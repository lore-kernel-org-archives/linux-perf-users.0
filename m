Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1804C16E872
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2024 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721663028; cv=none; b=s/Gh8v2QpcJSpvqLCszDf/gIDkOPdN2cFWOOhSMsjpWCl+2U8/9Cj6tyjO7/vnuaJW1gA5JWEvXFNBjnVF60Z+mbYrjtMVUMCPdTzYzahYKVMCz+hGsGBKvUP69uw2xAnwuve6yVjzTjwdqZrESRuI7QmimIECwJNTLQm1ptuXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721663028; c=relaxed/simple;
	bh=2vs/ZDLA688OQqpaLNxt6LeXd1t33/Nvj7ipcP//Hbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJUnA1NrY3b1VXcuPWXgWMmotfdKLUVYwQ05azV0eXQ+1inr3fTAfff9Lp6C+wWUBlv8iZNx8qxhT8VyouyUsxYMxc4f+FOh0VKuWzcAWycKYaAzE6+3p5eJVcg2b74BXQTj6VUv0wO/N/vgkF7KnAcbnYdadgXiQ0maoSS29go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JJqCEtIa; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JJqCEtIa"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3993fddea13so295475ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2024 08:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721663026; x=1722267826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vs/ZDLA688OQqpaLNxt6LeXd1t33/Nvj7ipcP//Hbw=;
        b=JJqCEtIauhT/wVnMcdjHZObr4x6zP/IPYcteRgc9CYC3WovIImGSNgVh9ZFvTfjKIa
         HypB6M3mGw7eHpW5vmyMRmh0ZbUUjY64R2glK2bPO9rhsprRMD4MBCrcygiqLVz+YLOf
         vViiCK/Ug9Pp+juUSg01OP0frq+AuXOAYYfcauMUHmT1DI0raEIvsVgC0WSNzquDhMA5
         3VCsJa2+Ua/cgeM051p1MJhUfyVw5wNEknOXrqLIBq3leIqtgcLvLuYpTfmuehZBrr/Y
         PASTax0NCdOfmLbuOxf2jJOvEoTu9trAGmP0VMCYW86BlToqLqr5fPAU9JZJQBo/mRrp
         cutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721663026; x=1722267826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2vs/ZDLA688OQqpaLNxt6LeXd1t33/Nvj7ipcP//Hbw=;
        b=Mkx7HxxDmQcZyxQacwY2rSM1RJfLxmlYeBc25abXxQ5/JzMmfjHpeKRCWhoOWVXo88
         i+jRCKQmgkN9NwpPhTpf0lJS1c22g3M3WfYMdML3lCSGOgfley0fNeOJpucP0RDPx0kf
         JMcheJ38VTtUMiJouNpKZNtX4AnA1qVbEvICqCVP0+Bqxwd4DTm3gz5Y7LknSlkLwUrp
         SKKc6dybPuavXPtV2SROh2oSkMy9Nyu/XcbYEPdd6a7vQd1U/xkB3A96uA5LKbyLqFHk
         s8mCN7oVYPzIWdENaGYkB8FdTXZIFpcyZ+UVKI5qUgY/AWcvVQyG96u+M/4Z3k/Nl119
         H21g==
X-Forwarded-Encrypted: i=1; AJvYcCX+FLSYLzD3OhUBJAXMRZaaBubUrGi74jlPOddnh7Vg5Dbub/Xba30bvCpeXN5OO79LX4E7j4NOBxcmwJmUuqxlhmOSfOIKQ2PMAdBE70jx6Q==
X-Gm-Message-State: AOJu0YwHMJ/Ll5ZG8C4t9eUeiF3T5Ltyp9DVJHzP1ynsfCuufF9wv5vB
	LGcS+vnCmIri75dpkA9gsFuQkqYMPhEGOHcNJx1tatp4zxsPk5N1K8NiGwqtMbJiC5OZIwuPOmc
	uA3EE4bNONyy7l3REAXI3kgQMAeD2pRc+3DCi
X-Google-Smtp-Source: AGHT+IGihboi8Aw1W/n3ywJYg+WG1Jxo4/rIjx2vOt7B5Shdg/kSWQskoKuVpp9DD7eUfUyHUyn/5Iej0qF9scz7c7I=
X-Received: by 2002:a05:6e02:20e9:b0:376:3026:9dfc with SMTP id
 e9e14a558f8ab-39936427277mr4963355ab.24.1721663025938; Mon, 22 Jul 2024
 08:43:45 -0700 (PDT)
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
 <862f6bb1-ab67-4286-8c27-465b2f29de64@linux.intel.com>
In-Reply-To: <862f6bb1-ab67-4286-8c27-465b2f29de64@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 22 Jul 2024 08:43:34 -0700
Message-ID: <CAP-5=fVdiFYVP8RsE+JuhOCoGSyybv0ZUn=Sixv1ZcEe8G7=2A@mail.gmail.com>
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

On Mon, Jul 22, 2024 at 6:57=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-07-19 6:02 p.m., Ian Rogers wrote:
> > On Fri, Jul 19, 2024 at 9:35=E2=80=AFAM Liang, Kan <kan.liang@linux.int=
el.com> wrote:
> >> On 2024-07-19 10:59 a.m., Ian Rogers wrote:
> >>> Thanks Kan. I'm not wondering about a case of 2 CPUs, say on CPU0 and
> >>> solely its perf event context, I want to know its core power and
> >>> package power as a group so I never record one without the other. Tha=
t
> >>> grouping wouldn't be possible with 2 PMUs.
> >>
> >> For power, to be honest, I don't think it improves anything. It gives
> >> users a false image that perf can group these counters.
> >> But the truth is that perf cannot. The power counters are all
> >> free-running counters. It's impossible to co-schedule them (which
> >> requires a global mechanism to disable/enable all counters, e.g.,
> >> GLOBAL_CTRL for core PMU). The kernel still has to read the counters o=
ne
> >> by one while the counters keep running. There are no differences with =
or
> >> without a group for the power events.
> >
> > Ok, so power should copy cstate with _core, _pkg, etc. I agree the
> > difference is small and I like the idea of being consistent. Do we
> > want to add "event.cpus" support to the tool anyway for potential
> > future uses?
>
> The only thing I can imagine is that it may be used to disclose the
> event constraint information, Or even more to update/override the event
> constraint information (which requires kernel update.). But what I'm
> worried about is that it may be abused. It's very easy to confuse an
> event and a counter in a PMU.

So you mean if you have a dual socket machine and an uncore PMU with a
cpumask of "0,48" you worry that someone setting an event on CPU 47
may think they are getting a CPU on the second socket? Perhaps if the
user can express an intent to the tool, say "perf stat
-randomly-select-uncore-cpus ...", then this can be avoided. I'm not
sure I'm worried about this as specifying the CPU for an event to use
is already something of a more niche/advanced thing to be doing.

> > This would at least avoid problems with newer kernels and
> > older perf tools were we to find a good use for it.
> >
> >>> My understanding had been that for core PMUs a "perf stat -C" option
> >>> would choose the particular CPU to count the event on, for an uncore
> >>> PMU the -C option would override the cpumask's "default" value. We
> >>> have code to validate this:
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/evlist.c?h=3Dperf-tools-next#n2522
> >>> But it seems now that overriding an uncore PMU's default CPU is
> >>> ignored.
> >>
> >> For the uncore driver, no matter what -C set, it writes the default CP=
U
> >> back.
> >> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.g=
it/tree/arch/x86/events/intel/uncore.c#n760
> >>
> >>> If you did:
> >>> $ perf stat -C 1 -e data_read -a sleep 0.1
> >>> Then the tool thinks data_read is on CPU1 and will set its thread
> >>> affinity to CPU1 to avoid IPIs. It seems to fix this we need to just
> >>> throw away the -C option.
> >> The perf tool can still read the the counter from CPU1 and no IPIs
> >> because of the PMU_EV_CAP_READ_ACTIVE_PKG().
> >>
> >> Not quite sure, but it seems only the open and close may be impacted a=
nd
> >> silently changed to CPU0.
> >
> > There's also enable/disable. Andi did the work and there were some
> > notable gains but likely more on core events. Ultimately it'd be nice
> > to be opening, closing.. everything in parallel given the calls are
> > slow and the work is embarrassingly parallel.
> > It feels like the cpumasks for uncore could still do with some cleanup
> > wrt -C I'm just unsure at the moment what this should be. Tbh, I'm
> > tempted to rewrite evlist propagate maps as someone may look at it and
> > think I believe in what it is doing. The parallel stuff we should grab
> > Riccardo's past work.
>
> For core PMU, the parallel may not work, because the core PMU is usually
> MSR based. Perf has to access the MSRs on the specific CPU. IPIs may be
> triggered if the users try to operate them from the other CPUs.

Right, I think the idea would be to have as many threads as you have
CPUs then give each thread affinity to a different CPU. The work done
on the thread would match the CPU they have affinity with to avoid the
IPIs. Because of the use of RCU in the kernel perf code it is possible
to hit RCU synchronize where IPIs are sent after 200ms IIRC. If you
get an RCU synchronize needing an IPI then "200ms x num CPUs" can mean
seconds of delay in a serial implementation (500 CPUs would be 100
seconds). With parallel code a worst case slow down shouldn't increase
with the number of CPUs. On laptops, .. this doesn't matter much.

> But the parallel is good for the counters in the MMIO space. The
> counters can be accessed from any CPU. There are more and more counters
> which are moved to the MMIO space, e.g., new uncore PMUs, IOMMU PMU,
> TMPI (for power), etc.

Sounds good but I'm wondering how we can get the tool in the right
place for doing affinity games. For the MMIO case life's good and we
don't care. How can the tool know one case from another? Should the
tool always be just following the cpumask? What about on ARM where the
cpumasks are broken?

Thanks,
Ian

> Thanks,
> Kan
> >
> > Thanks,
> > Ian
> >
> >
> >> Thanks,
> >> Kan
> >>>
> >>>>> 2) do the /sys/devices/<pmu>/events/event.(unit|scale|per-pkg|snaps=
hot)
> >>>>> files parse correctly and have a corresponding event.
> >>>>> 3) keep adding opening events on the PMU to a group to make sure th=
at
> >>>>> when counters are exhausted the perf_event_open fails (I've seen th=
is
> >>>>> bug on AMD)
> >>>>> 4) are the values in the type file unique
> >>>>>
> >>>>
> >>>> The rest sounds good to me.
> >>>
> >>> Cool. Let me know if you can think of more.
> >>>
> >>> Thanks,
> >>> Ian
> >>>
> >>>> Thanks,
> >>>> Kan
> >>>
> >
