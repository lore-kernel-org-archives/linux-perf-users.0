Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1631ABEDD
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Aug 2024 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723742991; cv=none; b=tNRQh/2WsIeHYBbK0++uniHtoLq1WUy0Mil+7sy/z4htBJpOeqFwsoTbLRK+HHMQehi/W4p9aQgdGg5wPJ4VxA4D4DhB956Hm3nnipATlOLLK1oHanCUqToUABw+3qFsf+PlssI56yaDANas3lFVwgNef32m+dlyC9Qt5vCRNDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723742991; c=relaxed/simple;
	bh=a/4vf+YJE4tfB80UP49O2UQzbAx9vqd1PyCAADHHECQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q51cU0l4evEFscP3b5wjjyPLEte1cB90s8jO8m9GFmEDCwGYIPR8UFjSPF+70EcL/ZlLEDi43OTrCR1FzR/CMiIqlI8ZcpsA7eHlbY2f08BJ72nLBxZCuFtKBhLaNmLJrva6cKc/JaC37TfoMD8R69GNUHNBewRcKg/dTnzDdIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UzlY6j3f; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UzlY6j3f"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fd7509397bso6965ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Aug 2024 10:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723742989; x=1724347789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/4vf+YJE4tfB80UP49O2UQzbAx9vqd1PyCAADHHECQ=;
        b=UzlY6j3fFSxXDSA15J0l4UurMF02yWBrZQOx+HGqKC3nhzWPVAYc5yyAnBeZRSJ62H
         Z52zngm+vnRmUqyhZMa2DP0RnFYVryOpDhfrY2pkpXTeCL+wyyf7tBJskF3lTOLSOW+J
         36wozT7LVw6O0O/GOa3oDWrd5aLykXgi0bPAIRxiuWVPZrC/+xeh4I1tkszonoeFuftG
         UkRBbfwbBdVJZ4F95R+cV72w7fL3RUBpTXJfE7non9Jg+RrS0f68DLO2TpwoT4sx0gcv
         w2FHA2kgPjdPwL42RxdzDHK2oEIWy3OpmCD/7HkHJ3VMB0hwEQGzDEX59Mi4O/XGznvZ
         8IqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723742989; x=1724347789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/4vf+YJE4tfB80UP49O2UQzbAx9vqd1PyCAADHHECQ=;
        b=hNorX715X/TkaLy8IIlrhVGwb3AgL0fYh/FTq4MPMNi8U0LGO2aqgQqSP491bL7baf
         MjEPgkz8H163sWhWyb2wI8DL+Sx6DQQU1XnOAjULZqevZ1lwQtCJoSR2fJlvPiYVmeBU
         ggOz8QW23l4wwb+g4kdE4SPjqxS5n+vTme0bG4TGoIeUSi+z8EOCaDwDZVi1Q7IwBLcZ
         z0l0fgCvko383dqgUsBJ377GAnIUkYHddPOz7AGFzR6u7Cf48ri4N+rfKwvhjL7We6Kq
         tOfmb5gnvwDwCImRokQCVLBEc+u7Taxo+IByhqHSZhkhui5hNKDeCiEjDS0WBj8e9tDJ
         kX+w==
X-Forwarded-Encrypted: i=1; AJvYcCUN4jlKPH2aYCft22SL5fyLW3/ibLe1+qKfsj/+FhH212zvjT/Ti3TYWX7VNM9CaDWYitvGTDDsVx6RpoZe3lrDt3g5YSUObdtg/UJ5U6MMNw==
X-Gm-Message-State: AOJu0YyzoUsKdIwLgEJnM0gOGxFgsoYd/FsZyLGfLHGZBPL4eRLVQpsy
	g3bLwGFvJgII6SG6dF1up+VV3JAAWkJ01/4FgnnPWxQDLmFeo+aqJ1jEdRroT4FEVmYv/qy/c8M
	lT9g+bTTqzZqwsFxC0RBOgfgOJEMBe+Nk8i7H
X-Google-Smtp-Source: AGHT+IH5MFIGSF7/WgzVtKFPpR15fzT6c8P4TJi4KagEceRO9o+l2byg+PRLLOxu2Bd7ImoT8/HtaG1VoEHIB0RWyZg=
X-Received: by 2002:a17:902:e80c:b0:201:fa2c:6d55 with SMTP id
 d9443c01a7336-201fa2c6efemr630395ad.13.1723742988974; Thu, 15 Aug 2024
 10:29:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st>
 <ZV1AnNB2CSbAUFVg@archie.me> <a9c14dfd-3269-4758-9174-4710bef07088@leemhuis.info>
 <CAP-5=fXqx_k1miPTkcAmS3z2GBPt2KeDtP5fknmdDghZqxXPew@mail.gmail.com>
 <714ed350-0e6c-4922-bf65-36de48f62879@leemhuis.info> <0de3b572-f5f7-42e4-b410-d1e315943a3c@linaro.org>
In-Reply-To: <0de3b572-f5f7-42e4-b410-d1e315943a3c@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 15 Aug 2024 10:29:37 -0700
Message-ID: <CAP-5=fVSVe=C5dHaOV22+YOZ_JCD0mDoByoubSFY3w4au5zwQg@mail.gmail.com>
Subject: Re: [REGRESSION] Perf (userspace) broken on big.LITTLE systems since v6.5
To: James Clark <james.clark@linaro.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Linux perf Profiling <linux-perf-users@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, James Clark <james.clark@arm.com>, 
	"cc: Marc Zyngier" <maz@kernel.org>, Hector Martin <marcan@marcan.st>, Asahi Linux <asahi@lists.linux.dev>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 9:28=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
> On 07/08/2024 9:54 am, Thorsten Leemhuis wrote:
> > On 01.08.24 21:05, Ian Rogers wrote:
> >> On Wed, Dec 6, 2023 at 4:09=E2=80=AFAM Linux regression tracking #upda=
te
> >> (Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
> >>>
> >>> [TLDR: This mail in primarily relevant for Linux kernel regression
> >>> tracking. See link in footer if these mails annoy you.]
> >>>
> >>> On 22.11.23 00:43, Bagas Sanjaya wrote:
> >>>> On Tue, Nov 21, 2023 at 09:08:48PM +0900, Hector Martin wrote:
> >>>>> Perf broke on all Apple ARM64 systems (tested almost everything), a=
nd
> >>>>> according to maz also on Juno (so, probably all big.LITTLE) since v=
6.5.
> >>>
> >>> #regzbot fix: perf parse-events: Make legacy events lower priority th=
an
> >>> sysfs/JSON
> >>> #regzbot ignore-activity
> >>
> >> Note, this is still broken.
> >
> > Hmmm, so all that became somewhat messy. Arnaldo, what's the way out of
> > this? Or is this a "we are screwed one way or another and someone has t=
o
> > bite the bullet" situation?
> >
> > Ciao, Thorsten
> >
> >> The patch changed the priority in the case
> >> that you do something like:
> >>
> >> $ perf stat -e 'armv8_pmuv3_0/cycles/' benchmark
> >>
> >> but if you do:
> >>
> >> $ perf stat -e 'cycles' benchmark
> >>
> >> then the broken behavior will happen as legacy events have priority
> >> over sysfs/json events in that case. To fix this you need to revert:
> >> 4f1b067359ac Revert "perf parse-events: Prefer sysfs/JSON hardware
> >> events over legacy"
> >>
> >> This causes some testing issues resolved in this unmerged patch series=
:
> >> https://lore.kernel.org/lkml/20240510053705.2462258-1-irogers@google.c=
om/
> >>
> >> There is a bug as the arm_dsu PMU advertises an event called "cycles"
> >> and this PMU is present on Ampere systems. Reverting the commit above
> >> will cause an issue as the commit 7b100989b4f6 ("perf evlist: Remove
> >> __evlist__add_default") to fix ARM's BIG.little systems (opening a
> >> cycles event on all PMUs not just 1) will cause the arm_dsu event to
> >> be opened by perf record and fail as the event won't support sampling.
> >>
> >> The patch https://lore.kernel.org/lkml/20240525152927.665498-1-irogers=
@google.com/
> >> fixes this by only opening the cycles event on core PMUs when choosing
> >> default events.
> >>
> >> Rather than take this patch the revert happened as Linus runs the
> >> command "perf record -e cycles:pp" (ie using a specified event and not
> >> defaults) and considers it a regression in the perf tool that on an
> >> Ampere system to need to do "perf record -e
> >> 'armv8_pmuv3_0/cycles/pp'". It was pointed out that not specifying -e
> >> will choose the cycles event correctly and with better precision the
> >> pp for systems that support it, but it was still considered a
> >> regression in the perf tool so the revert was made to happen. There is
> >> a lack of perf testing coverage for ARM, in particular as they choose
> >> to do everything in a different way to x86. The patch in question was
> >> in the linux-next tree for weeks without issues.
> >>
> >> ARM/Ampere could fix this by renaming the event from cycles to
> >> cpu_cycles, or by following Intel's convention that anything uncore
> >> uses the name clockticks rather than cycles. This could break people
> >> who rely on an event called arm_dsu/cycles/ but I imagine such people
> >> are rare. There has been no progress I'm aware of on renaming the
> >> event.
> >>
> >> Making perf not terminate on opening an event for perf record seems
> >> like the most likely workaround as that is at least something under
> >> the tool maintainers control. ARM have discussed doing this on the
> >> lists:
> >> https://lore.kernel.org/lkml/f30f676e-a1d7-4d6b-94c1-3bdbd1448887@arm.=
com/
> >> but since the revert in v6.10 no patches have appeared for the v6.11
> >> merge window. Feature work like coresight improvements and ARMv9 are
> >> being actively pursued by ARM, but feature work won't resolve this
> >> regression.
> >>
>
> I got some hardware with the DSU PMU so I'm going to have a go at trying
> to send some fixes for this. My initial idea was to try incorporate the
> "not terminate on opening" change as discussed in the link directly
> above. And then do the revert of the "revert of prefer sysfs/json".

Thanks, I think this would be good. The biggest issue is that none of
the record logic expects a file descriptor to be not opened, deleting
unopened evsels from the evlist breaks all the indexing into the
mmaps, etc. Tbh, you probably wouldn't do the code this way if was
written afresh. Perhaps a hashmap would map from an evsel to ring
buffer mmaps, etc. Trying to avoid having global state and benefitting
from encapsulation. I'd focus on just doing the expedient thing in the
changes, which probably just means making the record code tolerant of
evsels that fail to open and not modifying the evlist due to the risk
it breaks the indices.

(To point out the obvious, this work wouldn't be necessary if arm_dsu
event were renamed from "cycles" to "cpu_cycles" which would also make
it more intention revealing alongside the arm_dsu's "bus_cycles" event
name).

> FWIW I don't think Juno currently is broken if the kernel supports
> extended type ID? I could have missed some output in this thread but it
> seems like it's mostly related to Apple M hardware. I'm also a bit
> confused why the "supports extended type" check fails there, but maybe
> the v6.9 commit 25412c036 from Mark is missing?

So I think your later emails clarify Arnaldo is probably missing:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/co=
mmit/drivers/perf/arm_pmu.c?h=3Dperf-tools-next&id=3D5c816728651ae425954542=
fed64d21d40cb75a9f

Fwiw, the Apple M hardware issue came to me by way of Mark Rutland
(iirc), this regression report, etc. My understanding is that Apple M
has something like a v2 ARM PMU and the legacy events are encoded
incorrectly in the driver for this. The regression in v6.5 happened
because ARM's core PMUs had previously been treated as uncore PMUs,
meaning we wouldn't try to program legacy events on them. Fixing the
handling of ARM's core PMUs broke Apple M due to the broken legacy
event mappings. Why not fix the Apple M PMU driver? Well there was
anyway a similar RISC-V issue reported by Atish Patra (iirc) where the
RISC-V PMU driver wants to delegate the mapping of legacy events to
the perf tool so the driver needn't be aware of all and future RISC-V
configurations. The fix discussed with Mark, Atish, etc. has been to
swap the priority of legacy and sysfs/json events so that the latter
has priority. We need the revert of the revert as currently we only do
this if a PMU is specified with an event, not for the general wildcard
PMUs case that most people use. There was huge fallout from flipping
the priority particularly on Intel as all test expectations needed
updating. I've sent out similar fixes that need incorporating when the
revert is reverted. Ideally tools/perf/tests/parse-events.c would be
updated to cover ARM's PMUs that don't follow the normal pattern that
the core PMU is called "cpu" (this would mean that we were testing
event parsing on ARM was WAI wrt encoding priorities, BIG.little,
etc).

> I sent a small fix the other day to make perf stat default arguments
> work on Juno, and didn't notice anything out of the ordinary:
> https://lore.kernel.org/linux-perf-users/dac6ad1d-5aca-48b4-9dcb-ff7e54ca=
43f6@linaro.org/T/#t
> I agree that change is quite narrow but it does incrementally improve
> things for the time being. It's possible that it would become redundant
> if I can just include Ian's change to use strings for Perf stat.

I'd prefer we didn't merge this as we'd need to rebase:
https://lore.kernel.org/lkml/20240510053705.2462258-4-irogers@google.com/
and those changes would then delete the code introduced. I'm fine with
adding the tests.

There are more exotic heterogeneous core things upcoming, probably
also from ARM, and the thought of duplicating the default attribute
logic and event parsing constraints is just something I'd prefer not
to have to do.

> Of course I only think I have a handle on the issue right now, seems
> like it has a lot of moving parts and something else always comes up. If
> I hit a wall at some point I will come back here.

Thanks,
Ian
