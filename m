Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795102573;
	b=hE+4rXOh7/c7x5+iNykukAINRuN1NZW1MQpZXiStJwVrvPwuXFjgPpfBLjWbtyDCk8HF
	 /H3aN93dqOHX8ltTIUlC4iO6AMfasYdmhjHy6vBHT5b1bjADweba2+gKUf4hOXbAAWQnP
	 G5weqbkcSdlCBA7fKySoy09qsv+VCCl6eBbDuqc+GffRvhMBgokpIzo6sdm9ZxUau2ZVC
	 h9dk3t4yILvEo6lGCnnvqGUUsRXN6MFLQcfZdO2P+HlAbwtsTbziuvimcfXcBKEpiAmYm
	 oWzo2w3LFhUxHfe/bIF0S57r7Iwh1ExNZNoRw9hUyYeQeoSjg1glRKDjH2dKxfdYGUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795102573;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=WJfLh02jhGDmJ0EUFJgx7atkBkA7JgkXwKZPwWOi/vA=;
	b=5boRe/GDW2tCDhRK+ccXNt2dxU/WmHh7kdbklhOBFtqwy1mu5v6QYGp0oZPAABJs/UUP
	 5wH3MZ1pkv1UiRMOlsbXolxuJ8AuZcimyyIIvO4xKarjVRXUw/szU4+67zQVn7BTp+BfD
	 m/2SsxKVJhLhJrHbtZjszeiQS/7LTRwbm4eMNS7Ft9qg724bC0XHXfs5+iT73B0UVidLm
	 JDSOyownz8vSFYrNYRtcY6LMtGmu0wSlmnkzjjN5RGx1iMwgzb9XPGne/2I+uuyQpGTgC
	 bJuWk/0GVmSplDG13xH3xf9AZCel6ke8Q7uWYJ9D6vHinkynDEUcHjBkuoqBNWmJxYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=EB42BxVs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584DE60A2604
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 15:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 584DE60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=EB42BxVs
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-490d59c3edaso796668f8f.1
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 07:36:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795102571; cv=none;
        d=google.com; s=arc-20260327;
        b=bp1RAlIUf1P0K5/DiQjP/zOeOhuLT9ftUpEG+KI0OO3S3SYIJAs/MqwXinm/dEx6Se
         N2TC54Y1wuzqj5Q7vonlvviMCDEJmnQCDrUU4S+cVD+qrUNrP1/lrp5JHNZolesmUFkP
         TpvKjci4gVLXd2n9d67m9GaCT0dGE43giBNcAKeU/zYmxWQytAm8GTWnX+kQjpshXzAi
         vVtmGRd8nyRffpKdIkS7//gSXvc3vJiBRSCg+EaMygMcfb/CLntnMw9TadSed3kF8Lxi
         iyiudCd0vpSVvyR27oOQd2cI+h594kALaMMtfG8pkSlKxBBYmINAXl05MNz52e7kr8WN
         U4tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WJfLh02jhGDmJ0EUFJgx7atkBkA7JgkXwKZPwWOi/vA=;
        fh=O8yC++5JbO4bHgcW2H3BQJnWGB4CzeaWuxIXfohQSAc=;
        b=f+9+1TNMla6/zSaW799ZLPdGO/91I9BENHgknQQYPwh6TKOu9lXWQtl3kfGiz86Sd+
         +HN6dDWxBNMcqUdxi6uT502cNMUMsSCCeFkQ1qURNRX1IkBfE5aOaaGeECTulbHq2Gb2
         K99L/upH9ZUzYQh1hv4BQMBjqb4eguQzhm7kg2/uBnCAvvrl29BJdhAJ+7yf1v904uwb
         LhPxEkrFsQTMnHJ+LZ554PPJ+0UMBb3/PITtfe1uVSm+ItM+88zOh8kVLc4LsX4W6Nz4
         u0xsq0DJsvJSt10zB8qEiqOLYeGaWMc4ZlbYcimEJmbImeX+Wg0mDcM5/bjs/cHNrMZi
         CuXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1795102571; x=1795707371; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WJfLh02jhGDmJ0EUFJgx7atkBkA7JgkXwKZPwWOi/vA=;
        b=EB42BxVsZZZGwz8GB7/IKBSTcB8ml2fRDPaz8UU7g72siN7581xHFpSU5VR1RmuX5t
         azzltQ5eF9I5zrZPqq8qbxODS4zMBcbeQDUaOR4/ixQNHvbz/7mQ0ufUbm5WmkdGyFPA
         RUx3m48zHMG4yu/bCp7KjrvOca5QV2knDjj0jfAJuYrq1K1dESujxr9h6tFX9qWuIyWR
         SLF4PpMDGJaTnTIXM+phlG/iz/uTLmaixHOoQIQRNec58GQoGuH1cHoNIr1QE5O5qi1g
         4YG1iX8mOigmBLFq4TTDBFbWW4goy6aRInrR8pZpbB6LC5IEMUE+yPxtroNbX3s5c1uU
         XJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795102571; x=1795707371;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WJfLh02jhGDmJ0EUFJgx7atkBkA7JgkXwKZPwWOi/vA=;
        b=v2eIJ7g7Dviiu1fi8qUOis4fVCDcLocw+i/K+FZejaeydFAyzEZZi6KZ23CqSGxvE9
         8A5JbZ+4LGtPsHgYMfFSSqeiZYkTkd7ozA+XnWVsW3Dy1HbGwmdvlELNYj/tA5DMXQrq
         HfajPtYynTi92ldJHm3nIX0usH23xK6+jAThwjpJquj7w74wxVUNKCXBVvjR7kD9xnEq
         EMRSKR6E3fPPm6pntPP6JzsP7mK0TlIc12HgwtUrGwuQpY/Z0TPfu/2N5lef5h/1O2yq
         knrzYFbMNkRcKVCOO4tnn0fTF/bdnihgKPh/HjehotN3YDOEuuhwYT6/UgTQF1FN4Z8M
         KOuA==
X-Forwarded-Encrypted: i=1; AL+hErFM2Sui9ebDLJnvJyoq2FAL7neFeu8GniTBm2hgaHr7hjj/KGcYyrdsJ9ZV7aQIYzGeipuInxyb5z4w9V/Dw/x1@vger.kernel.org
X-Gm-Message-State: APuU4Z8MLZ9mM5TiFo8d145BKIw53dV9Kvx3lzo6ewqobAfoBAV09ebw
	Ed0Dl7x132uXWGkUcw7ETv607ndXnTqsa2WU/0vumlQbZL7ZazTh/0E8tAdXRzUnytFKwEUIvFI
	pGTPzDCFbxzUsQMTyfuW130XhMgdhJ0Qtaj2W20sXMw==
X-Gm-Gg: AZFdTZcmE6paC7GXSQIRbOjWW2lei4HC8E5ZxLTyWhZhG0/0Iyt7Cjl/8tY390VUQCo
	dNkYezBuXob+xxPGMyI8Rm1He9AkujufmUezupZs//tCvrTO/SR9vrai/lPhBTR6xXP+txQop1y
	cvZbEeYPdD1LLfSVi6yQWw24O8Ipb70ReOR35lmkYml7e4L8OB3u6OgybtWcNODSpMQW398Ud1y
	hkUMaKTPHXSDaT9sKB+EVsLRXtl1r3Dmw5rmKB4+26JNKE9xgxsVdZvmfGP8fw/Tn0DBF9qDFaD
	Uj9eT2EE0/d6cvo9N9QA6l3lz3gs0pAmE9rBRNF9FCrG5EG9ec0xWglnbR7kPgouFep95KBHS6p
	Pu3w63ge9w13C2rmoVGq5xHm/+7ZY06tX+8iCnyjwV9ONkNoqjk5h614TjSvSbkp/t4QVif6BBi
	ni7b2wjnJqYam6XXajbt3Z2a+jjuMN9bRxZjRJndulk0L6OnKNUO167nE=
X-Received: by 2002:a05:6000:2903:b0:491:c392:1f31 with SMTP id
 ffacd0b85a97d-4aa5ab788d1mr3852229f8f.28.1795102571521; Thu, 19 Nov 2026
 07:36:11 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118095053.3871267-1-vikram.singh3@oss.qualcomm.com> <20261118095053.3871267-7-vikram.singh3@oss.qualcomm.com>
In-Reply-To: <20261118095053.3871267-7-vikram.singh3@oss.qualcomm.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 19 Nov 2026 21:05:59 +0530
X-Gm-Features: Aa3M54rnDKWA8w7Y4rJmmE_fS3tPOuMM_ZzdffiEjwoFDQtL4x53zCglx7T-XA4
Message-ID: <CAAhSdy1sQcepYMT52e211e9nKTwDA8FXC1P2KhTAjU8rTYQTzg@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] riscv: pmu: Integrate CTR Ext support in
 riscv_pmu_dev driver
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
> Co-developed-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
> Signed-off-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
> Signed-off-by: Vikram Singh <vikram.singh3@oss.qualcomm.com>
> Link: https://lore.kernel.org/r/20261106173942.3175069-7-vikram.singh3@os=
s.qualcomm.com
> Signed-off-by: Anup Patel <anup@brainfault.org>

As mentioned in PATCH1, drop the "Link:" and the subsequent
"Signed-off-by:" lines.

> ---
>  drivers/perf/riscv_pmu.c     |  2 +-
>  drivers/perf/riscv_pmu_sbi.c | 72 ++++++++++++++++++++++++++++++++++--
>  2 files changed, 70 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> index d4826eb73b16..fa9ae4e659d2 100644
> --- a/drivers/perf/riscv_pmu.c
> +++ b/drivers/perf/riscv_pmu.c
> @@ -327,7 +327,7 @@ static int riscv_pmu_event_init(struct perf_event *ev=
ent)
>         uint64_t cmask;
>
>         /* driver does not support branch stack sampling */
> -       if (has_branch_stack(event))
> +       if (has_branch_stack(event) && !riscv_pmu_ctr_supported(rvpmu))
>                 return -EOPNOTSUPP;
>
>         hwc->flags =3D 0;
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index b14b3acf7567..637b9d97e20a 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -678,6 +678,9 @@ static int pmu_sbi_event_map(struct perf_event *event=
, u64 *econfig)
>          */
>         flush_work(&check_std_events_work);
>
> +       if (needs_branch_stack(event) && !riscv_pmu_ctr_valid(event))
> +               return -EOPNOTSUPP;
> +
>         return riscv_pmu_get_event_info(type, config, econfig);
>  }
>
> @@ -827,10 +830,14 @@ static void pmu_sbi_reset_scounteren(void *arg)
>
>  static void pmu_sbi_ctr_add(struct perf_event *event, int flags)
>  {
> +       if (needs_branch_stack(event))
> +               riscv_pmu_ctr_add(event);
>  }
>
>  static void pmu_sbi_ctr_del(struct perf_event *event, int flags)
>  {
> +       if (needs_branch_stack(event))
> +               riscv_pmu_ctr_del(event);
>  }
>
>  static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
> @@ -847,6 +854,10 @@ static void pmu_sbi_ctr_start(struct perf_event *eve=
nt, u64 ival)
>         ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, hwc->id=
x,
>                         1, flag, ival);
>  #endif
> +
> +       if (needs_branch_stack(event))
> +               riscv_pmu_ctr_enable(event);
> +
>         if (ret.error && (ret.error !=3D SBI_ERR_ALREADY_STARTED))
>                 pr_err("Starting counter idx %d failed with error %d\n",
>                         hwc->idx, sbi_err_map_linux_errno(ret.error));
> @@ -864,6 +875,9 @@ static void pmu_sbi_ctr_stop(struct perf_event *event=
, unsigned long flag)
>         struct cpu_hw_events *cpu_hw_evt =3D this_cpu_ptr(pmu->hw_events)=
;
>         struct riscv_pmu_snapshot_data *sdata =3D cpu_hw_evt->snapshot_ad=
dr;
>
> +       if (needs_branch_stack(event) && flag !=3D RISCV_PMU_STOP_FLAG_RE=
SET)
> +               riscv_pmu_ctr_disable(event);
> +
>         if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
>             (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
>                 pmu_sbi_reset_scounteren((void *)event);
> @@ -896,7 +910,7 @@ static void pmu_sbi_ctr_stop(struct perf_event *event=
, unsigned long flag)
>  static void pmu_sbi_sched_task(struct perf_event_pmu_context *pmu_ctx, s=
truct task_struct *task,
>                                bool sched_in)
>  {
> -       /* Call CTR specific Sched hook. */
> +       riscv_pmu_ctr_sched_task(pmu_ctx, task, sched_in);
>  }
>
>  static int pmu_sbi_find_num_ctrs(void)
> @@ -1179,6 +1193,12 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, vo=
id *dev)
>                 hw_evt->state |=3D PERF_HES_UPTODATE;
>                 perf_sample_data_init(&data, 0, hw_evt->last_period);
>                 if (riscv_pmu_event_set_period(event)) {
> +                       if (needs_branch_stack(event)) {
> +                               riscv_pmu_ctr_consume(cpu_hw_evt, event);
> +                               perf_sample_save_brstack(&data, event,
> +                                                        &cpu_hw_evt->bra=
nches->branch_stack, NULL);
> +                       }
> +
>                         /*
>                          * Unlike other ISAs, RISC-V don't have to disabl=
e interrupts
>                          * to avoid throttling here. As per the specifica=
tion, the
> @@ -1222,6 +1242,8 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, s=
truct hlist_node *node)
>                 enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
>         }
>
> +       riscv_pmu_ctr_starting_cpu();
> +
>         if (sbi_pmu_snapshot_available())
>                 return pmu_sbi_snapshot_setup(pmu, cpu);
>
> @@ -1237,6 +1259,8 @@ static int pmu_sbi_dying_cpu(unsigned int cpu, stru=
ct hlist_node *node)
>         /* Disable all counters access for user mode now */
>         csr_write(CSR_SCOUNTEREN, 0x0);
>
> +       riscv_pmu_ctr_dying_cpu();
> +
>         if (sbi_pmu_snapshot_available())
>                 return pmu_sbi_snapshot_disable();
>
> @@ -1367,7 +1391,30 @@ static void riscv_pmu_destroy(struct riscv_pmu *pm=
u)
>                 cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING,=
 &pmu->node);
>  }
>
> -static void pmu_sbi_event_init(struct perf_event *event)
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
> +       tmp_alloc_ptr =3D alloc_percpu_gfp(struct branch_records, GFP_KER=
NEL);
> +       if (!tmp_alloc_ptr)
> +               return -ENOMEM;
> +
> +       for_each_possible_cpu(cpu) {
> +               events =3D per_cpu_ptr(pmu->hw_events, cpu);
> +               records =3D per_cpu_ptr(tmp_alloc_ptr, cpu);
> +               events->branches =3D records;
> +       }
> +
> +       return 0;
> +}
> +
> +static int pmu_sbi_event_init(struct perf_event *event)
>  {
>         /*
>          * The permissions are set at event_init so that we do not depend
> @@ -1379,6 +1426,11 @@ static void pmu_sbi_event_init(struct perf_event *=
event)
>                 event->hw.flags |=3D PERF_EVENT_FLAG_USER_ACCESS;
>         else
>                 event->hw.flags |=3D PERF_EVENT_FLAG_LEGACY;
> +
> +       if (branch_sample_call_stack(event))
> +               event->attach_state |=3D PERF_ATTACH_TASK_DATA;
> +
> +       return 0;
>  }
>
>  static void pmu_sbi_event_mapped(struct perf_event *event, struct mm_str=
uct *mm)
> @@ -1516,9 +1568,16 @@ static int pmu_sbi_device_probe(struct platform_de=
vice *pdev)
>                 pmu->pmu.capabilities |=3D PERF_PMU_CAP_NO_EXCLUDE;
>         }
>         irq_requested =3D (ret =3D=3D 0);
> -
>         pmu->pmu.attr_groups =3D riscv_pmu_attr_groups;
>         pmu->pmu.parent =3D &pdev->dev;
> +       ret =3D riscv_pmu_ctr_init(pmu);
> +       if (ret)
> +               goto out_free;
> +
> +       ret =3D branch_records_alloc(pmu);
> +       if (ret)
> +               goto out_ctr_finish;
> +
>         bitmap_copy(pmu->cmask, cmask, RISCV_MAX_COUNTERS);
>         pmu->ctr_add =3D pmu_sbi_ctr_add;
>         pmu->ctr_del =3D pmu_sbi_ctr_del;
> @@ -1535,6 +1594,10 @@ static int pmu_sbi_device_probe(struct platform_de=
vice *pdev)
>         pmu->csr_index =3D pmu_sbi_csr_index;
>         pmu->sched_task =3D pmu_sbi_sched_task;
>
> +       ret =3D cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &p=
mu->node);
> +       if (ret)
> +               goto out_ctr_finish;
> +
>         ret =3D riscv_pm_pmu_register(pmu);
>         if (ret)
>                 goto out_destroy;
> @@ -1592,6 +1655,9 @@ static int pmu_sbi_device_probe(struct platform_dev=
ice *pdev)
>                 riscv_pmu_irq =3D 0;
>         }
>
> +out_ctr_finish:
> +       riscv_pmu_ctr_finish(pmu);
> +
>  out_free:
>         free_percpu(pmu->hw_events);
>         kfree(pmu_ctr_list);
> --
> 2.43.0
>

Regards,
Anup
