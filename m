From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/18] perf/urgent improvements and fixes
Date: Tue, 6 Nov 2018 20:06:30 +0100
Message-ID: <20181106190630.GA39226@gmail.com>
References: <20181106120612.8262-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181106120612.8262-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexei Starovoitov <ast@kernel.org>, Andi Kleen <ak@linux.intel.com>, Daniel Borkmann <daniel@iogearbox.net>, David Ahern <dsahern@gmail.com>, Edward Cree <ecree@solarflare.com>, Guenter Roeck <linux@roeck-us.net>, Gustavo Romero <gromero@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@linux.intel.com>, Martin KaFai Lau <kafai@fb.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Namhyung Kim <namhyun>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling, mostly fixes, some late coming
> improvements in non-core areas,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 29995d296e3e9ce4f9767963ecbef143ade26c36:
> 
>   Merge tag 'perf-urgent-for-mingo-4.20-20181031' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2018-10-31 22:53:40 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.20-20181106
> 
> for you to fetch changes up to 8e88c29b351ed4e09dd63f825f1c8260b0cb0ab3:
> 
>   perf tools: Do not zero sample_id_all for group members (2018-11-06 08:29:56 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent improvements and fixes:
> 
> Intel PT sql viewer: (Adrian Hunter)
> 
> - Fall back to /usr/local/lib/libxed.so
> - Add Selected branches report
> - Add help window
> - Fix table find when table re-ordered
> 
> Intel PT debug log (Adrian Hunter)
> 
> - Add more event information
> - Add MTC and CYC timestamps
> 
> perf record: (Andi Kleen)
> 
> - Support weak groups, just like with 'perf stat'
> 
> perf trace: (Arnaldo Carvalho de Melo)
> 
> - Start augmenting raw_syscalls:{sys_enter,sys_exit}: goal is to have a
>   generic, arch independent eBPF kernel component that is programmed with
>   syscall table details, what to copy, how many bytes, pid, arg filters from the
>   userspace via eBPF maps by the 'perf trace' tool that continues to use all its
>   argument beautifiers, just taking advantage of the extra pointer contents.
> 
> JVMTI: (Gustavo Romero)
> 
> - Fix undefined symbol scnprintf in libperf-jvmti.so
> 
> perf top: (Jin Yao)
> 
> - Display the LBR stats in callchain entries
> 
> perf stat: (Thomas Richter)
> 
> - Handle different PMU names with common prefix
> 
> arm64: Will (Deacon)
> 
> - Fix arm64 tools build failure wrt smp_load_{acquire,release}.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (6):
>       perf scripts python: exported-sql-viewer.py: Fall back to /usr/local/lib/libxed.so
>       perf scripts python: exported-sql-viewer.py: Add Selected branches report
>       perf scripts python: exported-sql-viewer.py: Add help window
>       perf scripts python: exported-sql-viewer.py: Fix table find when table re-ordered
>       perf intel-pt: Add more event information to debug log
>       perf intel-pt: Add MTC and CYC timestamps to debug log
> 
> Andi Kleen (2):
>       perf evlist: Move perf_evsel__reset_weak_group into evlist
>       perf record: Support weak groups
> 
> Arnaldo Carvalho de Melo (5):
>       perf examples bpf: Start augmenting raw_syscalls:sys_{start,exit}
>       perf trace: When augmenting raw_syscalls plug raw_syscalls:sys_exit too
>       perf trace: Fix setting of augmented payload when using eBPF + raw_syscalls
>       perf augmented_syscalls: Start collecting pathnames in the BPF program
>       perf beauty: Use SRCARCH, ARCH=x86_64 must map to "x86" to find the headers
> 
> Gustavo Romero (1):
>       perf tools: Fix undefined symbol scnprintf in libperf-jvmti.so
> 
> Jin Yao (1):
>       perf top: Display the LBR stats in callchain entry
> 
> Jiri Olsa (1):
>       perf tools: Do not zero sample_id_all for group members
> 
> Thomas Richter (1):
>       perf stat: Handle different PMU names with common prefix
> 
> Will Deacon (1):
>       tools headers barrier: Fix arm64 tools build failure wrt smp_load_{acquire,release}
> 
>  tools/arch/arm64/include/asm/barrier.h             | 133 +++---
>  tools/perf/Documentation/perf-list.txt             |   1 -
>  tools/perf/Makefile.perf                           |   2 +-
>  tools/perf/builtin-record.c                        |   7 +-
>  tools/perf/builtin-stat.c                          |  28 +-
>  tools/perf/builtin-top.c                           |   3 +
>  tools/perf/builtin-trace.c                         |  34 +-
>  tools/perf/examples/bpf/augmented_raw_syscalls.c   | 131 ++++++
>  tools/perf/jvmti/jvmti_agent.c                     |  49 +-
>  tools/perf/scripts/python/exported-sql-viewer.py   | 493 ++++++++++++++++++++-
>  tools/perf/tests/attr/test-record-group-sampling   |   1 -
>  tools/perf/util/evlist.c                           |  27 ++
>  tools/perf/util/evlist.h                           |   3 +
>  tools/perf/util/evsel.c                            |   1 -
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |   4 +
>  tools/perf/util/intel-pt-decoder/intel-pt-log.c    |   5 +
>  tools/perf/util/intel-pt-decoder/intel-pt-log.h    |   1 +
>  tools/perf/util/intel-pt.c                         |  16 +-
>  tools/perf/util/pmu.c                              |   2 +-
>  19 files changed, 820 insertions(+), 121 deletions(-)
>  create mode 100644 tools/perf/examples/bpf/augmented_raw_syscalls.c

Pulled, thanks a lot Arnaldo!

	Ingo
