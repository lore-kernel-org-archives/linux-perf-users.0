From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/30] perf/urgent fixes
Date: Tue, 28 Nov 2017 17:20:31 +0100
Message-ID: <20171128162031.lu36zbyg4tjemlah@gmail.com>
References: <20171128150220.5064-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42166 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752229AbdK1QUh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Nov 2017 11:20:37 -0500
Content-Disposition: inline
In-Reply-To: <20171128150220.5064-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Andrei Vagin <avagin@openvz.org>, Balamuruhan S <bala24@linux.vnet.ibm.com>, Bram Stolk <b.stolk@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Christoffer Dall <cdall@linaro.org>, Chris Wilson <chris@chris-wilson.co.uk>, Dan Williams <dan.j.williams@intel.com>, Dave Airlie <airlied@redhat.com>, Dave Martin <Dave.Martin@arm.com>, David Ahern <dsahern@gmail.com>, Donald Stence <dstence@us.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> 
> Hi Ingo,
> 
> 	These are fixes that were sitting in perf/core, together with
> syncronizing tools/include files with the kernel, to have the build
> clean of warnings.
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 1d3b78bbc6e983fabb3fbf91b76339bf66e4a12c:
> 
>   Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2017-11-23 21:18:46 -1000)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.15-20171128
> 
> for you to fetch changes up to 12507d0fc07ce2fa6ccdcdde819f26c4acb0d839:
> 
>   perf tools s390: Do not include header files from the kernel sources (2017-11-28 11:27:55 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> - Fix window dimensions change handling in 'perf top' (Jiri Olsa)
> 
> - Fix 'perf record -c/-F' options for CPU event aliases (Andi Kleen)
> 
> - Generate PERF_RECORD_{MMAP,COMM,EXEC} with 'perf record --delay'
>   fixing symbol resolution for processes created, maps put in place
>   while --delay happens (Arnaldo Carvalho de Melo)
> 
> - Fix up leftover perf_evsel_stat usage via evsel->priv, plugging
>   a SEGV when using event groups as in:
> 
>      $ perf stat -e '{cpu-clock,instructions}' workload
> 
> - Fix 'perf script --per-event-dump' for auxtrace synth evsels (Arnaldo Carvalho de Melo)
> 
> - Ignore kptr_restrict when not sampling the kernel (Arnaldo Carvalho de Melo)
> 
> - Synchronize kernel ABI headers wrt SPDX tags and ABI changes,
>   taking minimal action to handle new syscall args and silencing
>   perf build warnings (Arnaldo Carvalho de Melo, Ingo Molnar)
> 
> - Fix header.size for namespace events (Jiri Olsa)
> 
> - Fix a bug during strstart() conversion in 'perf help' (Namhyung Kim)
> 
> - Do not truncate instruction names at 6 chars in 'perf annotate', there
>   are really long instruction names in PPC (Ravi Bangoria)
> 
> - Fixup discontiguous/sparse numa nodes in 'perf bench numa' (Satheesh Rajendran)
> 
> - Fix an exit code of trace__symbols_init in 'perf trace' (Andrei Vagin)
> 
> - Fix 'perf test' entries on s/390 (Thomas Richter)
> 
> - Bring instruction decoder files used by Intel PT into line with the kernel,
>   silencing build warning (Adrian Hunter)
> 
> - Fix build on s/390 by not using directly kernel perf_regs.h (Arnaldo Carvalho de Melo)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (1):
>       perf intel-pt: Bring instruction decoder files into line with the kernel
> 
> Andi Kleen (1):
>       perf record: Fix -c/-F options for cpu event aliases
> 
> Andrei Vagin (1):
>       perf trace: Fix an exit code of trace__symbols_init
> 
> Arnaldo Carvalho de Melo (17):
>       perf evlist: Set the correct idx when adding dummy events
>       perf record: Generate PERF_RECORD_{MMAP,COMM,EXEC} with --delay
>       perf evsel: Fix up leftover perf_evsel_stat usage via evsel->priv
>       perf script: Fix --per-event-dump for auxtrace synth evsels
>       perf machine: Guard against NULL in machine__exit()
>       perf evlist: Add helper to check if attr.exclude_kernel is set in all evsels
>       perf report: Ignore kptr_restrict when not sampling the kernel
>       perf record: Ignore kptr_restrict when not sampling the kernel
>       perf top: Ignore kptr_restrict when not sampling the kernel
>       tools headers: Synchronize kernel ABI headers wrt SPDX tags
>       tools headers: Synchronize perf_event.h header
>       tools headers uapi: Synchronize drm/drm.h
>       tools headers: Synchronize drm/i915_drm.h
>       tools headers: Synchronize KVM arch ABI headers
>       tools headers: Synchronize prctl.h ABI header
>       tools headers: Syncronize mman.h ABI header
>       perf tools s390: Do not include header files from the kernel sources
> 
> Ingo Molnar (1):
>       tools/headers: Synchronize kernel x86 UAPI headers
> 
> Jiri Olsa (3):
>       perf: Fix header.size for namespace events
>       perf top: Fix window dimensions change handling
>       perf top: Use signal interface for SIGWINCH handler
> 
> Namhyung Kim (1):
>       perf help: Fix a bug during strstart() conversion
> 
> Ravi Bangoria (1):
>       perf annotate: Do not truncate instruction names at 6 chars
> 
> Satheesh Rajendran (1):
>       perf bench numa: Fixup discontiguous/sparse numa nodes
> 
> Thomas Richter (3):
>       perf test shell: Fix check open filename arg using 'perf trace' on s390x
>       perf test shell: Fix test case probe libc's inet_pton on s390x
>       perf test: Fix test 21 for s390x
> 
>  kernel/events/core.c                               |   5 +-
>  tools/arch/arm/include/uapi/asm/kvm.h              |   7 +
>  tools/arch/arm64/include/uapi/asm/kvm.h            |   7 +
>  tools/arch/s390/include/uapi/asm/perf_regs.h       |  43 ++
>  tools/arch/x86/include/asm/cpufeatures.h           | 537 +++++++++++----------
>  tools/arch/x86/include/asm/disabled-features.h     |   8 +-
>  tools/include/uapi/asm-generic/mman.h              |   1 +
>  tools/include/uapi/drm/drm.h                       |  41 ++
>  tools/include/uapi/drm/i915_drm.h                  |  33 +-
>  tools/include/uapi/linux/kcmp.h                    |   1 +
>  tools/include/uapi/linux/kvm.h                     |   1 +
>  tools/include/uapi/linux/perf_event.h              |   1 +
>  tools/include/uapi/linux/prctl.h                   |  10 +
>  tools/perf/arch/s390/include/perf_regs.h           |   2 +-
>  tools/perf/bench/numa.c                            |  56 ++-
>  tools/perf/builtin-help.c                          |   4 +-
>  tools/perf/builtin-record.c                        |  42 +-
>  tools/perf/builtin-report.c                        |   3 +
>  tools/perf/builtin-script.c                        |  31 +-
>  tools/perf/builtin-top.c                           |  36 +-
>  tools/perf/builtin-trace.c                         |   6 +-
>  tools/perf/check-headers.sh                        |   1 +
>  .../perf/tests/shell/trace+probe_libc_inet_pton.sh |   7 +-
>  tools/perf/tests/shell/trace+probe_vfs_getname.sh  |   6 +-
>  tools/perf/tests/task-exit.c                       |   4 +
>  tools/perf/trace/beauty/mmap.c                     |   3 +
>  tools/perf/util/annotate.c                         |  18 +-
>  tools/perf/util/evlist.c                           |  14 +-
>  tools/perf/util/evlist.h                           |   2 +
>  tools/perf/util/evsel.c                            |  14 +-
>  tools/perf/util/evsel.h                            |   1 +
>  tools/perf/util/intel-pt-decoder/inat.h            |  10 +
>  tools/perf/util/machine.c                          |   3 +
>  tools/perf/util/parse-events.c                     |   2 +
>  tools/perf/util/parse-events.h                     |   3 +
>  tools/perf/util/pmu.c                              |   5 +
>  36 files changed, 638 insertions(+), 330 deletions(-)
>  create mode 100644 tools/arch/s390/include/uapi/asm/perf_regs.h

Pulled, thanks a lot Arnaldo!

	Ingo
