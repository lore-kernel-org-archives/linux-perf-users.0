From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/14] perf/urgent fixes
Date: Thu, 12 Jul 2018 15:54:15 +0200
Message-ID: <20180712135415.GA6199@gmail.com>
References: <20180711204305.12924-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180711204305.12924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Herton Krzesinski <herton@redhat.com>, Janne Huttunen <janne.huttunen@nokia.com>, Jaroslav Skarvada <jskarvad@redhat.com>, Jeremy Cline <jcline@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Kim Phillips <kim.phillips@arm.com>, Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Sandipan Das <sandipan@linux.vnet.ibm.com>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 092150a25cb7bd6a79aa00bb1ad131063f58073d:
> 
>   Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid (2018-07-09 17:16:11 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.18-20180711
> 
> for you to fetch changes up to 32aa928a7b817140c84987b726d5014911808fa4:
> 
>   perf tools: Use python-config --includes rather than --cflags (2018-07-11 09:48:31 -0400)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> python interface:
> 
> - Make 'perf script -g python' generate scripts that are compatible
>   with both python 2 and 3 (Jeremy Cline)
> 
> - Fix python dictionary reference counting (Janne Huttunen)
> 
> - Add python3 support for various python scripts (Jeremy Cline)
> 
> - Use python-config --includes rather than --cflags, fixing the build
>   on Fedora, where the python 3.7 started adding -flto to what
> 
> perf stat:
> 
>   - Remove needless extra header line in --interval_clear (Jiri Olsa)
>   python-config --cflags generate, breaking the perf build (Jeremy Cline)
> 
> Build:
> 
> - Fix compilation errors on gcc8 (Jiri Olsa)
> 
> perf llvm-utils:
> 
> - Remove bashism from kernel include fetch script (Kim Phillips)
> 
> perf test: (Kim Phillips)
> 
> - Replace '|&' with '2>&1 |' to work with more shells
> 
> - Make perf's inet_pton test more portable
> 
> - Prevent temporary editor files from being considered test scripts
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Janne Huttunen (1):
>       perf script python: Fix dict reference counting
> 
> Jeremy Cline (7):
>       perf tools: Generate a Python script compatible with Python 2 and 3
>       perf scripts python: Add Python 3 support to Core.py
>       perf scripts python: Add Python 3 support to SchedGui.py
>       perf scripts python: Add Python 3 support to Util.py
>       perf scripts python: Add Python 3 support to sched-migration.py
>       perf scripts python: Add Python 3 support to EventClass.py
>       perf tools: Use python-config --includes rather than --cflags
> 
> Jiri Olsa (2):
>       perf tools: Fix compilation errors on gcc8
>       perf stat: Fix --interval_clear option
> 
> Kim Phillips (4):
>       perf test shell: Replace '|&' with '2>&1 |' to work with more shells
>       perf test shell: Make perf's inet_pton test more portable
>       perf llvm-utils: Remove bashism from kernel include fetch script
>       perf test shell: Prevent temporary editor files from being considered test scripts
> 
>  tools/perf/Makefile.config                         |  3 +-
>  tools/perf/arch/x86/util/perf_regs.c               |  2 +-
>  tools/perf/builtin-stat.c                          |  2 +-
>  tools/perf/jvmti/jvmti_agent.c                     |  3 +-
>  .../python/Perf-Trace-Util/lib/Perf/Trace/Core.py  | 40 +++++++++-------------
>  .../Perf-Trace-Util/lib/Perf/Trace/EventClass.py   |  4 ++-
>  .../Perf-Trace-Util/lib/Perf/Trace/SchedGui.py     |  2 +-
>  .../python/Perf-Trace-Util/lib/Perf/Trace/Util.py  | 11 +++---
>  tools/perf/scripts/python/sched-migration.py       | 14 +++++---
>  tools/perf/tests/builtin-test.c                    |  2 +-
>  .../tests/shell/record+probe_libc_inet_pton.sh     | 37 +++++++++++---------
>  tools/perf/tests/shell/trace+probe_vfs_getname.sh  |  2 +-
>  tools/perf/util/llvm-utils.c                       |  6 ++--
>  .../util/scripting-engines/trace-event-python.c    | 37 +++++++++-----------
>  14 files changed, 84 insertions(+), 81 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
