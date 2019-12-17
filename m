From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 0/9] perf/urgent fixes
Date: Tue, 17 Dec 2019 12:28:50 +0100
Message-ID: <20191217112850.GA72342@gmail.com>
References: <20191216204738.12107-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191216204738.12107-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ed Maste <emaste@freebsd.org>, John Garry <john.garry@huawei.com>, Kajol Jain <kjain@linux.ibm.com>, Mark Rutland <mark.rutland@arm.com>, Michael Petlan <mpetlan@redhat.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Sudipm Mukherjee <sudipm.mukherjee@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
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
> 
> The following changes since commit 761bfc33dd7504de951aa7b9db27a3cc5df1fde6:
> 
>   Merge remote-tracking branch 'torvalds/master' into perf/urgent (2019-12-11 09:58:16 -0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.5-20191216
> 
> for you to fetch changes up to 58b3bafff8257c6946df5d6aeb215b8ac839ed2a:
> 
>   perf vendor events s390: Remove name from L1D_RO_EXCL_WRITES description (2019-12-16 13:40:26 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> perf top:
> 
>  Arnaldo Carvalho de Melo:
> 
>  - Do not bail out when perf_env__read_cpuid() returns ENOSYS, which
>    has been reported happening on aarch64.
> 
> perf metricgroup:
> 
>   Kajol Jain:
> 
>   - Fix printing event names of metric group with multiple events
> 
> vendor events:
> 
> x86:
> 
>   Ravi Bangoria:
> 
>   - Fix Kernel_Utilization metric.
> 
> s390:
> 
>   Ed Maste:
> 
>   - Fix counter long description for DTLB1_GPAGE_WRITES and L1D_RO_EXCL_WRITES.
> 
> perf header:
> 
>   Michael Petlan:
> 
>   - Fix false warning when there are no duplicate cache entries
> 
> libtraceevent:
> 
>   Sudip Mukherjee:
> 
>   - Allow custom libdir path
> 
> API headers:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Sync linux/kvm.h with the kernel sources.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (3):
>       tools headers kvm: Sync linux/kvm.h with the kernel sources
>       perf arch: Make the default get_cpuid() return compatible error
>       perf top: Do not bail out when perf_env__read_cpuid() returns ENOSYS
> 
> Ed Maste (2):
>       perf vendor events s390: Fix counter long description for DTLB1_GPAGE_WRITES
>       perf vendor events s390: Remove name from L1D_RO_EXCL_WRITES description
> 
> Kajol Jain (1):
>       perf metricgroup: Fix printing event names of metric group with multiple events
> 
> Michael Petlan (1):
>       perf header: Fix false warning when there are no duplicate cache entries
> 
> Ravi Bangoria (1):
>       perf/x86/pmu-events: Fix Kernel_Utilization metric
> 
> Sudip Mukherjee (1):
>       libtraceevent: Allow custom libdir path
> 
>  tools/include/uapi/linux/kvm.h                     |  1 +
>  tools/lib/traceevent/Makefile                      |  5 +++--
>  tools/lib/traceevent/plugins/Makefile              |  5 +++--
>  tools/perf/builtin-top.c                           | 10 +++++++---
>  .../perf/pmu-events/arch/s390/cf_z13/extended.json |  2 +-
>  .../perf/pmu-events/arch/s390/cf_z14/extended.json |  2 +-
>  .../pmu-events/arch/x86/broadwell/bdw-metrics.json |  2 +-
>  .../arch/x86/broadwellde/bdwde-metrics.json        |  2 +-
>  .../arch/x86/broadwellx/bdx-metrics.json           |  2 +-
>  .../arch/x86/cascadelakex/clx-metrics.json         |  2 +-
>  .../pmu-events/arch/x86/haswell/hsw-metrics.json   |  2 +-
>  .../pmu-events/arch/x86/haswellx/hsx-metrics.json  |  2 +-
>  .../pmu-events/arch/x86/ivybridge/ivb-metrics.json |  2 +-
>  .../pmu-events/arch/x86/ivytown/ivt-metrics.json   |  2 +-
>  .../pmu-events/arch/x86/jaketown/jkt-metrics.json  |  2 +-
>  .../arch/x86/sandybridge/snb-metrics.json          |  2 +-
>  .../pmu-events/arch/x86/skylake/skl-metrics.json   |  2 +-
>  .../pmu-events/arch/x86/skylakex/skx-metrics.json  |  2 +-
>  tools/perf/util/header.c                           | 23 +++++++---------------
>  tools/perf/util/metricgroup.c                      |  7 +++++--
>  20 files changed, 40 insertions(+), 39 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
