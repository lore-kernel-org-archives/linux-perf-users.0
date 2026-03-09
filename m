Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C353C1995
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 15:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071333; cv=pass; b=PshChiWYegtBJi9RGRzKuJ5mCUvWrRP9uPL/sTHJE049fph6t4qGiULJjGZWbbefkyH/3G8jCbITFxk7ml6rnBcRD+GRkze2kZyltT8wh2e7YKWbpo+OtzJLGZHacblO2eHDKLJ5dGNDoLBPmmKDMkgOvpqAHRTV9vOmLpopVHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071333; c=relaxed/simple;
	bh=uJ/VC6Uxtx3MxQiAnMLJsC+6B6yK26/1pFhyOFBOrH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXCmclGP/oJ2a4tAgVbpkeyCsMcoCt5yEyU2z+c1uHSla58ong+2KGjir79bbJMcBMIAMEKzeG82OXXVUOhZn5oaMrOy0PSGJb3NWFkBD4Y+dOeZnEWLlC2GbMeLG6LUxgxjx1VqWwxF/SpnqrFPJKPrjTS4wHEHyq/7SEKVZc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uFxrrKmA; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uFxrrKmA"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ae3f822163so152805ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 08:48:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773071330; cv=none;
        d=google.com; s=arc-20240605;
        b=arzGsBLGwbWj32glyQbz5nZOeQczvKD598lFCUy6rh59zS/OKsbN4XExekeHfhprNN
         bAhbDHtCXICLY0c9T6y0fcDPfiX/mZERqMFOMWGuJpfoHtFBMuYS4/TrIbU+G2vW7Kx8
         TutmtZXokcUsZSMr2OCcuOyIUv6HdrorqtSCRFGlUAPyTPjEVsNiyNeepuTkWMXulOy6
         NDT2E3xt3dJ4kIaE8L23ATc2DdO267nlcHh5tzuQ/8VZDhV7RC6vjRHPKj5rDLEH0fnV
         YdcU0suwVvgSRr/ZLwM7Et3/RAFRtwd191UuaDNgfJ8QARfbmvU1ydzm1F0prbI8aSPu
         0obg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CA6/7hC6/EjB6Ur1CNpGWcjCxmjoCcUj5HNax+6YIEg=;
        fh=x2YdKGOyXkM/iVtlzlr0Qmd62FEgs+hsFzFGgg3PZkU=;
        b=MFqQMYc9s8z5Sxq/aJp3KbGcqpaJ+zOLvK1nFwQmOd9dZxiOopt3T1jqp4O6cEqRIS
         jBxS0+6Q9aTiWwvyEwKUOjbNU94q/Mr0PdwYY7r4gkh/teuHUn6VU/LecXFukov8hBTl
         oSTDkJvRx7QtvxgDXli6Y6Ioq4yhjWWLaJX7W2AB4VvzI67Ull/lk3AxMytyvaANJdKn
         yLjXGwLQXa0VezSDGzGuokTFb4ge4gXAs2wuKyj3rq92A3u5y0PVn7m5R5HgmTuf0K1I
         Ksiyi37FIWKgIu5irmKKlKC09kg3xGigSL7SABxZ0YzuVH+mh6Rnzl2gdCUJBkwZJ8Tb
         OHmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773071330; x=1773676130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CA6/7hC6/EjB6Ur1CNpGWcjCxmjoCcUj5HNax+6YIEg=;
        b=uFxrrKmAWYlOoMHf+tmADsGZPS2Qus7CYVMdep0IHgA0aSN9fODo6Fu7e4Lx+4jG1V
         8oXVh1uZzVQq9uf828/SiUljFrj+8mL3GNhBHfTQEyrSolJ063ulq09ecaKA+aQbUcl/
         Ndd5hPT3Z/DtUfh7/pmY2+OEoOafkPI9y1n7ENDNcdQ4fFwRUcHf3A5tw38dTUa/aSoq
         9zkCfMPsSI6hMiaHU3LvMcdJ0380bXJsKttht+/6TdSt8TQ4pbFa/yBdEJX+dhwl81T+
         2rzIq12xV0w32SG4lDVFdGJzCzp7xCjlckLrWVAQF/BeNOC7h8CLKW0M/RUTVj5qM37q
         BMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773071330; x=1773676130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CA6/7hC6/EjB6Ur1CNpGWcjCxmjoCcUj5HNax+6YIEg=;
        b=Bz7QoUrTrryGSf1Cn8ZmIJiy5blSySocc8IhIE5m5JaXDrXoAN/NZHXv0cmd+FCdZX
         05gPQa0PWx+oNwo5mtEnCzlK7IRpzGI5PjmA5JUr5ANTUaMq88m6TP+/4df4WruXBOd+
         jl1hKZOutmflL1C2FnGXUdFRAzd/7YBa7sj6q7XZDZrJzkarPYYnC6KDf7DxGBeh2tjT
         ymhPcICv0XJWzK+5HVPATsxnOcE8tvxWCp0PVz+n1XHmCqMmWjtBEEO7hwFpilnFlINP
         Lv9qr/SbyJEmJAbrNgKX0vqtX7bf9FWGfuVOPiXsrSFsYqGBEZej/3m6ni0+5eZwuzqo
         fSKg==
X-Forwarded-Encrypted: i=1; AJvYcCU7enX1VkETywJKrLT77z5KppUBQSj6U5VKuBaDDEWYRA9XKkjLJys6LM2coHKQSTy+b59n3XDAUF0zF7EI2o45@vger.kernel.org
X-Gm-Message-State: AOJu0YwMz4zWF68boncukC0+FbbF2quBmG6KRL0D0AIN0YSMQKaANw4I
	uMG4g9wBwq+X1WJ2JpEf9UBH/m+BsnlZjuNhW7jwj2B64k8HdXc6o5kVzsqpSVOUoqKzKYYS75O
	rCsKRCipB3XLc8omaFpE5AOH8uYrgyWlm9d9+WdlZ
X-Gm-Gg: ATEYQzy0jLAnFLbZt1Ji45GLXKpItjnuGvthOXySXvytqCOrWsLplMmD3cs76dZT9ND
	vaFT4gwP0qxvnLPujMWgkF8k+dw5zZuIzF4aseddT1GOgU9rzzCZaUTWFJfwqogiyFyo+cai5dY
	PiaJnlQvijZpvIdUb9/FY7ns23XEG9js45VD9n+eLG3oyPyYeT4MYIZHj5qHp/KAojzEjVeFe0H
	NKIkVLlrfD0/IAZU8Li8FVR+HaWCSGfzbhSEeH8a2MKHQ1VnpV2ahqAInEn1sfCZti4XH2DoFFL
	2mYKbgqdAACVd6asKIll6f3PtM+u9PAuHdEmeQ==
X-Received: by 2002:a17:902:e74a:b0:2ae:80a3:cd11 with SMTP id
 d9443c01a7336-2ae8ba41590mr3695495ad.7.1773071330236; Mon, 09 Mar 2026
 08:48:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309014215.3871484-1-olrose55@gmail.com> <20260309120543.GA606826@noisy.programming.kicks-ass.net>
 <20260309133713.GB606826@noisy.programming.kicks-ass.net>
In-Reply-To: <20260309133713.GB606826@noisy.programming.kicks-ass.net>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 08:48:38 -0700
X-Gm-Features: AaiRm51pMqayV3W3Ak-qGlvdzW9jI8BX5MqJR7_rltk8rBj50L3PYzrHYe5VqJI
Message-ID: <CAP-5=fVg8EcZCzmZgvb6SY9_XkRh7JP4_TcCV05vWAZchiSNgw@mail.gmail.com>
Subject: Re: [PATCH] perf_events: fix array-index-out-of-bounds in x86_pmu_del
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oliver Rosenberg <olrose55@gmail.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 6:37=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Mon, Mar 09, 2026 at 01:05:43PM +0100, Peter Zijlstra wrote:
> > Now, let me go audit the code to see if this same problem exists in mor=
e
> > shapes...
>
> I've ended up with the below.
>
> ---
> Subject: perf: Make sure to use pmu_ctx->pmu for groups
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Mon Mar 9 13:55:46 CET 2026
>
> Oliver reported that x86_pmu_del() ended up doing an out-of-bound memory =
access
> when group_sched_in() fails and needs to roll back.
>
> This *should* be handled by the transaction callbacks, but he found that =
when
> the group leader is a software event, the transaction handlers of the wro=
ng PMU
> are used. Despite the move_group case in perf_event_open() and group_sche=
d_in()
> using pmu_ctx->pmu.
>
> Turns out, inherit uses event->pmu to clone the events, effectively undoi=
ng the
> move_group case for all inherited contexts. Fix this by also making inher=
it use
> pmu_ctx->pmu, ensuring all inherited counters end up in the same pmu cont=
ext.
>
> Similarly, __perf_event_read() should use equally use pmu_ctx->pmu for th=
e
> group case.
>
> Fixes: bd2756811766 ("perf: Rewrite core context handling")
> Reported-by: Oliver Rosenberg <olrose55@gmail.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  kernel/events/core.c |   14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4813,7 +4813,7 @@ static void __perf_event_read(void *info
>         struct perf_event *sub, *event =3D data->event;
>         struct perf_event_context *ctx =3D event->ctx;
>         struct perf_cpu_context *cpuctx =3D this_cpu_ptr(&perf_cpu_contex=
t);
> -       struct pmu *pmu =3D event->pmu;
> +       struct pmu *pmu;
>
>         /*
>          * If this is a task context, we need to check whether it is
> @@ -4825,7 +4825,7 @@ static void __perf_event_read(void *info
>         if (ctx->task && cpuctx->task_ctx !=3D ctx)
>                 return;
>
> -       raw_spin_lock(&ctx->lock);
> +       guard(raw_spinlock)(&ctx->lock);
>         ctx_time_update_event(ctx, event);
>
>         perf_event_update_time(event);
> @@ -4833,14 +4833,15 @@ static void __perf_event_read(void *info
>                 perf_event_update_sibling_time(event);
>
>         if (event->state !=3D PERF_EVENT_STATE_ACTIVE)
> -               goto unlock;
> +               return;
>
>         if (!data->group) {
>                 pmu->read(event);
>                 data->ret =3D 0;
> -               goto unlock;
> +               return;
>         }
>
> +       pmu =3D event->pmu_ctx->pmu;
>         pmu->start_txn(pmu, PERF_PMU_TXN_READ);
>
>         pmu->read(event);
> @@ -4849,9 +4850,6 @@ static void __perf_event_read(void *info
>                 perf_pmu_read(sub);
>
>         data->ret =3D pmu->commit_txn(pmu);
> -
> -unlock:
> -       raw_spin_unlock(&ctx->lock);
>  }
>
>  static inline u64 perf_event_count(struct perf_event *event, bool self)
> @@ -14743,7 +14741,7 @@ inherit_event(struct perf_event *parent_
>         get_ctx(child_ctx);
>         child_event->ctx =3D child_ctx;
>
> -       pmu_ctx =3D find_get_pmu_context(child_event->pmu, child_ctx, chi=
ld_event);
> +       pmu_ctx =3D find_get_pmu_context(parent_event->pmu_ctx->pmu, chil=
d_ctx, child_event);
>         if (IS_ERR(pmu_ctx)) {
>                 free_event(child_event);
>                 return ERR_CAST(pmu_ctx);
