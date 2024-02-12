defmodule ActivityPub.Identity.Create do
  # provider_uid ---> string
  # token ---> string
  # identity_provider ---> integer
  # user_id

  # Indexes
  # index(:identities, [:provider_uid, :identity_provider]
  # index(:identities, [:user_id, :identity_provider]
end
