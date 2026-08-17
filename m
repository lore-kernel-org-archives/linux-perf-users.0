Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B875442368
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 19:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994926; cv=pass; b=Pq158osA0DxPgHP+wl7rEqqGfLq7VgdQWGLlwwtWFqVYlql7FU9gJ6R5IyrWTk2/ysr8sq1ci7OY0b6Xx36s1v18VjDQUiR/RoUOYCQpyJEv5bDE64FZxsoCwlbw9VobHoNEasQPuepdP5qSW3aUXTiKFHOW+pDwxby5QWDFox8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994926; c=relaxed/simple;
	bh=E+9p4Ktw7qIb6r4awUhnddYeMOmpqbe0oyhzt0QuIYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zes6Q0Gn1LfC51SOTfxU85XdNqjk1thQo/gy64GRm5StfhZ373S78l/FqozdVGQk/GgXCRzYBde06SWqNK37pKxdkQknXNZH7Ec44yQUOQIum2X55qpZOy9NnoP7g8cKhFQJocFFF+Jd50jTacgQaTSe0GKj2d715vqkC8v7Lxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IaVdFpfI; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IaVdFpfI"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ccdf36f63dso18995ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 12:28:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786994924; cv=none;
        d=google.com; s=arc-20260327;
        b=LZsd1kP4VKjc10x6XAckCGVaF4PzkE53j69ajsDFyjQXSKvcAq1aOZ9CeikwsPhBYQ
         WGNdjJgcA/SuiJ8BIuqmB3u4fRYf+1Iam9yfXn5xBwlHM/MJ1oqCjB9Hxdonob62MTnz
         hkQThr2jwPutIuZT+dvRDk2D2zQbQqi8Iuko6kL7WDR9jrQB3o0YtNZc5Wfvc3rsoLFq
         gfCr+MUXNnFpVBOsHdCUux/ZZWzIjXpfNZD6h65FPk3Qk8TSg9LX4i2Hf3e9qeAfPSW/
         Q/NMpLG4eimh/YHvWJBJ4yOawr1OltwtFdkIf900QPgUdd7mzBlddQmm7izseKkO1CIq
         5tyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LGn/SQWAyejOHOhqPphro3ssVKqrTOZCaI0vJa05Uyc=;
        fh=cZYUM4lsM+8BpXcZ0cpQZwiq47BJxkwKGfvLAN/Xyvk=;
        b=PnKpORtiKtbBJuplZ0hT4OzmR5rxc//l54qSDFkRb+dddnQ8p9pe5PvTqo2PIyhCrt
         nPcEJ04Z+QZCeMl4KyDHsgTu7eWuOC4qPRqPT9HRo04i1IQVgoMAROVyzUtrsnCK5k5C
         fWP80v7LYyAPG5yGcjUx2ZsPSmk9VXVOYLiHa3mvfKJ2B5EkQGOJdlkD/N7ckX2X0Ix1
         FXWGLf78GLEMZpwYnYvafGIYSgP0jeIy7Vregpta8shrPa/w8SbbbRNeOaZIdSk+ZaXZ
         81Drv6tJGvFqHaxY2HJT97Q2iUCWG4plHuMOz3UQS4vPYNuuDPJeB1vZU2xgeW+ztp4+
         uhyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786994924; x=1787599724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LGn/SQWAyejOHOhqPphro3ssVKqrTOZCaI0vJa05Uyc=;
        b=IaVdFpfI8Ex+JTQ0lE6CFhQ2uu7L++Zixy3pnL3mgC8FLwsTjpM5apiZ8zIvAvg7oq
         O9/wVhxVIf0azpQBuWnHNjMfeAScxX2PyHAB2fQktnoTRN9Iv0Qwy4zYqZHn5Tdx1gHF
         lL8Xo29HSZKdU8lCDJDcI7fzysYUOabbKSvv7keeuQPa73BTsBSw2j5wDb+2d1EAen3n
         +ScR7O2I31bfdC5C/gUvOErtbX6Xq9CRNIFdQMWYNE0Qfi61etMw+X0rT0xFAm8Sgt5U
         eIt423cS2ISV8DOYlJIarI3v5vvkc93JlFWY+F/ziwhaDIMqXwGwtBfveK6WUQBGpZqI
         pOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994924; x=1787599724;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LGn/SQWAyejOHOhqPphro3ssVKqrTOZCaI0vJa05Uyc=;
        b=F0Cx5kyq3e+nttbCd2wTMP4Bb74ZpTRhPzRiZfBGdF9z2be90mys9hOEJwY3Le/V8Y
         dAwwKidcHmil/lWstCFbQnmZ3rr3xFsDIFndL8nRDMUjGmUcOTQtbPVKVOtrD0XX0yi+
         kyrUgE4V79iB7wepVOzn6W/nKGUw35jdYSBGjHS6wBgeDKp5UKxqNsRONNlMtrKvH9j9
         /7yvy0vSn1Lr5BG+1PFpCG01J/WEswJXgqGgANZCb4RvCnpQX40qzN1ETKue0bc0oGs9
         +6kCct55doF/wAnRWbh9nIxkA0Q+S0JJUTmHYL/w2EOV2bw17M9kyCKnVh3vnFf4xaOY
         lESg==
X-Forwarded-Encrypted: i=1; AHgh+RrrwbyNPrBlpOLvW4NpWYbGcrqyZZwcZAEygw7QxByTDVsC6ABYUA/wIkae0OXYvlYjPpOMZ35FRDCgQMtdoLCx@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfb7GNtyNK1J2j+sqUGWqBapIzPUEjdJKudbCL8UwTSy9GHglb
	QBX1uFXlzWAeAakam9u2vihFRLrocJY72n+WeGeigLV0PO0lQ76ZFUd/0r59xRhpp9wSynAX2uQ
	WxSUg/J/eY7U/ugPnl1YnOqemAECf7dQ/q8d993g4
X-Gm-Gg: AR+sD11HQgFa3UiV0tSO0l0n4bbRy8a1kg1JFB7XayRJ2qR4k4aDsFSvWuj55fpauz4
	6iFvaH5E0jz8h0pBUxsgQiOpaN5Ahs0GGDZeskhDdfZOLD36RpR8neHJR1nP+qdLhFS6iRODTlp
	o4/tcb1olbNuyxk+xcv/SP3aizdUT/JfXtROchtoxahrrHsNHlzG+BipLYJeloCOHLfbS/hCHGw
	8ZdnNcC0R5UDmiTG8bgDEfdB+1O00Grhl83QYtTADpIFHES9rhDf3j8qff/773G7Rd7tH+DKN+s
	R5dDH/C86Dzz11y/emCMkf0uUQBIN0miHzXR8ckNwb3EFHtLDQJUOIHO3aujF2T12CatxHGv96g
	=
X-Received: by 2002:a17:903:3d0f:b0:2bf:3579:cdaa with SMTP id
 d9443c01a7336-2d5cca0821emr2319405ad.10.1786994918429; Mon, 17 Aug 2026
 12:28:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813064346.335458-1-dapeng1.mi@linux.intel.com>
In-Reply-To: <20260813064346.335458-1-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Aug 2026 12:28:25 -0700
X-Gm-Features: AcwNN1XPoKedeOFjVpACYc2oIYoNQK185S4RJmCshFaQqSbANvs_yg9Q4eoSaT4
Message-ID: <CAP-5=fWqqAFLwdRKeTN8q_GiCdvUx81bQT+=6KpWitV7uECM9w@mail.gmail.com>
Subject: Re: [Patch v2] perf/x86/intel: Prevent drain_pebs() reentry
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>, 
	Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 11:50=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.intel.=
com> wrote:
>
> The PEBS buffer is shared by all events on a CPU, so drain_pebs() must
> not be reentered. If so, one instance may observe stale buffer state and
> potentially access out-of-bound memory.
>
> Most invocations happen in NMI context, which naturally prevents reentry.
> However, drain_pebs() is also reachable from process context via
> intel_pmu_drain_pebs_buffer().
>
> In those paths, the PMU is often already disabled, but not guaranteed.
> For example, __intel_pmu_pebs_disable() only disables the target counter,
> so other active counters can still raise a PMI and interrupt an in-flight
> drain_pebs(). Here is an example,
>
> __perf_addr_filters_adjust()
>   perf_event_stop()
>     __perf_event_stop()
>       x86_pmu_stop() (event->pmu->stop)
>         intel_pmu_disable_event()
>           intel_pmu_pebs_disable()
>             __intel_pmu_pebs_disable()
>               intel_pmu_drain_large_pebs()
>                 intel_pmu_drain_pebs_buffer()
>
> Introduce __intel_pmu_quiesce() and __intel_pmu_resume() helpers and
> use them in intel_pmu_drain_large_pebs() to disable the full PMU
> around the intel_pmu_drain_pebs_buffer() call, preventing reentry.
>
> Also add a warning in intel_pmu_drain_pebs_buffer() when the full PMU is
> not disabled.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>
> v2: Move __intel_pmu_quiesce()/__intel_pmu_resume() pair into
> intel_pmu_drain_large_pebs() instead of guarding all drain_pebs()
> callbacks. (Peter)
>
> v1: https://lore.kernel.org/all/20260717080342.1879573-9-dapeng1.mi@linux=
.intel.com/
>
>  arch/x86/events/intel/core.c | 33 ++++++++++++++++++++++++---------
>  arch/x86/events/intel/ds.c   |  8 +++++++-
>  arch/x86/events/perf_event.h |  3 +++
>  3 files changed, 34 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index f6ee1819864e..1cdb52c0aad5 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3125,6 +3125,27 @@ static void intel_pmu_del_event(struct perf_event =
*event)
>                 this_cpu_ptr(&cpu_hw_events)->n_late_setup--;
>  }
>
> +int __intel_pmu_quiesce(void)

Thanks Dapeng. Rather than quiesce would
__intel_pmu_disable_if_enabled be a more intention revealing name?

> +{
> +       struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> +       int pmu_enabled =3D cpuc->enabled;
> +
> +       cpuc->enabled =3D 0;

Presumably the line above could also be inside the if.

> +       if (pmu_enabled)
> +               intel_pmu_disable_all();
> +
> +       return pmu_enabled;
> +}
> +
> +void __intel_pmu_resume(int pmu_enabled)
> +{
> +       struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> +
> +       cpuc->enabled =3D pmu_enabled;
> +       if (pmu_enabled)
> +               intel_pmu_enable_all(0);
> +}
> +
>  static int icl_set_topdown_event_period(struct perf_event *event)
>  {
>         struct hw_perf_event *hwc =3D &event->hw;
> @@ -3316,16 +3337,13 @@ static void intel_pmu_read_event(struct perf_even=
t *event)
>         if (event->hw.flags & (PERF_X86_EVENT_AUTO_RELOAD | PERF_X86_EVEN=
T_TOPDOWN) ||
>             is_pebs_counter_event_group(event)) {
>                 struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_event=
s);
> -               bool pmu_enabled =3D cpuc->enabled;
> +               int pmu_enabled;

nit: Maybe pmu_enabled would be better as pmu_was_enabled or pmu_reenable?

>
>                 /* Only need to call update_topdown_event() once for grou=
p read. */
>                 if (is_metric_event(event) && (cpuc->txn_flags & PERF_PMU=
_TXN_READ))
>                         return;
>
> -               cpuc->enabled =3D 0;
> -               if (pmu_enabled)
> -                       intel_pmu_disable_all();
> -
> +               pmu_enabled =3D __intel_pmu_quiesce();
>                 /*
>                  * If the PEBS counters snapshotting is enabled,
>                  * the topdown event is available in PEBS records.
> @@ -3334,10 +3352,7 @@ static void intel_pmu_read_event(struct perf_event=
 *event)
>                         static_call(intel_pmu_update_topdown_event)(event=
, NULL);
>                 else
>                         intel_pmu_drain_pebs_buffer();
> -
> -               cpuc->enabled =3D pmu_enabled;
> -               if (pmu_enabled)
> -                       intel_pmu_enable_all(0);
> +               __intel_pmu_resume(pmu_enabled);
>
>                 return;
>         }
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index e86e4ba91e1b..54890dda0589 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1242,8 +1242,11 @@ int intel_pmu_drain_bts_buffer(void)
>
>  void intel_pmu_drain_pebs_buffer(void)
>  {
> +       struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
>         struct perf_sample_data data;
>
> +       WARN_ON_ONCE(cpuc->enabled);
> +
>         static_call(x86_pmu_drain_pebs)(NULL, &data);
>  }
>
> @@ -1864,8 +1867,11 @@ static void intel_pmu_pebs_via_pt_enable(struct pe=
rf_event *event)
>  static inline void intel_pmu_drain_large_pebs(struct cpu_hw_events *cpuc=
)
>  {
>         if (cpuc->n_pebs =3D=3D cpuc->n_large_pebs &&
> -           cpuc->n_pebs !=3D cpuc->n_pebs_via_pt)
> +           cpuc->n_pebs !=3D cpuc->n_pebs_via_pt) {
> +               int enabled =3D __intel_pmu_quiesce();

Similarly, may be was_enabled rather than enabled.

Thanks,
Ian

>                 intel_pmu_drain_pebs_buffer();
> +               __intel_pmu_resume(enabled);
> +       }
>  }
>
>  static void __intel_pmu_pebs_enable(struct perf_event *event)
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index fa381110f7a7..84495279079a 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -1638,6 +1638,9 @@ static __always_inline void __intel_pmu_lbr_disable=
(void)
>         wrmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
>  }
>
> +extern int __intel_pmu_quiesce(void);
> +extern void __intel_pmu_resume(int pmu_enabled);
> +
>  int intel_pmu_save_and_restart(struct perf_event *event);
>
>  struct event_constraint *
>
> base-commit: 917d558b151cad5b05991e5eaee22efab33525ca
> --
> 2.34.1
>
