defmodule MishkaPubTest.ActivityStream.Activity do
  use ExUnit.Case
  alias MishkaPub.ActivityStream.Type.Activity

  test "greets the world" do
    %{
      type: "Create",
      actor: [
        %{id: "https://google.com", type: "Person", summary: "To Dev"},
        [%{id: "https://google.com", type: "Person", summary: "To Dev"}],
        "https://google.com"
      ],
      instrument: 1,
      object: "https://google.com"
    }
    |> Activity.builder()
    |> IO.inspect()
  end
end
