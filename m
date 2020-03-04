From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/urgent fixes
Date: Wed, 4 Mar 2020 11:54:46 +0100
Message-ID: <20200304105446.GA105264@gmail.com>
References: <20200303194827.6461-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200303194827.6461-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo/Thomas,
> 
> 	Please consider pulling, mostly from mostly valid complaints by
> the most recent gcc version in my container farm,
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit e0560ba6d92f06dbe13e9d11c921a60c07ea6fcc:
> 
>   perf annotate: Fix segfault with source toggle (2020-02-27 11:47:23 -0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.6-20200303
> 
> for you to fetch changes up to b5c0951860ba98cfe1936b5c0739450875d51451:
> 
>   perf symbols: Don't try to find a vmlinux file when looking for kernel modules (2020-03-03 16:20:01 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> perf symbols:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Don't try to find a vmlinux file when looking for kernel modules,
>     fixing symbol resolution in systems with compressed kernel modules.
> 
> perf env:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Do not return pointers to local variables, fixing valid warning from
>     gcc 10 for corner case that stops the build due to -Werror.
> 
> perf tests:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Make global variable static in the bp_account entry to fix build
>     with gcc 10.
> 
> perf parse-events:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Use asprintf() instead of strncpy() to read tracepoint files, addressing
>     compiler warning that stops the build as we use -Werror.
> 
> perf bench:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Share some global variables to fix build with gcc 10.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (5):
>       perf tests bp_account: Make global variable static
>       perf env: Do not return pointers to local variables
>       perf parse-events: Use asprintf() instead of strncpy() to read tracepoint files
>       perf bench: Share some global variables to fix build with gcc 10
>       perf symbols: Don't try to find a vmlinux file when looking for kernel modules
> 
>  tools/perf/bench/bench.h         |  4 ++++
>  tools/perf/bench/epoll-ctl.c     |  7 +++----
>  tools/perf/bench/epoll-wait.c    | 11 +++++------
>  tools/perf/bench/futex-hash.c    | 12 ++++++------
>  tools/perf/bench/futex-lock-pi.c | 11 +++++------
>  tools/perf/tests/bp_account.c    |  2 +-
>  tools/perf/util/env.c            |  4 ++--
>  tools/perf/util/parse-events.c   | 10 ++--------
>  tools/perf/util/symbol.c         | 13 ++++++-------
>  9 files changed, 34 insertions(+), 40 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
