From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [RFC] perf report/top with callchain fixes improvements
Date: Tue, 17 Dec 2019 11:48:16 -0300
Message-ID: <20191217144828.2460-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Kan Liang <kan.liang@intel.com>
List-Id: linux-perf-users.vger.kernel.org

Hi,

	These patches try to address inconsistencies in the navigation
in the 'perf report' and 'perf top' when callchains are present.

 	Linus reported that when pressing ENTER with callchains enabled
it no longer shows the popup menu, instead it toggles the callchains,
which is surprising and rather annoying.

	So this patchset makes it consistent by presenting the popup
menu when ENTER is pressed and callchains are present, and then an
extra menu entry, associated with the new '+' toggle is added and
appears proeminently in the popup menu, together with suggestions about
using 'e' to toogle all the callchains for the top level entry,

	Other changes in this patchkit allows for using those suggested
hotkeys directly from the popup menu and add a new 'k' hotkey to zoom
straight into the main kernel map. Pressing it again works just like
using the popup menu via ENTER + "Zoom out of the kernel" or using ESC
to Zoom out from the last filtering operation.

	While working on this I noticed some other oddities like in
the default --children mode where the Annotation popup option appeared
even for entries where no samples were taken, i.e. something that
appeared just on some callchain, suppressing the Annotation popup entry
for those cases. If the user insists in using the 'a' hotkey on such an
entry, a popup warning is showed.

	Also a fix for kernel maps for ranges that seldom appear in
samples, like "[kernel.vmlinux].init.text", that didn't a pointer back
to the kernel maps data structure and thus was causing an assertion
falure were found and fix, please test, available at:

	Available at:

git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/hists_browser

Best regards,

- Arnaldo

Arnaldo Carvalho de Melo (12):
  perf hists browser: Restore ESC as "Zoom out" of DSO/thread/etc
  perf report/top: Make ENTER consistently bring up menu
  perf report/top: Add menu entry for toggling callchain expansion
  perf report/top: Improve toggle callchain menu option
  perf hists browser: Generalize the do_zoom_dso() function
  perf report/top: Add 'k' hotkey to zoom directly into the kernel map
  perf hists browser: Allow passing an initial hotkey
  tools ui popup: Allow returning hotkeys
  perf report/top: Allow pressing hotkeys in the options popup menu
  perf report/top: Do not offer annotation for symbols without samples
  perf report/top: Make 'e' visible in the help and make it toggle showing callchains
  perf maps: Set maps pointer in the kmap area for kernel maps

 tools/perf/builtin-c2c.c            |   4 +-
 tools/perf/tests/maps.c             |   8 +-
 tools/perf/ui/browsers/hists.c      | 141 ++++++++++++++++++++++++----
 tools/perf/ui/browsers/hists.h      |   2 +-
 tools/perf/ui/browsers/res_sample.c |   2 +-
 tools/perf/ui/browsers/scripts.c    |   2 +-
 tools/perf/ui/tui/util.c            |  12 ++-
 tools/perf/ui/util.h                |   2 +-
 tools/perf/util/auxtrace.c          |   2 +-
 tools/perf/util/dso.c               |   4 +-
 tools/perf/util/dso.h               |   4 +-
 tools/perf/util/machine.c           |  10 +-
 tools/perf/util/map.c               |  15 ++-
 tools/perf/util/map.h               |   2 +-
 tools/perf/util/probe-event.c       |  10 +-
 tools/perf/util/sort.c              |   3 +-
 tools/perf/util/sort.h              |   2 +
 tools/perf/util/symbol-elf.c        |   2 +-
 tools/perf/util/symbol.c            |   6 +-
 19 files changed, 178 insertions(+), 55 deletions(-)

-- 
2.21.0
