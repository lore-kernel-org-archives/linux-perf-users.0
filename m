From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [RFC PATCHSET v2] Implement --switch-output-event
Date: Thu, 30 Apr 2020 11:05:06 +0200
Message-ID: <20200430090506.GE1681583@krava>
References: <20200429131106.27974-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200429131106.27974-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <songliubraving@fb.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Apr 29, 2020 at 10:10:58AM -0300, Arnaldo Carvalho de Melo wrote:
> Hi guys,
> 
> 	Please consider reviewing, this addresses comments by Jiri in
> the V1.

small nit posted, but overall looks good

Acked-by: Jiri Olsa <jolsa@redhat.com>

jirka

> 
> 	Again, the example provided is too simple, using 'perf probe' to
> put probes in specific places in some workload to then get any other
> event close to the time the trigger hits comes to mind as well, using
> the signal was just to reuse the pre-existing logic and keep the
> patchkit small.
> 
> 	One other thing that occurred to me while testing is that this
> can be combined with 'perf report/perf script' --switch-off option:
> 
>   $ perf report -h --switch-off
> 
>   Usage: perf report [<options>]
> 
>         --switch-off <event>
>                           Stop considering events after the ocurrence of this event
> 
>   $
> 
> 	To remove from consideration the events that end up being
> recorded in the ring buffer after the --switch-output-event but gets in
> the ring buffer because we process the --switch-output-event
> asynchronously.
> 
>         Its available at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/switch-output-event
> 
> Best regards,
> 
> - Arnaldo
> 
> 
> Arnaldo Carvalho de Melo (8):
>   perf record: Move sb_evlist to 'struct record'
>   perf top: Move sb_evlist to 'struct perf_top'
>   perf bpf: Decouple creating the evlist from adding the SB event
>   perf parse-events: Add parse_events_option() variant that creates evlist
>   perf evlist: Allow reusing the side band thread for more purposes
>   libsubcmd: Introduce OPT_CALLBACK_SET()
>   perf record: Introduce --switch-output-event
>   perf record: Move side band evlist setup to separate routine
> 
>  tools/lib/subcmd/parse-options.h         |  2 +
>  tools/perf/Documentation/perf-record.txt | 13 ++++
>  tools/perf/builtin-record.c              | 75 ++++++++++++++++++++----
>  tools/perf/builtin-top.c                 | 20 +++++--
>  tools/perf/util/bpf-event.c              |  3 +-
>  tools/perf/util/bpf-event.h              |  7 +--
>  tools/perf/util/evlist.c                 | 39 +++++++-----
>  tools/perf/util/evlist.h                 |  3 +-
>  tools/perf/util/parse-events.c           | 23 ++++++++
>  tools/perf/util/parse-events.h           |  1 +
>  tools/perf/util/top.h                    |  2 +-
>  11 files changed, 151 insertions(+), 37 deletions(-)
> 
> -- 
> 2.21.1
> 
