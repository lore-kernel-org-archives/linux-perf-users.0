Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1727AC7EE23
	for <linux-perf-users@archiver.kernel.org>; Wed, 31 May 2023 14:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbjEaONy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 31 May 2023 10:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237594AbjEaON0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 31 May 2023 10:13:26 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67FE2122
        for <linux-perf-users@vger.kernel.org>; Wed, 31 May 2023 07:10:44 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f603ff9c02so44897985e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 31 May 2023 07:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1685542170; x=1688134170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pgpyzmnbNHAseyCM+s0XsB0KjofBbxw68PBCInlqrLM=;
        b=oxzmFA70Bjtlz6BsRl7Er91ErjmIoeIoblFWyRv4dTc3OiWmG2pPwau86hZLSdyF+x
         o/en/dxj3KIaEe2mRLZqODiQX+Fg+JSppTKF39rcISQ02VRyDntm1u1tkc/glQkXxXhh
         EaiHBTIEfxCSC7I4LMcET+AewMo97ui82kaVsMEd7Ab8ZHEKv8SF/Xsnqc94oJk3BzeN
         i2yd/18czjL4o65TJ3sZKe+lBjgFghQNfjWmqI/7IwN3IC290cPe1bGt6TzPvtWv2jX4
         ehNH+GVJmKOfUJCeQKY/KPO98LY19AkaBF/5VcNefetloyimk0xYMoTcdzEvgx+HftjY
         /BSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542170; x=1688134170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgpyzmnbNHAseyCM+s0XsB0KjofBbxw68PBCInlqrLM=;
        b=bQgqfIcQdzIEZbAS57ln73kXFG0HJH4QSQ4hhZsuBSIIYc51m4/qGG4xQdJA3CEQxi
         icay2jsysyXu63+Jnj3E1mnqb9AIuJnMeB/aHqIXtPbNE5uxiMImhwkPXkS2PyrZV05W
         Bk9Ct1ppOsVdmjYqQd4QF40naHI/R0Y2lzJ37NkA5bkobn7DkUG1ywfdpvoBsV42VXgZ
         TKGk66VPumIxZkGAUtZo+5SF5eQFpTJ75vH3/9feAGO15ztSSeQ6fMfqR2PZsr/vkI2S
         qIPYpmIk9sFgqazCe3nGq9E2GCqbq42wZJk6yjYwrK25MRrbbIUDixITinlbCQkJYBBV
         jJiA==
X-Gm-Message-State: AC+VfDx443ABcNykv/pY/0DDqacNGcrybz9WvHOjqu3f+cP2CadxI0dU
        tCC+MKEbdgN3G9/kW1NJO3wzYA==
X-Google-Smtp-Source: ACHHUZ6/5u1aIeEPR87Cph6/LuYqwzkXH6Ggsh21iSthCsoK8ecfPiKMDhYwuo0sJqTdGafvLc34yA==
X-Received: by 2002:a5d:526e:0:b0:309:50e7:7c3 with SMTP id l14-20020a5d526e000000b0030950e707c3mr4408962wrc.63.1685542170038;
        Wed, 31 May 2023 07:09:30 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id d15-20020a056000114f00b0030af72bca98sm4800839wrx.103.2023.05.31.07.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:09:29 -0700 (PDT)
Date:   Wed, 31 May 2023 16:09:28 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 04/10] drivers: perf: Rename riscv pmu driver
Message-ID: <20230531-49ed4c2054db0abbacd03632@orel>
References: <20230512085321.13259-1-alexghiti@rivosinc.com>
 <20230512085321.13259-5-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512085321.13259-5-alexghiti@rivosinc.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, May 12, 2023 at 10:53:15AM +0200, Alexandre Ghiti wrote:
> In addition to being more pretty, it will be useful in upcoming commits
> to distinguish those pmu drivers from the other pmu drivers.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  drivers/perf/riscv_pmu_legacy.c | 2 +-
>  drivers/perf/riscv_pmu_sbi.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_legacy.c
> index 0d8c9d8849ee..ffe09d857366 100644
> --- a/drivers/perf/riscv_pmu_legacy.c
> +++ b/drivers/perf/riscv_pmu_legacy.c
> @@ -95,7 +95,7 @@ static void pmu_legacy_init(struct riscv_pmu *pmu)
>  	pmu->ctr_clear_idx = NULL;
>  	pmu->ctr_read = pmu_legacy_read_ctr;
>  
> -	perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
> +	perf_pmu_register(&pmu->pmu, RISCV_PMU_LEGACY_PDEV_NAME, PERF_TYPE_RAW);
>  }
>  
>  static int pmu_legacy_device_probe(struct platform_device *pdev)
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 70cb50fd41c2..3b0ee2148054 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -897,7 +897,7 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto out_unregister;
>  
> -	ret = perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
> +	ret = perf_pmu_register(&pmu->pmu, RISCV_PMU_PDEV_NAME, PERF_TYPE_RAW);

Should we include "sbi" in this name?

>  	if (ret)
>  		goto out_unregister;
>  
> -- 
> 2.37.2
> 

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
