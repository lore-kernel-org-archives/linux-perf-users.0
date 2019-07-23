From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/urgent fixes
Date: Tue, 23 Jul 2019 23:42:14 +0200
Message-ID: <20190723214214.GA56614@gmail.com>
References: <20190723200530.14090-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190723200530.14090-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Cong Wang <xiyou.wangcong@gmail.com>, Denis Bakhvalov <denis.bakhvalov@intel.com>, Numfor Mbiziwo-Tiapo <nums@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
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
> The following changes since commit e0c5c5e308ee9b3548844f0d88da937782b895ef:
> 
>   Merge tag 'perf-core-for-mingo-5.3-20190715' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2019-07-18 00:32:52 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.3-20190723
> 
> for you to fetch changes up to 39e7317e37f7f0be366d1201c283f968c17268da:
> 
>   perf build: Do not use -Wshadow on gcc < 4.8 (2019-07-23 09:04:54 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> perf.data:
> 
>   Alexey Budankov:
> 
>   - Fix loading of compressed data split across adjacent records
> 
>   Jiri Olsa:
> 
>   - Fix buffer size setting for processing CPU topology perf.data header.
> 
> perf stat:
> 
>   Jiri Olsa:
> 
>   - Fix segfault for event group in repeat mode
> 
>   Cong Wang:
> 
>   - Always separate "stalled cycles per insn" line, it was being appended to
>     the "instructions" line.
> 
> perf script:
> 
>   Andi Kleen:
> 
>   - Fix --max-blocks man page description.
> 
>   - Improve man page description of metrics.
> 
>   - Fix off by one in brstackinsn IPC computation.
> 
> perf probe:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Avoid calling freeing routine multiple times for same pointer.
> 
> perf build:
> 
>   - Do not use -Wshadow on gcc < 4.8, avoiding too strict warnings
>     treated as errors, breaking the build.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Alexey Budankov (1):
>       perf session: Fix loading of compressed data split across adjacent records
> 
> Andi Kleen (3):
>       perf script: Fix --max-blocks man page description
>       perf script: Improve man page description of metrics
>       perf script: Fix off by one in brstackinsn IPC computation
> 
> Arnaldo Carvalho de Melo (3):
>       perf probe: Set pev->nargs to zero after freeing pev->args entries
>       perf probe: Avoid calling freeing routine multiple times for same pointer
>       perf build: Do not use -Wshadow on gcc < 4.8
> 
> Cong Wang (1):
>       perf stat: Always separate stalled cycles per insn
> 
> Jiri Olsa (2):
>       perf tools: Fix proper buffer size for feature processing
>       perf stat: Fix segfault for event group in repeat mode
> 
>  tools/perf/Documentation/perf-script.txt |  8 ++++----
>  tools/perf/builtin-probe.c               | 10 ++++++++++
>  tools/perf/builtin-script.c              |  2 +-
>  tools/perf/builtin-stat.c                |  9 ++++++++-
>  tools/perf/util/evsel.c                  |  2 ++
>  tools/perf/util/header.c                 |  2 +-
>  tools/perf/util/probe-event.c            |  1 +
>  tools/perf/util/session.c                | 22 ++++++++++++++--------
>  tools/perf/util/session.h                |  1 +
>  tools/perf/util/stat-shadow.c            |  3 ++-
>  tools/perf/util/zstd.c                   |  4 ++--
>  tools/scripts/Makefile.include           |  9 ++++++++-
>  12 files changed, 54 insertions(+), 19 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
