Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61576CA4A
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Feb 2024 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707983671; cv=none; b=KEcMZ9BHQengzTtYXmfCiPLtDe74s6lI1wvDAlRk+OQVIe5lS3sLKNBWA3VxcuIlmXBOxTLyqP+esIYZ0fVWxHOG40TTvhWWMQ7d/n8asYQFn5KANhnS0kKQXzMh/nhud8RdfDeR46GIBqs4+YgZxGcIxag3teg1z1KNYkwWBOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707983671; c=relaxed/simple;
	bh=a0CrsUvrlzjtAIzYyECsZveq3IHuby4CWNqAo1/tuCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ceb8/TuY1HXTXAjpJWp+7ro/Bz5rCYmkLPhFsK7pFoYo7Qiymws4LYZKH9uyJDon9ko/NK71ppwW8kiCjSp2wA90nwapwUXNvoGMJtLUOH3dvPTY+ywa4n7En884geJ+Hj7rX8t2K42Ct7rUjcg/Fm6q9fbld6C5PTFrebpg2B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=McNaqup1; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="McNaqup1"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-428405a0205so210061cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Feb 2024 23:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707983668; x=1708588468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtgtlwF3ZegafmmTs7sJ+DY87IpwAYGQFQxo66uPYvY=;
        b=McNaqup1OEXkodmRxwhZvx4IHD7Mjm/eegbvwyIbquhLzuULdQPokXzwmGR7PucNgp
         4frss6uIjYRBGenxAm4Fayel0QSxFGYIszMPBr5IUiXSx7UmT/eco0XTN8UWqIO5P+pN
         cMiX0Ws4tz6J98i2OjX+U1eG43fBwVwEd+CahWIjc1Nf+uY4VGiAH8qxAYX16NbkqDK8
         MUKhbDurEUlcf4bJuI3nm+ugRQ2vFKXTLatEWOqSnWlT38Urhd8cxZWvHjKS16+O2u+z
         ZRKXIexSeqHVDi96UUEcZV5m4HLfRt2lK/kb6IISCxUqBA7HobT0RTFjHqiTVojfS2Qh
         R7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707983668; x=1708588468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtgtlwF3ZegafmmTs7sJ+DY87IpwAYGQFQxo66uPYvY=;
        b=ibljm6ZZZVqMwRDjz7JcvtpityC29PbsCtGMTAkvGx4gs+cOdsSp+8IcpNjklZo9hH
         OLU61SzKbaxwdcvUH1+7+uI2i81MQS0/huhE9VE+zc7lnR3im1RQyvRqt54dmYbuMAXa
         Hs8DAOWZtCcHVKkq8kwoX/KJ4SoYALS6Tb/klsEqWfezhPmxU/DEVZOTsWge2UBaA9i0
         YtT+U+oiwQ/mpRMr+QO4qU5uWGJ7sDFqblaQtf8NO2Fxm4h2fImq4fAv7fujQpsw6NfJ
         1QNxntWyINgWF0JmTto0ZYeo9GT08c4K0rLJdB56y7tgr05g9jCPHyR0XvtRkqWHK7jl
         JFFw==
X-Forwarded-Encrypted: i=1; AJvYcCXjQn5E/Nuyr9lDQLaV5KUHBcnBPdQFIwibiQTfusq5RjBChQGiSEgE5j1v9TQc1h+sv/QHpEaN1hS9e0NPoqzHMAqgS86EgowW/jN1PcVEmQ==
X-Gm-Message-State: AOJu0YzsfKL/mOUjgONMEOezSSbR1w66HlI3lMn/x5OU0qZYIRRVHMO+
	BySRkV9BqN/oJSt804WPLHJFzFY0ljQsC0uC5oqmYRIUpAiw5DSKjjgXh6KLG70DN9ofu3+C1hz
	+FrRtii87NTL4498b3fvZT19hK0z6F4Z8i+yv
X-Google-Smtp-Source: AGHT+IH+mrNCXejOLadUwcLX8B40T+eYg6hObFaWOPHFLDcUd6aZ2iTgo2276ibfjcBs0TzV9c+XFeCg2y0P2ilNniI=
X-Received: by 2002:a05:622a:85:b0:42d:a974:5b65 with SMTP id
 o5-20020a05622a008500b0042da9745b65mr583206qtw.17.1707983667966; Wed, 14 Feb
 2024 23:54:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213075256.1983638-1-namhyung@kernel.org> <20240213075256.1983638-4-namhyung@kernel.org>
 <CAP-5=fVK3vvNoaGHPep8NCweGw9cztKBGQh5+0bVX91PhWp5Eg@mail.gmail.com> <CAM9d7ci=A9rwZxEYYQRi-Cncs7NSpRG+TaH5knTdEPZYxJWp9Q@mail.gmail.com>
In-Reply-To: <CAM9d7ci=A9rwZxEYYQRi-Cncs7NSpRG+TaH5knTdEPZYxJWp9Q@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 14 Feb 2024 23:54:13 -0800
Message-ID: <CAP-5=fWwRjnv=BSdz2GV+EfKUrtzMCSvheR38hkbFadKpvW2eQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf hist: Do not use event index in hpp__fmt()
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 9:26=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Feb 14, 2024 at 4:08=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Mon, Feb 12, 2024 at 11:52=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > The __hpp__fmt() is to print period values in a hist entry.  It handl=
es
> > > event groups using linked pair entries.  Until now, it used event ind=
ex
> > > to print values of group members.  But we want to make it more robust
> > > and support groups even if some members in the group were removed.
> >
> > I'm unclear how it breaks currently. The evsel idx is set the evlist
> > nr_entries on creation and not updated by a remove. A remove may
> > change a groups leader, should the remove also make the next entry's
> > index idx that of the previous group leader?
>
> The evsel__group_idx() returns evsel->idx - leader->idx.
> If it has a group event {A, B, C} then the index would be 0, 1, 2.
> If it removes B, the group would be {A, C} with index 0 and 2.
> The nr_members is 2 now so it cannot use index 2 for C.
>
> Note that we cannot change the index of C because some information
> like annotation histogram relies on the index.

Ugh, the whole index thing is just messy - perhaps these days we could
have a hashmap with the evsel as a key instead. I remember that I also
forced the idx here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/parse-events.c?h=3Dperf-tools-next#n2049
If it were invariant that the idx were always the position of an event
in the evlist then I think life would be easier, but that won't help
for the arrays of counters that need the index to be constant. I guess
this is why the previous work to do this skipped evsels rather than
removed them.

Thanks,
Ian


> >
> > > Let's use an index table from evsel to value array so that we can ski=
p
> > > dummy events in the output later.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/ui/hist.c | 34 ++++++++++++++++++++++++++++------
> > >  1 file changed, 28 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
> > > index 5f4c110d840f..9c4c738edde1 100644
> > > --- a/tools/perf/ui/hist.c
> > > +++ b/tools/perf/ui/hist.c
> > > @@ -48,15 +48,30 @@ static int __hpp__fmt(struct perf_hpp *hpp, struc=
t hist_entry *he,
> > >         if (evsel__is_group_event(evsel)) {
> > >                 int idx;
> > >                 struct hist_entry *pair;
> > > -               int nr_members =3D evsel->core.nr_members;
> > > +               int nr_members =3D evsel->core.nr_members - 1;
> >
> > A comment on the -1 would be useful.
>
> The 'nr_members' includes the leader which is already printed.
> In this code, we want to print member events only, hence -1.
> I'll add it to the comment.
>
> Thanks,
> Namhyung
>
> >
> > Thanks,
> > Ian
> >
> >
> > >                 union {
> > >                         u64 period;
> > >                         double percent;
> > >                 } *val;
> > > +               struct evsel *member;
> > > +               struct evsel **idx_table;
> > >
> > >                 val =3D calloc(nr_members, sizeof(*val));
> > >                 if (val =3D=3D NULL)
> > > -                       return 0;
> > > +                       goto out;
> > > +
> > > +               idx_table =3D calloc(nr_members, sizeof(*idx_table));
> > > +               if (idx_table =3D=3D NULL)
> > > +                       goto out;
> > > +
> > > +               /*
> > > +                * Build an index table for each evsel to the val arr=
ay.
> > > +                * It cannot use evsel->core.idx because removed even=
ts might
> > > +                * create a hole so the index is not consecutive anym=
ore.
> > > +                */
> > > +               idx =3D 0;
> > > +               for_each_group_member(member, evsel)
> > > +                       idx_table[idx++] =3D member;
> > >
> > >                 /* collect values in the group members */
> > >                 list_for_each_entry(pair, &he->pairs.head, pairs.node=
) {
> > > @@ -66,8 +81,15 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct=
 hist_entry *he,
> > >                         if (!total)
> > >                                 continue;
> > >
> > > -                       evsel =3D hists_to_evsel(pair->hists);
> > > -                       idx =3D evsel__group_idx(evsel);
> > > +                       member =3D hists_to_evsel(pair->hists);
> > > +                       for (idx =3D 0; idx < nr_members; idx++) {
> > > +                               if (idx_table[idx] =3D=3D member)
> > > +                                       break;
> > > +                       }
> > > +
> > > +                       /* this should not happen */
> > > +                       if (idx =3D=3D nr_members)
> > > +                               continue;
> > >
> > >                         if (fmt_percent)
> > >                                 val[idx].percent =3D 100.0 * period /=
 total;
> > > @@ -75,8 +97,7 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct =
hist_entry *he,
> > >                                 val[idx].period =3D period;
> > >                 }
> > >
> > > -               /* idx starts from 1 to skip the leader event */
> > > -               for (idx =3D 1; idx < nr_members; idx++) {
> > > +               for (idx =3D 0; idx < nr_members; idx++) {
> > >                         if (fmt_percent) {
> > >                                 ret +=3D hpp__call_print_fn(hpp, prin=
t_fn,
> > >                                                           fmt, len, v=
al[idx].percent);
> > > @@ -89,6 +110,7 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct=
 hist_entry *he,
> > >                 free(val);
> > >         }
> > >
> > > +out:
> > >         /*
> > >          * Restore original buf and size as it's where caller expects
> > >          * the result will be saved.
> > > --
> > > 2.43.0.687.g38aa6559b0-goog
> > >
