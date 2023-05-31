Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7501CC7EE2E
	for <linux-perf-users@archiver.kernel.org>; Wed, 31 May 2023 14:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbjEaO1y (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 31 May 2023 10:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236790AbjEaO1s (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 31 May 2023 10:27:48 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567F31B0
        for <linux-perf-users@vger.kernel.org>; Wed, 31 May 2023 07:27:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30aa76048fbso4261878f8f.2
        for <linux-perf-users@vger.kernel.org>; Wed, 31 May 2023 07:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1685543259; x=1688135259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RZQfdwTjxzu5eTOjhFaQdoWnR4tOyHUVZ5eFRh/PK/c=;
        b=i9po3clbzEzJ5aZJXp7NVJtbYUD67qaN17suS1XLMBFHgOJIzR9JhzXZI9ZJYqcXzB
         kq/YSfSHb/X2mueCDVBd/l5QWcvxxlsWUUy88nrWZhX1ilWRtOOHcfJJ/0RS0jGhkCzU
         6X+sfKFKK8FPnIqVwRUZZgmv8K9q2bbO9TfEFrndYZKJKeK3GOqAsVNNVqmSiDNc0YfN
         XGf26cv2lKDNNG9JBv3HmW19c1DlT4oYqocIY9T/iywirimClxbKK+MiFqEKFT4zgJI+
         Fxa3nzHXP1JUOKnsWrX1F7xw2VqyGsPWm1LrAxNcnujbuy78IrhQ6p5qAn14yj5SvUqb
         wjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685543259; x=1688135259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZQfdwTjxzu5eTOjhFaQdoWnR4tOyHUVZ5eFRh/PK/c=;
        b=S6CovfoJH9fkYHIR6Hv1mA0pcwLI+PV0v/3NgbQ193XU+nGL/6ElxPmOfGQ1HMqFly
         MDPqxQPTnQ83GL9scnZzneaZRh5azE+4EoEWeDSTKq6XeCUXZo8m5pfsmCAaSWgbYu+9
         lVNKSZfczyQIhaEG+q1H/Lw/5j+M0OY2F1WIXkYk3f1OfwbuPEY7JWikZ0recMB96Fgi
         eoKU+tgi7QAflT/SAtFq3Qjh9L7AwR7YFyV66lEkEXEoy8apl2b7MyQYSf2WmKv55EOk
         djxO8mjLMXT9EuHxd94WFJUQm+5IbtRC9xwo6LP5tF4nS0tkF9VlX3X+31djHRyLQJKV
         4Uhw==
X-Gm-Message-State: AC+VfDz01HMxnhg5DZxhWD4ByNlJupSOUNHBsar25gFoPQ6uNO1p4fUn
        p5QEyTWD4Vv66kJLN2CKQXXnxQ==
X-Google-Smtp-Source: ACHHUZ7faXqorHCT28+gR8386YvZ5DrWoH2MDLT9ZyAvgjAEryPUGFAdHDgZlqhXBtiXlNhK+JXJbg==
X-Received: by 2002:adf:cd07:0:b0:30a:bf2b:e03c with SMTP id w7-20020adfcd07000000b0030abf2be03cmr4218382wrm.23.1685543259663;
        Wed, 31 May 2023 07:27:39 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600012c400b003047dc162f7sm7057593wrx.67.2023.05.31.07.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:27:39 -0700 (PDT)
Date:   Wed, 31 May 2023 16:27:38 +0200
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
Subject: Re: [PATCH v2 06/10] drivers: perf: Implement perf event mmap
 support in the legacy backend
Message-ID: <20230531-705f2911e8d66938ece04905@orel>
References: <20230512085321.13259-1-alexghiti@rivosinc.com>
 <20230512085321.13259-7-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512085321.13259-7-alexghiti@rivosinc.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, May 12, 2023 at 10:53:17AM +0200, Alexandre Ghiti wrote:
> Implement the needed callbacks in the legacy driver so that we can
> directly access the counters through perf in userspace.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  drivers/perf/riscv_pmu_legacy.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_legacy.c
> index ffe09d857366..f0f5bd856f66 100644
> --- a/drivers/perf/riscv_pmu_legacy.c
> +++ b/drivers/perf/riscv_pmu_legacy.c
> @@ -74,6 +74,31 @@ static void pmu_legacy_ctr_start(struct perf_event *event, u64 ival)
>  	local64_set(&hwc->prev_count, initial_val);
>  }
>  
> +static uint8_t pmu_legacy_csr_index(struct perf_event *event)
> +{
> +	return event->hw.idx;
> +}
> +
> +static void pmu_legacy_event_mapped(struct perf_event *event, struct mm_struct *mm)
> +{
> +	/* In legacy mode, the first 3 CSRs are available. */

Shouldn't this be

 /* In legacy mode, the first and third CSR are available. */

?

> +	if (event->attr.config != PERF_COUNT_HW_CPU_CYCLES &&
> +	    event->attr.config != PERF_COUNT_HW_INSTRUCTIONS)
> +		return;
> +
> +	event->hw.flags |= PERF_EVENT_FLAG_USER_READ_CNT;
> +}
> +
> +static void pmu_legacy_event_unmapped(struct perf_event *event, struct mm_struct *mm)
> +{
> +	/* In legacy mode, the first 3 CSRs are available. */

same comment

> +	if (event->attr.config != PERF_COUNT_HW_CPU_CYCLES &&
> +	    event->attr.config != PERF_COUNT_HW_INSTRUCTIONS)
> +		return;
> +
> +	event->hw.flags &= ~PERF_EVENT_FLAG_USER_READ_CNT;
> +}
> +
>  /*
>   * This is just a simple implementation to allow legacy implementations
>   * compatible with new RISC-V PMU driver framework.
> @@ -94,6 +119,9 @@ static void pmu_legacy_init(struct riscv_pmu *pmu)
>  	pmu->ctr_get_width = NULL;
>  	pmu->ctr_clear_idx = NULL;
>  	pmu->ctr_read = pmu_legacy_read_ctr;
> +	pmu->event_mapped = pmu_legacy_event_mapped;
> +	pmu->event_unmapped = pmu_legacy_event_unmapped;
> +	pmu->csr_index = pmu_legacy_csr_index;
>  
>  	perf_pmu_register(&pmu->pmu, RISCV_PMU_LEGACY_PDEV_NAME, PERF_TYPE_RAW);
>  }
> -- 
> 2.37.2
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
