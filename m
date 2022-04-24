Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D05DC433F5
	for <linux-perf-users@archiver.kernel.org>; Sun, 24 Apr 2022 14:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239477AbiDXO4T (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 24 Apr 2022 10:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbiDXO4S (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 24 Apr 2022 10:56:18 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202CADA6F9
        for <linux-perf-users@vger.kernel.org>; Sun, 24 Apr 2022 07:53:17 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id kq17so1931819ejb.4
        for <linux-perf-users@vger.kernel.org>; Sun, 24 Apr 2022 07:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PljnxRUh81pT/VZFsSxpCxfxThaMnEo3K5gwtxML1T4=;
        b=HPK1Fjl//ahLaP1lNA4NCbDVTK5dLYlXgM5pM42npxjQZKjO5L9/PdF8l7lGR+id0d
         ZnvgI0tC1zbFtZrmiJK2y52v84g9Y+w0AF5Zt9IAPvXJ1gHzny119IxGNvrK+e3TYJ4u
         Y8rptqx/qBwsXxnS7f3mTiPtWUBlHBlQ8JkfVLwxpVb/UrRFErhEaZRwiX5S5Rv6vPXW
         VQNWs1UCCJCC+rblI5xV7mDQLGIlW1+IdMc9fRmwH3q4frHl5f/WsbO1PmH/Hc+HBLm+
         UOmY6g+Q/jK77zTLxpstRUKCEecv/HgTLR/EgcdKccd6Gp1y71jMUnHcF/iHoANcNRBN
         BFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PljnxRUh81pT/VZFsSxpCxfxThaMnEo3K5gwtxML1T4=;
        b=fZdbpHCp5VJxwdPECGFE0Okzga34PBQWXWMWfxa7ExrkBlCvRuMnVu/NKmTsW0HFk4
         jgwViGS7EwXG585bUr+g7m9J5rMaM01f/9aagjAuzcuQ7FqkONjSHavgKfkJFQ8mvcml
         PmYIK66BREtN8/t0Zum4wZiowgf3tR7eA83hJvYHfpWnvaMImkDEegSjnQvz9z/lHQcN
         6sYcRY0rFWgZUlubgYFJM1wQbyX5U5DjvNsZQUOAR9qpiA1J0h4PtIz4cXJgoSo6A+d+
         HWv6BwE3nwVRo1p7L831l+f3kRGj7e4nkvV1RvHhcNCI1rz0JuQCb5hjszYECOUjXj1o
         93jA==
X-Gm-Message-State: AOAM530tK3YQvTqCyhm9achpAhflZmwQ6RQd+CDSkIxKUAIMs8ra3mp1
        6XlH/P9TBJmpMUpzJGrnMdOzmw==
X-Google-Smtp-Source: ABdhPJxP6gdki3QWyI62X0hWhCeuw+jp1SO/FmJ3sHN5jeLes6QLGVCoRpETcIf1m/9BtNHG/zYBEg==
X-Received: by 2002:a17:907:6e25:b0:6f0:99d4:9711 with SMTP id sd37-20020a1709076e2500b006f099d49711mr12019128ejc.511.1650811995192;
        Sun, 24 Apr 2022 07:53:15 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id gz15-20020a170906f2cf00b006f3802a963fsm1161681ejb.21.2022.04.24.07.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 07:53:14 -0700 (PDT)
Date:   Sun, 24 Apr 2022 22:53:07 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Timothy Hayes <timothy.hayes@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH 3/3] perf test: Add perf_event_attr test for Arm SPE
Message-ID: <20220424145307.GE978927@leoy-ThinkPad-X240s>
References: <20220421165205.117662-1-timothy.hayes@arm.com>
 <20220421165205.117662-4-timothy.hayes@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421165205.117662-4-timothy.hayes@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Apr 21, 2022 at 05:52:05PM +0100, Timothy Hayes wrote:
> Adds a perf_event_attr test for Arm SPE in which the presence of
> physical addresses are checked when SPE unit is run with pa_enable=1.
> 
> Signed-off-by: Timothy Hayes <timothy.hayes@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>

> ---
>  tools/perf/tests/attr/README                         |  1 +
>  .../perf/tests/attr/test-record-spe-physical-address | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
>  create mode 100644 tools/perf/tests/attr/test-record-spe-physical-address
> 
> diff --git a/tools/perf/tests/attr/README b/tools/perf/tests/attr/README
> index 454505d343fa..eb3f7d4bb324 100644
> --- a/tools/perf/tests/attr/README
> +++ b/tools/perf/tests/attr/README
> @@ -60,6 +60,7 @@ Following tests are defined (with perf commands):
>    perf record -R kill                           (test-record-raw)
>    perf record -c 2 -e arm_spe_0// -- kill       (test-record-spe-period)
>    perf record -e arm_spe_0/period=3/ -- kill    (test-record-spe-period-term)
> +  perf record -e arm_spe_0/pa_enable=1/ -- kill (test-record-spe-physical-address)
>    perf stat -e cycles kill                      (test-stat-basic)
>    perf stat kill                                (test-stat-default)
>    perf stat -d kill                             (test-stat-detailed-1)
> diff --git a/tools/perf/tests/attr/test-record-spe-physical-address b/tools/perf/tests/attr/test-record-spe-physical-address
> new file mode 100644
> index 000000000000..7ebcf5012ce3
> --- /dev/null
> +++ b/tools/perf/tests/attr/test-record-spe-physical-address
> @@ -0,0 +1,12 @@
> +[config]
> +command = record
> +args    = --no-bpf-event -e arm_spe_0/pa_enable=1/ -- kill >/dev/null 2>&1
> +ret     = 1
> +arch    = aarch64
> +
> +[event-10:base-record-spe]
> +# 622727 is the decimal of IP|TID|TIME|CPU|IDENTIFIER|DATA_SRC|PHYS_ADDR
> +sample_type=622727
> +
> +# dummy event
> +[event-1:base-record-spe]
> \ No newline at end of file
> -- 
> 2.25.1
> 
