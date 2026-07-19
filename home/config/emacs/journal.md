# Journal & Daily Notes

How note-taking/journaling works day to day, and which keys drive it.
Implementation lives in `emacs.org` under `** Daily Notes` (and the
`;; Journal` leader-key block).

## The mental model

- **Today's note** (`~/org/Daily/YYYY-MM-DD.org`) is where day-to-day stuff
  goes: a todo list, a snapshot of that day's calendar events, and your
  journal entry for the day. One file per day, auto-created on first visit.
  Because it lives under `~/org/Daily`, it's indexed by org-node like any
  other note — findable with `org-node-find`, linkable from other notes.
- **`~/org/journal.org`** is the old journal — a single file, organized by
  year/month/day. It's no longer written to day-to-day, but it's still there
  as an archive of everything journaled before daily notes existed.

## Keybindings

| Key | Action |
|---|---|
| `SPC j j` | Open today's note, creating it first if it doesn't exist yet. Cursor lands under `* Journal`, ready to type. |
| `SPC j o` | Open the old journal archive (`~/org/journal.org`). |
| `SPC f n` or `SPC o f` | `org-node-find` — jump to any note by title, including past daily notes. |
| `SPC o i` | `org-node-insert` — insert a link to a note (works for daily notes too) at point. |
| `SPC o a` | Open the agenda. |
| `SPC o c` | `org-capture` (general-purpose capture menu, unrelated to daily notes). |

## What happens the first time you open today's note

Pressing `SPC j j` on a day with no note yet creates
`~/org/Daily/YYYY-MM-DD.org` with this skeleton:

```org
#+TITLE: 2026-07-19
#+FILETAGS: :daily:

* Todo

* Calendar
- <today's gcal-synced events, or "(No calendar items today)">

* Journal
```

The Calendar section is a **one-time snapshot** taken at creation — it pulls
whatever's on your synced calendars (`~/org/Calendar/*.org`) for that day at
the moment the file is created, and does not update itself afterward. If an
event gets added or moved later in the day, re-run `org-gcal-fetch` and edit
the Calendar section by hand if you want it reflected.

Opening the note again later the same day (`SPC j j`) just visits the
existing file — nothing gets re-inserted or duplicated.

## Notes / limitations

- Todos written under a daily note's `* Todo` heading are **not** picked up
  by the global agenda (`SPC o a`) — they're scoped to that day only, kept
  separate from the "real" task list in `~/org/todo.org`. If you want a task
  tracked long-term, put it in `todo.org` instead (`SPC j` doesn't cover
  this — use `SPC o c` → capture, or edit `todo.org` directly).
- Daily notes are plain org files under `~/org/Daily/` — delete, rename, or
  edit them freely, same as any other note.
