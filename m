From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/urgent improvements and fixes
Date: Wed, 26 Feb 2020 15:19:07 +0100
Message-ID: <20200226141907.GA3100@gmail.com>
References: <20200221015310.16914-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200221015310.16914-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@linaro.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Thomas Richter <tmricht@linux.ibm.com>, Wei Li <liwei391@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
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
> The following changes since commit b1da3acc781ce445445d959b41064d209a27bc2d:
> 
>   Merge tag 'ecryptfs-5.6-rc3-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs (2020-02-17 21:08:37 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.6-20200220
> 
> for you to fetch changes up to b103de53e09f20d645eb313477f52d1993347605:
> 
>   perf arch powerpc: Sync powerpc syscall.tbl with the kernel sources (2020-02-18 13:36:57 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> auxtrace:
> 
>   Adrian Hunter:
> 
>   - Fix endless record after being terminated on arm-spe.
> 
>   Wei Li:
> 
>   - Fix endless record after being terminated on Intel PT and BTS and
>     on ARM's cs-etm.
> 
> perf test:
> 
>   Thomas Richter
> 
>   - Fix test trace+probe_vfs_getname.sh on s390
> 
> PowerPC:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Sync powerpc syscall.tbl with the kernel sources.
> 
> BPF:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Remove extraneous bpf/ subdir from bpf.h headers used to build bpf events.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (2):
>       perf arm-spe: Fix endless record after being terminated
>       perf auxtrace: Add auxtrace_record__read_finish()
> 
> Arnaldo Carvalho de Melo (2):
>       perf bpf: Remove bpf/ subdir from bpf.h headers used to build bpf events
>       perf arch powerpc: Sync powerpc syscall.tbl with the kernel sources
> 
> Thomas Richter (1):
>       perf test: Fix test trace+probe_vfs_getname.sh on s390
> 
> Wei Li (3):
>       perf intel-pt: Fix endless record after being terminated
>       perf intel-bts: Fix endless record after being terminated
>       perf cs-etm: Fix endless record after being terminated
> 
>  tools/perf/arch/arm/util/cs-etm.c                  | 18 ++----------------
>  tools/perf/arch/arm64/util/arm-spe.c               | 17 ++---------------
>  tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |  2 ++
>  tools/perf/arch/x86/util/intel-bts.c               | 17 ++---------------
>  tools/perf/arch/x86/util/intel-pt.c                | 17 ++---------------
>  tools/perf/include/bpf/pid_filter.h                |  2 +-
>  tools/perf/include/bpf/stdio.h                     |  2 +-
>  tools/perf/include/bpf/unistd.h                    |  2 +-
>  tools/perf/tests/shell/lib/probe_vfs_getname.sh    |  2 +-
>  tools/perf/util/auxtrace.c                         | 22 +++++++++++++++++++++-
>  tools/perf/util/auxtrace.h                         |  6 ++++++
>  11 files changed, 41 insertions(+), 66 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
