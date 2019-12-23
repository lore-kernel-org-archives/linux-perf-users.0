From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/urgent improvements and fixes
Date: Mon, 23 Dec 2019 22:28:36 +0100
Message-ID: <20191223212836.GA24434@gmail.com>
References: <20191223133241.8578-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191223133241.8578-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Hewenliang <hewenliang4@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, Yuya Fujita <fujita.yuya@fujitsu.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
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
> The following changes since commit 9f0bff1180efc9ea988fed3fd93da7647151ac8b:
> 
>   perf/core: Add SRCU annotation for pmus list walk (2019-12-17 13:32:46 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.5-20191223
> 
> for you to fetch changes up to 55347ec340af401437680fd0e88df6739a967f9f:
> 
>   perf hists: Fix variable name's inconsistency in hists__for_each() macro (2019-12-20 18:58:13 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> perf report/top:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Fix popup menu for entries in main kernel maps other than the main one,
>     e.g. ".init.text", where a non-initialized pointer was causing segfaults.
> 
>   Jin Yao:
> 
>   - Fix incorrectly added dimensions when switching perf.data file to another
>     via the popup menu.
> 
> libtraceevent:
> 
>   Hewenliang:
> 
>   - Fix memory leakage in filter_event().
> 
> perf hists:
> 
>   Yuya Fujita:
> 
>   - Fix variable name's inconsistency in hists__for_each() macro.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (1):
>       perf map: Set kmap->kmaps backpointer for main kernel map chunks
> 
> Hewenliang (1):
>       tools lib traceevent: Fix memory leakage in filter_event
> 
> Jin Yao (1):
>       perf report: Fix incorrectly added dimensions as switch perf data file
> 
> Yuya Fujita (1):
>       perf hists: Fix variable name's inconsistency in hists__for_each() macro
> 
>  tools/lib/traceevent/parse-filter.c | 4 +++-
>  tools/perf/builtin-report.c         | 5 ++++-
>  tools/perf/util/hist.h              | 4 ++--
>  tools/perf/util/symbol-elf.c        | 3 +++
>  4 files changed, 12 insertions(+), 4 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
