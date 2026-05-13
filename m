Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C953D19C542
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 00:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778631979; cv=pass; b=c3nuJ4N8M0tMn1n8AmG1e9xVHL/M8mqXylocz8jnY/8rbfPmBp49M6FnVyIrzAmxaJB6YA25PsBW1DpjcZ/uPaQuI0LQwfjiwREUNuTH4jIDKVBgSDm+lC39jd2trk8ire8EvK4D5rq7AztL7zYLX10jWCpBPlsDfhj9y+51s1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778631979; c=relaxed/simple;
	bh=jI137UNr0cKFagcpEdMVEfbzdjWinSTLpnYGNuSWtN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hsxPoKQkvfsG/V7MxmeMnlLG6awL9ZZaNTQmV4BbzHZjHDh05LGTvBLl+oxV61JyxkZATWGYUQTUpQJ8PisYkrDzsEk03WebImbtvi6GPKTKEzc/3zst8V35Zl51jxlHjrQzOe2Y1EiPc6DvJXtNG/wom0rAjtqpVKPJRiQfGHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EFGTLLo0; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EFGTLLo0"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso165ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 17:26:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778631977; cv=none;
        d=google.com; s=arc-20240605;
        b=UEyvRmwGA4JYUhKniOwn2Rd9e6pp6hOtEc/hwnuJwbE9Wpe1aLDFR+OFcv2ry+lMAE
         IW4q4BOE8Vwi3sFfEbwUroG2WyLwWjsKq8o7vZzMKV8sdpLToJArgm9125NzV918DbvC
         gbbX3ayaNre74ZUyxRQo8i4uszZ1Sis7Vohz0dOxAKuNo1j/uqyoLfA8v8S4w9f6rO3S
         ygroHjfSCHNyUdaHesy6fIpghcyhaE1FMzZYlmC+vkcHh7O4ummhH11p9xoabFh8Gu6B
         fRkHe2DbeH9rhfzEdQ9DDpp7MNJkxkTynq1JEV0vbMRHDxsxntsSq4z0U0qLzWLMdnkp
         ChYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kJB8OhIRgOZ01ZTilvZbdIJAYyP4tiECF1pQyrTpTF4=;
        fh=TW81nCGm5NOMei9xr2ft3BFYBeJmtRN/mc+i8loSiN8=;
        b=jjqscJspcaGz0cm27+SAEkyVtZCBTBn/c7LmHctQ3jn1CBlG25oWQcetvlk+2OJBPl
         n6CNYzBpQkaOuacKqiLmJiRYzGNMCF4MRh6U+yn/KDrqg6P91DxgZL5B7jHiu7E0bAZx
         6W4dvekivFdpGOQ8O6WKzNHwPwf27O1Cx/QLZQ6GLx8IJRNPwZNzijNi+x+bjk34SM11
         HDk4rD8L2lRh0joroI7Vnd7GjQ45f9Hk+ZRmIYbcb5TNCJtnSHSaR2IsMskqQhZ0SIP0
         GjZSHdwKyual3uLmhRaXpESiL4Rb4RX+uXnk33gUv/B2xoMCidR3htATwQMPjk+EX5Ac
         lPvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778631977; x=1779236777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJB8OhIRgOZ01ZTilvZbdIJAYyP4tiECF1pQyrTpTF4=;
        b=EFGTLLo0JfOkmzDscHR9QI2CJ3fdEbSfeKj0ZAj+7qTo/CvL/seW2TMfp1vvD/6XrG
         mS35cHwwPaOydiV2THV9GAreXfuHOJOUkNXmx0rhNwoqQR/Vkea8wVHDZZwMIDQdMxVS
         84sQpZ1NIRDASsi4Oby5LvOF55JyNJXM4tAF8UHKlniXMce13KTc6kNcJeMhIbM6RKkP
         fhkibVlXDDI7PoChVofQxyFUFXml7tVcMXtwYl32OMZu2HD2pYxrp8MFVk/IBINPq85V
         T3ykF/7OVrwW7YiB2VKvLvYkLIlNXtL/bXGZmnd3svrMq0J9tooUqH+fS7hQ1UkWsGN6
         SY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778631977; x=1779236777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kJB8OhIRgOZ01ZTilvZbdIJAYyP4tiECF1pQyrTpTF4=;
        b=DFJZvpss7BHXhylIMb0v2Z4sKCjBNEDKgvdtug2t9xrMIuAh3WmoDc5Td8rs8aIi8F
         WvsQ7JyhzhsfptOLQfKQLsiCUPBQuW9eZy6pat66k6T3nXlhAZXtifbkxkagb4vjAjRt
         MxR/3tba2gDh/PXryLEt+rEaOOWUxYxdO6YECY142AldCz4/EVOJxSFZPSd7DzRuz58o
         M4DYQ2SR8z4W7ZTqju86jdUwEFjowJztHslxrVMiIZBFBkgPzCS/EhjJ8GLte7E00YyC
         8TvPafoWjnWrxRg2iNCi2jjlsW0QT9Oo/G7hjCgMhxS/qg85PX/Ck6iue+ZK+HpUhdFl
         0NbA==
X-Forwarded-Encrypted: i=1; AFNElJ8O9eSHWyJtKYQhCn/RZUlDCLmuT6lf0M8crELJtQ0KBRe60NH1VFK9hoXXVKfQhUwrWhuJlxCEyKCjkGy9WhHt@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3UVRy8jM2Ws3o1oKGLXBLJF9ERJ0oVoG6NCjayEs4H8301kuN
	YYjk3lppfgzRnvJ6ZJYUWu52Sb+xJOaq+Gyxgxcy8W1q2LSf/nw4itg71Hkr0ezHSI12s5EJFHw
	RdnXS42cDDzQPAcKxwnouGIFRMjeCmOs5YKrWwhMW
X-Gm-Gg: Acq92OGbcJgXd4Wf0VqdrcLeq7Dw51wxe+Na6mSp88wK7lNYD3O6hjYs6aNT/541Fax
	doCPt8wenZ7nVaYaw9onmOqUoV/UbhMVyuzBG+rnftnh4HVHHTmqC1tL/tp1a2BBKdgmSOyxxsF
	myhoHhWzusBEjJYpXeQy+dAj/GDV7W3BU8yzNL+5bLgGmSGn6FzA9oyh4ETWHXtv8vhpNaVStyW
	GlpXCGCSgcAzdHZUR0tPXMjEmScHn2pCP8Nxwl3/DVMrVX8cPibQuynvSut2tA5rORYArMWOn/O
	09LUZqxOP3MlcSJm7ME=
X-Received: by 2002:a17:902:c403:b0:2b7:b03d:9dce with SMTP id
 d9443c01a7336-2bd26eff503mr1490085ad.18.1778631976449; Tue, 12 May 2026
 17:26:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512233048.9577-1-zide.chen@intel.com> <20260512233048.9577-2-zide.chen@intel.com>
In-Reply-To: <20260512233048.9577-2-zide.chen@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 12 May 2026 17:26:03 -0700
X-Gm-Features: AVHnY4Lusnsu6oQ_fyoIB6vO0CQt7E9GT_BT1Z-aAsEALtedLCoklOH1wrOL4x8
Message-ID: <CAP-5=fUNCL3h3=Sp5_wQ2nHiTAW2JsWUWHQeLnc4BG458wubWQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] perf/x86/intel/uncore: Rename refcount fields and
 other cleanups
To: Zide Chen <zide.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 4:39=E2=80=AFPM Zide Chen <zide.chen@intel.com> wro=
te:
>
> Fix typo UNCORE_BOX_FLAG_INITIATED to UNCORE_BOX_FLAG_INITIALIZED.
>
> Rename the 'id' parameter in uncore_box_{ref,unref}() to 'die' to
> reflect its actual meaning and be consistent with other functions.
>
> pmu->activeboxes is misleading because it does not decrement when the
> PMU fails to register.  Rename it to die_refcnt, reflecting that it
> counts the number of dies with a box present, regardless of whether
> the PMU is functioning.
>
> Rename box->refcnt to box->cpu_refcnt to clarify that it tracks the
> number of CPUs on the die with a corresponding PMU box present.
>
> Remove the incorrect atomic_inc(&box->refcnt) from
> uncore_pci_pmu_register(): PCI boxes are not tracked by cpu_refcnt,
> and this call incorrectly increments it on a per-die basis.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  arch/x86/events/intel/uncore.c | 21 +++++++++++----------
>  arch/x86/events/intel/uncore.h | 10 +++++-----
>  2 files changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncor=
e.c
> index a7780c5cd419..012a7e081014 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1170,14 +1170,13 @@ static int uncore_pci_pmu_register(struct pci_dev=
 *pdev,
>         if (!box)
>                 return -ENOMEM;
>
> -       atomic_inc(&box->refcnt);
>         box->dieid =3D die;
>         box->pci_dev =3D pdev;
>         box->pmu =3D pmu;
>         uncore_box_init(box);
>
>         pmu->boxes[die] =3D box;
> -       if (atomic_inc_return(&pmu->activeboxes) > 1)
> +       if (atomic_inc_return(&pmu->die_refcnt) > 1)
>                 return 0;
>
>         /* First active box registers the pmu */
> @@ -1249,7 +1248,7 @@ static void uncore_pci_pmu_unregister(struct intel_=
uncore_pmu *pmu, int die)
>         struct intel_uncore_box *box =3D pmu->boxes[die];
>
>         pmu->boxes[die] =3D NULL;
> -       if (atomic_dec_return(&pmu->activeboxes) =3D=3D 0)
> +       if (atomic_dec_return(&pmu->die_refcnt) =3D=3D 0)
>                 uncore_pmu_unregister(pmu);
>         uncore_box_exit(box);
>         kfree(box);
> @@ -1515,7 +1514,7 @@ static void uncore_change_context(struct intel_unco=
re_type **uncores,
>                 uncore_change_type_ctx(*uncores, old_cpu, new_cpu);
>  }
>
> -static void uncore_box_unref(struct intel_uncore_type **types, int id)
> +static void uncore_box_unref(struct intel_uncore_type **types, int die)
>  {
>         struct intel_uncore_type *type;
>         struct intel_uncore_pmu *pmu;
> @@ -1526,8 +1525,9 @@ static void uncore_box_unref(struct intel_uncore_ty=
pe **types, int id)
>                 type =3D *types;
>                 pmu =3D type->pmus;
>                 for (i =3D 0; i < type->num_boxes; i++, pmu++) {
> -                       box =3D pmu->boxes[id];
> -                       if (box && box->cpu >=3D 0 && atomic_dec_return(&=
box->refcnt) =3D=3D 0)
> +                       box =3D pmu->boxes[die];
> +                       if (box && box->cpu >=3D 0 &&
> +                           atomic_dec_return(&box->cpu_refcnt) =3D=3D 0)
>                                 uncore_box_exit(box);
>                 }
>         }
> @@ -1601,14 +1601,14 @@ static int allocate_boxes(struct intel_uncore_typ=
e **types,
>  }
>
>  static int uncore_box_ref(struct intel_uncore_type **types,
> -                         int id, unsigned int cpu)
> +                         int die, unsigned int cpu)
>  {
>         struct intel_uncore_type *type;
>         struct intel_uncore_pmu *pmu;
>         struct intel_uncore_box *box;
>         int i, ret;
>
> -       ret =3D allocate_boxes(types, id, cpu);
> +       ret =3D allocate_boxes(types, die, cpu);
>         if (ret)
>                 return ret;
>
> @@ -1616,8 +1616,9 @@ static int uncore_box_ref(struct intel_uncore_type =
**types,
>                 type =3D *types;
>                 pmu =3D type->pmus;
>                 for (i =3D 0; i < type->num_boxes; i++, pmu++) {
> -                       box =3D pmu->boxes[id];
> -                       if (box && box->cpu >=3D 0 && atomic_inc_return(&=
box->refcnt) =3D=3D 1)
> +                       box =3D pmu->boxes[die];
> +                       if (box && box->cpu >=3D 0 &&
> +                           atomic_inc_return(&box->cpu_refcnt) =3D=3D 1)
>                                 uncore_box_init(box);
>                 }
>         }
> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncor=
e.h
> index c2e5ccb1d72c..7d4ef869d193 100644
> --- a/arch/x86/events/intel/uncore.h
> +++ b/arch/x86/events/intel/uncore.h
> @@ -147,7 +147,7 @@ struct intel_uncore_pmu {
>         char                            name[UNCORE_PMU_NAME_LEN];
>         int                             pmu_idx;
>         bool                            registered;
> -       atomic_t                        activeboxes;
> +       atomic_t                        die_refcnt;
>         cpumask_t                       cpu_mask;
>         struct intel_uncore_type        *type;
>         struct intel_uncore_box         **boxes;
> @@ -165,7 +165,7 @@ struct intel_uncore_box {
>         int n_events;
>         int cpu;        /* cpu to collect events */
>         unsigned long flags;
> -       atomic_t refcnt;
> +       atomic_t cpu_refcnt; /* Number of CPUs that have this box online =
*/
>         struct perf_event *events[UNCORE_PMC_IDX_MAX];
>         struct perf_event *event_list[UNCORE_PMC_IDX_MAX];
>         struct event_constraint *event_constraint[UNCORE_PMC_IDX_MAX];
> @@ -185,7 +185,7 @@ struct intel_uncore_box {
>  #define CFL_UNC_CBO_7_PERFEVTSEL0              0xf70
>  #define CFL_UNC_CBO_7_PER_CTR0                 0xf76
>
> -#define UNCORE_BOX_FLAG_INITIATED              0
> +#define UNCORE_BOX_FLAG_INITIALIZED            0
>  /* event config registers are 8-byte apart */
>  #define UNCORE_BOX_FLAG_CTL_OFFS8              1
>  /* CFL 8th CBOX has different MSR space */
> @@ -559,7 +559,7 @@ static inline u64 uncore_read_counter(struct intel_un=
core_box *box,
>
>  static inline void uncore_box_init(struct intel_uncore_box *box)
>  {
> -       if (!test_and_set_bit(UNCORE_BOX_FLAG_INITIATED, &box->flags)) {
> +       if (!test_and_set_bit(UNCORE_BOX_FLAG_INITIALIZED, &box->flags)) =
{
>                 if (box->pmu->type->ops->init_box)
>                         box->pmu->type->ops->init_box(box);
>         }
> @@ -567,7 +567,7 @@ static inline void uncore_box_init(struct intel_uncor=
e_box *box)
>
>  static inline void uncore_box_exit(struct intel_uncore_box *box)
>  {
> -       if (test_and_clear_bit(UNCORE_BOX_FLAG_INITIATED, &box->flags)) {
> +       if (test_and_clear_bit(UNCORE_BOX_FLAG_INITIALIZED, &box->flags))=
 {
>                 if (box->pmu->type->ops->exit_box)
>                         box->pmu->type->ops->exit_box(box);
>         }
> --
> 2.54.0
>
