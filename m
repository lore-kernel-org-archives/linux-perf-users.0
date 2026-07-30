Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24BB418A30
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Jul 2026 19:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785441382; cv=pass; b=JP8LMh2xil+Tv3qKFAPeDT/u29VXpiQ6iDple0fj20D62dkrxvC/FO1I17Fr7npnBO4cIYZQNkI9St5FhHUglaUOBa6N+xOiCaxpzFamBH43nAhvouQNDBLXIGc8+TQ2d7WfJ2rRTK2uLmicZA3U/Wn2489NWK1GbaZ+p+JS4mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785441382; c=relaxed/simple;
	bh=8h9uuvioLmMzyjoC2PDlkvIO7nOSrqldyopjlTG22tQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptycYzUrqcg8BZyZcUiSGRB0PvA88uLI1ef4RxSRVihTwNpHoaB6D4TDg/eiWyrMuuMhdMmPCnfwZu9JO2qrGFq8eR9mscsmE4RffZtUB0YPFb8wxdrGWnvtormcm2pnMlGoe8cHwEEVYs0t5nnpCmAwV18Tk8Wimtugw5WiVJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFAuRFFM; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFAuRFFM"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84847482584so62870b3a.0
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Jul 2026 12:56:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785441380; cv=none;
        d=google.com; s=arc-20260327;
        b=lUNs6z6pTOTFCyRqkqOd72YNsItG62XLg/iNZsI17o0fMdrV48cvbj4joN34Q82nd9
         tUeQ4fbzbwazIgCzANuoqm9JOxe1lxtthgbz/Ct9lboKqtI7zcfaNva8MBu3Tja0kN1N
         T97/7lEkeoyiGhlP+74X30r8YilAU9o1H8b0XIz7RtmzzCxBFwdXvbq+RfjjDLvSCUYq
         lEjpDESslqo6ul5Hb1vau/cufGO57ju6bjP67jrZOY8a/cNmtblM4/SRgzUhiXSYXzDG
         4K2Ps68kCMvynOc8nseFVpeomkcmXwTuGDfSLTvOTfNEHOMFrDJYT/S+grOAqjzt16bX
         ay0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A3+RQo/HppHWztT11zWZQCBoviyZeuu95fXLxqIvMec=;
        fh=dHTLiP2yqNpxCBMN/VEPbmfGpBC4DRX7M9bDlSc/wjM=;
        b=jLcB7d126ODEFVau5vTb9jprKPe1wfo9MkIXHP9od2mub6XJvaLeP6LdR51qmm1Mgw
         Sskef2TxP8QkqNfdxrS9QA9cV7lEbfqXfVn4lkKYflZxL+FEXCzVaTBtF/ewN/drJmDC
         3KXQSTY1YDhfLe4FLSsbD0g72hVKVgHlxsXuRKZ/2aChMSQg+RtDH0vKhaeRBO6nXhGG
         sbobZo+qt2MOpKyBteM3/EZfLgKxClz6IrRjBeRtd9r+IZG9nXjlIRnaOixGtDV53NEL
         AD6FfXBDSaT6gT9aIyuqOVEzKNMi94QHiyAm+OMX6fMLXlm2CLy5eJFpYYW0XpBpZ2no
         Y3Sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785441380; x=1786046180; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A3+RQo/HppHWztT11zWZQCBoviyZeuu95fXLxqIvMec=;
        b=kFAuRFFMcGTtFSWlDoDw0YcOhlQeFMimBQU3AS0Lton5OG62fk3rksWzL6pIUGaesX
         d8K50qteJAawQXSX7rbD0eDnRHawW+cgKH+OuHHNnQy0uI6SBeHKWrjZbs5QyURzdZpJ
         cxaE6bzzXL9nYzTvNTFPRu6+2iX/Q2LeHWT7lIJ0I5RmGp36B4wzH0/li7HnDCtb5Dc2
         xtNyDX1x509QApVd5YpFwXwr5vDHWardXnKvTFNtwG6tFd6p32VWe+ZMilk59GgNbsI8
         UZTLTINsFtpLDxKnXWOpqNrW3CS4hA1oQ603vgqY8U95eCVv/cI8hmag3NeZut43ECU0
         nYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785441380; x=1786046180;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A3+RQo/HppHWztT11zWZQCBoviyZeuu95fXLxqIvMec=;
        b=ALGLndcZB5uovrOkG9HrXLjM92oeAxyg+dwNzldNAKzuuC4NpbkvMb3Za6MXiLaufY
         oXdlxrtsM75W1S8iQlHI2ZCp7P/VOQchTr34OR6JQ1CIdW/qJGGag6+V6mVl0NzOjx/D
         fTYg/NX451mBWkI6yilPsrm3i8MO6O4BEWRHF9IPAMu+pgtX2+pUFbA3+eJtONkRqSua
         CmHiwkjT87aZVPYtcV3OqEmKpid4qoduD8Iah/yG+opPFsxEzmmC9zCQa3NM93G1KHmd
         Ta6/oNkhV8y+TtxJkwcJtm5Y0mrR5/Thnjks+cV73h9e6uJ24b6xuQIqCHB1c/xXO+Z/
         yemg==
X-Forwarded-Encrypted: i=1; AHgh+RqgqQDNJXu6Emg1L1TgUZfosJKl6H/LRBQ/98Rekwac66UAJSrtLXINU0sHUOJFsvJZf5cttuAzXGCpiEBsLaP2@vger.kernel.org
X-Gm-Message-State: AOJu0YzE1RxnS/OH4o5THjf/wkkXSM2VeSaT4lLkHIkLuAuZWsLgMbHC
	4e6enLq8KJ/q3MhRF8vmq1P9A/giJyJN6XRIJRvAb31NSIWl2tM1oTvXo3kUFl/2PygpgQlkxjC
	Ecswx2l6h0O9uLfVp5UK9ZHzBJBiw7+4=
X-Gm-Gg: AR+sD11B3zkPIZPk3tpr+nplc7eh4hfoYeBUBPHsoEgO8kGiJ0VYwH2OOMMaDXcjisx
	N2a6oRJmmkocRjLeQasqmlsRNFkbWU+rg+a4FcMk7CKKzQCE1sfLljwyf6d/3jBOrTiBIcJ5zWQ
	5JYfWil3pbPqxDJsxMJBRP7mkS77v2lXi3LEYhPjaaikDFOc2CgfymW/jv8Cno3jYg+gtKDmVmn
	fg/9gonKYofIJn88DjWbOL/+3LiPqG5Q60Uigjhi+c0r1tD94qQa3Q7/Brt83q57siyj6/iosd/
	KbJnPftilOs9yESzUMyl4oV3Bb0kxa6nYPeK7eWBtlvjwhc0/pPXMsjLR0a6x6SKSUzwXhOjMuF
	rW+kUcHjkJEIFx8Qas2yL3OkxtdFRZH6TzvWR7TqMtQ==
X-Received: by 2002:a05:6a00:b53:b0:845:df5c:2567 with SMTP id
 d2e1a72fcca58-84eca755270mr1251616b3a.25.1785441380230; Thu, 30 Jul 2026
 12:56:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616155716.2631508-1-puranjay@kernel.org> <20260616155716.2631508-2-puranjay@kernel.org>
In-Reply-To: <20260616155716.2631508-2-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 Jul 2026 12:56:03 -0700
X-Gm-Features: AUfX_myauPf-9BUS4q5KaEKx2Sh46ySRXTd0ms5asoEI3-_AoZYC3_ia32CZLHo
Message-ID: <CAEf4BzakTaTr16F4xRF4wti46Gfq7Csky=drai=aE_aUSOFbTQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] perf/core: Fix sched_task callbacks for CPU-wide
 branch stack events
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>, 
	Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Leo Yan <leo.yan@arm.com>, Rob Herring <robh@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	James Clark <james.clark@linaro.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Shuah Khan <shuah@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Stephane Eranian <eranian@google.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Usama Arif <usama.arif@linux.dev>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 8:57=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> perf_pmu_sched_task() returns early when cpuctx->task_ctx is non-NULL,
> deferring to perf_ctx_sched_task_cb() in the context sched_in/out
> paths. But perf_ctx_sched_task_cb() only walks the task context's
> pmu_ctx_list -- PMUs that have only CPU-wide events are not on that
> list and their sched_task callback is silently skipped.
>
> On ARM64 with CPU-wide branch recording:
>
>   perf record -b -e cycles -a -- ls
>
> armv8pmu_sched_task() is skipped whenever the scheduled task has an
> unrelated perf event (e.g. a software event), and branch records leak
> across task boundaries.
>
> A second problem exists in __perf_pmu_sched_task(): it passes
> cpc->task_epc directly to pmu->sched_task(), but task_epc is NULL for
> PMUs with only CPU-wide events. When perf_pmu_sched_task() does reach
> the loop (because cpuctx->task_ctx is NULL), this causes a NULL
> pointer dereference:
>
>   Unable to handle kernel NULL pointer dereference at virtual address 00[=
.]
>   PC is at armv8pmu_sched_task+0x14/0x50
>   Call trace:
>     armv8pmu_sched_task+0x14/0x50 (P)
>     perf_pmu_sched_task+0xac/0x108
>     __perf_event_task_sched_out+0x6c/0xe0
>
> Fix both:
>
>  - Remove the blanket early return in perf_pmu_sched_task() when
>    cpuctx->task_ctx is set. Instead, skip individual CPCs that have a
>    task_epc (those are handled by perf_ctx_sched_task_cb()). CPCs
>    without a task_epc are CPU-only and must be handled here.
>
>  - Fall back to &cpc->epc in __perf_pmu_sched_task() when task_epc is
>    NULL, so the callback always gets a valid pmu_ctx.
>
> Fixes: bd2756811766 ("perf: Rewrite core context handling")
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/events/core.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>

This looks like perf core bug fix, Peter/Ingo, would you like to take
this directly into your tip/perf/urgent tree?


> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 6d1f8bad7e1c..6604f6e8f352 100644
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
> @@ -3919,12 +3920,20 @@ static void perf_pmu_sched_task(struct task_struc=
t *prev,
>         struct perf_cpu_context *cpuctx =3D this_cpu_ptr(&perf_cpu_contex=
t);
>         struct perf_cpu_pmu_context *cpc;
>
> -       /* cpuctx->task_ctx will be handled in perf_event_context_sched_i=
n/out */
> -       if (prev =3D=3D next || cpuctx->task_ctx)
> +       if (prev =3D=3D next)
>                 return;
>
> -       list_for_each_entry(cpc, this_cpu_ptr(&sched_cb_list), sched_cb_e=
ntry)
> +       list_for_each_entry(cpc, this_cpu_ptr(&sched_cb_list), sched_cb_e=
ntry) {
> +               /*
> +                * PMUs with per-task events are handled by
> +                * perf_ctx_sched_task_cb() via perf_event_context_sched_=
in/out
> +                * when a task context is active.
> +                */
> +               if (cpuctx->task_ctx && cpc->task_epc)
> +                       continue;
> +
>                 __perf_pmu_sched_task(cpc, sched_in ? next : prev, sched_=
in);
> +       }
>  }
>
>  static void perf_event_switch(struct task_struct *task,
> --
> 2.53.0-Meta
>
