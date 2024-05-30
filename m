Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C8D2C683
	for <linux-perf-users@vger.kernel.org>; Thu, 30 May 2024 16:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717085680; cv=none; b=qvzcuWhn9FtCTxFJLhylx3G7Zo+AGhKOiJfrt4JPYe87f9ulZm+6yoAMldTh3+5Tq+5ZOxq103wC6s6dG4UvDkQj8PmQLVKIAzWFdWpxb/OoPo34iBP0Fq1i9Si2v8sZGwT6SI/C+WVt13/CRQ59K9Zo1CLzgozQ+hEHFkbEgM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717085680; c=relaxed/simple;
	bh=OUowyC/BuT+oRhlybANuYOVPkHlLyq2cSzoK/fwEVhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+fPMrtawrNsdkC+hzqLooQv019HqPwu1g6bBBe7rrv4yiKctG8xxO5wDqxUgNdwdS+ABEdeEHLFBPEl9b7oDMhw+YqtSaN1bYUyxxFLfMmaINcl5b7pk72+P4pOvKQkrPAb9GSodTRKKVeIFx9ZejcV/eEyvDCh6Dejr68QC2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DDPZPcRE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DDPZPcRE"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f61bbb1dfcso174955ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 30 May 2024 09:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717085677; x=1717690477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9y2UktDm2Wf8VD1pUGGsxJOBNyj+qo8KLue+rmkggE=;
        b=DDPZPcRE3kIOgalnxE3Ys7+GnADKlyRHO+n1+PToMFK8heH1qZOpsmvvjxtmDc6dfj
         TmRA6wUiwZbBxVrOcASSluy5UlpOjbMTViTep1LWa36kLAjLLPvp5tXO0Vtmvr2cpouS
         Hg7B4+yWamJxEoAPhTyOLaePXWbHOAV5WNlPfGEM2BB8bBJhhrhTAdghWv6sSc571Cun
         017xDT3rLBht69E1C9pL0wRFWRRn/vOywJycHupvO4SPdIJtk/mQ22SeibDgpjOlwVLf
         0/14i3ceOPz9kwCZvDVhrkqhl0Ap5RqwluIAnvJgiEmKmchqSGxXRqVqRIC4yJ8cnQtl
         kk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717085677; x=1717690477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9y2UktDm2Wf8VD1pUGGsxJOBNyj+qo8KLue+rmkggE=;
        b=orgkuZbKgoa+EYP4ZHr+IGzJi9iK1ScCK9OGl/7SVq5dNg2rHaDiNmmf2RFWheCgby
         Mg9YnMXwtdZD5k9aEOOq1cYNKDndOlgzKDMIEsc0JVl+zM0M8wfjZ7qH/ci9dkbi/JiB
         LviEU5NBZLxz4r0f5ix3TQkygFL5wRtUQ18V+IKtYJNPO2D26GmWzM2e5dCirVipRbmZ
         VLpFUyxO2BjLqYOoRWYW61q51bh2qI1OXAX6QuwliU4+7evDHv3zlX5G2Pj9oLq49iWr
         YoXzfkthF6IzUKDMfuZdAbirlYz54bz1/9HPwfGrc5k05Ad9s+R/lzDgliE9azjifWhD
         Wdvw==
X-Forwarded-Encrypted: i=1; AJvYcCUkV0xmHy9hj2OfoplKj7z53hxKDtF7zBmEtt3pZ37l3qeJIJioda40jZlBoK5N8KehJKK1z5DoOLGiYUmk4/BxRpSMqnblDNG9pCaxdacYWQ==
X-Gm-Message-State: AOJu0Yyw6f9YJqTBNfjpu9KXUedFT2JGUU+w/6kvD71U+KXQXS8GWwy+
	01prgroWVOVS7b3TCEZGIc/pT/ZrwmvPjY4Afln91l7yJfVi8yiPc/VPWa5t1pQIQFSe6J9TNEe
	EAovFpuh73SKUcWuMh2b1RXq1Z3b1r9dgyD16
X-Google-Smtp-Source: AGHT+IENsByswKhreNE6pmbNMCSnJRJAYsQ0cPqasNX9uk4ZawLfH+q9UEiS1kJaf/p5e40IJ8fSmYYP1XGXPGGzVGQ=
X-Received: by 2002:a17:902:7289:b0:1ea:963e:2e2d with SMTP id
 d9443c01a7336-1f617382877mr2710595ad.24.1717085676926; Thu, 30 May 2024
 09:14:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525152927.665498-1-irogers@google.com> <CAHk-=wgYxi_+Q1OpZKg2F9=eem7VQjYnoqN6sA1+uUt-0JqQKQ@mail.gmail.com>
 <CAHk-=wi5Ri=yR2jBVk-4HzTzpoAWOgstr1LEvg_-OXtJvXXJOA@mail.gmail.com>
 <20240527105842.GB33806@debian-dev> <CAP-5=fXfidyF_e=yMNi26ScgY-VbJPfxN8M7OiK9ELa3qTfXPQ@mail.gmail.com>
 <ZlY0F_lmB37g10OK@x1> <CAP-5=fWM8LxrcR4Nf+e2jRtJ-jC0Sa-HYPf56pU5GW8ySdX1CQ@mail.gmail.com>
 <d79b18d7-6930-41fd-8157-eaa55b52df86@arm.com> <CAP-5=fV7AGJLCKv0yhcCNSTywBSOiPV8j8aHi5eniXHaRZWA0Q@mail.gmail.com>
 <3d4edff4-0052-4996-b8e8-61764988f4dd@arm.com>
In-Reply-To: <3d4edff4-0052-4996-b8e8-61764988f4dd@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 30 May 2024 09:14:24 -0700
Message-ID: <CAP-5=fVi7kGV6PqWpszoUtS9QuKtDweBt7OOVuFCSVD=Z=_q8w@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Force adding default events only to core PMUs
To: James Clark <james.clark@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 8:37=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
>
>
> On 29/05/2024 18:33, Ian Rogers wrote:
> > On Wed, May 29, 2024 at 7:50=E2=80=AFAM James Clark <james.clark@arm.co=
m> wrote:
> >>
> >> On 28/05/2024 20:51, Ian Rogers wrote:
> >>> On Tue, May 28, 2024 at 12:44=E2=80=AFPM Arnaldo Carvalho de Melo
> >>> <acme@kernel.org> wrote:
> >>>>
> >>>> On Mon, May 27, 2024 at 10:36:45PM -0700, Ian Rogers wrote:
> >>>>> On Mon, May 27, 2024 at 3:58=E2=80=AFAM Leo Yan <leo.yan@linux.dev>=
 wrote:
> >>>>>> On Sat, May 25, 2024 at 02:14:26PM -0700, Linus Torvalds wrote:
> >>>>>>> On Sat, 25 May 2024 at 09:43, Linus Torvalds <torvalds@linux-foun=
dation.org> wrote:
> >>>>
> >>>>>>>> This makes 'perf record' work for me again.
> >>>>
> >>>>>>> Oh, wait, no it doesn't.
> >>>>
> >>>>>>> It makes just the plain "perf record" without any arguments work,
> >>>>>>> which was what I was testing because I was lazy.
> >>>>
> >>>>>>> So now
> >>>>
> >>>>>>>     $ perf record sleep 1
> >>>>
> >>>>>>> works fine. But
> >>>>
> >>>>>>>     $ perf record -e cycles:pp sleep 1
> >>>>
> >>>>>>> is still completely broken (with or without ":p" and ":pp").
> >>>>
> >>>>>> Seems to me that this patch fails to check if a PMU is a core-atta=
ched
> >>>>>> PMU that can support common hardware events. Therefore, we should
> >>>>>> consider adding the following check.
> >>>>
> >>>>>> +++ b/tools/perf/util/parse-events.c
> >>>>>> @@ -1594,6 +1594,9 @@ int parse_events_multi_pmu_add(struct parse_=
events_state *parse_state,
> >>>>>>         while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) {
> >>>>>>                 bool auto_merge_stats;
> >>>>>>
> >>>>>> +               if (hw_config !=3D PERF_COUNT_HW_MAX && !pmu->is_c=
ore)
> >>>>>> +                       continue;
> >>>>>> +
> >>>>>>                 if (parse_events__filter_pmu(parse_state, pmu))
> >>>>>>                         continue;
> >>>>
> >>>>>> To be clear, I only compiled this change but I have no chance to t=
est
> >>>>>> it. @Ian, could you confirm this?
> >>>>
> >>>>> Hi Leo,
> >>>>
> >>>>> so the code is working as intended. I believe it also agrees with w=
hat
> >>>>> Arnaldo thinks.
> >>>>
> >>>>> If you do:
> >>>>
> >>>>> $ perf stat -e cycles ...
> >>>>
> >>>>> and you have
> >>>>
> >>>>> /sys/devices/pmu1/events/cycles
> >>>>> /sys/devices/pmu2/events/cycles
> >>>>
> >>>>> The output of perf stat should contain counts for pmu1 and pmu2. We=
re
> >>>>> the event 'data_read' or 'inst_retired.any' we wouldn't be having t=
he
> >>>>
> >>>> Sure, what is being asked is to count events and if those two events=
 in
> >>>> those two PMUs can count, then do what the user asked.
> >>>>
> >>>> For 'perf record' we're asking for sampling, if the event has the na=
me
> >>>> specified and can't be sampled, skip it, warn the user and even so
> >>>> only if verbose mode is asked, something like:
> >>>>
> >>>>   root@x1:~# perf record -e cycles -a sleep 1
> >>>>   [ perf record: Woken up 1 times to write data ]
> >>>>   [ perf record: Captured and wrote 1.998 MB perf.data (4472 samples=
) ]
> >>>>   root@x1:~# perf evlist
> >>>>   cpu_atom/cycles/
> >>>>   cpu_core/cycles/
> >>>>   dummy:u
> >>>>   root@x1:~#
> >>>>
> >>>> Cool, there are two 'cycles' events, one in a PMU named 'cpu_atom',
> >>>> another in a 'cpu_core' one, both can be sampled, my workload may
> >>>> run/use resources on then, I'm interested, sample both.
> >>>>
> >>>> But if we had some other PMU, to use a name Jiri uses in tests/fake
> >>>> PMUs, the 'krava' PMU and it has a 'cycles' event, so 'krava/cycles/=
'
> >>>> and for some reason it doesn't support sampling, skip it, then the
> >>>> result should be the same as above.
> >>>>
> >>>> If the user finds it strange after looking at sysfs that 'krava/cycl=
es/'
> >>>> isn't being sampled, the usual workflow is to ask perf for more
> >>>> verbosity, using -v (or multiple 'v' letters to get increasing level=
s of
> >>>> verbosity), in which case the user would see:
> >>>>
> >>>>   root@x1:~# perf record -v -e cycles -a sleep 1
> >>>>   WARNING: skipping 'krava/cycles/' event, it doesn't support sampli=
ng.
> >>>>   [ perf record: Woken up 1 times to write data ]
> >>>>   [ perf record: Captured and wrote 1.998 MB perf.data (4472 samples=
) ]
> >>>>   root@x1:~# perf evlist
> >>
> >> This makes sense to me. I like keeping the old apparent behavior unles=
s
> >> -v is used and it will feel like the tool "just works".
> >>
> >> In the context of the commit summary "perf parse-events: Prefer
> >> sysfs/JSON hardware events over legacy":
> >>
> >> I don't follow why that should be "Prefer, even if it's an event that
> >> can't be opened, sysfs/JSON...".
> >>
> >> Surely it should be "Prefer sysfs/JSON, unless it can't be opened, the=
n
> >> use legacy". If all events can be opened, sure go and open them all. I=
f
> >> only core events can be opened, do that too. If only uncore events can
> >> be opened... etc.
> >
>
> [...]
>
> > So great, ignoring the revert, that fixed everything? Well no. The
> > tool in places was hard coding 'struct perf_event_attr' which is of
> > course broken were things to be hybrid or BIG.little. So the fix for
> > that was to not hard code things. We need a set of 'struct
> > perf_event_attr', ah I know a way to get that let's just use our event
> > parsing logic. So a 'struct perf_event_attr' hard coding type to
> > PERF_TYPE_HARDWARE, the config to PERF_COUNT_HW_CPU_CYCLES and also
> > setting the precision to maximum was changed into parsing the string
> > "cycles:P". Sounds good, no? Well no. Somebody decided to create an
> > ARM event called cycles (Intel's name to avoid conflicts is
> > clockticks) and now that event was getting added to our set. Although
> > the patch sat for weeks (months?) on linux-next nobody had discovered
> > a fairly obvious breakage.
> >
>
> We did see the test failure on our Ampere test machine 7 days ago, but
> for some reason only on mainline (I was also on holiday at the same
> time). I'm checking if that machine is running all the branches and will
> make sure it does from now on.
>
> We are running perf-tools-next on other machines and I try to look at
> all the test failures. Just this one had a bit of an obscure combination
> of needing the DSU PMU.

Thanks, I'm truly appreciative of greater testing and I appreciate it
doesn't happen for free. It also has ongoing costs. Thank you!

> One thing we don't have in CI is any Apple M hardware. I can look into
> it but I wouldn't have high hopes for anything soon.

As mentioned in these threads it is also knowingly broken - what the
reverted patch was trying to address. Perhaps one could be captured on
the way to e-waste if the screen,... don't work. We don't need much.
Apple M is the root cause of much special behavior in the perf tool
and the testing situation on it is sad. Maybe the Linux Foundation
could get one?

> [...]
>
> > It isn't new behavior for perf to scan all PMUs, it always has, the
> > new behavior is around legacy events. We want multiple PMU scanning
> > for hybrid, we want all PMU scanning for uncore. The legacy changes
> > happened because of the Apple M? PMU with me being complained at by
> > folks at ARM who have now created this mess by their arm_dsu event
> > name. Shouldn't it be a 1 liner fix to change "DSU_EVENT_ATTR(cycles,
> > 0x11)," to "DSU_EVENT_ATTR(clockticks, 0x11),":
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/perf/arm_dsu_pmu.c#n177
> > that's up to ARM but it would make sense to me.
> >
>
> Not sure about that one, that would break anyone's scripts or tools that
> are looking at DSU cycles. And it wouldn't fix the issue in the future
> if there were other reasons the event doesn't open (like non sampling
> core events, or someone's brand new uncore PMU that also has a cycles
> event).

Right, but should the resolution there be to specify which PMU you
want to resolve the ambiguity. The tool telling you a PMU doesn't
support sampling is signal. We'd expect the tool to fail if it didn't
support an event, is it really unreasonable to fail on a mode of an
event?

I'm further confused by the DSU driver. The names:

DSU_EVENT_ATTR(cycles, 0x11),
DSU_EVENT_ATTR(bus_access, 0x19),
DSU_EVENT_ATTR(memory_error, 0x1a),
DSU_EVENT_ATTR(bus_cycles, 0x1d),

The last 3 seem unambiguous, but cycles, couldn't it be read as also
possibly meaning bus_cycles? Wouldn't cpu_cycles be in keeping with
ARM's other names and an objectively better name? Getting that 1 liner
in v6.10 would resolve a lot of problems. I also think llc or l3 may
be more "intention revealing" names for the device than dsu, but hey I
don't want to start a naming war.

> It seems like we're converging one something that works though in the
> other threads, but I'm still digesting the problems a bit.

I think the major blocker is that some people, although I can only
name 1 and they've stopped listening, think event names should somehow
carry special meaning and in that special case it implies use only
core PMUs. The only known example of a special event is cycles, but if
you look for equivalent event names in perf's code there are things as
banal as branches and instructions, and as wild as
dTLB-speculative-read-misses. I'd really like not to carry around
notions of special event names but if we merge patches that ignore
that and then they get reverted, justified through hand written tests
looking to poke at things like the dsu PMU,  I don't know where we
are. It has also been threatened that the perf code could be removed
from the kernel tree, so there's really no fun in poking a bear.

Thanks,
Ian

> >> Because the user could always use the defaults (no argument) or -e
> >> cycles and historically Perf correctly picked the one that could be
> >> opened. Or if they want the DSU one they could specify it. That can al=
l
> >> still work _and_ we can support "prefer sysfs/JSON" as long as we don'=
t
> >> prefer it when opening the event doesn't work.
> >
> > Hopefully this is all explained above.
> >
> > Thanks,
> > Ian
> >
> >> Thanks
> >> James
> >>
> >>> Thanks,
> >>> Ian
> >>>
> >>>> - Arnaldo
