Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55329C4743D
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Jun 2021 19:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FF0D61246
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Jun 2021 19:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238014AbhFHTcK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Jun 2021 15:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238021AbhFHT3Z (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Jun 2021 15:29:25 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A668C06114E;
        Tue,  8 Jun 2021 12:17:26 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id r16so9313528ljk.9;
        Tue, 08 Jun 2021 12:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cosITyDQl2L25+4lyg/BG4bp6XU6pX4jWaFVKHxz0aI=;
        b=bmQdXKuLqJZc33OTfgDObSxISRstiWSe8iGno3AolJpZYwKz08U7c9qRpXDCOy5Gme
         7CRNpCotHHFxBsJj58cwqLV4vAJo4H+tEkuW6PAW0TPJWwG6tXKTlygcMyoJCGLd6pP1
         MiV6gvD+uvH8kcQuA/MaNDt8FWhlDJmiwB1rC3VRvKDjScvnuJ+crPgzebjX7JD/Pb4a
         Jr223NNZqugxupTx44dsXm0RgCIBsCrzpXTqA4FBdzMPsaxM3iALTBYv6jgF3Pn+OFBj
         q2PJjVtYOuJf4Z7TEyH7XCHq5Usb4IP8FuwPeYhNnbswaPKSTwNQYscCS0+mv+vUXUtY
         faug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cosITyDQl2L25+4lyg/BG4bp6XU6pX4jWaFVKHxz0aI=;
        b=XRh9XtOGbRJuhCT3i8cdyPwrLbSYH+EOJelNQ/s5GIWBZh5pyzvXaQfYXhiquZjI/G
         LiSjeEvZQ8UD3WTZY2sFZ6j+pdgQZmNna6CTLepQRLMylDVEUYDmmSmw+7XHjV4vVNzp
         Oto5AWGduiEKytY43CvjHVM3lY2hrurZxAv0n9WxQKmGFBbqfltZ7tVuX9rKt4Bx5aWJ
         75igLcZFx/PclVJMpdxa+zYn3tJSO2YZpdCcmMcS8x89rS+nhKuFrYCbJTXjZWJzt8UB
         BINOWHZJBUqGH4l/hgdNwIDYPfgrXrkTtCkfITbSGRcUfbicqMdY4qwOLO2zL5XpKVTl
         HPGg==
X-Gm-Message-State: AOAM533BEKqXvnpxx0At35S7m+rdfEOY5VLHnpxoW8ZJ5QFXqAgy78y2
        gcwRofl0tuGvFnyJLmwFdG8=
X-Google-Smtp-Source: ABdhPJywqNlBsmVgsAvbdkDdTrSf8CTQZIyMq57isjRipyczl9dZGXf7d0RQ4ln2sjkxm8IT//3DBg==
X-Received: by 2002:a05:651c:210e:: with SMTP id a14mr20397039ljq.156.1623179844587;
        Tue, 08 Jun 2021 12:17:24 -0700 (PDT)
Received: from rikard (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id f39sm66959lfv.290.2021.06.08.12.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 12:17:23 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Tue, 8 Jun 2021 21:17:20 +0200
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Antonov <alexander.antonov@linux.intel.com>
Subject: Re: [PATCH 1/4] perf/x86/intel/uncore: Constify intel_uncore_ops
Message-ID: <YL/CQIA0vk1CiQcf@rikard>
References: <20210605155653.21850-1-rikard.falkeborn@gmail.com>
 <20210605155653.21850-2-rikard.falkeborn@gmail.com>
 <77212f9f-1914-afd2-99c1-a5ced5b7c265@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77212f9f-1914-afd2-99c1-a5ced5b7c265@linux.intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jun 07, 2021 at 03:09:11PM -0400, Liang, Kan wrote:
> 
> 
> On 6/5/2021 11:56 AM, Rikard Falkeborn wrote:
> > These are not modified, so make them const to allow the compiler to put
> > them in read-only memory.
> 
> For most of the cases, yes, but the ops are modified for the TGL/RKL. We may
> want to create a read-only ops for the TGL/RKL as below, and make both
> skl_uncore_msr_ops and rkl_uncore_msr_ops const as well.
> 
Thanks for the feedback.

Yes, that was the odd one out, the commit message could have been
clearer. What I meant above was "Constify all intel_uncore_ops that are
not modified", which was all but skl_uncore_msr_ops. So the patch is
correct, but in order to also constify skl_uncore_msr_ops, we could do
as you suggested. Is it worth doing? And if so, in a V2 of this patch,
or as a follow-up patch?

Thanks,
Rikard
> 
> diff --git a/arch/x86/events/intel/uncore_snb.c
> b/arch/x86/events/intel/uncore_snb.c
> index 0f63706..e750514 100644
> --- a/arch/x86/events/intel/uncore_snb.c
> +++ b/arch/x86/events/intel/uncore_snb.c
> @@ -435,14 +435,22 @@ static void rkl_uncore_msr_init_box(struct
> intel_uncore_box *box)
>  		wrmsrl(SKL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
>  }
> 
> +static struct intel_uncore_ops rkl_uncore_msr_ops = {
> +	.init_box	= rkl_uncore_msr_init_box,
> +	.enable_box	= skl_uncore_msr_enable_box,
> +	.exit_box	= skl_uncore_msr_exit_box,
> +	.disable_event	= snb_uncore_msr_disable_event,
> +	.enable_event	= snb_uncore_msr_enable_event,
> +	.read_counter	= uncore_msr_read_counter,
> +};
> +
>  void tgl_uncore_cpu_init(void)
>  {
>  	uncore_msr_uncores = tgl_msr_uncores;
>  	icl_uncore_cbox.num_boxes = icl_get_cbox_num();
> -	icl_uncore_cbox.ops = &skl_uncore_msr_ops;
> -	icl_uncore_clockbox.ops = &skl_uncore_msr_ops;
> -	snb_uncore_arb.ops = &skl_uncore_msr_ops;
> -	skl_uncore_msr_ops.init_box = rkl_uncore_msr_init_box;
> +	icl_uncore_cbox.ops = &rkl_uncore_msr_ops;
> +	icl_uncore_clockbox.ops = &rkl_uncore_msr_ops;
> +	snb_uncore_arb.ops = &rkl_uncore_msr_ops;
>  }
> 
>  static void adl_uncore_msr_init_box(struct intel_uncore_box *box)
> 
> Thanks,
> Kan
> 
> 
> > 
> > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> > ---
> >   arch/x86/events/intel/uncore.h           |  2 +-
> >   arch/x86/events/intel/uncore_discovery.c |  6 +--
> >   arch/x86/events/intel/uncore_nhmex.c     | 10 ++--
> >   arch/x86/events/intel/uncore_snb.c       | 12 ++---
> >   arch/x86/events/intel/uncore_snbep.c     | 66 ++++++++++++------------
> >   5 files changed, 48 insertions(+), 48 deletions(-)
> > 
> > diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
> > index 187d7287039c..83b25a7b8c27 100644
> > --- a/arch/x86/events/intel/uncore.h
> > +++ b/arch/x86/events/intel/uncore.h
> > @@ -77,7 +77,7 @@ struct intel_uncore_type {
> >   	struct event_constraint unconstrainted;
> >   	struct event_constraint *constraints;
> >   	struct intel_uncore_pmu *pmus;
> > -	struct intel_uncore_ops *ops;
> > +	const struct intel_uncore_ops *ops;
> >   	struct uncore_event_desc *event_descs;
> >   	struct freerunning_counters *freerunning;
> >   	const struct attribute_group *attr_groups[4];
> > diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
> > index aba9bff95413..2b8e9a1d793e 100644
> > --- a/arch/x86/events/intel/uncore_discovery.c
> > +++ b/arch/x86/events/intel/uncore_discovery.c
> > @@ -368,7 +368,7 @@ static void intel_generic_uncore_msr_disable_event(struct intel_uncore_box *box,
> >   	wrmsrl(hwc->config_base, 0);
> >   }
> > -static struct intel_uncore_ops generic_uncore_msr_ops = {
> > +static const struct intel_uncore_ops generic_uncore_msr_ops = {
> >   	.init_box		= intel_generic_uncore_msr_init_box,
> >   	.disable_box		= intel_generic_uncore_msr_disable_box,
> >   	.enable_box		= intel_generic_uncore_msr_enable_box,
> > @@ -433,7 +433,7 @@ static u64 intel_generic_uncore_pci_read_counter(struct intel_uncore_box *box,
> >   	return count;
> >   }
> > -static struct intel_uncore_ops generic_uncore_pci_ops = {
> > +static const struct intel_uncore_ops generic_uncore_pci_ops = {
> >   	.init_box	= intel_generic_uncore_pci_init_box,
> >   	.disable_box	= intel_generic_uncore_pci_disable_box,
> >   	.enable_box	= intel_generic_uncore_pci_enable_box,
> > @@ -516,7 +516,7 @@ static void intel_generic_uncore_mmio_disable_event(struct intel_uncore_box *box
> >   	writel(0, box->io_addr + hwc->config_base);
> >   }
> > -static struct intel_uncore_ops generic_uncore_mmio_ops = {
> > +static const struct intel_uncore_ops generic_uncore_mmio_ops = {
> >   	.init_box	= intel_generic_uncore_mmio_init_box,
> >   	.exit_box	= uncore_mmio_exit_box,
> >   	.disable_box	= intel_generic_uncore_mmio_disable_box,
> > diff --git a/arch/x86/events/intel/uncore_nhmex.c b/arch/x86/events/intel/uncore_nhmex.c
> > index 173e2674be6e..5f7c27d7f428 100644
> > --- a/arch/x86/events/intel/uncore_nhmex.c
> > +++ b/arch/x86/events/intel/uncore_nhmex.c
> > @@ -262,7 +262,7 @@ static void nhmex_uncore_msr_enable_event(struct intel_uncore_box *box, struct p
> >   	.disable_event	= nhmex_uncore_msr_disable_event,	\
> >   	.read_counter	= uncore_msr_read_counter
> > -static struct intel_uncore_ops nhmex_uncore_ops = {
> > +static const struct intel_uncore_ops nhmex_uncore_ops = {
> >   	NHMEX_UNCORE_OPS_COMMON_INIT(),
> >   	.enable_event	= nhmex_uncore_msr_enable_event,
> >   };
> > @@ -413,7 +413,7 @@ static const struct attribute_group nhmex_uncore_bbox_format_group = {
> >   	.attrs = nhmex_uncore_bbox_formats_attr,
> >   };
> > -static struct intel_uncore_ops nhmex_uncore_bbox_ops = {
> > +static const struct intel_uncore_ops nhmex_uncore_bbox_ops = {
> >   	NHMEX_UNCORE_OPS_COMMON_INIT(),
> >   	.enable_event		= nhmex_bbox_msr_enable_event,
> >   	.hw_config		= nhmex_bbox_hw_config,
> > @@ -490,7 +490,7 @@ static const struct attribute_group nhmex_uncore_sbox_format_group = {
> >   	.attrs			= nhmex_uncore_sbox_formats_attr,
> >   };
> > -static struct intel_uncore_ops nhmex_uncore_sbox_ops = {
> > +static const struct intel_uncore_ops nhmex_uncore_sbox_ops = {
> >   	NHMEX_UNCORE_OPS_COMMON_INIT(),
> >   	.enable_event		= nhmex_sbox_msr_enable_event,
> >   	.hw_config		= nhmex_sbox_hw_config,
> > @@ -916,7 +916,7 @@ static struct uncore_event_desc wsmex_uncore_mbox_events[] = {
> >   	{ /* end: all zeroes */ },
> >   };
> > -static struct intel_uncore_ops nhmex_uncore_mbox_ops = {
> > +static const struct intel_uncore_ops nhmex_uncore_mbox_ops = {
> >   	NHMEX_UNCORE_OPS_COMMON_INIT(),
> >   	.enable_event	= nhmex_mbox_msr_enable_event,
> >   	.hw_config	= nhmex_mbox_hw_config,
> > @@ -1179,7 +1179,7 @@ static struct uncore_event_desc nhmex_uncore_rbox_events[] = {
> >   	{ /* end: all zeroes */ },
> >   };
> > -static struct intel_uncore_ops nhmex_uncore_rbox_ops = {
> > +static const struct intel_uncore_ops nhmex_uncore_rbox_ops = {
> >   	NHMEX_UNCORE_OPS_COMMON_INIT(),
> >   	.enable_event		= nhmex_rbox_msr_enable_event,
> >   	.hw_config		= nhmex_rbox_hw_config,
> > diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
> > index 0f63706cdadf..5826cff568f4 100644
> > --- a/arch/x86/events/intel/uncore_snb.c
> > +++ b/arch/x86/events/intel/uncore_snb.c
> > @@ -216,7 +216,7 @@ static const struct attribute_group snb_uncore_format_group = {
> >   	.attrs		= snb_uncore_formats_attr,
> >   };
> > -static struct intel_uncore_ops snb_uncore_msr_ops = {
> > +static const struct intel_uncore_ops snb_uncore_msr_ops = {
> >   	.init_box	= snb_uncore_msr_init_box,
> >   	.enable_box	= snb_uncore_msr_enable_box,
> >   	.exit_box	= snb_uncore_msr_exit_box,
> > @@ -341,7 +341,7 @@ void skl_uncore_cpu_init(void)
> >   	snb_uncore_arb.ops = &skl_uncore_msr_ops;
> >   }
> > -static struct intel_uncore_ops icl_uncore_msr_ops = {
> > +static const struct intel_uncore_ops icl_uncore_msr_ops = {
> >   	.disable_event	= snb_uncore_msr_disable_event,
> >   	.enable_event	= snb_uncore_msr_enable_event,
> >   	.read_counter	= uncore_msr_read_counter,
> > @@ -468,7 +468,7 @@ static void adl_uncore_msr_exit_box(struct intel_uncore_box *box)
> >   		wrmsrl(ADL_UNC_PERF_GLOBAL_CTL, 0);
> >   }
> > -static struct intel_uncore_ops adl_uncore_msr_ops = {
> > +static const struct intel_uncore_ops adl_uncore_msr_ops = {
> >   	.init_box	= adl_uncore_msr_init_box,
> >   	.enable_box	= adl_uncore_msr_enable_box,
> >   	.disable_box	= adl_uncore_msr_disable_box,
> > @@ -799,7 +799,7 @@ static struct pmu snb_uncore_imc_pmu = {
> >   	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> >   };
> > -static struct intel_uncore_ops snb_uncore_imc_ops = {
> > +static const struct intel_uncore_ops snb_uncore_imc_ops = {
> >   	.init_box	= snb_uncore_imc_init_box,
> >   	.exit_box	= uncore_mmio_exit_box,
> >   	.enable_box	= snb_uncore_imc_enable_box,
> > @@ -1267,7 +1267,7 @@ static struct uncore_event_desc nhm_uncore_events[] = {
> >   	{ /* end: all zeroes */ },
> >   };
> > -static struct intel_uncore_ops nhm_uncore_msr_ops = {
> > +static const struct intel_uncore_ops nhm_uncore_msr_ops = {
> >   	.disable_box	= nhm_uncore_msr_disable_box,
> >   	.enable_box	= nhm_uncore_msr_enable_box,
> >   	.disable_event	= snb_uncore_msr_disable_event,
> > @@ -1422,7 +1422,7 @@ static void tgl_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
> >   		pr_warn("perf uncore: Failed to ioremap for %s.\n", type->name);
> >   }
> > -static struct intel_uncore_ops tgl_uncore_imc_freerunning_ops = {
> > +static const struct intel_uncore_ops tgl_uncore_imc_freerunning_ops = {
> >   	.init_box	= tgl_uncore_imc_freerunning_init_box,
> >   	.exit_box	= uncore_mmio_exit_box,
> >   	.read_counter	= uncore_mmio_read_counter,
> > diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> > index bb6eb1e5569c..43eabe8d37dc 100644
> > --- a/arch/x86/events/intel/uncore_snbep.c
> > +++ b/arch/x86/events/intel/uncore_snbep.c
> > @@ -775,7 +775,7 @@ static const struct attribute_group snbep_uncore_qpi_format_group = {
> >   	__SNBEP_UNCORE_MSR_OPS_COMMON_INIT(),			\
> >   	.init_box	= snbep_uncore_msr_init_box		\
> > -static struct intel_uncore_ops snbep_uncore_msr_ops = {
> > +static const struct intel_uncore_ops snbep_uncore_msr_ops = {
> >   	SNBEP_UNCORE_MSR_OPS_COMMON_INIT(),
> >   };
> > @@ -786,7 +786,7 @@ static struct intel_uncore_ops snbep_uncore_msr_ops = {
> >   	.disable_event	= snbep_uncore_pci_disable_event,	\
> >   	.read_counter	= snbep_uncore_pci_read_counter
> > -static struct intel_uncore_ops snbep_uncore_pci_ops = {
> > +static const struct intel_uncore_ops snbep_uncore_pci_ops = {
> >   	SNBEP_UNCORE_PCI_OPS_COMMON_INIT(),
> >   	.enable_event	= snbep_uncore_pci_enable_event,	\
> >   };
> > @@ -1017,7 +1017,7 @@ static int snbep_cbox_hw_config(struct intel_uncore_box *box, struct perf_event
> >   	return 0;
> >   }
> > -static struct intel_uncore_ops snbep_uncore_cbox_ops = {
> > +static const struct intel_uncore_ops snbep_uncore_cbox_ops = {
> >   	SNBEP_UNCORE_MSR_OPS_COMMON_INIT(),
> >   	.hw_config		= snbep_cbox_hw_config,
> >   	.get_constraint		= snbep_cbox_get_constraint,
> > @@ -1127,7 +1127,7 @@ static int snbep_pcu_hw_config(struct intel_uncore_box *box, struct perf_event *
> >   	return 0;
> >   }
> > -static struct intel_uncore_ops snbep_uncore_pcu_ops = {
> > +static const struct intel_uncore_ops snbep_uncore_pcu_ops = {
> >   	SNBEP_UNCORE_MSR_OPS_COMMON_INIT(),
> >   	.hw_config		= snbep_pcu_hw_config,
> >   	.get_constraint		= snbep_pcu_get_constraint,
> > @@ -1211,7 +1211,7 @@ static void snbep_qpi_enable_event(struct intel_uncore_box *box, struct perf_eve
> >   	pci_write_config_dword(pdev, hwc->config_base, hwc->config | SNBEP_PMON_CTL_EN);
> >   }
> > -static struct intel_uncore_ops snbep_uncore_qpi_ops = {
> > +static const struct intel_uncore_ops snbep_uncore_qpi_ops = {
> >   	SNBEP_UNCORE_PCI_OPS_COMMON_INIT(),
> >   	.enable_event		= snbep_qpi_enable_event,
> >   	.hw_config		= snbep_qpi_hw_config,
> > @@ -1517,11 +1517,11 @@ static void ivbep_uncore_pci_init_box(struct intel_uncore_box *box)
> >   	.enable_event	= snbep_uncore_msr_enable_event,	\
> >   	.read_counter	= uncore_msr_read_counter
> > -static struct intel_uncore_ops ivbep_uncore_msr_ops = {
> > +static const struct intel_uncore_ops ivbep_uncore_msr_ops = {
> >   	IVBEP_UNCORE_MSR_OPS_COMMON_INIT(),
> >   };
> > -static struct intel_uncore_ops ivbep_uncore_pci_ops = {
> > +static const struct intel_uncore_ops ivbep_uncore_pci_ops = {
> >   	.init_box	= ivbep_uncore_pci_init_box,
> >   	.disable_box	= snbep_uncore_pci_disable_box,
> >   	.enable_box	= snbep_uncore_pci_enable_box,
> > @@ -1757,7 +1757,7 @@ static void ivbep_cbox_enable_event(struct intel_uncore_box *box, struct perf_ev
> >   	wrmsrl(hwc->config_base, hwc->config | SNBEP_PMON_CTL_EN);
> >   }
> > -static struct intel_uncore_ops ivbep_uncore_cbox_ops = {
> > +static const struct intel_uncore_ops ivbep_uncore_cbox_ops = {
> >   	.init_box		= ivbep_uncore_msr_init_box,
> >   	.disable_box		= snbep_uncore_msr_disable_box,
> >   	.enable_box		= snbep_uncore_msr_enable_box,
> > @@ -1785,7 +1785,7 @@ static struct intel_uncore_type ivbep_uncore_cbox = {
> >   	.format_group		= &ivbep_uncore_cbox_format_group,
> >   };
> > -static struct intel_uncore_ops ivbep_uncore_pcu_ops = {
> > +static const struct intel_uncore_ops ivbep_uncore_pcu_ops = {
> >   	IVBEP_UNCORE_MSR_OPS_COMMON_INIT(),
> >   	.hw_config		= snbep_pcu_hw_config,
> >   	.get_constraint		= snbep_pcu_get_constraint,
> > @@ -1873,7 +1873,7 @@ static u64 ivbep_uncore_irp_read_counter(struct intel_uncore_box *box, struct pe
> >   	return count;
> >   }
> > -static struct intel_uncore_ops ivbep_uncore_irp_ops = {
> > +static const struct intel_uncore_ops ivbep_uncore_irp_ops = {
> >   	.init_box	= ivbep_uncore_pci_init_box,
> >   	.disable_box	= snbep_uncore_pci_disable_box,
> >   	.enable_box	= snbep_uncore_pci_enable_box,
> > @@ -1893,7 +1893,7 @@ static struct intel_uncore_type ivbep_uncore_irp = {
> >   	.format_group		= &ivbep_uncore_format_group,
> >   };
> > -static struct intel_uncore_ops ivbep_uncore_qpi_ops = {
> > +static const struct intel_uncore_ops ivbep_uncore_qpi_ops = {
> >   	.init_box	= ivbep_uncore_pci_init_box,
> >   	.disable_box	= snbep_uncore_pci_disable_box,
> >   	.enable_box	= snbep_uncore_pci_enable_box,
> > @@ -2178,7 +2178,7 @@ static int knl_cha_hw_config(struct intel_uncore_box *box,
> >   static void hswep_cbox_enable_event(struct intel_uncore_box *box,
> >   				    struct perf_event *event);
> > -static struct intel_uncore_ops knl_uncore_cha_ops = {
> > +static const struct intel_uncore_ops knl_uncore_cha_ops = {
> >   	.init_box		= snbep_uncore_msr_init_box,
> >   	.disable_box		= snbep_uncore_msr_disable_box,
> >   	.enable_box		= snbep_uncore_msr_enable_box,
> > @@ -2272,7 +2272,7 @@ static void knl_uncore_imc_enable_event(struct intel_uncore_box *box,
> >   				       hwc->config | SNBEP_PMON_CTL_EN);
> >   }
> > -static struct intel_uncore_ops knl_uncore_imc_ops = {
> > +static const struct intel_uncore_ops knl_uncore_imc_ops = {
> >   	.init_box	= snbep_uncore_pci_init_box,
> >   	.disable_box	= snbep_uncore_pci_disable_box,
> >   	.enable_box	= knl_uncore_imc_enable_box,
> > @@ -2581,7 +2581,7 @@ static int hswep_ubox_hw_config(struct intel_uncore_box *box, struct perf_event
> >   	return 0;
> >   }
> > -static struct intel_uncore_ops hswep_uncore_ubox_ops = {
> > +static const struct intel_uncore_ops hswep_uncore_ubox_ops = {
> >   	SNBEP_UNCORE_MSR_OPS_COMMON_INIT(),
> >   	.hw_config		= hswep_ubox_hw_config,
> >   	.get_constraint		= uncore_get_constraint,
> > @@ -2741,7 +2741,7 @@ static void hswep_cbox_enable_event(struct intel_uncore_box *box,
> >   	wrmsrl(hwc->config_base, hwc->config | SNBEP_PMON_CTL_EN);
> >   }
> > -static struct intel_uncore_ops hswep_uncore_cbox_ops = {
> > +static const struct intel_uncore_ops hswep_uncore_cbox_ops = {
> >   	.init_box		= snbep_uncore_msr_init_box,
> >   	.disable_box		= snbep_uncore_msr_disable_box,
> >   	.enable_box		= snbep_uncore_msr_enable_box,
> > @@ -2788,7 +2788,7 @@ static void hswep_uncore_sbox_msr_init_box(struct intel_uncore_box *box)
> >   	}
> >   }
> > -static struct intel_uncore_ops hswep_uncore_sbox_msr_ops = {
> > +static const struct intel_uncore_ops hswep_uncore_sbox_msr_ops = {
> >   	__SNBEP_UNCORE_MSR_OPS_COMMON_INIT(),
> >   	.init_box		= hswep_uncore_sbox_msr_init_box
> >   };
> > @@ -2836,7 +2836,7 @@ static int hswep_pcu_hw_config(struct intel_uncore_box *box, struct perf_event *
> >   	return 0;
> >   }
> > -static struct intel_uncore_ops hswep_uncore_pcu_ops = {
> > +static const struct intel_uncore_ops hswep_uncore_pcu_ops = {
> >   	SNBEP_UNCORE_MSR_OPS_COMMON_INIT(),
> >   	.hw_config		= hswep_pcu_hw_config,
> >   	.get_constraint		= snbep_pcu_get_constraint,
> > @@ -2941,7 +2941,7 @@ static u64 hswep_uncore_irp_read_counter(struct intel_uncore_box *box, struct pe
> >   	return count;
> >   }
> > -static struct intel_uncore_ops hswep_uncore_irp_ops = {
> > +static const struct intel_uncore_ops hswep_uncore_irp_ops = {
> >   	.init_box	= snbep_uncore_pci_init_box,
> >   	.disable_box	= snbep_uncore_pci_disable_box,
> >   	.enable_box	= snbep_uncore_pci_enable_box,
> > @@ -3611,7 +3611,7 @@ static int skx_cha_hw_config(struct intel_uncore_box *box, struct perf_event *ev
> >   	return 0;
> >   }
> > -static struct intel_uncore_ops skx_uncore_chabox_ops = {
> > +static const struct intel_uncore_ops skx_uncore_chabox_ops = {
> >   	/* There is no frz_en for chabox ctl */
> >   	.init_box		= ivbep_uncore_msr_init_box,
> >   	.disable_box		= snbep_uncore_msr_disable_box,
> > @@ -3673,7 +3673,7 @@ static void skx_iio_enable_event(struct intel_uncore_box *box,
> >   	wrmsrl(hwc->config_base, hwc->config | SNBEP_PMON_CTL_EN);
> >   }
> > -static struct intel_uncore_ops skx_uncore_iio_ops = {
> > +static const struct intel_uncore_ops skx_uncore_iio_ops = {
> >   	.init_box		= ivbep_uncore_msr_init_box,
> >   	.disable_box		= snbep_uncore_msr_disable_box,
> >   	.enable_box		= snbep_uncore_msr_enable_box,
> > @@ -3931,7 +3931,7 @@ static struct uncore_event_desc skx_uncore_iio_freerunning_events[] = {
> >   	{ /* end: all zeroes */ },
> >   };
> > -static struct intel_uncore_ops skx_uncore_iio_freerunning_ops = {
> > +static const struct intel_uncore_ops skx_uncore_iio_freerunning_ops = {
> >   	.read_counter		= uncore_msr_read_counter,
> >   	.hw_config		= uncore_freerunning_hw_config,
> >   };
> > @@ -4006,7 +4006,7 @@ static struct attribute_group skx_uncore_pcu_format_group = {
> >   	.attrs = skx_uncore_pcu_formats_attr,
> >   };
> > -static struct intel_uncore_ops skx_uncore_pcu_ops = {
> > +static const struct intel_uncore_ops skx_uncore_pcu_ops = {
> >   	IVBEP_UNCORE_MSR_OPS_COMMON_INIT(),
> >   	.hw_config		= hswep_pcu_hw_config,
> >   	.get_constraint		= snbep_pcu_get_constraint,
> > @@ -4105,7 +4105,7 @@ static void skx_upi_uncore_pci_init_box(struct intel_uncore_box *box)
> >   	pci_write_config_dword(pdev, SKX_UPI_PCI_PMON_BOX_CTL, IVBEP_PMON_BOX_CTL_INT);
> >   }
> > -static struct intel_uncore_ops skx_upi_uncore_pci_ops = {
> > +static const struct intel_uncore_ops skx_upi_uncore_pci_ops = {
> >   	.init_box	= skx_upi_uncore_pci_init_box,
> >   	.disable_box	= snbep_uncore_pci_disable_box,
> >   	.enable_box	= snbep_uncore_pci_enable_box,
> > @@ -4136,7 +4136,7 @@ static void skx_m2m_uncore_pci_init_box(struct intel_uncore_box *box)
> >   	pci_write_config_dword(pdev, SKX_M2M_PCI_PMON_BOX_CTL, IVBEP_PMON_BOX_CTL_INT);
> >   }
> > -static struct intel_uncore_ops skx_m2m_uncore_pci_ops = {
> > +static const struct intel_uncore_ops skx_m2m_uncore_pci_ops = {
> >   	.init_box	= skx_m2m_uncore_pci_init_box,
> >   	.disable_box	= snbep_uncore_pci_disable_box,
> >   	.enable_box	= snbep_uncore_pci_enable_box,
> > @@ -4373,7 +4373,7 @@ static void snr_cha_enable_event(struct intel_uncore_box *box,
> >   	wrmsrl(hwc->config_base, hwc->config | SNBEP_PMON_CTL_EN);
> >   }
> > -static struct intel_uncore_ops snr_uncore_chabox_ops = {
> > +static const struct intel_uncore_ops snr_uncore_chabox_ops = {
> >   	.init_box		= ivbep_uncore_msr_init_box,
> >   	.disable_box		= snbep_uncore_msr_disable_box,
> >   	.enable_box		= snbep_uncore_msr_enable_box,
> > @@ -4560,7 +4560,7 @@ static int snr_pcu_hw_config(struct intel_uncore_box *box, struct perf_event *ev
> >   	return 0;
> >   }
> > -static struct intel_uncore_ops snr_uncore_pcu_ops = {
> > +static const struct intel_uncore_ops snr_uncore_pcu_ops = {
> >   	IVBEP_UNCORE_MSR_OPS_COMMON_INIT(),
> >   	.hw_config		= snr_pcu_hw_config,
> >   	.get_constraint		= snbep_pcu_get_constraint,
> > @@ -4660,7 +4660,7 @@ static void snr_m2m_uncore_pci_init_box(struct intel_uncore_box *box)
> >   	pci_write_config_dword(pdev, box_ctl, IVBEP_PMON_BOX_CTL_INT);
> >   }
> > -static struct intel_uncore_ops snr_m2m_uncore_pci_ops = {
> > +static const struct intel_uncore_ops snr_m2m_uncore_pci_ops = {
> >   	.init_box	= snr_m2m_uncore_pci_init_box,
> >   	.disable_box	= snbep_uncore_pci_disable_box,
> >   	.enable_box	= snbep_uncore_pci_enable_box,
> > @@ -4706,7 +4706,7 @@ static void snr_uncore_pci_enable_event(struct intel_uncore_box *box, struct per
> >   	pci_write_config_dword(pdev, hwc->config_base + 4, (u32)(hwc->config >> 32));
> >   }
> > -static struct intel_uncore_ops snr_pcie3_uncore_pci_ops = {
> > +static const struct intel_uncore_ops snr_pcie3_uncore_pci_ops = {
> >   	.init_box	= snr_m2m_uncore_pci_init_box,
> >   	.disable_box	= snbep_uncore_pci_disable_box,
> >   	.enable_box	= snbep_uncore_pci_enable_box,
> > @@ -4884,7 +4884,7 @@ static void snr_uncore_mmio_disable_event(struct intel_uncore_box *box,
> >   	writel(hwc->config, box->io_addr + hwc->config_base);
> >   }
> > -static struct intel_uncore_ops snr_uncore_mmio_ops = {
> > +static const struct intel_uncore_ops snr_uncore_mmio_ops = {
> >   	.init_box	= snr_uncore_mmio_init_box,
> >   	.exit_box	= uncore_mmio_exit_box,
> >   	.disable_box	= snr_uncore_mmio_disable_box,
> > @@ -4948,7 +4948,7 @@ static struct uncore_event_desc snr_uncore_imc_freerunning_events[] = {
> >   	{ /* end: all zeroes */ },
> >   };
> > -static struct intel_uncore_ops snr_uncore_imc_freerunning_ops = {
> > +static const struct intel_uncore_ops snr_uncore_imc_freerunning_ops = {
> >   	.init_box	= snr_uncore_mmio_init_box,
> >   	.exit_box	= uncore_mmio_exit_box,
> >   	.read_counter	= uncore_mmio_read_counter,
> > @@ -5005,7 +5005,7 @@ static int icx_cha_hw_config(struct intel_uncore_box *box, struct perf_event *ev
> >   	return 0;
> >   }
> > -static struct intel_uncore_ops icx_uncore_chabox_ops = {
> > +static const struct intel_uncore_ops icx_uncore_chabox_ops = {
> >   	.init_box		= ivbep_uncore_msr_init_box,
> >   	.disable_box		= snbep_uncore_msr_disable_box,
> >   	.enable_box		= snbep_uncore_msr_enable_box,
> > @@ -5406,7 +5406,7 @@ static void icx_uncore_imc_init_box(struct intel_uncore_box *box)
> >   	__snr_uncore_mmio_init_box(box, box_ctl, mem_offset);
> >   }
> > -static struct intel_uncore_ops icx_uncore_mmio_ops = {
> > +static const struct intel_uncore_ops icx_uncore_mmio_ops = {
> >   	.init_box	= icx_uncore_imc_init_box,
> >   	.exit_box	= uncore_mmio_exit_box,
> >   	.disable_box	= snr_uncore_mmio_disable_box,
> > @@ -5476,7 +5476,7 @@ static void icx_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
> >   	__snr_uncore_mmio_init_box(box, uncore_mmio_box_ctl(box), mem_offset);
> >   }
> > -static struct intel_uncore_ops icx_uncore_imc_freerunning_ops = {
> > +static const struct intel_uncore_ops icx_uncore_imc_freerunning_ops = {
> >   	.init_box	= icx_uncore_imc_freerunning_init_box,
> >   	.exit_box	= uncore_mmio_exit_box,
> >   	.read_counter	= uncore_mmio_read_counter,
> > 
