use flutter_rust_bridge::frb;

#[frb(ui_state)]
pub struct RustState {
    pub count: i32,
}

impl RustState {
    #[frb(sync)]
    pub fn new() -> Self {
        Self {
            count: 0,
            base_state: Default::default(),
        }
    }

    #[frb(ui_mutation)]
    pub fn increment(&mut self) {
        self.count += 1;
    }
}
