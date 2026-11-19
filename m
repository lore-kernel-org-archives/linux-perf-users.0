Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795102041;
	b=2kkOPj4mFzE0eHkhF3nO3TZWE+0LXaD+ZuAIqBsJKOdhwo/lWsdjXUDjS36oi1ucZC/9
	 LgrLw7nCjuNkze9/7S8y8VK4fD1xVje1DLUlhxhEbX5pW4yj/OKJX0HnHpI92hV5/MCBm
	 /v4ZNdPGf+KqKhK17st/NfflhDolyAP+xo9YkodWJuWmYu3fsTu+Gn3JAJ73ASWgxjY4G
	 fUcWU8i5AVuhtHQ0oxQhO7V0YiwG1+/4QvCQ1yh7XIGAFo1QEMUX3nTPvdCYRemAWKltx
	 dqsRwe9Dfia4eU0OxnlxykMrPNPeMpkS4DjJ6R88gzTP5VfraxZhbmaVz3ooGOMeQXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795102041;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CZqy6xFABQEyD7CGf6Z9ErvSDunlUYlFbbHfyyFxeho=;
	b=R4LSsXTqZhEMil2kev0mE1gdxreAltGWEg1xVkoMk+FR6NtE6w8n5M68UJ7s4RHUVVaE
	 Q6znwFwVqjANeLiLCfp8/DLIi8ucgOj/UlUX/2HEiI7/rESX9NX3lyhzC6GePHrFDj9ZL
	 k8KQQQqeOEKh8Vz48OMI+4C270P2jncItK1rjRfU5oP651iblJuN4PL2Yc46qgdWWJ3X2
	 znKP5NSqmsCQGsb6RIK8iM4R/ba2eprDgwwm0NUC+CjXbv7Nc/qkcldNKh70yIQjtTXlg
	 HKm0r6ex01us3sxtROVEs+krNTSOEod8S0E2+uZQsWkmN6Zzz+jeRTWcjI3lqdXnDIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=qsbv9f9X;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52A0606A325
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 15:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C52A0606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=qsbv9f9X
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so19021005e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 07:27:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795102039; cv=none;
        d=google.com; s=arc-20260327;
        b=cutcG6/LeE8tUMbgCrC2KXtm8k9MOo+da1hnNKEAo0HWFqVCmrk6BhMRnW6hKiciSV
         5a91T26yHsEt5t9psrhy+UJ6VxqzY3i1cwnUbQrVtQ4+NJgQ0LP+jJKxCTQueKuorXdG
         ZzI37QcPN2KXbVbYVAtIPuqBnESW3cWjj6z5wORXWfElLQifjoqHts568E0a9agPoXLJ
         woLQxxAHlynbn9YK3Cb5QfSrxZhb9jBjVdL2Zy0nX5cthF9+0jbB2QXAGiVRWOj/vJ2+
         sf6f1XPSWYjM4zzAp7CGEk/97KD3bbCzdGvw9Txhmc44WdFBSc5I3hThztqEXJH8vBxW
         9bbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CZqy6xFABQEyD7CGf6Z9ErvSDunlUYlFbbHfyyFxeho=;
        fh=TEQGGEsP7hxGamzfdGV9eiTkWIsYyzGRdkFH6P3J3Rg=;
        b=s+1uirzGLPEsEqz/dYTV/HtXX5GuT4rRDA8whfoiPFXG5q65OGOGHrwcjefozdUQZJ
         3EYPWP1gxYGaPvsPlLoMFQxiIwdcJchPwrz07DnfiXHkpuqncrXBHc5rSFFFnWYGzcZo
         6hKNcVZh2XiNOyLjqLpjKELwkxH/lzV7ZH9XwE4oHoUAK2NTBc/E1o5ibrlFAzXmpHB3
         JiBp7iCpoZqbIuIEE0wjlAVjI4Uk2OALfzF5ctteZBUJThqwrvbYfJOPyE0+DUdo9r0g
         UdAZV+i5i02dne58sZDVbAeoigjbPmP199YVtU2nUP9qOVGd9U+lDOMkJUlYmoWPJzNJ
         OMOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1795102039; x=1795706839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CZqy6xFABQEyD7CGf6Z9ErvSDunlUYlFbbHfyyFxeho=;
        b=qsbv9f9XlOjyM4QYFAOG4kMPWUZNb7q33N3+H96WjvHAPHCwDqiOYPU2UKXxDTpEY6
         CUSiHzoSCXhgbFTfH8oifUg21xSy4aPUsqivVz/oln67NWpD0vRUlfZ8J0t6dsRBpwA7
         IujGAro2KlwijgWpnnxP49TK+YWproFDYYkFzcSgrJNuv6vz6xsq/vpUt4gfOxTqBYM4
         qHJLuD02qWtnIRji8am8zmkFeliHdOUXzKNnA62vq+XeRalRWoFisI0j/Gbdtgww7ZcU
         qdY7GUlh+bgyhHVJzq1IjXuOPADDOpyEifpClv+9SPAuTjqdnQn4rnKn5NDkzF3+SEfJ
         c2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795102039; x=1795706839;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CZqy6xFABQEyD7CGf6Z9ErvSDunlUYlFbbHfyyFxeho=;
        b=pPY4II7vrITqwr/t9iZJODwnMEcPqLFkjUtBsBCaF4pWQG3d6fuee3vNGSC6A3/ose
         VkxINcfew3rjP7csD9lnUugj/UdQkPg/9KmWLQOJneTTXBnuDcQyTcw53kFRGb8NWdXC
         NRyklQvxjZfjD+OqFOHn55APSIMQg5uD87Ud/I58j4zv59JIP+QxiCoIYqGNxQcMUjbj
         O1lTERXXBiM/Jkw7oqsUOG2ryQuaQ3O4yiiccEfdWvARFpbx9yZHL1k31w8c69rq70ZS
         ZerJtqofTxqSQ8doOSlDPkX2k22jyNIuLELbpN0avhIZ9Xb1sEMvCu79cMlMVcJM9q13
         F7eg==
X-Forwarded-Encrypted: i=1; AL+hErG15SluV00QXKvYXDev6dGavLRRyv+ejGeiLr4CkJZLvwaKpA3yBcPtoPD2+gp+BP5+YbdHPhDKW0T1NVG8VL4m@vger.kernel.org
X-Gm-Message-State: APuU4Z+PGz1ziRFzCb7IvuDdSFsQhEispM4tzUDpEC1+JFaGU0rHMp0u
	ix0QGiufSYRMp279npz7evtPtQH3KZcQWFcV+jsERZ/Cbtkb9nO9er7eaHnHp07YNGqWS65RAEK
	uF7sYd7CzOauZBgKX6ngTh4gUPZg6hd/I4x+XbmimOQ==
X-Gm-Gg: AYBFou1w3ZTPeTxHM0eYrjAm4uRV/3YzT4x2EW1+aocC65mqjYuPMCIggW42VdYbUAl
	7AzUks7BlxgZrpBIs6qa4AHYxmlqzTSFpgE9YPQ34wfYip32TeTEjt6D6gCqSCOiBxP/nQCoovd
	nYZ7tVhWVF8F2Qe1XKBTG9cEV2IK6SL38Gj43R92OBzJ85lePFw3oVzkIrenoLsVBZMdWUVlZ+n
	tygHpJPBBEqYISmxnQm3UVLbgvDQLm+pAYrbopVd+hOw3RoBX44CAGsEIZsW2jQiLpmRAA7h1zu
	M6Qok+v8UQIOAgg/xGh3rK7t1g8b4X5gGc/QyUF7HCUkxtuYAsTkYrwYZ1rrWmEhcMCBHrnKxee
	XHzAR1ztY/ju+K2P0r+w5jbDGU6P8ph6jZQUvUW3bYg5hSkJsy70m5YL26o+JDaNFjpTN5vHKkM
	JApr6HkGYEJr1epJPzTVc7n1tntHpWHn3XMypxPIv72DlR78Ao96hkvf4=
X-Received: by 2002:a05:600c:154a:b0:4bb:6b6b:fbaa with SMTP id
 5b1f17b1804b1-4bb7da12ab1mr128048755e9.16.1795102039017; Thu, 19 Nov 2026
 07:27:19 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118095053.3871267-1-vikram.singh3@oss.qualcomm.com> <20261118095053.3871267-5-vikram.singh3@oss.qualcomm.com>
In-Reply-To: <20261118095053.3871267-5-vikram.singh3@oss.qualcomm.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 19 Nov 2026 20:57:07 +0530
X-Gm-Features: Aa3M54rZEbG4RNdS6O1BRxLO3kDHI5P1qMQJ1pxxqQiXGApFrfCV5-bLcT-cUmk
Message-ID: <CAAhSdy1fx4uJJTTamoyOjojh+ApdZmPVh9nd==NcfM6fTCoOvQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] riscv: pmu: Add infrastructure for Control
 Transfer Record
To: Vikram Singh <vikram.singh3@oss.qualcomm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, atishp@rivosinc.com, anup.patel@oss.qualcomm.com, 
	will@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	beeman@rivosinc.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Conor Dooley <conor@kernel.org>, 
	devicetree@vger.kernel.org, Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 3:21=E2=80=AFPM Vikram Singh
<vikram.singh3@oss.qualcomm.com> wrote:
>
> To support Control Transfer Records (CTR) extension, we need to extend th=
e
> riscv_pmu framework with some basic infrastructure for branch stack
> sampling. Subsequent patches will use this to add support for CTR in the
> riscv_pmu_dev driver.
>
> With CTR, the branches are stored into a hardware FIFO, which will be
> sampled by software when perf events overflow. A task may be
> context-switched between overflows, and to avoid leaking samples we need
> to clear the last task's records when a task is context-switched in.
> To do this we will be using the pmu::sched_task() callback added in this
> patch.
>
> Co-developed-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
> Signed-off-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
> Signed-off-by: Vikram Singh <vikram.singh3@oss.qualcomm.com>
> Link: https://lore.kernel.org/r/20261106173942.3175069-5-vikram.singh3@os=
s.qualcomm.com
> Signed-off-by: Anup Patel <anup@brainfault.org>

As mentioned in PATCH1, drop the "Link:" and the subsequent
"Signed-off-by:" lines.

> ---
>  drivers/perf/riscv_pmu.c        | 19 +++++++++++++++++++
>  drivers/perf/riscv_pmu_legacy.c |  2 ++
>  drivers/perf/riscv_pmu_sbi.c    | 17 +++++++++++++++++
>  include/linux/perf/riscv_pmu.h  | 23 +++++++++++++++++++++--
>  4 files changed, 59 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> index 8e3cd0f35336..d4826eb73b16 100644
> --- a/drivers/perf/riscv_pmu.c
> +++ b/drivers/perf/riscv_pmu.c
> @@ -157,6 +157,19 @@ u64 riscv_pmu_ctr_get_width_mask(struct perf_event *=
event)
>         return GENMASK_ULL(cwidth, 0);
>  }
>
> +static void riscv_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx,=
 struct task_struct *task,
> +                                bool sched_in)
> +{
> +       struct riscv_pmu *pmu;
> +
> +       if (!pmu_ctx)
> +               return;
> +
> +       pmu =3D to_riscv_pmu(pmu_ctx->pmu);
> +       if (pmu->sched_task)
> +               pmu->sched_task(pmu_ctx, task, sched_in);
> +}
> +
>  u64 riscv_pmu_event_update(struct perf_event *event)
>  {
>         struct riscv_pmu *rvpmu =3D to_riscv_pmu(event->pmu);
> @@ -269,6 +282,8 @@ static int riscv_pmu_add(struct perf_event *event, in=
t flags)
>         cpuc->events[idx] =3D event;
>         cpuc->n_events++;
>         hwc->state =3D PERF_HES_UPTODATE | PERF_HES_STOPPED;
> +       if (rvpmu->ctr_add)
> +               rvpmu->ctr_add(event, flags);
>         if (flags & PERF_EF_START)
>                 riscv_pmu_start(event, PERF_EF_RELOAD);
>
> @@ -290,6 +305,8 @@ static void riscv_pmu_del(struct perf_event *event, i=
nt flags)
>         if (rvpmu->ctr_stop)
>                 rvpmu->ctr_stop(event, RISCV_PMU_STOP_FLAG_RESET);
>         cpuc->n_events--;
> +       if (rvpmu->ctr_del)
> +               rvpmu->ctr_del(event, flags);
>         if (rvpmu->ctr_clear_idx)
>                 rvpmu->ctr_clear_idx(event);
>         perf_event_update_userpage(event);
> @@ -402,6 +419,7 @@ struct riscv_pmu *riscv_pmu_alloc(void)
>         for_each_possible_cpu(cpuid) {
>                 cpuc =3D per_cpu_ptr(pmu->hw_events, cpuid);
>                 cpuc->n_events =3D 0;
> +               cpuc->ctr_users =3D 0;
>                 for (i =3D 0; i < RISCV_MAX_COUNTERS; i++)
>                         cpuc->events[i] =3D NULL;
>                 cpuc->snapshot_addr =3D NULL;
> @@ -416,6 +434,7 @@ struct riscv_pmu *riscv_pmu_alloc(void)
>                 .start          =3D riscv_pmu_start,
>                 .stop           =3D riscv_pmu_stop,
>                 .read           =3D riscv_pmu_read,
> +               .sched_task     =3D riscv_pmu_sched_task,
>         };
>
>         return pmu;
> diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_leg=
acy.c
> index 1b8e4789cb3c..5214e90c61a6 100644
> --- a/drivers/perf/riscv_pmu_legacy.c
> +++ b/drivers/perf/riscv_pmu_legacy.c
> @@ -115,6 +115,8 @@ static void pmu_legacy_init(struct riscv_pmu *pmu)
>         set_bit(RISCV_PMU_LEGACY_INSTRET, pmu->cmask);
>         pmu->ctr_start =3D pmu_legacy_ctr_start;
>         pmu->ctr_stop =3D NULL;
> +       pmu->ctr_add =3D NULL;
> +       pmu->ctr_del =3D NULL;
>         pmu->event_map =3D pmu_legacy_event_map;
>         pmu->ctr_get_idx =3D pmu_legacy_ctr_get_idx;
>         pmu->ctr_get_width =3D pmu_legacy_ctr_get_width;
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 21a2078eab98..b14b3acf7567 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -825,6 +825,14 @@ static void pmu_sbi_reset_scounteren(void *arg)
>                           csr_read(CSR_SCOUNTEREN) & ~BIT(pmu_sbi_csr_ind=
ex(event)));
>  }
>
> +static void pmu_sbi_ctr_add(struct perf_event *event, int flags)
> +{
> +}
> +
> +static void pmu_sbi_ctr_del(struct perf_event *event, int flags)
> +{
> +}
> +
>  static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
>  {
>         struct sbiret ret;
> @@ -885,6 +893,12 @@ static void pmu_sbi_ctr_stop(struct perf_event *even=
t, unsigned long flag)
>         }
>  }
>
> +static void pmu_sbi_sched_task(struct perf_event_pmu_context *pmu_ctx, s=
truct task_struct *task,
> +                              bool sched_in)
> +{
> +       /* Call CTR specific Sched hook. */
> +}
> +
>  static int pmu_sbi_find_num_ctrs(void)
>  {
>         struct sbiret ret;
> @@ -1506,6 +1520,8 @@ static int pmu_sbi_device_probe(struct platform_dev=
ice *pdev)
>         pmu->pmu.attr_groups =3D riscv_pmu_attr_groups;
>         pmu->pmu.parent =3D &pdev->dev;
>         bitmap_copy(pmu->cmask, cmask, RISCV_MAX_COUNTERS);
> +       pmu->ctr_add =3D pmu_sbi_ctr_add;
> +       pmu->ctr_del =3D pmu_sbi_ctr_del;
>         pmu->ctr_start =3D pmu_sbi_ctr_start;
>         pmu->ctr_stop =3D pmu_sbi_ctr_stop;
>         pmu->event_map =3D pmu_sbi_event_map;
> @@ -1517,6 +1533,7 @@ static int pmu_sbi_device_probe(struct platform_dev=
ice *pdev)
>         pmu->event_mapped =3D pmu_sbi_event_mapped;
>         pmu->event_unmapped =3D pmu_sbi_event_unmapped;
>         pmu->csr_index =3D pmu_sbi_csr_index;
> +       pmu->sched_task =3D pmu_sbi_sched_task;
>
>         ret =3D riscv_pm_pmu_register(pmu);
>         if (ret)
> diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pm=
u.h
> index ecaa40370830..c748a06ad751 100644
> --- a/include/linux/perf/riscv_pmu.h
> +++ b/include/linux/perf/riscv_pmu.h
> @@ -28,6 +28,15 @@
>
>  #define RISCV_PMU_CONFIG1_GUEST_EVENTS 0x1
>
> +struct sse_event;
> +

Drop this forward declaration of "struct sse_event" and the
subsequent newline.

> +#define MAX_BRANCH_RECORDS 256
> +
> +struct branch_records {
> +       struct perf_branch_stack branch_stack;
> +       struct perf_branch_entry branch_entries[MAX_BRANCH_RECORDS];
> +};
> +
>  struct cpu_hw_events {
>         /* currently enabled events */
>         int                     n_events;
> @@ -47,6 +56,11 @@ struct cpu_hw_events {
>         bool snapshot_set_done;
>         /* A shadow copy of the counter values to avoid clobbering during=
 multiple SBI calls */
>         u64 snapshot_cval_shcopy[RISCV_MAX_COUNTERS];
> +       /* Saved branch records. */
> +       struct branch_records *branches;
> +

Drop the redundant newline.

> +       /* Active events requesting branch records */
> +       int ctr_users;
>  };
>
>  struct riscv_pmu {
> @@ -60,17 +74,22 @@ struct riscv_pmu {
>         int             (*ctr_get_idx)(struct perf_event *event);
>         int             (*ctr_get_width)(int idx);
>         void            (*ctr_clear_idx)(struct perf_event *event);
> +       void            (*ctr_add)(struct perf_event *event, int flags);
> +       void            (*ctr_del)(struct perf_event *event, int flags);
>         void            (*ctr_start)(struct perf_event *event, u64 init_v=
al);
>         void            (*ctr_stop)(struct perf_event *event, unsigned lo=
ng flag);
>         int             (*event_map)(struct perf_event *event, u64 *confi=
g);
> -       void            (*event_init)(struct perf_event *event);
> +       int             (*event_init)(struct perf_event *event);
>         void            (*event_mapped)(struct perf_event *event, struct =
mm_struct *mm);
>         void            (*event_unmapped)(struct perf_event *event, struc=
t mm_struct *mm);
>         uint8_t         (*csr_index)(struct perf_event *event);
> -
> +       void            (*sched_task)(struct perf_event_pmu_context *ctx,=
 struct task_struct *task,
> +                                     bool sched_in);
>         struct cpu_hw_events    __percpu *hw_events;
>         struct hlist_node       node;
>         struct notifier_block   riscv_pm_nb;
> +
> +       unsigned int    ctr_depth;
>  };
>
>  #define to_riscv_pmu(p) (container_of(p, struct riscv_pmu, pmu))
> --
> 2.43.0
>

Regards,
Anup
