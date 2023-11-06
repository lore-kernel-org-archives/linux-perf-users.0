Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB0B2E648
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Nov 2023 22:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489821BC;
	Mon,  6 Nov 2023 14:23:59 -0800 (PST)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6c398717726so2192012b3a.2;
        Mon, 06 Nov 2023 14:23:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699309439; x=1699914239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5KSCOu691NT1PfrO1kzMKbd/+BqwCFGmhMLBYbiDMU=;
        b=Xm1ulYXiL5xj9GhPzCf9lO/xEW1P9Mb8RB9RM9tleL9PYBjX7foVpfQcOo0Bo1tHvU
         +EMGJrCFEEPjooWI8XytCGgCzgtRhC29cwWFY3o/lWeGc5L7qx3MIPiMGsdzfKzdp0hY
         +ftaCPdr2fFpv3mtyrDXf2KJm69uep3KHIsEG4sa+pdc7rhVQRBOD9xg5k+YV/gHNJ2R
         4/GQyCnl4aeV9yotcsR9nFp9TV2obZ3MhbvxoLU5/5FYeYyyfaIfwmAfmP85da/Qb7p7
         4LCAODY1U4Hs9KFy+nfJMPbxq744+M7Is9gv0tigYp6Nbwk6Z1Umft9hxHNgUltzLuoj
         VFyQ==
X-Gm-Message-State: AOJu0YxlJ/ezJI4X9njZiJ3zxTliIlka8cgq9JQKQ0BhU35i9LbMl8An
	62n9aJdTNUmQEeT0acV1iNwQ1uE5W0QYydxVe94=
X-Google-Smtp-Source: AGHT+IGv+o/+zJivESMR2Z2d4lwNd6Y7F/0po0qUsoq6kPluTYpMriId/VUFweUPW/AXzfZjUY0YyuPA+oYiuLyuApA=
X-Received: by 2002:a05:6a20:3945:b0:182:2282:fd7a with SMTP id
 r5-20020a056a20394500b001822282fd7amr8559206pzg.19.1699309438609; Mon, 06 Nov
 2023 14:23:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103191907.54531-1-namhyung@kernel.org> <20231103191907.54531-2-namhyung@kernel.org>
 <ZUk/27WMwtnQPggF@kernel.org> <ZUlEP9pP3JiSxDVc@kernel.org>
In-Reply-To: <ZUlEP9pP3JiSxDVc@kernel.org>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 6 Nov 2023 14:23:47 -0800
Message-ID: <CAM9d7cgWUfDR9J6NLZBEs-DhXGR1YdaQYyOuANTRbhhUwp=8WQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] perf annotate: Split struct cycles_info
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

On Mon, Nov 6, 2023 at 11:53=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Nov 06, 2023 at 04:34:51PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Fri, Nov 03, 2023 at 12:19:03PM -0700, Namhyung Kim escreveu:
> > > The cycles info is used only when branch stack is provided.  Split th=
em
> > > into a separate struct and lazy allocate them to save some memory.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/ui/browsers/annotate.c |  2 +-
> > >  tools/perf/util/annotate.c        | 34 ++++++++++++++++++-----------=
--
> > >  tools/perf/util/annotate.h        | 14 ++++++++-----
> > >  3 files changed, 30 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browse=
rs/annotate.c
> > > index ccdb2cd11fbf..d2470f87344d 100644
> > > --- a/tools/perf/ui/browsers/annotate.c
> > > +++ b/tools/perf/ui/browsers/annotate.c
> > > @@ -337,7 +337,7 @@ static void annotate_browser__calc_percent(struct=
 annotate_browser *browser,
> > >                             max_percent =3D percent;
> > >             }
> > >
> > > -           if (max_percent < 0.01 && pos->al.ipc =3D=3D 0) {
> > > +           if (max_percent < 0.01 && (!pos->al.cycles || pos->al.cyc=
les->ipc =3D=3D 0)) {
> > >                     RB_CLEAR_NODE(&pos->al.rb_node);
> > >                     continue;
> > >             }
> > > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > > index 82956adf9963..3e7f75827270 100644
> > > --- a/tools/perf/util/annotate.c
> > > +++ b/tools/perf/util/annotate.c
> > > @@ -1100,8 +1100,8 @@ static void annotation__count_and_fill(struct a=
nnotation *notes, u64 start, u64
> > >             for (offset =3D start; offset <=3D end; offset++) {
> > >                     struct annotation_line *al =3D notes->offsets[off=
set];
> > >
> > > -                   if (al && al->ipc =3D=3D 0.0) {
> > > -                           al->ipc =3D ipc;
> > > +                   if (al && al->cycles && al->cycles->ipc =3D=3D 0.=
0) {
> > > +                           al->cycles->ipc =3D ipc;
> > >                             cover_insn++;
> > >                     }
> > >             }
> > > @@ -1134,13 +1134,18 @@ void annotation__compute_ipc(struct annotatio=
n *notes, size_t size)
> > >             if (ch && ch->cycles) {
> > >                     struct annotation_line *al;
> > >
> > > +                   al =3D notes->offsets[offset];
> > > +                   if (al && al->cycles =3D=3D NULL) {
> > > +                           al->cycles =3D zalloc(sizeof(*al->cycles)=
);
> > > +                           if (al->cycles =3D=3D NULL)
> >
> > Shouldn't we stop here and tell the user that his system is really tigh=
t
> > on memory instead of just ignoring it?
> >
> >       if (al->cycles =3D=3D NULL) {
> >               ui__error("Not enough memory for allocating branch stack =
cycles info!\n");
> >               return ... its a void function :-\
> >       }
> >
> > Since its a void function, can't we detect that we need al->cycles
> > allocated at the tool start and allocate it there, then propagate back
> > the error?
> >
> > Its per line, so doing it lazily is indeed easier, so make that functio=
n
> > return an error and bail out when not being able to calculate the ipc
> > for the remaining lines?
>
> I.e. with this folded into this patch, all but one of the callers of
> symbol__annotate2() already call a ui error messagem for instance:
>
>                 err =3D symbol__annotate2(ms, evsel, opts, &browser.arch)=
;
>                 if (err) {
>                         char msg[BUFSIZ];
>                         dso->annotate_warned =3D true;
>                         symbol__strerror_disassemble(ms, err, msg, sizeof=
(msg));
>                         ui__error("Couldn't annotate %s:\n%s", sym->name,=
 msg);
>
> - Arnaldo

Looks good to me, thanks for doing this!
Namhyung


>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 3e7f758272703554..99ff3bb9cad8daa6 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1114,12 +1114,13 @@ static void annotation__count_and_fill(struct ann=
otation *notes, u64 start, u64
>         }
>  }
>
> -void annotation__compute_ipc(struct annotation *notes, size_t size)
> +static int annotation__compute_ipc(struct annotation *notes, size_t size=
)
>  {
> +       int err =3D 0;
>         s64 offset;
>
>         if (!notes->src || !notes->src->cycles_hist)
> -               return;
> +               return 0;
>
>         notes->total_insn =3D annotation__count_insn(notes, 0, size - 1);
>         notes->hit_cycles =3D 0;
> @@ -1137,8 +1138,10 @@ void annotation__compute_ipc(struct annotation *no=
tes, size_t size)
>                         al =3D notes->offsets[offset];
>                         if (al && al->cycles =3D=3D NULL) {
>                                 al->cycles =3D zalloc(sizeof(*al->cycles)=
);
> -                               if (al->cycles =3D=3D NULL)
> -                                       continue;
> +                               if (al->cycles =3D=3D NULL) {
> +                                       err =3D ENOMEM;
> +                                       break;
> +                               }
>                         }
>                         if (ch->have_start)
>                                 annotation__count_and_fill(notes, ch->sta=
rt, offset, ch);
> @@ -1150,7 +1153,21 @@ void annotation__compute_ipc(struct annotation *no=
tes, size_t size)
>                         notes->have_cycles =3D true;
>                 }
>         }
> +
> +       if (err) {
> +               while (++offset < (s64)size) {
> +                       struct cyc_hist *ch =3D &notes->src->cycles_hist[=
offset];
> +
> +                       if (ch && ch->cycles) {
> +                               struct annotation_line *al =3D notes->off=
sets[offset];
> +                               if (al)
> +                                       zfree(&al->cycles);
> +                       }
> +               }
> +       }
> +
>         annotation__unlock(notes);
> +       return 0;
>  }
>
>  int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, struct per=
f_sample *sample,
> @@ -3270,7 +3287,11 @@ int symbol__annotate2(struct map_symbol *ms, struc=
t evsel *evsel,
>
>         annotation__set_offsets(notes, size);
>         annotation__mark_jump_targets(notes, sym);
> -       annotation__compute_ipc(notes, size);
> +
> +       err =3D annotation__compute_ipc(notes, size);
> +       if (err)
> +               goto out_free_offsets;
> +
>         annotation__init_column_widths(notes, sym);
>         notes->nr_events =3D nr_pcnt;
>
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index 16d27952fd5c1b47..19bc2f03917575a8 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -329,7 +329,6 @@ static inline bool annotation_line__filter(struct ann=
otation_line *al, struct an
>  }
>
>  void annotation__set_offsets(struct annotation *notes, s64 size);
> -void annotation__compute_ipc(struct annotation *notes, size_t size);
>  void annotation__mark_jump_targets(struct annotation *notes, struct symb=
ol *sym);
>  void annotation__update_column_widths(struct annotation *notes);
>  void annotation__init_column_widths(struct annotation *notes, struct sym=
bol *sym);
