Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075DD239099
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Dec 2025 03:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764820630; cv=none; b=tvBDsUJz24NudNeJ80k60Ns+ujJNqrqAu8lx+ZwyrnwJ8Q6P5Gy90NWdZgGrj/cl6aSE6NsvDt4Lcop6ygDf8UIo09XQGNR38XnqHY7WEuObgC9OKznmsLW52t7CDhe/GpAHV6zpp7VkYOehzEnTLYxJoyGhMoPWfK0LpmOgVRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764820630; c=relaxed/simple;
	bh=zX9c7chYV7gXxEqwc4tFXZ6Sy0C+BBq2PqMRcTvKGFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=P93irNrWL9wSYdOcOmFOLTrdVAPQP6L4Xq69fvq+xuwK9u44x2iuiaISyOwvjYBc1yWhBCBkSBVzgXqmkY+FqRKnFRNPnVWQHSLni5GHbm2/PGQ0/GFmdwWFyPUsjw+4+xVC/A9/zsI2K9GPNQY0hDvsKDTkO2V3wtk6Rjh2UPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=LOlgPQWn; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LOlgPQWn"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42e2e77f519so389189f8f.2
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Dec 2025 19:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1764820625; x=1765425425; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=okWEC/iPxwHapBCL3ZZGyYvTBzssGUbkrGoBgDrV58Y=;
        b=LOlgPQWnKP2dVzXcuRxKl2zOPMbSWIWboRuiIq9V/Fy6btFm3YKZXGu6kGIkSD4Mvb
         1wAMhVHfJbkP0IQHLPbN/NjjKXUqjgHwPaOnTz+kW3OduTa6k36FyHrrVj4vaVgE8IlH
         70Eqpe7O8XqV8gFt+ADQzMsFYwV6KH3oOd7ussyD5P1wSQzmJ7rL1ZDwLGCkc22ru6an
         AUCNURGgKjtgvNfpnZDisQaq3yeiCqIkJAZ+fcRWpajgtbVRl2dYn0kxoD6YjQbAX/nm
         OOW5ox4jzYeP1TazTpwrwknqPZtmES+AjAYhsrUI7xOJEYnEsz/0+HBU9r/NGxOkj+tu
         YcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764820625; x=1765425425;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=okWEC/iPxwHapBCL3ZZGyYvTBzssGUbkrGoBgDrV58Y=;
        b=A+BbFbNW5FklEjtjf6hZMZZOFonCvw+0JOGvI9e++4LSbZLe3CdXp061x1tltkfwCz
         B0geJNqVqdZvaoLoEjy+/Za97voza8I/0y79msTDghSprWc05lfO+9FUbH/nywrISFH5
         PfkcuUq+Y3Wf4MU8NFh2CwBoPcZ3G7kBgq9In3sO9AxjMBzCqVTCXIOhYlTbObkdEv28
         yM9kG7uP6zKPpyW/a9bVsrEBDzbfGHnL6MhcUMWvkHC02UbAHpCs1BIUUgwsEBj0ykxN
         ReAzftgM1V7azXZyCGBlawmV+JLYIQSS11YlENfzjiYt3rB9EXx1FN1/qKhSjh6/YplV
         SZVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXheTffZVUD1SRyS0Q1sggDD8E1uEYdmkG1VuEAs76Jrdbir0TWsKMckhq4nAmRGAzXm/l2bw16QWwRCovfxqi8@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp9RQbNRtGGF6qoZqRGodoay/lCN9DAMOLluPMUwpvWdUCsEPb
	b4JFWmd/PAkgbifkdo9N+/BG0GZGICp0TErEgFyg+pwBpaFd0IH7LyomtDn6yaF2xKy9WOeBXlj
	2AkuD6UDb7EOFjPVY7pwvRHQn5/Uw3y5/GL6N1QTV0w==
X-Gm-Gg: ASbGnctTos+S1Dd/lHejhS22R2kwtIpQtZo/lBu9l9uQbHpKpCEXUKRwU/kTmeMqlFe
	hfJ81JbhQWpZLfsnrBB+xUS7RlHM8cKbOrttgY352dAHP7UE/fOJcXvJ3EVj1aRMXfO0po/v3gZ
	mgLvjqpANN7khKHldgUD0JXLXoOD//yXG7AUakGGXugQimO75+7FpPoo0WDrJSr7CZKRC2Q0umo
	oyXZUYqF1bGHbR5uoqcGjH3cwJRsPr3aXTp0kBr7o44O7yq5ORvoKel+U1yICI6nuotFcvIUQ==
X-Google-Smtp-Source: AGHT+IEY7s+3eyCqfIKSZqMakE7dNGsLTPhL1IL5G66m9i8O6D+WqBplrxA/nvb3Sc8t+ks/VUJVjaMiah5FHZONyPw=
X-Received: by 2002:a05:6000:4212:b0:42b:3dfb:645f with SMTP id
 ffacd0b85a97d-42f79858038mr1000158f8f.47.1764820624734; Wed, 03 Dec 2025
 19:57:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523-b4-ctr_upstream_v3-v3-0-ad355304ba1c@rivosinc.com>
 <20250523-b4-ctr_upstream_v3-v3-6-ad355304ba1c@rivosinc.com> <CAPqJEFr=3Re=L0CmEpCRHxovB74MDB9C8neNMfouYvWWbR0hyw@mail.gmail.com>
In-Reply-To: <CAPqJEFr=3Re=L0CmEpCRHxovB74MDB9C8neNMfouYvWWbR0hyw@mail.gmail.com>
From: Jimmy Ho <jimmy.ho@sifive.com>
Date: Thu, 4 Dec 2025 11:56:53 +0800
X-Gm-Features: AWmQ_blU2yYn2rCdC2QKjaMEY5Jg5LSw32Q3EJYwEkvkceud3D2wmUV5r3WnXKM
Message-ID: <CAJh9TSJk0nZvqJrvTe5ENMpAB=56--+CFai0tXQnYFakKxQxQw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] riscv: pmu: Integrate CTR Ext support in
 riscv_pmu_dev driver
To: "To: Peter Zijlstra" <peterz@infradead.org>, mingo@redhat.com, 
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
