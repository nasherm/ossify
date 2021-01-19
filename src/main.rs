// We don't want to link the standard lib
// but rather build a free-standing OS
#![no_std]
#![no_main]

use core::panic::PanicInfo;

// When we don't link with the standard
// library we need to define a panic
// handler.
#[panic_handler]
fn panic(_info : &PanicInfo) -> !{
    loop {}
}

pub extern "C" fn _start() -> !{
    loop {}
}
