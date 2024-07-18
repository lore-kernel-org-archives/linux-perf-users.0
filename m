Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DE0143C55
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 15:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721317175; cv=none; b=gYBRl2cNrribOcbdb/OflRXzm+EE0+x0mWpeIkml8dX25cG/KpEyRqzQEyVb1xXeMVOl2GSG5/jIJPD4R+BSW6YJIwzH3skcbkRckNsmSjWQghP6vNYAR28yYfcX92n7QfsgYYMRRbt+t7g/v7qRCKk/KTEuc2LPNJWM4Lm8iLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721317175; c=relaxed/simple;
	bh=QwDQsw1Igqb7IEeMk767If/DS1y9TVTy0Y2qoJoxu5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=quM3SRplRKEpVvQ6eUhrlbQkceAivrFYKXVmCSm+bgJTRQE0RIRMHNqH3s6axFpa5p9tbXqVjGwegQ0s4iprZphfUiMAoF0ZepiB9OKhnVQMMiodMk4NyrSraCxleuo1AFtlQBPwNoP30RTP8NABARYJjuKWhjGgMbyMtLfeI38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TzcpdwC0; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TzcpdwC0"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fc4aff530dso235425ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 08:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721317173; x=1721921973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tt0I2KGkrKSNHkYee7uJVlW3OUILFcgKcyGzTxibNPU=;
        b=TzcpdwC0LFXeE7WTIXK+rcGiixonhkFbEBoM4EuinmNHmXnNhyD/U0YjDj31rrWluv
         VVyGK3c/KhSGBRhgTw4/mx5CnLuAWcNZp9y8Y9hxYBe7kIKEFaHJGg19ZNSEd81OmtIG
         bvFefkIgykLR/mrnvlvACqrye43vjy8mHteYdRHupK5It80K4ED9NTAMUdbzmNs3UIng
         1rzauoLO3pw1sv409dQ1tOatgblLIKx6cy8th7xc32o0fELbdVujGKRMBt0R5pzYZeJy
         8icwD6SLxYootYjMfMC02ZUg8RGnAeZS7c5KGZ0EonaTYpmwYxuu6rbP+iUd3B7JzMXY
         47bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721317173; x=1721921973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tt0I2KGkrKSNHkYee7uJVlW3OUILFcgKcyGzTxibNPU=;
        b=maIK69tYRDnS/5hjHiKjeHtbcozRCL8p5HZXa9M0YzY/8D5KSg809EVm77rXJNf6zX
         TmxDEt5KPDxA0MupV3I+rDs7s10jSNLtLndfSU4BUaMlwRYSBG8qXqsh+k19FNzSDjLY
         Shec/W8ZZHBZSYzHnLQ7SYCVJnwbzmcH3Wku/l4OHwSZe98OQo1VzMZeOBOr6YAlMMst
         HZg16jbvn0HK2PBka+oQ4fz0yGcTZIzcEIHYyFsxL7+kgDi2wLztBFOARUVDIIaGw+XS
         NWlNFHeTRhEL2S2nl0Ia1hJoWPmZtMCc3a1CUsPjj7jmsLs/ZDqw6QVvmvr2tramIoRg
         HHCw==
X-Forwarded-Encrypted: i=1; AJvYcCX2ElvuSiCfWkVWdngr4G2JDOaUbCSV0YWi1V/kfEujCFinBi0uIvyknAfqRqESEXYFF61E+mOKV+kPPFyu9weEzvnebXbdJponLbsAo5qjLw==
X-Gm-Message-State: AOJu0YyCTQdzL7UchtTMbzHPYjcR2GqQt/d2sFEPN8bBsannmuenoTNh
	oGnq2ywPZ9fqlngj5wuaWH9sZBUMpT5oijTZVVktQO/yKmx6Js2T8ddHArUwgmiNtfvr8Za1Cpv
	hkRw5A1WVTr3Jc/O5BWdGd595VTQQvy6NkVHn
X-Google-Smtp-Source: AGHT+IEqkM3JV0rVMiSXMzPvq8eeXAkUx1YpQZU7ZziqlnFKKdiNs0GUPa/x2ix7RLH/fMAJwFw1M6Q8WmmE3oMqLaQ=
X-Received: by 2002:a17:902:ea07:b0:1fb:c2c:63c8 with SMTP id
 d9443c01a7336-1fc5f91f58emr2890715ad.12.1721317172520; Thu, 18 Jul 2024
 08:39:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718003025.1486232-1-irogers@google.com> <20240718003025.1486232-4-irogers@google.com>
 <92ceb8b5-240a-4715-98db-c73e8e9d3e50@linux.intel.com>
In-Reply-To: <92ceb8b5-240a-4715-98db-c73e8e9d3e50@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 18 Jul 2024 08:39:21 -0700
Message-ID: <CAP-5=fUfoMZ0HjCNoJe6hgEMi5ciY+LqFjBbLzfiZgO6dioshA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] perf pmu: Add support for event.cpus files in sysfs
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, ananth.narayan@amd.com, gautham.shenoy@amd.com, 
	kprateek.nayak@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 7:33=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-07-17 8:30 p.m., Ian Rogers wrote:
> > If an event file exists in sysfs, check if a event.cpus file exists
> > and read a perf_cpu_map from it if it does. This allows particular
> > events to have a different set of CPUs compared to the PMU.
> >
> > One scenario where this could be useful is when a PMU is set up with a
> > cpumask/events per SMT thread but some events record for all SMT
> > threads. Programming an event on each SMT thread will cause
> > unnecessary counters to be programmed and the aggregate value to be
> > too large.
>
> If I understand the scenario correctly, I think the issue should have
> been addressed since ICX, with the introduction of  the "SMT-aware
> events". Is there a specific event which still has the issue on newer
> platforms?

Nothing comes to mind, but it is there on popular machines like Skylake.

> >
> > Another scenario where this could be useful if when a PMU has
> > historically had a cpumask at the package level, but now newer per
> > die, core or CPU information is available.
>
> The traditional way to support new counters with a different scope is to
> add a new PMU.
>
> >
> > Additional context for the motivation is in these patches and
> > conversation:
> > https://lore.kernel.org/lkml/20240711102436.4432-1-Dhananjay.Ugwekar@am=
d.com/
>
> I don't see the advantages of the new event.cpus way.
> The aggregation should be the same.

Agreed. My concern is that we may end up with a pattern of
<pmu>_per_pkg, <pmu>_per_core, <pmu>_per_cpu, <pmu>_per_l3, etc. just
for the sake of the cpumask.

> The RAPL counters are free-running counters. So there is no difference
> whether grouping or not grouping.

Should the RAPL counters return true for perf_pmu__is_software? In the
tool we currently return false and won't allow grouping, these events
with other hardware events. The intent in perf_pmu__is_software was to
emulate the way the kernel allows/disallows groups - software context
events can be in a hardware context but otherwise I don't believe the
grouping is allowed.

> But it makes the kernel driver complex, since it has to maintain at
> least two different cpumasks.

Two drivers each maintaining a cpumask or 1 driver maintaining 2
cpumasks, it seems like there is chance for code reuse in both cases.
I'm not seeing how it adds to complexity particularly.

> The tool becomes complex either, since it has to take care of the
> per-event CPU override case.

I'm not sure I agree with this. What we need for perf_event_open is a
perf_event_attr, we dress these up as evsels which also have the
ability to be for >1 CPU or thread. Longer term I think evsels can
also have >1 PMU, for the wildcard cases like uncore memory
controllers - this would remove the need for resorting evsels except
for topdown events which have thrown us a giant bundle of challenges.
Anyway, so an evsel is perf_event_attr information paired with CPU
information, it makes sense to me that the parser should do this
pairing. What's harder in the evsel/evlist setup is trying to fix CPU
maps up not in parsing, like with __perf_evlist__propagate_maps where
the parsing is trying to leave crumbs around (like system_wide,
has_user_cpus, is_pmu_core) so the map propagation works properly.

> The json file must also be updated to add a
> new field cpumask.

Yeah, I don't like this as it means we end up putting CPU information
into the json that isn't the same for every CPU variant of the same
architecture model. Maybe we can have some kind of "scope" enum value
in the json and then when the scope differs from the PMU's, core scope
vs the PMU's hyperthread scope, then in the tool we can figure out the
cpumask from the topology in sysfs. Maybe we should just always use
the topology and get rid of cpumask files in sysfs, replacing them
with "scope" files. Will Deacon pushed back on having ARM PMUs
supporting hot plugging
(https://lore.kernel.org/lkml/20240701142222.GA2691@willie-the-truck/)
where the main thing hot plugging handler needs to maintain is set the
cpumask.

Thanks,
Ian
