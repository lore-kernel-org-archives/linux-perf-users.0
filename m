Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7305921E1
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887505; cv=pass; b=hH8UVgdSaEYnUMCKhQ/Gk5MkSXCRuB6lKbrkHgHyIWMPjlzlt8iavcVTaIh8GNVGbo76PZQD16DhIsQ9qjDOXzRK2NNWmPUNB+VkJNxAi8xl6ePL/bjAeNF319DWFzOCaC/xU5OSk3+yfmlxDmkErDto+in7jW+raZUXwXcvIp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887505; c=relaxed/simple;
	bh=EsSaRGvIxD63ugwBKEyi2i+Vt5mUM4Sz6FUce0h4zBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NpYWpxgVymJZNlFX11B8bWS70WStosWA/SHijNZWToBuURMbegOmTDs4FUQoi7Eprwzola7kdCBvNu2BPxEvbCWWJ6/ZKfjZxHUVgvZNlLgNQdT0mYSWS6+xCSmhi6L+U2aZ40PNmwMOrZJSDqTQX4ZOLr8kKj4p8V/5IBwpJOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lyzEzKRj; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lyzEzKRj"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5306706e89dso757541cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Sep 2026 10:11:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788887502; cv=none;
        d=google.com; s=arc-20260327;
        b=Fz5qpuHB6iCYDaSFx0yD6O6gZ57KfogibrZ0EM1dXHy9WNwk1vz8ycdaSMeYx+9Bvf
         ZLbVUlxS9/alFKumUwpeaQD1ja5WwAQBKMZOd82EW45nP3wrzqXglQJ1ISGVKJdjxlaC
         r1OoWwfrLlw8WLBZ50HS0IU3SOED9hBoumRBjeVXZFVMlhCSF7EipFYLQzE3kEwLypcd
         fVSEpfJGaRqNt52McbSPql0OE3z2cTrpV1I9V9HudOIwyHtmzp4X+TN7IQ4enyaTiBYa
         lZ9mg8OpHJMOXPiGqPf6gNsMsqpIMoiFxm5CRahyI7fN+fDrrkjBk7nOgC6WUobblylQ
         onAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zrmv8bXE0okXwbTlSHoQW+GmP7+eHityU98CjsAMjJQ=;
        fh=COvGY4Xd5wdHcpmWtfjqm7O84AOROs4/xQ85kS33mlk=;
        b=rBkPgJWm/C2GU5DtxnQuxIM03pM4w3BbhBc1qsUngXUuA4nYAD8t4NH1z3oUCB0LbC
         OHwaH5xuLdPyEhXllxKxXYG2D+ktcb3YhV9b4QrL0KGKeJw6osjrygz7qZP0oE6sYA+a
         iR7iclKzZRds+8FdYbaJIsKUNq1nqHpTQD/TBnBlvx/74hS3BqrC3vyDuaOA1Llmp9Tv
         STD0lHPO0lDY9f6wlOUJS/OI7jU2cDpOQF+LEJ4RMaLNu3fYVhu2/KYwJQcfSmv0tJzK
         WfoXBAveJQMFQ2FCEwKLekLsWUVOggHG9HosNrDPNL0JANnrgDc3vWDysddOPCC5Geut
         R3Fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788887502; x=1789492302; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zrmv8bXE0okXwbTlSHoQW+GmP7+eHityU98CjsAMjJQ=;
        b=lyzEzKRjvSuAxWx7P7RutK/Jinicm/Iamy1bNZgyWe+Tv+J7JnKSG+zdZPs/iKHheZ
         LXyIVoABQwwc/PFayG1XmBPicuCrUc7tmYJGykamo4/yZwl11/teV8GkNG39fMqFD56z
         X9o+W6ljWVjaLUdgzZN78otkUXm3asFMbk2vqRWWv/XBsD/Q6DIUG7ej01Vy5dfURuvM
         jfXi621lFujbZ1LjQ2NJoADA5fokGsJwo59uXHG5E5L+QOBX+TngtWS0cqRvJF4YWXD2
         WP85jlmS8aIYv6FY8e/+DCigPQczPUSPhf9Lke135IHYGIUK9RvfQRTCQ9OxamvaxqNP
         rzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788887502; x=1789492302;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zrmv8bXE0okXwbTlSHoQW+GmP7+eHityU98CjsAMjJQ=;
        b=llenc/EIQqaQPwGdEDC6Qs8yXIgQbR7I51/6enxNSQ8OEHGWbIK8fTZQgW6HJr4cRL
         P6S5mdm914JBvAIKGCeVVRsZOwarldzpKARFdno4XefFFRnb3/qE/74RT0sZq09pLuXP
         PDXAc6kI9CWijBCSYr4ubjrqRhIhkyc2yQpAWfw3rup16bFZkMyCpDXHlbOnXC4tk+H+
         29OEen+HDWQKXwOkhoialP50ieokiQAXz6T2g9kL/VEC4PtzEFs8T2Xjnt1RClxO/zH4
         yJEhk6Vp1+SW+hB1BwyKGFvBNO4OTiLLKb0sfBhEFEBfco7Qm43yvNQq7uM8Led6anYJ
         R6XA==
X-Forwarded-Encrypted: i=1; AKwUvBzPRGQK6wDW+mT3ZaN8k8qlD3vsgMU1HEn+QTjLrii8JJCfpW3zw0d0rWdGhNvAbgiDC/aEOc1g8yaRnSOUBQN5@vger.kernel.org
X-Gm-Message-State: AFuF++mXUNp+OJvirrceovxIvg6h21p7SCbPK6A7+Z6P25iDY+1jYhJE
	QDoeAchcY1ZcjqxMhsFwHBGcnhfkfY3RHsvywy346tmUwSvzUW//pSz3e5fqehPG+qM8sQZr4+n
	YICgLPI2y+sJxF5phGUk5xZAinM0oYJZt9bGiMmuv
X-Gm-Gg: AYBFou0TQYRJ/lGHPZMYWxDGACCdVcF31jM8S63nXgXklAKrqO4RxupGtdrqvdgS03n
	xR1H+zONlqsXK9cGRFYA7wKt9E3LdyPkvHSiEpXfTd0n0LBsLi7APwnIMQEGiS70h5ZcoSDAElO
	fmYnd40cnWDDd+arj4RosgpmKXV0JCFHJLCwvKwvDkVUSNi5AGTNFZe1oGECO6pyb/d2QWafK00
	cunRZvm93Meq5YAGefdXVqbhrrzskrQTfEG+WhI0ZuunkszQqsRvFT0XImcrjKCG8/NQndu7h/5
	ezrDwTmXW//vdMckwyUCnEaBimS+QZcUvXT5IaXdAc8DmQZGvZ2tePZlcdDOtuQ7t9vEbwho4w=
	=
X-Received: by 2002:a05:622a:2589:b0:517:64f6:3365 with SMTP id
 d75a77b69052e-53065d7943emr51763311cf.4.1788887501596; Tue, 08 Sep 2026
 10:11:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-perf-evlist-uncore-cpu-b4-v1-1-604b55c025ee@sifive.com>
 <CAP-5=fX1uKg8AncsP5BVFtchgns5TquOTB10-mR5ury2CaH0sg@mail.gmail.com> <CACpYXwATq8nU9mB2SuNO6kAUNrj8bH3UjQiHd5X6=9VX4YZJgA@mail.gmail.com>
In-Reply-To: <CACpYXwATq8nU9mB2SuNO6kAUNrj8bH3UjQiHd5X6=9VX4YZJgA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 8 Sep 2026 10:11:29 -0700
X-Gm-Features: AcwNN1W_7TbKFmLSN9KMzfgyNcfZZaPeZ1089C38oYWYBJyJNhXAnE8ie59-N6k
Message-ID: <CAP-5=fVw0+Xh6Xovj_Vt1XnTT8Y0fK-+wia=oxwFmPaT06MTBg@mail.gmail.com>
Subject: Re: [PATCH] perf evlist: don't restrict uncore events to PMU CPUs
To: Nia Su <nia.su@sifive.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 8:23=E2=80=AFPM Nia Su <nia.su@sifive.com> wrote:
>
> On Fri, Sep 4, 2026 at 11:34=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Fri, Sep 4, 2026 at 6:45=E2=80=AFAM Nia Su <nia.su@sifive.com> wrote=
:
> > >
> > > The PMU CPU map has different semantics for core and uncore PMUs.
> > >
> > > For core PMUs, pmu_cpus contains the CPUs on which the event can be
> > > opened. Intersect the user-requested CPU map with the PMU CPU map to
> > > reject CPUs unsupported by the PMU.
> > >
> > > For uncore PMUs, pmu_cpus is just the default CPU to open the event o=
n,
> > > not the set of CPUs it can only be opened on.
> >
> > This isn't quite true. On a dual socket Intel machine, `pmu_cpus` will
> > contain a CPU to open the event on per-socket.
>
> Yes, I agree. My description was not precise enough. What I wanted to say
> was that pmu_cpus provides the default CPU(s) used to open an event. It
> is not necessarily an allowlist. A user may specify another valid CPU,
> which the PMU driver can resolve to the appropriate control CPU.
>
> > > The user-requested CPU may
> > > override the default and be used directly, and the driver can redirec=
t
> > > the event to the appropriate control CPU.
> >
> > Agreed.
> >
> > > Currently, __perf_evlist__propagate_maps() intersects the user-reques=
ted
> > > CPU map with pmu_cpus for all PMUs. If the user-requested CPU is not =
in
> > > pmu_cpus, the intersection becomes empty and the evsel is removed bef=
ore
> > > perf_event_open() is called.
> >
> > Could you give a command line example of the perf tool doing this? I
> > ask because I'm surprised the uncore specifying a CPU behavior has
> > been broken. As well as `perf record -C` there is also a somewhat
> > newer cpu event qualifier.
>
> I tested both approaches, but they still fail whenever a perf event is
> assigned to a CPU outside the uncore PMU's sysfs cpumask. for example,
> assigning the event to CPU 1 fails when the cpumask is 0:
>
> perf stat -C 1 -e <uncore event> -- <program>
>
> Here, for an uncore PMU, pmu_cpumask() reads the sysfs cpumask into
> pmu->cpus. When the event is created, perf copies pmu->cpus to the
> local pmu_cpus variable and then stores it in evsel->core.pmu_cpus.
> In this case, evsel->core.pmu_cpus is {0}. The CPU specified with
> "-C 1" is stored in evsel->core.cpus as {1}. Then, in this function,
> __perf_evlist__propagate_maps() then intersects the two maps, resulting
> in an empty map, so the event is removed before reaching the PMU driver.
>
> > > Skip the intersection when evsel->requires_cpu is true, which is set =
for
> > > uncore PMUs. is_pmu_core is also false for other non-core PMUs, so
> > > gating on it would have loosened this check for them too. Core PMUs
> > > continue to be restricted to their PMU CPU map.
> > >
> > > requires_cpu can also be set for BPF counters regardless of PMU type,
> > > but only when has_user_cpus is false, so this guard has no effect the=
re
> > > today.
> >
> > So the separation between libperf and perf is frustrating, and libperf
> > lacks the necessary PMU abstraction. Using requires_cpu as a proxy for
> > an uncore PMU test is okay, but it would be better if we had a boolean
> > flag especially for this. Given this, a comment should be added saying
> > that requires_cpu is used as a proxy for an uncore PMU. The real
> > meaning of requires_cpu is that the event doesn't support
> > perf_event_open with a thread.
> >
> > Thanks,
> > Ian
>
> That makes sense. I=E2=80=99ll add a comment clarifying that requires_cpu=
 is used
> as a proxy for uncore PMUs and keep the current approach for now.

So I think the flag we can use is `evsel->is_pmu_core` which captures
the !uncore behavior. I validated the fixes tag is correct.

Thanks,
Ian

> Thanks,
> Nia
>
> > > Fixes: 811082e4b668 ("perf parse-events: Support user CPUs mixed with=
 threads/processes")
> > >
> > > Assisted-by: Claude Sonnet 5
> > > Signed-off-by: Nia Su <nia.su@sifive.com>
> > > ---
> > >  tools/lib/perf/evlist.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> > > index 1f210dadd666ff818a23712ab95acaa659ccf8dc..a1064175f12ba655a9f7f=
e42e7c7e4c49ae60423 100644
> > > --- a/tools/lib/perf/evlist.c
> > > +++ b/tools/lib/perf/evlist.c
> > > @@ -80,7 +80,8 @@ static void __perf_evlist__propagate_maps(struct pe=
rf_evlist *evlist,
> > >         }
> > >
> > >         /* Ensure cpus only references valid PMU CPUs. */
> > > -       if (!perf_cpu_map__has_any_cpu(evsel->cpus) &&
> > > +       if (!evsel->requires_cpu &&
> > > +           !perf_cpu_map__has_any_cpu(evsel->cpus) &&
> > >             !perf_cpu_map__is_subset(evsel->pmu_cpus, evsel->cpus)) {
> > >                 struct perf_cpu_map *tmp =3D perf_cpu_map__intersect(=
evsel->pmu_cpus, evsel->cpus);
> > >
> > >
> > > ---
> > > base-commit: 73e3f0710014fe6d4ed98cfc02292f6121db7558
> > > change-id: 20260904-perf-evlist-uncore-cpu-b4-418af0f17c80
> > >
> > > --
> > >
