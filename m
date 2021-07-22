Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFFEC6377D
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Jul 2021 11:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D794261289
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Jul 2021 11:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhGVKaN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Jul 2021 06:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbhGVKaN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Jul 2021 06:30:13 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC00C061757
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jul 2021 04:10:47 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id c15so5503235wrs.5
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jul 2021 04:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+BbEYjJZrDMvVMU8Gk6ZZXnsglhpn/IFncHvu0fGydQ=;
        b=dwSE7daosIqAIYrAg6zfool4qyV1Av+1/M71w7zKk1Q7KC7+ks3lA1z6zT65mf7I6C
         wvkepV4WJgSNdJB5ApE8wMASfJm7BYkWCslG2YdS+g+/qfFdl3YlVGfGl4zIh636hjya
         B9tHEjL7imZ/MEZ5MWpEg3Pnu76OprUuLZrrqG9KoR+iAtStpz+54ci+5g510O9ZcZTj
         OCtL3tXvyrLATrlQ9z8pEIWlxXTdSAZC1LOMJV0ki8G3kGHI6JcLtmiiuO8MlI4AqG7l
         ta6R5LkO9d2rTpcGpfTs+8a1Fq6/YkiR9HDJLlNIYCWexCHUFhkFc5hz09kauipJH574
         gctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+BbEYjJZrDMvVMU8Gk6ZZXnsglhpn/IFncHvu0fGydQ=;
        b=rN0+RF9vx5/Dd89V25a+MMtd3W86SKtFkfx0fjk70VnlUdaWoIuw8Dx0/zXj0vNDYN
         /YpyBGebSYspBu8j4QslC698avYnjQC1LgdWhdgDZURNNRmdIjFauO1mxROaxEKubyND
         WZk+McEpiyHCncmso/5c9jMBpMP/04N+eMTSrMEcp09xoiYZCCA5fhHrNyaoRbLIvAfU
         +W6KUkJPYA8lmQFXBMUWHCUF4XM6kyMhDAMv9ojDv9fftXKBPZhpgdvmTr0mx415BywR
         GpOk72y7hCU0f+EqIbHzxvw1kVrvb46cvE+YxmHQ73N4MtmsSD3LYh68veb8aesQmuDx
         bXIQ==
X-Gm-Message-State: AOAM530Abv6Y9P8OuzAV13nA8eeZdfQTchVe/yNREWpbnk5MVCMRkhIP
        TPut/kZVz7GSZZkn37H7/VY26L9mwQK9FK9Q2l0B+g==
X-Google-Smtp-Source: ABdhPJwWnzl/vvtrpZNDGt12uO9nxNx15w3I8z53H5T1+Rtm/pEgI7ux1/XG3alF95NgDGAbjNhXo5AR0bbcINTVsP4=
X-Received: by 2002:adf:f949:: with SMTP id q9mr46150136wrr.178.1626952246441;
 Thu, 22 Jul 2021 04:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210721090706.21523-1-james.clark@arm.com> <20210721090706.21523-3-james.clark@arm.com>
In-Reply-To: <20210721090706.21523-3-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 22 Jul 2021 12:10:35 +0100
Message-ID: <CAJ9a7Viap53OgrM2e_DU4+oymFB41jspbKbvEVFQWROt7ifuXw@mail.gmail.com>
Subject: Re: [PATCH 2/6] perf cs-etm: Initialise architecture based on TRCIDR1
To:     James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Al Grant <al.grant@arm.com>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

HI James

On Wed, 21 Jul 2021 at 10:07, James Clark <james.clark@arm.com> wrote:
>
> Currently the architecture is hard coded as ARCH_V8, but with the
> introduction of ETE we want to pick ARCH_AA64. And this change is also
> applicable to ETM v4.4 onwards as well.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 30889a9d0165..5972a8afcc6b 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -126,6 +126,18 @@ static int cs_etm_decoder__gen_etmv3_config(struct cs_etm_trace_params *params,
>         return 0;
>  }
>
> +#define TRCIDR1_TRCARCHMIN_SHIFT 4
> +#define TRCIDR1_TRCARCHMIN_MASK  GENMASK(7, 4)
> +#define TRCIDR1_TRCARCHMIN(x)    (((x) & TRCIDR1_TRCARCHMIN_MASK) >> TRCIDR1_TRCARCHMIN_SHIFT)
> +static enum _ocsd_arch_version cs_etm_decoder__get_arch_ver(u32 reg_idr1)
> +{
> +       /*
> +        * If the ETM trace minor version is 4 or more then we can assume
> +        * the architecture is ARCH_AA64 rather than just V8
> +        */
> +       return TRCIDR1_TRCARCHMIN(reg_idr1) >= 4 ? ARCH_AA64 : ARCH_V8;
> +}

This is true for ETM4.x & ETE 1.x (arch 5.x) but not ETM 3.x
Probably need to beef up this comment or the function name to emphasise this.

Also only true because we don't currently support AArch32 builds of
the ETM4.x driver.

Regards

Mike

> +
>  static void cs_etm_decoder__gen_etmv4_config(struct cs_etm_trace_params *params,
>                                              ocsd_etmv4_cfg *config)
>  {
> @@ -140,7 +152,7 @@ static void cs_etm_decoder__gen_etmv4_config(struct cs_etm_trace_params *params,
>         config->reg_idr11 = 0;
>         config->reg_idr12 = 0;
>         config->reg_idr13 = 0;
> -       config->arch_ver = ARCH_V8;
> +       config->arch_ver = cs_etm_decoder__get_arch_ver(params->etmv4.reg_idr1);
>         config->core_prof = profile_CortexA;
>  }
>
> --
> 2.28.0
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
