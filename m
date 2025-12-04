Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D4D290D81
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Dec 2025 07:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764832997; cv=none; b=YBtCauDugpH9WxQ8e/r2p50i0jnajMmKHaYVK/SI/ikbpVMGphifGkfR8Uw0zzonUw/jn6mR/eF5DN28QlRXZM3HUXvdDuZYZhNI/kLTEmKBn0WqJ+jyfWzB0V350/i8NAcHpyJnI1Oo61fyllQlp2renGRlUlHzfh7lPM4a5Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764832997; c=relaxed/simple;
	bh=zX9c7chYV7gXxEqwc4tFXZ6Sy0C+BBq2PqMRcTvKGFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=D/BQWowpXG1062msRdevoAB0P/kDdW+6KTgYgUAduZOGZh8C0oddLq+eY0KKGi0YiM0Cnj0fu/2rL2EaMltDwAGEVPGiKQPIkCCNv+NpFoLdU6g1TOPU1rW3UuTVCPJyw+XCUVuqEgbOwhIQFb/H+yC4igqFjaYFDGHLK9ifDZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=YuOhdV3X; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YuOhdV3X"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42e2d44c727so294497f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Dec 2025 23:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1764832994; x=1765437794; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=okWEC/iPxwHapBCL3ZZGyYvTBzssGUbkrGoBgDrV58Y=;
        b=YuOhdV3XhYeQLzGTeFG6NTPekh6PpI2Va1y9VOOTq8WXzzQRTM1kOajrxgsKF/VC+P
         bYQWr1bTosjJ2w5oRmJOUxC7hnh8gp7q74HdqhNC2JoCrXXfc6zDTCC97iQdJuoL+YfI
         C4tfgo2SLwponDTZaqwSc5DVLnXglAyoMLsCsJ3S3pULEZZgarfFbCMwHgUgupR+oq0P
         saF5UNREWfg9HMaTKyVw8mQOKA5iYP8duo9+dtM4865gFVMs2bVzFQQzFuF2+0TehDyo
         oZG+FAzfIwJt/np3LDEKrKtPbEBiMGRErMcDBr48wiVuF3/yG1aZ6wXD3Y3mLnua/GvU
         nKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764832994; x=1765437794;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=okWEC/iPxwHapBCL3ZZGyYvTBzssGUbkrGoBgDrV58Y=;
        b=KTpWAdi5sLFmlpc2XM5LKRIrxORTSojlqP/0uZzIug0gyvbAq5yxTVoMwlazx5zOvz
         5QURXNHifOf254WN7ENYfaO4h1RcFeI0XBROAyxFi3nWmaD03F0rWb+MmRFdY/Pc6w5v
         U3EPqlxa3EfVVI276xgM6zX/Usx0R72wn0I8E2k5Vy8eW+A5ucHNFkHJILimrsFfKQqK
         GICX/Wh1gXjWAb34+6syEM2h8KHXpNvKesp0ATQRUXLX/8PouIZg/0m8Da0LOl77IumW
         NYOdBpgC5AfkQ334stDmvPDfK3iAhBX9aRs6ygmdkyUBaXGDsFz+JoBqUnOzQfFiO6Cy
         nBeg==
X-Forwarded-Encrypted: i=1; AJvYcCVUt2l7b3vMZ6XXC/40MRclF2qYtqi6R642JtPktnAeie2N1yPOu609vi6mW/j8VKgcfcs0vfL4KJM0h/vBY9k8@vger.kernel.org
X-Gm-Message-State: AOJu0YxtEe639VSdS6iVFtOo1vCgHUu00b763hb0JMPY4hUrN8IFXpd/
	MnbQhYkK8FLaAt3GI8u2F0X0IjOHmHXx+63ef76H1ISPLGceKzkLpTw+Xf2cBd0BY1kFiSh0CSB
	pv8Yj8sPfCQJNtcpAlej0vRcMv6Vmo07OhSF0Xue6Qg==
X-Gm-Gg: ASbGncupXuEkyRI8ISnlCfPOW/VRiEr+5x0FbuI7d2Ugy3LQG3zeZaU19o530Ufn/7D
	CoZkEJMUi5hcdJUVogvCpo46h+HDtbQ9ty9KhKFluQ1Q7yOAlxeV51G/NBcpec79kFW65edC1AH
	TyQjbrJeYwqqad0VPhXdI4C9L6XuPaZiOEIja1kIgI5gSdaWzlHhaDg5Iu2yTP+E6Fm6loIbEDl
	M23SdDHUbWxuQr8DD3Pe0hDjftNulRVr31bM4PabW3U4Y4qSVDh6zowLwV7qUGFkRa69cqIUA==
X-Google-Smtp-Source: AGHT+IFaKGk1a1cfaFCq3oEJHjtRMI9goTFpitEtb54cbEHZjPz6jL2+k2TkdRXspbNqqeM3uYcrqB70IssR3M+MU1k=
X-Received: by 2002:a05:6000:4012:b0:42b:3701:c4c6 with SMTP id
 ffacd0b85a97d-42f731eb4d1mr4801776f8f.38.1764832993790; Wed, 03 Dec 2025
 23:23:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523-b4-ctr_upstream_v3-v3-0-ad355304ba1c@rivosinc.com>
 <20250523-b4-ctr_upstream_v3-v3-6-ad355304ba1c@rivosinc.com>
 <CAPqJEFr=3Re=L0CmEpCRHxovB74MDB9C8neNMfouYvWWbR0hyw@mail.gmail.com> <CAJh9TSJk0nZvqJrvTe5ENMpAB=56--+CFai0tXQnYFakKxQxQw@mail.gmail.com>
In-Reply-To: <CAJh9TSJk0nZvqJrvTe5ENMpAB=56--+CFai0tXQnYFakKxQxQw@mail.gmail.com>
From: Jimmy Ho <jimmy.ho@sifive.com>
Date: Thu, 4 Dec 2025 15:23:02 +0800
X-Gm-Features: AWmQ_bmUiiW9pn488x-Fr8fuYuHfeGljg_pilmkGRtBxdEqZhbPqlS98C4-BBjg
Message-ID: <CAJh9TS+MM+4ytsQ4tOhddNihvTrRMwV0rFRmMv1xRQTGcE18Dw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] riscv: pmu: Integrate CTR Ext support in
 riscv_pmu_dev driver
To: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, adrian.hunter@intel.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu, 
	Alexandre Ghiti <alex@ghiti.fr>, Patra <atishp@rivosinc.com>, Anup Patel <anup@brainfault.org>, 
	Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>, Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Beeman Strong <beeman@rivosinc.com>, 
	"Cc:" <linux-perf-users@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	palmer@sifive.com, Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org, 
	Rajnesh Kanwal <rkanwal@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

Hi Rajnesh,

> This integrates recently added CTR ext support in riscv_pmu_dev driver
> to enable branch stack sampling using PMU events.
>
> This mainly adds CTR enable/disable callbacks in rvpmu_ctr_stop()
> and rvpmu_ctr_start() function to start/stop branch recording along
> with the event.
>
> PMU overflow handler rvpmu_ovf_handler() is also updated to sample
> CTR entries in case of the overflow for the particular event programmed
> to records branches. The recorded entries are fed to core perf for
> further processing.
>
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> ---
>  drivers/perf/riscv_pmu_common.c |  3 +-
>  drivers/perf/riscv_pmu_dev.c    | 67 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 67 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/perf/riscv_pmu_common.c b/drivers/perf/riscv_pmu_common.c
> index b2dc78cbbb93926964f81f30be9ef4a1c02501df..0b032b8d8762e77d2b553643b0f9064e7c789cfe
> 100644
> --- a/drivers/perf/riscv_pmu_common.c
> +++ b/drivers/perf/riscv_pmu_common.c
> @@ -329,8 +329,7 @@ static int riscv_pmu_event_init(struct perf_event *event)
>         u64 event_config = 0;
>         uint64_t cmask;
>
> -       /* driver does not support branch stack sampling */
> -       if (has_branch_stack(event))
> +       if (needs_branch_stack(event) && !riscv_pmu_ctr_supported(rvpmu))
>                 return -EOPNOTSUPP;
>
>         hwc->flags = 0;
> diff --git a/drivers/perf/riscv_pmu_dev.c b/drivers/perf/riscv_pmu_dev.c
> index 95e6dd272db69f53b679e5fc3450785e45d5e8b9..b0c616fb939fcc61f7493877a8801916069f16f7
> 100644
> --- a/drivers/perf/riscv_pmu_dev.c
> +++ b/drivers/perf/riscv_pmu_dev.c
> @@ -1038,7 +1038,7 @@ static void rvpmu_sbi_ctr_stop(struct perf_event
> *event, unsigned long flag)
>  static void pmu_sched_task(struct perf_event_pmu_context *pmu_ctx,
>                            bool sched_in)
>  {
> -       /* Call CTR specific Sched hook. */
> +       riscv_pmu_ctr_sched_task(pmu_ctx, sched_in);
>  }
>
>  static int rvpmu_sbi_find_num_ctrs(void)
> @@ -1370,6 +1370,13 @@ static irqreturn_t rvpmu_ovf_handler(int irq, void *dev)
>                 hw_evt->state |= PERF_HES_UPTODATE;
>                 perf_sample_data_init(&data, 0, hw_evt->last_period);
>                 if (riscv_pmu_event_set_period(event)) {
> +                       if (needs_branch_stack(event)) {
> +                               riscv_pmu_ctr_consume(cpu_hw_evt, event);
> +                               perf_sample_save_brstack(
> +                                       &data, event,
> +
> &cpu_hw_evt->branches->branch_stack, NULL);
> +                       }
> +
>                         /*
>                          * Unlike other ISAs, RISC-V don't have to
> disable interrupts
>                          * to avoid throttling here. As per the
> specification, the
> @@ -1569,16 +1576,23 @@ static int rvpmu_deleg_ctr_get_idx(struct
> perf_event *event)
>
>  static void rvpmu_ctr_add(struct perf_event *event, int flags)
>  {
> +       if (needs_branch_stack(event))
> +               riscv_pmu_ctr_add(event);
>  }
>
>  static void rvpmu_ctr_del(struct perf_event *event, int flags)
>  {
> +       if (needs_branch_stack(event))
> +               riscv_pmu_ctr_del(event);
>  }
>
>  static void rvpmu_ctr_start(struct perf_event *event, u64 ival)
>  {
>         struct hw_perf_event *hwc = &event->hw;
>
> +       if (needs_branch_stack(event))
> +               riscv_pmu_ctr_enable(event);
> +
>         if (riscv_pmu_cdeleg_available() && !pmu_sbi_is_fw_event(event))
>                 rvpmu_deleg_ctr_start(event, ival);
>         else
> @@ -1593,6 +1607,9 @@ static void rvpmu_ctr_stop(struct perf_event
> *event, unsigned long flag)
>  {
>         struct hw_perf_event *hwc = &event->hw;
>
> +       if (needs_branch_stack(event) && flag != RISCV_PMU_STOP_FLAG_RESET)
> +               riscv_pmu_ctr_disable(event);
> +
>         if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
>             (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
>                 rvpmu_reset_scounteren((void *)event);
> @@ -1650,6 +1667,9 @@ static u32 rvpmu_find_ctrs(void)
>
>  static int rvpmu_event_map(struct perf_event *event, u64 *econfig)
>  {
> +       if (needs_branch_stack(event) && !riscv_pmu_ctr_valid(event))
> +               return -EOPNOTSUPP;
> +
>         if (riscv_pmu_cdeleg_available() && !pmu_sbi_is_fw_event(event))
>                 return rvpmu_cdeleg_event_map(event, econfig);
>         else
> @@ -1696,6 +1716,8 @@ static int rvpmu_starting_cpu(unsigned int cpu,
> struct hlist_node *node)
>                 enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
>         }
>
> +       riscv_pmu_ctr_starting_cpu();
> +
>         if (sbi_pmu_snapshot_available())
>                 return pmu_sbi_snapshot_setup(pmu, cpu);
>
> @@ -1710,6 +1732,7 @@ static int rvpmu_dying_cpu(unsigned int cpu,
> struct hlist_node *node)
>
>         /* Disable all counters access for user mode now */
>         csr_write(CSR_SCOUNTEREN, 0x0);
> +       riscv_pmu_ctr_dying_cpu();
>
>         if (sbi_pmu_snapshot_available())
>                 return pmu_sbi_snapshot_disable();
> @@ -1833,6 +1856,29 @@ static void riscv_pmu_destroy(struct riscv_pmu *pmu)
>         cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
>  }
>
> +static int branch_records_alloc(struct riscv_pmu *pmu)
> +{
> +       struct branch_records __percpu *tmp_alloc_ptr;
> +       struct branch_records *records;
> +       struct cpu_hw_events *events;
> +       int cpu;
> +
> +       if (!riscv_pmu_ctr_supported(pmu))
> +               return 0;
> +
> +       tmp_alloc_ptr = alloc_percpu_gfp(struct branch_records, GFP_KERNEL);
> +       if (!tmp_alloc_ptr)
> +               return -ENOMEM;
> +
> +       for_each_possible_cpu(cpu) {
> +               events = per_cpu_ptr(pmu->hw_events, cpu);
> +               records = per_cpu_ptr(tmp_alloc_ptr, cpu);
> +               events->branches = records;
> +       }
> +
> +       return 0;
> +}
> +
>  static void rvpmu_event_init(struct perf_event *event)
>  {
>         /*
> @@ -1845,6 +1891,9 @@ static void rvpmu_event_init(struct perf_event *event)
>                 event->hw.flags |= PERF_EVENT_FLAG_USER_ACCESS;
>         else
>                 event->hw.flags |= PERF_EVENT_FLAG_LEGACY;
> +
> +       if (branch_sample_call_stack(event))
> +               event->attach_state |= PERF_ATTACH_TASK_DATA;
>  }
>
>  static void rvpmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
> @@ -1992,6 +2041,15 @@ static int rvpmu_device_probe(struct
> platform_device *pdev)
>                 pmu->pmu.attr_groups = riscv_cdeleg_pmu_attr_groups;
>         else
>                 pmu->pmu.attr_groups = riscv_sbi_pmu_attr_groups;
> +
> +       ret = riscv_pmu_ctr_init(pmu);
> +       if (ret)
> +               goto out_free;
> +
> +       ret = branch_records_alloc(pmu);
> +       if (ret)
> +               goto out_ctr_finish;
> +
>         pmu->cmask = cmask;
>         pmu->ctr_add = rvpmu_ctr_add;
>         pmu->ctr_del = rvpmu_ctr_del;
> @@ -2008,6 +2066,10 @@ static int rvpmu_device_probe(struct
> platform_device *pdev)
>         pmu->csr_index = rvpmu_csr_index;
>         pmu->sched_task = pmu_sched_task;
>
> +       ret = cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING,
> &pmu->node);
> +       if (ret)
> +               goto out_ctr_finish;

This hotplug registration should be removed, since there is already
one in the original code.
Otherwise, It will cause the CPU hotplug down to loop infinitely.

Best regards,
Jimmy Ho

> +
>         ret = riscv_pm_pmu_register(pmu);
>         if (ret)
>                 goto out_unregister;
> @@ -2057,6 +2119,9 @@ static int rvpmu_device_probe(struct
> platform_device *pdev)
>  out_unregister:
>         riscv_pmu_destroy(pmu);
>
> +out_ctr_finish:
> +       riscv_pmu_ctr_finish(pmu);
> +
>  out_free:
>         kfree(pmu);
>         return ret;
>
> --
> 2.43.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
