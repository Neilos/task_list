describe("creating tasks", function() {
  describe("add_task_to_view")
  it("should add a task to the view", function() {
    var result = add_task_to_view("an important task", 26/03/2013)
    expect(result).toBe("");
  });
});