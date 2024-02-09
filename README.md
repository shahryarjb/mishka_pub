# MishkaPub

```
# name, preferredUsername, inbox, outbox, followers, following, liked --> enforce
# All list of top types field should be OrderedCollection

# --------------------------------------------------------------------
# Sending email
# User's feed is its inbox with Get
# User's profile is its outbox for other poaple with Get
# Send message to someone or public is user'outbox with POST
# Then server sends the user's outbox request to the poaple inbox
# If user want to see another users profile should GET their outbox

# --------------------------------------------------------------------
# A client to server protocol, or "Social API"
# A server to server protocol, or "Federation Protocol"
# application/ld+json;
# application/ld+json; profile="https://www.w3.org/ns/activitystreams"
#
# Location: https://dustycloud.org/likes/345 --->
#           user should put the full url in location header when a activity is transient
# bto / bcc ---> should be deleted from activity but should be delivered
# to, bto, cc, bcc, audience ----> server should manage
# Add, Remove --> activity should have target
# If a activity is created SHOULD be copied onto the object's attributedTo (for Create)
# ----------------------------------------------------------------------
# When a user send a request to his outbox for creating an object can be like:
# {
#   "@context": "https://www.w3.org/ns/activitystreams",
#   "type": "Note",
#   "content": "This is a note",
#   "published": "2015-02-10T15:04:55Z",
#   "to": ["https://example.org/~john/"],
#   "cc": ["https://example.com/~erik/followers",
#          "https://www.w3.org/ns/activitystreams#Public"]
# }
# This top object is about the object of creating a not, but who sends to his outbox
# for example mallory, so we should add activity properties automaticly and delete all sent ids like this:
# {
#   "@context": "https://www.w3.org/ns/activitystreams",
#   "type": "Create",
#   "id": "https://example.net/~mallory/87374",
#   "actor": "https://example.net/~mallory",
#   "object": {
#     "id": "https://example.com/~mallory/note/72",
#     "type": "Note",
#     "attributedTo": "https://example.net/~mallory",
#     "content": "This is a note",
#     "published": "2015-02-10T15:04:55Z",
#     "to": ["https://example.org/~john/"],
#     "cc": ["https://example.com/~erik/followers",
#            "https://www.w3.org/ns/activitystreams#Public"]
#   },
#   "published": "2015-02-10T15:04:55Z",
#   "to": ["https://example.org/~john/"],
#   "cc": ["https://example.com/~erik/followers",
#          "https://www.w3.org/ns/activitystreams#Public"]
# }
# ----------------------------------------------------------------------
# Updating, for deleteing one field user should send `json null` this exeption for activitypub --> client to server
# ----------------------------------------------------------------------
# Deleting, If an object deleted and a user request it, server should response HTTP 410, if there is not object at first server
# should return 404
# {
#   "@context": "https://www.w3.org/ns/activitystreams",
#   "id": "https://example.com/~alice/note/72",
#   "type": "Tombstone",
#   "published": "2015-02-10T15:04:55Z",
#   "updated": "2015-02-10T15:04:55Z",
#   "deleted": "2015-02-10T15:04:55Z"
# }
# If user send a request to delete an activity should consider this is for the server has permition ot not
# Side effect, the server for any reson maybe not give the accses for deleting
# ----------------------------------------------------------------------
# Extera activityes
# Accept and Reject,
# Arrive and Leave,
# Join and Leave,
# Create and Delete,
# Like and Dislike
# ----------------------------------------------------------------------
# For undoing: Create --> Delete, Add ---> Remove
# Some recurse object and edit should have a limition
# ----------------------------------------------------------------------
# For uploading media
# https://www.w3.org/wiki/SocialCG/ActivityPub/MediaUpload
# Content-Disposition: form-data; name="file"; filename="wireworld.webm"
# Content-Type: video/webm
# 202 Accepted
# ---
# Server should prevent oversized Collections from client, must have a limition and rate limit
```
