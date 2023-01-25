defmodule App.Record do
  defmacro __using__(opts) do
    quote do
      alias unquote(opts[:repo])

      import Ecto.Query

      def run(query) do
        query
        |> Repo.all()
      end

      def new(attr) do
        %unquote(opts[:schema]){}
        |> struct(attr)
      end

      def preload(query, tables) do
        query
        |> Repo.preload(tables)
      end

      def all do
        unquote(opts[:schema])
        |> Repo.all()
      end

      def first do
        from(
          t in unquote(opts[:schema]),
          limit: 1
        )
        |> Repo.one()
      end

      def last do
        from(
          t in unquote(opts[:schema]),
          limit: 1,
          order_by: [desc: t.id]
        )
        |> Repo.one()
      end

      def find(id) do
        unquote(opts[:schema])
        |> Repo.get!(id)
      end

      def find_by(conds) do
        unquote(opts[:schema])
        |> Repo.get_by(conds)
      end

      def where(conds) when is_list(conds) do
        from(unquote(opts[:schema]), where: ^conds)
        |> Repo.all()
      end

      def where(query) do
        query
        |> Repo.all()
      end

      def insert(attr) do
        %unquote(opts[:schema]){}
        |> unquote(opts[:schema]).changeset(attr)
        |> Repo.insert()
      end

      def insert!(attr) do
        %unquote(opts[:schema]){}
        |> unquote(opts[:schema]).changeset(attr)
        |> Repo.insert!()
      end

      def insert_all(maps, opts \\ []) do
        now = DateTime.utc_now() |> NaiveDateTime.truncate(:second)

        changesets =
          maps
          |> Enum.map(fn map -> Map.merge(%{inserted_at: now, updated_at: now}, map) end)

        Repo.insert_all(unquote(opts[:schema]), changesets, opts)
      end

      def create(attr), do: insert(attr)

      def create!(attr), do: insert!(attr)

      def create_all(maps, opts \\ []), do: insert_all(maps, opts)

      def update(entity, attr) do
        entity
        |> unquote(opts[:schema]).changeset(attr)
        |> Repo.update()
      end

      def update!(entity, attr) do
        entity
        |> unquote(opts[:schema]).changeset(attr)
        |> Repo.update!()
      end

      def delete(entity), do: Repo.delete(entity)
      def delete!(entity), do: Repo.delete!(entity)

      def delete_all(), do: Repo.delete_all(unquote(opts[:schema]))

      def changeset(attr) do
        unquote(opts[:schema]).changeset(%unquote(opts[:schema]){}, attr)
      end

      def changeset(entity, attr) do
        entity
        |> unquote(opts[:schema]).changeset(attr)
      end
    end
  end
end
