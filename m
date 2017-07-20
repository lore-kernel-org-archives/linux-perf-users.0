From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/86] perf/core improvements and fixes
Date: Thu, 20 Jul 2017 10:32:27 +0200
Message-ID: <20170720083227.ttflzrwczwayqq7x@gmail.com>
References: <20170719142950.3747-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexei Starovoitov <ast@kernel.org>, Andi Kleen <ak@linux.intel.com>, Brendan Gregg <brendan.d.gregg@gmail.com>, David Ahern <dsahern@gmail.com>, David Carrillo-Cisneros <davidcc@google.com>, He Kuang <hekuang@huawei.com>, Jens Axboe <axboe@kernel.dk>, Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@intel.com>, Krister Johansen <kjlx@templeofstupid.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Masami Hiramatsu <mhiramat@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Unusually big one, please conside pulling, details on the signed tag,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 4b1303d0b01440f224cf81493b7e8e43d9b4965e:
> 
>   perf symbols: Accept zero as the kernel base address (2017-07-12 11:47:05 -0300)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.13-20170718
> 
> for you to fetch changes up to b851dd49868e295e18c5d72fc3bad85ff1c444b1:
> 
>   perf report: Show branch type in callchain entry (2017-07-18 23:14:42 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> User visible:
> 
> . Initial support for namespaces, using setns to access files in
>   namespaces, grabbing their build-ids, etc. We still need to work
>   more to deal with namespaces that vanish before we can get the
>   needed data to do analysis, but this should be as good as what is
>   in bcc now (Krister Johansen)
> 
> . Add header record types to pipe-mode, now this command:
> 
>   $ perf record -o - -e cycles sleep 1 | perf report --stdio --header
> 
>   Will show the same as in non-pipe mode, i.e. involving a perf.data
>   file (David Carrillo-Cisneros)
> 
> . Implement a visual marker for fused x86 instructions in the annotate
>   TUI browser, available now in 'perf report', more work needed to have
>   it available as well in 'perf top' (Jin Yao)
> 
>   Further explanation from one of Jin's patches:
> 
>        │   ┌──cmpl   $0x0,argp_program_version_hook
>  81.93 │   ├──je     20
>        │   │  lock   cmpxchg %esi,0x38a9a4(%rip)
>        │   │↓ jne    29
>        │   │↓ jmp    43
>  11.47 │20:└─→cmpxch %esi,0x38a999(%rip)
> 
>   That means the cmpl+je is a fused instruction pair and they should be
>   considered together.
> 
> . Record the branch type and then show statistics and info about
>   in callchain entries (Jin Yao)
> 
>   Example from one of Jin's patches:
> 
>   # perf record -g -j any,save_type
>   # perf report --branch-history --stdio --no-children
> 
>   38.50%  div.c:45                [.] main                    div
>           |
>           ---main div.c:42 (RET CROSS_2M cycles:2)
>              compute_flag div.c:28 (cycles:2)
>              compute_flag div.c:27 (RET CROSS_2M cycles:1)
>              rand rand.c:28 (cycles:1)
>              rand rand.c:28 (RET CROSS_2M cycles:1)
>              __random random.c:298 (cycles:1)
>              __random random.c:297 (COND_BWD CROSS_2M cycles:1)
>              __random random.c:295 (cycles:1)
>              __random random.c:295 (COND_BWD CROSS_2M cycles:1)
>              __random random.c:295 (cycles:1)
>              __random random.c:295 (RET CROSS_2M cycles:9)
> 
> . Beautify the fcntl syscall, which is an interesting one in the sense
>   that infrastructure had to be put in place to change the formatters of
>   some arguments according to the value in a previous one, i.e. cmd
>   dictates how arg and the syscall return will be formatted.
>   (Arnaldo Carvalho de Melo
> 
> Infrastructure:
> 
> . 'perf test attr' fixes (Jiri Olsa)
> 
> Vendor events:
> 
> - Add POWER9 PMU events Sukadev (Bhattiprolu)
> 
> - Support additional POWER8+ PVR in PMU mapfile (Shriya)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (39):
>       perf trace: Remove F_ from some of the fcntl command strings
>       perf trace: Beautify linux specific fcntl commands
>       tools: Update include/uapi/linux/fcntl.h copy from the kernel
>       perf trace beauty: Export the strarrays scnprintf method
>       perf trace: Only build tools/perf/trace/beauty/ when building 'perf trace'
>       perf trace beauty: Mask ignored fcntl 'arg' parameter
>       perf trace beauty: Allow accessing syscall args values in a syscall arg formatter
>       perf trace beauty: Export the "int" and "hex" syscall arg formatters
>       perf trace beauty: Introduce syscall arg beautifier for long integers
>       tools include uapi asm-generic: Grab a copy of fcntl.h
>       perf trace beauty fcntl: Basic 'arg' beautifier
>       perf trace: Beautify new write hint fcntl commands
>       perf beauty open: Detach the syscall_arg agnostic bits from the flags formatter
>       perf trace: Allow syscall_arg beautifiers to set a different return formatter
>       perf trace beauty open flags: Support O_TMPFILE and O_NOFOLLOW
>       perf trace beauty open flags: Do not depend on the system's O_LARGEFILE define
>       perf trace beauty fcntl: Beautify F_GETFL return value
>       perf trace beauty open flags: Move RDRW to the start of the output
>       perf trace beauty fcntl flags: Beautify F_SETFL arg
>       perf trace beauty fcntl: Beautify F_[GS]ETFD arg/return value
>       perf trace beauty: Give syscall return beautifier more context
>       perf trace beauty: Export the fd beautifier for use in more places
>       perf trace beauty fcntl: Augment the return of F_DUPFD(_CLOEXEC)
>       perf trace beauty: Export the pid beautifier for use in more places
>       perf trace beauty fcntl: Beautify F_GETOWN and F_SETOWN
>       tools include uapi x86: Grab a copy of unistd.h
>       tools include uapi x86: Add __NR_setns, if missing
>       tools build: Add test for setns()
>       perf evsel: Allow asking for max precise_ip in new_cycles()
>       perf evlist: Allow asking for max precise_ip in add_default()
>       perf record: Do not ask for precise_ip with --no-samples
>       perf test sdt: Handle realpath() failure
>       perf trace beauty: Export strarray for use in per-object beautifiers
>       perf trace beauty fcntl: Beautify F_GETLEASE and F_SETLEASE arg/return
>       perf trace: Group per syscall arg formatter info into one struct
>       perf trace: Allow syscall arg formatters to request non suppression of zeros
>       perf trace beauty fcntl: Do not suppress 'cmd' when zero, should be DUPFD
>       perf trace beauty fcntl: Beautify the 'arg' for DUPFD
>       perf trace beauty: Simplify syscall return formatting
> 
> David Carrillo-Cisneros (16):
>       perf header: Encapsulate read and swap
>       perf header: Add PROCESS_STR_FUN macro
>       perf header: Fail on write_padded error
>       perf util: Add const modifier to buf in "writen" function
>       perf header: Revamp do_write()
>       perf header: Add struct feat_fd for write
>       perf header: Use struct feat_fd for print
>       perf header: Use struct feat_fd to process header records
>       perf header: Don't pass struct perf_file_section to process_##_feat
>       perf header: Use struct feat_fd in read header records
>       perf header: Make write_pmu_mappings pipe-mode friendly
>       perf header: Add a buffer to struct feat_fd
>       perf header: Change FEAT_OP* macros
>       perf tool: Add show_feature_header to perf_tool
>       perf tools: Add feature header record to pipe-mode
>       perf header: Add event desc to pipe-mode header
> 
> Jin Yao (10):
>       perf annotate: Check for fused instructions
>       perf annotate: Implement visual marker for macro fusion
>       perf report: Enable finding kernel inline functions
>       perf/core: Define the common branch type classification
>       perf/x86/intel: Record branch type
>       perf record: Create a new option save_type in --branch-filter
>       perf report: Refactor the branch info printing code
>       perf util: Create branch.c/.h for common branch functions
>       perf report: Show branch type statistics for stdio mode
>       perf report: Show branch type in callchain entry
> 
> Jiri Olsa (13):
>       perf tests attr: Do not store failed events
>       perf tests attr: Add test_attr__ready function
>       perf tests attr: Make compare_data global
>       perf tests attr: Rename compare_data to data_equal
>       perf tests attr: Add 1s for exclude_kernel and task base bits
>       perf tests attr: Fix record dwarf test
>       perf tests attr: Fix no-delay test
>       perf tests attr: Add proper return values
>       perf tests attr: Fix cpu test disabled term setup
>       perf tests attr: Fix sample_period setup
>       perf tests attr: Fix precise_ip setup
>       perf tests attr: Fix stat sample_type setup
>       perf tests attr: Add optional term
> 
> Krister Johansen (5):
>       perf symbols: Find symbols in different mount namespace
>       perf maps: Lookup maps in both intitial mountns and inner mountns.
>       perf probe: Allow placing uprobes in alternate namespaces.
>       perf buildid-cache: Support binary objects from other namespaces
>       perf buildid-cache: Cache debuginfo
> 
> Shriya (1):
>       perf pmu-events: Support additional POWER8+ PVR in mapfile
> 
> Sukadev Bhattiprolu (2):
>       perf vendor events: Add POWER9 PMU events
>       perf vendor events: Add POWER9 PVRs to mapfile
> 
>  arch/x86/events/intel/lbr.c                        |   52 +-
>  include/uapi/linux/perf_event.h                    |   27 +-
>  tools/arch/x86/include/asm/unistd_32.h             |    3 +
>  tools/arch/x86/include/asm/unistd_64.h             |    3 +
>  tools/arch/x86/include/uapi/asm/unistd.h           |   17 +
>  tools/build/Makefile.feature                       |    3 +-
>  tools/build/feature/Makefile                       |    6 +-
>  tools/build/feature/test-all.c                     |    5 +
>  tools/build/feature/test-setns.c                   |    7 +
>  tools/include/uapi/asm-generic/fcntl.h             |  220 +++++
>  tools/include/uapi/linux/fcntl.h                   |   21 +
>  tools/include/uapi/linux/perf_event.h              |   27 +-
>  tools/perf/Build                                   |    2 +-
>  tools/perf/Documentation/perf-buildid-cache.txt    |    5 +
>  tools/perf/Documentation/perf-probe.txt            |   14 +
>  tools/perf/Documentation/perf-record.txt           |    1 +
>  tools/perf/Documentation/perf.data-file-format.txt |   10 +-
>  tools/perf/Makefile.config                         |    5 +
>  tools/perf/arch/powerpc/util/sym-handling.c        |    2 +-
>  tools/perf/arch/x86/annotate/instructions.c        |   46 +
>  tools/perf/builtin-annotate.c                      |    1 +
>  tools/perf/builtin-buildid-cache.c                 |   54 +-
>  tools/perf/builtin-inject.c                        |    1 +
>  tools/perf/builtin-probe.c                         |   45 +-
>  tools/perf/builtin-record.c                        |    9 +-
>  tools/perf/builtin-report.c                        |   30 +
>  tools/perf/builtin-script.c                        |    4 +
>  tools/perf/builtin-top.c                           |    2 +-
>  tools/perf/builtin-trace.c                         |  602 ++++++------
>  tools/perf/check-headers.sh                        |    1 +
>  tools/perf/perf.h                                  |    1 +
>  tools/perf/pmu-events/arch/powerpc/mapfile.csv     |    4 +
>  .../perf/pmu-events/arch/powerpc/power9/cache.json |  176 ++++
>  .../arch/powerpc/power9/floating-point.json        |   44 +
>  .../pmu-events/arch/powerpc/power9/frontend.json   |  446 +++++++++
>  .../pmu-events/arch/powerpc/power9/marked.json     |  782 +++++++++++++++
>  .../pmu-events/arch/powerpc/power9/memory.json     |  158 +++
>  .../perf/pmu-events/arch/powerpc/power9/other.json |  836 ++++++++++++++++
>  .../pmu-events/arch/powerpc/power9/pipeline.json   |  680 +++++++++++++
>  tools/perf/pmu-events/arch/powerpc/power9/pmc.json |  146 +++
>  .../arch/powerpc/power9/translation.json           |  272 ++++++
>  tools/perf/tests/attr.c                            |   12 +-
>  tools/perf/tests/attr.py                           |   50 +-
>  tools/perf/tests/attr/base-record                  |    6 +-
>  tools/perf/tests/attr/base-stat                    |    4 +-
>  tools/perf/tests/attr/test-record-C0               |    1 +
>  tools/perf/tests/attr/test-record-basic            |    1 +
>  tools/perf/tests/attr/test-record-branch-any       |    2 +-
>  .../perf/tests/attr/test-record-branch-filter-any  |    2 +-
>  .../tests/attr/test-record-branch-filter-any_call  |    2 +-
>  .../tests/attr/test-record-branch-filter-any_ret   |    2 +-
>  tools/perf/tests/attr/test-record-branch-filter-hv |    2 +-
>  .../tests/attr/test-record-branch-filter-ind_call  |    2 +-
>  tools/perf/tests/attr/test-record-branch-filter-k  |    2 +-
>  tools/perf/tests/attr/test-record-branch-filter-u  |    2 +-
>  tools/perf/tests/attr/test-record-count            |    1 +
>  tools/perf/tests/attr/test-record-data             |    3 +-
>  tools/perf/tests/attr/test-record-freq             |    1 +
>  tools/perf/tests/attr/test-record-graph-default    |    1 +
>  tools/perf/tests/attr/test-record-graph-dwarf      |    4 +-
>  tools/perf/tests/attr/test-record-graph-fp         |    1 +
>  tools/perf/tests/attr/test-record-group            |    1 +
>  tools/perf/tests/attr/test-record-group-sampling   |    1 +
>  tools/perf/tests/attr/test-record-group1           |    1 +
>  ...st-record-no-delay => test-record-no-buffering} |    4 +-
>  tools/perf/tests/attr/test-record-no-inherit       |    1 +
>  tools/perf/tests/attr/test-record-no-samples       |    1 +
>  tools/perf/tests/attr/test-record-period           |    1 +
>  tools/perf/tests/attr/test-record-raw              |    2 +-
>  tools/perf/tests/attr/test-stat-C0                 |    4 +-
>  tools/perf/tests/attr/test-stat-default            |    2 +
>  tools/perf/tests/attr/test-stat-detailed-1         |    2 +
>  tools/perf/tests/attr/test-stat-detailed-2         |    3 +
>  tools/perf/tests/attr/test-stat-detailed-3         |    5 +
>  tools/perf/tests/sdt.c                             |    8 +-
>  tools/perf/trace/beauty/Build                      |    1 +
>  tools/perf/trace/beauty/beauty.h                   |   65 ++
>  tools/perf/trace/beauty/fcntl.c                    |  100 ++
>  tools/perf/trace/beauty/open_flags.c               |   29 +-
>  tools/perf/trace/beauty/pid.c                      |    4 +-
>  tools/perf/ui/browser.c                            |   29 +
>  tools/perf/ui/browser.h                            |    2 +
>  tools/perf/ui/browsers/annotate.c                  |   30 +-
>  tools/perf/ui/browsers/hists.c                     |    3 -
>  tools/perf/ui/gtk/annotate.c                       |    2 +-
>  tools/perf/ui/stdio/hist.c                         |    3 -
>  tools/perf/util/Build                              |    5 +
>  tools/perf/util/annotate.c                         |   29 +-
>  tools/perf/util/annotate.h                         |    4 +-
>  tools/perf/util/branch.c                           |  147 +++
>  tools/perf/util/branch.h                           |   24 +
>  tools/perf/util/build-id.c                         |  129 ++-
>  tools/perf/util/build-id.h                         |   16 +-
>  tools/perf/util/callchain.c                        |  134 +--
>  tools/perf/util/callchain.h                        |    5 +-
>  tools/perf/util/dso.c                              |   21 +-
>  tools/perf/util/dso.h                              |    3 +
>  tools/perf/util/event.c                            |    1 +
>  tools/perf/util/event.h                            |   11 +-
>  tools/perf/util/evlist.c                           |    4 +-
>  tools/perf/util/evlist.h                           |    9 +-
>  tools/perf/util/evsel.c                            |   18 +-
>  tools/perf/util/evsel.h                            |    3 +-
>  tools/perf/util/header.c                           | 1015 +++++++++++---------
>  tools/perf/util/header.h                           |   16 +-
>  tools/perf/util/hist.c                             |    5 +-
>  tools/perf/util/machine.c                          |   33 +-
>  tools/perf/util/map.c                              |   23 +-
>  tools/perf/util/map.h                              |    2 +-
>  tools/perf/util/namespaces.c                       |  211 ++++
>  tools/perf/util/namespaces.h                       |   38 +
>  tools/perf/util/parse-branch-options.c             |    1 +
>  tools/perf/util/parse-events.c                     |    2 +-
>  tools/perf/util/probe-event.c                      |   86 +-
>  tools/perf/util/probe-event.h                      |   10 +-
>  tools/perf/util/probe-file.c                       |   19 +-
>  tools/perf/util/probe-file.h                       |    4 +-
>  tools/perf/util/python-ext-sources                 |    1 +
>  tools/perf/util/session.c                          |    4 +
>  tools/perf/util/setns.c                            |    8 +
>  tools/perf/util/symbol.c                           |   92 +-
>  tools/perf/util/thread.c                           |    3 +
>  tools/perf/util/thread.h                           |    1 +
>  tools/perf/util/tool.h                             |   10 +-
>  tools/perf/util/util.c                             |   40 +-
>  tools/perf/util/util.h                             |    8 +-
>  126 files changed, 6339 insertions(+), 1031 deletions(-)
>  create mode 100644 tools/arch/x86/include/uapi/asm/unistd.h
>  create mode 100644 tools/build/feature/test-setns.c
>  create mode 100644 tools/include/uapi/asm-generic/fcntl.h
>  create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/floating-point.json
>  create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/frontend.json
>  create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/marked.json
>  create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/other.json
>  create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/pmc.json
>  create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/translation.json
>  rename tools/perf/tests/attr/{test-record-no-delay => test-record-no-buffering} (61%)
>  create mode 100644 tools/perf/trace/beauty/fcntl.c
>  create mode 100644 tools/perf/util/branch.c
>  create mode 100644 tools/perf/util/branch.h
>  create mode 100644 tools/perf/util/setns.c

Pulled, thanks a lot Arnaldo!

	Ingo
