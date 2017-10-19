defmodule ExAudit.Schema do
  def insert_all(module, adapter, schema_or_source, entries, opts) do
    # TODO!
    Ecto.Repo.Schema.insert_all(module, adapter, schema_or_source, entries, opts)
  end

  def insert(module, adapter, struct, opts) do
    result = Ecto.Repo.Schema.insert(module, adapter, struct, opts)

    case result do
      {:ok, resulting_struct} ->
        ExAudit.Tracking.track_change(module, adapter, :created, struct, resulting_struct, opts)
      _ -> 
        :ok
    end

    result
  end

  def update(module, adapter, struct, opts) do
    result = Ecto.Repo.Schema.update(module, adapter, struct, opts)

    case result do
      {:ok, resulting_struct} ->
        ExAudit.Tracking.track_change(module, adapter, :updated, struct, resulting_struct, opts)
      _ -> 
        :ok
    end

    result
  end

  def insert_or_update(module, adapter, changeset, opts) do
    # TODO!
    Ecto.Repo.Schema.insert_or_update(module, adapter, changeset, opts)
  end

  def delete(module, adapter, struct, opts) do
    result = Ecto.Repo.Schema.delete(module, adapter, struct, opts)

    case result do
      {:ok, resulting_struct} ->
        ExAudit.Tracking.track_change(module, adapter, :deleted, struct, resulting_struct, opts)
      _ -> 
        :ok
    end

    result
  end

  def insert!(module, adapter, struct, opts) do
    result = Ecto.Repo.Schema.insert!(module, adapter, struct, opts)
    ExAudit.Tracking.track_change(module, adapter, :created, struct, result, opts)
    result
  end

  def update!(module, adapter, struct, opts) do
    result = Ecto.Repo.Schema.update!(module, adapter, struct, opts)
    ExAudit.Tracking.track_change(module, adapter, :updated, struct, result, opts)
    result
  end

  def insert_or_update!(module, adapter, changeset, opts) do
    # TODO
    Ecto.Repo.Schema.insert_or_update!(module, adapter, changeset, opts)
  end

  def delete!(module, adapter, struct, opts) do
    result = Ecto.Repo.Schema.delete!(module, adapter, struct, opts)
    ExAudit.Tracking.track_change(module, adapter, :deleted, struct, result, opts)
    result
  end
end