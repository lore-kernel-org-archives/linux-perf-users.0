From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 0/7] perf/urgent fixes
Date: Fri, 19 Apr 2019 19:11:48 +0200
Message-ID: <20190419171148.GA115669@gmail.com>
References: <20190419123029.11328-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190419123029.11328-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Bastian Beischer <bastian.beischer@rwth-aachen.de>, Song Liu <songliubraving@fb.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit b24131eb77429f7ac52d5ab5a4313fccff64c411:
> 
>   Merge tag 'perf-urgent-for-mingo-5.1-20190416' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2019-04-16 17:24:14 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.1-20190419
> 
> for you to fetch changes up to 2db7b1e0bd49d2b0e7d16949e167b1cfaf5c07cf:
> 
>   perf bpf: Return NULL when RB tree lookup fails in perf_env__find_btf() (2019-04-17 14:30:23 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> perf top:
> 
>   Jiri Olsa:
> 
>   - Fix 'perf top --pid', it needs PERF_SAMPLE_TIME since we switched to using
>     a different thread to sort the events and then even for just a single
>     thread we now need timestamps.
> 
> BPF:
> 
>   Jiri Olsa:
> 
>   - Fix bpf_prog and btf lookup functions failure path to to properly return
>     NULL.
> 
>   - Fix side band thread draining, used to process PERF_RECORD_BPF_EVENT
>     metadata records.
> 
> core:
> 
>   Jiri Olsa:
> 
>   - Fix map lookup by name to get a refcount when the name is already in
>     the tree. Found
> 
>   Song Liu:
> 
>   - Fix __map__is_kmodule() by taking into account recently added BPF
>     maps.
> 
> UAPI:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Sync sound/asound.h copy
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (1):
>       tools include uapi: Sync sound/asound.h copy
> 
> Jiri Olsa (5):
>       perf top: Always sample time to satisfy needs of use of ordered queuing
>       perf bpf: Return NULL when RB tree lookup fails in perf_env__find_bpf_prog_info()
>       perf evlist: Fix side band thread draining
>       perf tools: Fix map reference counting
>       perf bpf: Return NULL when RB tree lookup fails in perf_env__find_btf()
> 
> Song Liu (1):
>       perf tools: Check maps for bpf programs
> 
>  tools/include/uapi/sound/asound.h |  1 +
>  tools/perf/builtin-top.c          |  1 +
>  tools/perf/util/env.c             |  8 ++++++--
>  tools/perf/util/evlist.c          | 14 +++++++++-----
>  tools/perf/util/map.c             | 20 +++++++++++++++++---
>  tools/perf/util/map.h             |  4 +++-
>  6 files changed, 37 insertions(+), 11 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
