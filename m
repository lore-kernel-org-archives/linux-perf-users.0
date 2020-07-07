From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL] Second batch of perf tooling fixes for v5.8
Date: Tue,  7 Jul 2020 17:24:50 -0300
Message-ID: <20200707202450.23345-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Andreas Gerstmayr <agerstmayr@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <zanussi@kernel.org>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>, Wei Li <liwei391@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit cdd3bb54332f82295ed90cd0c09c78cd0c0ee822:

  Merge tag 'm68knommu-for-v5.8-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu (2020-07-02 22:56:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-2020-07-07

for you to fetch changes up to bee9ca1c8a237ca178f281062bf162637071ab04:

  perf report TUI: Remove needless 'dummy' event from menu (2020-07-06 09:24:02 -0300)

----------------------------------------------------------------
Second batch of perf tooling fixes for v5.8:

- Intel PT fixes for PEBS-via-PT with registers.

- Fixes for Intel PT python based GUI.

- Avoid duplicated sideband events with Intel PT in system wide tracing.

- Remove needless 'dummy' event from TUI menu, used when synthesizing
  meta data events for pre-existing processes.

- Fix corner case segfault when pressing enter in a screen without
  entries in the TUI for report/top.

- Fixes for time stamp handling in libtraceevent.

- Explicitly set utf-8 encoding in perf flamegraph.

- Update arch/x86/lib/memcpy_64.S copy used in 'perf bench mem memcpy',
  silencing perf build warning.

Adrian Hunter (9):
      perf scripts python: export-to-postgresql.py: Fix struct.pack() int argument
      perf record: Fix duplicated sideband events with Intel PT system wide tracing
      perf scripts python: exported-sql-viewer.py: Fix unexpanded 'Find' result
      perf scripts python: exported-sql-viewer.py: Fix zero id in call graph 'Find' result
      perf scripts python: exported-sql-viewer.py: Fix zero id in call tree 'Find' result
      perf scripts python: exported-sql-viewer.py: Fix time chart call tree
      perf intel-pt: Fix recording PEBS-via-PT with registers
      perf intel-pt: Fix displaying PEBS-via-PT with registers
      perf intel-pt: Fix PEBS sample for XMM registers

Andreas Gerstmayr (1):
      perf flamegraph: Explicitly set utf-8 encoding

Arnaldo Carvalho de Melo (3):
      Merge remote-tracking branch 'torvalds/master' into perf/urgent
      tools arch: Update arch/x86/lib/memcpy_64.S copy used in 'perf bench mem memcpy'
      perf report TUI: Remove needless 'dummy' event from menu

Steven Rostedt (Red Hat) (1):
      tools lib traceevent: Add API to read time information from kbuffer

Tom Zanussi (1):
      tools lib traceevent: Add proper KBUFFER_TYPE_TIME_STAMP handling

Wei Li (1):
      perf report TUI: Fix segmentation fault in perf_evsel__hists_browse()

 tools/arch/x86/lib/memcpy_64.S                    |  4 +++
 tools/lib/traceevent/kbuffer-parse.c              | 43 +++++++++++++++++++----
 tools/lib/traceevent/kbuffer.h                    |  2 ++
 tools/perf/arch/x86/util/intel-pt.c               |  1 +
 tools/perf/builtin-record.c                       | 18 +++++-----
 tools/perf/builtin-script.c                       |  2 +-
 tools/perf/scripts/python/export-to-postgresql.py |  2 +-
 tools/perf/scripts/python/exported-sql-viewer.py  | 11 ++++--
 tools/perf/scripts/python/flamegraph.py           |  8 +++--
 tools/perf/ui/browsers/hists.c                    | 36 +++++++++++++++----
 tools/perf/util/evlist.c                          | 12 +++++++
 tools/perf/util/evlist.h                          |  1 +
 tools/perf/util/evsel.c                           | 12 ++-----
 tools/perf/util/evsel.h                           |  6 ++++
 tools/perf/util/intel-pt.c                        |  5 +--
 15 files changed, 123 insertions(+), 40 deletions(-)
