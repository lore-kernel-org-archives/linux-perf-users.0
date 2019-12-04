From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Date: Wed, 4 Dec 2019 08:51:34 +0100
Message-ID: <20191204075134.GA29770@gmail.com>
References: <20191203135606.24902-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191203135606.24902-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Ian Rogers <irogers@google.com>, Sudipm Mukherjee <sudipm.mukherjee@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
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
> The following changes since commit e680a41fcaf07ccac8817c589fc4824988b48eac:
> 
>   Merge tag 'perf-core-for-mingo-5.5-20191128' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2019-11-29 06:56:05 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.5-20191203
> 
> for you to fetch changes up to 15b3904f8e884e0d34d5f09906cf6526d0b889a2:
> 
>   libtraceevent: Copy pkg-config file to output folder when using O= (2019-12-02 21:58:20 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf report/top:
> 
>   - Fix segfault due to missing initialization of recently introduced
>     struct map_symbol 'maps' field in append_inlines(), when running
>     with DWARF callchains.
> 
> perf stat:
> 
>   Andi Kleen:
> 
>   - Affinity based optimizations for sessions with many events in
>     machines with large core counts, avoiding excessive number of IPIs.
> 
> libtraceevent:
> 
>   - Sudip Mukherjee:
> 
>   - Fix installation with O=.
> 
>   - Copy pkg-config file to output folder when using O=.
> 
> perf bench:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Update the copies of x86's mem{cpy,set}_64.S, and because that
>     now uses new stuff in linux/linkage.h, update that header too, which
>     made the minimal clang version to build perf to be 3.5, as
>     3.4 as found in some of the container images used to test build perf
>     can't grok STT_FUNC as a token in .type lines.
> 
> ABI headers:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Sync x86's msr-index.h copy with the kernel sources, resulting
>     in new MSRs to be usable in filter expressions in 'perf trace',
>     such as IA32_TSX_CTRL.
> 
>   - Sync linux/fscrypt.h, linux/stat.h, sched.h and the kvm headers.
> 
> perf trace:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Add CLEAR_SIGHAND support for clone's flags arg
> 
> perf kvm:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Clarify the 'perf kvm' -i and -o command line options
> 
> perf test:
> 
>   Ian Rogers:
> 
>   - Move test functionality in to a 'perf test' entry.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Andi Kleen (10):
>       perf cpumap: Maintain cpumaps ordered and without dups
>       perf evlist: Maintain evlist->all_cpus
>       perf evsel: Add iterator to iterate over events ordered by CPU
>       perf evsel: Add functions to close evsel on a CPU
>       perf stat: Use affinity for closing file descriptors
>       perf stat: Factor out open error handling
>       perf stat: Use affinity for opening events
>       perf stat: Use affinity for reading
>       perf evsel: Add functions to enable/disable for a specific CPU
>       perf stat: Use affinity for enabling/disabling events
> 
> Arnaldo Carvalho de Melo (10):
>       perf machine: Fill map_symbol->maps in append_inlines() to fix segfault
>       perf bench: Update the copies of x86's mem{cpy,set}_64.S
>       tools arch x86: Sync the msr-index.h copy with the kernel sources
>       tools headers uapi: Sync linux/fscrypt.h with the kernel sources
>       tools headers uapi: Sync linux/stat.h with the kernel sources
>       tools headers kvm: Sync kvm headers with the kernel sources
>       tools headers UAPI: Sync sched.h with the kernel
>       perf beauty: Add CLEAR_SIGHAND support for clone's flags arg
>       tools arch x86: Sync asm/cpufeatures.h with the kernel sources
>       perf kvm: Clarify the 'perf kvm' -i and -o command line options
> 
> Ian Rogers (1):
>       perf jit: Move test functionality in to a test
> 
> Sudip Mukherjee (2):
>       libtraceevent: Fix lib installation with O=
>       libtraceevent: Copy pkg-config file to output folder when using O=
> 
>  tools/arch/arm/include/uapi/asm/kvm.h     |   3 +-
>  tools/arch/arm64/include/uapi/asm/kvm.h   |   5 +-
>  tools/arch/powerpc/include/uapi/asm/kvm.h |   3 +
>  tools/arch/x86/include/asm/cpufeatures.h  |   3 +
>  tools/arch/x86/include/asm/msr-index.h    |  18 ++
>  tools/arch/x86/lib/memcpy_64.S            |  20 +--
>  tools/arch/x86/lib/memset_64.S            |  16 +-
>  tools/include/uapi/linux/fscrypt.h        |   3 +-
>  tools/include/uapi/linux/kvm.h            |  11 ++
>  tools/include/uapi/linux/sched.h          |  60 +++++--
>  tools/include/uapi/linux/stat.h           |   2 +-
>  tools/lib/traceevent/Makefile             |   6 +-
>  tools/perf/Documentation/perf-kvm.txt     |   5 +-
>  tools/perf/arch/arm/tests/regs_load.S     |   4 +-
>  tools/perf/arch/arm64/tests/regs_load.S   |   4 +-
>  tools/perf/arch/x86/tests/regs_load.S     |   8 +-
>  tools/perf/builtin-record.c               |   2 +-
>  tools/perf/builtin-stat.c                 | 288 +++++++++++++++++++++---------
>  tools/perf/check-headers.sh               |   4 +-
>  tools/perf/lib/cpumap.c                   |  73 +++++++-
>  tools/perf/lib/evlist.c                   |   1 +
>  tools/perf/lib/evsel.c                    |  76 ++++++--
>  tools/perf/lib/include/internal/evlist.h  |   1 +
>  tools/perf/lib/include/perf/cpumap.h      |   2 +
>  tools/perf/lib/include/perf/evsel.h       |   3 +
>  tools/perf/tests/Build                    |   1 +
>  tools/perf/tests/builtin-test.c           |   9 +
>  tools/perf/tests/cpumap.c                 |  16 ++
>  tools/perf/tests/event-times.c            |   4 +-
>  tools/perf/tests/genelf.c                 |  51 ++++++
>  tools/perf/tests/tests.h                  |   2 +
>  tools/perf/trace/beauty/clone.c           |   1 +
>  tools/perf/util/cpumap.h                  |   1 +
>  tools/perf/util/evlist.c                  | 113 +++++++++++-
>  tools/perf/util/evlist.h                  |  11 +-
>  tools/perf/util/evsel.c                   |  35 +++-
>  tools/perf/util/evsel.h                   |   9 +-
>  tools/perf/util/genelf.c                  |  46 -----
>  tools/perf/util/include/linux/linkage.h   |  89 ++++++++-
>  tools/perf/util/machine.c                 |   1 +
>  tools/perf/util/stat.c                    |   5 +-
>  tools/perf/util/stat.h                    |   3 +-
>  42 files changed, 789 insertions(+), 229 deletions(-)
>  create mode 100644 tools/perf/tests/genelf.c

Pulled, thanks a lot Arnaldo!

	Ingo
