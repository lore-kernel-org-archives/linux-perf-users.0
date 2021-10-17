Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8C1C433EF
	for <linux-perf-users@archiver.kernel.org>; Sun, 17 Oct 2021 12:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5912960EC0
	for <linux-perf-users@archiver.kernel.org>; Sun, 17 Oct 2021 12:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245691AbhJQMjC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 17 Oct 2021 08:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245697AbhJQMjC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 17 Oct 2021 08:39:02 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8B9C061768
        for <linux-perf-users@vger.kernel.org>; Sun, 17 Oct 2021 05:36:52 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id pf6-20020a17090b1d8600b0019fa884ab85so12599093pjb.5
        for <linux-perf-users@vger.kernel.org>; Sun, 17 Oct 2021 05:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oPvgJePPPBGbk8CW4Cm7B5m1/jymObsgz0pZkmP9Ef4=;
        b=lp3WHIE32fPaO3XawzQCwVOWXW5PLHElCa8VcFcbpcVoQFDVeONnA2Kbrj2yevKHwP
         bGPzLFHE8Zs6iJ+1Ar1XM/IT+sX8mch/4stT3BrVKql4fWFc+FWXSgKLUm+fItxiyI6Y
         JQSocx8NHvtdy9o8JXvXvn0nKjX2bpwlygGAQVtnzzjy3Au97jwb97d2OhiphKTFw8jr
         Gj2Wj71i22U+563cE+Jeu4hP9M3ZZi9mBl4Ip/6kh16GRZhR7dJQnpd09t3CA8jIzc61
         1nNDgkcF6FiDRkTlSlLyX2cHsXGzYnudulqt+nZSbTf2yLCuvbWlopx5E1wIjo6RTNR7
         a/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oPvgJePPPBGbk8CW4Cm7B5m1/jymObsgz0pZkmP9Ef4=;
        b=KDid6EQIPsuOM7fnzUmjSnMLK3E0lYdQXXlT2lpZeUe3S3ZdGJEOJCLV8NUHWfeuJY
         /BDNlzSqy5MHdBti7qMluQQS6rohsmkuUfAiDdK0t1dvjWAvjy7zYzbjPkgR4vE44MNb
         LqnikrRXTbPB0G6vTmRY8yCFJySSYKZn5TnrOxL2tFfYVrBOOPFcuSBjJg/VJMztDGyL
         5R4FVe4A/SLMrR8rvjMYs1bOXo1jvEvVeQ+EeYejgBOa3Fl3FlEv5hdJgEhQlRz4h590
         lT9mmh5PYPK0B5puELnhVsbkj6MCMeDueHz0JZf5PSRChktXtRYu36CskBSj6TC7Xo0F
         fPVw==
X-Gm-Message-State: AOAM533bE8lUKrIlQw4c9ISQGu7uEeobITujZJ1DXkZL1CZYzSYB15Yp
        04X7s9Jw9Kv0PWjFHHyKHRj1QQ==
X-Google-Smtp-Source: ABdhPJwz2fdpS5sQkuZLqAK1HrQMi++7H83aRWHfRxdAe96fuAfHWyHJmMCI7Vmzx88o2V/ndJc8wQ==
X-Received: by 2002:a17:90b:3809:: with SMTP id mq9mr26762607pjb.7.1634474212020;
        Sun, 17 Oct 2021 05:36:52 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([148.163.172.147])
        by smtp.gmail.com with ESMTPSA id 21sm16373500pjg.57.2021.10.17.05.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 05:36:51 -0700 (PDT)
Date:   Sun, 17 Oct 2021 20:36:46 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Subject: Re: [PATCH 4/5] perf arm-spe: Implement find_snapshot callback
Message-ID: <20211017123646.GC130233@leoy-ThinkPad-X240s>
References: <20210916154635.1525-1-german.gomez@arm.com>
 <20210916154635.1525-4-german.gomez@arm.com>
 <20211017120546.GB130233@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017120546.GB130233@leoy-ThinkPad-X240s>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Oct 17, 2021 at 08:05:46PM +0800, Leo Yan wrote:

[...]


> To allow arm_spe_buffer_has_wrapped() to work properly, I think we
> need to clean up the top 8 bytes of the AUX buffer in Arm SPE driver
> when start the PMU event (please note, this change has an assumption
> that is meantioned in another email that suggests to remove redundant
> PERF_RECORD_AUX events so the function arm_spe_perf_aux_output_begin()
> is invoked only once when start PMU event, so we can use the top 8
> bytes in AUX buffer to indicate trace is wrap around or not).
> 
> 
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index d44bcc29d99c..eb35f85d0efb 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -493,6 +493,16 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
>         if (limit)
>                 limit |= BIT(SYS_PMBLIMITR_EL1_E_SHIFT);
> 
> +       /*
> +        * Cleanup the top 8 bytes for snapshot mode; these 8 bytes are
> +        * used to indicate if trace data is wrap around if they are not
> +        * zero.
> +        */
> +       if (buf->snapshot) {
> +               void *tail = buf->base + (buf->nr_pages << PAGE_SHIFT) - 8;
> +               memset(tail, 0x0, 8);

Here need to add below code for flushing data cache:

                 flush_dcache_range((unsigned long)tail, (unsigned long)tail+8);

Sorry for spamming.

Leo

> +       }
> +
>         limit += (u64)buf->base;
>         base = (u64)buf->base + PERF_IDX2OFF(handle->head, buf);
>         write_sysreg_s(base, SYS_PMBPTR_EL1);
