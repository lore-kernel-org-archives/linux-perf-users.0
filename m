Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B7E208A4
	for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715620768; cv=none; b=sdkwQY3x7jIw82kajbshbG9OxV1q89SFqJzRAsggBUxC7B3Aj7+caMyf8OfKzoU34XV9n3us9R8aMM1Sos2ll1GaY8JQtoGi1/2gnEfkWaE7F7AUGzWt7whtBdBX3OylOGlsYeqlmuJ1unMH+6pTR9/Jprz0BMH4MUgWITJlXgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715620768; c=relaxed/simple;
	bh=MJiVwiM18XryHUPJhid6EktmMnrxfcyKLI1aF/pSACw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ud9MVXRTyzeyboerkoaZWDBpTXFcK+lInY94A4ZNLH3rFiQbYfkHG4mYeRsinSkAvKmAdP/PiTss638XQ/XGHP48jom/nvxzMdDtqyNvMOw71vNbJxLwUhUz5a0H28YQTYEi9L6ObwEkOKWI2N9+z1gRPjdzB92K/PBZmMUfwPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2Ei9j5Wg; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2Ei9j5Wg"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36c6789b520so353745ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 10:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715620765; x=1716225565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0LcTyeTsxJaPnZ45cfiBgAVI9jES1Y4g+ohTkoWGUw=;
        b=2Ei9j5Wg6O6/qB40/2aulFUIKXSQWn61xjUeF1fmhSS1aMrtu5QfaHTae9VZB2uY0Z
         /z3sgGReAHsJnMC1avCOSFjaEr2AKchf/Ku3bGZD/txcPm1kZEsKu9cMZoXhDRJwf/nh
         A5+rxzvBarfGhVJE6zfcjWtYTYkCPIr3kUdXHj+0tYYMGkHFtGjNWSdv2F9y2cte79QC
         H4OM56RbvsczCHHlWVwkoD2LePrxAYuhEMOxB3h+1W84ekzJIoU8uh9BvVuSbUyKIlox
         Ufo81MAKjO99hz/N3uqXsKuT94J3ZpgDjx8pCkWMBq7uswl2hcD0lxC5yb1pNDZSG7WM
         cWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715620765; x=1716225565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0LcTyeTsxJaPnZ45cfiBgAVI9jES1Y4g+ohTkoWGUw=;
        b=IpOX5v3wGO91LxOjVTLAk+pECB8hZZOXroGI5xDIa1VR5AY4x6MUMWDhwIfPhR2I2o
         ZC13w5CCg1IqOu77DLprkf3eMK7z9S7bqtYkFoT0FfLE7l1FrRCErpcizNQrAQbxI2dw
         rteAgTnhKAGc+dk3X+REj9jHcOuFQ8kjcmlPBuLw6t7vPTc/7fSbNqIxW14KQY/zPdJd
         2HVnZfIzJ4ERa17ZJTrr5AkPcdJPyDkiVvBCiSyY+a8u2axaoUz75u3cFt5YB1cV2xqD
         SI+6P4SQQuImWMIKc7yaCGufix00IH9r9RO85zSazQDMRReZQFE1UN5pJWePLrLM0hyI
         stXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkFhOElI1Lq86t8ho5aVjpkk0vAmaQo6nRkU2tWdJckfiHPDAnUQ0iwXPyTOtQVrgBCfzeDHKlw9jWIYBt/b7h+rCLlpM2aq3cTCRuYDQN9Q==
X-Gm-Message-State: AOJu0YwHjSBv2P//NpaTOR5H3kziIUZb0kFwGb0BtVunesHLZTGUGYHI
	+cJdVpTYXYBH8Aeyl+YYcpx1wkWqy2SOtaAYanE350Q6JYbXQ2UAqNq1ymvHdFNRd2yxdnb37oY
	A9aeK/r5ylJlOWwC4qXeqUGt2f2NwIT8zngrd
X-Google-Smtp-Source: AGHT+IHz250z2fsSfufWt35b1l38Vjd0Oami4jYQovh1cLlCfllpQsmtMEwp1o+6AyTLkjf+AYr8RDCjJC6mp5mdSQ4=
X-Received: by 2002:a05:6e02:c71:b0:36c:5511:4a4a with SMTP id
 e9e14a558f8ab-36ccb8904ccmr4746675ab.6.1715620765372; Mon, 13 May 2024
 10:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240511003601.2666907-1-irogers@google.com> <DBBPR08MB4538FF1CC6CC1C3CD37FCF76F7E22@DBBPR08MB4538.eurprd08.prod.outlook.com>
In-Reply-To: <DBBPR08MB4538FF1CC6CC1C3CD37FCF76F7E22@DBBPR08MB4538.eurprd08.prod.outlook.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 May 2024 10:19:13 -0700
Message-ID: <CAP-5=fWqGvVZxjjEb5MvTNK6oJXheedkohFw4xx3z1N_Csvr_A@mail.gmail.com>
Subject: Re: [PATCH v1] perf pmu: Count sys and cpuid json events separately
To: Justin He <Justin.He@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <Mark.Rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <James.Clark@arm.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Garry <john.g.garry@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 12, 2024 at 7:22=E2=80=AFPM Justin He <Justin.He@arm.com> wrote=
:
>
>
>
> > -----Original Message-----
> > From: Ian Rogers <irogers@google.com>
> > Sent: Saturday, May 11, 2024 8:36 AM
> > To: Justin He <Justin.He@arm.com>; Peter Zijlstra <peterz@infradead.org=
>;
> > Ingo Molnar <mingo@redhat.com>; Arnaldo Carvalho de Melo
> > <acme@kernel.org>; Namhyung Kim <namhyung@kernel.org>; Mark Rutland
> > <Mark.Rutland@arm.com>; Alexander Shishkin
> > <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@kernel.org>; Ian=
 Rogers
> > <irogers@google.com>; Adrian Hunter <adrian.hunter@intel.com>; Kan Lian=
g
> > <kan.liang@linux.intel.com>; James Clark <James.Clark@arm.com>;
> > linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org; John Ga=
rry
> > <john.g.garry@oracle.com>
> > Subject: [PATCH v1] perf pmu: Count sys and cpuid json events separatel=
y
> >
> > Sys events are eagerly loaded as each event has a compat option that ma=
y mean
> > the event is or isn't associated with the PMU. These shouldn't be count=
ed as
> > loaded_json_events as that is used for json events matching the CPUID t=
hat may
> > or may not have been loaded. The mismatch causes issues on ARM64 that u=
ses
> > sys events.
> >
> > Reported-by: Jia He <justin.he@arm.com>
> > Closes:
> > https://lore.kernel.org/lkml/20240510024729.1075732-1-justin.he@arm.com
> > /
> > Fixes: e6ff1eed3584 ("perf pmu: Lazily add JSON events")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/pmu.c | 70 ++++++++++++++++++++++++++++++-------------
> >  tools/perf/util/pmu.h |  6 ++--
> >  2 files changed, 53 insertions(+), 23 deletions(-)
> >
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c index
> > b3b072feef02..888ce9912275 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -36,6 +36,18 @@ struct perf_pmu perf_pmu__fake =3D {
> >
> >  #define UNIT_MAX_LEN 31 /* max length for event unit name */
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
> > +};
> > +
> >  /**
> >   * struct perf_pmu_alias - An event either read from sysfs or builtin =
in
> >   * pmu-events.c, created by parsing the pmu-events json files.
> > @@ -521,7 +533,7 @@ static int update_alias(const struct pmu_event *pe,
> >
> >  static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
> >                               const char *desc, const char *val, FILE *=
val_fd,
> > -                             const struct pmu_event *pe)
> > +                             const struct pmu_event *pe, enum event_so=
urce src)
> >  {
> >       struct perf_pmu_alias *alias;
> >       int ret;
> > @@ -574,25 +586,30 @@ static int perf_pmu__new_alias(struct perf_pmu
> > *pmu, const char *name,
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
e, pmu,
> > name,
> >                                                        update_alias, &d=
ata) =3D=3D 0)
> > -                             pmu->loaded_json_aliases++;
> > +                             pmu->cpu_json_aliases++;
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
> >  }
> > @@ -653,7 +670,8 @@ static int __pmu_aliases_parse(struct perf_pmu *pmu=
,
> > int events_dir_fd)
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
> > @@ -946,7 +964,8 @@ static int pmu_add_cpu_aliases_map_callback(const
> > struct pmu_event *pe,  {
> >       struct perf_pmu *pmu =3D vdata;
> >
> > -     perf_pmu__new_alias(pmu, pe->name, pe->desc, pe->event, /*val_fd=
=3D*/
> > NULL, pe);
> > +     perf_pmu__new_alias(pmu, pe->name, pe->desc, pe->event, /*val_fd=
=3D*/
> > NULL,
> > +                         pe, EVENT_SRC_CPU_JSON);
> >       return 0;
> >  }
> >
> > @@ -981,13 +1000,14 @@ static int pmu_add_sys_aliases_iter_fn(const str=
uct
> > pmu_event *pe,
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
> > @@ -1082,6 +1102,12 @@ struct perf_pmu *perf_pmu__lookup(struct
> > list_head *pmus, int dirfd, const char
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
> > @@ -1739,12 +1765,14 @@ size_t perf_pmu__num_events(struct perf_pmu
> > *pmu)
> >       size_t nr;
> >
> >       pmu_aliases_parse(pmu);
> > -     nr =3D pmu->sysfs_aliases;
> > +     nr =3D pmu->sysfs_aliases + pmu->sys_json_aliases;;
>
> Nits: double ";", others lgtm.
>
> This fixes the error on the Arm N2 server:
> Unexpected event smmuv3_pmcg_3f002/smmuv3_pmcg_3f002/transaction//
> Unexpected event smmuv3_pmcg_3f042/smmuv3_pmcg_3f042/transaction//
> Unexpected event smmuv3_pmcg_3f062/smmuv3_pmcg_3f062/transaction//
> Unexpected event smmuv3_pmcg_3f402/smmuv3_pmcg_3f402/transaction//
> Unexpected event smmuv3_pmcg_3f442/smmuv3_pmcg_3f442/transaction//
> .....
>
> Please feel free to add
> Tested-by: Jia He <justin.he@arm.com>

Thanks Justin! I noticed Arnaldo has picked this up in the next tree:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/co=
mmit/?h=3Dperf-tools-next&id=3Dd9c5f5f94c2d356fdf3503f7fcaf254512bc032d
Would be great to add the Tested-by and address the ;; issue, good catch :-=
)

Ian

> --
> Cheers,
> Justin (Jia He)
> >
> >       if (pmu->cpu_aliases_added)
> > -              nr +=3D pmu->loaded_json_aliases;
> > +              nr +=3D pmu->cpu_json_aliases;
> >       else if (pmu->events_table)
> > -             nr +=3D pmu_events_table__num_events(pmu->events_table, p=
mu) -
> > pmu->loaded_json_aliases;
> > +             nr +=3D pmu_events_table__num_events(pmu->events_table, p=
mu) -
> > pmu->cpu_json_aliases;
> > +     else
> > +             assert(pmu->cpu_json_aliases =3D=3D 0);
> >
> >       return pmu->selectable ? nr + 1 : nr;
> >  }
> > diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h index
> > 561716aa2b25..b2d3fd291f02 100644
> > --- a/tools/perf/util/pmu.h
> > +++ b/tools/perf/util/pmu.h
> > @@ -123,8 +123,10 @@ struct perf_pmu {
> >       const struct pmu_events_table *events_table;
> >       /** @sysfs_aliases: Number of sysfs aliases loaded. */
> >       uint32_t sysfs_aliases;
> > -     /** @sysfs_aliases: Number of json event aliases loaded. */
> > -     uint32_t loaded_json_aliases;
> > +     /** @cpu_json_aliases: Number of json event aliases loaded specif=
ic to the
> > CPUID. */
> > +     uint32_t cpu_json_aliases;
> > +     /** @sys_json_aliases: Number of json event aliases loaded matchi=
ng the
> > PMU's identifier. */
> > +     uint32_t sys_json_aliases;
> >       /** @sysfs_aliases_loaded: Are sysfs aliases loaded from disk? */
> >       bool sysfs_aliases_loaded;
> >       /**
> > --
> > 2.45.0.118.g7fe29c98d7-goog
>
> IMPORTANT NOTICE: The contents of this email and any attachments are conf=
idential and may also be privileged. If you are not the intended recipient,=
 please notify the sender immediately and do not disclose the contents to a=
ny other person, use it for any purpose, or store or copy the information i=
n any medium. Thank you.
