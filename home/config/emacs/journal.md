# Journal & Daily Notes

How note-taking/journaling works day to day, and which keys drive it.
Implementation lives in `emacs.org` under `** Daily Notes` (and the
`;; Journal` leader-key block).

## The mental model

- **Today's note** (`~/org/Daily/YYYY-MM-DD.org`) is where day-to-day stuff
  goes: a todo list, a snapshot of that day's calendar events, and your
  journal entry for the day. One file per day, auto-created on first visit.
  Daily notes have no `:ID:` property, so unlike your other notes they are
  **not** indexed by org-node — they won't show up in `org-node-find` and
  can't be linked to with `org-node-insert-link`. That's left as-is on
  purpose: with one file per day, giving them IDs would mean an
  ever-growing pile of dated entries cluttering the note-finder alongside
  your permanent notes. Use `SPC j j` / `SPC j y` / `SPC j t` to open them
  directly instead.
- **`~/org/journal.org`** is the old journal — a single file, organized by
  year/month/day. It's no longer written to day-to-day, but it's still there
  as an archive of everything journaled before daily notes existed.

## Keybindings

| Key | Action |
|---|---|
| `SPC j j` | Open today's note, creating it first if it doesn't exist yet. Cursor lands under `* Journal`, ready to type. |
| `SPC j y` | Open yesterday's note, creating it first if it doesn't exist yet. |
| `SPC j t` | Open tomorrow's note, creating it first if it doesn't exist yet. |
| `SPC j o` | Open the old journal archive (`~/org/journal.org`). |
| `SPC f n` or `SPC o f` | `org-node-find` — jump to any note by title. Daily notes don't show up here (see above). |
| `SPC o i` | `org-node-insert-link` — insert a link to a note at point. Daily notes can't be targeted this way (see above). |
| `SPC o a` | Open the agenda. |
| `SPC o c` | `org-capture` (general-purpose capture menu, unrelated to daily notes). |

## What happens the first time you open a daily note

Pressing `SPC j j` (or `SPC j y` / `SPC j t` for yesterday/tomorrow) on a day
with no note yet creates `~/org/Daily/YYYY-MM-DD.org` with this skeleton:

```org
#+TITLE: 2026-07-19
#+FILETAGS: :daily:

* Todo

* Calendar
- <today's gcal-synced events, or "(No calendar items today)">

* Journal
```

The Calendar section is a **one-time snapshot** taken at creation — it pulls
whatever's on your synced calendars (`~/org/Calendar/*.org`) for *that day*
(today, yesterday, or tomorrow, depending which key you pressed) at the
moment the file is created, and does not update itself afterward. If an
event gets added or moved later, re-run `org-gcal-fetch` and edit the
Calendar section by hand if you want it reflected.

Opening an existing note again (`SPC j j` / `SPC j y` / `SPC j t`) just
visits the file — nothing gets re-inserted or duplicated.

## Notes / limitations

- Todos written under a daily note's `* Todo` heading are **not** picked up
  by the global agenda (`SPC o a`) — they're scoped to that day only, kept
  separate from the "real" task list in `~/org/todo.org`. If you want a task
  tracked long-term, put it in `todo.org` instead (`SPC j` doesn't cover
  this — use `SPC o c` → capture, or edit `todo.org` directly).
- Daily notes are plain org files under `~/org/Daily/` — delete, rename, or
  edit them freely, same as any other note.
