Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EF4374E5D
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773328625; cv=pass; b=MahuNGoeFq9vrb8boevESCktpdXd3UUAkYe/T4IicqsW0gR5Z97OqZEEthvBPcD06eeuUNDs1sJrVsR50WWGkKb3/Cq7L529M4Z3h/h+12l+RI75FbrvBwWc5KS+dO5M9DCLMEGI3JJJBrInyHIxtRiOWlWCpBHg7AoeplDvBK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773328625; c=relaxed/simple;
	bh=QrFKcPwnyEwqzleEsR1Z0gp9z5JyvBhZTzw8OGPfcz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=piWUe+YAVUbpTd0W7N9c3hnbtj0xm96rR/JSBFvyKb9mnC2KMIzfqUupQzhhdP35zlj3lnJ05N5ZBmyAM2HO/mHAfPeXtsQiDfVkZgVI1O6E1zY9RPAVeFOM6AsbYI7RekOwFsTprbigUQCJEBneR1HzlN3k8IRtGvIrugoT07s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iVkvOes2; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iVkvOes2"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ae3f822163so102655ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 08:17:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773328622; cv=none;
        d=google.com; s=arc-20240605;
        b=GoxvV2HW3h+Nfb1drjIMs6DtBANaJnKln8UIHSoLGCc233bYIKk3t7V6tGLORzPPDI
         vJ9h3EeLgN2v/ZBg+5n3fy1DNIQhtRc4I2+WAgARkofEJ4KkVCzDgiiCrz0vhTZMM8t8
         QbZQu/goZ9Z84zUy2jbN8O6CPw34zwA6dTB4y63Hb/P72GK6AMt8e/5jegpbTTiIB+lY
         683PAC6JuFInjvzWLcrzOJmVk565woJ5ptw5ozYXgfdqSvx/L3n/TX8w2Bv7PKen01mX
         QGl+CShE/Q44rNrJmJ+7eK/efifBGzkdDJT1Xq9VaYTFAWrCUDsY44c2e8iZDUaR8G0C
         op7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Oh8PRWTWtMdEVxzq0YheWN7NaGFDtw5bIAmE/DTrEdI=;
        fh=AZ99vVmS8x4GJGch8LSaLaAom1KFz94rvHrYcil7LLU=;
        b=ACB777U/bm8O0vN0JKBpNZuuxOlMU2qSlF+TQro/ZEGDadZO8pDtvf7FdP/ujU3qTd
         ePkQDbRygK0fJV3rDdZwHDCmcmywI3JbwQzOi+eueiU6aKJM9F8W/TmaG9Uof9uSu5pr
         3l+zberDeJZ0cE+euQGoF0VmLfyBknLfNhmQJm61gT9upttGEhjGKu2uDu7Hf/Re8atF
         VKT1sNhkEssEras7NADF0/OymTgF9IaUfc9QblgZDxygDwaSPlZnJwufvqKIaRoSY2ik
         8MaP0QHGEmR0GsgCM7EUPJ1ssR1++oyIshvmaIVco9lUVRgsmdFDuuXI4Ic5y6nu7TIN
         7bHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773328622; x=1773933422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oh8PRWTWtMdEVxzq0YheWN7NaGFDtw5bIAmE/DTrEdI=;
        b=iVkvOes2QcQ/rlX4Qaad1UoN/KXeHeUQauIKt1W9F3rwbfmjgliNxo7wLDK2znJSUE
         E9Zq895s7aO03ysrnrXMDfCHqVX9dromfeAWxkCHWRo4hiNPVYOkSpjGfrxEOI0Ab9Oq
         FvUhzUgA0I/PP6InNrYWTaxXCG+f5Z4BkrxPmQq7Fp8poQcy6sI5yKIsf1fwUEyGcJGZ
         Yqvo5PefrQL5XYKWeBVHua9PtFWJ1zGOsILgyMEVzzXR1WfLVpnF62FdObDmuvFW5Bx6
         yahgHM0At1mWlJMFXmZmjE0soGMWvkoSyOKb5hhVZBEqSSK7qtC5PTnUiBELsq1oq2kb
         nhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773328622; x=1773933422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oh8PRWTWtMdEVxzq0YheWN7NaGFDtw5bIAmE/DTrEdI=;
        b=YLfWq5S9muFuxGG7ryJq6VXdr7HOMslhlNeORuiHmpUUIxZtuZHuvB6UJbGExOWV5V
         QeLOZls1FFb+n36xa3PjdaL8nlUFEC0tqh9tTwoEmnjx0LhUSm7b5OgSEmZvjgJ//sY1
         H2XVXjhKraIMoWNHi2G+uF3E95+7al22Ue2jcJ1bpTaT/1iGQFmE0FTFRCAhIytLQtmn
         RAwageKtZ8RvCRyVCMhWI756bT8X66vwJJw6YngH5a5bc2+wG7PlgJv1jRcLn76GF0k3
         8xd9QBBcMwnFvj3ZTtP8Veu77/7ipOz/yIjNYgwnQ/sOThJSVgFT290jZ/EQuDmbHBYf
         wBjg==
X-Forwarded-Encrypted: i=1; AJvYcCWCgo3I/t/lcXoOJS2K+EuilL0CzpByRSXre2QoVNBOhK4B4Cka3MFumjPjpmW0gWHw86xeo2Zx+jT5FgcXmrKc@vger.kernel.org
X-Gm-Message-State: AOJu0Yw84gOS/bDl9NLuu7GgKEve0VT5wISc+BvtVAeTbPilLwFmuFeO
	bjfMQQ6SqUaE1coE1FbB3u2stEPrGL+jcpD0hxEVgluB3JV7+vyCScvkmT6WpOJRgR6IR0x0dTj
	lxkAi3JraAGl7nwf4xWJHb0FboKMoyjwPqiQ6fV8g
X-Gm-Gg: ATEYQzz9ehSKAPuuaRU4y18Yc6PTAla9m44ohG/UFhbH4xGkE5wN3pg1deGhdkvWhZc
	ZlBTIAF72hmdb8IAt5taihsjQXUVdAscyhjISeQqoGXsv8pvHTbLW63a/OGJvnft5JfLWFnqqoF
	/D5LeoFElhROp35537cEGJ53FJcb2tJEodpb2uU3iEfIVVm3hhxrDRYcyGFe016qyLeD6ptrZow
	+WkKqRpntviawI1hwX+f/JdcMGHHtwCJQqiX9qu5q8tMNr1DWrx/nTGiEB9bARYytdKEWr0cnBG
	WZ/NW6+czsabAH7RIzygu1FodaGfTkqQYqPZ
X-Received: by 2002:a17:903:3d0b:b0:2ae:4808:bd99 with SMTP id
 d9443c01a7336-2aebad83d36mr3150505ad.2.1773328621594; Thu, 12 Mar 2026
 08:17:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fUBy-vzdSB3xsuyU+AKd8o99R7DLgoyyJHxb6Shkfb-8w@mail.gmail.com>
 <20260312054810.1571020-1-irogers@google.com> <20260312083159.GD606826@noisy.programming.kicks-ass.net>
 <1627ec0d-50d3-4caa-a75a-a952a29cc664@linux.intel.com>
In-Reply-To: <1627ec0d-50d3-4caa-a75a-a952a29cc664@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 12 Mar 2026 08:16:50 -0700
X-Gm-Features: AaiRm53Ns1nzeQ1WCjmASMJfVy8j20zvTG7Mkio10dpOpOUrrekOMhD26YWYk7M
Message-ID: <CAP-5=fV6ZDY-wvjfMHFPTpbXsR+3a0-HiBVr-Nxv+dsr7kXzhg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf/x86: Avoid inadvertent casts to x86_hybrid_pmu
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, dapeng1.mi@intel.com, acme@kernel.org, 
	adrian.hunter@intel.com, ak@linux.intel.com, 
	alexander.shishkin@linux.intel.com, eranian@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, namhyung@kernel.org, thomas.falcon@intel.com, 
	xudong.hao@intel.com, zide.chen@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 2:44=E2=80=AFAM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 3/12/2026 4:31 PM, Peter Zijlstra wrote:
> > On Wed, Mar 11, 2026 at 10:48:09PM -0700, Ian Rogers wrote:
> >> The patch:
> >> https://lore.kernel.org/lkml/20260311075201.2951073-2-dapeng1.mi@linux=
.intel.com/
> >> showed it was pretty easy to accidentally cast non-x86 PMUs to
> >> x86_hybrid_pmus. Add a BUG_ON for that case. Restructure is_x86_event
> >> and add an is_x86_pmu to facilitate this.
> >>
> >> @@ -779,6 +795,7 @@ struct x86_hybrid_pmu {
> >>
> >>  static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *=
pmu)
> >>  {
> >> +    BUG_ON(!is_x86_pmu(pmu));
> >>      return container_of(pmu, struct x86_hybrid_pmu, pmu);
> >>  }
> > Given that hybrid_pmu will have PERF_PMU_CAP_EXTENDED_HW_TYPE, and we
> > should really only use hyrid_pmu() on one of those, would not the
> > simpler patch be so?
> >
> >
> > diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.=
h
> > index fad87d3c8b2c..13ec623617a9 100644
> > --- a/arch/x86/events/perf_event.h
> > +++ b/arch/x86/events/perf_event.h
> > @@ -779,6 +779,7 @@ struct x86_hybrid_pmu {
> >
> >  static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *p=
mu)
> >  {
> > +     BUG_ON(!(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE));
>
> It looks we can't add either !is_x86_pmu(pmu) or !(pmu->capabilities &
> PERF_PMU_CAP_EXTENDED_HW_TYPE) here. hybrid_pmu() is called by the hybrid=
()
> marco or other variants, and hybrid() macro is called in many places of t=
he
> intel_pmu_init(), like the update_pmu_cap() , but the flag
> PERF_PMU_CAP_EXTENDED_HW_TYPE is still not set for the hybrid
> pmu->capabilities until intel_pmu_init() ends and the hybrid pmus are
> registered. Then it would cause the unexpected kernel crash.
>
> [    1.945128] kernel BUG at arch/x86/events/intel/../perf_event.h:798!
> [    1.946131] Oops: invalid opcode: 0000 [#1] SMP NOPTI
> [    1.947127] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted
> 7.0.0-rc3-perf-urgent-gc8b4b538960c #460 PREEMPT(full)
> [    1.947127] Hardware name: Intel Corporation Panther Lake Client
> Platform/PTL-UH LP5 T3 RVP1, BIOS PTLPFWI1.R00.3171.D00.2504220409 04/22/=
2025
> [    1.947127] RIP: 0010:intel_pmu_init+0x25c9/0x5fd0
> [    1.947127] Code: db 44 ff 4c 89 35 c7 da 44 ff 48 89 2d 80 da 44 ff e=
9
> 49 df ff ff 83 7a 68 04 0f 84 1b f9 ff ff f6 42 6d 01 0f 85 11 f9 ff ff
> <0f> 0b 31 d2 48 89 df
> [    1.947127] RSP: 0000:ffffd5dc800f7db8 EFLAGS: 00010246
> [    1.947127] RAX: 0000000000000001 RBX: 00000000000abfff RCX:
> 0000000000000000
> [    1.947127] RDX: ffff8f40856bc000 RSI: 0000000000000001 RDI:
> 00000000000000ff
> [    1.947127] RBP: 0000000000000001 R08: ffffffffffffffff R09:
> 0000000000000004
> [    1.947127] R10: ffffffffbd4e2500 R11: 0000000000000006 R12:
> ffffffffbc26438b
> [    1.947127] R13: 0000000000000000 R14: 0000000000000000 R15:
> 0000000000000000
> [    1.947127] FS:  0000000000000000(0000) GS:ffff8f482214f000(0000)
> knlGS:0000000000000000
> [    1.947127] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.947127] CR2: ffff8f47ff7ff000 CR3: 00000004c1434001 CR4:
> 0000000000f70ef0
> [    1.947127] PKRU: 55555554
> [    1.947127] Call Trace:
> [    1.947127]  <TASK>
> [    1.947127]  ? __pfx_init_hw_perf_events+0x10/0x10
> [    1.947127]  init_hw_perf_events+0x2af/0x4b0
> [    1.947127]  ? __pfx_init_hw_perf_events+0x10/0x10
> [    1.947127]  do_one_initcall+0x52/0x250
> [    1.947127]  ? _raw_spin_unlock+0x18/0x40
> [    1.947127]  ? __register_sysctl_table+0x143/0x1a0
> [    1.947127]  kernel_init_freeable+0x21d/0x340
> [    1.947127]  ? __pfx_kernel_init+0x10/0x10
> [    1.947127]  kernel_init+0x1a/0x1c0
> [    1.947127]  ret_from_fork+0xcb/0x1c0
> [    1.947127]  ? __pfx_kernel_init+0x10/0x10
> [    1.947127]  ret_from_fork_asm+0x1a/0x30
> [    1.947127]  </TASK>
> [    1.947127] Modules linked in:
> [    1.947127] ---[ end trace 0000000000000000 ]---
> [    1.948128] RIP: 0010:intel_pmu_init+0x25c9/0x5fd0
> [    1.949128] Code: db 44 ff 4c 89 35 c7 da 44 ff 48 89 2d 80 da 44 ff e=
9
> 49 df ff ff 83 7a 68 04 0f 84 1b f9 ff ff f6 42 6d 01 0f 85 11 f9 ff ff
> <0f> 0b 31 d2 48 89 df
> [    1.950129] RSP: 0000:ffffd5dc800f7db8 EFLAGS: 00010246
> [    1.951128] RAX: 0000000000000001 RBX: 00000000000abfff RCX:
> 0000000000000000
> [    1.952128] RDX: ffff8f40856bc000 RSI: 0000000000000001 RDI:
> 00000000000000ff
> [    1.953128] RBP: 0000000000000001 R08: ffffffffffffffff R09:
> 0000000000000004
> [    1.954129] R10: ffffffffbd4e2500 R11: 0000000000000006 R12:
> ffffffffbc26438b
> [    1.955128] R13: 0000000000000000 R14: 0000000000000000 R15:
> 0000000000000000
> [    1.956128] FS:  0000000000000000(0000) GS:ffff8f482214f000(0000)
> knlGS:0000000000000000
> [    1.957128] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.958128] CR2: ffff8f47ff7ff000 CR3: 00000004c1434001 CR4:
> 0000000000f70ef0
> [    1.959128] PKRU: 55555554
> [    1.960128] Kernel panic - not syncing: Attempted to kill init!
> exitcode=3D0x0000000b
>
> I'm not sure if we can move the flag PERF_PMU_CAP_EXTENDED_HW_TYPE settin=
g
> earlier and eventually find a good place to set the flag. Even it's
> possible, but could be risky ...
>
> Ian, if you don't object, I would suggest to drop the bug_on(). I would
> adopt other changes and add the is_x86_pmu() check in the
> x86_pmu_has_rdpmc_user_disable() to fix the issue.

No objections from me, these patches aim to improve the code's typing
and were intended more as a suggestion easily expressed in code than
by email :-)

I feel that the x86_pmu and x86_hybrid_pmu are something of a mess,
making features like counter partitioning harder than necessary if the
code were structured better - ie 1 partition per PMU, which means
multiple PMUs even without hybrid. It'd be nice if we could implement
something like the BUG_ON to at least ensure correctness in the
current code. I'll try to find other broken casts/container_ofs in the
code by visual inspection.

Thanks,
Ian

> Thanks.
>
> >       return container_of(pmu, struct x86_hybrid_pmu, pmu);
> >  }
> >
