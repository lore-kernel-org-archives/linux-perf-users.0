Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C50733F1
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Nov 2023 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96DDD5C;
	Fri,  3 Nov 2023 11:58:42 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6be1bc5aa1cso2538699b3a.3;
        Fri, 03 Nov 2023 11:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699037922; x=1699642722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HsepAUpXpJFKU4XV8IuMmYlOnjqVxBUaHisnVnUUj9g=;
        b=Vg7fTiTH6pj+M9scIlGx2Ycu1fWXzEPt5c3crtJZI2MlCQV0tUNea770FDlVxCkngS
         V7Dq+JRFxJ4nITF0BKl0DnWFxYO5Tx9sQZs1RZHjCD5VJLyrSNkj9NgcRH5hZ7QiePkf
         fw5WPUKiK9TrJN48RsSMwNzHWHdGj3lokLak969F6Ck6RmpRKcfKZSVfAjt64kLgWpH0
         7v9p+6JKIbOl0HiZSupnw3R4M7Mb/ZloN62t0C8hJVy/2yfeXvJVisi2miG+TY85/a11
         MDXq/tqPxZK/HkvBqWHUY+2CTgtzbp+B57VuCwzYb8D+nFy+oECMcklSu0Fwr2y/IJIt
         tnAA==
X-Gm-Message-State: AOJu0YyJX7QzSrHshixcDtzfCKMeBHXfVdyL58GaLtwdZSdOJ6Nym/uT
	wCbnZsg61xbfWTbSOFRtv7z8M9rqvwxD1V+BhloKmmg5
X-Google-Smtp-Source: AGHT+IHBLYP1wHeQPmLG0ezgwFMDu/JJgR2hIw29vh+FkiQcYTlolR2ZFQu0cSoy6u5Vnv1ftujUo4tt+GEo10tywnw=
X-Received: by 2002:a05:6a00:1356:b0:6c0:4006:4195 with SMTP id
 k22-20020a056a00135600b006c040064195mr25950354pfu.0.1699037922172; Fri, 03
 Nov 2023 11:58:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102222653.4165959-1-namhyung@kernel.org> <20231102222653.4165959-5-namhyung@kernel.org>
 <133a66fe-a7e7-42e2-822b-1f3caea7862a@wanadoo.fr>
In-Reply-To: <133a66fe-a7e7-42e2-822b-1f3caea7862a@wanadoo.fr>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 3 Nov 2023 11:58:31 -0700
Message-ID: <CAM9d7chKaMnAR1=SOsRGXeyJsyOVOE0poTKajPYpaJC=yNWCrA@mail.gmail.com>
Subject: Re: [PATCH 4/5] perf annotate: Move some fields to annotated_source
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Nov 2, 2023 at 10:41=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 02/11/2023 =C3=A0 23:26, Namhyung Kim a =C3=A9crit :
> > Some fields in the struct annotation are only used with annotated_sourc=
e
> > so better to be moved there in order to reduce memory consumption for
> > other symbols.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >   tools/perf/ui/browsers/annotate.c | 12 ++++++------
> >   tools/perf/util/annotate.c        | 17 +++++++++--------
> >   tools/perf/util/annotate.h        | 14 +++++++-------
> >   3 files changed, 22 insertions(+), 21 deletions(-)
> >
> > diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers=
/annotate.c
> > index d2470f87344d..1b42db70c998 100644
> > --- a/tools/perf/ui/browsers/annotate.c
> > +++ b/tools/perf/ui/browsers/annotate.c
> > @@ -384,7 +384,7 @@ static bool annotate_browser__toggle_source(struct =
annotate_browser *browser)
> >               if (al->idx_asm < offset)
> >                       offset =3D al->idx;
> >
> > -             browser->b.nr_entries =3D notes->nr_entries;
> > +             browser->b.nr_entries =3D notes->src->nr_entries;
> >               notes->options->hide_src_code =3D false;
> >               browser->b.seek(&browser->b, -offset, SEEK_CUR);
> >               browser->b.top_idx =3D al->idx - offset;
> > @@ -402,7 +402,7 @@ static bool annotate_browser__toggle_source(struct =
annotate_browser *browser)
> >               if (al->idx_asm < offset)
> >                       offset =3D al->idx_asm;
> >
> > -             browser->b.nr_entries =3D notes->nr_asm_entries;
> > +             browser->b.nr_entries =3D notes->src->nr_asm_entries;
> >               notes->options->hide_src_code =3D true;
> >               browser->b.seek(&browser->b, -offset, SEEK_CUR);
> >               browser->b.top_idx =3D al->idx_asm - offset;
> > @@ -435,7 +435,7 @@ static void ui_browser__init_asm_mode(struct ui_bro=
wser *browser)
> >   {
> >       struct annotation *notes =3D browser__annotation(browser);
> >       ui_browser__reset_index(browser);
> > -     browser->nr_entries =3D notes->nr_asm_entries;
> > +     browser->nr_entries =3D notes->src->nr_asm_entries;
> >   }
> >
> >   static int sym_title(struct symbol *sym, struct map *map, char *title=
,
> > @@ -860,7 +860,7 @@ static int annotate_browser__run(struct annotate_br=
owser *browser,
> >                                          browser->b.height,
> >                                          browser->b.index,
> >                                          browser->b.top_idx,
> > -                                        notes->nr_asm_entries);
> > +                                        notes->src->nr_asm_entries);
> >               }
> >                       continue;
> >               case K_ENTER:
> > @@ -991,8 +991,8 @@ int symbol__tui_annotate(struct map_symbol *ms, str=
uct evsel *evsel,
> >
> >       ui_helpline__push("Press ESC to exit");
> >
> > -     browser.b.width =3D notes->max_line_len;
> > -     browser.b.nr_entries =3D notes->nr_entries;
> > +     browser.b.width =3D notes->src->max_line_len;
> > +     browser.b.nr_entries =3D notes->src->nr_entries;
> >       browser.b.entries =3D &notes->src->source,
> >       browser.b.width +=3D 18; /* Percentage */
> >
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index 92a9adf9d5eb..ee7b8e1848a8 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -2808,19 +2808,20 @@ void annotation__mark_jump_targets(struct annot=
ation *notes, struct symbol *sym)
> >   void annotation__set_offsets(struct annotation *notes, s64 size)
> >   {
> >       struct annotation_line *al;
> > +     struct annotated_source *src =3D notes->src;
> >
> > -     notes->max_line_len =3D 0;
> > -     notes->nr_entries =3D 0;
> > -     notes->nr_asm_entries =3D 0;
> > +     src->max_line_len =3D 0;
> > +     src->nr_entries =3D 0;
> > +     src->nr_asm_entries =3D 0;
> >
> > -     list_for_each_entry(al, &notes->src->source, node) {
> > +     list_for_each_entry(al, &src->source, node) {
> >               size_t line_len =3D strlen(al->line);
> >
> > -             if (notes->max_line_len < line_len)
> > -                     notes->max_line_len =3D line_len;
> > -             al->idx =3D notes->nr_entries++;
> > +             if (src->max_line_len < line_len)
> > +                     src->max_line_len =3D line_len;
> > +             al->idx =3D src->nr_entries++;
> >               if (al->offset !=3D -1) {
> > -                     al->idx_asm =3D notes->nr_asm_entries++;
> > +                     al->idx_asm =3D src->nr_asm_entries++;
> >                       /*
> >                        * FIXME: short term bandaid to cope with assembl=
y
> >                        * routines that comes with labels in the same co=
lumn
> > diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> > index d8a221591926..c51ceb857bd6 100644
> > --- a/tools/perf/util/annotate.h
> > +++ b/tools/perf/util/annotate.h
> > @@ -268,10 +268,13 @@ struct cyc_hist {
> >    * returns.
> >    */
> >   struct annotated_source {
> > -     struct list_head   source;
> > -     int                nr_histograms;
> > -     size_t             sizeof_sym_hist;
> > -     struct sym_hist    *histograms;
> > +     struct list_head        source;
> > +     int                     nr_histograms;
>
> If this int...
>
> > +     size_t                  sizeof_sym_hist;
> > +     struct sym_hist         *histograms;
> > +     int                     nr_entries;
> > +     int                     nr_asm_entries;
> > +     u16                     max_line_len;
>
> ... and these int and u16 were grouped, you would also save a hole in
> the struct and reduce padding.
>
>
> On x86_64, after patch 4/5:
> struct annotated_source {
>         struct list_head           source;               /*     0    16 *=
/
>         int                        nr_histograms;        /*    16     4 *=
/
>
>         /* XXX 4 bytes hole, try to pack */                     <=3D=3D=
=3D=3D
>
>         size_t                     sizeof_sym_hist;      /*    24     8 *=
/
>         struct sym_hist *          histograms;           /*    32     8 *=
/
>         int                        nr_entries;           /*    40     4 *=
/
>         int                        nr_asm_entries;       /*    44     4 *=
/
>         u16                        max_line_len;         /*    48     2 *=
/
>
>         /* size: 56, cachelines: 1, members: 7 */
>         /* sum members: 46, holes: 1, sum holes: 4 */
>         /* padding: 6 */                                        <=3D=3D=
=3D=3D
>         /* last cacheline: 56 bytes */
> };
>
> After patch 5/5, the struct would be just 64 bytes. If fields are
> re-ordered, it would be 56 bytes.
>
> Because of rounding in memory allocations, 56 or 64 shouldn't change
> anything. But it would be more future proof, should something else be
> added here in the future.

Thanks for looking at this.  I agree with your analysis and I will
reorder the struct.  Actually I plan to make more changes here
so it's better to make it smaller.

Thanks,
Namhyung
