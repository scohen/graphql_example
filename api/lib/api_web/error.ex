defmodule ApiWeb.Error do
  @derive {Jason.Encoder, only: [:message, :code, :field]}
  defstruct [:http_status_code, :code, :field, :message]

  @type t :: %__MODULE__{
          http_status_code: pos_integer,
          message: String.t(),
          code: atom,
          field: String.t()
        }

  @spec new(pos_integer, atom, atom | nil, String.t() | nil) :: t
  def new(http_status_code, code, field \\ nil, message \\ nil) do
    %__MODULE__{
      http_status_code: http_status_code,
      code: code,
      field: field,
      message: message
    }
  end
end
