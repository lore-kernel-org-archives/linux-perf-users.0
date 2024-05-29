Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E169715B547
	for <linux-perf-users@vger.kernel.org>; Wed, 29 May 2024 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717004042; cv=none; b=uyKCzGAkfYcZbXVsB2kqnPhKy31YrZJr3ef1K3BUoiSG1SGz3ys1xlE6tNhNzOdCccF9prxC2KTYFVpeu/zLkX+SOS6/hoj3edkpJX1IGx/UTkYhOkPq2pf8beniX5/FX6EXH5DLJW0YET4iFfdy6OzbUa2IaN8qwwKijfhyH+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717004042; c=relaxed/simple;
	bh=J/thBa2Oh4RKLXFlmUFRdE59OrBUVSgcwSRgE4tmaR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jdWE/Mh7jcHqUJotjdOjQLiKnnJWCLRpnjwT8u5KW8AfvqZGszg42jRvVDSvlds924mFSUqckJxWXw8uqWYjJJRE8MfJvVLvJdFbP8cwzDHBylYUrrXiwkq2vKhIiGA59VsjvDpem1rD626gRGYj75zv0rIVJKXWXyua5P4/7qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bgZ78GSf; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bgZ78GSf"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-43dfe020675so22291cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 May 2024 10:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717004039; x=1717608839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+RXCOcjD/5HCXHnq+rUcFqK89yyUKCTSAw5+yFrN8Q=;
        b=bgZ78GSf90/RafuknKw8KSqOi2dxXeAuywLl6/jKPx8Wx7iL7UFdYea0LWZylgGWJf
         NtSVO3bLyFOlDfTGBh0+cM6d444+lohRaB94rlB+rpwi+ieo/rintOs6SrvvkfQ0OXgD
         +ilRdd/tp6LtTDf3zD+azlNDKylmdZdDIdN7fZ5EhetiM4mECYBu8XAIQvsNeah4b8Mf
         EihDM7oWfLAR0fLSnSoJAatWrrw8jc5c9rWHAPWylZS66KKvamarMG245U9GXWb4KRA+
         jiHBDaLcXnjybR3SPaLj1/Hvl7G8i2ZLMHQolitbahHCCBczpsZWEfNILx0hV895QNMt
         LWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717004039; x=1717608839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+RXCOcjD/5HCXHnq+rUcFqK89yyUKCTSAw5+yFrN8Q=;
        b=t+3qU7urgcY8FHDluYuEBJMxe0dURR7FJYqlAs/R12/ATMSBdMjtmoe2c9wLS6eqTI
         Zhc7rQSiGk5jJ2ecg90s9FFTPyAHMxB603CCclLucL0liFMRaFXcy9+j2hDGwhHJ41Sv
         uBP4gGwPGo7F6WOHUB2P/6fN4y8K3ciLdvEWJ2IJLSxVXmgb8oYbXGmJscxo/wta+si5
         7fiYFYJ4y8tbfi/aS6hyeSVvAv8TT5n5QB/W+ZmyM52ZsG7Y8u5xXJyv50P9V6myBQbh
         PtNTa38FuRztK3sMemxTBH5ir8BZnN/0olG+HcalnNlhE6her1CMo3Y91s8ThE0Si9wk
         cbRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+n7GXLCHZv7VYKDHJbEZMFyu04+BH3Cs2Dqv/2QbuzFAX8KZXDIEJOQV0WUOGJj7JGk9Kx69cjSpAKfmnQio4gE183wcf5qL+/GrPLxKRvQ==
X-Gm-Message-State: AOJu0YyuQUowQCf1vc8xJfL/Xi+liQNZdYB4OXpGZuuVy9dXGgkoE7lX
	r+gZa/W4HSnwhy5krCd4lCpoJwoiJEX1tuOosrdiqryf8BmtZDJkdd/T7/IpTgaNus7fRP72/ld
	JBnVSoR/LlGIAaQNCKT4Cx2RAT9hr8CLZ3i6A
X-Google-Smtp-Source: AGHT+IGiCUgv5kpu6hh5K38P0pgvcZ0vhcskRAciikqELWVpAT9rhWKyJk9eKFwFjOgzMwmNKSbmaovBiaImf03oNb8=
X-Received: by 2002:a05:622a:985:b0:43e:3b12:8bb0 with SMTP id
 d75a77b69052e-43fe2968a2dmr3181481cf.17.1717004038425; Wed, 29 May 2024
 10:33:58 -0700 (PDT)
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
 <d79b18d7-6930-41fd-8157-eaa55b52df86@arm.com>
In-Reply-To: <d79b18d7-6930-41fd-8157-eaa55b52df86@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 29 May 2024 10:33:46 -0700
Message-ID: <CAP-5=fV7AGJLCKv0yhcCNSTywBSOiPV8j8aHi5eniXHaRZWA0Q@mail.gmail.com>
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

On Wed, May 29, 2024 at 7:50=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> On 28/05/2024 20:51, Ian Rogers wrote:
> > On Tue, May 28, 2024 at 12:44=E2=80=AFPM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> >>
> >> On Mon, May 27, 2024 at 10:36:45PM -0700, Ian Rogers wrote:
> >>> On Mon, May 27, 2024 at 3:58=E2=80=AFAM Leo Yan <leo.yan@linux.dev> w=
rote:
> >>>> On Sat, May 25, 2024 at 02:14:26PM -0700, Linus Torvalds wrote:
> >>>>> On Sat, 25 May 2024 at 09:43, Linus Torvalds <torvalds@linux-founda=
tion.org> wrote:
> >>
> >>>>>> This makes 'perf record' work for me again.
> >>
> >>>>> Oh, wait, no it doesn't.
> >>
> >>>>> It makes just the plain "perf record" without any arguments work,
> >>>>> which was what I was testing because I was lazy.
> >>
> >>>>> So now
> >>
> >>>>>     $ perf record sleep 1
> >>
> >>>>> works fine. But
> >>
> >>>>>     $ perf record -e cycles:pp sleep 1
> >>
> >>>>> is still completely broken (with or without ":p" and ":pp").
> >>
> >>>> Seems to me that this patch fails to check if a PMU is a core-attach=
ed
> >>>> PMU that can support common hardware events. Therefore, we should
> >>>> consider adding the following check.
> >>
> >>>> +++ b/tools/perf/util/parse-events.c
> >>>> @@ -1594,6 +1594,9 @@ int parse_events_multi_pmu_add(struct parse_ev=
ents_state *parse_state,
> >>>>         while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) {
> >>>>                 bool auto_merge_stats;
> >>>>
> >>>> +               if (hw_config !=3D PERF_COUNT_HW_MAX && !pmu->is_cor=
e)
> >>>> +                       continue;
> >>>> +
> >>>>                 if (parse_events__filter_pmu(parse_state, pmu))
> >>>>                         continue;
> >>
> >>>> To be clear, I only compiled this change but I have no chance to tes=
t
> >>>> it. @Ian, could you confirm this?
> >>
> >>> Hi Leo,
> >>
> >>> so the code is working as intended. I believe it also agrees with wha=
t
> >>> Arnaldo thinks.
> >>
> >>> If you do:
> >>
> >>> $ perf stat -e cycles ...
> >>
> >>> and you have
> >>
> >>> /sys/devices/pmu1/events/cycles
> >>> /sys/devices/pmu2/events/cycles
> >>
> >>> The output of perf stat should contain counts for pmu1 and pmu2. Were
> >>> the event 'data_read' or 'inst_retired.any' we wouldn't be having the
> >>
> >> Sure, what is being asked is to count events and if those two events i=
n
> >> those two PMUs can count, then do what the user asked.
> >>
> >> For 'perf record' we're asking for sampling, if the event has the name
> >> specified and can't be sampled, skip it, warn the user and even so
> >> only if verbose mode is asked, something like:
> >>
> >>   root@x1:~# perf record -e cycles -a sleep 1
> >>   [ perf record: Woken up 1 times to write data ]
> >>   [ perf record: Captured and wrote 1.998 MB perf.data (4472 samples) =
]
> >>   root@x1:~# perf evlist
> >>   cpu_atom/cycles/
> >>   cpu_core/cycles/
> >>   dummy:u
> >>   root@x1:~#
> >>
> >> Cool, there are two 'cycles' events, one in a PMU named 'cpu_atom',
> >> another in a 'cpu_core' one, both can be sampled, my workload may
> >> run/use resources on then, I'm interested, sample both.
> >>
> >> But if we had some other PMU, to use a name Jiri uses in tests/fake
> >> PMUs, the 'krava' PMU and it has a 'cycles' event, so 'krava/cycles/'
> >> and for some reason it doesn't support sampling, skip it, then the
> >> result should be the same as above.
> >>
> >> If the user finds it strange after looking at sysfs that 'krava/cycles=
/'
> >> isn't being sampled, the usual workflow is to ask perf for more
> >> verbosity, using -v (or multiple 'v' letters to get increasing levels =
of
> >> verbosity), in which case the user would see:
> >>
> >>   root@x1:~# perf record -v -e cycles -a sleep 1
> >>   WARNING: skipping 'krava/cycles/' event, it doesn't support sampling=
.
> >>   [ perf record: Woken up 1 times to write data ]
> >>   [ perf record: Captured and wrote 1.998 MB perf.data (4472 samples) =
]
> >>   root@x1:~# perf evlist
>
> This makes sense to me. I like keeping the old apparent behavior unless
> -v is used and it will feel like the tool "just works".
>
> In the context of the commit summary "perf parse-events: Prefer
> sysfs/JSON hardware events over legacy":
>
> I don't follow why that should be "Prefer, even if it's an event that
> can't be opened, sysfs/JSON...".
>
> Surely it should be "Prefer sysfs/JSON, unless it can't be opened, then
> use legacy". If all events can be opened, sure go and open them all. If
> only core events can be opened, do that too. If only uncore events can
> be opened... etc.

Currently event parsing is not the same as event opening. Event
parsing I hope is about generating a set of `struct perf_event_attr`,
I'd like to see it migrate to libperf and it needn't pull in evsels
and evlists that are a construct on top of these. There's always more
work to do.

This whole can't the tool do blah, blah, blah.. well fine, but that's
not actually describing the tool. It is describing a different tool
and the question is how to get from what the tool is to what you
describe. A lot of people talk to me about what the tool should do,
they are a lot more hesitant to actually do the work.

A command line with an event like:
$ perf record -e inst_retired.any ...
seems simple enough. But how many PMUs support inst_retired.any, what
should the set of 'struct perf_event_attr' look like? Oh that's
obvious Ian, you're talking about an Intel event so there should be
exactly one and it should be on the PMU 'cpu' (note, until recently we
didn't even really track PMUs associated with an event). But then what
about hybrid? Ah yes, you want two 'struct perf_event_attr' one set up
for cpu_core and one set up for cpu_atom. Okay, so how in the tool do
I "know" this? Well the tool should scan PMUs, look for the event and
then create a 'struct perf_event_attr' for each one. Okay that's where
we are today, although there are some places where core and non-core
PMUs are treated differently and I'd like that not to be the case as
it has caused conditions where we will program events differently, and
in particular I believe this breaks ARM Apple M? PMUs. It also aligned
with RISC-V plans for how to support events.

When a legacy event occurs there is a whole bunch of other processing.
The legacy event names are hard coded into the parse events parser:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/parse-events.l?h=3Dperf-tools-next#n332
An example of a legacy event name is cycles. The parsing of cycles
used to create exactly one 'struct perf_event_attr' with the PMU type
set to the special PERF_TYPE_HARDWARE and the config set to
PERF_COUNT_HW_CPU_CYCLES. But then what about hybrid? Well then we
need an event for each PMU type otherwise when a process gets
rescheduled between CPU types it will suddenly become invisible. This
is something we fixed in Linux 6.x.

Ah, Ian did you know on Apple M? PMUs the legacy events are broken and
we need to always use sysfs or json events? The fact that ARM's PMU
didn't look like a core PMU meant we wouldn't try to program legacy
events on them and now your code to fix Intel's hybrid has exposed a
latent ARM PMU bug? Oh and by the way this has been broken for
multiple Linux releases, go fix it by yesterday.

My expectation on fixing this was that Intel would just say to go
away. But no, Kan was cool with it and I went ahead inverted the
priorities and now sysfs and json events have priority - the largest
part of the work is making the test expectations align with what the
code does. So what this means for our cycles event, well the logic to
scan all PMUs for inst_retired.any is now the default logic but in the
case of a legacy event we also remember a legacy encoding is possible.
So if the event isn't found in sysfs or json for a core PMU then we
use the legacy encoding. Note, I'm just talking about making 'struct
perf_event_attr' not opening events.

Great, so why did you need a patch in 6.10? The process was
incomplete. Let's say on a Apple M? system you went:
$ perf record -e 'armv8_pmuv3_0/cycles/' ...
then you would indeed get a sysfs encoded event. But what about:
$ perf record -e 'cycles' ...
I may want the event on the BIG and little cores. Well in that case
the sysfs and json overriding legacy event logic hadn't been applied.
This means that the legacy encoding would always be used, but as I
already mentioned the legacy encoding is broken on a Apple M? system.
The user is supposed to somehow know the fix is to add the PMU name
and specify multiple events.

With the now reverted change the event parsing logic would scan for
the cycles event on every PMU and create a struct perf_event_attr for
it (the code makes evsels, but they are just wrappers on top of a
struct perf_event_attr). But why scan all PMUs? Well that was done to
make hybrid work and because perf's behavior has always been either to
handle an event as legacy or handle it as a potential event on all
PMUs. We're making legacy second class, given the desire to prefer
sysfs and json, and we only use that encoding when the scan fails to
find the event on a core PMU.

So great, ignoring the revert, that fixed everything? Well no. The
tool in places was hard coding 'struct perf_event_attr' which is of
course broken were things to be hybrid or BIG.little. So the fix for
that was to not hard code things. We need a set of 'struct
perf_event_attr', ah I know a way to get that let's just use our event
parsing logic. So a 'struct perf_event_attr' hard coding type to
PERF_TYPE_HARDWARE, the config to PERF_COUNT_HW_CPU_CYCLES and also
setting the precision to maximum was changed into parsing the string
"cycles:P". Sounds good, no? Well no. Somebody decided to create an
ARM event called cycles (Intel's name to avoid conflicts is
clockticks) and now that event was getting added to our set. Although
the patch sat for weeks (months?) on linux-next nobody had discovered
a fairly obvious breakage.

Oh Ian this is your crazy json Ian wants to pick a PMU and wants to
break the world not caring about regressions mentality, admit you hate
everybody and let me throw some expletives at you. Well I hope not. We
were parsing "cycles:P" to generate our set of perf_event_attr, let's
avoid the problem of getting uncore PMU events by making it so the
events parsed are only on core PMUs - hey, this is at least better
than the broken on hybrid hard coded alternative. Which is where this
patch sits on top of everything.

Well we hate it. Cycles is clearly only something that CPUs have
(ignoring the fact ARM have explicitly called their L3 cache event
cycles, cough, cough..) make everything go back. Go back to where? We
want legacy events to have priority again? But we have legacy event
names like l1-i-speculative-read-prefetches, we want to hard code that
nonsense and make it modify the regular scan all PMUs logic? Clearly
no, and that's where Arnaldo's proposal is.

Under Arnaldo's proposal, as I understand it, the parsing will
generate the set of 'struct perf_event_attr' in the list of evsels.
When we go to open the evsels a failure needn't be fatal. Notice the
important distinction here. You are talking about opening during
parsing, the proposal is to postpone that.

Great, go and code. I did - I even did it on the weekend. The events
we want to ignore I reuse the idea of skippable that was introduced
for when a hard coded 'struct perf_event_attr' could fail to open but
we'd moved the code to use event parsing. The problem is that nothing
in the perf record logic, that is split between perf and libperf,
expects an evsel not to open. To add the workarounds was making a
change large enough that it was unreasonable to think it could land in
v6.10 as it may well break something else.

So where does that leave us:
1) we have Arnaldo's proposal, it sounds good but it has clear
behavior changes. My rough implementation showed it to be too big for
v6.10.
2) v6.10 has reverted a patch fixing the event encodings for the PMU
on ARM Apple M? CPUs.
3) as the reverted patch has undone something fundamental our tests
are now out of sync with what event parsing does (hey ARM never made
the event parsing tests work anyway so why care about this one,
right?)
4) if we revert the revert it fixes the Apple M? issue but breaks
Neoverse if the arm_dsu PMU is enabled. Well then apply this fix on
top of the revert and you're good? No, what has explicitly been said
is that "cycles" shouldn't follow any of the patterns of event parsing
so far described. But why? Well because even though the PMUs are
advertising two cycles events, cycles needs to be special and mean
core only if no PMU is given. So 1 cycles event then? Well no, we
still want PMU scanning because there's hybrid to care about. Okay,
and is it just cycles that are special? We have potentially >200
legacy events where a similar argument could be made about making them
core only, what about instructions, what about branches... The reply I
got was, go away and I will no longer speak to you.

I think the best plan we have for moving forward is Arnaldo's
proposal, Linus has explicitly stated that it is wrong and there
should be special event names. We can't land this in v6.10 which is
why I've said that it doesn't seem so terrible that on a Neoverse if
you are specifying events by hand and you don't specify a PMU and the
event you specify happens to be cycles, make it clear you want the
armv8_pmuv3_0 one by adding the PMU name. This has always been the way
to clear up the ambiguity.

> I'm happy to help with the implementation or testing of that on my
> big.LITTLE system.
>
> FWIW the hybrid stuff with Perf stat is already working well for me on
> Arm since we added PERF_PMU_CAP_EXTENDED_HW_TYPE which Ian suggested.
>
> >
> > The problem here is that we're hiding a problem rather than reporting
> > it. Typically we report the issue and more than that we ask the user
> > to work around the issue. That would be analogous to wanting the user
> > to specify what PMU they want the event to apply to, which has always
> > been perf's behavior.
> >
>
> Is the problem you are referring to that there are multiple PMUs with
> 'cycles' events? Surely that's only a problem in the context of the new
> proposed behavior, otherwise it's not really a problem. It's just
> something that happens to exist.

So perf will try to open events, when failing it will fall back, if an
event fails to open then we report an error. This is why none of the
code currently handles an evsel in an evlist where the event has
failed to open.

Failure to open could be a behavior someone relies upon. Let's say you
want to probe the behavior of a PMU, you could be relying on failures
to show you the event won't work. This is Hyrum's law:

With a sufficient number of users of an API,
it does not matter what you promise in the contract:
all observable behaviors of your system
will be depended on by somebody.

It isn't new behavior for perf to scan all PMUs, it always has, the
new behavior is around legacy events. We want multiple PMU scanning
for hybrid, we want all PMU scanning for uncore. The legacy changes
happened because of the Apple M? PMU with me being complained at by
folks at ARM who have now created this mess by their arm_dsu event
name. Shouldn't it be a 1 liner fix to change "DSU_EVENT_ATTR(cycles,
0x11)," to "DSU_EVENT_ATTR(clockticks, 0x11),":
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/perf/arm_dsu_pmu.c#n177
that's up to ARM but it would make sense to me.

> Because the user could always use the defaults (no argument) or -e
> cycles and historically Perf correctly picked the one that could be
> opened. Or if they want the DSU one they could specify it. That can all
> still work _and_ we can support "prefer sysfs/JSON" as long as we don't
> prefer it when opening the event doesn't work.

Hopefully this is all explained above.

Thanks,
Ian

> Thanks
> James
>
> > Thanks,
> > Ian
> >
> >> - Arnaldo
