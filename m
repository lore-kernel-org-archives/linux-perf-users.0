From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL] perf tools fixes for v5.9: 2nd batch
Date: Thu,  3 Sep 2020 23:07:28 -0300
Message-ID: <20200904020728.3734002-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Kim Phillips <kim.phillips@amd.com>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>, YueHaibing <yuehaibing@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

Comprehensive test results are available in the signed tag.

The following changes since commit e28f0104343d0c132fa37f479870c9e43355fee4:

  Merge tag 'fixes-2020-09-03' of git://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock (2020-09-03 10:05:48 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.9-2020-09-03

for you to fetch changes up to 830fadfd954c6782b7a8a2461c76a568c7153b9a:

  perf tools: Add bpf image check to __map__is_kmodule (2020-09-03 16:04:46 -0300)

----------------------------------------------------------------
perf tools fixes for v5.9: 2nd batch

- Use uintptr_t when casting numbers to pointers

- Keep output expected by 3rd parties: Turn off summary for interval
  mode by default.

- BPF is in kernel space, make sure do_validate_kcore_modules() knows
  about that.

- Explicitly call out event modifiers in the documentation.

- Fix jevents() allocation of space for regular expressions.

- Address libtraceevent build warnings on 32-bit arches.

- Fix checking of functions returns using ERR_PTR() in 'perf bench'.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (1):
      perf parse-events: Use uintptr_t when casting numbers to pointers

Jin Yao (1):
      perf stat: Turn off summary for interval mode by default

Jiri Olsa (1):
      perf tools: Add bpf image check to __map__is_kmodule

Kim Phillips (1):
      perf record/stat: Explicitly call out event modifiers in the documentation

Namhyung Kim (1):
      perf jevents: Fix suspicious code in fixregex()

Tzvetomir Stoyanov (VMware) (1):
      libtraceevent: Fix build warning on 32-bit arches

YueHaibing (1):
      perf bench: The do_run_multi_threaded() function must use IS_ERR(perf_session__new())

 tools/lib/traceevent/event-parse.c       |  2 +-
 tools/perf/Documentation/perf-record.txt |  4 ++++
 tools/perf/Documentation/perf-stat.txt   |  7 +++++++
 tools/perf/bench/synthesize.c            |  4 ++--
 tools/perf/builtin-stat.c                |  8 +++++---
 tools/perf/pmu-events/jevents.c          |  2 +-
 tools/perf/util/machine.c                |  6 ------
 tools/perf/util/map.c                    | 16 ++++++++++++++++
 tools/perf/util/map.h                    |  9 ++++++++-
 tools/perf/util/parse-events.y           |  8 ++++----
 tools/perf/util/stat.h                   |  1 +
 11 files changed, 49 insertions(+), 18 deletions(-)
