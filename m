Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B846F3BA24B
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Apr 2026 11:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775734251; cv=pass; b=Fti5evdm6SMJV5T4+8KRhc1fwLKIS3OI3dSueFgD5BDKOnruoFJiMqjbL3pOXX71HxZKLZ9FiqjYHoB1TRkFMD0MlR4c4tpeAUFEP5X5GWK99kF9z7Pd3iDi9W0hg1rqd3B6zl8V7oxwIzpm39BFR3kLeb+F7Jen0YVMOuRIlgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775734251; c=relaxed/simple;
	bh=G/7I3x0QjIqDpJ1DUaO/7ft5e7RW7ciCg+Tgmgila2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Etff8M8DhPDskGYg9PD78G3aaqy8Hj8be1WjN80jB0HPYyoSIuoq5kVu7EYuRxi63Q66cJjT1XBH7aEwIej6w2T5ba8Br5PCEQAJleT25Nz3gMCE8n2r9r8lvMzULg6rAWYeompHRyHcKoZTQdq4G60JNf/Ylh1wRk4CkqcbXZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N669kqF3; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N669kqF3"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-66e8cc714fbso1329303a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Apr 2026 04:30:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775734248; cv=none;
        d=google.com; s=arc-20240605;
        b=b3AGoMiR/R5DyH8j5t7UC0iUOd4vCbaLX0jX5Ulo8Iz/u6ixKkEQx+9DdhggdPkDTS
         qcCTFb6zr2n3raGsJI8IEkMnKA46gHRhrtzjLxVXsfXnUXniTNQFtyYAQ95eNp4ObXPL
         3BFod6/2h3zLPbInubhC/6d3iPNYijPhz/whGBb8FlS+eEN3gB0G/n7lpZe9Rwdnz560
         kJeHU8M7P/lRJrVOLu6B9U+A9R8yqNest7cwYJuZ+bucvTqnzKUwmCtNLYUVh79A2ksg
         c01UscAlNmye5DbdcCHxq8Htp3vuRuQ6iGh+m45Vmnq2vzlThfs7LPKr1axxzxXKLq75
         x9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=328He/coesElBgD5e1QY9m5NS4vj8QLQC1DiWdQM608=;
        fh=HsERfgxNpD2PdYP1VATRSaVPvtQtwQ0bD8mR9n+AGIA=;
        b=CD4XIGlTL8+H8ZJH4wzhxyUjwM44UGln2IDWJH9I4XkvnC/8TsyDWGQ89TogQC2ueu
         j9PyGEFTHgtWjYvSS+b0nAPgRYayonE61W8G2IZbfx/Qx/f+EaBa+oGlKBuH5i2dni7r
         etedDMQl6TVlpYt3x2dDWF6CVPsc8HRXXDoFXRr+FBI4vgS2TvJhxX/aliRxl52nZt7h
         WMKqc6BUy5JEoXXqz+rWIjzCo//z1/UIDcv6ip43imUFGhud2DpgGjnTpvWqExHuCAC5
         vWUT10gYfAJprDkdp++E8HfSSBi0bSHXSrV9WK78KI9vYsD35sJv+hI4t/QWivgcZKNJ
         Da2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775734248; x=1776339048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=328He/coesElBgD5e1QY9m5NS4vj8QLQC1DiWdQM608=;
        b=N669kqF3cGysKCN/r1YChJiD6tDI0qbALNGklsU/hzk0FXAxrhp2vL7ypd9z7apFCZ
         3FfrXOtBmeUerVasXzFBDGRRHY3/lwEMz6bK7u7fJyyXwPepYs9BIzMf4yqDXEdvLm2a
         fEgDjDAcIeuLH3patrxBsDeEHCFA9s5i3TucR3h5MQoHQUCiaoWUcuCzaIaFZLMERe1+
         5njsd7Z9KhmIr+Xr8e39wpnOXvzAzYlcKrPPhwcMgUkhFU5l/rRdacIxP5Z+vuAcdrWU
         bUbrUGTMMTtPAx3lSCflrApux3wS3HTnD531mIuUbkBllNO9EPOlWT2ECpFWFjmcGD3j
         WNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775734248; x=1776339048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=328He/coesElBgD5e1QY9m5NS4vj8QLQC1DiWdQM608=;
        b=L/CbSR9q1ku7vl6fCRB9tbnW+26LY/5IsM5sKKwwnN73AVa70ruigHZZL9j/ivZerS
         JvSJ/78144uw529RL1UsO4osnB4b60h6bhk1RgbPV3XwBd+h3rmMp43I9g1kMXh6x5Gw
         juqvy68jcefWJeftUFDUd3TrR58wWdua/IkjWwdil8ku4jxIyzyFu8h6wosXEM2qxJDd
         C7PgUxQjYUtksVnTKXMCIoGy4pF4FmEfkhUE8dVoGItsKKDJVr4ic03Nbs+Ny8tLo7xb
         nxcq4n4VqgAwjpcSB6pRC4iY5v3ZmzuhaNP6FpK8+PUkbewsf+rTf2wHuYXCabY2yZyG
         e7Og==
X-Forwarded-Encrypted: i=1; AJvYcCXYgh51xYddlmgxWwHX919PE2tQkkLcYZEZdHhMSfHXY6nd52YFC2bOfGo84MbQmyYtvcs/4HW7pahbY6RsIaJy@vger.kernel.org
X-Gm-Message-State: AOJu0YzhG25cpsOvfl9rpAjwrS3oWu9Sp/N19XiXtkI6sghAZyKjNFNO
	kvYoW4PaD6oa1i9tWVQbZmQ2VryBqdW51UBOxcmqRRqCT+d1BXMw8wsCTUIG1njiU6Uzvooz2qH
	XM1aD/rTIvDiGxOuMioL+7Igpb8/GDgI=
X-Gm-Gg: AeBDietcRFAigE3wx3mPFIZ2Iv/0tj5avCbgo8cmZf2XDQ5RHcHrcnsuRKgaGx9jqA6
	ftJBhQyHQ1eWL8aTTVMulloosOerkYzXHzkwxdy4dc42fsObZc4aIWXn5o4tFcSe8+3mFQFwkUI
	6foRzvvidOvtT/hxqJBec1pTVcC6QGOU9L1pcKcTFxam2ahtHjsdUjc0IYPju9M3XhqS4ItgdT/
	DEfmKUwWnzkeqWDUX12xaw9ReD1xm+qggq4tnzbJbrE1juIcHDGKggB2x2u4LuuJkjQPl2tWqON
	xA928r3mO/fclYyym4RENnioxHs3mPlREA==
X-Received: by 2002:a05:6402:35d4:b0:670:13a3:646a with SMTP id
 4fb4d7f45d1cf-67013a365f5mr1353530a12.15.1775734247839; Thu, 09 Apr 2026
 04:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318171706.2840512-1-puranjay@kernel.org> <20260318171706.2840512-2-puranjay@kernel.org>
 <20260409112453.GR356832@e132581.arm.com>
In-Reply-To: <20260409112453.GR356832@e132581.arm.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 9 Apr 2026 12:30:35 +0100
X-Gm-Features: AQROBzACqmc9E5pVvwSPdWHo6z5Px611puIK_CexByaqynTStVAf-jkD8nOFqkU
Message-ID: <CANk7y0j972j3rk25PVprcTB4E8HOysoJOJNRV25iDK03995AOg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] perf/arm_pmuv3: Fix NULL pointer dereference in armv8pmu_sched_task()
To: Leo Yan <leo.yan@arm.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Rob Herring <robh@kernel.org>, 
	Breno Leitao <leitao@debian.org>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, kernel-team@meta.com, 
	James Clark <James.Clark@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 12:24=E2=80=AFPM Leo Yan <leo.yan@arm.com> wrote:
>
> Hi Puranjay,
>
> On Wed, Mar 18, 2026 at 10:16:55AM -0700, Puranjay Mohan wrote:
> > This is easily triggered with:
> >
> >   perf record -b -e cycles -a -- ls
> >
> > which crashes on the first context switch with:
> >
> >   Unable to handle kernel NULL pointer dereference at virtual address 0=
0[.]
> >   PC is at armv8pmu_sched_task+0x14/0x50
> >   LR is at perf_pmu_sched_task+0xac/0x108
> >   Call trace:
> >     armv8pmu_sched_task+0x14/0x50 (P)
> >     perf_pmu_sched_task+0xac/0x108
> >     __perf_event_task_sched_out+0x6c/0xe0
> >     prepare_task_switch+0x120/0x268
> >     __schedule+0x1e8/0x828
> >     ...
> >
> > perf_pmu_sched_task() invokes the PMU sched callback with cpc->task_epc=
,
> > which is NULL when no per-task events exist for this PMU. With CPU-wide
> > branch-stack events, armv8pmu_sched_task() is still registered and
> > dereferences pmu_ctx->pmu unconditionally, causing the crash.
>
> Would not this is a bug in perf core layer that it should properly
> pass &cpc->epc for CPU wide trace?
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 89b40e439717..a8cd0a26effa 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3906,7 +3906,8 @@ static void __perf_pmu_sched_task(struct perf_cpu_p=
mu_context *cpc,
>         perf_ctx_lock(cpuctx, cpuctx->task_ctx);
>         perf_pmu_disable(pmu);
>
> -       pmu->sched_task(cpc->task_epc, task, sched_in);
> +       pmu->sched_task(cpc->task_epc ? cpc->task_epc : &cpc->epc,
> +                       task, sched_in);
>
>         perf_pmu_enable(pmu);
>         perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
>
>
> I checked other archs, most of them don't use the parameter *pmu_ctx
> so the issue never hits.
>
> My understanding is that for CPU-wide (or system-wide) tracing, we still
> need to invalidate the branch record on a task switch so that a branch
> stack is recorded within the same context.

Thanks for your review, and I agree with your reasoning, I will change
the patch to use your diff.

Puranjay
