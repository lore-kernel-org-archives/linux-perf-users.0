Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B06623E356
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Oct 2025 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759331574; cv=none; b=UhVm0OJgWBm6mt5foFWxhhEslOBxDXCYrUh+oUSYxIkWHgb/fYYYsnwcSivCZAguVGO03EqIxagJGzRStH+uphqmEeJpcIJLEZNK+ErLdqHcVhblc1tGwqpX259b4XGgyjrlf4MzRf+0c1B0b86XyfzzuutG4lev4rHEGMHEk0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759331574; c=relaxed/simple;
	bh=8oNDG86TZ07XYux57SEpF/H9dhi9dvoHlRVIRW7qe5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J9CipptezWOJJelS3G8DeW0h68Tlu9zGx61bHUOqkz6W4B4k7xfrlJ7UdPl28VHKGDpZldDGy6lvCZso3BB5NJoJ/vIq39uRgMGDK7YbwmbYlzClMZ+oyzZPg2Zpi0gN6gNBaecDUj0D9dsNl7AoHt+o6XXJM7PTYYk+kqUwUvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D/OSCLO1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D/OSCLO1"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2681645b7b6so162425ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Oct 2025 08:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759331572; x=1759936372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=By9EATg/7iGsCftMxP7XGM1WXGGuxaHVyyGMtP3OxWc=;
        b=D/OSCLO19TKgAc/2HXdzo7Fcbh2jpRuaHqvxx4ag4Eue+RPsCUsPcoQYsZTTNjzf/V
         n/0OsmqldHt4PJ8by3fplr3+gfmZF2UygXy8R4uIi3OXW/QhZ7DaStPI9NGb57czNXTv
         ITttFFWFqcKBlARbL6bHpzIBO5eu3wNU85wwcPAfUwBy+3S6JIp4cmh/ZMmKh8oe4p24
         4eef3WAg4LdW4E9UaQlC4I1mgBymUJTVfeyE/lJaY8YMRXE+TIMukqzKaGn6jczJ1DwE
         gxodNgTKzH4viQejnsW4cc77yv00DaJZY8mkI8iSJ55wbZgmPPvM/RYrCM+yIVpuGkGA
         X4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759331572; x=1759936372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=By9EATg/7iGsCftMxP7XGM1WXGGuxaHVyyGMtP3OxWc=;
        b=RKIBLG4OHcu31xw+XhtR4FMNyrfZyY0LLcimnfAOA5Zerzt0t0b8BaTZOpSwVufZZf
         oAO/IqGFTCnw90J4L4cedM1Ebgsc/z9VHahxanVcaCKP5Bx5GPHOP+jNT1ssyQnKYfEp
         xYFYz2T5+L7A9SmgE7Bnpb+DNiEGyT1U0rR9Zt7v7QJ17Jobgd/qogFnXtC8dzmHKhkF
         XskoI97/VsB9iNzLBhtUkJ6VwGkCMSksvqj7n5RtcENVUucg+SsF6mDFdnR7Fb3C4RRX
         WKhFmLJysa4OChOPdKDRk/BG3nKizB4N9CjFD0b5s4qr11T/u3bCCvutI74tS5nTWwHU
         J9TQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbKBvyts85TSGZf/2L6EqBdUnVj7RL7/+RxQeHLFEXziqonRyCD3DRzf8pmJQOHwUelHTUW2dEAlYLekESZhx7@vger.kernel.org
X-Gm-Message-State: AOJu0YyU9ArdBHSj3IrTAOX25xjXYoarUDln2GqffuWVUsQN9L2/NtKx
	OD1PgmtRuFkChI+kBdLksQxrUE9TUmam9Dy25RZ7mf1+mHbQG0uS417KbS5E5NW0jkKaOr1CHGx
	ZPxjYmuaLz3adVUznHVLw5oNS+G+epsxoaL/3aeNW
X-Gm-Gg: ASbGnct9rlYPx5xfrJIWecYID2UV6kqg1RO9RvFXBhqb6gGNlklK6weqq8tAdTgYQgu
	ea6Z6QbvFD4BqNV+VI0YefpRtmGviAFcTtugN+dPlW8xpPWfOrK/u9O2jTquLvenKdg5IYVtmpZ
	uJGIWMKi588D8FFA7sE7O7EF4QPKa4oAfv5fv4luBoaK0cfNQrjKILonga3Brp0qw2kQMMD85RQ
	AKGnTyRVOJXWdeGsyaqMlgFtk1yyoOZgynFwp+gs4KU2q+jSgocSOHVk907WgThEgmd
X-Google-Smtp-Source: AGHT+IFb8ZJd2qNnAQ1IkcnjFiCNu5tm0vHw/OjrpoQRYJPa5OoezYIcClMUM2rjfkgM/KQUjPU5VyiRdjzuTtjFXsU=
X-Received: by 2002:a17:902:cece:b0:264:1805:df20 with SMTP id
 d9443c01a7336-28e7fdd3bf0mr4717585ad.4.1759331571162; Wed, 01 Oct 2025
 08:12:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923223312.238185-1-irogers@google.com> <ca47d298-331d-420c-8c4f-83cd29bae902@linaro.org>
In-Reply-To: <ca47d298-331d-420c-8c4f-83cd29bae902@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Oct 2025 08:12:39 -0700
X-Gm-Features: AS18NWBy9Hk9dJpCoVpNawHjux1xtXUCQHTW2qWeQTJoYD2mRBPwmJ-68vbxHD4
Message-ID: <CAP-5=fWUYH2eji2SNp37_2uHu55qEfRxuhhROYsMZeCixjda+g@mail.gmail.com>
Subject: Re: [PATCH v6 00/28] Legacy hardware/cache events as json
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, 
	Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 6:38=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
>
>
> On 23/09/2025 11:32 pm, Ian Rogers wrote:
> > Mirroring similar work for software events in commit 6e9fa4131abb
> > ("perf parse-events: Remove non-json software events"). These changes
> > migrate the legacy hardware and cache events to json.  With no hard
> > coded legacy hardware or cache events the wild card, case
> > insensitivity, etc. is consistent for events. This does, however, mean
> > events like cycles will wild card against all PMUs. A change doing the
> > same was originally posted and merged from:
> > https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.com
> > and reverted by Linus in commit 4f1b067359ac ("Revert "perf
> > parse-events: Prefer sysfs/JSON hardware events over legacy"") due to
> > his dislike for the cycles behavior on ARM with perf record. Earlier
> > patches in this series make perf record event opening failures
> > non-fatal and hide the cycles event's failure to open on ARM in perf
> > record, so it is expected the behavior will now be transparent in perf
> > record on ARM. perf stat with a cycles event will wildcard open the
> > event on all PMUs, however, with default events the cycles event will
> > only be opened on core PMUs.
> >
> > The key motivation for these patches is so that if, for example, you
> > run `perf stat -e cpu-cycles ...` on a hybrid x86 and the results are
> > printed out with "cpu_core/cpu-cycles/" and "cpu_atom/cpu-cycles/",
> > the perf_event_attr for cpu-cycles and cpu_core/cpu-cycles/ be the
> > same, similarly for the cpu_atom event. Prior to these patches the
> > event with a PMU prefers sysfs/json over legacy encodings while with
> > no PMU legacy encodings are preferred - these are different encodings
> > on x86.
> >
> > The change to support legacy events with PMUs was done to clean up
> > Intel's hybrid PMU implementation. Having sysfs/json events with
> > increased priority to legacy was requested by Mark Rutland
> >   <mark.rutland@arm.com> to fix Apple-M PMU issues wrt broken legacy
> > events on that PMU. It is believed the PMU driver is now fixed, but
> > this has only been confirmed on ARM Juno boards. It was requested that
> > RISC-V be able to add events to the perf tool json so the PMU driver
> > didn't need to map legacy events to config encodings:
> > https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivosinc.c=
om/
> > This patch series achieves this.
> >
> > A previous series of patches decreasing legacy hardware event
> > priorities was posted in:
> > https://lore.kernel.org/lkml/20250416045117.876775-1-irogers@google.com=
/
> > Namhyung Kim <namhyung@kernel.org> mentioned that hardware and
> > software events can be implemented similarly:
> > https://lore.kernel.org/lkml/aIJmJns2lopxf3EK@google.com/
> > and this patch series achieves this.
> >
> > Note, patch 2 (perf parse-events: Fix legacy cache events if event is
> > duplicated in a PMU) fixes a function deleted by patch 17 (perf
> > parse-events: Remove hard coded legacy hardware and cache
> > parsing). Adding the json exposed an issue when legacy cache (not
> > legacy hardware) and sysfs/json events exist. The fix is necessary to
> > keep tests passing through the series. It is also posted for backports
> > to stable trees.
> >
> > The perf list behavior includes a lot more information and events. The
> > before behavior on a hybrid alderlake is:
> > ```
> > $ perf list hw
> >
> > List of pre-defined events (to be used in -e or -M):
> >
> >    branch-instructions OR branches                    [Hardware event]
> >    branch-misses                                      [Hardware event]
> >    bus-cycles                                         [Hardware event]
> >    cache-misses                                       [Hardware event]
> >    cache-references                                   [Hardware event]
> >    cpu-cycles OR cycles                               [Hardware event]
> >    instructions                                       [Hardware event]
> >    ref-cycles                                         [Hardware event]
> > $ perf list hwcache
> >
> > List of pre-defined events (to be used in -e or -M):
> >
> >
> > cache:
> >    L1-dcache-loads OR cpu_atom/L1-dcache-loads/
> >    L1-dcache-stores OR cpu_atom/L1-dcache-stores/
> >    L1-icache-loads OR cpu_atom/L1-icache-loads/
> >    L1-icache-load-misses OR cpu_atom/L1-icache-load-misses/
> >    LLC-loads OR cpu_atom/LLC-loads/
> >    LLC-load-misses OR cpu_atom/LLC-load-misses/
> >    LLC-stores OR cpu_atom/LLC-stores/
> >    LLC-store-misses OR cpu_atom/LLC-store-misses/
> >    dTLB-loads OR cpu_atom/dTLB-loads/
> >    dTLB-load-misses OR cpu_atom/dTLB-load-misses/
> >    dTLB-stores OR cpu_atom/dTLB-stores/
> >    dTLB-store-misses OR cpu_atom/dTLB-store-misses/
> >    iTLB-load-misses OR cpu_atom/iTLB-load-misses/
> >    branch-loads OR cpu_atom/branch-loads/
> >    branch-load-misses OR cpu_atom/branch-load-misses/
> >    L1-dcache-loads OR cpu_core/L1-dcache-loads/
> >    L1-dcache-load-misses OR cpu_core/L1-dcache-load-misses/
> >    L1-dcache-stores OR cpu_core/L1-dcache-stores/
> >    L1-icache-load-misses OR cpu_core/L1-icache-load-misses/
> >    LLC-loads OR cpu_core/LLC-loads/
> >    LLC-load-misses OR cpu_core/LLC-load-misses/
> >    LLC-stores OR cpu_core/LLC-stores/
> >    LLC-store-misses OR cpu_core/LLC-store-misses/
> >    dTLB-loads OR cpu_core/dTLB-loads/
> >    dTLB-load-misses OR cpu_core/dTLB-load-misses/
> >    dTLB-stores OR cpu_core/dTLB-stores/
> >    dTLB-store-misses OR cpu_core/dTLB-store-misses/
> >    iTLB-load-misses OR cpu_core/iTLB-load-misses/
> >    branch-loads OR cpu_core/branch-loads/
> >    branch-load-misses OR cpu_core/branch-load-misses/
> >    node-loads OR cpu_core/node-loads/
> >    node-load-misses OR cpu_core/node-load-misses/
> > ```
> > and after it is:
> > ```
> > $ perf list hw
> >
> > legacy hardware:
> >    branch-instructions
> >         [Retired branch instructions [This event is an alias of branche=
s].
> >          Unit: cpu_atom]
> >    branch-misses
> >         [Mispredicted branch instructions. Unit: cpu_atom]
> >    branches
> >         [Retired branch instructions [This event is an alias of
> >          branch-instructions]. Unit: cpu_atom]
> >    bus-cycles
> >         [Bus cycles,which can be different from total cycles. Unit: cpu=
_atom]
> >    cache-misses
> >         [Cache misses. Usually this indicates Last Level Cache misses; =
this is
> >          intended to be used in conjunction with the
> >          PERF_COUNT_HW_CACHE_REFERENCES event to calculate cache miss r=
ates.
> >          Unit: cpu_atom]
> >    cache-references
> >         [Cache accesses. Usually this indicates Last Level Cache access=
es but
> >          this may vary depending on your CPU. This may include prefetch=
es and
> >          coherency messages; again this depends on the design of your C=
PU.
> >          Unit: cpu_atom]
> >    cpu-cycles
> >         [Total cycles. Be wary of what happens during CPU frequency sca=
ling
> >          [This event is an alias of cycles]. Unit: cpu_atom]
> >    cycles
> >         [Total cycles. Be wary of what happens during CPU frequency sca=
ling
> >          [This event is an alias of cpu-cycles]. Unit: cpu_atom]
> >    instructions
> >         [Retired instructions. Be careful,these can be affected by vari=
ous
> >          issues,most notably hardware interrupt counts. Unit: cpu_atom]
> >    ref-cycles
> >         [Total cycles; not affected by CPU frequency scaling. Unit: cpu=
_atom]
> >    branch-instructions
> >         [Retired branch instructions [This event is an alias of branche=
s].
> >          Unit: cpu_core]
> >    branch-misses
> >         [Mispredicted branch instructions. Unit: cpu_core]
> >    branches
> >         [Retired branch instructions [This event is an alias of
> >          branch-instructions]. Unit: cpu_core]
> >    bus-cycles
> >         [Bus cycles,which can be different from total cycles. Unit: cpu=
_core]
> >    cache-misses
> >         [Cache misses. Usually this indicates Last Level Cache misses; =
this is
> >          intended to be used in conjunction with the
> >          PERF_COUNT_HW_CACHE_REFERENCES event to calculate cache miss r=
ates.
> >          Unit: cpu_core]
> >    cache-references
> >         [Cache accesses. Usually this indicates Last Level Cache access=
es but
> >          this may vary depending on your CPU. This may include prefetch=
es and
> >          coherency messages; again this depends on the design of your C=
PU.
> >          Unit: cpu_core]
> >    cpu-cycles
> >         [Total cycles. Be wary of what happens during CPU frequency sca=
ling
> >          [This event is an alias of cycles]. Unit: cpu_core]
> >    cycles
> >         [Total cycles. Be wary of what happens during CPU frequency sca=
ling
> >          [This event is an alias of cpu-cycles]. Unit: cpu_core]
> >    instructions
> >         [Retired instructions. Be careful,these can be affected by vari=
ous
> >          issues,most notably hardware interrupt counts. Unit: cpu_core]
> >    ref-cycles
> >         [Total cycles; not affected by CPU frequency scaling. Unit: cpu=
_core]
> > $ perf list hwcache
> >
> > legacy cache:
> >    branch-load-misses
> >         [Branch prediction unit read misses. Unit: cpu_atom]
> >    branch-loads
> >         [Branch prediction unit read accesses. Unit: cpu_atom]
> >    dtlb-load-misses
> >         [Data TLB read misses. Unit: cpu_atom]
> >    dtlb-loads
> >         [Data TLB read accesses. Unit: cpu_atom]
> >    dtlb-store-misses
> >         [Data TLB write misses. Unit: cpu_atom]
> >    dtlb-stores
> >         [Data TLB write accesses. Unit: cpu_atom]
> >    itlb-load-misses
> >         [Instruction TLB read misses. Unit: cpu_atom]
> >    l1-dcache-loads
> >         [Level 1 data cache read accesses. Unit: cpu_atom]
> >    l1-dcache-stores
> >         [Level 1 data cache write accesses. Unit: cpu_atom]
> >    l1-icache-load-misses
> >         [Level 1 instruction cache read misses. Unit: cpu_atom]
> >    l1-icache-loads
> >         [Level 1 instruction cache read accesses. Unit: cpu_atom]
> >    llc-load-misses
> >         [Last level cache read misses. Unit: cpu_atom]
> >    llc-loads
> >         [Last level cache read accesses. Unit: cpu_atom]
> >    llc-store-misses
> >         [Last level cache write misses. Unit: cpu_atom]
> >    llc-stores
> >         [Last level cache write accesses. Unit: cpu_atom]
> >    branch-load-misses
> >         [Branch prediction unit read misses. Unit: cpu_core]
> >    branch-loads
> >         [Branch prediction unit read accesses. Unit: cpu_core]
> >    dtlb-load-misses
> >         [Data TLB read misses. Unit: cpu_core]
> >    dtlb-loads
> >         [Data TLB read accesses. Unit: cpu_core]
> >    dtlb-store-misses
> >         [Data TLB write misses. Unit: cpu_core]
> >    dtlb-stores
> >         [Data TLB write accesses. Unit: cpu_core]
> >    itlb-load-misses
> >         [Instruction TLB read misses. Unit: cpu_core]
> >    l1-dcache-load-misses
> >         [Level 1 data cache read misses. Unit: cpu_core]
> >    l1-dcache-loads
> >         [Level 1 data cache read accesses. Unit: cpu_core]
> >    l1-dcache-stores
> >         [Level 1 data cache write accesses. Unit: cpu_core]
> >    l1-icache-load-misses
> >         [Level 1 instruction cache read misses. Unit: cpu_core]
> >    llc-load-misses
> >         [Last level cache read misses. Unit: cpu_core]
> >    llc-loads
> >         [Last level cache read accesses. Unit: cpu_core]
> >    llc-store-misses
> >         [Last level cache write misses. Unit: cpu_core]
> >    llc-stores
> >         [Last level cache write accesses. Unit: cpu_core]
> >    node-load-misses
> >         [Local memory read misses. Unit: cpu_core]
> >    node-loads
> >         [Local memory read accesses. Unit: cpu_core]
> > ```
> >
> > v6. Fix x86 hybrid mismatched number of evsels for the case a PMU is
> >      specified. Add patches to make failures in the parse-events test
> >      easier to diagnose. Reorder the perf stat default events patch to
> >      come earlier.
> >
> > v5. Add patch for retrying default events, fixing regression when
> >      non-root and paranoid. Make cycles to cpu-cycles test event change
> >      (to avoid non-core ARM events) the default on all architectures
> >      (suggested by Namhyung). Switch all non-test cases to specifying a
> >      PMU. Improvements to the parse-events test including core PMU
> >      parsing support for architectures without a "cpu" PMU.
> >      https://lore.kernel.org/lkml/20250923041844.400164-1-irogers@googl=
e.com/
> >
> > v4: Fixes for matching hard coded metrics in stat-shadow. Make the
> >      default "cycles" event string on ARM "cpu-cycles" which is the
> >      same legacy event but avoids name collisions on ARM PMUs. To
> >      support this, use evlist__new_default for the no command line
> >      event case in `perf record` and `perf top`. Make
> >      evlist__new_default only scan core PMUs.
> >      https://lore.kernel.org/lkml/20250914181121.1952748-1-irogers@goog=
le.com/#t
> >
> > v3: Deprecate the legacy cache events that aren't shown in the
> >      previous perf list to avoid the perf list output being too verbose=
.
> >      https://lore.kernel.org/lkml/20250828205930.4007284-1-irogers@goog=
le.com/
> >
>
> Hi Ian,
>
> Did you drop the change to ignore failures to open events in favour of
> switching the default from "cycles" to "cpu-cycles" instead? I'm trying
> to follow the changelog but couldn't see it.

Hi James,

your example is using `perf stat` whilst the behavior to ignore
failing to open events is for `perf record` and added in:
https://lore.kernel.org/lkml/20250923223312.238185-6-irogers@google.com/
Changing the behavior for `perf stat` hasn't been in scope for making
the behavior of legacy events consistent in any patch series. The
whole '<not counted>' vs '<not supported>' vs an early exit is
something where not changing behavior has been the name of the game
for many years due to potential reliance on the behavior.

Fwiw, this series migrates legacy events to json we should be able to
do the same with the legacy hard coded metrics in `perf stat` once it
lands. Removing the hard coded metrics will give better metrics as we
can use event groups, share events between metrics, .. and only
display requested metrics when metrics are requested. My point is that
there is further `perf stat` clean up that this work moves us toward
but at 28 patches already I'd like not to start work on making perf
stat a better place. Getting consensus on what that better place is
given the existing fragmentic behavior will be a challenge, but at
least these days we have some form of tests, albeit they tend to flake
all the time. To solve your problems below where you're specifically
picking an event that can wildcard, give the PMU or use cpu-cycles, or
one of the many other names ARM already has to mean this. Overloading
the event 'cycles' wasn't something introduced in this series and the
fact changing the name hasn't happened in the drivers is really very
frustrating.

Thanks,
Ian


> In v3 I got <not supported> for the uncore cycles event, but in v6 I get
> a complete failure:
>
>   -> sudo perf-v3 stat -e cycles -- true
>
>   Performance counter stats for 'true':
>
>             1732478      cycles
>
>     <not supported>      arm_cmn_0/cycles/
>
>
>   -> sudo perf-v6 stat -e cycles -- true
>   Error:
>   Invalid event (cycles) in per-thread mode, enable system wide with '-
>   a'.
>
> The verbose output shows that it tries both, but doesn't ignore the
> error on arm_cmn_0 anymore:
>
> -> sudo perf-v6 stat -e cycles -vvv -- true
> Control descriptor is not initialized
> Opening: cycles
> ------------------------------------------------------------
> perf_event_attr:
>    type                             0 (PERF_TYPE_HARDWARE)
>    size                             136
>    config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>    sample_type                      IDENTIFIER
>    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>    disabled                         1
>    inherit                          1
>    enable_on_exec                   1
> ------------------------------------------------------------
> sys_perf_event_open: pid 9646  cpu -1  group_fd -1  flags 0x8 =3D 3
> Opening: cycles
> ------------------------------------------------------------
> perf_event_attr:
>    type                             11 (arm_cmn_0)
>    size                             136
> Required parameter 'wp_dev_sel' not specified
> Required parameter 'wp_dev_sel' not specified
>    config                           0x3 (cycles)
>    sample_type                      IDENTIFIER
>    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>    disabled                         1
>    inherit                          1
>    enable_on_exec                   1
> ------------------------------------------------------------
> sys_perf_event_open: pid 9646  cpu 0  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -22
> switching off exclude_guest for PMU arm_cmn_0
> Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit,
> falling back to no-inherit.
> Warning:
> cycles event is not supported by the kernel.
> Error:
> Invalid event (cycles) in per-thread mode, enable system wide with '-a'.
>
>
> > v2: Additional details to the cover letter. Credit to Vince Weaver
> >      added to the commit message for the event details. Additional
> >      patches to clean up perf_pmu new_alias by removing an unused term
> >      scanner argument and avoid stdio usage.
> >      https://lore.kernel.org/lkml/20250828163225.3839073-1-irogers@goog=
le.com/
> >
> > v1: https://lore.kernel.org/lkml/20250828064231.1762997-1-irogers@googl=
e.com/
> >
> > Ian Rogers (28):
> >    perf stat: Allow retry for default events
> >    perf parse-events: Fix legacy cache events if event is duplicated in=
 a
> >      PMU
> >    perf perf_api_probe: Avoid scanning all PMUs, try software PMU first
> >    perf stat: Avoid wildcarding PMUs for default events
> >    perf record: Skip don't fail for events that don't open
> >    perf jevents: Support copying the source json files to OUTPUT
> >    perf pmu: Don't eagerly parse event terms
> >    perf parse-events: Remove unused FILE input argument to scanner
> >    perf pmu: Use fd rather than FILE from new_alias
> >    perf pmu: Factor term parsing into a perf_event_attr into a helper
> >    perf parse-events: Add terms for legacy hardware and cache config
> >      values
> >    perf jevents: Add legacy json terms and default_core event table
> >      helper
> >    perf pmu: Add and use legacy_terms in alias information
> >    perf jevents: Add legacy-hardware and legacy-cache json
> >    perf print-events: Remove print_hwcache_events
> >    perf print-events: Remove print_symbol_events
> >    perf parse-events: Remove hard coded legacy hardware and cache parsi=
ng
> >    perf record: Use evlist__new_default when no events specified
> >    perf top: Use evlist__new_default when no events specified
> >    perf evlist: Avoid scanning all PMUs for evlist__new_default
> >    perf evsel: Improvements to __evsel__match
> >    perf test parse-events: Use evsel__match for legacy events
> >    perf test parse-events: Without a PMU use cpu-cycles rather than
> >      cycles
> >    perf test parse-events: Remove cpu PMU requirement
> >    perf test: Switch cycles event to cpu-cycles
> >    perf test: Clean up test_..config helpers
> >    perf test parse-events: Add evlist test helper
> >    perf test parse-events: Add evsel test helper
> >
> >   tools/perf/Makefile.perf                      |   21 +-
> >   tools/perf/arch/x86/util/intel-pt.c           |    2 +-
> >   tools/perf/builtin-list.c                     |   34 +-
> >   tools/perf/builtin-record.c                   |   97 +-
> >   tools/perf/builtin-stat.c                     |  171 +-
> >   tools/perf/builtin-top.c                      |    8 +-
> >   tools/perf/pmu-events/Build                   |   24 +-
> >   .../arch/common/common/legacy-hardware.json   |   72 +
> >   tools/perf/pmu-events/empty-pmu-events.c      | 2771 ++++++++++++++++=
-
> >   tools/perf/pmu-events/jevents.py              |   32 +
> >   tools/perf/pmu-events/make_legacy_cache.py    |  129 +
> >   tools/perf/pmu-events/pmu-events.h            |    1 +
> >   tools/perf/tests/code-reading.c               |    2 +-
> >   tools/perf/tests/keep-tracking.c              |    2 +-
> >   tools/perf/tests/parse-events.c               | 2010 ++++++------
> >   tools/perf/tests/perf-time-to-tsc.c           |    4 +-
> >   tools/perf/tests/pmu-events.c                 |   24 +-
> >   tools/perf/tests/pmu.c                        |    3 +-
> >   tools/perf/tests/switch-tracking.c            |    2 +-
> >   tools/perf/util/evlist.c                      |   18 +-
> >   tools/perf/util/evsel.c                       |   21 +-
> >   tools/perf/util/parse-events.c                |  282 +-
> >   tools/perf/util/parse-events.h                |   22 +-
> >   tools/perf/util/parse-events.l                |   54 +-
> >   tools/perf/util/parse-events.y                |  114 +-
> >   tools/perf/util/perf_api_probe.c              |   27 +-
> >   tools/perf/util/pmu.c                         |  309 +-
> >   tools/perf/util/print-events.c                |  112 -
> >   tools/perf/util/print-events.h                |    4 -
> >   29 files changed, 4523 insertions(+), 1849 deletions(-)
> >   create mode 100644 tools/perf/pmu-events/arch/common/common/legacy-ha=
rdware.json
> >   create mode 100755 tools/perf/pmu-events/make_legacy_cache.py
> >
>
