#![allow(non_snake_case)]

use cstr::cstr;
use derivative::Derivative;
use qmetaobject::*;
use std::ffi::CStr;

macro_rules! register {
    ($($typ:ident),*) => {
        $({
            const X: &'static CStr = unsafe {
                union BytesToCStr<'a> {
                    bytes: &'a [u8],
                    cstr: &'a CStr,
                }

                BytesToCStr { bytes: concat!(stringify!($typ), "\0").as_bytes() }.cstr
            };
            qml_register_type::<$typ>(cstr!("Rust"), 1, 0, X);
        })*
    };
}

#[derive(QObject, Default)]
struct MenuActions {
    base: qt_base_class!(trait QObject),
    aboutDialog: qt_signal!(message: QString),
    about: qt_method!(fn(&mut self)),
}

impl MenuActions {
    fn about(&mut self) {
        self.aboutDialog("This is a test application using Qt with Rust!".into());
    }
}

#[derive(QObject, Derivative)]
#[derivative(Default)]
struct Greeter {
    base: qt_base_class!(trait QObject),
    #[derivative(Default(value = "\"Say hi!\".into()"))]
    text: qt_property!(QString; NOTIFY textChanged),
    textChanged: qt_signal!(),
    hello: qt_method!(fn(&mut self)),
}

impl Greeter {
    fn hello(&mut self) {
        self.text = "Thanks!".into();
        self.textChanged();
    }
}

fn main() {
    register!(MenuActions, Greeter);
    let mut engine = QmlEngine::new();
    engine.load_data(include_str!("main.qml").into());
    engine.exec();
}
