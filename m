Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE0314A4C7
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Apr 2025 04:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744951101; cv=none; b=un47pHpL52WECff3OPBam+9zZlPqW1eXWWnxyp8yO0Q+iUadM99McFxlZDLA296VvHC5vjvn6ofWFZobffjcOfikEV3LlRcZI0SKLbO1XAZKMRPyJ7wjPXEzERroWOxe5uWApeq2mQ/BHpsAKki2cFElJPYsgs2o7qebOYazYEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744951101; c=relaxed/simple;
	bh=vfu58btUgceDW5CcoAg4ZjLX+XL7N+MOmIt4/J/6gt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qay9YJkceSYfu+IeDd3KlBx4Fc6olFYsNnA/57/T7/dKS41t3tgkRLK15muxRF8lXh2KvcCwMXJClRFGHjc6VuGwmt+AgSCp28mLx6WZ8V6AxaTpbnPbuX1KEgGBwCdqiR5YMx5iVLkoU8bun2SMqs7Q4VBRuzFLFSLWnnclNUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AkGJv7rV; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AkGJv7rV"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4774611d40bso187581cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Apr 2025 21:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744951098; x=1745555898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alu2R4F3B7RUJL8sloJCdr8FVEoYU8rWGzhQ01p1ka8=;
        b=AkGJv7rV1dbqGgsTA4UQs44O93ySE8y7t7G2Vf7DNE+Oyx6lF24VCcOOr3LptTnuVd
         /wQAcFAFCmMR9SQpB3LcZwkA2kVX+G3PE/ypCvI9UkgKwI/Ak/89Eps2djtwyL+FotID
         AI/02KuYUYdmEcoAb859PHawmWaWc4p9pbdhztFuQwYrt8KuNzqtQfXa1HQy1qf+7icZ
         ZgwXKWiflQCr1JQqe1ULernpNdmYGGQMXqgcf97l2BS2R7HkvAEZS96JxK/cZryMTHU8
         poHbE5VucddBPlz15AjQnZTSEs9Qp72ciuW0V/4lJl6VEWaZcGnCWKRu8pJZ2Fvc8utC
         FB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744951098; x=1745555898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alu2R4F3B7RUJL8sloJCdr8FVEoYU8rWGzhQ01p1ka8=;
        b=D3L421whw321dSJNDR/R+JZhAlxoWEiGdkhEtNfQZGyBTxKVQ7sw9mC2vVClFg8mT+
         0lWRiuARuxZe2Xs6HglFdfYuSc9CHnxTVNYAw404x0JMrVGTOIYVEklK52n1aPTfB5lv
         ZgGPULNqwI4PsE7+TBDOa/3C4xCshpgfckJH38RGFAPtWPoJFJ+u4sBDbLSQ2yH826KZ
         JUf42oxR4ijNmFaK7hqCudxv5+COxzaTLCdHiEgMc9+8ZTNFRwQSeE/JO4Ao8VbmHThJ
         Nwo1WSVohCNfDBFT2IZ2GdCNWWTZIfVdpLv919DY7+EQKO3vSzaQy7MvEHTpEyrpOV/C
         QIDQ==
X-Gm-Message-State: AOJu0YxQ3B8ILaft92UGW+PMl9Kln8bbJthvdxfmh4O2B6U+M6iApvBL
	q/fuC6NM+ZfvHKmU/ehKN5Sf/eTx0sxA8Ts8jgWA3WomJcYAMsskKNG/vbbWhjNJ7hqqskk6i6V
	TNWZ3273mG9+uiUiuycNbGbNkmcWGpbUb83zb
X-Gm-Gg: ASbGncskBnilj/jkmIrL8n5nfjugjft8EgWG4puiFRhMHgB5yQaD5M8+DbJb5WjwBA3
	G1Z96jRftNk88KsL7IeE2TFK0j/BezQ112sRx70Xg6J+RKyxOWgTt+fJIcx25heb9Q3UltL/0JC
	gYEFUvJ4I1qSTH09CMDuBKjRqR+f7DjD699pfc7Po4+5/qyMdiDk+QJrc=
X-Google-Smtp-Source: AGHT+IEQwdCoq6ssid8K1M7dKnqK1w8BnxQuH4nU8TPJG+w0y8sO/BUglZoz0UfWFnGOaEnnZC+3anrdokcAlx3LzeE=
X-Received: by 2002:a05:622a:491:b0:476:f4e9:314e with SMTP id
 d75a77b69052e-47aecc92a27mr1623031cf.25.1744951098055; Thu, 17 Apr 2025
 21:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744906694.git.sandipan.das@amd.com> <8ecf5fe20452da1cd19cf3ff4954d3e7c5137468.1744906694.git.sandipan.das@amd.com>
In-Reply-To: <8ecf5fe20452da1cd19cf3ff4954d3e7c5137468.1744906694.git.sandipan.das@amd.com>
From: Stephane Eranian <eranian@google.com>
Date: Thu, 17 Apr 2025 21:38:05 -0700
X-Gm-Features: ATxdqUEwPg2OmVNqmUmBlYhcX7bAmP2fEDLfnUqgavDPvjEmBbvMRWdI1M5qi94
Message-ID: <CABPqkBS+k4Om3-sQWGBFN-imhiU8fXYsiDR1XAyp0Ro3uknCHw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] perf/x86/amd/uncore: Use hrtimer for handling overflows
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, songliubraving@meta.com, ravi.bangoria@amd.com, 
	ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 8:44=E2=80=AFPM Sandipan Das <sandipan.das@amd.com>=
 wrote:
>
> Uncore counters do not provide mechanisms like interrupts to report
> overflows and the accumulated user-visible count is incorrect if there
> is more than one overflow between two successive read requests for the
> same event because the value of prev_count goes out-of-date for
> calculating the correct delta.
>
> To avoid this, start a hrtimer to periodically initiate a pmu->read() of
> the active counters for keeping prev_count up-to-date. It should be
> noted that the hrtimer duration should be lesser than the shortest time
> it takes for a counter to overflow for this approach to be effective.
>
The problem I see is that the number of uncore PMU varies a lot based
on the CPU model, in particular due to the L3 PMU.
Is there a timer armed per CCX or only a global one that will generate
IPI to all other CPUs?

> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> ---
>  arch/x86/events/amd/uncore.c | 63 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>
> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
> index 010024f09f2c..e09bfbb4a4cd 100644
> --- a/arch/x86/events/amd/uncore.c
> +++ b/arch/x86/events/amd/uncore.c
> @@ -21,6 +21,7 @@
>  #define NUM_COUNTERS_NB                4
>  #define NUM_COUNTERS_L2                4
>  #define NUM_COUNTERS_L3                6
> +#define NUM_COUNTERS_MAX       64
>
>  #define RDPMC_BASE_NB          6
>  #define RDPMC_BASE_LLC         10
> @@ -38,6 +39,10 @@ struct amd_uncore_ctx {
>         int refcnt;
>         int cpu;
>         struct perf_event **events;
> +       unsigned long active_mask[BITS_TO_LONGS(NUM_COUNTERS_MAX)];
> +       int nr_active;
> +       struct hrtimer hrtimer;
> +       u64 hrtimer_duration;
>  };
>
>  struct amd_uncore_pmu {
> @@ -87,6 +92,42 @@ static struct amd_uncore_pmu *event_to_amd_uncore_pmu(=
struct perf_event *event)
>         return container_of(event->pmu, struct amd_uncore_pmu, pmu);
>  }
>
> +static enum hrtimer_restart amd_uncore_hrtimer(struct hrtimer *hrtimer)
> +{
> +       struct amd_uncore_ctx *ctx;
> +       struct perf_event *event;
> +       int bit;
> +
> +       ctx =3D container_of(hrtimer, struct amd_uncore_ctx, hrtimer);
> +
> +       if (!ctx->nr_active || ctx->cpu !=3D smp_processor_id())
> +               return HRTIMER_NORESTART;
> +
> +       for_each_set_bit(bit, ctx->active_mask, NUM_COUNTERS_MAX) {
> +               event =3D ctx->events[bit];
> +               event->pmu->read(event);
> +       }
> +
> +       hrtimer_forward_now(hrtimer, ns_to_ktime(ctx->hrtimer_duration));
> +       return HRTIMER_RESTART;
> +}
> +
> +static void amd_uncore_start_hrtimer(struct amd_uncore_ctx *ctx)
> +{
> +       hrtimer_start(&ctx->hrtimer, ns_to_ktime(ctx->hrtimer_duration),
> +                     HRTIMER_MODE_REL_PINNED_HARD);
> +}
> +
> +static void amd_uncore_cancel_hrtimer(struct amd_uncore_ctx *ctx)
> +{
> +       hrtimer_cancel(&ctx->hrtimer);
> +}
> +
> +static void amd_uncore_init_hrtimer(struct amd_uncore_ctx *ctx)
> +{
> +       hrtimer_setup(&ctx->hrtimer, amd_uncore_hrtimer, CLOCK_MONOTONIC,=
 HRTIMER_MODE_REL_HARD);
> +}
> +
>  static void amd_uncore_read(struct perf_event *event)
>  {
>         struct hw_perf_event *hwc =3D &event->hw;
> @@ -117,18 +158,26 @@ static void amd_uncore_read(struct perf_event *even=
t)
>
>  static void amd_uncore_start(struct perf_event *event, int flags)
>  {
> +       struct amd_uncore_pmu *pmu =3D event_to_amd_uncore_pmu(event);
> +       struct amd_uncore_ctx *ctx =3D *per_cpu_ptr(pmu->ctx, event->cpu)=
;
>         struct hw_perf_event *hwc =3D &event->hw;
>
> +       if (!ctx->nr_active++)
> +               amd_uncore_start_hrtimer(ctx);
> +
>         if (flags & PERF_EF_RELOAD)
>                 wrmsrl(hwc->event_base, (u64)local64_read(&hwc->prev_coun=
t));
>
>         hwc->state =3D 0;
> +       __set_bit(hwc->idx, ctx->active_mask);
>         wrmsrl(hwc->config_base, (hwc->config | ARCH_PERFMON_EVENTSEL_ENA=
BLE));
>         perf_event_update_userpage(event);
>  }
>
>  static void amd_uncore_stop(struct perf_event *event, int flags)
>  {
> +       struct amd_uncore_pmu *pmu =3D event_to_amd_uncore_pmu(event);
> +       struct amd_uncore_ctx *ctx =3D *per_cpu_ptr(pmu->ctx, event->cpu)=
;
>         struct hw_perf_event *hwc =3D &event->hw;
>
>         wrmsrl(hwc->config_base, hwc->config);
> @@ -138,6 +187,11 @@ static void amd_uncore_stop(struct perf_event *event=
, int flags)
>                 event->pmu->read(event);
>                 hwc->state |=3D PERF_HES_UPTODATE;
>         }
> +
> +       if (!--ctx->nr_active)
> +               amd_uncore_cancel_hrtimer(ctx);
> +
> +       __clear_bit(hwc->idx, ctx->active_mask);
>  }
>
>  static int amd_uncore_add(struct perf_event *event, int flags)
> @@ -490,6 +544,9 @@ static int amd_uncore_ctx_init(struct amd_uncore *unc=
ore, unsigned int cpu)
>                                 goto fail;
>                         }
>
> +                       amd_uncore_init_hrtimer(curr);
> +                       curr->hrtimer_duration =3D 60LL * NSEC_PER_SEC;
> +
>                         cpumask_set_cpu(cpu, &pmu->active_mask);
>                 }
>
> @@ -879,12 +936,18 @@ static int amd_uncore_umc_event_init(struct perf_ev=
ent *event)
>
>  static void amd_uncore_umc_start(struct perf_event *event, int flags)
>  {
> +       struct amd_uncore_pmu *pmu =3D event_to_amd_uncore_pmu(event);
> +       struct amd_uncore_ctx *ctx =3D *per_cpu_ptr(pmu->ctx, event->cpu)=
;
>         struct hw_perf_event *hwc =3D &event->hw;
>
> +       if (!ctx->nr_active++)
> +               amd_uncore_start_hrtimer(ctx);
> +
>         if (flags & PERF_EF_RELOAD)
>                 wrmsrl(hwc->event_base, (u64)local64_read(&hwc->prev_coun=
t));
>
>         hwc->state =3D 0;
> +       __set_bit(hwc->idx, ctx->active_mask);
>         wrmsrl(hwc->config_base, (hwc->config | AMD64_PERFMON_V2_ENABLE_U=
MC));
>         perf_event_update_userpage(event);
>  }
> --
> 2.43.0
>
