From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL 00/75] perf/core improvements and fixes
Date: Thu,  6 Dec 2018 18:24:47 -0300
Message-ID: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Song Liu <songliubraving@fb.com>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>, Clark Williams <williams@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Alexey Brodkin <alexey.brodkin@synopsys.com>, Will Deacon <will.deacon@arm.com>, Alexei Starovoitov <ast@kernel.org>, Stephane Eranian <eranian@google.com>, Adrian Hunter <adrian.hunter@intel.com>, David Howells <dhowells@redhat.com>, Jin Yao <yao.jin@linux.intel.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Robert Walker <robert.walker@arm.com>, Jiri Olsa <jolsa@redhat.com>, Wen Yang <wen.yang99@zte.com.cn>, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, zhong.weidong@zte.com.cn, Sihyeon Jang <uneedsihyeon@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Alexey Budankov <alexey.budankov@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

Hi Ingo,

	Please consider pulling, this includes what should have been in
my previous pull request, that ended up empty as I messed up when
signing the tag, that was made with perf/urgent checked out :-\ Now it
should be ok, sorry about that :-\

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit e8e94fce14658defc659021a50d4253a681d02e7:

  Merge tag 'perf-core-for-mingo-4.21-20181122' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2018-11-22 07:52:50 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.21-20181206

for you to fetch changes up to 4085fed6373f15892959e3392efe5552504cfc94:

  perf trace: Add ordered processing (2018-12-06 16:43:28 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

- Introduce 'perf record --aio' to use asynchronous IO trace writing, disabled
  by default (Alexey Budankov)

- Add fallback routines to be used in places where we don't have the CPU mode
  (kernel/userspace/hypervisor) and thus must first fallback lookups looking
  at all map trees when trying to resolve symbols (Adrian Hunter)

- Fix error with config term "pt=0", where we should just force "pt=1" and
  warn the user about the former being nonsensical (Adrian Hunter)

- Fix 'perf test' entry where we expect 'sleep' to come in a PERF_RECORD_COMM
  but instead we get 'coreutils' when sleep is provided by some versions of
  the 'coreutils' package (Adrian Hunter)

- Introduce 'perf top --kallsyms file' to match 'perf report --kallsyms', useful
  when dealing with BPF, where symbol resolution happens via kallsyms, not via
  the default vmlinux ELF symtabs (Arnaldo Carvalho de Melo)

- Support 'srccode' output field in 'perf script' (Andi Kleen)

- Introduce basic 'perf annotation' support for the ARC architecture (Eugeniy Paltsev)

- Compute and display average IPC and IPC coverage per symbol in 'perf annotate' and
  'perf report' (Jin Yao)

- Make 'perf top' use ordered_events and process histograms in a separate thread (Jiri Olsa)

- Make 'perf trace' use ordered_events (Jiri Olsa)

- Add support for ETMv3 and PTMv1.1 decoding in cs-etm (Mathieu Poirier)

- Support for ARM A32/T32 instruction sets in CoreSight trace (cs-etm) (Robert Walker)

- Fix 'perf stat' shadow stats for clock events. (Ravi Bangoria)

- Remove needless rb_tree extra indirection from map__find() (Eric Saint-Etienne)

- Fix CSV mode column output for non-cgroup events in 'perf stat' (Stephane Eranian)

- Add sanity check to libtraceevent's is_timestamp_in_us() (Tzvetomir Stoyanov)

- Use ERR_CAST instead of ERR_PTR(PTR_ERR()) (Wen Yang)

- Fix Load_Miss_Real_Latency on SKL/SKX intel vendor event files (Andi Kleen)

- strncpy() fixes triggered by new warnings on gcc 8.2.0 (Arnaldo Carvalho de Melo)

- Handle tracefs syscall tracepoint older 'nr' field in 'perf trace', that got
  renamed to '__syscall_nr' to work in older kernels (Arnaldo Carvalho de Melo)

- Give better hint about devel package for libssl (Arnaldo Carvalho de Melo)

- Fix the 'perf trace' build in architectures lacking explicit mmap.h file (Arnaldo Carvalho de Melo)

- Remove extra rb_tree traversal indirection from map__find() (Eric Saint-Etienne)

- Disable breakpoint tests for 32-bit ARM (Florian Fainelli)

- Fix typos all over the place, mostly in comments, but also in some debug
  messages and JSON files (Ingo Molnar)

- Allow specifying proc-map-timeout in config file (Mark Drayton)

- Fix mmap_flags table generation script (Sihyeon Jang)

- Fix 'size' parameter to snprintf in the 'perf config' code (Sihyeon Jang)

- More libtraceevent renames to make it a proper library (Tzvetomir Stoyanov)

- Implement new API tep_get_ref() in libtraceevent (Tzvetomir Stoyanov)

- Added support for pkg-config in libtraceevent (Tzvetomir Stoyanov)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (8):
      perf machine: Record if a arch has a single user/kernel address space
      perf thread: Add fallback functions for cases where cpumode is insufficient
      perf tools: Use fallback for sample_addr_correlates_sym() cases
      perf script: Use fallbacks for branch stacks
      tools lib traceevent: Fix compile warnings in tools/lib/traceevent/event-parse.c
      perf tests record: Allow for 'sleep' being 'coreutils'
      perf test: Fix perf_event_attr test failure
      perf intel-pt: Fix error with config term "pt=0"

Alexey Budankov (5):
      tools build feature: Check if libaio is available
      perf mmap: Map data buffer for preserving collected data
      perf record: Enable asynchronous trace writing
      perf record: Extend trace writing to multi AIO
      perf record: Fix memory leak on AIO objects deallocation

Andi Kleen (2):
      perf tools: Support 'srccode' output
      perf vendor events intel: Fix Load_Miss_Real_Latency on SKL/SKX

Arnaldo Carvalho de Melo (14):
      perf build: Give better hint about devel package for libssl
      perf env: Also consider env->arch == NULL as local operation
      tools include: Adopt ERR_CAST() from the kernel err.h header
      perf top: Allow passing a kallsyms file
      perf beauty mmap_flags: Check if the arch has a mmap.h file
      perf trace: We need to consider "nr" if "__syscall_nr" is not there
      perf dso: Fix unchecked usage of strncpy()
      perf header: Fix unchecked usage of strncpy()
      perf header: Fix unchecked usage of strncpy()
      perf help: Remove needless use of strncpy()
      perf svghelper: Fix unchecked usage of strncpy()
      perf ui helpline: Use strlcpy() as a shorter form of strncpy() + explicit set nul
      perf probe: Fix unchecked usage of strncpy()
      perf parse-events: Fix unchecked usage of strncpy()

Eric Saint-Etienne (1):
      perf map: Remove extra indirection from map__find()

Eugeniy Paltsev (1):
      perf annotate: Introduce basic support for ARC

Florian Fainelli (1):
      perf tests ARM: Disable breakpoint tests 32-bit

Ingo Molnar (6):
      perf vendor events intel: Fix diverse typos
      tools lib traceevent: Fix diverse typos in comments
      perf tools Documentation: Fix diverse typos
      perf bpf-loader: Fix debugging message typo
      perf tools: Fix diverse comment typos
      tools lib subcmd: Fix a few source code comment typos

Jin Yao (4):
      perf annotate: Compute average IPC and IPC coverage per symbol
      perf annotate: Create a annotate2 flag in struct symbol
      perf report: Display average IPC and IPC coverage per symbol
      perf report: Documentation average IPC and IPC coverage

Jiri Olsa (15):
      perf ordered_events: Rework show_progress for __ordered_events__flush
      perf ordered_events: Add private data member
      perf top: Save and display the lost count stats
      perf top: Move lost events warning to helpline
      perf top: Add processing thread
      perf top: Use cond variable instead of a lock
      perf top: Set the 'session_done' volatile variable when exiting
      perf top: Drop samples which are behind the refresh rate
      perf top: Save and display the drop count stats
      perf top: Display slow reader warning when droping samples
      perf top: Move perf_top__reset_sample_counters() to after counts display
      perf ordered_events: Add ordered_events__flush_time interface
      perf trace: Move event delivery to a new deliver_event() function
      perf ordered_events: Add first_time() method
      perf trace: Add ordered processing

Mark Drayton (1):
      perf tools: Allow specifying proc-map-timeout in config file

Mathieu Poirier (3):
      perf cs-etm: Add configuration for ETMv3 trace protocol
      perf cs-etm: Add support for ETMv3 trace decoding
      perf cs-etm: Add support for PTMv1.1 decoding

Ravi Bangoria (1):
      perf stat: Fix shadow stats for clock events

Robert Walker (1):
      perf cs-etm: Support for ARM A32/T32 instruction sets in CoreSight trace

Sihyeon Jang (2):
      perf beauty mmap_flags: Fixed syntax error Fixed missing ']' error
      perf config: Modify size factor of snprintf

Stephane Eranian (1):
      perf stat: Fix CSV mode column output for non-cgroup events

Tzvetomir Stoyanov (8):
      tools lib traceevent: Add sanity check to is_timestamp_in_us()
      tools lib traceevent: Implement new API tep_get_ref()
      tools lib traceevent: Added support for pkg-config
      tools lib traceevent: Install trace-seq.h API header file
      tools lib traceevent, perf tools: Rename 'struct tep_event_format' to 'struct tep_event'
      tools lib traceevent: Rename tep_free_format() to tep_free_event()
      perf tools: traceevent API cleanup, remove __tep_data2host*()
      tools lib traceevent: traceevent API cleanup

Wen Yang (1):
      perf bpf: Use ERR_CAST instead of ERR_PTR(PTR_ERR())

 tools/build/Makefile.feature                       |   6 +-
 tools/build/feature/Makefile                       |   6 +-
 tools/build/feature/test-all.c                     |   5 +
 tools/build/feature/test-libaio.c                  |  16 ++
 tools/build/feature/test-libopencsd.c              |   8 +
 tools/include/linux/err.h                          |  13 +
 tools/lib/subcmd/parse-options.h                   |   4 +-
 tools/lib/traceevent/Makefile                      |  27 +-
 tools/lib/traceevent/event-parse-api.c             |   8 +-
 tools/lib/traceevent/event-parse-local.h           |  13 +-
 tools/lib/traceevent/event-parse.c                 | 234 +++++++++--------
 tools/lib/traceevent/event-parse.h                 |  77 +++---
 tools/lib/traceevent/libtraceevent.pc.template     |  10 +
 tools/lib/traceevent/parse-filter.c                |  42 +--
 tools/lib/traceevent/plugin_function.c             |   2 +-
 tools/lib/traceevent/plugin_hrtimer.c              |   4 +-
 tools/lib/traceevent/plugin_kmem.c                 |   2 +-
 tools/lib/traceevent/plugin_kvm.c                  |  16 +-
 tools/lib/traceevent/plugin_mac80211.c             |   4 +-
 tools/lib/traceevent/plugin_sched_switch.c         |   4 +-
 tools/perf/Documentation/perf-config.txt           |   6 +
 tools/perf/Documentation/perf-list.txt             |   2 +-
 tools/perf/Documentation/perf-record.txt           |   5 +
 tools/perf/Documentation/perf-report.txt           |  10 +-
 tools/perf/Documentation/perf-script.txt           |   2 +-
 tools/perf/Documentation/perf-stat.txt             |   4 +-
 tools/perf/Documentation/perf-top.txt              |   3 +
 tools/perf/Makefile.config                         |   8 +-
 tools/perf/Makefile.perf                           |   9 +-
 tools/perf/arch/arc/annotate/instructions.c        |   9 +
 tools/perf/arch/common.c                           |  21 +-
 tools/perf/arch/common.h                           |   1 +
 tools/perf/arch/x86/tests/insn-x86.c               |   2 +-
 tools/perf/arch/x86/util/intel-pt.c                |  11 +
 tools/perf/builtin-help.c                          |   2 +-
 tools/perf/builtin-kvm.c                           |   6 +-
 tools/perf/builtin-record.c                        | 263 ++++++++++++++++++-
 tools/perf/builtin-report.c                        |  26 +-
 tools/perf/builtin-script.c                        |  59 ++++-
 tools/perf/builtin-top.c                           | 289 +++++++++++++++------
 tools/perf/builtin-trace.c                         |  87 +++++--
 tools/perf/perf.h                                  |   2 +-
 .../perf/pmu-events/arch/x86/broadwell/cache.json  |   4 +-
 .../pmu-events/arch/x86/broadwell/pipeline.json    |   2 +-
 .../pmu-events/arch/x86/broadwellde/cache.json     |   4 +-
 .../pmu-events/arch/x86/broadwellde/pipeline.json  |   2 +-
 .../perf/pmu-events/arch/x86/broadwellx/cache.json |   4 +-
 .../pmu-events/arch/x86/broadwellx/pipeline.json   |   2 +-
 tools/perf/pmu-events/arch/x86/jaketown/cache.json |   4 +-
 .../pmu-events/arch/x86/jaketown/pipeline.json     |   2 +-
 .../pmu-events/arch/x86/knightslanding/cache.json  |  30 +--
 .../pmu-events/arch/x86/sandybridge/cache.json     |   4 +-
 .../pmu-events/arch/x86/sandybridge/pipeline.json  |   2 +-
 .../pmu-events/arch/x86/skylake/skl-metrics.json   |   2 +-
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |   2 +-
 .../pmu-events/arch/x86/skylakex/uncore-other.json |  12 +-
 tools/perf/tests/attr.c                            |   2 +-
 tools/perf/tests/attr.py                           |   2 +-
 tools/perf/tests/bp_signal.c                       |  20 +-
 tools/perf/tests/code-reading.c                    |   2 +-
 tools/perf/tests/dwarf-unwind.c                    |   2 +-
 tools/perf/tests/mmap-thread-lookup.c              |   4 +-
 tools/perf/tests/perf-record.c                     |   7 +-
 tools/perf/trace/beauty/mmap_flags.sh              |   4 +-
 tools/perf/ui/browsers/hists.c                     |  11 +
 tools/perf/ui/tui/helpline.c                       |   2 +-
 tools/perf/util/Build                              |   1 +
 tools/perf/util/annotate.c                         |  49 +++-
 tools/perf/util/annotate.h                         |   5 +
 tools/perf/util/bpf-loader.c                       |   4 +-
 tools/perf/util/config.c                           |   8 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |  60 +++++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h    |  19 ++
 tools/perf/util/cs-etm.c                           | 143 ++++++----
 tools/perf/util/dso.c                              |   2 +-
 tools/perf/util/env.c                              |   2 +-
 tools/perf/util/event.c                            |  61 +++--
 tools/perf/util/event.h                            |   8 +-
 tools/perf/util/evlist.c                           |   6 +-
 tools/perf/util/evlist.h                           |   2 +-
 tools/perf/util/evsel.h                            |   4 +-
 tools/perf/util/evsel_fprintf.c                    |   1 +
 tools/perf/util/header.c                           |   8 +-
 tools/perf/util/hist.c                             |   2 +-
 tools/perf/util/hist.h                             |   1 +
 tools/perf/util/jitdump.c                          |   2 +-
 tools/perf/util/machine.c                          |  33 ++-
 tools/perf/util/machine.h                          |   6 +-
 tools/perf/util/map.c                              |  62 ++++-
 tools/perf/util/map.h                              |  16 ++
 tools/perf/util/mmap.c                             | 152 ++++++++++-
 tools/perf/util/mmap.h                             |  26 +-
 tools/perf/util/ordered-events.c                   |  44 +++-
 tools/perf/util/ordered-events.h                   |   8 +-
 tools/perf/util/parse-events.c                     |   2 +-
 tools/perf/util/probe-event.c                      |   4 +-
 tools/perf/util/probe-file.c                       |   2 +-
 tools/perf/util/python.c                           |   4 +-
 .../perf/util/scripting-engines/trace-event-perl.c |   6 +-
 .../util/scripting-engines/trace-event-python.c    |  24 +-
 tools/perf/util/session.c                          |   7 +-
 tools/perf/util/sort.c                             |  63 ++++-
 tools/perf/util/sort.h                             |   2 +
 tools/perf/util/srccode.c                          | 186 +++++++++++++
 tools/perf/util/srccode.h                          |   7 +
 tools/perf/util/srcline.c                          |  28 ++
 tools/perf/util/srcline.h                          |   1 +
 tools/perf/util/stat-display.c                     |  16 +-
 tools/perf/util/stat-shadow.c                      |   3 +-
 tools/perf/util/svghelper.c                        |   2 +-
 tools/perf/util/symbol.h                           |   1 +
 tools/perf/util/thread.c                           |   2 +
 tools/perf/util/thread.h                           |   6 +
 tools/perf/util/top.c                              |   8 +-
 tools/perf/util/top.h                              |  10 +-
 tools/perf/util/trace-event-parse.c                |  16 +-
 tools/perf/util/trace-event-read.c                 |   4 +-
 tools/perf/util/trace-event.c                      |   8 +-
 tools/perf/util/trace-event.h                      |  16 +-
 119 files changed, 2051 insertions(+), 572 deletions(-)
 create mode 100644 tools/build/feature/test-libaio.c
 create mode 100644 tools/lib/traceevent/libtraceevent.pc.template
 create mode 100644 tools/perf/arch/arc/annotate/instructions.c
 create mode 100644 tools/perf/util/srccode.c
 create mode 100644 tools/perf/util/srccode.h

Test results:

The first ones are container based builds of tools/perf with and without
libelf support.  Where clang is available, it is also used to build perf
with/without libelf, and building with LIBCLANGLLVM=1 (built-in clang)
with gcc and clang when clang and its devel libraries are installed.

The objtool and samples/bpf/ builds are disabled now that I'm switching from
using the sources in a local volume to fetching them from a http server to
build it inside the container, to make it easier to build in a container cluster.
Those will come back later.

Several are cross builds, the ones with -x-ARCH and the android one, and those
may not have all the features built, due to lack of multi-arch devel packages,
available and being used so far on just a few, like
debian:experimental-x-{arm64,mipsel}.

The 'perf test' one will perform a variety of tests exercising
tools/perf/util/, tools/lib/{bpf,traceevent,etc}, as well as run perf commands
with a variety of command line event specifications to then intercept the
sys_perf_event syscall to check that the perf_event_attr fields are set up as
expected, among a variety of other unit tests.

Then there is the 'make -C tools/perf build-test' ones, that build tools/perf/
with a variety of feature sets, exercising the build with an incomplete set of
features as well as with a complete one. It is planned to have it run on each
of the containers mentioned above, using some container orchestration
infrastructure. Get in contact if interested in helping having this in place.

  $ dm
   1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
   2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
   3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
   4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   5 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   6 alpine:edge                   : Ok   gcc (Alpine 8.2.0) 8.2.0
   7 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
   8 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
   9 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  10 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  11 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  12 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  13 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36)
  14 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 8.2.1 20180502
  15 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  16 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u1) 4.9.2
  17 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
  18 debian:experimental           : Ok   gcc (Debian 8.2.0-10) 8.2.0
  19 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.2.0-10) 8.2.0
  20 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 8.2.0-10) 8.2.0
  21 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  22 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  23 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  24 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  25 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  26 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  27 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
  28 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6)
  29 fedora:28                     : Ok   gcc (GCC) 8.2.1 20181105 (Red Hat 8.2.1-5)
  30 fedora:29                     : Ok   gcc (GCC) 8.2.1 20181105 (Red Hat 8.2.1-5)
  31 fedora:rawhide                : Ok   gcc (GCC) 8.2.1 20181105 (Red Hat 8.2.1-5)
  32 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 7.3.0-r3 p1.4) 7.3.0
  33 mageia:5                      : Ok   gcc (GCC) 4.9.2
  34 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0
  35 opensuse:13.2                 : Ok   gcc (SUSE Linux) 4.8.3 20140627 [gcc-4_8-branch revision 212064]
  36 opensuse:42.1                 : Ok   gcc (SUSE Linux) 4.8.5
  37 opensuse:42.2                 : Ok   gcc (SUSE Linux) 4.8.5
  38 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
  39 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  40 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36.0.1)
  41 ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  42 ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4
  43 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.5-2017.10) 5.5.0
  44 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609
  45 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  46 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  47 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  48 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  49 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  50 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  51 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0
  52 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  53 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.3.0-27ubuntu1~18.04) 7.3.0
  54 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.3.0-27ubuntu1~18.04) 7.3.0
  55 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  56 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  57 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  58 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  59 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  60 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  61 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  62 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  63 ubuntu:18.10                  : Ok   gcc (Ubuntu 8.2.0-7ubuntu1) 8.2.0
  $

  # uname -a
  Linux quaco 4.20.0-rc5 #1 SMP Mon Dec 3 12:20:42 -03 2018 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  4085fed6373f perf trace: Add ordered processing
  # perf version --build-options
  perf version 4.20.rc3.g4085fe
                   dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
      dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                   glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
                    gtk2: [ on  ]  # HAVE_GTK2_SUPPORT
           syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                  libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
                  libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
                 libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
  numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
                 libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
               libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
                libslang: [ on  ]  # HAVE_SLANG_SUPPORT
               libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
               libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
      libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                    zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                    lzma: [ on  ]  # HAVE_LZMA_SUPPORT
               get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                     bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
  # perf test
   1: vmlinux symtab matches kallsyms                       : Ok
   2: Detect openat syscall event                           : Ok
   3: Detect openat syscall event on all cpus               : Ok
   4: Read samples using the mmap interface                 : Ok
   5: Test data source output                               : Ok
   6: Parse event definition strings                        : Ok
   7: Simple expression parser                              : Ok
   8: PERF_RECORD_* events & perf_sample fields             : Ok
   9: Parse perf pmu format                                 : Ok
  10: DSO data read                                         : Ok
  11: DSO data cache                                        : Ok
  12: DSO data reopen                                       : Ok
  13: Roundtrip evsel->name                                 : Ok
  14: Parse sched tracepoints fields                        : Ok
  15: syscalls:sys_enter_openat event fields                : Ok
  16: Setup struct perf_event_attr                          : Ok
  17: Match and link multiple hists                         : Ok
  18: 'import perf' in python                               : Ok
  19: Breakpoint overflow signal handler                    : Ok
  20: Breakpoint overflow sampling                          : Ok
  21: Breakpoint accounting                                 : Ok
  22: Watchpoint                                            :
  22.1: Read Only Watchpoint                                : Skip
  22.2: Write Only Watchpoint                               : Ok
  22.3: Read / Write Watchpoint                             : Ok
  22.4: Modify Watchpoint                                   : Ok
  23: Number of exit events of a simple workload            : Ok
  24: Software clock events period values                   : Ok
  25: Object code reading                                   : Ok
  26: Sample parsing                                        : Ok
  27: Use a dummy software event to keep tracking           : Ok
  28: Parse with no sample_id_all bit set                   : Ok
  29: Filter hist entries                                   : Ok
  30: Lookup mmap thread                                    : Ok
  31: Share thread mg                                       : Ok
  32: Sort output of hist entries                           : Ok
  33: Cumulate child hist entries                           : Ok
  34: Track with sched_switch                               : Ok
  35: Filter fds with revents mask in a fdarray             : Ok
  36: Add fd to a fdarray, making it autogrow               : Ok
  37: kmod_path__parse                                      : Ok
  38: Thread map                                            : Ok
  39: LLVM search and compile                               :
  39.1: Basic BPF llvm compile                              : Ok
  39.2: kbuild searching                                    : Ok
  39.3: Compile source for BPF prologue generation          : Ok
  39.4: Compile source for BPF relocation                   : Ok
  40: Session topology                                      : Ok
  41: BPF filter                                            :
  41.1: Basic BPF filtering                                 : Ok
  41.2: BPF pinning                                         : Ok
  41.3: BPF prologue generation                             : Ok
  41.4: BPF relocation checker                              : Ok
  42: Synthesize thread map                                 : Ok
  43: Remove thread map                                     : Ok
  44: Synthesize cpu map                                    : Ok
  45: Synthesize stat config                                : Ok
  46: Synthesize stat                                       : Ok
  47: Synthesize stat round                                 : Ok
  48: Synthesize attr update                                : Ok
  49: Event times                                           : Ok
  50: Read backward ring buffer                             : Ok
  51: Print cpu map                                         : Ok
  52: Probe SDT events                                      : Ok
  53: is_printable_array                                    : Ok
  54: Print bitmap                                          : Ok
  55: perf hooks                                            : Ok
  56: builtin clang support                                 : Skip (not compiled in)
  57: unit_number__scnprintf                                : Ok
  58: mem2node                                              : Ok
  59: x86 rdpmc                                             : Ok
  60: Convert perf time to TSC                              : Ok
  61: DWARF unwind                                          : Ok
  62: x86 instruction decoder - new instructions            : Ok
  63: x86 bp modify                                         : Ok
  64: probe libc's inet_pton & backtrace it with ping       : Ok
  65: Use vfs_getname probe to get syscall args filenames   : Ok
  66: Add vfs_getname probe to get syscall args filenames   : Ok
  67: Check open filename arg using perf trace + vfs_getname: Ok

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
             make_no_libperl_O: make NO_LIBPERL=1
              make_clean_all_O: make clean all
                    make_doc_O: make doc
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
              make_no_libelf_O: make NO_LIBELF=1
                   make_help_O: make help
       make_util_pmu_bison_o_O: make util/pmu-bison.o
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
                 make_perf_o_O: make perf.o
               make_no_slang_O: make NO_SLANG=1
                make_install_O: make install
         make_install_prefix_O: make install prefix=/tmp/krava
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
            make_no_auxtrace_O: make NO_AUXTRACE=1
            make_no_demangle_O: make NO_DEMANGLE=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
                make_no_newt_O: make NO_NEWT=1
             make_no_libnuma_O: make NO_LIBNUMA=1
                make_no_gtk2_O: make NO_GTK2=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
                 make_static_O: make LDFLAGS=-static
                   make_tags_O: make tags
                  make_debug_O: make DEBUG=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
            make_install_bin_O: make install-bin
           make_no_libunwind_O: make NO_LIBUNWIND=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
             make_util_map_o_O: make util/map.o
              make_no_libbpf_O: make NO_LIBBPF=1
           make_no_libpython_O: make NO_LIBPYTHON=1
                   make_pure_O: make
           make_no_backtrace_O: make NO_BACKTRACE=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
