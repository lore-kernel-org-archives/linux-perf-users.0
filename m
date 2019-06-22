From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Date: Sat, 22 Jun 2019 08:28:59 +0200
Message-ID: <20190622062859.GA39787@gmail.com>
References: <20190621173831.13780-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190621173831.13780-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Florian Fainelli <f.fainelli@gmail.com>, John Garry <john.garry@huawei.com>, Laura Abbott <labbott@redhat.com>, Leo Yan <leo.yan@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Raphael Gault <raphael.gault@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 3ce5aceb5dee298b082adfa2baa0df5a447c1b0b:
> 
>   Merge tag 'perf-core-for-mingo-5.3-20190611' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2019-06-17 20:48:14 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.3-20190621
> 
> for you to fetch changes up to 3469fa84c1631face938efc42b3f488a2c2504e0:
> 
>   tools build: Fix the zstd test in the test-all.c common case feature test (2019-06-18 18:44:24 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf trace:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Fix exclusion of not available syscall names from selector list.
> 
>   - Fixup pointer arithmetic when consuming augmented syscall args.
> 
> Intel PT:
> 
>   Adrian Hunter:
> 
>   - Add support for decoding PEBS via PT packets. See:
> 
>       https://software.intel.com/en-us/articles/intel-sdm
>       May 2019 version: Vol. 3B 18.5.5.2 PEBS output to Intel® Processor Trace
> 
>   for more details about it.
> 
> ARM64:
> 
>   John Garry:
> 
>   - Fix uncore PMU alias list for ARM64
> 
>   Raphael Gault:
> 
>   - Compile tests unconditionally.
> 
> cs-etm:
> 
>   Mathieu Poirier:
> 
>   - Optimize option setup for CPU-wide sessions.
> 
> build:
> 
>   Florian Fainelli:
> 
>   - Don't hardcode host include path for libslang, fixing up building with it
>     in cross build environments.
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Check if gettid() is available before providing helper, fixing the build
>     when using the latest glibc version, where a helper for gettid() is finally
>     present.
> 
>   - Fix building with libslang in systems where it is located in slang/slang.h.
> 
>   - Fix fast path test for zstd library.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (11):
>       perf intel-pt: Add new packets for PEBS via PT
>       perf intel-pt: Add Intel PT packet decoder test
>       perf intel-pt: Add decoder support for PEBS via PT
>       perf intel-pt: Prepare to synthesize PEBS samples
>       perf intel-pt: Factor out common sample preparation for re-use
>       perf intel-pt: Synthesize PEBS sample basic information
>       perf intel-pt: Add gp registers to synthesized PEBS sample
>       perf intel-pt: Add XMM registers to synthesized PEBS sample
>       perf intel-pt: Add LBR information to synthesized PEBS sample
>       perf intel-pt: Add memory information to synthesized PEBS sample
>       perf intel-pt: Add callchain to synthesized PEBS sample
> 
> Arnaldo Carvalho de Melo (10):
>       tools build: Check if gettid() is available before providing helper
>       perf trace: Fix exclusion of not available syscall names from selector list
>       perf trace: Streamline validation of select syscall names list
>       tools build feature tests: Add missing SPDX headers
>       perf tests: Add missing SPDX headers
>       perf trace: Fixup pointer arithmetic when consuming augmented syscall args
>       perf evsel: Make perf_evsel__name() accept a NULL argument
>       tools build: Add test to check if slang.h is in /usr/include/slang/
>       perf build: Handle slang being in /usr/include and in /usr/include/slang/
>       tools build: Fix the zstd test in the test-all.c common case feature test
> 
> Florian Fainelli (1):
>       perf tools: Don't hardcode host include path for libslang
> 
> John Garry (1):
>       perf pmu: Fix uncore PMU alias list for ARM64
> 
> Mathieu Poirier (1):
>       perf: cs-etm: Optimize option setup for CPU-wide sessions
> 
> Raphael Gault (1):
>       perf tests arm64: Compile tests unconditionally
> 
>  tools/build/Makefile.feature                       |   3 +-
>  tools/build/feature/Makefile                       |  10 +-
>  tools/build/feature/test-all.c                     |   7 +-
>  tools/build/feature/test-fortify-source.c          |   1 +
>  tools/build/feature/test-gettid.c                  |  11 +
>  tools/build/feature/test-hello.c                   |   1 +
>  tools/build/feature/test-libslang-include-subdir.c |   7 +
>  tools/build/feature/test-setns.c                   |   1 +
>  tools/perf/Makefile.config                         |  16 +-
>  tools/perf/arch/arm/util/cs-etm.c                  |  20 +-
>  tools/perf/arch/arm64/Build                        |   2 +-
>  tools/perf/arch/arm64/tests/Build                  |   2 +-
>  tools/perf/arch/x86/include/arch-tests.h           |   1 +
>  tools/perf/arch/x86/tests/Build                    |   2 +-
>  tools/perf/arch/x86/tests/arch-tests.c             |   4 +
>  .../arch/x86/tests/intel-pt-pkt-decoder-test.c     | 304 +++++++++++++++++++++
>  tools/perf/builtin-trace.c                         |  20 +-
>  tools/perf/jvmti/jvmti_agent.c                     |   2 +
>  tools/perf/tests/Build                             |   2 +
>  tools/perf/tests/bp_account.c                      |   1 +
>  tools/perf/tests/bpf-script-example.c              |   1 +
>  tools/perf/tests/bpf-script-test-kbuild.c          |   1 +
>  tools/perf/tests/bpf-script-test-prologue.c        |   1 +
>  tools/perf/tests/bpf-script-test-relocation.c      |   1 +
>  tools/perf/tests/bpf.c                             |   1 +
>  tools/perf/tests/map_groups.c                      |   1 +
>  tools/perf/tests/mem.c                             |   1 +
>  tools/perf/tests/mem2node.c                        |   1 +
>  tools/perf/tests/shell/lib/probe.sh                |   1 +
>  tools/perf/tests/shell/probe_vfs_getname.sh        |   3 +-
>  .../tests/shell/record+probe_libc_inet_pton.sh     |   1 +
>  .../tests/shell/record+script_probe_vfs_getname.sh |   1 +
>  tools/perf/tests/shell/record+zstd_comp_decomp.sh  |   2 +
>  tools/perf/tests/shell/trace+probe_vfs_getname.sh  |   1 +
>  tools/perf/ui/libslang.h                           |   5 +
>  tools/perf/util/evsel.c                            |   8 +-
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 114 +++++++-
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.h  | 137 ++++++++++
>  .../util/intel-pt-decoder/intel-pt-pkt-decoder.c   | 140 +++++++++-
>  .../util/intel-pt-decoder/intel-pt-pkt-decoder.h   |  21 +-
>  tools/perf/util/intel-pt.c                         | 296 +++++++++++++++++++-
>  tools/perf/util/pmu.c                              |  28 +-
>  42 files changed, 1115 insertions(+), 68 deletions(-)
>  create mode 100644 tools/build/feature/test-gettid.c
>  create mode 100644 tools/build/feature/test-libslang-include-subdir.c
>  create mode 100644 tools/perf/arch/x86/tests/intel-pt-pkt-decoder-test.c

Pulled, thanks a lot Arnaldo!

	Ingo
