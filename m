From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/urgent fixes
Date: Thu, 19 Mar 2020 15:00:03 +0100
Message-ID: <20200319140003.GA52834@gmail.com>
References: <20200309185323.22583-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200309185323.22583-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>, disconnect3d <dominik.b.czarnota@gmail.com>, He Zhe <zhe.he@windriver.com>, Ian Rogers <irogers@google.com>, Ilie Halip <ilie.halip@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
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
> The following changes since commit 441b62acd9c809e87bab45ad1d82b1b3b77cb4f0:
> 
>   tools: Fix off-by 1 relative directory includes (2020-03-06 08:36:46 -0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.6-20200309
> 
> for you to fetch changes up to 1efde2754275dbd9d11c6e0132a4f09facf297ab:
> 
>   perf probe: Do not depend on dwfl_module_addrsym() (2020-03-09 10:43:53 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> perf probe:
> 
>   Masami Hiramatsu:
> 
>   - Fix deletion of multiple probe events.
> 
>   - Fix userspace libraries handling by not depending on dwfl_module_addrsym().
> 
> Event parsing:
> 
>   Ian Rogers:
> 
>   - Fix reading of invalid memory in event parsing.
> 
> python binding:
> 
>   Ilie Halip:
> 
>   - Fix clang detection when using CC=clang-version.
> 
> build:
> 
>   Masami Hiramatsu:
> 
>   - Fix O= use with relative paths.
> 
> Android:
> 
>   Dominik b. Czarnota:
> 
>   - Fix off by one in strncpy() size argument when handling Android
>     libraries.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Ian Rogers (1):
>       perf parse-events: Fix reading of invalid memory in event parsing
> 
> Ilie Halip (1):
>       perf python: Fix clang detection when using CC=clang-version
> 
> Masami Hiramatsu (3):
>       tools: Let O= makes handle a relative path with -C option
>       perf probe: Fix to delete multiple probe event
>       perf probe: Do not depend on dwfl_module_addrsym()
> 
> disconnect3d (1):
>       perf map: Fix off by one in strncpy() size argument
> 
>  tools/perf/Makefile            |  2 +-
>  tools/perf/util/map.c          |  2 +-
>  tools/perf/util/parse-events.c | 46 +++++++++++++++++++++---------------------
>  tools/perf/util/probe-file.c   |  3 +++
>  tools/perf/util/probe-finder.c | 11 +++++++---
>  tools/perf/util/setup.py       | 10 +++++----
>  tools/scripts/Makefile.include |  4 ++--
>  7 files changed, 44 insertions(+), 34 deletions(-)

Pulled into tip:perf/urgent, thanks Arnaldo!

	Ingo
