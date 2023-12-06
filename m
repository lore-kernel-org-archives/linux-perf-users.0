Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pm0UkKa/"
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1649F122
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Dec 2023 15:39:20 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so5405a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Dec 2023 15:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701905958; x=1702510758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXDE6J1nVfJg93wGJKDjkzbUE0s3CIXmehRMH73JMCU=;
        b=pm0UkKa/+DWIDnsZusJr4TVyh+AZZsQp2D9z3j8wugLmzDeBA6uicon2bw7Pp/VG6X
         Lq1CnuQSFjdZGQrh+9qgbranToIXf7vNIpPULs6h73hz/JTz3+Z0N32F0FhFYHmjt0kM
         jHpcsRMud5TmtgYMFO0HZ799H5HnXYEfeUwlSvlS5TmL2zYXeLyq3GSYnYIIkKwhljqe
         NQzWox8YgHy+figv/4Ac4GyRvz64VhyK7OQRF6DKkuE4jJ3CyTPIz0pDIQN6fQgxJ7ub
         GHss51ugxiWSxOpG8waYGgq1agu1TwuyGg6v6VmViWWjyuJjRR+4NU0jVTceAHVfZAt+
         bxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701905958; x=1702510758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXDE6J1nVfJg93wGJKDjkzbUE0s3CIXmehRMH73JMCU=;
        b=oL/Pn53oWuj5+ftPcqllAf7/QL6o1whnX9QpI+ApD5rnhiJdPfz+vlRkGHREsplzdF
         0Z9MGjZz41/HZSTGkFZHs9kZVAEZ7JcSOf2ZMveL9om7Av6AsCVcvn3ChySh69WbJlpf
         BwylYYc9iaFprhP94ParDD8dpkFHtRQxaMm0h/QUTICQexdM+LqrKRnJYUi9d8TdS/t9
         tfaZuh29w9tqsjbcIgy5T3NeZNr2MfOzm063pyApaORs52ouv4t1oSNzv1a+0vdJAF4k
         vTQHu/IM1pwq2x4IIAusyt4nfSk9iFFtSk8DIfM/ZkJgo0apuxxsOi0h0BL84CDY1//r
         ZEMA==
X-Gm-Message-State: AOJu0YxGlmrDCaRi7nlOZ8iF1YvEWVmp8ZFf4UNj3rc9DolO68kU0gkh
	tAg1dqznu+49KQkC9VE9JL54VikxL6l0zu98Uv7vZg==
X-Google-Smtp-Source: AGHT+IFKP8XUxAXse9Lx6CIFn+syqtsYY8Wpp8RCyiOHqdGl5W23i0Cvc+SJ6knGPcsHbBgWRjy2uAEAQOt2f+HWLYg=
X-Received: by 2002:a50:d0cc:0:b0:54c:9996:7833 with SMTP id
 g12-20020a50d0cc000000b0054c99967833mr136601edf.7.1701905957898; Wed, 06 Dec
 2023 15:39:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-19-irogers@google.com>
 <CAM9d7chbysNaH++LQgeskZ_LRAF7KuErexapDTWRf-zsgPOq1g@mail.gmail.com>
In-Reply-To: <CAM9d7chbysNaH++LQgeskZ_LRAF7KuErexapDTWRf-zsgPOq1g@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 6 Dec 2023 15:39:06 -0800
Message-ID: <CAP-5=fWnvRqQY5fX1ada3c+7Xsh4+Up2cxR12xkgQSKf1-OgBg@mail.gmail.com>
Subject: Re: [PATCH v5 18/50] perf maps: Refactor maps__fixup_overlappings
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ming Wang <wangming01@loongson.cn>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, liuwenyu <liuwenyu7@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 3:59=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Mon, Nov 27, 2023 at 2:10=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Rename to maps__fixup_overlap_and_insert as the given mapping is
> > always inserted. Factor out first_ending_after as a utility
> > function. Minor variable name changes. Switch to using debug_file()
> > rather than passing a debug FILE*.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/maps.c   | 62 ++++++++++++++++++++++++----------------
> >  tools/perf/util/maps.h   |  2 +-
> >  tools/perf/util/thread.c |  3 +-
> >  3 files changed, 39 insertions(+), 28 deletions(-)
> >
> > diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> > index f13fd3a9686b..40df08dd9bf3 100644
> > --- a/tools/perf/util/maps.c
> > +++ b/tools/perf/util/maps.c
> > @@ -334,20 +334,16 @@ size_t maps__fprintf(struct maps *maps, FILE *fp)
> >         return args.printed;
> >  }
> >
> > -int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE =
*fp)
> > +/*
> > + * Find first map where end > new->start.
>
> s/new/map/.
>
> > + * Same as find_vma() in kernel.
> > + */
> > +static struct rb_node *first_ending_after(struct maps *maps, const str=
uct map *map)
> >  {
> >         struct rb_root *root;
> >         struct rb_node *next, *first;
> > -       int err =3D 0;
> > -
> > -       down_write(maps__lock(maps));
> >
> >         root =3D maps__entries(maps);
> > -
> > -       /*
> > -        * Find first map where end > map->start.
> > -        * Same as find_vma() in kernel.
> > -        */
> >         next =3D root->rb_node;
> >         first =3D NULL;
> >         while (next) {
> > @@ -361,8 +357,22 @@ int maps__fixup_overlappings(struct maps *maps, st=
ruct map *map, FILE *fp)
> >                 } else
> >                         next =3D next->rb_right;
> >         }
> > +       return first;
> > +}
> > +
> > +/*
> > + * Adds new to maps, if new overlaps existing entries then the existin=
g maps are
> > + * adjusted or removed so that new fits without overlapping any entrie=
s.
> > + */
> > +int maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
>
> Do we really need this rename (map -> new)?  It seems just to create
> unnecessary diffs.  Also I'd like to avoid 'new' as it's a keyword in C++
> although we don't compile with C++ compilers.

Agreed on the C++ issue, but this is also an issue in linux/list.h
that uses the same naming convention. The reason for the change from
map to new is that "pos->map" and "map" read very similarly, so the
code is more intention revealing with the change.


> > +{
> > +
> > +       struct rb_node *next;
> > +       int err =3D 0;
>
> Maybe you can add this line or let the caller pass it to reduce the diff.
>
>     FILE *fp =3D debug_file();

Good idea. Done in v6.

Thanks,
Ian

> Thanks,
> Namhyung
>
> > +
> > +       down_write(maps__lock(maps));
> >
> > -       next =3D first;
> > +       next =3D first_ending_after(maps, new);
> >         while (next && !err) {
> >                 struct map_rb_node *pos =3D rb_entry(next, struct map_r=
b_node, rb_node);
> >                 next =3D rb_next(&pos->rb_node);
> > @@ -371,27 +381,27 @@ int maps__fixup_overlappings(struct maps *maps, s=
truct map *map, FILE *fp)
> >                  * Stop if current map starts after map->end.
> >                  * Maps are ordered by start: next will not overlap for=
 sure.
> >                  */
> > -               if (map__start(pos->map) >=3D map__end(map))
> > +               if (map__start(pos->map) >=3D map__end(new))
> >                         break;
> >
> >                 if (verbose >=3D 2) {
> >
> >                         if (use_browser) {
> >                                 pr_debug("overlapping maps in %s (disab=
le tui for more info)\n",
> > -                                        map__dso(map)->name);
> > +                                        map__dso(new)->name);
> >                         } else {
> > -                               fputs("overlapping maps:\n", fp);
> > -                               map__fprintf(map, fp);
> > -                               map__fprintf(pos->map, fp);
> > +                               pr_debug("overlapping maps:\n");
> > +                               map__fprintf(new, debug_file());
> > +                               map__fprintf(pos->map, debug_file());
> >                         }
> >                 }
> >
> > -               rb_erase_init(&pos->rb_node, root);
> > +               rb_erase_init(&pos->rb_node, maps__entries(maps));
> >                 /*
> >                  * Now check if we need to create new maps for areas no=
t
> >                  * overlapped by the new map:
> >                  */
> > -               if (map__start(map) > map__start(pos->map)) {
> > +               if (map__start(new) > map__start(pos->map)) {
> >                         struct map *before =3D map__clone(pos->map);
> >
> >                         if (before =3D=3D NULL) {
> > @@ -399,7 +409,7 @@ int maps__fixup_overlappings(struct maps *maps, str=
uct map *map, FILE *fp)
> >                                 goto put_map;
> >                         }
> >
> > -                       map__set_end(before, map__start(map));
> > +                       map__set_end(before, map__start(new));
> >                         err =3D __maps__insert(maps, before);
> >                         if (err) {
> >                                 map__put(before);
> > @@ -407,11 +417,11 @@ int maps__fixup_overlappings(struct maps *maps, s=
truct map *map, FILE *fp)
> >                         }
> >
> >                         if (verbose >=3D 2 && !use_browser)
> > -                               map__fprintf(before, fp);
> > +                               map__fprintf(before, debug_file());
> >                         map__put(before);
> >                 }
> >
> > -               if (map__end(map) < map__end(pos->map)) {
> > +               if (map__end(new) < map__end(pos->map)) {
> >                         struct map *after =3D map__clone(pos->map);
> >
> >                         if (after =3D=3D NULL) {
> > @@ -419,23 +429,25 @@ int maps__fixup_overlappings(struct maps *maps, s=
truct map *map, FILE *fp)
> >                                 goto put_map;
> >                         }
> >
> > -                       map__set_start(after, map__end(map));
> > -                       map__add_pgoff(after, map__end(map) - map__star=
t(pos->map));
> > -                       assert(map__map_ip(pos->map, map__end(map)) =3D=
=3D
> > -                               map__map_ip(after, map__end(map)));
> > +                       map__set_start(after, map__end(new));
> > +                       map__add_pgoff(after, map__end(new) - map__star=
t(pos->map));
> > +                       assert(map__map_ip(pos->map, map__end(new)) =3D=
=3D
> > +                               map__map_ip(after, map__end(new)));
> >                         err =3D __maps__insert(maps, after);
> >                         if (err) {
> >                                 map__put(after);
> >                                 goto put_map;
> >                         }
> >                         if (verbose >=3D 2 && !use_browser)
> > -                               map__fprintf(after, fp);
> > +                               map__fprintf(after, debug_file());
> >                         map__put(after);
> >                 }
> >  put_map:
> >                 map__put(pos->map);
> >                 free(pos);
> >         }
> > +       /* Add the map. */
> > +       err =3D __maps__insert(maps, new);
> >         up_write(maps__lock(maps));
> >         return err;
> >  }
> > diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
> > index b94ad5c8fea7..62e94d443c02 100644
> > --- a/tools/perf/util/maps.h
> > +++ b/tools/perf/util/maps.h
> > @@ -133,7 +133,7 @@ struct addr_map_symbol;
> >
> >  int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams);
> >
> > -int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE =
*fp);
> > +int maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)=
;
> >
> >  struct map *maps__find_by_name(struct maps *maps, const char *name);
> >
> > diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> > index b6986a81aa6d..3d47b5c5528b 100644
> > --- a/tools/perf/util/thread.c
> > +++ b/tools/perf/util/thread.c
> > @@ -345,8 +345,7 @@ int thread__insert_map(struct thread *thread, struc=
t map *map)
> >         if (ret)
> >                 return ret;
> >
> > -       maps__fixup_overlappings(thread__maps(thread), map, stderr);
> > -       return maps__insert(thread__maps(thread), map);
> > +       return maps__fixup_overlap_and_insert(thread__maps(thread), map=
);
> >  }
> >
> >  struct thread__prepare_access_maps_cb_args {
> > --
> > 2.43.0.rc1.413.gea7ed67945-goog
> >
