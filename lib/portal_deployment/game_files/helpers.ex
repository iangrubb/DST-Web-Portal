defmodule PortalDeployment.GameFiles.Helpers do
  def directories(path) do
    path
    |> File.ls!()
    |> Enum.flat_map(fn name ->
      [name]
      |> Enum.map(fn name -> path <> "/" <> name end)
      |> Enum.filter(&File.dir?/1)
      |> Enum.map(fn full_path -> {name, full_path} end)
    end)
  end

  def read_with_backup(path, backup) do
    path
    |> File.read()
    |> case do
      {:ok, contents} -> contents
      {:error, _reason} -> backup
    end
  end

  def convert_ini_file_to_hash(file) do
    file
    |> String.split("\n")
    |> Enum.map(fn line -> String.split(line, "=") end)
    |> Enum.reduce(%{}, fn
      [_line], acc ->
        acc

      [key | value], acc ->
        value = value |> Enum.join("=") |> String.trim()
        Map.put(acc, String.trim(key), value)
    end)
  end

  def update_ini_file_contents(contents, data) do
    contents
    |> String.split("\n")
    |> Enum.map(fn line -> String.split(line, "=") end)
    |> Enum.map(fn
      [line] ->
        line

      [key_str | value] ->
        key = key_str |> String.trim() |> String.to_atom()

        case Map.get(data, key) do
          nil -> Enum.join([key_str | value], "=")
          update -> "#{key_str}= #{update}"
        end
    end)
    |> Enum.join("\n")
  end
end
