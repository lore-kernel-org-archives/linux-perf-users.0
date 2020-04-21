From: Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf record: add dummy event during system wide synthesis
Date: Mon, 20 Apr 2020 23:17:12 -0700
Message-ID: <CAP-5=fWMm+Bvuja8wLS4fSAxx5AVchKBGZ96KKc0sb0sze6x3Q@mail.gmail.com>
References: <20200416004713.192740-1-irogers@google.com> <20200420083720.GB718574@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200420083720.GB718574@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

On Mon, Apr 20, 2020 at 1:44 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Apr 15, 2020 at 05:47:13PM -0700, Ian Rogers wrote:
> > During the processing of /proc during event synthesis new processes may
> > start. Add a dummy event if /proc is to be processed, to capture mmaps
> > for starting processes. This reuses the existing logic for
> > initial-delay.
> >
> > Suggested-by: Stephane Eranian <eranian@google.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-record.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 1ab349abe904..bab4fc8568d1 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -805,16 +805,18 @@ static int record__open(struct record *rec)
> >       int rc = 0;
> >
> >       /*
> > -      * For initial_delay we need to add a dummy event so that we can track
> > -      * PERF_RECORD_MMAP while we wait for the initial delay to enable the
> > -      * real events, the ones asked by the user.
> > +      * For initial_delay or system wide, we need to add a dummy event so
> > +      * that we can track PERF_RECORD_MMAP to cover the delay (of waiting or
> > +      * synthesis) prior to the real user events being enabled.
> >        */
> > -     if (opts->initial_delay) {
> > +     if (opts->initial_delay || target__has_cpu(&opts->target)) {
>
> hum, how this works for system wide? IIRC the delay works
> for monitoring tasks by setting dummy with enable_on_exec,
> and enabling the rest by ioctl after the delay.. so without
> the monitored task there's no enable_on_exec effect

Thanks! I sent a 2nd version that makes the comments actually agree
with the code :-)
https://lore.kernel.org/lkml/20200421061103.109440-1-irogers@google.com/

Ian

> jirka
>
> >               if (perf_evlist__add_dummy(evlist))
> >                       return -ENOMEM;
> >
> > +             /* Disable tracking of mmaps on lead event. */
> >               pos = evlist__first(evlist);
> >               pos->tracking = 0;
> > +             /* Activate dummy event immediately. */
> >               pos = evlist__last(evlist);
> >               pos->tracking = 1;
> >               pos->core.attr.enable_on_exec = 1;
> > --
> > 2.26.0.110.g2183baf09c-goog
> >
>
