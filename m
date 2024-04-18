Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F3D16F8E4
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Apr 2024 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456659; cv=none; b=QLAZwvgwCSJeelsjQJ73dRa17TdA3idO6vyqid5ua92/fvk9El93K4yeWaiHQ6WMUrqhl8nhmKVwEw74sPg68uHJr7x+cgAqBRMZa8YJUTA3go+m6jtHpzH6w++FB2m4CkKhco7l2SLrcb6R+r1fFvzggPj0VTFj5uwYW82iK9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456659; c=relaxed/simple;
	bh=HmLfpMcHYrzZbuc/PhIlXzh89lXk9MVpBVgqARZJ8TE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Er8/ZfLVO43jkDyY9pLak7UpTqRTfNyliptoR1M60jC4XayJXV5IK695zm0LmbKokrUIJaLi2ioufVPogP3dEsipF6DHZgZxCtYzF5cQ5TZF726GQnxApMRB5Nu56J3ak14VnEYPGwbbZs7tHYnh7Db8PhrdR5BUVColW1YR3es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gUJ4GnFl; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gUJ4GnFl"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e86333bbe9so184195ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Apr 2024 09:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713456656; x=1714061456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmLpmQ1JT6UkUs6uYJ7SZ3Nu+oVNswf7rXObpFV/9rU=;
        b=gUJ4GnFljs3NdmqOXMP/UtGyMp1VDtls0i9qzPBhoI4C0UNycb8nTAnN2+Ihx9E2Bb
         I0c3MMcAEyORX2ECJaR9/ek+Fn5ZjG2y8mBuz+d4SZwcmR0WPuCwm5hm5jgyE6uRZ5x6
         FAK+mW3bUuHtq1/CKTdtBAPqSuvruiBgbhimLGpoXxuBJb3dPn8JUuZvy94TT9CGDil6
         TQzx7+bVsZPelPS9vNarOFgI8S+Trp1GM05P/Gez1FyzfBdR5+HI+ORJRsFgsh+sfOy1
         JgUetIsH1VhUvl/qrMQYqMs6LioAyv10ayU2VTk6HxeFxQqOydN4b7PWiUu6nCM9xTMU
         aKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713456656; x=1714061456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmLpmQ1JT6UkUs6uYJ7SZ3Nu+oVNswf7rXObpFV/9rU=;
        b=Jj/ztb46bfR9m/mp1qb2lN/2Lq34J0AvYxBZZ0rVeej1GUCvdiltNQ08DfHo/pYukc
         yUfAi2lv3fMD4Q1XahxuCqCpRvDJEaqgik2QdjPE2K6ouDP+QIRIPibXSU785Yp95G07
         tf7U3AwEF/wOcaqoux7skeWUXwefehVy3DLQtB7j9/+OxPSowaTjvxZSIhZvbRt4H9O4
         9RiSF0AGqyCr9lt/KnNk0ngvQe60tfxoGqjuAXzplNhUgR5m++JoV7fyqSm7kHmsDAUU
         DTAvQaIUQ6Zuo6Og0//grHl30fGBuFTMt4h5vR4JqkuwtUgkVhmRng0C2CJ7rpt1Y7Ez
         nVfw==
X-Forwarded-Encrypted: i=1; AJvYcCV7AABAwLNyisjxXP+HhWEgKJQkjwoQFjCLShOwv0CZoTC82THF58iSGRTWTHmmv9U9evpV8lzeL9zQm2wbnnC8Oc9qWK9AX6UkkR+QK9Y5Kg==
X-Gm-Message-State: AOJu0YyZFgWOY/cYu2i3u/kCA9ok/HDHnOSCnLNFrNMUM5wXFOdgz04j
	BnQS2w/JfyAxd85YFLjuepLXGUruvQ0YNz3IbZvSmmDg+D3RP81oB61pYqnMEdfg+BRAffG/WF0
	rMxmnN7m4Se81FbYfTnDBi8yAQE2a8WtHifth
X-Google-Smtp-Source: AGHT+IEacHdschB/zABXcMxk5QjHIwjCbz4AMh3Jc2XakPc3yzUMgZzafeJDoIf5eLklNdZJj2ACwvNgTYFLPbBkEyc=
X-Received: by 2002:a17:902:ec92:b0:1e2:afe3:9128 with SMTP id
 x18-20020a170902ec9200b001e2afe39128mr268330plg.14.1713456655880; Thu, 18 Apr
 2024 09:10:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240413040812.4042051-1-irogers@google.com> <550e5ca5-f28c-48e1-b86e-9de3458a5737@linux.intel.com>
In-Reply-To: <550e5ca5-f28c-48e1-b86e-9de3458a5737@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 18 Apr 2024 09:10:42 -0700
Message-ID: <CAP-5=fWCw2GWM-B4k_uYm+xVRn+GgKXBR5vq-2==T16Q0ej45Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1] perf pmu: Assume sysfs events are always lowercase
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 8:35=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-04-13 12:08 a.m., Ian Rogers wrote:
> > Perf event names aren't case sensitive. For sysfs events the entire
> > directory of events is read then iterated comparing names in a case
> > insensitive way, most often to see if an event is present.
> >
> > Consider:
> > $ perf stat -e inst_retired.any true
> >
> > The event inst_retired.any may be present in any PMU, so every PMU's
> > sysfs events are loaded and then searched with strcasecmp to see if
> > any match. This event is only present on the cpu PMU as a json event
> > so a lot of events were loaded from sysfs unnecessarily just to prove
> > an event didn't exist there.
> >
> > This change avoids loading all the events by assuming sysfs event
> > names are always lowercase.
>
> From what I searched in the kernel, it looks like all the sysfs event
> names (from different ARCHs and devices) are lowercase. It should not
> break the existing usages.
> I don't see a reason why a event name must be uppercase.
> However, I think we need to add something to guarantee the assumption.
>
> Could you please update the doc to describe the assumption?
> Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> So everybody can follow the rule.
>
> I think a perf test is required as well.
> Maybe we can extend the test__pmu_events() to do the name check.

Great suggestions, I'll do a v2 with this. I've been thinking for a
while we need a PMU driver test. A particular problem is for weak
groups, where broken drivers don't return perf event open failures for
groups that exceed the number of counters. There's the enum value
MetricNoGroupEvents to workaround this problem in metrics, but it
would still be nice to get the drivers fixed. So rather than keep
growing the event parsing tests, I think adding it to the pmu test and
making the pmu test a fuller suite checking properties of PMUs would
be good.

Thanks,
Ian

> Thanks,
> Kan
>
> > It then uses file exists and only loads
> > the events when the desired event is present.
> >
> > For the example above, the number of openat calls measured by perf
> > trace on a tigerlake laptop goes from 325 down to 255. The reduction
> > will be larger for machines with many PMUs, particularly replicated
> > uncore PMUs.
> >
> > Make pmu_aliases_parse early return when aliases are loaded, ensure
> > the function is called before all uses of the aliases list.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/pmu.c | 20 +++++++++++++++-----
> >  1 file changed, 15 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index ab30f22eaf10..ce72c99e4f61 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -425,9 +425,16 @@ static struct perf_pmu_alias *perf_pmu__find_alias=
(struct perf_pmu *pmu,
> >  {
> >       struct perf_pmu_alias *alias;
> >
> > -     if (load && !pmu->sysfs_aliases_loaded)
> > -             pmu_aliases_parse(pmu);
> > +     if (load && !pmu->sysfs_aliases_loaded) {
> > +             char event_file_name[FILENAME_MAX + 8];
> >
> > +             scnprintf(event_file_name, sizeof(event_file_name), "even=
ts/%s", name);
> > +             for (size_t i =3D 7, n =3D 7 + strlen(name); i < n; i++)
> > +                     event_file_name[i] =3D tolower(event_file_name[i]=
);
> > +
> > +             if (perf_pmu__file_exists(pmu, event_file_name))
> > +                     pmu_aliases_parse(pmu);
> > +     }
> >       list_for_each_entry(alias, &pmu->aliases, list) {
> >               if (!strcasecmp(alias->name, name))
> >                       return alias;
> > @@ -605,6 +612,9 @@ static int pmu_aliases_parse(struct perf_pmu *pmu)
> >       size_t len;
> >       int fd, dir_fd;
> >
> > +     if (pmu->sysfs_aliases_loaded)
> > +             return 0;
> > +
> >       len =3D perf_pmu__event_source_devices_scnprintf(path, sizeof(pat=
h));
> >       if (!len)
> >               return 0;
> > @@ -1689,9 +1699,7 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
> >  {
> >       size_t nr;
> >
> > -     if (!pmu->sysfs_aliases_loaded)
> > -             pmu_aliases_parse(pmu);
> > -
> > +     pmu_aliases_parse(pmu);
> >       nr =3D pmu->sysfs_aliases;
> >
> >       if (pmu->cpu_aliases_added)
> > @@ -1750,6 +1758,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu=
, bool skip_duplicate_pmus,
> >       struct strbuf sb;
> >
> >       strbuf_init(&sb, /*hint=3D*/ 0);
> > +     pmu_aliases_parse(pmu);
> >       pmu_add_cpu_aliases(pmu);
> >       list_for_each_entry(event, &pmu->aliases, list) {
> >               size_t buf_used;
> > @@ -2154,6 +2163,7 @@ const char *perf_pmu__name_from_config(struct per=
f_pmu *pmu, u64 config)
> >       if (!pmu)
> >               return NULL;
> >
> > +     pmu_aliases_parse(pmu);
> >       pmu_add_cpu_aliases(pmu);
> >       list_for_each_entry(event, &pmu->aliases, list) {
> >               struct perf_event_attr attr =3D {.config =3D 0,};
