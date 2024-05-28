Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0162E2563
	for <linux-perf-users@vger.kernel.org>; Tue, 28 May 2024 17:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716918006; cv=none; b=YDILBirsecPYlSdi4asDh6on8DPX1EtEwJfpMAtrJrQcRPeiMd3ZuJpxpXr4eYo6KVkTn+6T7QzbGU4A4rs12Lzhzke4b/YagHkKJQiDt5FaE2fQE4v7zZZ363OAWD144TaOtTFQ85oMA7WN67GpcPMCMTF4/h1PcC0v/E+wbB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716918006; c=relaxed/simple;
	bh=lXSn8ThsYvfxIN0Qd9QHZh3xt5vjFFJUhZrdayvJuDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rekrpTNch8DQMeZqZNLFlF9A7XECwhWLiYDHHjXcIH/ju4HcAT98zOSAhChK7VSkt/AlD3+1L4YLlkF2+wRI1BdmJkHWZHmEnVrfS4lHYJWLHDhu2zwRTP02dlEK2LNCE7/WncwwP92dBQoiwTJcRowu61oz+IJgN6RxjyLCVbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aQ3x210s; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aQ3x210s"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f48e9871e2so20535ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 May 2024 10:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716918004; x=1717522804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kq6ro/o/mynJuC/f6DEQ1M9MUXbyfGiQuVDeIAKrcKs=;
        b=aQ3x210sHS/DQhhuk3l7YT5qVfh+kFjZvceV6uUJbf+9sznRYtKSgklUCubUItNwdh
         7Jdx5kQejvPrW5bA9Ggilm5/UHRJQuMhfBg1xQ1gRIfhRewO7tWZjUCKkBKlPOwfU//g
         kJUM6KJrgfnhArshaITALzGl+FITa234rVNyCJSX09Qu7BIZCt2nPl4BshhDSgSCpg9h
         +NZwmvQ5cLiZNA/Gmv6rV16gyeffMGLZnwgKmk062Fdud/A5Dw0nPFNHZjMBJDXoblE4
         803jrl7ZCQWfREJsPGA2pEnknAAvrj/n2ftpeIlOuokLQogpGx4xmSu704ngOPWYTwam
         nGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716918004; x=1717522804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kq6ro/o/mynJuC/f6DEQ1M9MUXbyfGiQuVDeIAKrcKs=;
        b=DHa2fiBnnmzxvLovq5KFWfQOTQH1PWEECRiovpFZ6tk6NY5/gJdreKIHDGSyVdg7jz
         uNJoy66+NklPG/sKl5D0pQ0qb+5hxSiu9QbMMqVeOS0ZVDT9ChTavsVNKnBw/KNJy+XL
         cGnapTLRlf4XcfuTQ/+6+gbpAkfc48WtXjeK30ukK7EtBloBjpJmiGi4mXFWRfilGqmF
         sAooINFLtGnzZ9uPLhKCv77Q/mC7UF4PwjhCUTG4DwdOl/TQBobQVZjneRQWp6V6jOfc
         ju6NkZUfNhMakbm5OXivUaTrXy2RGcfrYcG0KoeFgRoWZkvqUrpAaeli774kidAIQ625
         HlLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0+rBsLIzHDxs9SlYMXThEwBpDZJe6NS19Zl3wgb1098HASJ4TyF+p5Xv0MISOds1tck7eJ2QAWKItYHsDEHkFosFIDbxtS02T6Dw5s2Nahg==
X-Gm-Message-State: AOJu0YzZ6Z2D3kzaSeUhhfsAEUrxAr12oOLDKHrAycC4pg1XKvGsB4PX
	UA45Vi5M7kOAZaJDV7l1IXsEYUG6rSWvbc5SpWiG/3Eg8i8P2IIp4WMQ/bPYShqCPqEC8TL/72m
	Rl4ran8v2UaXmU14oW0Dc8Yq3jMFR1ZFR/sWc8UGXw997FinZFFQdo2g=
X-Google-Smtp-Source: AGHT+IHcPxq9NejNLg0S7NcSsj7DSlW0Q8J5NZOFIFmMl8ZpvAt0K5VsvkH971wUprS2568A+M2fFIEUO71ZLFd/3jA=
X-Received: by 2002:a17:902:e94c:b0:1eb:3f4f:6f02 with SMTP id
 d9443c01a7336-1f4e79790d5mr75285ad.12.1716918003790; Tue, 28 May 2024
 10:40:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525152927.665498-1-irogers@google.com> <CAHk-=wgYxi_+Q1OpZKg2F9=eem7VQjYnoqN6sA1+uUt-0JqQKQ@mail.gmail.com>
 <CAHk-=wi5Ri=yR2jBVk-4HzTzpoAWOgstr1LEvg_-OXtJvXXJOA@mail.gmail.com>
 <20240527105842.GB33806@debian-dev> <CAP-5=fXfidyF_e=yMNi26ScgY-VbJPfxN8M7OiK9ELa3qTfXPQ@mail.gmail.com>
 <CAHk-=wgcoODsCbba423uZwQqOjJ8r29GZyCd472K6L6Dt-NbPg@mail.gmail.com>
In-Reply-To: <CAHk-=wgcoODsCbba423uZwQqOjJ8r29GZyCd472K6L6Dt-NbPg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 28 May 2024 10:39:50 -0700
Message-ID: <CAP-5=fUp+gSoLC90vT50X7So_SyAC9OprAMvh_Jj_8NTuO6j_w@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Force adding default events only to core PMUs
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 10:01=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 27 May 2024 at 22:37, Ian Rogers <irogers@google.com> wrote:
> >
> > If you do:
> >
> > $ perf stat -e cycles ...
>
> You always talk about "perf stat", because you want to ignore a big
> part of the issueL
>
> > The issue is about legacy events.
>
> No.
>
> The issue isn't "perf stat".
>
> That works. Even with the broken version.
>
> > I have a patch that's WIP for this, but I also think we could
> > also agree that when >1 PMU advertises an event, perf's behavior when
> > matching should be to open all such events. You avoid this by
> > specifying a PMU name.
>
> Christ. You're still ignoring the elephant in the room.
>
> Stop using "perf stat" as an example.  It's bogus. You're ignoring the is=
sue.
>
> Lookie here:
>
>     $ perf stat make
>     ...
>      Performance counter stats for 'make':
>
>               5,262.78 msec task-clock                       #
> 1.195 CPUs utilized
>                 46,891      context-switches                 #
> 8.910 K/sec
>                      6      cpu-migrations                   #
> 1.140 /sec
>                198,402      page-faults                      #
> 37.699 K/sec
>         10,238,763,227      cycles                           #
> 1.946 GHz
>         16,280,644,955      instructions                     #    1.59
>  insn per cycle
>          3,252,743,314      branches                         #
> 618.066 M/sec
>             83,702,386      branch-misses                    #
> 2.57% of all branches
>
>            4.405792739 seconds time elapsed
>
>            4.287784000 seconds user
>            0.921132000 seconds sys
>
> but then
>
>     $ perf record make
>     Error:
>     cycles:P: PMU Hardware doesn't support
> sampling/overflow-interrupts. Try 'perf stat'
>
> because that broken thing (a) picked a different cycles than before
> and (b) your argument that it should pick both IS WRONG BECAUSE ONE OF
> THEM DOESN'T EVEN WORK.

By default it picked "cycles:P" with this patch it now picks "<core
pmu>/cycles/P". As your Tested-by attested this does work.

> Why is this so hard to just accept? Why do you keep mis-stating the probl=
em?

I'm not. What your saying is that the arm_dsu_0 PMU advertising cycles
doesn't work if you use it for perf record. I agree. This change fixed
the issue. What to do if someone writes "perf record -e cycles" well
there are two advertised cycles events isn't it reasonable perf record
try to open them both?

> How hard is it to realize that I DO NOT WANT "perf stat"? The perf
> error message is bogus crap. If I ask for a "perf record", it
> shouldn't pick the wrong PMU that can't do it, and then say "do you
> want to do something else"?

It's not about perf record having some kind of intelligence and
picking a PMU. perf record either opens an event on the PMU you ask
for it it wild cards across them all. For legacy events they used to
be handled differently and I'm trying to fix this. In part so I can
fix the PMU behavior on the Apple M1 and later CPUs that fail to
implement legacy events properly in their PMU driver.  You've said you
used to use Apple CPUs for ARM testing, I'm trying to fix a problem
that will help you.

> I don't care a whit for "legacy events". I care about the fact that
> you changed the code to pick the WRONG event, and then you are blaming
> anything but that.

Sure, I added "if user =3D=3D linus then pick wrong PMU". The code was
reviewed by IBM and Intel. ARM were on the CC list. The change baked
on linux-next for a good long while. All of this points to my problem
that I'm often fixing problems for ARM with a complete lack of
testing/reviewing/acking... by them.

> If perf would go "Oh, this one doesn't support 'record', let's see if
> another one does", it would all be good.
>
> If perf would go "Oh, let's prioritize core events", it would all be good=
.

But as I've pointed out it wouldn't because then you'd break the
behavior of doing things like gathering memory bandwidth from uncore
PMUs. An example:
```
$ sudo perf stat -e data_read -a sleep 1

 Performance counter stats for 'system wide':

          4,447.10 MiB  data_read

       1.001748581 seconds time elapsed
```
By making the wildcard only work for core PMUs the best case is you'd make =
this:
```
$ sudo perf stat -e 'imc_free_running/data_read/' -a sleep 1

 Performance counter stats for 'system wide':

          4,454.56 MiB  imc_free_running/data_read/

       1.001865448 seconds time elapsed
```
But that wouldn't work again as ARM decided to mess up the naming
convention, my unmerged fix for that is here:
https://lore.kernel.org/lkml/20240515060114.3268149-1-irogers@google.com/
it says Marvell but Marvell followed ARM's lead.

> But no. Your patch actively picked a bad event, and then you try to
> blame some "legacy" thing.
>
> Yes, the legacy thing picked the right event, but it's not even about
> legacy. You could have picked the right event any number of other
> ways.
>
> It's about "it damn well worked when you didn't go out of your way to
> pick the wrong event".
>
> In other words, this isn't about "legacy" and "new".

I'm not clear what you think is "new". All the events are being picked
in your case from sysfs, the way this has all worked is years if not
decades old. What is new is that because of an event name the behavior
should be uniform, motivated initially by fixing your other ARM test
platform of Apple.

> This is about "right" and "wrong". The old code picked right - for
> whatever reasons. The new code picked wrong - also for whatever
> reasons.
>
> Don't try to make it be anything else. Just admit that the new code
> picked the wrong PMU, instead of trying to make excuses for it.

I agree it picked the wrong PMU for default events. This was a problem
on no systems that anybody was bothering to test with. Having been
made aware of the issue I fixed it in this patch, you're welcome.

What is still not clear from this is what should the behavior be of:

$ perf record -e cycles ...

Should it wildcard all events and open them on all PMUs potentially
failing? Well this has always been perf's behavior were the event:

$ perf record -e inst_retired.any ...

where inst_retired.any could be an event advertised on an accelerator
or device where sampling doesn't work. If inst_retired.any doesn't
work for you as an example, pick another event that does. A GPU has
instructions and cycles so the likelihood of naming conflicts is high.

We can make perf record ignore opening events on PMUs that don't
support sampling, it's an invasive and non-trivial change not suited
to landing in 6.10. It is also a behavior change, see this thread for
how popular those are.

So 6.10 is now in a mess. We likely fail tests, reverting this change
has a bunch of consequences and presumably I'm expected to dig
through, figure those out and then provide fixes. Thanks!

For 6.11 I currently suggest we revert the revert and apply this
patch. This would also I think be the best thing to do for 6.10. I
appreciate my opinions are worth much less than others. I don't see
why the priority should be to fix things on an ARM system that nobody
is actively testing on rather than say Apple devices fixed by the
reverted change, RISC-V system, etc. Anyway...

Thanks,
Ian

>                Linus
>
