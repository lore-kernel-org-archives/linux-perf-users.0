Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D9D3E3145
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Aug 2026 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786370699; cv=pass; b=NE68QKBXX3+wEho2KjMO0wIophHnZW6fPSDK/dHGGfXPqMpsF7vVw/D2LcLO3PbqVMbhIIAPbzQBZLg/Z92oYSBDLIHAdTa/Bn/0KxuYNVqM5P5bLxcevdnFKj1sZdTHZQynv5rhVi1CpFllEo21tg0qDY1E/xoBYVbI6wxzbiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786370699; c=relaxed/simple;
	bh=aQefb5KGUUtBew9fCgJ/HSm0at5w/RtJ4qdMArEgBms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dln2Q3BWyqGoJumDyHSKQD8mevUkz0egVfsA9X6tyY2TOVu1OH0r0lZb2Iy1IztCBD9ahQFspS5ezpLGvnkJuCjH2HoEu5r9xWFspetvLDGigv0ntEzTOc+qq7FCw7KCv+QZxEcgWzyfJzPQ/ok2FzvMl48ftcDVCkY5rb9dC8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0Rdg8OL; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0Rdg8OL"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a17f91so2994254a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Aug 2026 07:04:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786370696; cv=none;
        d=google.com; s=arc-20260327;
        b=q+xwj0AGKvTMoqFw+ltnyOaL9m77fed6S0omCPd2a5OXXTHKPzQ5mR9v8CCf98W03x
         1MQoV/StNxgJA5PKl6hkeJ7v9bsVWFx9kb8NsThMCuugEBaJt3OF2n3o1QLhBeXZhavb
         bHio7W2X0tRrl6nez5qBhWJ9XYobWqy0PqzKkozToQnMxleBspDvZCdR8m4wQ/29Oefo
         2vTCgdg8/ixz86P0j2XEuemrzuRI7g8tVSht1sFEGcwv9mwP4l/kal9zz7cs7tT5uytj
         VHKuBuF7AkiP0IGGjJuITY2smIaDug7H0fhUC9FfKsWhk+q0Ul9aBkvW+mGvd2dLD1g7
         MPzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rXErR0QDrrFQK5fNUe5J6pmYbKM/4pwmkmKBefRuoz0=;
        fh=LQLdSW01h2ROUwNK2N5+UwHQ+4lE93qNu55uGrsD190=;
        b=XEbQPnfp4UuU0IWQMWe6HHz2p2tYradIzXuwMehU3B2x/9HE4HdD0ZIYr75NMt1vXh
         z19VZNzEW9kfdzz34LeStTwhFQ7zhJVZRQpWe0Vd+0cYRR0fPnKKseUvIJvFZjKfvjgf
         9Go9Goj8PHLKlmzFo4lBxbxvk++7r4QqxfGTLomvI32ku2zEl50dcw64rmVFJclMttiH
         cqYxMUyOy9FTZlbWAZ93jdic54WveB0Qv7J8XIAFJcIu6PYsvNNGazkGa+BmJEF6Vtdc
         2bFFrfM5apwSNb0n7+/m0DOig9izgn6JNqzZTCTElAI5EGR2AMX7+WQBHXLhQYJSyV0a
         Qguw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786370696; x=1786975496; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rXErR0QDrrFQK5fNUe5J6pmYbKM/4pwmkmKBefRuoz0=;
        b=A0Rdg8OLXwK8/HbarErIwN2gyK2KHHOKhgForv3iXhXBzI8GTB4QrVml67u++NHgnN
         Wsc8x+ybChd4OFIu52k1kEZUBEjT8DyZIzQqxJxZgE9kgOqa8UQYd730rEpYjXz3tm9/
         1OjvD96j1Zf46xQV2llqBBbOiHc0SC9e04BmpUDXVcRc/xuAs5ieV7KF8KH7XXoi7MOz
         IydtcsnJki3ZaWiPgBGvxn4XYjJkbafAtjl+LfPRNm9IYD3eh7hF7bINeZDtb2dl/MEO
         TqATcuehk7ljYMkIERTX8WRzbQ3FW+ueWOKZ4GKB7Ay3DP0s7DqEMmBhvy3/9/lW1EeX
         h+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786370696; x=1786975496;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rXErR0QDrrFQK5fNUe5J6pmYbKM/4pwmkmKBefRuoz0=;
        b=NkOad7kx92RAOKmWWccpIs5fAAlgoiQAQ85IRQXdjOWzLCDXCsZ0Hq0RMtuQMXJ7Qk
         pW7L8WtyBCQhVmru2KzUbScjlSojZmreQIR6RbvOchN8ckCYFrrSpQTvgPjnWANjCawf
         XkF8QNWScFKip5ArLK2RHA1PksQIaS3h6BxZeF2LTVftCU03wJ65TOx6I4GOggqgcGuB
         0KNnmfeS/2iXlR6nQUQYKfuiPQUm77tBcb6VofctAeIH7FLt1kRU4pJ28nrgauwWdU81
         ruG+YTrMyiZHt1+27EC1afo7b3vvLF1SHtIEhsJSPtFdowU9ZkiTQiUVYy6ZlnfF60Jl
         nobA==
X-Gm-Message-State: AOJu0YwOCxyFElISqePgFZQYYiKLL67/7ZtKkr9XbON9cY/zToDoeaKo
	cHJOB5UoFi0PY5iFTP8bo19+6wHL2siL5nwGlluM6v+RiGUtueQcx44Bz42cH0fI40z5bObkVrt
	NdWRP3LsR/+CcPgte/qVjxckWMHPjRPI=
X-Gm-Gg: AR+sD102oqpYrSy8kLy4mIv7WApj107yXSc26nxEfhdVPGWEsYj3Tz6HtREgkwbE2c6
	ERT/Eqb6+FlPtGeBSbww3mrlZww5PD1730iH7WFpv7iReYMMxOz8N1QZROiO0CzWLcsKsRQiR/6
	u/Vu4lSmllN5twiStYungDk9Hx09PeP4eL0NpY0bGFAQ13iohZ9zF/s4l+85eOGgwBAYV4lQmdx
	yYcK5Q7tuxsGttEPE/67wWwjsTJFW83ytXx8cgnTRvfZ7A3HrDqSxqRUEjTYoYZV5ecyzpSFaMq
	XsW7XjL1en39l/UCr78BP95I7pzkb0P5wWKqmqMp9+V8btHdND3QeJbIcW6hPDw9DjD6tec=
X-Received: by 2002:a17:907:8e96:b0:c12:83c9:d41 with SMTP id
 a640c23a62f3a-c20c67e6fd9mr99288466b.12.1786370696006; Mon, 10 Aug 2026
 07:04:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810133540.1947118-1-puranjay@kernel.org> <20260810133540.1947118-2-puranjay@kernel.org>
 <20260810140306.C1D721F000E9@smtp.kernel.org>
In-Reply-To: <20260810140306.C1D721F000E9@smtp.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 10 Aug 2026 15:04:42 +0100
X-Gm-Features: AUfX_mzW0QQd2n7jimcEIfkUiJMD2Japtfg5KrPbI5Jksmx_wgWQIhzjSqo4ogE
Message-ID: <CANk7y0gUp5-Rqt-CCmfh1W5o2sMHW+Z=oGrjLYXdS81ZLE-TaA@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] perf/core: Fix NULL pmu_ctx passed to pmu->sched_task()
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 3:03=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Per-CPU PMUs missing `sched_task` callbacks during context switc=
hes if a task context exists.
> --
>
> --- Patch [1]: [PATCH v7 1/3] perf/core: Fix NULL pmu_ctx passed to pmu->=
sched_task() ---
> commit 333df3e02c2d6b54e5bd528f91779820677d118e
> Author: Puranjay Mohan <puranjay@kernel.org>
>
> perf/core: Fix NULL pmu_ctx passed to pmu->sched_task()
>
> perf_pmu_sched_task() returns early when cpuctx->task_ctx is set, and
> cpc->task_epc is only non-NULL while a task context is scheduled in on
> this CPU. This patch passes &cpc->epc instead, which is the CPU-wide
> context for this PMU, avoiding a NULL pointer dereference.
>
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index ba5bd6a78fe7b..c372213ffc883 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -3907,7 +3907,7 @@ static void __perf_pmu_sched_task(struct perf_cpu=
_pmu_context *cpc,
> >       perf_ctx_lock(cpuctx, cpuctx->task_ctx);
> >       perf_pmu_disable(pmu);
> >
> > -     pmu->sched_task(cpc->task_epc, task, sched_in);
> > +     pmu->sched_task(&cpc->epc, task, sched_in);
>
> [Severity: High]
> This isn't a bug introduced by this patch, but does the early return in
> perf_pmu_sched_task() skip callbacks for CPU-wide PMUs?
>
> If a system-wide PMU event is active (sched_cb_usage > 0), and a context
> switch occurs to or from a task with an active perf event (meaning
> cpuctx->task_ctx is set), perf_pmu_sched_task() returns early:
>
> kernel/events/core.c:perf_pmu_sched_task() {
>         ...
>         /* cpuctx->task_ctx will be handled in perf_event_context_sched_i=
n/out */
>         if (prev =3D=3D next || cpuctx->task_ctx)
>                 return;
>         ...
> }
>
> It seems to rely on perf_event_context_sched_out/in() to handle the
> callbacks. However, perf_ctx_sched_task_cb() only iterates over the task'=
s
> pmu_ctx_list:
>
> kernel/events/core.c:perf_ctx_sched_task_cb() {
>         ...
>         list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
>                 cpc =3D this_cpc(pmu_ctx->pmu);
>
>                 if (cpc->sched_cb_usage && pmu_ctx->pmu->sched_task)
>                         pmu_ctx->pmu->sched_task(pmu_ctx, task, sched_in)=
;
>         }
>         ...
> }
>
> If the task's perf event is for a different PMU (like a software event), =
the
> CPU-wide PMU won't be in ctx->pmu_ctx_list. Does this mean the CPU-wide
> PMU's sched_task() callback is completely skipped during the context swit=
ch,
> potentially corrupting hardware tracing or leaking branch records across =
tasks?
>
> >
> >       perf_pmu_enable(pmu);
> >       perf_ctx_unlock(cpuctx, cpuctx->task_ctx);


Next patch fixes this exact issue.
