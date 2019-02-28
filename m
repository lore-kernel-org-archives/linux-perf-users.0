From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/17] perf/core improvements and fixes
Date: Thu, 28 Feb 2019 08:28:12 +0100
Message-ID: <20190228072812.GA59852@gmail.com>
References: <20190221012549.4069-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190221012549.4069-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, He Kuang <hekuang@huawei.com>, Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>, Thomas Richter <tmricht@linux.ibm.com>, Tommi Rantala <tommi.t.rantala@nokia.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
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
> The following changes since commit 43f4e6279f05eefac058a3524e184cecae463bfe:
> 
>   Merge tag 'perf-core-for-mingo-5.1-20190214' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2019-02-15 10:19:11 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.1-20190220
> 
> for you to fetch changes up to b4409ae112caa6315f6ee678e953b9fc93e6919c:
> 
>   perf tools: Make rm_rf() remove single file (2019-02-20 17:09:28 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf report:
> 
>   He Kuang:
> 
>   - Don't shadow inlined symbol with different addr range.
> 
> perf script:
> 
>   Jiri Olsa:
> 
>   - Allow +- operator to ask for -F to add/remove fields to
>     the default set, for instance to ask for the removal of the
>     'cpu' field in tracepoint events, adding 'period' to that
>     kind of events, etc.
> 
> perf test:
> 
>   Thomas Richter:
> 
>   - Fix scheduler tracepoint signedness of COMM fields failure of
>     'evsel-tp-sched' test on s390 and other arches.
> 
>   Tommi Rantala:
> 
>   - Skip trace+probe_vfs_getname.sh when 'perf trace' is not built.
> 
> perf trace:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Add initial BPF map dumper, initially just for the current, minimal
>     needs of the augmented_raw_syscalls BPF example used to collect
>     pointer args payloads that uses BPF maps for pid and syscall filtering,
>     but will in time have features similar to 'perf stat' --interval-print,
>     --interval-clear, ways to signal from a BPF event that a specific
>     map (or range of that map) should be printed, optionally as a
>     histogram, etc.
> 
> General:
> 
>   Jiri Olsa:
> 
>   - Add cpu and numa topologies classes for further reuse, fixing some
>     issues in the process.
> 
>   - Fixup some warnings and debug levels.
> 
>   - Make rm_rf() remove single file, not just directories.
> 
> Documentation:
> 
>   Jonas Rabenstein:
> 
>   - Fix HEADER_CMDLINE description in perf.data documentation.
> 
>   - Fix documentation of the Flags section in perf.data.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (2):
>       perf bpf: Add bpf_map dumper
>       perf trace: Allow dumping a BPF map after setting up BPF events
> 
> He Kuang (1):
>       perf report: Don't shadow inlined symbol with different addr range
> 
> Jiri Olsa (10):
>       perf header: Fix wrong node write in NUMA_TOPOLOGY feature
>       perf tools: Add cpu_topology object
>       perf tools: Add numa_topology object
>       perf tools: Use sysfs__mountpoint() when reading cpu topology
>       perf session: Don't report zero period samples for slave events
>       perf evsel: Force sample_type for slave events
>       perf script: Allow +- operator for type specific fields option
>       perf bpf-event: Add missing new line into pr_debug call
>       perf cpumap: Increase debug level for cpu_map__snprint verbose output
>       perf tools: Make rm_rf() remove single file
> 
> Jonas Rabenstein (2):
>       perf doc: Fix HEADER_CMDLINE description in perf.data documentation
>       perf doc: Fix documentation of the Flags section in perf.data
> 
> Thomas Richter (1):
>       perf test: Fix failure of 'evsel-tp-sched' test on s390
> 
> Tommi Rantala (1):
>       perf tests shell: Skip trace+probe_vfs_getname.sh if built without trace support
> 
>  tools/perf/Documentation/perf-script.txt           |   6 +
>  tools/perf/Documentation/perf-trace.txt            |   8 +
>  tools/perf/Documentation/perf.data-file-format.txt |  11 +-
>  tools/perf/builtin-script.c                        |   8 +
>  tools/perf/builtin-trace.c                         |  19 ++
>  tools/perf/tests/evsel-tp-sched.c                  |   6 +-
>  tools/perf/tests/shell/lib/probe.sh                |   5 +
>  tools/perf/tests/shell/trace+probe_vfs_getname.sh  |   1 +
>  tools/perf/util/Build                              |   2 +
>  tools/perf/util/bpf-event.c                        |   2 +-
>  tools/perf/util/bpf_map.c                          |  72 ++++++
>  tools/perf/util/bpf_map.h                          |  22 ++
>  tools/perf/util/cpumap.c                           |   2 +-
>  tools/perf/util/cputopo.c                          | 277 +++++++++++++++++++++
>  tools/perf/util/cputopo.h                          |  33 +++
>  tools/perf/util/evsel.c                            |   8 +
>  tools/perf/util/header.c                           | 269 +++-----------------
>  tools/perf/util/session.c                          |   7 +
>  tools/perf/util/sort.c                             |  10 +-
>  tools/perf/util/srcline.c                          |   2 +-
>  tools/perf/util/util.c                             |  16 +-
>  21 files changed, 530 insertions(+), 256 deletions(-)
>  create mode 100644 tools/perf/util/bpf_map.c
>  create mode 100644 tools/perf/util/bpf_map.h
>  create mode 100644 tools/perf/util/cputopo.c
>  create mode 100644 tools/perf/util/cputopo.h

Pulled, thanks a lot Arnaldo!

	Ingo
