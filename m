Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AFCC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 21 Jan 2022 12:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380507AbiAUMuw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 21 Jan 2022 07:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380503AbiAUMuq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 21 Jan 2022 07:50:46 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AD6C061748
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Jan 2022 04:50:46 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id r132-20020a1c448a000000b0034e043aaac7so4847018wma.5
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Jan 2022 04:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AwSBqHVllEbRZxhPaY/nleQIUKbH7/3TNlbkvqfi1ds=;
        b=SjAYeD0CSrOpQfIZCcvtmxQ8h4fFUkFk0ENjs0Rszvp1oIgCTAm601Q/tsPSQJ5Cqx
         W65MO+a5lYctkovj7NtvOtHzSBQwMzjRhqbBfQR818uHl9a62sijHLUPnRxX71octH37
         inVt3W9AWDp9CcUCgpFWwZpNqS3UdsD8Aj5wI78Si6biRzlyTCbWEL4rlzhs0d9kXr4e
         r6RkiSOSnpt8COFooc35f0LiMw3vx+cpVA8OTAf1vjyMoxBqhbL2RZo09eqs5Vo/t1oS
         pYC8dFKjQvSRYdZ8yMg6UTOCGX5t/OvHXWACE/5TjyOY3T/9WznPg3dv7VGNRdvuQJBa
         3QJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AwSBqHVllEbRZxhPaY/nleQIUKbH7/3TNlbkvqfi1ds=;
        b=jEvlhPJClBFsJrZ7Gz0pZGyhCct74uvvYaOLtDbJbOovroScdVGpDWdBg9bP70FCLc
         zgEQzgZvsV1/w+ADXYtokDEyYT0cs+Sz89CE83FUaaKHMbwa88atgQ3gSor4iynOJlHC
         lNErsm+w3QwiVG9JAhvZ+5nfJo/wa6c0xvnrSEjriUdUkao+UvCvdN2wY/b/A1xjQVTm
         /m8BNGGPAA7xpmxRVERW4QAR2cwlcmj1TE1HQ1ja8QcJgR2fBf863ABwYsv8N7I9KPIb
         3nZIuuy80nLA748h3KaWwh8Pnv+8rVa1G4cKKFT3bNzPCdDc/FlGKMRGqkYFKpb3KaiL
         hqXQ==
X-Gm-Message-State: AOAM533v/NzU4NkO2Zxchk56CrSX1Nnz7b9G3EuNibvYr0DTC0jSscqR
        A5HUis4O9NpPbAXDqg+Apng1DICEH89rnhqu3gmwCA==
X-Google-Smtp-Source: ABdhPJwryD8OThQOaZ8G+mLwXbncN4ce1miORo8Z4fbkZv3mG/YD9KNLzjofo1Ez7NVxZPi+WrFCt8iiWT+GiMWLB/g=
X-Received: by 2002:a5d:618b:: with SMTP id j11mr3725004wru.619.1642769444987;
 Fri, 21 Jan 2022 04:50:44 -0800 (PST)
MIME-Version: 1.0
References: <20220113091056.1297982-1-james.clark@arm.com> <20220113091056.1297982-7-james.clark@arm.com>
In-Reply-To: <20220113091056.1297982-7-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 21 Jan 2022 12:50:34 +0000
Message-ID: <CAJ9a7VihnvK6uwYri0kh_pwQu893+FrdcUNg0Y5iW7Euh3YwuA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] Documentation: coresight: Expand branch broadcast documentation
To:     James Clark <James.Clark@arm.com>
Cc:     suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, leo.yan@linaro.com,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, 13 Jan 2022 at 09:11, James Clark <james.clark@arm.com> wrote:
>
> Now that there is a way of enabling branch broadcast via perf, mention
> the possible use cases and known limitations.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  .../trace/coresight/coresight-etm4x-reference.rst      | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/trace/coresight/coresight-etm4x-reference.rst b/Documentation/trace/coresight/coresight-etm4x-reference.rst
> index 0439b4006227..ec336575919c 100644
> --- a/Documentation/trace/coresight/coresight-etm4x-reference.rst
> +++ b/Documentation/trace/coresight/coresight-etm4x-reference.rst
> @@ -656,7 +656,15 @@ Bit assignments shown below:-
>      ETM_MODE_BB
>
>  **description:**
> -    Set to enable branch broadcast if supported in hardware [IDR0].
> +    Set to enable branch broadcast if supported in hardware [IDR0]. The primary use for this feature
> +    is when code is patched dynamically at run time and the full program flow may not be able to be
> +    reconstructed using only conditional branches.
> +
> +    Choosing this option will result in a significant increase in the amount of trace generated -
> +    possible danger of overflows, or fewer instructions covered. Note, that this option also
> +    overrides any setting of :ref:`ETM_MODE_RETURNSTACK <coresight-return-stack>`, so where a branch
> +    broadcast range overlaps a return stack range, return stacks will not be available for that
> +    range.
>
>  .. _coresight-cycle-accurate:
>
> --
> 2.28.0
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
