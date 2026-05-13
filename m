Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AE419C542
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 00:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778631854; cv=pass; b=eYTvJBLQox9ZL7QJiH8ilVi81O6punJBhJnq8Wuvlenk7l8ZgsiTwB359U7O1ubq3bANMutf2oo8/SI8i8f9WD6IXVikObVIQRuQiazhPjuS7JOexnNw+XJ1jxGou3ZV0ijC+AbVUIdSwofNC1+Hc18VHxWlNpsS7gJN/3EVEtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778631854; c=relaxed/simple;
	bh=xWOEkSlgz8tpDaWzpUaV9rhS8Gk5wXB6w79eAx8EKiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJ/DXSnWybzkLDTsHrdSNEEZLEQZEBW9wKAFlMWrWKsw3jHs3K3CbnqQT9hLFv4hx8qyjjn0rce2brPDrNwKFb5b/NHkudYSM/fnogp4Iez7aK611s1dbQOcpxzKLIZelc6+NPlVS9caSFWZtcd0Nv2vbROckZHEL7fIsi6yffo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WD8mtLwo; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WD8mtLwo"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so315ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 17:24:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778631851; cv=none;
        d=google.com; s=arc-20240605;
        b=PSkIAfSPL2bixJUOzdcGZGlkltu5bh93Ls7JHInhz1bf0ncaFIxqJco7CZRlVGI6hS
         a1N6t4+BV2WvaIGM2/tWLBjayd3sgEdOpnMTCH9HpZI19mxoD2jsEbhVMNAwZLWCVjg4
         iJhvNrO1b7uBUJNVacg5LKQLu4AedauzjWSLyAK4zCKN/89Vv7bQ+xU+Xx4EcHeWaoc3
         vUX8EGqgWsrQq4RrjOA2mALBIYCMgETH7MpTYq1rOlo6nK2/UWf8zsTlSP1dke5Kj/+N
         BonBSvB7xsydR7C+bxPtz+3OK9QkRVwyZ5PLMIeIN4mN97gXx4i8KxCe21FySrbceHWx
         S64A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jhzmdv+VWVc2IHLV9r3iWKmSJGqnwG41zdUv//JYvM4=;
        fh=hRIxJNEjKElix/ZRV/2ndHDsrgjza11wbjYqNi/56CY=;
        b=eNOf2P8CoO48sg9/z7lxm9NytyyCKor+F53VRA2Bct8gN9nKeo7KUfMOltly2t0ZNB
         6ORVknu54QXKYRSab+TiRC/lrZdrwDiiWEFlhX4/JKaD92p9VYpVoM1PJPAAUTHSkfQS
         /OjTDFAHpfCkmVI7IcCiOPqDpKysc8Fd1faO1SqNo5h0Gt10TMrxJQA7+uvrXrCAtvl2
         hFfWjJ1lliFVJLcwUBNcAVx95Yqi7VS6gc/Pr35bR3HxNYlqiRcyQE+cRg7TSxIG5dqT
         Dhripw0suWzUgDoi8Icw/YfhwzkcUhKsTvhoD6vAurESw6JIU6lHvBNKV82nEZ3NpZMF
         R5Tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778631851; x=1779236651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jhzmdv+VWVc2IHLV9r3iWKmSJGqnwG41zdUv//JYvM4=;
        b=WD8mtLwoUSMh/DHf3mpI1nNzscdrB0de1t/erbA1HoMeZdZK6WDEd3y3Fc1QNV7JCx
         Nd0uqFQX5J7GBj5PN5hxY9/NKzJMO95Usd+Ss1eFPXooK6njyejw8wFJPfvKDO2Zdzfm
         PzE278GQ6C2bChaHnmj3DxSsLuSCT5IdI3xdNi+BJzjcTRdaoNu0w5vH8UW09GY0cpea
         GIE+cJ++8pr1ekeswBv+ikipTOkL61QUlUvJtbBD1scK0aMIJRMWShmImNSL0ERAS2PE
         yGDmINldHY8htmR1kzvb2V+NLR8h3tQxOy+gjZKN5WChH8N3YOALZYCrdxuq6pmTnbRY
         ytfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778631851; x=1779236651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jhzmdv+VWVc2IHLV9r3iWKmSJGqnwG41zdUv//JYvM4=;
        b=lbB6QVOnI9vj9meHANqvTKP37qRzqNW5gvF6iyWLW3YkmP4C3jYHdQJpOsojS0JFiV
         FSl7xJhD9RP9n1KhNCMPvJKPoHpK1ULNQYx9Xv4Afo1Cqus0jkr3Jc31KvEzNrhRc5cL
         LX2ar5iPqzqOZifUlftmyqOtxnfeeBgZ5lyKvxjaPMXFb2k4GmRoT1ie0rytfgdZd9rs
         C12tvXBZh8z0Ni1Nkm9zb1AJcA6ve1UchDU8fA05TlaYb9i8fXRZ1/TxM+8JMg8uq3bV
         ZI8NZKjjD2YVCJx27LCjwQy8lsW4POZ3nQUyeNp4jTQFfRw9KaIxFFCShzSVwHkl+Rxx
         EGDg==
X-Forwarded-Encrypted: i=1; AFNElJ8mqlz/ETTSpEYIPYM5H5OK9JvrxEOZZk4QTW9m7q8eHpXBkvbXt2fZMZYS6TEATNeIsJSvwoq3WNTBj6CnuGxj@vger.kernel.org
X-Gm-Message-State: AOJu0YxZGH9HOQpVlJPbsKhNdwxVHcIy/tcQq2sGSKWIU3/0F6bU4odE
	0rsmyIv5ThnsgsIrpJXsNoKomV+ul7NokKYB0O1nKrOSnPFtLOKV4zhaSX30jJgG/cI75yyFmNv
	tSDi0/vP9FYiNWaejUp6PGApAjnxwsiwB4Kf+vwiP
X-Gm-Gg: Acq92OGPERJdkW61bMbT5hYElwWVb+6bct0z2SeCc+dvNXDNX1OZ1st9gq6f/Z+2C/8
	CeFzPtGZPJ30Zj8AbE5ewZoleQbhQizM13CWq46pO7sKlU+wPuDcGh2pODswM+emY++l4hIxQCE
	tovIQBCTn1HJOIIxxj0sc8MFlDo1v4+CtxGwReO0KMV2Qn7Hw+V7DmkMJ3XnnhaFCwoXZCf4siL
	Zpa4b85OoYUmCcFaqutVSHuRhhqFo4Eqk0DOhA6nTPxwqnaBX1AFvWZj9I24VDSBs44Wx90Ge6F
	uTaC5bT2FglMnCuQIkU=
X-Received: by 2002:a17:903:1a8f:b0:2bc:ac76:c1ca with SMTP id
 d9443c01a7336-2bd266faa2emr1805625ad.2.1778631850633; Tue, 12 May 2026
 17:24:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512233048.9577-1-zide.chen@intel.com> <20260512233048.9577-3-zide.chen@intel.com>
In-Reply-To: <20260512233048.9577-3-zide.chen@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 12 May 2026 17:23:58 -0700
X-Gm-Features: AVHnY4KrPK0pveh5cjjWqNaLfJn6qD6UGP00nkVGU2bisodGopIAOkHdVGosOiY
Message-ID: <CAP-5=fV-U4B4Hmj5a-Nk6vRYjdHpuDE0XJka5jdwAbRX=ETqcQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] perf/x86/intel/uncore: Let init_box() callback report failures
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
> The init_box() callback currently returns void, so initialization
> failures are silently ignored and the box is still marked initialized.
>
> Change the callback to return int so platform code can report errors
> back to the common uncore layer.
>
> Update uncore_box_init() to set the initialized flag only when
> init_box() succeeds.  Because box->cpu_refcnt guarantees that at most
> one CPU calls uncore_box_init() for a given box at a time, plain
> __set_bit() is safe for the initialized flag without atomic overhead.
>
> Convert all init_box() implementations to return 0 on success or a
> negative error code on failure.  This is a prerequisite for propagating
> initialization errors to the caller so they can be handled properly.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  arch/x86/events/intel/uncore.h           | 16 +++--
>  arch/x86/events/intel/uncore_discovery.c | 15 +++--
>  arch/x86/events/intel/uncore_discovery.h |  6 +-
>  arch/x86/events/intel/uncore_nhmex.c     |  3 +-
>  arch/x86/events/intel/uncore_snb.c       | 80 +++++++++++++++---------
>  arch/x86/events/intel/uncore_snbep.c     | 69 ++++++++++++--------
>  6 files changed, 120 insertions(+), 69 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncor=
e.h
> index 7d4ef869d193..5ee05545116a 100644
> --- a/arch/x86/events/intel/uncore.h
> +++ b/arch/x86/events/intel/uncore.h
> @@ -129,7 +129,7 @@ struct intel_uncore_type {
>  #define events_group attr_groups[2]
>
>  struct intel_uncore_ops {
> -       void (*init_box)(struct intel_uncore_box *);
> +       int (*init_box)(struct intel_uncore_box *);
>         void (*exit_box)(struct intel_uncore_box *);
>         void (*disable_box)(struct intel_uncore_box *);
>         void (*enable_box)(struct intel_uncore_box *);
> @@ -557,12 +557,18 @@ static inline u64 uncore_read_counter(struct intel_=
uncore_box *box,
>         return box->pmu->type->ops->read_counter(box, event);
>  }
>
> -static inline void uncore_box_init(struct intel_uncore_box *box)
> +static inline int uncore_box_init(struct intel_uncore_box *box)
>  {
> -       if (!test_and_set_bit(UNCORE_BOX_FLAG_INITIALIZED, &box->flags)) =
{
> -               if (box->pmu->type->ops->init_box)
> -                       box->pmu->type->ops->init_box(box);
> +       int ret =3D 0;
> +
> +       if (!test_bit(UNCORE_BOX_FLAG_INITIALIZED, &box->flags) &&
> +           box->pmu->type->ops->init_box) {
> +               ret =3D box->pmu->type->ops->init_box(box);
> +               if (!ret)
> +                       __set_bit(UNCORE_BOX_FLAG_INITIALIZED, &box->flag=
s);
>         }
> +
> +       return ret;
>  }
>
>  static inline void uncore_box_exit(struct intel_uncore_box *box)
> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/i=
ntel/uncore_discovery.c
> index 49183d607a34..f1156ad03523 100644
> --- a/arch/x86/events/intel/uncore_discovery.c
> +++ b/arch/x86/events/intel/uncore_discovery.c
> @@ -488,9 +488,10 @@ static u64 intel_generic_uncore_box_ctl(struct intel=
_uncore_box *box)
>         return unit->addr;
>  }
>
> -void intel_generic_uncore_msr_init_box(struct intel_uncore_box *box)
> +int intel_generic_uncore_msr_init_box(struct intel_uncore_box *box)
>  {
>         wrmsrq(intel_generic_uncore_box_ctl(box), GENERIC_PMON_BOX_CTL_IN=
T);
> +       return 0;
>  }
>
>  void intel_generic_uncore_msr_disable_box(struct intel_uncore_box *box)
> @@ -565,13 +566,14 @@ static inline int intel_pci_uncore_box_ctl(struct i=
ntel_uncore_box *box)
>         return UNCORE_DISCOVERY_PCI_BOX_CTRL(intel_generic_uncore_box_ctl=
(box));
>  }
>
> -void intel_generic_uncore_pci_init_box(struct intel_uncore_box *box)
> +int intel_generic_uncore_pci_init_box(struct intel_uncore_box *box)
>  {
>         struct pci_dev *pdev =3D box->pci_dev;
>         int box_ctl =3D intel_pci_uncore_box_ctl(box);
>
>         __set_bit(UNCORE_BOX_FLAG_CTL_OFFS8, &box->flags);
>         pci_write_config_dword(pdev, box_ctl, GENERIC_PMON_BOX_CTL_INT);
> +       return 0;
>  }
>
>  void intel_generic_uncore_pci_disable_box(struct intel_uncore_box *box)
> @@ -632,7 +634,7 @@ static struct intel_uncore_ops generic_uncore_pci_ops=
 =3D {
>
>  #define UNCORE_GENERIC_MMIO_SIZE               0x4000
>
> -void intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box)
> +int intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box)
>  {
>         static struct intel_uncore_discovery_unit *unit;
>         struct intel_uncore_type *type =3D box->pmu->type;
> @@ -642,13 +644,13 @@ void intel_generic_uncore_mmio_init_box(struct inte=
l_uncore_box *box)
>         if (!unit) {
>                 pr_warn("Uncore type %d id %d: Cannot find box control ad=
dress.\n",
>                         type->type_id, box->pmu->pmu_idx);
> -               return;
> +               return -ENODEV;
>         }
>
>         if (!unit->addr) {
>                 pr_warn("Uncore type %d box %d: Invalid box control addre=
ss.\n",
>                         type->type_id, unit->id);
> -               return;
> +               return -ENODEV;
>         }
>
>         addr =3D unit->addr;
> @@ -656,10 +658,11 @@ void intel_generic_uncore_mmio_init_box(struct inte=
l_uncore_box *box)
>         if (!box->io_addr) {
>                 pr_warn("Uncore type %d box %d: ioremap error for 0x%llx.=
\n",
>                         type->type_id, unit->id, (unsigned long long)addr=
);
> -               return;
> +               return -ENOMEM;
>         }
>
>         writel(GENERIC_PMON_BOX_CTL_INT, box->io_addr);
> +       return 0;
>  }
>
>  void intel_generic_uncore_mmio_disable_box(struct intel_uncore_box *box)
> diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/i=
ntel/uncore_discovery.h
> index e1330342b92e..142e1b56cfc2 100644
> --- a/arch/x86/events/intel/uncore_discovery.h
> +++ b/arch/x86/events/intel/uncore_discovery.h
> @@ -148,11 +148,11 @@ void intel_uncore_generic_uncore_cpu_init(void);
>  int intel_uncore_generic_uncore_pci_init(void);
>  void intel_uncore_generic_uncore_mmio_init(void);
>
> -void intel_generic_uncore_msr_init_box(struct intel_uncore_box *box);
> +int intel_generic_uncore_msr_init_box(struct intel_uncore_box *box);
>  void intel_generic_uncore_msr_disable_box(struct intel_uncore_box *box);
>  void intel_generic_uncore_msr_enable_box(struct intel_uncore_box *box);
>
> -void intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box);
> +int intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box);
>  void intel_generic_uncore_mmio_disable_box(struct intel_uncore_box *box)=
;
>  void intel_generic_uncore_mmio_enable_box(struct intel_uncore_box *box);
>  void intel_generic_uncore_mmio_disable_event(struct intel_uncore_box *bo=
x,
> @@ -160,7 +160,7 @@ void intel_generic_uncore_mmio_disable_event(struct i=
ntel_uncore_box *box,
>  void intel_generic_uncore_mmio_enable_event(struct intel_uncore_box *box=
,
>                                             struct perf_event *event);
>
> -void intel_generic_uncore_pci_init_box(struct intel_uncore_box *box);
> +int intel_generic_uncore_pci_init_box(struct intel_uncore_box *box);
>  void intel_generic_uncore_pci_disable_box(struct intel_uncore_box *box);
>  void intel_generic_uncore_pci_enable_box(struct intel_uncore_box *box);
>  void intel_generic_uncore_pci_disable_event(struct intel_uncore_box *box=
,
> diff --git a/arch/x86/events/intel/uncore_nhmex.c b/arch/x86/events/intel=
/uncore_nhmex.c
> index 8962e7cb21e3..7a6855281102 100644
> --- a/arch/x86/events/intel/uncore_nhmex.c
> +++ b/arch/x86/events/intel/uncore_nhmex.c
> @@ -199,9 +199,10 @@ DEFINE_UNCORE_FORMAT_ATTR(counter, counter, "config:=
6-7");
>  DEFINE_UNCORE_FORMAT_ATTR(match, match, "config1:0-63");
>  DEFINE_UNCORE_FORMAT_ATTR(mask, mask, "config2:0-63");
>
> -static void nhmex_uncore_msr_init_box(struct intel_uncore_box *box)
> +static int nhmex_uncore_msr_init_box(struct intel_uncore_box *box)
>  {
>         wrmsrq(NHMEX_U_MSR_PMON_GLOBAL_CTL, NHMEX_U_PMON_GLOBAL_EN_ALL);
> +       return 0;
>  }
>
>  static void nhmex_uncore_msr_exit_box(struct intel_uncore_box *box)
> diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/u=
ncore_snb.c
> index edddd4f9ab5f..c5347920541c 100644
> --- a/arch/x86/events/intel/uncore_snb.c
> +++ b/arch/x86/events/intel/uncore_snb.c
> @@ -295,12 +295,14 @@ static void snb_uncore_msr_disable_event(struct int=
el_uncore_box *box, struct pe
>         wrmsrq(event->hw.config_base, 0);
>  }
>
> -static void snb_uncore_msr_init_box(struct intel_uncore_box *box)
> +static int snb_uncore_msr_init_box(struct intel_uncore_box *box)
>  {
>         if (box->pmu->pmu_idx =3D=3D 0) {
>                 wrmsrq(SNB_UNC_PERF_GLOBAL_CTL,
>                         SNB_UNC_GLOBAL_CTL_EN | SNB_UNC_GLOBAL_CTL_CORE_A=
LL);
>         }
> +
> +       return 0;
>  }
>
>  static void snb_uncore_msr_enable_box(struct intel_uncore_box *box)
> @@ -394,7 +396,7 @@ void snb_uncore_cpu_init(void)
>                 snb_uncore_cbox.num_boxes =3D topology_num_cores_per_pack=
age();
>  }
>
> -static void skl_uncore_msr_init_box(struct intel_uncore_box *box)
> +static int skl_uncore_msr_init_box(struct intel_uncore_box *box)
>  {
>         if (box->pmu->pmu_idx =3D=3D 0) {
>                 wrmsrq(SKL_UNC_PERF_GLOBAL_CTL,
> @@ -404,6 +406,8 @@ static void skl_uncore_msr_init_box(struct intel_unco=
re_box *box)
>         /* The 8th CBOX has different MSR space */
>         if (box->pmu->pmu_idx =3D=3D 7)
>                 __set_bit(UNCORE_BOX_FLAG_CFL8_CBOX_MSR_OFFS, &box->flags=
);
> +
> +       return 0;
>  }
>
>  static void skl_uncore_msr_enable_box(struct intel_uncore_box *box)
> @@ -547,10 +551,12 @@ static struct intel_uncore_type *tgl_msr_uncores[] =
=3D {
>         NULL,
>  };
>
> -static void rkl_uncore_msr_init_box(struct intel_uncore_box *box)
> +static int rkl_uncore_msr_init_box(struct intel_uncore_box *box)
>  {
>         if (box->pmu->pmu_idx =3D=3D 0)
>                 wrmsrq(SKL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
> +
> +       return 0;
>  }
>
>  void tgl_uncore_cpu_init(void)
> @@ -707,9 +713,10 @@ static struct intel_uncore_type mtl_uncore_hac_cbox =
=3D {
>         .format_group   =3D &adl_uncore_format_group,
>  };
>
> -static void mtl_uncore_msr_init_box(struct intel_uncore_box *box)
> +static int mtl_uncore_msr_init_box(struct intel_uncore_box *box)
>  {
>         wrmsrq(uncore_msr_box_ctl(box), SNB_UNC_GLOBAL_CTL_EN);
> +       return 0;
>  }
>
>  static struct intel_uncore_ops mtl_uncore_msr_ops =3D {
> @@ -773,10 +780,12 @@ static struct intel_uncore_type *lnl_msr_uncores[] =
=3D {
>
>  #define LNL_UNC_MSR_GLOBAL_CTL                 0x240e
>
> -static void lnl_uncore_msr_init_box(struct intel_uncore_box *box)
> +static int lnl_uncore_msr_init_box(struct intel_uncore_box *box)
>  {
>         if (box->pmu->pmu_idx =3D=3D 0)
>                 wrmsrq(LNL_UNC_MSR_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
> +
> +       return 0;
>  }
>
>  static struct intel_uncore_ops lnl_uncore_msr_ops =3D {
> @@ -874,7 +883,7 @@ static const struct attribute_group snb_uncore_imc_fo=
rmat_group =3D {
>         .attrs =3D snb_uncore_imc_formats_attr,
>  };
>
> -static void snb_uncore_imc_init_box(struct intel_uncore_box *box)
> +static int snb_uncore_imc_init_box(struct intel_uncore_box *box)
>  {
>         struct intel_uncore_type *type =3D box->pmu->type;
>         struct pci_dev *pdev =3D box->pci_dev;
> @@ -893,10 +902,13 @@ static void snb_uncore_imc_init_box(struct intel_un=
core_box *box)
>         addr &=3D ~(PAGE_SIZE - 1);
>
>         box->io_addr =3D ioremap(addr, type->mmio_map_size);
> -       if (!box->io_addr)
> +       if (!box->io_addr) {
>                 pr_warn("perf uncore: Failed to ioremap for %s.\n", type-=
>name);
> +               return -ENOMEM;
> +       }
>
>         box->hrtimer_duration =3D UNCORE_SNB_IMC_HRTIMER_INTERVAL;
> +       return 0;
>  }
>
>  static void snb_uncore_imc_enable_box(struct intel_uncore_box *box)
> @@ -1532,7 +1544,7 @@ static struct pci_dev *tgl_uncore_get_mc_dev(void)
>  #define TGL_UNCORE_MMIO_IMC_MEM_OFFSET         0x10000
>  #define TGL_UNCORE_PCI_IMC_MAP_SIZE            0xe000
>
> -static void
> +static int
>  uncore_get_box_mmio_addr(struct intel_uncore_box *box,
>                          unsigned int base_offset,
>                          int bar_offset, int step)
> @@ -1541,19 +1553,20 @@ uncore_get_box_mmio_addr(struct intel_uncore_box =
*box,
>         struct intel_uncore_pmu *pmu =3D box->pmu;
>         struct intel_uncore_type *type =3D pmu->type;
>         resource_size_t addr;
> +       int ret =3D 0;
>         u32 bar;
>
>         if (!pdev) {
>                 pr_warn("perf uncore: Cannot find matched IMC device.\n")=
;
> -               return;
> +               return -ENODEV;
>         }
>
>         pci_read_config_dword(pdev, bar_offset, &bar);
>         if (!(bar & BIT(0))) {
>                 pr_warn("perf uncore: BAR 0x%x is disabled. Failed to map=
 %s counters.\n",
>                         bar_offset, type->name);
> -               pci_dev_put(pdev);
> -               return;
> +               ret =3D -ENODEV;
> +               goto out;
>         }
>         bar &=3D ~BIT(0);
>         addr =3D (resource_size_t)(bar + step * pmu->pmu_idx);
> @@ -1565,23 +1578,26 @@ uncore_get_box_mmio_addr(struct intel_uncore_box =
*box,
>
>         addr +=3D base_offset;
>         box->io_addr =3D ioremap(addr, type->mmio_map_size);
> -       if (!box->io_addr)
> +       if (!box->io_addr) {
> +               ret =3D -ENOMEM;
>                 pr_warn("perf uncore: Failed to ioremap for %s.\n", type-=
>name);
> -
> +       }
> +out:
>         pci_dev_put(pdev);
> +       return ret;
>  }
>
> -static void __uncore_imc_init_box(struct intel_uncore_box *box,
> +static int __uncore_imc_init_box(struct intel_uncore_box *box,
>                                   unsigned int base_offset)
>  {
> -       uncore_get_box_mmio_addr(box, base_offset,
> +       return uncore_get_box_mmio_addr(box, base_offset,
>                                  SNB_UNCORE_PCI_IMC_BAR_OFFSET,
>                                  TGL_UNCORE_MMIO_IMC_MEM_OFFSET);
>  }
>
> -static void tgl_uncore_imc_freerunning_init_box(struct intel_uncore_box =
*box)
> +static int tgl_uncore_imc_freerunning_init_box(struct intel_uncore_box *=
box)
>  {
> -       __uncore_imc_init_box(box, 0);
> +       return __uncore_imc_init_box(box, 0);
>  }
>
>  static struct intel_uncore_ops tgl_uncore_imc_freerunning_ops =3D {
> @@ -1648,13 +1664,15 @@ void tgl_uncore_mmio_init(void)
>  #define ADL_UNCORE_IMC_CTL_INT                 (ADL_UNCORE_IMC_CTL_RST_C=
TRL | \
>                                                 ADL_UNCORE_IMC_CTL_RST_CT=
RS)
>
> -static void adl_uncore_imc_init_box(struct intel_uncore_box *box)
> +static int adl_uncore_imc_init_box(struct intel_uncore_box *box)
>  {
> -       __uncore_imc_init_box(box, ADL_UNCORE_IMC_BASE);
> +       int ret =3D __uncore_imc_init_box(box, ADL_UNCORE_IMC_BASE);
>
>         /* The global control in MC1 can control both MCs. */
> -       if (box->io_addr && (box->pmu->pmu_idx =3D=3D 1))
> +       if (!ret && (box->pmu->pmu_idx =3D=3D 1))
>                 writel(ADL_UNCORE_IMC_CTL_INT, box->io_addr + ADL_UNCORE_=
IMC_GLOBAL_CTL);
> +
> +       return ret;
>  }
>
>  static void adl_uncore_mmio_disable_box(struct intel_uncore_box *box)
> @@ -1731,9 +1749,9 @@ static struct freerunning_counters adl_uncore_imc_f=
reerunning[] =3D {
>         [ADL_MMIO_UNCORE_IMC_DATA_WRITE]        =3D { 0xA0, 0x0, 0x0, 1, =
64 },
>  };
>
> -static void adl_uncore_imc_freerunning_init_box(struct intel_uncore_box =
*box)
> +static int adl_uncore_imc_freerunning_init_box(struct intel_uncore_box *=
box)
>  {
> -       __uncore_imc_init_box(box, ADL_UNCORE_IMC_FREERUNNING_BASE);
> +       return __uncore_imc_init_box(box, ADL_UNCORE_IMC_FREERUNNING_BASE=
);
>  }
>
>  static struct intel_uncore_ops adl_uncore_imc_freerunning_ops =3D {
> @@ -1803,9 +1821,9 @@ static const struct attribute_group lnl_uncore_form=
at_group =3D {
>         .attrs          =3D lnl_uncore_formats_attr,
>  };
>
> -static void lnl_uncore_hbo_init_box(struct intel_uncore_box *box)
> +static int lnl_uncore_hbo_init_box(struct intel_uncore_box *box)
>  {
> -       uncore_get_box_mmio_addr(box, LNL_UNCORE_HBO_BASE,
> +       return uncore_get_box_mmio_addr(box, LNL_UNCORE_HBO_BASE,
>                                  LNL_UNCORE_PCI_SAFBAR_OFFSET,
>                                  LNL_UNCORE_HBO_OFFSET);
>  }
> @@ -1829,14 +1847,16 @@ static struct intel_uncore_type lnl_uncore_hbo =
=3D {
>         .format_group   =3D &lnl_uncore_format_group,
>  };
>
> -static void lnl_uncore_sncu_init_box(struct intel_uncore_box *box)
> +static int lnl_uncore_sncu_init_box(struct intel_uncore_box *box)
>  {
> -       uncore_get_box_mmio_addr(box, LNL_UNCORE_SNCU_BASE,
> +       int ret =3D uncore_get_box_mmio_addr(box, LNL_UNCORE_SNCU_BASE,
>                                  LNL_UNCORE_PCI_SAFBAR_OFFSET,
>                                  0);
>
> -       if (box->io_addr)
> +       if (!ret)
>                 writel(ADL_UNCORE_IMC_CTL_INT, box->io_addr + LNL_UNCORE_=
GLOBAL_CTL);
> +
> +       return ret;
>  }
>
>  static struct intel_uncore_ops lnl_uncore_sncu_ops =3D {
> @@ -1887,13 +1907,15 @@ static struct intel_uncore_type ptl_uncore_imc =
=3D {
>         .mmio_map_size          =3D 0xf00,
>  };
>
> -static void ptl_uncore_sncu_init_box(struct intel_uncore_box *box)
> +static int ptl_uncore_sncu_init_box(struct intel_uncore_box *box)
>  {
> -       intel_generic_uncore_mmio_init_box(box);
> +       int ret =3D intel_generic_uncore_mmio_init_box(box);
>
>         /* Clear the global freeze bit */
>         if (box->io_addr)
>                 writel(0, box->io_addr + PTL_UNCORE_GLOBAL_CTL_OFFSET);
> +
> +       return ret;
>  }
>
>  static struct intel_uncore_ops ptl_uncore_sncu_ops =3D {
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel=
/uncore_snbep.c
> index 251c7bdbe30b..fbc51fa1b705 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -627,12 +627,13 @@ static u64 snbep_uncore_pci_read_counter(struct int=
el_uncore_box *box, struct pe
>         return count;
>  }
>
> -static void snbep_uncore_pci_init_box(struct intel_uncore_box *box)
> +static int snbep_uncore_pci_init_box(struct intel_uncore_box *box)
>  {
>         struct pci_dev *pdev =3D box->pci_dev;
>         int box_ctl =3D uncore_pci_box_ctl(box);
>
>         pci_write_config_dword(pdev, box_ctl, SNBEP_PMON_BOX_CTL_INT);
> +       return 0;
>  }
>
>  static void snbep_uncore_msr_disable_box(struct intel_uncore_box *box)
> @@ -680,12 +681,14 @@ static void snbep_uncore_msr_disable_event(struct i=
ntel_uncore_box *box,
>         wrmsrq(hwc->config_base, hwc->config);
>  }
>
> -static void snbep_uncore_msr_init_box(struct intel_uncore_box *box)
> +static int snbep_uncore_msr_init_box(struct intel_uncore_box *box)
>  {
>         unsigned msr =3D uncore_msr_box_ctl(box);
>
>         if (msr)
>                 wrmsrq(msr, SNBEP_PMON_BOX_CTL_INT);
> +
> +       return 0;
>  }
>
>  static struct attribute *snbep_uncore_formats_attr[] =3D {
> @@ -1507,18 +1510,21 @@ int snbep_uncore_pci_init(void)
>  /* end of Sandy Bridge-EP uncore support */
>
>  /* IvyTown uncore support */
> -static void ivbep_uncore_msr_init_box(struct intel_uncore_box *box)
> +static int ivbep_uncore_msr_init_box(struct intel_uncore_box *box)
>  {
>         unsigned msr =3D uncore_msr_box_ctl(box);
>         if (msr)
>                 wrmsrq(msr, IVBEP_PMON_BOX_CTL_INT);
> +
> +       return 0;
>  }
>
> -static void ivbep_uncore_pci_init_box(struct intel_uncore_box *box)
> +static int ivbep_uncore_pci_init_box(struct intel_uncore_box *box)
>  {
>         struct pci_dev *pdev =3D box->pci_dev;
>
>         pci_write_config_dword(pdev, SNBEP_PCI_PMON_BOX_CTL, IVBEP_PMON_B=
OX_CTL_INT);
> +       return 0;
>  }
>
>  #define IVBEP_UNCORE_MSR_OPS_COMMON_INIT()                     \
> @@ -2784,7 +2790,7 @@ static struct intel_uncore_type hswep_uncore_cbox =
=3D {
>  /*
>   * Write SBOX Initialization register bit by bit to avoid spurious #GPs
>   */
> -static void hswep_uncore_sbox_msr_init_box(struct intel_uncore_box *box)
> +static int hswep_uncore_sbox_msr_init_box(struct intel_uncore_box *box)
>  {
>         unsigned msr =3D uncore_msr_box_ctl(box);
>
> @@ -2798,6 +2804,8 @@ static void hswep_uncore_sbox_msr_init_box(struct i=
ntel_uncore_box *box)
>                         wrmsrq(msr, flags);
>                 }
>         }
> +
> +       return 0;
>  }
>
>  static struct intel_uncore_ops hswep_uncore_sbox_msr_ops =3D {
> @@ -4160,12 +4168,13 @@ static const struct attribute_group skx_upi_uncor=
e_format_group =3D {
>         .attrs =3D skx_upi_uncore_formats_attr,
>  };
>
> -static void skx_upi_uncore_pci_init_box(struct intel_uncore_box *box)
> +static int skx_upi_uncore_pci_init_box(struct intel_uncore_box *box)
>  {
>         struct pci_dev *pdev =3D box->pci_dev;
>
>         __set_bit(UNCORE_BOX_FLAG_CTL_OFFS8, &box->flags);
>         pci_write_config_dword(pdev, SKX_UPI_PCI_PMON_BOX_CTL, IVBEP_PMON=
_BOX_CTL_INT);
> +       return 0;
>  }
>
>  static struct intel_uncore_ops skx_upi_uncore_pci_ops =3D {
> @@ -4321,12 +4330,13 @@ static struct intel_uncore_type skx_uncore_upi =
=3D {
>         .cleanup_mapping =3D skx_upi_cleanup_mapping,
>  };
>
> -static void skx_m2m_uncore_pci_init_box(struct intel_uncore_box *box)
> +static int skx_m2m_uncore_pci_init_box(struct intel_uncore_box *box)
>  {
>         struct pci_dev *pdev =3D box->pci_dev;
>
>         __set_bit(UNCORE_BOX_FLAG_CTL_OFFS8, &box->flags);
>         pci_write_config_dword(pdev, SKX_M2M_PCI_PMON_BOX_CTL, IVBEP_PMON=
_BOX_CTL_INT);
> +       return 0;
>  }
>
>  static struct intel_uncore_ops skx_m2m_uncore_pci_ops =3D {
> @@ -4829,13 +4839,14 @@ void snr_uncore_cpu_init(void)
>         uncore_msr_uncores =3D snr_msr_uncores;
>  }
>
> -static void snr_m2m_uncore_pci_init_box(struct intel_uncore_box *box)
> +static int snr_m2m_uncore_pci_init_box(struct intel_uncore_box *box)
>  {
>         struct pci_dev *pdev =3D box->pci_dev;
>         int box_ctl =3D uncore_pci_box_ctl(box);
>
>         __set_bit(UNCORE_BOX_FLAG_CTL_OFFS8, &box->flags);
>         pci_write_config_dword(pdev, box_ctl, IVBEP_PMON_BOX_CTL_INT);
> +       return 0;
>  }
>
>  static struct intel_uncore_ops snr_m2m_uncore_pci_ops =3D {
> @@ -5008,17 +5019,22 @@ static int snr_uncore_mmio_map(struct intel_uncor=
e_box *box,
>         return 0;
>  }
>
> -static void __snr_uncore_mmio_init_box(struct intel_uncore_box *box,
> +static int __snr_uncore_mmio_init_box(struct intel_uncore_box *box,
>                                        unsigned int box_ctl, int mem_offs=
et,
>                                        unsigned int device)
>  {
> -       if (!snr_uncore_mmio_map(box, box_ctl, mem_offset, device))
> +       int ret;
> +
> +       ret =3D snr_uncore_mmio_map(box, box_ctl, mem_offset, device);
> +       if (!ret)
>                 writel(IVBEP_PMON_BOX_CTL_INT, box->io_addr);
> +
> +       return ret;
>  }
>
> -static void snr_uncore_mmio_init_box(struct intel_uncore_box *box)
> +static int snr_uncore_mmio_init_box(struct intel_uncore_box *box)
>  {
> -       __snr_uncore_mmio_init_box(box, uncore_mmio_box_ctl(box),
> +       return __snr_uncore_mmio_init_box(box, uncore_mmio_box_ctl(box),
>                                    SNR_IMC_MMIO_MEM0_OFFSET,
>                                    SNR_MC_DEVICE_ID);
>  }
> @@ -5635,14 +5651,14 @@ int icx_uncore_pci_init(void)
>         return 0;
>  }
>
> -static void icx_uncore_imc_init_box(struct intel_uncore_box *box)
> +static int icx_uncore_imc_init_box(struct intel_uncore_box *box)
>  {
>         unsigned int box_ctl =3D box->pmu->type->box_ctl +
>                                box->pmu->type->mmio_offset * (box->pmu->p=
mu_idx % ICX_NUMBER_IMC_CHN);
>         int mem_offset =3D (box->pmu->pmu_idx / ICX_NUMBER_IMC_CHN) * ICX=
_IMC_MEM_STRIDE +
>                          SNR_IMC_MMIO_MEM0_OFFSET;
>
> -       __snr_uncore_mmio_init_box(box, box_ctl, mem_offset,
> +       return __snr_uncore_mmio_init_box(box, box_ctl, mem_offset,
>                                    SNR_MC_DEVICE_ID);
>  }
>
> @@ -5699,12 +5715,12 @@ static struct uncore_event_desc icx_uncore_imc_fr=
eerunning_events[] =3D {
>         { /* end: all zeroes */ },
>  };
>
> -static void icx_uncore_imc_freerunning_init_box(struct intel_uncore_box =
*box)
> +static int icx_uncore_imc_freerunning_init_box(struct intel_uncore_box *=
box)
>  {
>         int mem_offset =3D box->pmu->pmu_idx * ICX_IMC_MEM_STRIDE +
>                          SNR_IMC_MMIO_MEM0_OFFSET;
>
> -       snr_uncore_mmio_map(box, uncore_mmio_box_ctl(box),
> +       return snr_uncore_mmio_map(box, uncore_mmio_box_ctl(box),
>                             mem_offset, SNR_MC_DEVICE_ID);
>  }
>
> @@ -6001,10 +6017,10 @@ static struct intel_uncore_type spr_uncore_mdf =
=3D {
>         .name                   =3D "mdf",
>  };
>
> -static void spr_uncore_mmio_offs8_init_box(struct intel_uncore_box *box)
> +static int spr_uncore_mmio_offs8_init_box(struct intel_uncore_box *box)
>  {
>         __set_bit(UNCORE_BOX_FLAG_CTL_OFFS8, &box->flags);
> -       intel_generic_uncore_mmio_init_box(box);
> +       return intel_generic_uncore_mmio_init_box(box);
>  }
>
>  static struct intel_uncore_ops spr_uncore_mmio_offs8_ops =3D {
> @@ -6185,12 +6201,11 @@ static struct uncore_event_desc spr_uncore_imc_fr=
eerunning_events[] =3D {
>
>  #define SPR_MC_DEVICE_ID       0x3251
>
> -static void spr_uncore_imc_freerunning_init_box(struct intel_uncore_box =
*box)
> +static int spr_uncore_imc_freerunning_init_box(struct intel_uncore_box *=
box)
>  {
>         int mem_offset =3D box->pmu->pmu_idx * ICX_IMC_MEM_STRIDE + SNR_I=
MC_MMIO_MEM0_OFFSET;
> -
> -       snr_uncore_mmio_map(box, uncore_mmio_box_ctl(box),
> -                           mem_offset, SPR_MC_DEVICE_ID);
> +       return snr_uncore_mmio_map(box, uncore_mmio_box_ctl(box),
> +                                  mem_offset, SPR_MC_DEVICE_ID);
>  }
>
>  static struct intel_uncore_ops spr_uncore_imc_freerunning_ops =3D {
> @@ -6879,20 +6894,24 @@ static unsigned int dmr_iio_freerunning_box_offse=
ts[] =3D {
>         0x0, 0x8000, 0x18000, 0x20000
>  };
>
> -static void dmr_uncore_freerunning_init_box(struct intel_uncore_box *box=
)
> +static int dmr_uncore_freerunning_init_box(struct intel_uncore_box *box)
>  {
>         struct intel_uncore_type *type =3D box->pmu->type;
>         u64 mmio_base;
>
>         if (box->pmu->pmu_idx >=3D type->num_boxes)
> -               return;
> +               return -ENODEV;
>
>         mmio_base =3D DMR_IMH1_HIOP_MMIO_BASE;
>         mmio_base +=3D dmr_iio_freerunning_box_offsets[box->pmu->pmu_idx]=
;
>
>         box->io_addr =3D ioremap(mmio_base, type->mmio_map_size);
> -       if (!box->io_addr)
> +       if (!box->io_addr) {
>                 pr_warn("perf uncore: Failed to ioremap for %s.\n", type-=
>name);
> +               return -ENOMEM;
> +       }
> +
> +       return 0;
>  }
>
>  static struct intel_uncore_ops dmr_uncore_freerunning_ops =3D {
> --
> 2.54.0
>
