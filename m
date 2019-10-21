From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Date: Tue, 22 Oct 2019 01:16:43 +0200
Message-ID: <20191021231643.GA119094@gmail.com>
References: <20191021133834.25998-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Brendan Gregg <brendan.d.gregg@gmail.com>, Daniel Bristot de Oliveira <bristot@redhat.com>, Ian Rogers <irogers@google.com>, Jin Yao <yao.jin@linux.intel.com>, John Garry <john.garry@huawei.com>, Leo Yan <leo.yan@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas Richter <tmricht@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo/Thomas,
> 
> 	Please consider pulling,
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 39b656ee9f2ce41eb969c86525f9a2a63fefac5b:
> 
>   Merge tag 'perf-core-for-mingo-5.5-20191011' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2019-10-15 07:19:55 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.5-20191021
> 
> for you to fetch changes up to 27198a893ba074407e7a87e346252b3e6fab454f:
> 
>   perf trace: Use STUL_STRARRAY_FLAGS with mmap (2019-10-19 15:35:02 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf trace:
> 
> - Add syscall failure stats to -s/--summary and -S/--with-summary, also works in
>   combination with specifying just a set of syscalls, see below first with
>   -s/--summary, then with -S/--with-summary just for the syscalls we saw failing
>   with -s:
> 
>     # perf trace -s sleep 1
> 
>      Summary of events:
> 
>      sleep (16218), 80 events, 93.0%
> 
>        syscall     calls  errors  total      min      avg      max   stddev
>                                   (msec)   (msec)   (msec)   (msec)    (%)
>        ----------- -----  ------ -------- -------- -------- -------- ------
>        nanosleep       1      0  1000.091 1000.091 1000.091 1000.091  0.00%
>        mmap            8      0     0.045    0.005    0.006    0.008  7.09%
>        mprotect        4      0     0.028    0.005    0.007    0.009 11.38%
>        openat          3      0     0.021    0.005    0.007    0.009 14.07%
>        munmap          1      0     0.017    0.017    0.017    0.017  0.00%
>        brk             4      0     0.010    0.001    0.002    0.004 23.15%
>        read            4      0     0.009    0.002    0.002    0.003  8.13%
>        close           5      0     0.008    0.001    0.002    0.002 10.83%
>        fstat           3      0     0.006    0.002    0.002    0.002  6.97%
>        access          1      1     0.006    0.006    0.006    0.006  0.00%
>        lseek           3      0     0.005    0.001    0.002    0.002  7.37%
>        arch_prctl      2      1     0.004    0.001    0.002    0.002 17.64%
>        execve          1      0     0.000    0.000    0.000    0.000  0.00%
> 
>     # perf trace -e access,arch_prctl -S sleep 1
>          0.000 ( 0.006 ms): sleep/19503 arch_prctl(option: 0x3001, arg2: 0x7fff165996b0) = -1 EINVAL (Invalid argument)
>          0.024 ( 0.006 ms): sleep/19503 access(filename: 0x2177e510, mode: R)            = -1 ENOENT (No such file or directory)
>          0.136 ( 0.002 ms): sleep/19503 arch_prctl(option: SET_FS, arg2: 0x7f9421737580) = 0
> 
>      Summary of events:
> 
>      sleep (19503), 6 events, 50.0%
> 
>        syscall    calls  errors total    min    avg    max  stddev
>                                 (msec) (msec) (msec) (msec)    (%)
>        ---------- -----  ------ ------ ------ ------ ------ ------
>        arch_prctl   2       1    0.008  0.002  0.004  0.006 57.22%
>        access       1       1    0.006  0.006  0.006  0.006  0.00%
> 
>     #
> 
>   - Introduce --errno-summary, to drill down a bit more in the errno stats:
> 
>     # perf trace --errno-summary -e access,arch_prctl -S sleep 1
>          0.000 ( 0.006 ms): sleep/5587 arch_prctl(option: 0x3001, arg2: 0x7ffd6ba6aa00) = -1 EINVAL (Invalid argument)
>          0.028 ( 0.007 ms): sleep/5587 access(filename: 0xb83d9510, mode: R)            = -1 ENOENT (No such file or directory)
>          0.172 ( 0.003 ms): sleep/5587 arch_prctl(option: SET_FS, arg2: 0x7f45b8392580) = 0
> 
>      Summary of events:
> 
>      sleep (5587), 6 events, 50.0%
> 
>        syscall    calls  errors total    min    avg    max  stddev
>                                 (msec) (msec) (msec) (msec)   (%)
>        ---------- -----  ------ ------ ------ ------ ------ ------
>        arch_prctl     2     1    0.009  0.003  0.005  0.006 38.90%
> 			   EINVAL: 1
>        access         1     1    0.007  0.007  0.007  0.007  0.00%
>                            ENOENT: 1
>     #
> 
>   - Filter own pid to avoid a feedback look in 'perf trace record -a'
> 
>   - Add the glue for the auto generated x86 IRQ vector array.
> 
>   - Show error message when not finding a field used in a filter expression
> 
>     # perf trace --max-events=4 -e syscalls:sys_enter_write --filter="cnt>32767"
>     Failed to set filter "(cnt>32767) && (common_pid != 19938 && common_pid != 8922)" on event syscalls:sys_enter_write with 22 (Invalid argument)
>     #
>     # perf trace --max-events=4 -e syscalls:sys_enter_write --filter="count>32767"
>          0.000 python3.5/17535 syscalls:sys_enter_write(fd: 3, buf: 0x564b0dc53600, count: 172086)
>         12.641 python3.5.post/17535 syscalls:sys_enter_write(fd: 3, buf: 0x564b0db63660, count: 75994)
>         27.738 python3.5.post/17535 syscalls:sys_enter_write(fd: 3, buf: 0x564b0db4b1e0, count: 41635)
>        136.070 python3.5.post/17535 syscalls:sys_enter_write(fd: 3, buf: 0x564b0dbab510, count: 62232)
>     #
> 
>   - Add a generator for x86's IRQ vectors -> strings
> 
>   - Introduce stroul() (string -> number) methods for the strarray and
>     strarrays classes, also strtoul_flags, allowing to go from both strings
>     and or-ed strings to numbers, allowing things like:
> 
>     # perf trace -e syscalls:sys_enter_mmap --filter="flags==DENYWRITE|PRIVATE|FIXED" sleep 1
>          0.000 sleep/22588 syscalls:sys_enter_mmap(addr: 0x7f42d2aa5000, len: 1363968, prot: READ|EXEC, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x22000)
>          0.011 sleep/22588 syscalls:sys_enter_mmap(addr: 0x7f42d2bf2000, len: 311296, prot: READ, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x16f000)
>          0.015 sleep/22588 syscalls:sys_enter_mmap(addr: 0x7f42d2c3f000, len: 24576, prot: READ|WRITE, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x1bb000)
>     #
> 
>   Allowing to narrow down from the complete set of mmap calls for that workload:
> 
>     # perf trace -e syscalls:sys_enter_mmap sleep 1
>          0.000 sleep/22695 syscalls:sys_enter_mmap(len: 134773, prot: READ, flags: PRIVATE, fd: 3)
>          0.041 sleep/22695 syscalls:sys_enter_mmap(len: 8192, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS)
>          0.053 sleep/22695 syscalls:sys_enter_mmap(len: 1857472, prot: READ, flags: PRIVATE|DENYWRITE, fd: 3)
>          0.069 sleep/22695 syscalls:sys_enter_mmap(addr: 0x7fd23ffb6000, len: 1363968, prot: READ|EXEC, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x22000)
>          0.077 sleep/22695 syscalls:sys_enter_mmap(addr: 0x7fd240103000, len: 311296, prot: READ, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x16f000)
>          0.083 sleep/22695 syscalls:sys_enter_mmap(addr: 0x7fd240150000, len: 24576, prot: READ|WRITE, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x1bb000)
>          0.095 sleep/22695 syscalls:sys_enter_mmap(addr: 0x7fd240156000, len: 14272, prot: READ|WRITE, flags: PRIVATE|FIXED|ANONYMOUS)
>          0.339 sleep/22695 syscalls:sys_enter_mmap(len: 217750512, prot: READ, flags: PRIVATE, fd: 3)
>     #
> 
>   Works with all targets, so, for system wide, looking at who calls mmap with flags set to just "PRIVATE":
> 
>     # perf trace --max-events=5 -e syscalls:sys_enter_mmap --filter="flags==PRIVATE"
>          0.000 pool/2242 syscalls:sys_enter_mmap(len: 756, prot: READ, flags: PRIVATE, fd: 14)
>          0.050 pool/2242 syscalls:sys_enter_mmap(len: 756, prot: READ, flags: PRIVATE, fd: 14)
>          0.062 pool/2242 syscalls:sys_enter_mmap(len: 756, prot: READ, flags: PRIVATE, fd: 14)
>          0.145 goa-identity-s/2240 syscalls:sys_enter_mmap(len: 756, prot: READ, flags: PRIVATE, fd: 18)
>          0.183 goa-identity-s/2240 syscalls:sys_enter_mmap(len: 756, prot: READ, flags: PRIVATE, fd: 18)
>     #
> 
>   # perf trace --max-events=2 -e syscalls:sys_enter_lseek --filter="whence==SET && offset != 0"
>          0.000 Cache2 I/O/12047 syscalls:sys_enter_lseek(fd: 277, offset: 43, whence: SET)
>       1142.070 mozStorage #5/12302 syscalls:sys_enter_lseek(fd: 44</home/acme/.mozilla/firefox/ina67tev.default/cookies.sqlite-wal>, offset: 393536, whence: SET)
>   #
> 
> perf annotate:
> 
>   - Fix objdump --no-show-raw-insn flag to work with goth gcc and clang.
> 
>   - Streamline objdump execution, preserving the right error codes for better
>     reporting to user.
> 
> perf report:
> 
>   - Add warning when libunwind not compiled in.
> 
> perf stat:
> 
>   Jin Yao:
> 
>   - Support --all-kernel/--all-user, to match options available in 'perf record',
>     asking that all the events specified work just with kernel or user events.
> 
> perf list:
> 
>   Jin Yao:
> 
>   - Hide deprecated events by default, allow showing them with --deprecated.
> 
> libbperf:
> 
>   Jiri Olsa:
> 
>   - Allow to build with -ltcmalloc.
> 
>   - Finish mmap interface, getting more stuff from tools/perf while adding
>     abstractions to avoid pulling too much stuff, to get libperf to grow as
>     tools needs things like auxtrace, etc.
> 
> perf scripting engines:
> 
>   Steven Rostedt (VMware):
> 
>   - Iterate on tep event arrays directly, fixing script generation with
>     '-g python' when having multiple tracepoints in a perf.data file.
> 
> core:
> 
>   - Allow to build with -ltcmalloc.
> 
> perf test:
> 
>   Leo Yan:
> 
>   - Report failure for mmap events.
> 
>   - Avoid infinite loop for task exit case.
> 
>   - Remove needless headers for bp_account test.
> 
>   - Add dedicated checking helper is_supported().
> 
>   - Disable bp_signal testing for arm64.
> 
> Vendor events:
> 
> arm64:
> 
>   John Garry:
> 
>   - Fix Hisi hip08 DDRC PMU eventname.
> 
>   - Add some missing events for Hisi hip08 DDRC, L3C and HHA PMUs.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Andi Kleen (2):
>       perf script: Fix --reltime with --time
>       perf evlist: Fix fix for freed id arrays
> 
> Arnaldo Carvalho de Melo (25):
>       perf trace: Add syscall failure stats to -s/--summary and -S/--with-summary
>       perf trace: Introduce --errno-summary
>       perf string: Export asprintf__tp_filter_pids()
>       perf trace: Filter own pid to avoid a feedback look in 'perf trace record -a'
>       perf trace: Support tracepoint dynamic char arrays
>       tools arch x86: Grab a copy of the file containing the IRQ vector defines
>       libbeauty: Add a generator for x86's IRQ vectors -> strings
>       libbeauty: Hook up the x86 irq_vectors table generator
>       libbeauty: Add a strarray__scnprintf_suffix() method
>       perf trace beauty: Add the glue for the autogenerated x86 IRQ vector array
>       perf trace: Hook the 'vec' tracepoint argument with the x86 IRQ vectors scnprintf/strtoul
>       perf trace: Show error message when not finding a field used in a filter expression
>       perf trace: Introduce accessors to trace specific evsel->priv
>       perf trace: Hide evsel->access further, simplify code
>       perf trace: Introduce 'struct evsel__trace' for evsel->priv needs
>       perf trace: Initialize evsel_trace->fmt for syscalls:sys_enter_* tracepoints
>       libbeauty: Introduce syscall_arg__strtoul_strarray()
>       perf trace: Honour --max-events in processing syscalls:sys_enter_*
>       perf trace: Pass a syscall_arg to syscall_arg_fmt->strtoul()
>       libbeauty: Introduce syscall_arg__strtoul_strarrays()
>       perf trace: Use strtoul for the fcntl 'cmd' argument
>       libbeauty: Make the mmap_flags strarray visible outside of its beautifier
>       libbeauty: Introduce strarray__strtoul_flags()
>       perf trace: Wire up strarray__strtoul_flags()
>       perf trace: Use STUL_STRARRAY_FLAGS with mmap
> 
> Ian Rogers (5):
>       perf annotate: Avoid reallocation in objdump parsing
>       perf annotate: Use libsubcmd's run-command.h to fork objdump
>       perf annotate: Don't pipe objdump output through 'grep' command
>       perf annotate: Don't pipe objdump output through 'expand' command
>       perf annotate: Fix objdump --no-show-raw-insn flag
> 
> Jin Yao (3):
>       perf report: Add warning when libunwind not compiled in
>       perf stat: Support --all-kernel/--all-user
>       perf list: Hide deprecated events by default
> 
> Jiri Olsa (10):
>       perf tools: Allow to build with -ltcmalloc
>       libperf: Introduce perf_evlist__for_each_mmap()
>       libperf: Move mmap allocation to perf_evlist__mmap_ops::get
>       libperf: Move mask setup to perf_evlist__mmap_ops()
>       libperf: Link static tests with libapi.a
>       libperf: Add tests_mmap_thread test
>       libperf: Add tests_mmap_cpus test
>       libperf: Keep count of failed tests
>       libperf: Do not export perf_evsel__init()/perf_evlist__init()
>       libperf: Add pr_err() macro
> 
> John Garry (4):
>       perf vendor events arm64: Fix Hisi hip08 DDRC PMU eventname
>       perf vendor events arm64: Add some missing events for Hisi hip08 DDRC PMU
>       perf vendor events arm64: Add some missing events for Hisi hip08 L3C PMU
>       perf vendor events arm64: Add some missing events for Hisi hip08 HHA PMU
> 
> Leo Yan (5):
>       perf test: Report failure for mmap events
>       perf test: Avoid infinite loop for task exit case
>       perf tests: Remove needless headers for bp_account
>       perf tests bp_account: Add dedicated checking helper is_supported()
>       perf tests: Disable bp_signal testing for arm64
> 
> Steven Rostedt (VMware) (2):
>       perf scripting engines: Iterate on tep event arrays directly
>       perf tools: Remove unused trace_find_next_event()
> 
> Thomas Richter (1):
>       perf jvmti: Link against tools/lib/ctype.h to have weak strlcpy()
> 
>  tools/arch/x86/include/asm/irq_vectors.h           | 146 +++++++
>  tools/perf/Documentation/perf-list.txt             |   3 +
>  tools/perf/Documentation/perf-stat.txt             |   6 +
>  tools/perf/Documentation/perf-trace.txt            |   4 +
>  tools/perf/Makefile.config                         |   5 +
>  tools/perf/Makefile.perf                           |  10 +
>  tools/perf/builtin-list.c                          |  14 +-
>  tools/perf/builtin-report.c                        |   7 +
>  tools/perf/builtin-script.c                        |   5 +-
>  tools/perf/builtin-stat.c                          |   6 +
>  tools/perf/builtin-trace.c                         | 420 ++++++++++++++++-----
>  tools/perf/check-headers.sh                        |   1 +
>  tools/perf/jvmti/Build                             |   6 +-
>  tools/perf/lib/Makefile                            |   1 +
>  tools/perf/lib/evlist.c                            |  71 +++-
>  tools/perf/lib/include/internal/evlist.h           |   3 +
>  tools/perf/lib/include/internal/evsel.h            |   1 +
>  tools/perf/lib/include/internal/mmap.h             |   5 +-
>  tools/perf/lib/include/internal/tests.h            |  20 +-
>  tools/perf/lib/include/perf/core.h                 |   1 +
>  tools/perf/lib/include/perf/evlist.h               |  10 +-
>  tools/perf/lib/include/perf/evsel.h                |   2 -
>  tools/perf/lib/internal.h                          |   3 +
>  tools/perf/lib/libperf.map                         |   3 +-
>  tools/perf/lib/mmap.c                              |   6 +-
>  tools/perf/lib/tests/Makefile                      |   6 +-
>  tools/perf/lib/tests/test-cpumap.c                 |   2 +-
>  tools/perf/lib/tests/test-evlist.c                 | 219 ++++++++++-
>  tools/perf/lib/tests/test-evsel.c                  |   2 +-
>  tools/perf/lib/tests/test-threadmap.c              |   2 +-
>  .../arch/arm64/hisilicon/hip08/uncore-ddrc.json    |  16 +-
>  .../arch/arm64/hisilicon/hip08/uncore-hha.json     |  23 +-
>  .../arch/arm64/hisilicon/hip08/uncore-l3c.json     |  56 +++
>  tools/perf/pmu-events/jevents.c                    |  26 +-
>  tools/perf/pmu-events/jevents.h                    |   3 +-
>  tools/perf/pmu-events/pmu-events.h                 |   1 +
>  tools/perf/tests/bp_account.c                      |  20 +-
>  tools/perf/tests/bp_signal.c                       |  15 +-
>  tools/perf/tests/builtin-test.c                    |   2 +-
>  tools/perf/tests/task-exit.c                       |   9 +
>  tools/perf/tests/tests.h                           |   1 +
>  tools/perf/trace/beauty/beauty.h                   |  19 +
>  tools/perf/trace/beauty/mmap.c                     |   4 +-
>  tools/perf/trace/beauty/tracepoints/Build          |   1 +
>  .../trace/beauty/tracepoints/x86_irq_vectors.c     |  29 ++
>  .../trace/beauty/tracepoints/x86_irq_vectors.sh    |  27 ++
>  tools/perf/util/annotate.c                         | 196 ++++++----
>  tools/perf/util/evlist.c                           |  34 +-
>  tools/perf/util/parse-events.c                     |   4 +-
>  tools/perf/util/parse-events.h                     |   2 +-
>  tools/perf/util/pmu.c                              |  17 +-
>  tools/perf/util/pmu.h                              |   4 +-
>  .../perf/util/scripting-engines/trace-event-perl.c |   8 +-
>  .../util/scripting-engines/trace-event-python.c    |   9 +-
>  tools/perf/util/stat.c                             |  10 +
>  tools/perf/util/stat.h                             |   2 +
>  tools/perf/util/string2.h                          |   3 +
>  tools/perf/util/time-utils.c                       |  27 +-
>  tools/perf/util/time-utils.h                       |   5 +
>  tools/perf/util/trace-event-parse.c                |  31 --
>  tools/perf/util/trace-event.h                      |   2 -
>  61 files changed, 1307 insertions(+), 289 deletions(-)
>  create mode 100644 tools/arch/x86/include/asm/irq_vectors.h
>  create mode 100644 tools/perf/trace/beauty/tracepoints/x86_irq_vectors.c
>  create mode 100755 tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh

Pulled, thanks a lot Arnaldo!

	Ingo
