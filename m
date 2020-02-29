From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/urgent fixes
Date: Sat, 29 Feb 2020 10:11:59 +0100
Message-ID: <20200229091159.GA92847@gmail.com>
References: <20200228140014.1236-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200228140014.1236-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, He Zhe <zhe.he@windriver.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
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
> The following changes since commit 4c45945aa418f5e2f31cdaf0b1484e146e29f72f:
> 
>   Merge tag 'perf-urgent-for-mingo-5.6-20200220' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2020-02-26 15:18:05 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.6-20200228
> 
> for you to fetch changes up to e0560ba6d92f06dbe13e9d11c921a60c07ea6fcc:
> 
>   perf annotate: Fix segfault with source toggle (2020-02-27 11:47:23 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> perf annotate:
> 
>   Ravi Bangoria:
> 
>   - Fix segfault with source toggle.
> 
>   - Fix --show-total-period and --show-nr-samples for tui/stdio2.
> 
>   - Fix handling of settings in ~/.perfconfig versus the ones passed
>     in the command line
> 
>   - Re-render title bar after switching back from script browser.
> 
>   - Fix options man page, document some missing ones.
> 
> perf probe:
> 
>   He Zhe:
> 
>   - Check return value of strlist__add() for -ENOMEM.
> 
> tools UAPI:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Sync x86's msr-index.h copy with the kernel sources.
> 
>   - Update tools's copy of x86's kvm.h headers.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (2):
>       tools arch x86: Sync the msr-index.h copy with the kernel sources
>       tools headers UAPI: Update tools's copy of kvm.h headers
> 
> He Zhe (1):
>       perf probe: Check return value of strlist__add() for -ENOMEM
> 
> Ravi Bangoria (12):
>       perf annotate/tui: Re-render title bar after switching back from script browser
>       perf annotate: Fix --show-total-period for tui/stdio2
>       perf annotate: Fix --show-nr-samples for tui/stdio2
>       perf config: Introduce perf_config_u8()
>       perf annotate: Make perf config effective
>       perf annotate: Prefer cmdline option over default config
>       perf annotate: Fix perf config option description
>       perf config: Document missing config options
>       perf annotate: Remove privsize from symbol__annotate() args
>       perf annotate: Simplify disasm_line allocation and freeing code
>       perf annotate: Align struct annotate_args
>       perf annotate: Fix segfault with source toggle
> 
>  tools/arch/x86/include/asm/msr-index.h   |   2 +
>  tools/arch/x86/include/uapi/asm/kvm.h    |   1 +
>  tools/perf/Documentation/perf-config.txt |  74 +++++++++++-
>  tools/perf/builtin-annotate.c            |   4 +-
>  tools/perf/builtin-probe.c               |   6 +-
>  tools/perf/builtin-report.c              |   2 +-
>  tools/perf/builtin-top.c                 |   4 +-
>  tools/perf/ui/browsers/annotate.c        |  19 ++-
>  tools/perf/ui/gtk/annotate.c             |   2 +-
>  tools/perf/util/annotate.c               | 194 ++++++++++++-------------------
>  tools/perf/util/annotate.h               |   9 +-
>  tools/perf/util/config.c                 |  12 ++
>  tools/perf/util/config.h                 |   1 +
>  tools/perf/util/probe-file.c             |  28 ++++-
>  14 files changed, 210 insertions(+), 148 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
