From: Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v3] perf record: add dummy event during system wide synthesis
Date: Tue, 19 May 2020 22:59:42 -0700
Message-ID: <CAP-5=fVLgsQxutNOEmKfCs6W=hx1ABHtVVhhxiA3GpAs9S049Q@mail.gmail.com>
References: <20200422173615.59436-1-irogers@google.com> <20200520015435.GB32678@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200520015435.GB32678@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

On Tue, May 19, 2020 at 6:54 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Wed, Apr 22, 2020 at 10:36:15AM -0700, Ian Rogers escreveu:
> > During the processing of /proc during event synthesis new processes may
> > start. Add a dummy event if /proc is to be processed, to capture mmaps
> > for starting processes. This reuses the existing logic for
> > initial-delay.
> >
> > v3 fixes the attr test of test-record-C0
> > v2 fixes the dummy event configuration and a branch stack issue.
>
> Something I noticed only now is that this ends up in the perf.data file,
> and we don't need it at all there, i.e.
>
>   # perf record -I
>
> I.e. system wide, asking for registers now ends up with:
>
> [root@quaco ~]# perf record -I
> ^C[ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 2.855 MB perf.data (4902 samples) ]
> [root@quaco ~]# perf evlist
> cycles
> dummy:HG
> [root@quaco ~]# perf evlist -v
> cycles: size: 120, { sample_period, sample_freq }: 4000, sample_type: IP|=
TID|TIME|ID|CPU|PERIOD|REGS_INTR, read_format: ID, disabled: 1, inherit: 1,=
 freq: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1, sample_regs_in=
tr: 0xff0fff
> dummy:HG: type: 1, size: 120, config: 0x9, { sample_period, sample_freq }=
: 4000, sample_type: IP|TID|TIME|ID|CPU|PERIOD|REGS_INTR, read_format: ID, =
inherit: 1, mmap: 1, comm: 1, freq: 1, task: 1, sample_id_all: 1, mmap2: 1,=
 comm_exec: 1, ksymbol: 1, bpf_event: 1, sample_regs_intr: 0xff0fff
> [root@quaco ~]#
>
> For perf top is ok to reuse the main evlist, as those are not going to
> hit the disk, but for 'perf record' it pollutes the perf.data file with
> that dummy event.
>
> This was a problem introduced with initial-delay, that IIRC predates the
> side band thread tho, I'll have to think about it, just writing this
> down to revisit this, as may raise some eyebrows by now being more
> exposed.

Agreed. We've had to adjust some tooling like the protobuf convertor
because of this:
https://github.com/google/perf_data_converter/pull/88

Thanks,
Ian

> - Arnaldo
>
> > Suggested-by: Stephane Eranian <eranian@google.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-record.c             | 19 +++++++---
> >  tools/perf/tests/attr/system-wide-dummy | 50 +++++++++++++++++++++++++
> >  tools/perf/tests/attr/test-record-C0    | 12 +++++-
> >  tools/perf/util/evsel.c                 |  5 ++-
> >  4 files changed, 78 insertions(+), 8 deletions(-)
> >  create mode 100644 tools/perf/tests/attr/system-wide-dummy
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 1ab349abe904..8d1e93351298 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -805,19 +805,28 @@ static int record__open(struct record *rec)
> >       int rc =3D 0;
> >
> >       /*
> > -      * For initial_delay we need to add a dummy event so that we can =
track
> > -      * PERF_RECORD_MMAP while we wait for the initial delay to enable=
 the
> > -      * real events, the ones asked by the user.
> > +      * For initial_delay or system wide, we need to add a dummy event=
 so
> > +      * that we can track PERF_RECORD_MMAP to cover the delay of waiti=
ng or
> > +      * event synthesis.
> >        */
> > -     if (opts->initial_delay) {
> > +     if (opts->initial_delay || target__has_cpu(&opts->target)) {
> >               if (perf_evlist__add_dummy(evlist))
> >                       return -ENOMEM;
> >
> > +             /* Disable tracking of mmaps on lead event. */
> >               pos =3D evlist__first(evlist);
> >               pos->tracking =3D 0;
> > +             /* Set up dummy event. */
> >               pos =3D evlist__last(evlist);
> >               pos->tracking =3D 1;
> > -             pos->core.attr.enable_on_exec =3D 1;
> > +             /*
> > +              * Enable the dummy event when the process is forked for
> > +              * initial_delay, immediately for system wide.
> > +              */
> > +             if (opts->initial_delay)
> > +                     pos->core.attr.enable_on_exec =3D 1;
> > +             else
> > +                     pos->immediate =3D 1;
> >       }
> >
> >       perf_evlist__config(evlist, opts, &callchain_param);
> > diff --git a/tools/perf/tests/attr/system-wide-dummy b/tools/perf/tests=
/attr/system-wide-dummy
> > new file mode 100644
> > index 000000000000..eba723cc0d38
> > --- /dev/null
> > +++ b/tools/perf/tests/attr/system-wide-dummy
> > @@ -0,0 +1,50 @@
> > +# Event added by system-wide or CPU perf-record to handle the race of
> > +# processes starting while /proc is processed.
> > +[event]
> > +fd=3D1
> > +group_fd=3D-1
> > +cpu=3D*
> > +pid=3D-1
> > +flags=3D8
> > +type=3D1
> > +size=3D120
> > +config=3D9
> > +sample_period=3D4000
> > +sample_type=3D455
> > +read_format=3D4
> > +# Event will be enabled right away.
> > +disabled=3D0
> > +inherit=3D1
> > +pinned=3D0
> > +exclusive=3D0
> > +exclude_user=3D0
> > +exclude_kernel=3D0
> > +exclude_hv=3D0
> > +exclude_idle=3D0
> > +mmap=3D1
> > +comm=3D1
> > +freq=3D1
> > +inherit_stat=3D0
> > +enable_on_exec=3D0
> > +task=3D1
> > +watermark=3D0
> > +precise_ip=3D0
> > +mmap_data=3D0
> > +sample_id_all=3D1
> > +exclude_host=3D0
> > +exclude_guest=3D0
> > +exclude_callchain_kernel=3D0
> > +exclude_callchain_user=3D0
> > +mmap2=3D1
> > +comm_exec=3D1
> > +context_switch=3D0
> > +write_backward=3D0
> > +namespaces=3D0
> > +use_clockid=3D0
> > +wakeup_events=3D0
> > +bp_type=3D0
> > +config1=3D0
> > +config2=3D0
> > +branch_sample_type=3D0
> > +sample_regs_user=3D0
> > +sample_stack_user=3D0
> > diff --git a/tools/perf/tests/attr/test-record-C0 b/tools/perf/tests/at=
tr/test-record-C0
> > index 93818054ae20..317730b906dd 100644
> > --- a/tools/perf/tests/attr/test-record-C0
> > +++ b/tools/perf/tests/attr/test-record-C0
> > @@ -9,6 +9,14 @@ cpu=3D0
> >  # no enable on exec for CPU attached
> >  enable_on_exec=3D0
> >
> > -# PERF_SAMPLE_IP | PERF_SAMPLE_TID PERF_SAMPLE_TIME | # PERF_SAMPLE_PE=
RIOD
> > +# PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
> > +# PERF_SAMPLE_ID | PERF_SAMPLE_PERIOD
> >  # + PERF_SAMPLE_CPU added by -C 0
> > -sample_type=3D391
> > +sample_type=3D455
> > +
> > +# Dummy event handles mmaps, comm and task.
> > +mmap=3D0
> > +comm=3D0
> > +task=3D0
> > +
> > +[event:system-wide-dummy]
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 6a571d322bb2..ca8f9533d8f9 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -1163,11 +1163,14 @@ void perf_evsel__config(struct evsel *evsel, st=
ruct record_opts *opts,
> >       }
> >
> >       /*
> > +      * A dummy event never triggers any actual counter and therefore
> > +      * cannot be used with branch_stack.
> > +      *
> >        * For initial_delay, a dummy event is added implicitly.
> >        * The software event will trigger -EOPNOTSUPP error out,
> >        * if BRANCH_STACK bit is set.
> >        */
> > -     if (opts->initial_delay && is_dummy_event(evsel))
> > +     if (is_dummy_event(evsel))
> >               perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
> >  }
> >
> > --
> > 2.26.2.303.gf8c07b1a785-goog
> >
>
> --
>
> - Arnaldo
