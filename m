Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903B0C83F17
	for <linux-perf-users@archiver.kernel.org>; Mon, 28 Aug 2023 15:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjH1Pf4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 28 Aug 2023 11:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjH1Pfu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 28 Aug 2023 11:35:50 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A9F1AD
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Aug 2023 08:35:42 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bcc0adab4so440521366b.2
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Aug 2023 08:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693236941; x=1693841741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J20soSuN4iUiNmxOSPdPjy08oKocmaSVaDQ2dqW28vI=;
        b=UJrY4OGBWFJE1SuNYXhydM4g6MnuROT2Nn9Ehvief3kfQCRKN81uwtWSLE2rDDvqi4
         W6iEErllaA8K6cT5zBi8JQkX6e1aKu4nlsXj4Tg8qdzBgT9yi3Ks72KyqXMhdvmM7B6W
         Kl9MLyu6BMHPcV0mMf03MCRFNx+kFrTk98biw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693236941; x=1693841741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J20soSuN4iUiNmxOSPdPjy08oKocmaSVaDQ2dqW28vI=;
        b=Q7kj+T18T7pqF9m0c+YZqrIMFO+IVT8AGJuclnoF1TYjmdrXTYbHm/FPIZ/OHEVXHd
         Po5O1b5U+z8QwCfWCLInAjjUT/f7rSEQFMhC8W4HlOAONSUCwMG4ImgrjU7ck96zyf3o
         ysTrre90ANq1nUOswt8WhEoSgtV4eIGZRRZc29i2Nn+ZHAJszmql61upEi1QSCAw5lhS
         GTu7gaYqSQwkNHQobbonaPIQgIFTMc1Q0W0wdE17mi196PVKWPacegOgBRwVHMOiYR42
         pdvKFJSJLPXFKGlKPw8plJeEZOvNs/Uqc/nNxSn0vyrqon9ySjyaFRAnULLldB45+qLV
         mCiA==
X-Gm-Message-State: AOJu0YxoakJVYmwth1HRT6JYI/d/xoW3IuUCXi1pVO2kOuLUrRMIoBf9
        GO5HuI8NmPn+k8FHHzrOFfFsOT/PA/3qw3RP5h0QLA==
X-Google-Smtp-Source: AGHT+IGe1sowPQNcGEnaHHPmapRo6l9F7PkCVN3toJIX5wDDikWWU85+QZ76Qu3GyNTwhMLWlrLuBQ==
X-Received: by 2002:a17:906:2932:b0:99b:4ed4:5527 with SMTP id v18-20020a170906293200b0099b4ed45527mr18597874ejd.25.1693236940926;
        Mon, 28 Aug 2023 08:35:40 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id dk13-20020a170906f0cd00b00992e14af9c3sm4843160ejb.143.2023.08.28.08.35.40
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 08:35:40 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4005f0a6c2bso117025e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Aug 2023 08:35:40 -0700 (PDT)
X-Received: by 2002:a05:600c:1c23:b0:3f7:3e85:36a with SMTP id
 j35-20020a05600c1c2300b003f73e85036amr308624wms.7.1693236939945; Mon, 28 Aug
 2023 08:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230824153233.1006420-1-dianders@chromium.org>
 <20230824083012.v11.1.I1223c11c88937bd0cbd9b086d4ef216985797302@changeid> <86bkeuf5tm.wl-maz@kernel.org>
In-Reply-To: <86bkeuf5tm.wl-maz@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 28 Aug 2023 08:35:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VaF2ebXX12CY4ZSnj4rSbes9vruBkKf-F6ZdaHBCqkqQ@mail.gmail.com>
Message-ID: <CAD=FV=VaF2ebXX12CY4ZSnj4rSbes9vruBkKf-F6ZdaHBCqkqQ@mail.gmail.com>
Subject: Re: [PATCH v11 1/6] irqchip/gic-v3: Enable support for SGIs to act as NMIs
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kgdb-bugreport@lists.sourceforge.net,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-perf-users@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, ito-yuichi@fujitsu.com,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Sat, Aug 26, 2023 at 3:37=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Thu, 24 Aug 2023 16:30:27 +0100,
> Douglas Anderson <dianders@chromium.org> wrote:
> >
> > As of commit 6abbd6988971 ("irqchip/gic, gic-v3: Make SGIs use
> > handle_percpu_devid_irq()") SGIs are treated the same as PPIs/EPPIs
> > and use handle_percpu_devid_irq() by default. Unfortunately,
> > handle_percpu_devid_irq() isn't NMI safe, and so to run in an NMI
> > context those should use handle_percpu_devid_fasteoi_nmi().
> >
> > In order to accomplish this, we just have to make room for SGIs in the
> > array of refcounts that keeps track of which interrupts are set as
> > NMI. We also rename the array and create a new indexing scheme that
> > accounts for SGIs.
> >
> > Also, enable NMI support prior to gic_smp_init() as allocation of SGIs
> > as IRQs/NMIs happen as part of this routine.
> >
> > Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > In v10 I removed the previous Reviewed-by and Tested-by tags since the
> > patch contents changed pretty drastically.
> >
> > I'll also note that this change is a little more black magic to me
> > than others in this series. I don't have a massive amounts of
> > familiarity with all the moving parts of gic-v3, so I mostly just
> > followed Mark Rutland's advice [1]. Please pay extra attention to make
> > sure I didn't do anything too terrible.
> >
> > Mark's advice wasn't a full patch and I ended up doing a bit of work
> > to translate it to reality, so I did not add him as "Co-developed-by"
> > here. Mark: if you would like this tag then please provide it and your
> > Signed-off-by. I certainly won't object.
> >
> > [1] https://lore.kernel.org/r/ZNC-YRQopO0PaIIo@FVFF77S0Q05N.cambridge.a=
rm.com
> >
> > (no changes since v10)
> >
> > Changes in v10:
> > - Rewrite as needed for 5.11+ as per Mark Rutland and Sumit.
> >
> >  drivers/irqchip/irq-gic-v3.c | 54 ++++++++++++++++++++++++------------
> >  1 file changed, 36 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.=
c
> > index eedfa8e9f077..49d18cf3f636 100644
> > --- a/drivers/irqchip/irq-gic-v3.c
> > +++ b/drivers/irqchip/irq-gic-v3.c
> > @@ -78,6 +78,8 @@ static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key=
);
> >  #define GIC_LINE_NR  min(GICD_TYPER_SPIS(gic_data.rdists.gicd_typer), =
1020U)
> >  #define GIC_ESPI_NR  GICD_TYPER_ESPIS(gic_data.rdists.gicd_typer)
> >
> > +#define SGI_NR               16
>
> Why 16? We only allocate 8, as the other 8 are potentially stolen by
> the secure side. We do try and initialise them all so that they have a
> known state if they were actually configured as Group-1NS, but we
> don't use them.
>
> I understand that this simplifies the indexing in the rdist_nmi_refs
> array and I'm not going to cry over 32 wasted bytes, but this
> definitely deserves a comment.

Good point. I'll plan to wait another day or two to see if any other
feedback shows up and then send a v12 with this plus Stephen's nit
fixes on one of the other patches.

-Doug
