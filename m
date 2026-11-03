Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793733003;
	b=JctZvXuiSZ4ksE4FPAKUS3ZRL+I675CepmhT2mY6GKdga21cZW3L+4BGhO5aCrsesSiU
	 B6MRlI9hlJtAobWvvKFhh1UM2wga2kcfSTlVVvdW+M/CH+IdiJxuhjm3cxLOOTRmYwZhh
	 0T8cB7lM6iSMpRY+qOFhZVKAHNdNQoCaWxpEJxF8LSB8nfz1vZVTtt6Mu5u2/q1bDsJpY
	 GYg8CsMaKmzKJkyIXo918/f/VnpujeFM2oaBqbhqSpZVPkfbPaDQSHuLjz5SbGRoEAsTv
	 SYhAKrB7T50SJ1qfvhmbjNuTkxS39EwiI+b9M1vykNHA1FihIk7dy/pfUfdiEEpwbCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793733003;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=K+4cGjYBMwET5S3/yL1y9WI8cj6ga2fX+l6VhSdIjFo=;
	b=0vlD0hKCi/3TJ/48eLIpFxPaIhu7D/XPaBtMYZIF4b9gs95/od/JCxFiwY778MVJNLpU
	 rR6GOkrvaTwB0pEeIsJsrqupQrOM2gQRpWmECLhGuZG3o5LnvhOq3tgyuXizq6EG/bvfU
	 VuHGmQwhIkER/h8y5IRMag+ZGAXk65QVZVOhAmzfl2Hanu4AFLEMOBYJcQ9oO4RW/IOOj
	 O2uRAwnRNYsmu6pS0qlvoWoeKn2xhAR3PmZy6Hq+DyRyXQEWXLjLPJBW1bERYG9+V8Mnx
	 LuyIANAQWmgQHMsBKAP21KIPAJO12lwvZ34ND2UVfF/sBjbSOIWOJo35XhHab+43fJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WE1jRdNV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF48E606A324
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 19:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF48E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WE1jRdNV
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so3357074a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 11:10:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793733002; cv=none;
        d=google.com; s=arc-20260327;
        b=ZS/J6oft/1k+w8HuT6UBO18nVf6DhsJ4ZO8/Kz+TnrzZtMlo8921y+O/gRE8w/yMD9
         azlNRr9fDD9JlP9J8dnUiKLf/79hYK+bXqzA50/lsHRd3MXK1NtuFCEEqhYYRgma5Lkg
         vYi2jxBPHP98zdtYxtg8/WEDDbzw7XkTc2QRK9OBmqh+oZgx/+Ezf6u2JR6+82ckj/ru
         H7BNhd5+GVwQkvzez4wp+/RRIIhPR3L6H/VIYPWLJ6EUziJDziPXWJarudLdgkdXGD3S
         N1FPnLAdWrqYBzrAbUBMLvZ5CZ26DZFoWZ+HA9zQ7TzzLLAdFCE/GgBWZAVXLvkJF/1/
         yb9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K+4cGjYBMwET5S3/yL1y9WI8cj6ga2fX+l6VhSdIjFo=;
        fh=mB07ydxwL7aUSzRMgQPwSBaTrWNFCfhCSvyMgDJ3FuI=;
        b=PrGu/mlCxyX1yOzSPZc+oByC0rF2AiABIfJVzfMbwoNFgiqcuGfglMAAB7WaUu8kaF
         jCPmY+GrwrmC1gnPfvkC5iGxcrsLwtJZZukaW+Hw+GYdnWIUvBHHyOMmOvp2s/KqilyY
         oh0iv85PbLjO7+usT4lo08JQgr7Cqcdc6kwVVTy+gKqrOOvlugxmQni71VSOuVvAf6MA
         LyEi5F9gJAB/uYYJIlzVAuitLLqMTy5ISvrBVOe8kurcHJUPnPruaqc3RQoG9j/F8lZ6
         oKbQA7yrNL5eRyuZyooy6q0mWaZsjsfUmymQcn6udYhFyxkesMEQtA36ykdW3WmIOvf5
         RcNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793733002; x=1794337802; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K+4cGjYBMwET5S3/yL1y9WI8cj6ga2fX+l6VhSdIjFo=;
        b=WE1jRdNVSlJlkT+X3hyEmsqPJSVOTnfHup9E3BmA4yucOx2NMZJb49EeibHoThNAHM
         WR7TEkDiL+duBhQhyIATdRcovxX6tGCSlyrawtlbFc7BonTPUOrG0qPrU8sKAtkSnSHT
         XSne8WMJrTMz9G56eAOxCdTLtqAvmTq3XYQaxshD+rSWgpqQ6AgPzHIrOoYMY5btbxMr
         uYRtb6XECf7ioi1PoZMebV8ay7iluf1dMcb6E/sMazc7/lB6P7mQjQfVwsCDrJaSNnms
         rRdUQTZ9FGGt2B3WfW/IStJ6QxCAN2jNNqWOHirlr1+Y7bR52Nsv49B8PLGcC8Rc60Vh
         eGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793733002; x=1794337802;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K+4cGjYBMwET5S3/yL1y9WI8cj6ga2fX+l6VhSdIjFo=;
        b=kf9AhifL6IdZC1FVK+nM3zryYb7J1jUc3pH/oLylqvRvomHzIs7DJp7XagOfrCoqv7
         FxURTv44ZeUOdTKzEaOjNmhNgzHYd4vJywDeWrtFJQ/mk3CIrq2/d4TpSDTaUCP8z0Dx
         QejT+qdXfsGitcaMIwXzUAC9MZ6HvySCX+Giovg4Tj45679kdOdw3lRan0zcUc9qySdb
         Y9yfOaJFSNmWX37foeq6z47lxe0L81U8udwd+Bf3APwNZ78VYeZEnB4Wx8z1/3R6dB5o
         tS5m308E+ayaiElwmVO3S5KZRZzEYMk9P/PdWimYo+t74ljSnyxxhkRS/aMudK/ZeF6V
         XLZg==
X-Forwarded-Encrypted: i=1; AKwUvBwQHSlUutD7yiK8x4O8y27JU6v9wWjyJIAwAau76e4jNEDrg1Qdr4hc4HJJ4xqT4CMpeGYlgrpOjdAyuoty2KoR@vger.kernel.org
X-Gm-Message-State: APuU4Z8lelyrGPy2KjF+qzqElJc7kel0gIVxRHYrY+ezFee1efL2jyJe
	ffDfKEj9Vd5MEmZjBdoHQQJ/2RG5QBJcrlqUZNaQrqz1JMNTX1Iz5uy9etx/9HdkLvvVYeUyrTw
	3opxFkZClk2Bh9OD+wEgJRWtGRh8U0uw=
X-Gm-Gg: AYBFou257bjjJKoOJRYHO5OkWTpZLOIM/QjrhyRY5b/nBkRkTb1P7VW5nNNJOluM+AA
	IqOpfoWeUeue42BQ4rhhex2MggYQT+FfFfpXUL5Lv4ISrEyJGjD7oGJrJoYwVj+oGZ5fzki+oJK
	yflNzbobX56Mjsp/2lPrU/wOVwQPvmAZCgl8YA7g2P6UtdiunuayqgKgB/Z01zDsWj57Se2pbUh
	yOR7o2+wST6uIgeLN2of28A1jcX9uCuDLs5//68IwBY9Zco5WwOAVRxlwQ/YXaeQiGdub3umKLr
	phLcLzOD5dR8MV4wd9LnZRLvaPBjJO5DuuF1yv8plHQL1t7VzPmZUnJ/DVDMnoEZzvk+xP8t2Xu
	xhCT9HQvKy2zq4m6g4+k0YkzU/uz6CAcs+ioGXQuKbdKhXpJjR9eXR6SC4Y1wCwFEsJFV/Y2zpS
	lnw3dXTBPh8LBK+OieYXuoJ9CgRm0G1aRCHA==
X-Received: by 2002:a17:90b:1b12:b0:3ac:9e76:aa9e with SMTP id
 98e67ed59e1d1-3ae89573fa9mr12431023a91.3.1793733002279; Tue, 03 Nov 2026
 11:10:02 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023124157.75524-1-puranjay@kernel.org> <CAEf4Bzb2jEjqpZrmtTk_+YCW3_jU8fcVzk26CBZnxkpYJ8kCbQ@mail.gmail.com>
 <317a989b-c79a-41a3-8c0a-7e952bdae6d0@amd.com>
In-Reply-To: <317a989b-c79a-41a3-8c0a-7e952bdae6d0@amd.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Nov 2026 11:09:49 -0800
X-Gm-Features: AclHuK_PFt2J5xDqIZ8k--bqZaPNNyMF_lX84RrlZyhcj3U0kfhEDPOFvmuNTeU
Message-ID: <CAEf4BzY4FYFuT2iSU+fEApnKK4LjHe3i0Xpq_kd4rt4iDLK3XA@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/amd/lbr: Freeze LBR on PMI only when kernel
 branches are recorded
To: Sandipan Das <sandipan.das@amd.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 2:08=E2=80=AFAM Sandipan Das <sandipan.das@amd.com> =
wrote:
>
> On 30-10-2026 01:42, Andrii Nakryiko wrote:
> > On Fri, Oct 23, 2026 at 5:42=E2=80=AFAM Puranjay Mohan <puranjay@kernel=
.org> wrote:
> >>
> >> On CPUs with X86_FEATURE_AMD_LBR_PMC_FREEZE the LBR is always frozen o=
n
> >> PMI, so the branch stack ends before the IP and callchain, which are
> >> taken when the NMI is delivered. IBS rejects branch-stack events, so
> >> there is no precise alternative.
> >>
> >> The freeze only keeps the PMI handler's branches out of the stack, whi=
ch
> >> matters only when branches into the kernel are recorded; without it th=
e
> >> stack fills with the handler's own branches. A user-only filter does n=
ot
> >> record them, and parts without the feature are never frozen (see commi=
t
> >> 598c2fafc06f ("perf/x86/amd/lbr: Use freeze based on availability")).
> >>
> >> Freeze unless the value written to LBR_SELECT, which is shared by all
> >> events on the CPU, suppresses branches into the kernel.
> >>
> >> With perf record -e ex_ret_brn_tkn:u -j any,u on a Zen 5 part running
> >> CPython, the function of the sampled IP differs from the function of
> >> LBR[0].to in 84.3% of samples with the freeze and in 0.1% without it.
> >>
> >> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> >> ---
> >>  arch/x86/events/amd/lbr.c | 9 +++++++--
> >>  1 file changed, 7 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
> >> index a55646fcb8465..7ec50380ac81d 100644
> >> --- a/arch/x86/events/amd/lbr.c
> >> +++ b/arch/x86/events/amd/lbr.c
> >> @@ -392,7 +392,7 @@ void amd_pmu_lbr_sched_task(struct perf_event_pmu_=
context *pmu_ctx,
> >>  void amd_pmu_lbr_enable_all(void)
> >>  {
> >>         struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> >> -       u64 lbr_select, dbg_ctl, dbg_extn_cfg;
> >> +       u64 lbr_select =3D 0, dbg_ctl, dbg_extn_cfg;
> >>
> >>         if (!cpuc->lbr_users || !x86_pmu.lbr_nr)
> >>                 return;
> >> @@ -405,7 +405,12 @@ void amd_pmu_lbr_enable_all(void)
> >>
> >>         if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
> >>                 rdmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
> >> -               wrmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl | DEBUGCTLMSR_FRE=
EZE_LBRS_ON_PMI);
> >> +               /* Freeze unless the filter suppresses branches into t=
he kernel */
> >> +               if (lbr_select & LBR_KERNEL)
> >
> > On Intel CPU side, we reset this FREEZE bit in
> > __intel_pmu_lbr_enable() if is_lbr_call_stack_bit_set(), with the
> > comment "LBR callstack does not work well with FREEZE_LBRS_ON_PMI.".
> > So this is not *exactly* what Intel side of things is doing, and I'm
> > not sure I fully understand the differences, so hopefully someone more
> > knowledgeable can help.
> >
> > But what Puranjay is trying to do here is to at least make a
> > user-mode-only LBR and IP + callstack to be coherent (for PGO data
> > collection, which we then use for user space app compilation), by
> > disabling freezing for LBR.
> >
> > It doesn't seem like there is anything we can do on AMD hardware for
> > when we want kernel-side LBR and precise IP to be in sync,
> > unfortunately, but at least for user-space only case it would allow us
> > to not plain disable freezing altogether at kernel boot time.
> >
> > Does this approach make sense?
> >
>
> Yes, the intent to keep the LBR and IP coherent is clear. However, my
> concern is that this may end up dropping the branches preceding the
> hotspots since a CPU might keep executing in userspace until the PMI
> handler runs. I'm not sure about the effect that this is going to have
> on PGO but what if we rely on a mechanism (UAPI + tool flags) to let
> users explicitly request freeze?
>
> If there is an use-case where freeze helps, then the facility can be
> explicitly requested.

heh, it's actually the other way, freezing **hurts** consistency
here... should API requested freeze *opt-out*? because freezing, if
supported by CPU, currently, is the default behavior not requiring
opt-in. Or are you proposing to not enable freeze (even if
cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE) is true), and then
make user space request freezing with the new UAPI config flag?

I'm not against expanding UAPI, but it feels like a very quirky little
thing which also stems from AMD-only limitation of not supporting
precise IP capture with LBR enabled


BTW, the alternative that internal customers actually requested
initially instead of this was to completely disable freezing at start
up through the kernel command line. Which seems like the worst
outcome.

Thoughts? This all seems unfortunately messy, but hopefully we can
figure out some non-intrusive but workable solution.

>
> >
> >> +                       dbg_ctl &=3D ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
> >> +               else
> >> +                       dbg_ctl |=3D DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
> >> +               wrmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
> >>         }
> >>
> >>         rdmsrq(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
> >>
> >> base-commit: 0f443787a7f6ae907975742680aac2600483eaf1
> >> --
> >> 2.53.0-Meta
> >>
>
