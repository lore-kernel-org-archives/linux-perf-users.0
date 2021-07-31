Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75D1C4338F
	for <linux-perf-users@archiver.kernel.org>; Sat, 31 Jul 2021 06:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B90E361059
	for <linux-perf-users@archiver.kernel.org>; Sat, 31 Jul 2021 06:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhGaGu3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 31 Jul 2021 02:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbhGaGu3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 31 Jul 2021 02:50:29 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BF1C06175F
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jul 2021 23:50:23 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c16so13668123plh.7
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jul 2021 23:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Scp0XsH/8g/xK4xKxJDwfK0sTyUpWpPn5qW5XBp4RlQ=;
        b=t5KuRMuqXwprgBmPyYSxKUd9krVCGGA1/xFNfgaXMbWzxfPTXEG3OEi+Pa0OSrxk51
         HD841NZ6TGnggbZXbFfK5Y96Vg6U+w2CtczwKpMsaRA83Qylg6Vmi98cFMDopiEq9Qjv
         HMnOZNaLE4Oe6e2uXI+ElUBf9dSqD55l6oE470aYX0v0oyAxBcp/Q/Ty/sCsy6RQnekk
         6HWpWqrmzvVtxiG4c5ckM0DvM06cAd6/R6JXBGbSrwnp3MVCosssqU/vcmJc/ltpCh9K
         tcQK8ZganY6dzHe0CwjEduNH4rxJLjM9STZUSvURpuIDdqz62OobXT3en/qIocQjLoUN
         vFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Scp0XsH/8g/xK4xKxJDwfK0sTyUpWpPn5qW5XBp4RlQ=;
        b=amK/oOnfHR9yLqA5cjXBbaC11BnPT+EYWk6OvKCR0XopZsMfJewoqkNS3HBXO2rdwr
         Z0R4Tafj7gYEFZo/lx8+nFXR6Q0pIaxyAKnpfPVzRERMI0yfduZp674lBSuYeGJ4vfly
         EPls8x06jc1Aol1ucjB5/Jjd96qtopuGdSHIAXWkGSaQACtNaCTKCHuse+0efaz6PZr2
         PlUluo1c36Rvi1PunkF+p08DvzGb8pmYst2gflhEpuywaSofW8bJLo9yb8nTJaZITfDm
         6geCZSyShmjGHLzNB9IyPkR0IFtD3SYQo8dmGs4xMOG9FrIRQFnyo7ne4ysvqeGgguZ7
         QvqA==
X-Gm-Message-State: AOAM5320XX2GuyIANIMg9ImFrlYDjvMXiZKHQBfVrIeykrrDg6ziCrBb
        j75DV9OZizTwPn0wQpk1jE63Ew==
X-Google-Smtp-Source: ABdhPJyPuhbQY1xaqyLCuAYgPVh0gLGVPKGQCpoB6z7QVm3rnjclpY3xMn1x90IcjsEf9JHsoC15nQ==
X-Received: by 2002:a17:902:76cb:b029:12b:2fb8:7c35 with SMTP id j11-20020a17090276cbb029012b2fb87c35mr5751825plt.16.1627714223124;
        Fri, 30 Jul 2021 23:50:23 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([204.124.181.43])
        by smtp.gmail.com with ESMTPSA id g3sm4423116pfi.197.2021.07.30.23.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 23:50:22 -0700 (PDT)
Date:   Sat, 31 Jul 2021 14:50:12 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, al.grant@arm.com,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        mike.leach@linaro.org, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 4/6] perf cs-etm: Update OpenCSD decoder for ETE
Message-ID: <20210731065012.GD7437@leoy-ThinkPad-X240s>
References: <20210721090706.21523-1-james.clark@arm.com>
 <20210721090706.21523-5-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721090706.21523-5-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jul 21, 2021 at 10:07:03AM +0100, James Clark wrote:
> OpenCSD v1.1.1 has a bug fix for the installation of the ETE decoder
> headers. This also means that including headers separately for each
> decoder is unnecessary so remove these.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

IIUC, only the later patches in this patch set are dependent on OpenCSD
v1.1.1.  After I checked OpenCSD latest header, this change LGTM:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  tools/build/feature/test-libopencsd.c           | 4 ++--
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 2 --
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/build/feature/test-libopencsd.c b/tools/build/feature/test-libopencsd.c
> index 52c790b0317b..eb6303ff446e 100644
> --- a/tools/build/feature/test-libopencsd.c
> +++ b/tools/build/feature/test-libopencsd.c
> @@ -4,9 +4,9 @@
>  /*
>   * Check OpenCSD library version is sufficient to provide required features
>   */
> -#define OCSD_MIN_VER ((1 << 16) | (0 << 8) | (0))
> +#define OCSD_MIN_VER ((1 << 16) | (1 << 8) | (1))
>  #if !defined(OCSD_VER_NUM) || (OCSD_VER_NUM < OCSD_MIN_VER)
> -#error "OpenCSD >= 1.0.0 is required"
> +#error "OpenCSD >= 1.1.1 is required"
>  #endif
>  
>  int main(void)
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 5972a8afcc6b..60147c908425 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -13,8 +13,6 @@
>  #include <linux/zalloc.h>
>  #include <stdlib.h>
>  #include <opencsd/c_api/opencsd_c_api.h>
> -#include <opencsd/etmv4/trc_pkt_types_etmv4.h>
> -#include <opencsd/ocsd_if_types.h>
>  
>  #include "cs-etm.h"
>  #include "cs-etm-decoder.h"
> -- 
> 2.28.0
> 
