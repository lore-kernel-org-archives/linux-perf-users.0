Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6990158855
	for <linux-perf-users@vger.kernel.org>; Wed, 15 May 2024 17:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715795336; cv=none; b=kNup+mPJE5HBPmGGjo9k5AJZcLGaO78ZFR+gGiFzx33v84wgInBnplp42CkDbYOhvfsF9PqQs6Td972L6CKASf4UwT5as5bEmszHSZK8BR/uN4u+KNVzNQnI38jLFigESap6922TF8mlSeu5EBLX6qSwX7VBVag7QtFXEiPaCj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715795336; c=relaxed/simple;
	bh=UUzQ5NaPArsqV7EzmAil3TiG02ZO1xm3CWdIobhck/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ueRxHYgYkkYkbvbjeGFLP/KhJilKZFBAOzvJUoQNA8/n9YzybErELUxE+OOtyqo4eqYkksxz4UGjZuTQvFwA8yvzcBc0U4Awd0WthTKYANmt7eTCtyNTEadyBlpjMss6p9dK3qi6qy/UEY+7VxpQLnnSSVkUVe5W9kWLK836l9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cq/TK0Sx; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cq/TK0Sx"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36c6056f7bdso77805ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 15 May 2024 10:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715795333; x=1716400133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ntGT+XQ5Dg40kFpF5ng16PmKkDdGbsaz/CFaC9Twh0=;
        b=cq/TK0SxB0y+z+3Uej+rSAm99YYf0mhUy41TEct8d1czOf/Je/tYxznklG226YafyP
         E7CWEDoEXvegu5TfZo0iueUdHHvbIa5wfWs5klLYhEtk0JLjFU1aLENWBCZSIkH832R3
         kUxaHHJUelAEYon1q/2Hs7HYMpsQES6i1tZpcR9cp/mAe4OwqyWGiq2nk7V8dcJ2xIqJ
         /ni60iwURjghYM6iDh1dmTYnGSB8kq4cv+xDaiPjgAN3Y9F9NjOdjzC1w3gWz2uJowyz
         LMMsG1cpdJLhc1Wn6V1s8Kg+93fydOQJpHytEluK8JR32rwFuIYYVyrf754fkIj4fuj/
         c3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715795333; x=1716400133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ntGT+XQ5Dg40kFpF5ng16PmKkDdGbsaz/CFaC9Twh0=;
        b=kCWQ7XrNb+aVB3X+KRVzY8yn7NHxKcM5m62PFZNg3V5DY6X6iRwJA5JF6UHV3PgITd
         OqxhdXBec7Lo357+4NJAAXlt8Rxcwbd6LljZITHiB5FiS5yGB3ye6u5wbiUtYNwRhZgw
         fvWqSxC7UmRurTUfedw+vkotXCT3ZO/QMW8iK9lm6aen9aHel8PfnRhj54nHIAUgzzJk
         MVTjEwy5lBirQMod8OlUCqGK/neSizGvQJxN2/G8qNNh5dottFbQ8i8HasLuK5pIpci1
         uNHQ5iFNMDNmrrhgEBs4M44Cr9kKGa3HzRIsxyHUuZKdcQSTLflcj5a1WeWQx75F8Val
         vKEw==
X-Forwarded-Encrypted: i=1; AJvYcCWauiEy2xOUgA2qkgMzwYFPQl5f8ljma+byMI0GjLpTnXHUF++xxv5MSdK27tEOjPqw7T0cMmIXwYWD4NhZInY2iRH7IDXk3fH0Z5X/N+zibA==
X-Gm-Message-State: AOJu0Yw4qsP2HvUrgqlvODyJzOUsm/iJZU2C37n6BOLUYY41scSD0Q6u
	LbZ/P43F0VGK8fzym7h0h/wwx55qVUrOnTRGncl9BXTNaalDKP5IaPUJqCBbavoEMCWMLIsbSbv
	ekMAUZqWvEaq2A/cVNT3vclaXYOqjxyBJDeNo
X-Google-Smtp-Source: AGHT+IHPwzs2F32xA97ScCj6OGavEN1PKGp0PuTn0AuUSXvnRaIsnA/5sK2GAanwyOBfgfvAVarnALeAs9VhXZygZkc=
X-Received: by 2002:a92:d90d:0:b0:36c:4c58:bbc2 with SMTP id
 e9e14a558f8ab-36cccb4f827mr11544465ab.23.1715795332589; Wed, 15 May 2024
 10:48:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240511003601.2666907-1-irogers@google.com> <b205e882-a9dc-44fd-bbc3-53089433eae5@oracle.com>
In-Reply-To: <b205e882-a9dc-44fd-bbc3-53089433eae5@oracle.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 15 May 2024 10:48:41 -0700
Message-ID: <CAP-5=fUFzr3PymeSaaO=c-OnvhozoORFmeXmwWdqFhbVqknT3Q@mail.gmail.com>
Subject: Re: [PATCH v1] perf pmu: Count sys and cpuid json events separately
To: John Garry <john.g.garry@oracle.com>
Cc: Jia He <justin.he@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 9:09=E2=80=AFAM John Garry <john.g.garry@oracle.com=
> wrote:
>
> On 10/05/2024 18:36, Ian Rogers wrote:
> > Sys events are eagerly loaded as each event has a compat option that
> > may mean the event is or isn't associated with the PMU. These
> > shouldn't be counted as loaded_json_events as that is used for json
> > events matching the CPUID that may or may not have been loaded. The
> > mismatch causes issues on ARM64 that uses sys events.
> >
> > Reported-by: Jia He <justin.he@arm.com>
> > Closes: https://urldefense.com/v3/__https://lore.kernel.org/lkml/202405=
10024729.1075732-1-justin.he@arm.com/__;!!ACWV5N9M2RV99hQ!KVhaRPLqS7T1s6p50=
6Gv0zFNdlTR1exCUrXM3UIDr0EdrRFwrzM3W9ntkxw42jNeG01P7H78r0c-nz8FVQQ$
> > Fixes: e6ff1eed3584 ("perf pmu: Lazily add JSON events")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/util/pmu.c | 70 ++++++++++++++++++++++++++++++------------=
-
> >   tools/perf/util/pmu.h |  6 ++--
> >   2 files changed, 53 insertions(+), 23 deletions(-)
> >
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index b3b072feef02..888ce9912275 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -36,6 +36,18 @@ struct perf_pmu perf_pmu__fake =3D {
> >
> >   #define UNIT_MAX_LEN        31 /* max length for event unit name */
> >
> > +enum event_source {
> > +     /* An event loaded from /sys/devices/<pmu>/events. */
> > +     EVENT_SRC_SYSFS,
> > +     /* An event loaded from a CPUID matched json file. */
> > +     EVENT_SRC_CPU_JSON,
> > +     /*
> > +      * An event loaded from a /sys/devices/<pmu>/identifier matched j=
son
> > +      * file.
> > +      */
> > +     EVENT_SRC_SYS_JSON,
>
> If a json sys event aliases to a EVENT_SRC_SYSFS event, this is
> considered a EVENT_SRC_SYS_JSON event source, right?

Thanks John. The current use for this enum is just in
perf_pmu__new_alias to say which source is requesting the new
alias/event for the lazy loading book keeping. It isn't held in the
perf_pmu_alias as events may appear in both sysfs and json and we
update in that case.

> > +};
> > +
> >   /**
> >    * struct perf_pmu_alias - An event either read from sysfs or builtin=
 in
> >    * pmu-events.c, created by parsing the pmu-events json files.
> > @@ -521,7 +533,7 @@ static int update_alias(const struct pmu_event *pe,
> >
> >   static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name=
,
> >                               const char *desc, const char *val, FILE *=
val_fd,
> > -                             const struct pmu_event *pe)
> > +                             const struct pmu_event *pe, enum event_so=
urce src)
> >   {
> >       struct perf_pmu_alias *alias;
> >       int ret;
> > @@ -574,25 +586,30 @@ static int perf_pmu__new_alias(struct perf_pmu *p=
mu, const char *name,
> >               }
> >               snprintf(alias->unit, sizeof(alias->unit), "%s", unit);
> >       }
> > -     if (!pe) {
> > -             /* Update an event from sysfs with json data. */
> > -             struct update_alias_data data =3D {
> > -                     .pmu =3D pmu,
> > -                     .alias =3D alias,
> > -             };
> > -
> > +     switch (src) {
> > +     default:
> > +     case EVENT_SRC_SYSFS:
> >               alias->from_sysfs =3D true;
> >               if (pmu->events_table) {
> > +                     /* Update an event from sysfs with json data. */
> > +                     struct update_alias_data data =3D {
> > +                             .pmu =3D pmu,
> > +                             .alias =3D alias,
> > +                     };
> >                       if (pmu_events_table__find_event(pmu->events_tabl=
e, pmu, name,
> >                                                        update_alias, &d=
ata) =3D=3D 0)
> > -                             pmu->loaded_json_aliases++;
> > +                             pmu->cpu_json_aliases++;
>
> seems strange that matching for EVENT_SRC_SYSFS increases
> pmu->cpu_json_aliases

Yep. There's a comment at the start of the "if", we're trying to
update a srcfs event with json data as the pmu->events_table contained
the event. As the json event won't be used, it just updates the srcfs
event, we need to account for that when giving the number of
events/aliases.

> >               }
> > -     }
> > -
> > -     if (!pe)
> >               pmu->sysfs_aliases++;
> > -     else
> > -             pmu->loaded_json_aliases++;
> > +             break;
> > +     case  EVENT_SRC_CPU_JSON:
> > +             pmu->cpu_json_aliases++;
> > +             break;
> > +     case  EVENT_SRC_SYS_JSON:
> > +             pmu->sys_json_aliases++;
> > +             break;
> > +
> > +     }
> >       list_add_tail(&alias->list, &pmu->aliases);
> >       return 0;
> >   }
> > @@ -653,7 +670,8 @@ static int __pmu_aliases_parse(struct perf_pmu *pmu=
, int events_dir_fd)
> >               }
> >
> >               if (perf_pmu__new_alias(pmu, name, /*desc=3D*/ NULL,
> > -                                     /*val=3D*/ NULL, file, /*pe=3D*/ =
NULL) < 0)
> > +                                     /*val=3D*/ NULL, file, /*pe=3D*/ =
NULL,
> > +                                     EVENT_SRC_SYSFS) < 0)
> >                       pr_debug("Cannot set up %s\n", name);
> >               fclose(file);
> >       }
> > @@ -946,7 +964,8 @@ static int pmu_add_cpu_aliases_map_callback(const s=
truct pmu_event *pe,
> >   {
> >       struct perf_pmu *pmu =3D vdata;
> >
> > -     perf_pmu__new_alias(pmu, pe->name, pe->desc, pe->event, /*val_fd=
=3D*/ NULL, pe);
> > +     perf_pmu__new_alias(pmu, pe->name, pe->desc, pe->event, /*val_fd=
=3D*/ NULL,
> > +                         pe, EVENT_SRC_CPU_JSON);
> >       return 0;
> >   }
> >
> > @@ -981,13 +1000,14 @@ static int pmu_add_sys_aliases_iter_fn(const str=
uct pmu_event *pe,
> >               return 0;
> >
> >       if (pmu_uncore_alias_match(pe->pmu, pmu->name) &&
> > -                     pmu_uncore_identifier_match(pe->compat, pmu->id))=
 {
> > +         pmu_uncore_identifier_match(pe->compat, pmu->id)) {
> >               perf_pmu__new_alias(pmu,
> >                               pe->name,
> >                               pe->desc,
> >                               pe->event,
> >                               /*val_fd=3D*/ NULL,
> > -                             pe);
> > +                             pe,
> > +                             EVENT_SRC_SYS_JSON);
> >       }
> >
> >       return 0;
> > @@ -1082,6 +1102,12 @@ struct perf_pmu *perf_pmu__lookup(struct list_he=
ad *pmus, int dirfd, const char
> >       pmu->max_precise =3D pmu_max_precise(dirfd, pmu);
> >       pmu->alias_name =3D pmu_find_alias_name(pmu, dirfd);
> >       pmu->events_table =3D perf_pmu__find_events_table(pmu);
> > +     /*
> > +      * Load the sys json events/aliases when loading the PMU as each =
event
> > +      * may have a different compat regular expression. We therefore c=
an't
> > +      * know the number of sys json events/aliases without computing t=
he
> > +      * regular expressions for them all.
> > +      */
> >       pmu_add_sys_aliases(pmu);
> >       list_add_tail(&pmu->list, pmus);
> >
> > @@ -1739,12 +1765,14 @@ size_t perf_pmu__num_events(struct perf_pmu *pm=
u)
> >       size_t nr;
> >
> >       pmu_aliases_parse(pmu);
> > -     nr =3D pmu->sysfs_aliases;
> > +     nr =3D pmu->sysfs_aliases + pmu->sys_json_aliases;;
> >
> >       if (pmu->cpu_aliases_added)
> > -              nr +=3D pmu->loaded_json_aliases;
> > +              nr +=3D pmu->cpu_json_aliases;
> >       else if (pmu->events_table)
> > -             nr +=3D pmu_events_table__num_events(pmu->events_table, p=
mu) - pmu->loaded_json_aliases;
> > +             nr +=3D pmu_events_table__num_events(pmu->events_table, p=
mu) - pmu->cpu_json_aliases;
> > +     else
> > +             assert(pmu->cpu_json_aliases =3D=3D 0);
> >
> >       return pmu->selectable ? nr + 1 : nr;
> >   }
> > diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> > index 561716aa2b25..b2d3fd291f02 100644
> > --- a/tools/perf/util/pmu.h
> > +++ b/tools/perf/util/pmu.h
> > @@ -123,8 +123,10 @@ struct perf_pmu {
> >       const struct pmu_events_table *events_table;
> >       /** @sysfs_aliases: Number of sysfs aliases loaded. */
> >       uint32_t sysfs_aliases;
> > -     /** @sysfs_aliases: Number of json event aliases loaded. */
> > -     uint32_t loaded_json_aliases;
> > +     /** @cpu_json_aliases: Number of json event aliases loaded specif=
ic to the CPUID. */
> > +     uint32_t cpu_json_aliases;
>
> it seems strange that we allow a pmu to have both cpu_json_aliases and
> sys_json_aliases count. A union could be used, but that would complicate
> things.

Yeah. There are a bunch of things the currently sys json allows that
we may want to change. Lazy loading has made "perf bench internals
pmu-scan" about 10 times faster, this matters on large servers that
may be getting on for 100s of particularly uncore PMUs. Sys json
events don't allow lazy loading as each json event needs its Compat
field checking against the PMU's identifier file. We're paying a cost
for sys json events in cases where the events are never used. If we
keep this behavior we could at least ahead of time compile the regular
expressions in the sys event json using lex, we should do similar for
CPUIDs. Anyway, I think there's lots of room for improvements. The
focus in this change was on correctness and I'm not worried about the
possible 4 byte per PMU saving here.

Thanks,
Ian

>
> > +     /** @sys_json_aliases: Number of json event aliases loaded matchi=
ng the PMU's identifier. */
> > +     uint32_t sys_json_aliases;
> >       /** @sysfs_aliases_loaded: Are sysfs aliases loaded from disk? */
> >       bool sysfs_aliases_loaded;
> >       /**
>
