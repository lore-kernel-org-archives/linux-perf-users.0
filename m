Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CB53BBC2
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jul 2024 21:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721079850; cv=none; b=jw4SQ7tFe5HzjqSKco4DXWmZONnIddH8Bjx8pGbCDMxHwPKQis8JWQ4P+k+EgUW+8JMFT18i1hqz2KIdQ30vDDEh+ySWGOd4tAJ1Iutue4sUzvDfxbl14PZty7sHmUbkSizU3xasaJ6pSZUvDSlyecg9onTcoqUw6Y5mwcE48vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721079850; c=relaxed/simple;
	bh=iOART0ipK+1hi4xZSLp3kV4LBrHcAgdFJZ3ePxsMgnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tj6hVWCOZ/xID83ys7IqtIsp0pbAVD3zIcy11N1yBKTz4Ju9AmgPz4IR3Ws/FIJ0I9gYMAQar8sSBYlm/b5LH4jQjffV1gFY1S6AVoT8yM4Rmu1MWmY+mcsxvTFkwSU1NecpQLNV9pW5vpljdO6Z0uWuQEFjPoUUG26phVC4mso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Zm4sPor; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Zm4sPor"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3815ad8adc9so42375ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jul 2024 14:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721079848; x=1721684648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3amkL1H4ZKyi6XfzXBNLueafBWppUuU6SEPwkJIi2Y=;
        b=4Zm4sPorV/8Kct/ucOLDJyDVOuuhk+r15c47RfOvrI01nxGzSKhYk8IUPLQt9q/pg7
         /eJ6K/rxbIzBJ4yNSUcqh6+Isd2VjN45Bpse6fyUhq/LChDdc2unnOAtnWwGo1q+6Ra9
         YutP0f8QjMCVZX3WPSkiuAHSk2JCI1aZFhc84oyaCY0pGHwE5vdzztWb2FQ0euYbMyP0
         2v8siIkQepHvXe9S/SuUyyK1x98GsG0oHr/Gl3Uiwpq70XtuAN9khuY7RKXBp7JpnD2z
         XbULNEKACG9BPeB6mQjhZhHBIYj5jf5FUpUMlLMQRbfC5kbzQ5nlfQmDad/ww7CCHS7U
         PRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721079848; x=1721684648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3amkL1H4ZKyi6XfzXBNLueafBWppUuU6SEPwkJIi2Y=;
        b=QSzI4V+12wdmFaNWW8hyIUKSyabkJY5BnBCjNGd9vuA5QvyKldt3WdUJq1zXKBJ1+S
         xaO1QIMY9VqmKn+OF7JGa/xt84CLYR2XKiM29Jvu6jHmYePdVzroynGYA33ILIkSHoBS
         Wv8XsF8DqbuJqhIwohYaRmIhqZ70cWSf/oLbJFj+wEPUPBpm416hxopq73sBcM54xob8
         1dMo/2zINNTFTUBAbOtY+lYQXDZRR+aeYXuyT/QMn1om6iBwoA3Rx8dSOj10WHF8j7Q+
         QtOzbCyvkJ/iM+3brz2khqH4BGboqocYDGde7EclczEcEKZ4R0ZSHQ9Xp1LxdQzBROXO
         CEzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmI+2ViBC8YxqDX3Q7btzSCdXdE4aBwMFobaMG+v+nyfEqIHANMJi5QLce++2/aSkX7ccAfazctwX3k9T4bfILQKtEWWZYk4R/LSk14h5rtA==
X-Gm-Message-State: AOJu0YxXXc3syjVscelmyI1Yxq2R5PtoPdAENrh0HQ+8aLHRwLgt4whG
	h13FTyb0TPIu/65Gf6GxluzepfHwOINba+fqB8UkEQzh/T3Cr2QLFM6CX8ZVDx3BWLUZZPilbMi
	FoIC+WPpr0SgrzKAZUfQmfIQ9Ix2989Dvi3jr
X-Google-Smtp-Source: AGHT+IEFgTxOp8oe9itMdaaRuGV9iiTBREIpojoh2SSfmAHSYzoxmt5lyKaNR7JMpmVQE6Qex+Suuw9OoTAe8/R1MBs=
X-Received: by 2002:a05:6e02:12e2:b0:376:30ec:3f04 with SMTP id
 e9e14a558f8ab-393e911a8c1mr302555ab.11.1721079847830; Mon, 15 Jul 2024
 14:44:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531194414.1849270-1-l.stach@pengutronix.de>
 <8b31bc0823df42e1ef4c22eac159fa58694887c7.camel@pengutronix.de>
 <ZoXRr9wcE98ijyFA@google.com> <CAP-5=fWxuPW1WGSOV-wqYXJ-4kiwefujprnGn3YfVzO+62-i-Q@mail.gmail.com>
 <b3a4282a-91b6-49a0-83d1-470cc4873dc1@linaro.org> <ac1d9124e497a1667e7cbc340f923cb4449764bb.camel@pengutronix.de>
In-Reply-To: <ac1d9124e497a1667e7cbc340f923cb4449764bb.camel@pengutronix.de>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Jul 2024 14:43:56 -0700
Message-ID: <CAP-5=fUuK8TJF-djerEZs05u227kteeZoshAdiay=3HuUpnkvg@mail.gmail.com>
Subject: Re: [PATCH] perf jevents: return potentially empty metrics table
To: Lucas Stach <l.stach@pengutronix.de>, John Garry <john.g.garry@oracle.com>
Cc: James Clark <james.clark@linaro.org>, Namhyung Kim <namhyung@kernel.org>, 
	Leo Yan <leo.yan@linux.dev>, James Clark <james.clark@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, patchwork-lst@pengutronix.de, 
	linux-perf-users@vger.kernel.org, kernel@pengutronix.de, 
	Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+John Garry

On Mon, Jul 15, 2024 at 8:54=E2=80=AFAM Lucas Stach <l.stach@pengutronix.de=
> wrote:
>
> Am Montag, dem 15.07.2024 um 16:12 +0100 schrieb James Clark:
> >
> > On 12/07/2024 10:54 pm, Ian Rogers wrote:
> > > On Wed, Jul 3, 2024 at 3:33=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > > >
> > > > Hello,
> > > >
> > > > On Mon, Jul 01, 2024 at 07:19:55PM +0200, Lucas Stach wrote:
> > > > > Hi,
> > > > >
> > > > > has this patch fallen through the cracks? It fixes a functional
> > > > > regression where the DDR controller metrics are completely unavai=
lable
> > > > > on all i.MX8M* systems and thus would be nice if someone could ha=
ve a
> > > > > look.
> > > > >
> > > > > Regards,
> > > > > Lucas
> > > > >
> > > > > Am Freitag, dem 31.05.2024 um 21:44 +0200 schrieb Lucas Stach:
> > > > > > Don't return NULL when a empty (num_pmus =3D 0) metrics table i=
s encountered,
> > > > > > as this causes many of the users to bail out, which will skip m=
atching any
> > > > > > potentially existing sys metrics later on. Instead return the e=
mpty table
> > > > > > which will be handled properly by the iterators and allows matc=
hing to
> > > > > > continue.
> > > > > >
> > > > > > This fixes metrics reporting on systems where only the sys, but=
 not the
> > > > > > core PMUs have metrics defined.
> > > > > >
> > > > > > Fixes: f20c15d13f01 ("perf pmu-events: Remember the perf_events=
_map for a PMU")
> > > > > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > > >
> > > > Looks ok to me.  Ian?
> > >
> > > Sorry I missed this, I expect to see patches on LKML and so my email
> > > filters placed this elsewhere.
> > >
> > > The change doesn't make sense. A search is requested with a PMU and
> > > you return success (the table) when there is no PMU match. If this
> > > behavior were expected then NULL should be passed as a PMU - this is
> > > the behavior in util/pmu.c and ARM is the only architecture to pass a
> > > PMU. The ARM pmu_metrics_table__find also specifically breaks
> > > heterogeneous (BIG.little) systems and this change won't impact/fix
> > > that. Perhaps there is some context I lack.
> > >
>
> The missing context is probably the call chain that I somehow omitted
> and needed to piece together again right now. The issue I'm try to fix
> here is perf stat not being able to measure metrics from a system-wide
> PMU (the i.MX8M* ddrc) only.
>
> The underlying issue is that when there is no non-systemwide PMU,
> perf_pmu__find_metrics_table will return NULL after f20c15d13f01. This
> causes metricgroup__parse_groups to drop out early. However, we need
> this function to call the chain parse_groups() ->
> metricgroup__add_metric_list -> metricgroup__add_metric, as only at
> this point system wide metrics, like the ddrc, will be added to the
> list.
>
> It is correct to drop out early, as those functions can not be called
> with a NULL parameter. Before f20c15d13f01 and after the patch
> discussed here perf_pmu__find_metrics_table() will simply return a
> table with 0 entries. The called functions are fine with this, as they
> iterate the entries and the execution flow is able to reach the point
> where the system wide events are added.

I don't see that in the commit:
```
 const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct
perf_pmu *pmu)
 {
-        const struct pmu_metrics_table *table =3D NULL;
-        char *cpuid =3D perf_pmu__getcpuid(pmu);
-        int i;
+        const struct pmu_events_map *map =3D map_for_pmu(pmu);

-        /* on some platforms which uses cpus map, cpuid can be NULL for
-         * PMUs other than CORE PMUs.
-         */
-        if (!cpuid)
+        if (!map)
                 return NULL;

-        i =3D 0;
-        for (;;) {
-                const struct pmu_events_map *map =3D &pmu_events_map[i++];
-                if (!map->arch)
-                        break;
```
Here the loop is terminated, "table =3D=3D NULL" and so the empty case
will return NULL.
```
+        if (!pmu)
+                return &map->metric_table;

-                if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
-                        table =3D &map->metric_table;
-                        break;
-                }
+        for (size_t i =3D 0; i < map->metric_table.num_pmus; i++) {
+                const struct pmu_table_entry *table_pmu =3D
&map->metric_table.pmus[i];
+                const char *pmu_name =3D
&big_c_string[table_pmu->pmu_name.offset];
+
+                if (pmu__name_match(pmu, pmu_name))
+                           return &map->metric_table;
         }
-        free(cpuid);
-        return table;
+        return NULL;
 }
```
In any case this fix won't work on BIG.little where NULL is always
returned, and so a fix higher up the stack is necessary.

Thanks,
Ian

> > > Thanks,
> > > Ian
> > >
> >
> > Yes it looks like the fix should possibly be higher up in the arm64
> > pmu_metrics_table__find().
> >
> Maybe someone can figure out how to fix this in a better way higher up
> the call chain with the description above. However, my fix looked quite
> straight forward to me, as it simply restores the behavior before
> f20c15d13f01.
>
> > Which set of JSON files are you seeing the issue with exactly Lucas? I
> > see that there are multiple versions of i.MX8M metrics.
> >
> It was first observed on a i.MX8MP, but the issue is also reproducible
> on i.MX8MM. I guess it doesn't matter which SoC is used specifically,
> the key point is that the sampling isn't able to match any specific
> PMU, but there are still system wide metrics.
>
> Regards,
> Lucas
>
> > James
> >
> > > > Thanks,
> > > > Namhyung
> > > >
> > > >
> > > > > > ---
> > > > > >   tools/perf/pmu-events/jevents.py | 2 +-
> > > > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-=
events/jevents.py
> > > > > > index e42efc16723e..0a1ed9ee1429 100755
> > > > > > --- a/tools/perf/pmu-events/jevents.py
> > > > > > +++ b/tools/perf/pmu-events/jevents.py
> > > > > > @@ -1081,7 +1081,7 @@ const struct pmu_metrics_table *perf_pmu_=
_find_metrics_table(struct perf_pmu *pm
> > > > > >           if (!map)
> > > > > >                   return NULL;
> > > > > >
> > > > > > -        if (!pmu)
> > > > > > +        if (!pmu || !map->metric_table.num_pmus)
> > > > > >                   return &map->metric_table;
> > > > > >
> > > > > >           for (size_t i =3D 0; i < map->metric_table.num_pmus; =
i++) {
> > > > >
> > >
>
