Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C48913D63B
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 14:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721401180; cv=none; b=lYlXBsz+kNSozk51E30TIJ2u3ekdiH6JCxyj3OGLlC+y2qQ6BXPl4Yb+mkSZ6SWzHz63noI+epDmhX8ELYLvuK3PFXGSkc7b8a+XqCvD0h6lEL6Tc71jn7j1OmUq5cVfqiLW3hUG8NvOuiurUS262hED/9qpI1S2AIxPe32CeMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721401180; c=relaxed/simple;
	bh=GSPkmIWez+O4tDwfj7g7PjaxesW3OsKJF1BuQzLsVrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WE0JKXSUTaSymP75Zoq99WfykXIFjkUrNDmZoVuFCusIgitmIgEjySJg+rpux6v9rSI+DVUV21wxpjWdz3aI2Inml5BUnE99qHALSm9a7sEKZOBgWW3dZhgzlN2EFIWAvyxrKxvNQ121p8qCR3LUScE+tU+7Rla1OsAONxoMaoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xPd6nxrZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xPd6nxrZ"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc312a36f9so189115ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 07:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721401178; x=1722005978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jv3U8Qnh/s2WC8Nv6kkVq4OxpnRI2cXzguS22ScPxYs=;
        b=xPd6nxrZbWbjhGEeyw/Cw2qESjS/uiTcPUz8/Moj8DRmv7SsY+z5QlxhhTH6KQQ6KC
         UHWR1PHixs+Dd+dBPk9hP2xNe/tZndcbcO6+W1FTaNctpN5WXTUxUgWS9+JX10v+we0e
         j2taE0+qYwiURRLiYREC+R/U+U3735rivLO5eb8asc57CdIWPB/iJZ/r8uscfopxi4VL
         tJRS2LH5lCcB2HHtDRVZG9dijFTTgJ6gklsIovcv3KHw8cKHNuJAx7cKmIgigHooM/yu
         l5Pige+bqLNBYPohKt+Qguu6Oy7dP5e1fIMltPa8+Rv+fsSMd/siz3VGLq80dRU4mxHV
         ladg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721401178; x=1722005978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jv3U8Qnh/s2WC8Nv6kkVq4OxpnRI2cXzguS22ScPxYs=;
        b=CWJnMEdD5m8KV0vYXgDkl/gkpFeEKZ/jQ/UwqRRPJKMu+kioMPV6NPfvh/S0cuF89o
         V5cFHECDHf0oiV2MAui33eXVol6kIverj7n5kFaARRdO/by+6P04a3rher0Guvny67zQ
         l/RBagdniPcBCamjcaFX1XPtYVJmI7/lczZuOGOgx0a54aluJrJvhO+36zfm6QA3yYIZ
         YrakbiNlVx9wr9dgI7BKrbFBmoLa+OKG/gPswERQFdYdMgGIrsXw4bJTz9vBdqN8HWsZ
         z6XYvLB62Aqw5jIizKaq14/3avOuKKMbFIyQJstiVpfPdQvvGj/9Q/nE82g72Es1W9b4
         Cfsg==
X-Forwarded-Encrypted: i=1; AJvYcCWN1a4Fa3GuQo6h5DF4MQzDzgPIJV3foOcpnGvLrqdQX3JH6UFIIsl79oXmsJMMT4sVpqkIeyDq0mAz9JwL/L4Sks2sxXGCBLw4EpvjVsnuQw==
X-Gm-Message-State: AOJu0YzLINZn+AP+2bUwf8Xj9j8hTZnihn532aB5HYp/7zMTbZ+EMSsJ
	6kuIdKL1RA5e9IFLvIWeotUHafGD/yfQb0oL9a5tpmVbSyyeKFW1ah7rJQ4bRORRwflgFt+34jH
	FzB1vbmW+cHNS3lEa0ul0bFVahljRbgALXRW4
X-Google-Smtp-Source: AGHT+IGJ3mmaihDVrZeamgWM477mQHRSS2TSc3iTBONyGOTVYkscb/wcJmL3lNt2OKkmAzmoka4L9rty3Wo7AV796HQ=
X-Received: by 2002:a17:903:280c:b0:1fa:cd15:985e with SMTP id
 d9443c01a7336-1fd60cbfa51mr3011095ad.6.1721401178054; Fri, 19 Jul 2024
 07:59:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718003025.1486232-1-irogers@google.com> <20240718003025.1486232-4-irogers@google.com>
 <92ceb8b5-240a-4715-98db-c73e8e9d3e50@linux.intel.com> <CAP-5=fUfoMZ0HjCNoJe6hgEMi5ciY+LqFjBbLzfiZgO6dioshA@mail.gmail.com>
 <64030eab-6e95-494a-ab72-bc33792ef723@linux.intel.com> <CAP-5=fVMV4ZmGk4-XguqV=LAuif-MgAL+BK=mMAE1tC3f3tbhQ@mail.gmail.com>
 <e8872317-8e18-48aa-9f23-b98af9345bed@linux.intel.com>
In-Reply-To: <e8872317-8e18-48aa-9f23-b98af9345bed@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 19 Jul 2024 07:59:25 -0700
Message-ID: <CAP-5=fUjEYwdOdmfa5N7b8OOLWDitJKBdeOr8-+UOYWA5+ehkA@mail.gmail.com>
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

On Fri, Jul 19, 2024 at 6:56=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-07-18 4:50 p.m., Ian Rogers wrote:
> > On Thu, Jul 18, 2024 at 10:48=E2=80=AFAM Liang, Kan <kan.liang@linux.in=
tel.com> wrote:
> >>
> >>
> >>
> >> On 2024-07-18 11:39 a.m., Ian Rogers wrote:
> >>> On Thu, Jul 18, 2024 at 7:33=E2=80=AFAM Liang, Kan <kan.liang@linux.i=
ntel.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2024-07-17 8:30 p.m., Ian Rogers wrote:
> >>>>> If an event file exists in sysfs, check if a event.cpus file exists
> >>>>> and read a perf_cpu_map from it if it does. This allows particular
> >>>>> events to have a different set of CPUs compared to the PMU.
> >>>>>
> >>>>> One scenario where this could be useful is when a PMU is set up wit=
h a
> >>>>> cpumask/events per SMT thread but some events record for all SMT
> >>>>> threads. Programming an event on each SMT thread will cause
> >>>>> unnecessary counters to be programmed and the aggregate value to be
> >>>>> too large.
> >>>>
> >>>> If I understand the scenario correctly, I think the issue should hav=
e
> >>>> been addressed since ICX, with the introduction of  the "SMT-aware
> >>>> events". Is there a specific event which still has the issue on newe=
r
> >>>> platforms?
> >>>
> >>> Nothing comes to mind, but it is there on popular machines like Skyla=
ke.
> >>>
> >>>>>
> >>>>> Another scenario where this could be useful if when a PMU has
> >>>>> historically had a cpumask at the package level, but now newer per
> >>>>> die, core or CPU information is available.
> >>>>
> >>>> The traditional way to support new counters with a different scope i=
s to
> >>>> add a new PMU.
> >>>>
> >>>>>
> >>>>> Additional context for the motivation is in these patches and
> >>>>> conversation:
> >>>>> https://lore.kernel.org/lkml/20240711102436.4432-1-Dhananjay.Ugweka=
r@amd.com/
> >>>>
> >>>> I don't see the advantages of the new event.cpus way.
> >>>> The aggregation should be the same.
> >>>
> >>> Agreed. My concern is that we may end up with a pattern of
> >>> <pmu>_per_pkg, <pmu>_per_core, <pmu>_per_cpu, <pmu>_per_l3, etc. just
> >>> for the sake of the cpumask.
> >>
> >> The cstate PMUs already do so, e.g., cstate_core, cstate_pkg.
> >>
> >> From another perspective, it discloses the scope information in a PMU
> >> name. If a user only cares about the information of a package, they ju=
st
> >> need to focus on everything under <pmu>_pkg. Otherwise, they have to g=
o
> >> through all the events.
> >>
> >>>
> >>>> The RAPL counters are free-running counters. So there is no differen=
ce
> >>>> whether grouping or not grouping.
> >>>
> >>> Should the RAPL counters return true for perf_pmu__is_software? In th=
e
> >>> tool we currently return false and won't allow grouping, these events
> >>> with other hardware events. The intent in perf_pmu__is_software was t=
o
> >>> emulate the way the kernel allows/disallows groups - software context
> >>> events can be in a hardware context but otherwise I don't believe the
> >>> grouping is allowed.
> >>
> >> No, it's not allowed for the RAPL counters.
> >>
> >> If the motivation is to find another way to group counters with
> >> different scope, it may not work.
> >>
> >> We once tried to mix the perf_invalid_context PMUs in a group. But it'=
s
> >> denied.
> >> https://yhbt.net/lore/all/20150415172856.GA5029@twins.programming.kick=
s-ass.net/
> >>
> >> The event.cpus still faces the same issues.
> >
> > Why so? The events would share the same perf_event_context, I thought
> > the perf_event_open would succeed.
>
> I think it breaks what groups are as well. At least, you cannot
> guarantee that two events can be co-scheduled on the same CPU. Even
> worse, there could be no events on some CPU.
> The first thing that pops up is the sample read feature. On CPU_A, the
> event_A is the leader event, but on CPU_B, the event_B could be the
> leader event if event_A's cpumask doesn't include the CPU_B.
> There could be more similar features we have to special handle.

Thanks Kan. I'm not wondering about a case of 2 CPUs, say on CPU0 and
solely its perf event context, I want to know its core power and
package power as a group so I never record one without the other. That
grouping wouldn't be possible with 2 PMUs.

> >
> >>>
> >>>> But it makes the kernel driver complex, since it has to maintain at
> >>>> least two different cpumasks.
> >>>
> >>> Two drivers each maintaining a cpumask or 1 driver maintaining 2
> >>> cpumasks, it seems like there is chance for code reuse in both cases.
> >>> I'm not seeing how it adds to complexity particularly.
> >>
> >> Yes, there are some cleanup opportunities for the cpumask/hotplug code=
s.
> >>
> >> We may even abstracts some generic interfaces for pkg or core level PM=
Us.
> >>
> >> Eventually, the complexity/duplication should be able to be reduced.
> >>
> >>>
> >>>> The tool becomes complex either, since it has to take care of the
> >>>> per-event CPU override case.
> >>>
> >>> I'm not sure I agree with this. What we need for perf_event_open is a
> >>> perf_event_attr, we dress these up as evsels which also have the
> >>> ability to be for >1 CPU or thread. Longer term I think evsels can
> >>> also have >1 PMU, for the wildcard cases like uncore memory
> >>> controllers - this would remove the need for resorting evsels except
> >>> for topdown events which have thrown us a giant bundle of challenges.
> >>> Anyway, so an evsel is perf_event_attr information paired with CPU
> >>> information, it makes sense to me that the parser should do this
> >>> pairing. What's harder in the evsel/evlist setup is trying to fix CPU
> >>> maps up not in parsing, like with __perf_evlist__propagate_maps where
> >>> the parsing is trying to leave crumbs around (like system_wide,
> >>> has_user_cpus, is_pmu_core) so the map propagation works properly.
> >>>
> >>>> The json file must also be updated to add a
> >>>> new field cpumask.
> >>>
> >>> Yeah, I don't like this as it means we end up putting CPU information
> >>> into the json that isn't the same for every CPU variant of the same
> >>> architecture model. Maybe we can have some kind of "scope" enum value
> >>> in the json and then when the scope differs from the PMU's, core scop=
e
> >>> vs the PMU's hyperthread scope, then in the tool we can figure out th=
e
> >>> cpumask from the topology in sysfs. Maybe we should just always use
> >>> the topology and get rid of cpumask files in sysfs, replacing them
> >>> with "scope" files. Will Deacon pushed back on having ARM PMUs
> >>> supporting hot plugging
> >>> (https://lore.kernel.org/lkml/20240701142222.GA2691@willie-the-truck/=
)
> >>> where the main thing hot plugging handler needs to maintain is set th=
e
> >>> cpumask.
> >>
> >> Not just the cpumask but also migrate the context for some PMUs, see
> >> perf_pmu_migrate_context().
> >
> > Will do, thanks.
> >
> >> It seems we really need a shared cpumask in the generic code, so the
> >> drivers don't need to handle the hotplug everywhere. I will think abou=
t it.
> >
> > Thanks. There are other problems on ARM PMUs like having no or empty
> > cpumasks, which the tool take to mean open the event on every online
> > CPU (there is no cpus or cpumask file on core PMUs historically, so we
> > adopt this behavior when the cpumask is empty or not present).
>
> The no cpus/cpumasks and empty cpumasks should be different.
> No cpus/cpumasks file means that the counters/events are available for
> all the CPUs.
> But if it's an empty cpus/cpumasks file, it means that there are no
> proper CPUs. It may happen on a hybrid machine when all e-core CPUs are
> hot-removed. Since it's possible that the CPUs can be hot-added later,
> the kernel driver doesn't unregister the cpu_atom PMU.
>
> > I've
> > been thinking to expand `tools/perf/tests/pmu.c` with basic PMU sanity
> > tests. Some ideas:
> >
>
> Thanks.
>
> > 1) some kind of cpumask sanity check - we could open an event with the
> > cpumask and see if it yields multiplexing.. which would highlight the
> > ARM no cpumask bug
>
> The multiplexing is triggered when there are not enough counters. It
> should not related to the cpumask.

Agreed. Here I'm thinking about the bugs I see in PMUs. One of them is
to always succeed in opening siblings within a group and for the
unavailable counters to just report "not counted". This breaks weak
groups used by metrics.

> For the PMU without cpumask, I think the test case should try to open an
> event on all CPUs and check if the open succeeds.
> For the PMU with cpumask, the test case should try to open an event on
> the masked CPUs and check if the open succeeds.

I agree without cpumask means all CPUs, the bug I see on ARM PMUs is
that they have uncore PMUs with no or empty cpumasks leading to the
uncore events being programmed on every CPU and over counting,
multiplexing counters and so on. I'm trying to devise tests so that
they can see they are broken.

> The behavior of opening an event on unmasked CPUs seems not defined.
> For uncore, it's OK. The kernel treats the CPUs from the same socket
> exactly the same. But I'm not sure about the other PMUs.

My understanding had been that for core PMUs a "perf stat -C" option
would choose the particular CPU to count the event on, for an uncore
PMU the -C option would override the cpumask's "default" value. We
have code to validate this:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/evlist.c?h=3Dperf-tools-next#n2522
But it seems now that overriding an uncore PMU's default CPU is
ignored. If you did:
$ perf stat -C 1 -e data_read -a sleep 0.1
Then the tool thinks data_read is on CPU1 and will set its thread
affinity to CPU1 to avoid IPIs. It seems to fix this we need to just
throw away the -C option.

> > 2) do the /sys/devices/<pmu>/events/event.(unit|scale|per-pkg|snapshot)
> > files parse correctly and have a corresponding event.
> > 3) keep adding opening events on the PMU to a group to make sure that
> > when counters are exhausted the perf_event_open fails (I've seen this
> > bug on AMD)
> > 4) are the values in the type file unique
> >
>
> The rest sounds good to me.

Cool. Let me know if you can think of more.

Thanks,
Ian

> Thanks,
> Kan
