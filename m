Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A309224FB
	for <linux-perf-users@vger.kernel.org>; Sat, 25 May 2024 23:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716680070; cv=none; b=Jl4HQou5DIARQ0HBcnRNXU4VSmbDYjw2/uGZ8DLZjKjMXBLNp7WIGbsefce8+dP5tOB7UfvMzz/psSrDu3T/slFT2LkH831E4PhNvJ/eC15Qq8WPcZ/QRIsTEhQ0dDAHGKJ+HanWFYK3mcPhGXo2KuEPHy4Ra/evi8Og6hQfdd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716680070; c=relaxed/simple;
	bh=uUzfAIJAN8UOtttIYoZiBPiN+mS3jw1s66mcLXazIvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0Pq9czGtOBfEaykh+PX+MVfELDLWHcuNSYnb+cFFi6wLKAUt78cG7GR2Qy48nEpH8qZjlhMrvuDCCwCoiGXBcPBwAr3Tn9x7a/M0WkYskP7GWZFcPo0tjR5nKV+861cIE1AsVDP3kWF7f+raMHZUZNbP+GyMa7CXtNz/iK8bxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hVTkRfwf; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hVTkRfwf"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-373807d3bebso144345ab.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 May 2024 16:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716680066; x=1717284866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyDDv123oM7gFPBqZNEnU0l4e5csQD/v1tgVMBREQS8=;
        b=hVTkRfwfauw92SOS29Dqr0TUajj4TaI9BKrmERxWzvOT9Q9kiVwB/yLUjmDq/vLb0m
         MOoulP6dc5+D3kdZYEe8zUJ0sYxTu/dDYtKX32Kf//ifBOSjnWY8bWnkqXPXDURFdc8p
         doG5vZh+wslMAIyd3jQSBL4g1+jbKlnKThjq3ptXtxHNfdYqxhKpGlOHgac6dOvpEpAW
         woCM1BISCO82obdBZaAdg+6qVPJudwv5Fp/xbvjVexQU1sYK7FVSAa9K9MBxaVVA+Jw0
         k7WEMuCH6X4bRt14NAlL1itab0yDiegqLMjnp21lzNlFhs0Mnrmhv2XgLEt6cTMx/MVE
         QsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716680066; x=1717284866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyDDv123oM7gFPBqZNEnU0l4e5csQD/v1tgVMBREQS8=;
        b=V5ODZunxvSXm6vXYMw6xMV5OF7Qa7ZG7dFvILyLadiho7m+jrCzOiPM9HJPQSpSB/b
         gr6gX9fAYdKJLOuUEKA1YpKFesoUKn53Uj76ch1Qbr55+9m0z5XnA3LEnGjtZm1GOka0
         tsesuBCBrKLpX3CWZ5ZICCWzmob8poXBNYuUwme+C1Is7pL86FoTHjiWrZ0J8Af8kFME
         JMeyjYIZkyVQHqvwT8heXtNO+2i6VRgRedHFE096/v1+JvvZXJIZ9xwJrnVUySNtCamd
         26kUquG2KG8A9PfNrEGkubJ9+GWhDDhEXze48uq+Qwb0VPCDjK0T31ZpzGP5PXLE48Z4
         s7Ag==
X-Forwarded-Encrypted: i=1; AJvYcCW4zLrsp2m8UEfnQiyVsGDj9O2ajLsTG1QEZzCBTY9YBlIHdfMIHHzGhiJZ1rknSto7j02ObL6Dq2Y1L0JBPPcjNyyYFZIf3Qx44w5VUb6NLw==
X-Gm-Message-State: AOJu0YxnTc0dCFUl7LIPqBNzABfQ7s94x71pBuFiQBjDXkB2/2G10lao
	8cDkPTwsMmJ5/gIEtI3U+oxcXpeA42U8ubXLEaEWgAeKfBrr25YHPLY0pd16PIbXhjuWlQ489/7
	HAUq2gn8feLGwFPPTfx3Yx5haZkv2iqY+jv+4
X-Google-Smtp-Source: AGHT+IEFPou839IYn52nxYvnLuzElIpziWWNUre//vAxOnb6alTAcRjMhiwI1g9ND3ujWy0WXgIQXHtHnH7qWJI7MMo=
X-Received: by 2002:a92:d38a:0:b0:36c:3046:a6ef with SMTP id
 e9e14a558f8ab-3738a706885mr2292555ab.12.1716680066259; Sat, 25 May 2024
 16:34:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521192614.3937942-1-acme@kernel.org> <CAHk-=wiWvtFyedDNpoV7a8Fq_FpbB+F5KmWK2xPY3QoYseOf_A@mail.gmail.com>
 <ZlFE-wbwStOqt8Ra@x1> <ZlFGpxWGQskCTjeK@x1> <CAP-5=fXDdcjMmn8iBenjPmZZQdB=AX+gc4TYDsHXuwH9TYq4Ng@mail.gmail.com>
 <CAHk-=wheZptGieaObmQEsz6bocUjhQXNpWXFDmCK-TOKbOvO+Q@mail.gmail.com>
 <CAM9d7chXVsoNP6uYMCqy2MZOiWkt4GrFn+giYLHQjaJRsap1Cw@mail.gmail.com> <CAHk-=wjY7CG5WRZQ3E1gdEO9YtUQstMe7a=ciShY0wz0hKXyuQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjY7CG5WRZQ3E1gdEO9YtUQstMe7a=ciShY0wz0hKXyuQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 25 May 2024 16:34:14 -0700
Message-ID: <CAP-5=fUvT+O0iyXxst3WKqnWdpimqD8+aX8GJU7_7zYieniYxQ@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.10
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Clark Williams <williams@redhat.com>, 
	Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Anne Macedo <retpolanne@posteo.net>, 
	Bhaskar Chowdhury <unixbhaskar@gmail.com>, Ethan Adams <j.ethan.adams@gmail.com>, 
	James Clark <james.clark@arm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Tycho Andersen <tycho@tycho.pizza>, 
	Yang Jihong <yangjihong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 25, 2024 at 10:22=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, 25 May 2024 at 00:38, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Yep, so I'm curious what makes it fail.  IIUC the commit in question
> > would convert "cycles" event to "${whatever_pmu}/cycles/" if the pmu
> > has "events/cycles" alias in sysfs or in JSON.  But it should work afte=
r
> > that too. :(
>
> Well, having looked at it some more, I have the main CPU PMU:
>
>     /sys/bus/event_source/devices/armv8_pmuv3_0/
>
> which has a 'cpu_cycles' event, and the cpumask covers all the 128
> cores in this thing.
>
> That's the thing the regular profiling *should* use:
>
>     $ ls events/
>     br_mis_pred          l1d_cache_wb        l3d_cache_allocate
>     br_mis_pred_retired  l1d_tlb             l3d_cache_refill
>     br_pred              l1d_tlb_refill      l3d_cache_wb
>     br_retired           l1i_cache           mem_access
>     bus_access           l1i_cache_refill    memory_error
>     bus_cycles           l1i_tlb             sample_collision
>     cid_write_retired    l1i_tlb_refill      sample_feed
>     cpu_cycles           l2d_cache           sample_filtrate
>     exc_return           l2d_cache_allocate  sample_pop
>     exc_taken            l2d_cache_refill    stall_backend
>     inst_retired         l2d_cache_wb        stall_frontend
>     inst_spec            l2d_tlb             ttbr_write_retired
>     l1d_cache            l2d_tlb_refill
>     l1d_cache_refill     l3d_cache
>
> But the thing that seems to have confused the new parsing is that this
> machine _also_ has
>
>     /sys/bus/event_source/devices/arm_dsu_{0..63}/
>
> which all have a 'cycles' event:
>
>     $ ls events/
>     bus_access  cycles     l3d_cache_allocate  l3d_cache_wb
>     bus_cycles  l3d_cache  l3d_cache_refill    memory_error
>
> but these things are basically some "each pair of cpus has some bridge
> to the L3", which is why this 128-core machine has 64 of them. So each
> of those have something like this:
>
>     $ cat cpumask
>     40
>     $ cat associated_cpus
>     40-41
>
> I did not look any closer at what the 'cycles' there can actually
> count, but clearly they can't be used for recording. And even if they
> can, they shouldn't for the default "cycles".

So this is now the behavior with the patch I sent.

> > It seems my system doesn't have the alias (both in x86_64 and arm64)
> > at least in sysfs.  I think that's why I don't see the failure and mayb=
e
> > there's a specific hardware issue - like a M1 macbook issue?  IIRC it
> > required the exclude_guest bit to be set, but I think we handled it alr=
eady
> > so this must be a different issue.
>
> This is my new Ampere system, which has basically replaced the M2
> Macbook Air as my arm64 test platform, since it builds the kernel a
> whole lot faster. That's what 128 cores will do...
>
> Ian's patch at
>
>     https://lore.kernel.org/lkml/20240525152927.665498-1-irogers@google.c=
om/
>
> makes things work for me again, but I get the feeling that the JSON
> parsing is too fragile. It should have noticed that the 'cycles' event
> it found wasn't useful for profiling, and gone on to the next one,
> instead of just giving an incomprehensible error message.
>
> I think the real problem was that the JSON parsing code blindly just
> looked for "cycles".

I don't think JSON really means anything here. We use JSON as a way to
import tables of events. We want to map an event name to a config
value, we could do it in lots of different ways. There is a difference
between:
 - legacy events: hard coded event numbers for certain typically CPU
events, although there are L3 cache events in there,
 - sysfs: events advertised by the PMU driver in sysfs,
 - events built into the tool, imported from json files.

The first problem that happened was BIG.little. ARM did nothing to fix
the perf APIs for BIG.little and Intel fixed things up when they did
hybrid. What does it mean to open a legacy event on a process in a
BIG.little CPU when the process may be scheduled onto either BIG or
little cores? ARM's non-solution was that you'd profile based on which
PMU driver registered first and not profile on the other - you would
be profiling on some fraction of your CPUs but not all.

While Intel added proper hybrid/BIG.little support they did so by
essentially forking every aspect of the perf tool to have a "hybrid"
version. I put a stop to this in the metrics code and by doing so
ended up taking on responsibility for cleaning up the mess Intel had
been creating. This led to the event parser being able to parse "<PMU
name>/<legacy event name>/" for example in "cpu_core/cycles/" and
"cpu_atom/cycles/" and encode the legacy event.

This caused issues on ARM, especially Apple ones - maybe Apple should
be asked to support their PMU? Previously their PMU would advertise
events like cycles and the sysfs encoding would be used as there was
no notion of using the legacy encoding. Now the legacy encoding was
used and for some reason we don't maintain legacy mappings of events
for PMUs on Apple CPUs. After being politely shouted at, and to my
surprise Intel agreeing, we made it so sysfs or events built into the
tool take priority over legacy events if the PMU is specified. This
wasn't a small change as every test expectation needed updating for
this. We still have some broken test expectations.

So we had a case where legacy events weren't the priority if the PMU
was specified but when no PMU was specified they had priority. This
was frankly weird and so the patch you bisected to fixed this and was
also a behavior RISC-V had asked for. There was even some discussion
on this subject at LPC 2023.

Is everything fixed? Nope. It is still the case on ARM that we don't
profile on all CPUs for perf stat. This is because when no event is
specified hand crafted perf_event_attr are passed to perf_event_open
and these perf_event_attr need to open multiple for a
BIG.little/hybrid system:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/perf/builtin-stat.c#n1942
I wrote a fix for this:
https://lore.kernel.org/lkml/20240510053705.2462258-4-irogers@google.com/
Unreviewed/unmerged and frankly I think ARM should be in the driving
seat for reviewing it as it is trying to fix their CPUs.

> The only thing that seems to make Ian's new
> evlist__add_default_events() special is that it uses
> "perf_pmus__scan_core()" for that cycles finding, which in turn then
> uses only the *core* PMU's.
>
> It feels to me like the "parse the JSON info" is just too fragile,
> picks the wrong events, and Ian's "add defaults" just works around the
> weakness.

So I think the parsing is now robust/consistent but that doesn't mean
the behavior matches your expectations.

I say robust as when any event, regardless of whether it happens to
alias the few hundred legacy names, will parse. Previous parsing meant
events advertised by AMD's PMU, like branch-brs, would return parse
errors as "branch" and "brs" looked like components of a legacy event
name.

Consistent in that, regardless of event name, we will try the same
process to find the event.

I don't understand why you think JSON comes into this. Is it because
I've sent patches with JSON encoding events and metrics in? In the
case of AMD's "branch-brs" and the "cycles" event, the event has been
advertised via sysfs and not from data in JSON tables.

> But whatever. With his patch, at least it works for me.

You followed up in:
https://lore.kernel.org/lkml/CAHk-=3Dwi5Ri=3DyR2jBVk-4HzTzpoAWOgstr1LEvg_-O=
XtJvXXJOA@mail.gmail.com/
with:

> So no. That still needs to be fixed, or the whole "prefer sysfs/JSON
> by default" needs to be reverted.

So I think we still need to figure out what:

$ perf <command> -e <event> ...

where <event> doesn't specify a PMU means. I'll try to enumerate the option=
s:

1) the 6.9 behavior where <event> will be searched for on every PMU
and each PMU that has that event will have it opened. This can lead to
failures depending on what <command> is going to do. If <event> is a
legacy event name then it will be opened only on core PMUs.
2) the current perf-tools branch behavior where <event> is searched
for on every PMU regardless of it being a legacy or non-legacy event
name.
3) (2) but we change drivers to not advertise events where the name
conflicts with a legacy event name.
4) if the PMU isn't specified with <event> then we only search core
PMUs (e.g. armv8_pmuv3_0, cpu, cpu_core, cpu_atom)
5) we parse all events as with (2) but depending on <command> can
choose to ignore perf_event_open failing.

I'll try to rustle up a patch for (5), I have no way to test it. I
expect it will make somebody somewhere unhappy, apologies in advance.

Thanks,
Ian

>                  Linus
