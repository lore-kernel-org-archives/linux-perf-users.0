From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/core improvements and fixes from Budapest
Date: Wed, 5 Feb 2020 08:45:50 +0100
Message-ID: <20200205074550.GA124628@gmail.com>
References: <20200201080330.13211-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200201080330.13211-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Cengiz Can <cengiz@kernel.wtf>, Changbin Du <changbin.du@gmail.com>, Leo Yan <leo.yan@linaro.org>, Thomas Richter <tmricht@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
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
> The following changes since commit 0cc4bd8f70d1ea2940295f1050508c663fe9eff9:
> 
>   Merge branch 'core/kprobes' into perf/core, to pick up fixes (2020-01-28 07:59:05 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.6-20200201
> 
> for you to fetch changes up to 85fc95d75970ee7dd8e01904e7fb1197c275ba6b:
> 
>   perf maps: Add missing unlock to maps__insert() error case (2020-01-31 09:40:50 +0100)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf maps:
> 
>   Cengiz Can:
> 
>   - Add missing unlock to maps__insert() error case.
> 
> srcline:
> 
>   Changbin Du:
> 
>   - Make perf able to build with latest libbfd.
> 
> perf parse:
> 
>   Leo Yan:
> 
>   - Keep copy of string in perf_evsel_config_term() to fix sink terms
>     processing in ARM CoreSight.
> 
> perf test:
> 
>   Thomas Richter:
> 
>   - Fix test case Merge cpu map, removing extra reference count drop that
>     causes a segfault on s/390.
> 
> perf probe:
> 
>   Thomas Richter:
> 
>   - Add ustring support for perf probe command
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Cengiz Can (1):
>       perf maps: Add missing unlock to maps__insert() error case
> 
> Changbin Du (1):
>       perf: Make perf able to build with latest libbfd
> 
> Leo Yan (2):
>       perf parse: Refactor 'struct perf_evsel_config_term'
>       perf parse: Copy string to perf_evsel_config_term
> 
> Thomas Richter (2):
>       perf test: Fix test case Merge cpu map
>       perf probe: Add ustring support for perf probe command
> 
>  tools/perf/arch/arm/util/cs-etm.c |  2 +-
>  tools/perf/tests/cpumap.c         |  1 -
>  tools/perf/util/evsel.c           |  8 +++--
>  tools/perf/util/evsel_config.h    |  5 ++-
>  tools/perf/util/map.c             |  1 +
>  tools/perf/util/parse-events.c    | 67 ++++++++++++++++++++++++++-------------
>  tools/perf/util/probe-finder.c    |  3 +-
>  tools/perf/util/srcline.c         | 16 +++++++++-
>  8 files changed, 71 insertions(+), 32 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
