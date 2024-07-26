Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27812F50A
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Jul 2024 07:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721980361; cv=none; b=pUH584hglSxh7+oUiaRD6p87bT5p6QVBmvL2AdECL9CaORWnjbIkUxBbCfCW5dfvpKy/CilbTWmS7Vw4TVagpOblSfzWcF4N1GzuNGYLbJwnEhaF9Slj7Lvee6goeQfyOmtgVn5aXg8Qe7P6iBxsQbZX7odpCfYMh1OTTEjzXi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721980361; c=relaxed/simple;
	bh=sDHNbFFR8u9Ol5TjK73rCYVuwpJnfqzoenZIDSugLOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBA3tR2T0gv4SMNu4kd1qPfmTBs7TrQSzjJraNycIoY2I97x0JlgjPGbqR+nFLLAYZVzwibufbI11iECIz76CvgJVU1Dis5jZTWhcB347Aoa0G1Hyl3xOlnA1Nk8S/5Wa3qTLoA7iKPGmw/5pYqeCPtIkC45phent8J3uPds0cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZP+sF4Au; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZP+sF4Au"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3993fddea13so78975ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Jul 2024 00:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721980359; x=1722585159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBMQzLMIUbcFt/VMX67sOZNaoPLY2OiQ1SguXdFhPbs=;
        b=ZP+sF4AuIHzAur8twvhjrbJ1ETtlUALymrtQjdig+Ha874uLtbzsowwnQLXdjoDAKd
         NiMFBa+Ee3SlOLKLOsGcM0cf5N8TC150FrpyDYfF5of7LLb9+uPNCXevsOew/jDMSyyc
         gvjtA/D5OlNp4k41Nq4pdOLgwR66QU8QKrCp0TEcY8U8xAwfqpa0xUZOso62lzlim/3u
         N6H1DVWXaVMm2EIyldIrCUe8lVF48f6DYorEaTL2E+Az22lDIJkN6LdxxvZ/QnTOoCEW
         TPVAHFDq6cbc+x6NejP9U7j5oQO4McinFuwPOoyehQoIaPydGHfb/JzveuVPWS0E1Nw8
         h4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721980359; x=1722585159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBMQzLMIUbcFt/VMX67sOZNaoPLY2OiQ1SguXdFhPbs=;
        b=s4RsGL/XjdKiAdD+34oj9RJ/Y6aU3xNknC81WI61cF//jjMB1/G2N/Y7Np1vFl3Mq+
         TkVJPaMYZyuc3sV/o23R5I5MsPqEpLwDU/qK8FrkP6xlvqIh4PsHO2fK/mh+HbGCZqdv
         WUCC6W7e1F1WdizP3xFu/1eiesLDC8r8m2++oBe2zdDcg/hppdVY76UNCSc7eW/jvdhC
         Y1mMo+Lupph+g2+OEHutNHCzuyCkyNbJIVNAHmFg1DMRTxHPy7baju30uLrCGyfOLQ8B
         pZdOS1H34GoMssIKSfaXJGGqYCGVhInlq5IhdFtxXULm60Rpmbqmx35uKnpin9Y/SoZu
         WYiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcihZT2/xrM0T9TBoEv2vOAVm0GpjLtXuFPLngLSMSc025qO+5ILYNexJa4SEVkrxA8isE4tEJLPGefW9VIfeOFsD+fvTsJHJOlNy+g7JR/g==
X-Gm-Message-State: AOJu0YxO+EqQiA7ei0Af64NzXB2Py+si4kf7jW6SQhzs9DbZG5xKrX9n
	dAHWJGSlSreosRADUDbhDCoT+Mi93L3KxjMmay6LROoxFjgkhTDg0PEmwJgQn/lLnCnYVxEQQLY
	GZNADFTDVv3ckJ9hIdY+cpCJJtIXUSVW6zbu4
X-Google-Smtp-Source: AGHT+IECrbtVj1fH1Dt53KoC7R4VFg5GwNAQTW30EI0t0xukhScR5m6uiL+Eu7e1Dywp20PIeicc0ZaSLp0fsIsUS78=
X-Received: by 2002:a05:6e02:1a6c:b0:398:a724:24e6 with SMTP id
 e9e14a558f8ab-39a2b3fb060mr1813155ab.20.1721980358585; Fri, 26 Jul 2024
 00:52:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718003025.1486232-1-irogers@google.com> <20240718003025.1486232-4-irogers@google.com>
 <92ceb8b5-240a-4715-98db-c73e8e9d3e50@linux.intel.com> <CAP-5=fUfoMZ0HjCNoJe6hgEMi5ciY+LqFjBbLzfiZgO6dioshA@mail.gmail.com>
 <64030eab-6e95-494a-ab72-bc33792ef723@linux.intel.com> <CAP-5=fVMV4ZmGk4-XguqV=LAuif-MgAL+BK=mMAE1tC3f3tbhQ@mail.gmail.com>
 <e8872317-8e18-48aa-9f23-b98af9345bed@linux.intel.com> <CAP-5=fUjEYwdOdmfa5N7b8OOLWDitJKBdeOr8-+UOYWA5+ehkA@mail.gmail.com>
 <775d8f1d-437d-47a3-b4b2-da476e914cf5@linux.intel.com> <CAP-5=fUH+n+f_q1Tc-a3oV3vDV60VGOLANRFWUemDen197rYog@mail.gmail.com>
 <c4b499a5-7d2a-44db-bd0c-c123417337a5@amd.com> <3c3d1cd9-ccb1-495d-a670-9ee504fb0bbe@amd.com>
In-Reply-To: <3c3d1cd9-ccb1-495d-a670-9ee504fb0bbe@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 26 Jul 2024 00:52:25 -0700
Message-ID: <CAP-5=fXpacz331M71WR1HZHS0p7t9zqNUqBvMf2EjOxaB9Ayyw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] perf pmu: Add support for event.cpus files in sysfs
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	ananth.narayan@amd.com, gautham.shenoy@amd.com, kprateek.nayak@amd.com, 
	sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 12:10=E2=80=AFAM Dhananjay Ugwekar
<Dhananjay.Ugwekar@amd.com> wrote:
>
>
>
> On 7/26/2024 12:36 PM, Dhananjay Ugwekar wrote:
> > Hello, Ian, Kan,
> >
> > On 7/20/2024 3:32 AM, Ian Rogers wrote:
> >> On Fri, Jul 19, 2024 at 9:35=E2=80=AFAM Liang, Kan <kan.liang@linux.in=
tel.com> wrote:
> >>> On 2024-07-19 10:59 a.m., Ian Rogers wrote:
> >>>> Thanks Kan. I'm not wondering about a case of 2 CPUs, say on CPU0 an=
d
> >>>> solely its perf event context, I want to know its core power and
> >>>> package power as a group so I never record one without the other. Th=
at
> >>>> grouping wouldn't be possible with 2 PMUs.
> >>>
> >>> For power, to be honest, I don't think it improves anything. It gives
> >>> users a false image that perf can group these counters.
> >>> But the truth is that perf cannot. The power counters are all
> >>> free-running counters. It's impossible to co-schedule them (which
> >>> requires a global mechanism to disable/enable all counters, e.g.,
> >>> GLOBAL_CTRL for core PMU). The kernel still has to read the counters =
one
> >>> by one while the counters keep running. There are no differences with=
 or
> >>> without a group for the power events.
> >>
> >> Ok, so power should copy cstate with _core, _pkg, etc. I agree the
> >> difference is small and I like the idea of being consistent.
> >
> > So, it seems we want to follow the new PMU addition approach for RAPL
> > being consistent with Intel cstate driver, should I revive my "power_pe=
r_core"
> > PMU thread now?
>
> The power_per_core PMU thread link for reference,
>
> https://lore.kernel.org/all/20240711102436.4432-1-Dhananjay.Ugwekar@amd.c=
om/

I think so. Would it be possible to follow the same naming convention
as cstate, where there is cstate_pkg and cstate_core? (ie no "_per" in
the name)

Thanks,
Ian

> >
> > Thanks,
> > Dhananjay
> >
> >  Do we
> >> want to add "event.cpus" support to the tool anyway for potential
> >> future uses? This would at least avoid problems with newer kernels and
> >> older perf tools were we to find a good use for it.
> >>
> >>>> My understanding had been that for core PMUs a "perf stat -C" option
> >>>> would choose the particular CPU to count the event on, for an uncore
> >>>> PMU the -C option would override the cpumask's "default" value. We
> >>>> have code to validate this:
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next=
.git/tree/tools/perf/util/evlist.c?h=3Dperf-tools-next#n2522
> >>>> But it seems now that overriding an uncore PMU's default CPU is
> >>>> ignored.
> >>>
> >>> For the uncore driver, no matter what -C set, it writes the default C=
PU
> >>> back.
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/arch/x86/events/intel/uncore.c#n760
> >>>
> >>>> If you did:
> >>>> $ perf stat -C 1 -e data_read -a sleep 0.1
> >>>> Then the tool thinks data_read is on CPU1 and will set its thread
> >>>> affinity to CPU1 to avoid IPIs. It seems to fix this we need to just
> >>>> throw away the -C option.
> >>> The perf tool can still read the the counter from CPU1 and no IPIs
> >>> because of the PMU_EV_CAP_READ_ACTIVE_PKG().
> >>>
> >>> Not quite sure, but it seems only the open and close may be impacted =
and
> >>> silently changed to CPU0.
> >>
> >> There's also enable/disable. Andi did the work and there were some
> >> notable gains but likely more on core events. Ultimately it'd be nice
> >> to be opening, closing.. everything in parallel given the calls are
> >> slow and the work is embarrassingly parallel.
> >> It feels like the cpumasks for uncore could still do with some cleanup
> >> wrt -C I'm just unsure at the moment what this should be. Tbh, I'm
> >> tempted to rewrite evlist propagate maps as someone may look at it and
> >> think I believe in what it is doing. The parallel stuff we should grab
> >> Riccardo's past work.
> >>
> >> Thanks,
> >> Ian
> >>
> >>
> >>> Thanks,
> >>> Kan
> >>>>
> >>>>>> 2) do the /sys/devices/<pmu>/events/event.(unit|scale|per-pkg|snap=
shot)
> >>>>>> files parse correctly and have a corresponding event.
> >>>>>> 3) keep adding opening events on the PMU to a group to make sure t=
hat
> >>>>>> when counters are exhausted the perf_event_open fails (I've seen t=
his
> >>>>>> bug on AMD)
> >>>>>> 4) are the values in the type file unique
> >>>>>>
> >>>>>
> >>>>> The rest sounds good to me.
> >>>>
> >>>> Cool. Let me know if you can think of more.
> >>>>
> >>>> Thanks,
> >>>> Ian
> >>>>
> >>>>> Thanks,
> >>>>> Kan
> >>>>
>
