From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/urgent improvements and fixes
Date: Mon, 7 Oct 2019 15:16:55 +0200
Message-ID: <20191007131655.GA78239@gmail.com>
References: <20191001111216.7208-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191001111216.7208-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Brian Robbins <brianrob@microsoft.com>, Ian Rogers <irogers@google.com>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, Steve MacLean <Steve.MacLean@Microsoft.com>, Thomas Richter <tmricht@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo/Thomas,
> 
> 	Please consider pulling, mostly small fixes, just one extra
> header copied due to linux/fs.h now having parts of it moved to
> linux/fscrypt.h that then needs syncing so that tooling continues to
> build on older systems.
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit da05b5ea12c1e50b2988a63470d6b69434796f8b:
> 
>   Merge branch 'timers-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2019-09-26 15:53:17 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.4-20191001
> 
> for you to fetch changes up to 11aad897f6d1a28eae3b7e5b293647c522d65819:
> 
>   perf annotate: Don't return -1 for error when doing BPF disassembly (2019-09-30 17:30:06 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> perf script:
> 
>   Andi Kleen:
> 
>     - Fix recovery from LBR/binary mismatch in the "brstackinsn" --field.
> 
> perf annotate:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Propagate errors so that meaningful messages can be presented to the
>     user in case of problems.
> 
> perf map:
> 
>   Steve MacLean:
> 
>   - Fix handling of maps partially overlapped, resolving symbols in the
>     ranges not replaced by new mmaps.
> 
> perf tests:
> 
>   Ian Rogers:
> 
>   - Use raise() instead of NULL derefs to avoid causing a SIGILL rather than a
>     SIGSEGV for optimized builds that turn NULL derefs into ud2 instructions.
> 
> perf LLVM:
> 
>   Ian Rogers:
> 
>   - Don't access out-of-scope array.
> 
> perf inject:
> 
>   Steve MacLean:
> 
>   - Fix JIT_CODE_MOVE filename, that was having a u64 truncaded into a 32-bit
>     snprintf format and also a missing ".so" suffix in another case.
> 
> libsubcmd:
> 
>   Ian Rogers:
> 
>   - Make _FORTIFY_SOURCE defines dependent on the feature, avoiding
>     false positives with with memory sanitizers such as LLVM's ASan.
> 
> Vendor specific events:
> 
> Intel:
> 
>   Andi Kleen:
> 
>   - Fix period for Intel fixed counters.
> 
> s390:
> 
>   Thomas Richter (2):
> 
>   - Fix some event details transaction for machine type 8561.
> 
> tools headers UAPI:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Sync headers with the kernel, catching new usbdevfs ioctls and
>     madvise behaviours to properly decode in 'perf trace' output.
> 
> Documentation:
> 
>   Steve MacLean:
> 
>   - Correct and clarify jitdump spec.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Andi Kleen (2):
>       perf script brstackinsn: Fix recovery from LBR/binary mismatch
>       perf jevents: Fix period for Intel fixed counters
> 
> Arnaldo Carvalho de Melo (13):
>       tools headers uapi: Sync drm/i915_drm.h with the kernel sources
>       tools headers uapi: Sync asm-generic/mman-common.h with the kernel
>       tools headers uapi: Sync linux/usbdevice_fs.h with the kernel sources
>       tools headers uapi: Sync linux/fs.h with the kernel sources
>       tools headers kvm: Sync kvm headers with the kernel sources
>       perf tools: Propagate get_cpuid() error
>       perf evsel: Fall back to global 'perf_env' in perf_evsel__env()
>       perf annotate: Propagate perf_env__arch() error
>       perf annotate: Fix the signedness of failure returns
>       perf annotate: Propagate the symbol__annotate() error return
>       perf annotate: Fix arch specific ->init() failure errors
>       perf annotate: Return appropriate error code for allocation failures
>       perf annotate: Don't return -1 for error when doing BPF disassembly
> 
> Ian Rogers (4):
>       libsubcmd: Make _FORTIFY_SOURCE defines dependent on the feature
>       perf tests: Avoid raising SEGV using an obvious NULL dereference
>       perf docs: Allow man page date to be specified
>       perf llvm: Don't access out-of-scope array
> 
> Steve MacLean (3):
>       perf map: Fix overlapped map handling
>       perf inject jit: Fix JIT_CODE_MOVE filename
>       perf docs: Correct and clarify jitdump spec
> 
> Thomas Richter (2):
>       perf vendor events s390: Add JSON transaction for machine type 8561
>       perf vendor events s390: Use s390 machine name instead of type 8561
> 
>  tools/arch/arm/include/uapi/asm/kvm.h              |   4 +-
>  tools/arch/arm64/include/uapi/asm/kvm.h            |   4 +-
>  tools/arch/s390/include/uapi/asm/kvm.h             |   6 +
>  tools/arch/x86/include/uapi/asm/vmx.h              |   2 +
>  tools/include/uapi/asm-generic/mman-common.h       |   3 +
>  tools/include/uapi/drm/i915_drm.h                  |   1 +
>  tools/include/uapi/linux/fs.h                      |  55 +------
>  tools/include/uapi/linux/fscrypt.h                 | 181 +++++++++++++++++++++
>  tools/include/uapi/linux/kvm.h                     |   3 +
>  tools/include/uapi/linux/usbdevice_fs.h            |   4 +
>  tools/lib/subcmd/Makefile                          |   8 +-
>  tools/perf/Documentation/asciidoc.conf             |   3 +
>  tools/perf/Documentation/jitdump-specification.txt |   4 +-
>  tools/perf/arch/arm/annotate/instructions.c        |   4 +-
>  tools/perf/arch/arm64/annotate/instructions.c      |   4 +-
>  tools/perf/arch/powerpc/util/header.c              |   3 +-
>  tools/perf/arch/s390/annotate/instructions.c       |   6 +-
>  tools/perf/arch/s390/util/header.c                 |   9 +-
>  tools/perf/arch/x86/annotate/instructions.c        |   6 +-
>  tools/perf/arch/x86/util/header.c                  |   3 +-
>  tools/perf/builtin-kvm.c                           |   7 +-
>  tools/perf/builtin-script.c                        |   6 +-
>  tools/perf/check-headers.sh                        |   1 +
>  .../arch/s390/{cf_m8561 => cf_z15}/basic.json      |   0
>  .../arch/s390/{cf_m8561 => cf_z15}/crypto.json     |   0
>  .../arch/s390/{cf_m8561 => cf_z15}/crypto6.json    |   0
>  .../arch/s390/{cf_m8561 => cf_z15}/extended.json   |   0
>  .../pmu-events/arch/s390/cf_z15/transaction.json   |   7 +
>  tools/perf/pmu-events/arch/s390/mapfile.csv        |   2 +-
>  tools/perf/pmu-events/jevents.c                    |  12 +-
>  tools/perf/tests/perf-hooks.c                      |   3 +-
>  tools/perf/util/annotate.c                         |  35 +++-
>  tools/perf/util/annotate.h                         |   4 +
>  tools/perf/util/evsel.c                            |   3 +-
>  tools/perf/util/jitdump.c                          |   6 +-
>  tools/perf/util/llvm-utils.c                       |   6 +-
>  tools/perf/util/map.c                              |   3 +
>  tools/perf/util/python.c                           |   6 +
>  38 files changed, 315 insertions(+), 99 deletions(-)
>  create mode 100644 tools/include/uapi/linux/fscrypt.h
>  rename tools/perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/basic.json (100%)
>  rename tools/perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/crypto.json (100%)
>  rename tools/perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/crypto6.json (100%)
>  rename tools/perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/extended.json (100%)
>  create mode 100644 tools/perf/pmu-events/arch/s390/cf_z15/transaction.json

Pulled, thanks a lot Arnaldo!

	Ingo
