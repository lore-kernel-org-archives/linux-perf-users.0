Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71178C07E95
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 15:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46BE5611AB
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 15:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbhGMPvP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jul 2021 11:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237061AbhGMPvP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jul 2021 11:51:15 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F78FC0613E9
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jul 2021 08:48:25 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c15so11305795pls.13
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jul 2021 08:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nOwfQkcUfoATzJqAE5bisD/PokYKrCYviR8WyjP18Ic=;
        b=IUP2Pn9R2xrjs8iHm7lcOdGOcLhhCOL7rCwupu8dwAtL9t2rkM4XJWKrJJ/daLRvWD
         XfdgrAx+sffHZtp/1o7u2AnnkOjET+Vs32kTTN0JbP0a9ojq3hWpXB9OQWoJ7Y02T9uJ
         ++1P5Ds8obO2eLfheTKugZMgh91ftTf4E3cHXhlPpYAClTmQuFaKSvDNgjOnHAIBQWI3
         G27rIN1lt3yxSuYDzW8P4eNcekR/LpFuOph9Bcskpcd2KbRBU3ihS1T49svnhsDuG96+
         729GkE05pZDr8iQILLchxtUsvkYCTiOLVAvTiNRpi90cctkETvoymJRNVxVKhNzbBaUH
         TqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nOwfQkcUfoATzJqAE5bisD/PokYKrCYviR8WyjP18Ic=;
        b=d3jzOIU08uo7iogrRTAIf/DIAAk9vLPiHKSc4PEXhR6iyaWyvwxxotRYEhVrHDXxUt
         G6vZTlJQUGofH+kVToinZMgeFof2TZSoR4f1T1xtcrtfLekjkcfl/ipcxTJafYu0rE9W
         50Y55+xipAI0ufBdQY2PGvPnJNTbThMDs8xRaABigOW+z6ssKQbY00mk+Pv/De5Pb0ad
         wEA9LsDgi+HaJHBuTlG4jz1Sx9ex++S+D3oGYqNiA20VBV8AKTQjCm0vKC3Y2gr89muF
         qwjb6yN1dRxecIg+6p7MkbX2UvXQfkUBDM/3EUHafuRz1j1Qtd69b5fVbJYLbxlxt0qx
         OuNw==
X-Gm-Message-State: AOAM531xTrC4MZq+ayaxw+MfJlgRXwjK2yQGOp99ulfQr11vALF1HSoW
        GF16GTHrf4FyfEJegMOD4GdCmQ==
X-Google-Smtp-Source: ABdhPJwigp0rQLZis0JaDnZZN9nSa9J+V3Qsqnlk+GBUzYAD1Zi/QIvqfwyS+A8X8b3jUHAKI0IMdg==
X-Received: by 2002:a17:90a:9484:: with SMTP id s4mr82939pjo.231.1626191304719;
        Tue, 13 Jul 2021 08:48:24 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id z141sm22530841pfc.146.2021.07.13.08.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 08:48:24 -0700 (PDT)
Date:   Tue, 13 Jul 2021 23:48:17 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 11/11] perf auxtrace: Add
 compat_auxtrace_mmap__{read_head|write_tail}
Message-ID: <20210713154817.GE748506@leoy-ThinkPad-X240s>
References: <20210711104105.505728-1-leo.yan@linaro.org>
 <20210711104105.505728-12-leo.yan@linaro.org>
 <2e4cbd2f-19b6-6fca-a8e3-86ba14247cb8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e4cbd2f-19b6-6fca-a8e3-86ba14247cb8@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jul 13, 2021 at 10:07:03AM +0300, Adrian Hunter wrote:

[...]

> > +/*
> > + * In the compat mode kernel runs in 64-bit and perf tool runs in 32-bit mode,
> > + * 32-bit perf tool cannot access 64-bit value atomically, which might lead to
> > + * the issues caused by the below sequence on multiple CPUs: when perf tool
> > + * accesses either the load operation or the store operation for 64-bit value,
> > + * on some architectures the operation is divided into two instructions, one
> > + * is for accessing the low 32-bit value and another is for the high 32-bit;
> > + * thus these two user operations can give the kernel chances to access the
> > + * 64-bit value, and thus leads to the unexpected load values.
> > + *
> > + *   kernel (64-bit)                        user (32-bit)
> > + *
> > + *   if (LOAD ->aux_tail) { --,             LOAD ->aux_head_lo
> > + *       STORE $aux_data      |       ,--->
> > + *       FLUSH $aux_data      |       |     LOAD ->aux_head_hi
> > + *       STORE ->aux_head   --|-------`     smp_rmb()
> > + *   }                        |             LOAD $data
> > + *                            |             smp_mb()
> > + *                            |             STORE ->aux_tail_lo
> > + *                            `----------->
> > + *                                          STORE ->aux_tail_hi
> > + *
> > + * For this reason, it's impossible for the perf tool to work correctly when
> > + * the AUX head or tail is bigger than 4GB (more than 32 bits length); and we
> > + * can not simply limit the AUX ring buffer to less than 4GB, the reason is
> > + * the pointers can be increased monotonically (e.g in snapshot mode), whatever
> 
> At least for Intel PT, in snapshot mode, the head is always an offset
> into the buffer, so never more than 4GB for a 32-bit perf tool. So maybe
> leave out "(e.g in snapshot mode)"

Sure, will leave out "(e.g in snapshot mode)".

Thanks,
Leo
