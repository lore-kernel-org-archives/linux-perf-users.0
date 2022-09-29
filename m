Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7949EC04A95
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Sep 2022 06:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbiI2GsL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 29 Sep 2022 02:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbiI2GsK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Sep 2022 02:48:10 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7000112AEC5
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Sep 2022 23:48:09 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id bh13so644103pgb.4
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Sep 2022 23:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Y2jtn+YsX5psuE/71sdgLvbCvSb2B8wIQO3pPPOaBMU=;
        b=DGMv8gpt078xYbXObstLocpu9x9DdBibz3qT7uIeJPUOznSsVgwQntQ+WJdvY9fTwS
         dVAHay4BA6NHfzzWyRvqpFaKOC1KHwqW6fDSE1vbhjShXptPMOk+SRV4JCPrwDGE5yBa
         vMjEaYkAG66Casvyiry8jguN6Zq63E7VL8XD3hJYlvr7lQUJFyn/lEytlLwgihHGOgX3
         hZSVvPh1Km+uE8bLB/U+uDsJ6QEj2VAw8SeBkPg3czg0jKnlnFplsDmnfXAOGR8ryzcv
         SJ3qS8ysSyVMKSOKfDI9quQTRn/zt1nkffIVSHjeVcKaBGauAFNFLXx7XVRCtP1G9axu
         MbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Y2jtn+YsX5psuE/71sdgLvbCvSb2B8wIQO3pPPOaBMU=;
        b=tmPHdIjwncsByOwYb8ypM9u518ZcHCMCTzKRbdYD9qLuAHHCk/x6UMjD0Ikzn3jKuc
         xCWssockb3EqE+/V80loKBfGdfS6ph1b+tqHQiYwg+XrMNw6l8gegfXff/Sws0edV1sa
         Zv0Smm2kDkwwcQ8+3LMPVR7RmVk69hNZpuexhYGwAX+btw5x28r47qfWDeI6/NyBIMX6
         flCGzKGMWO8KhGhage02u4D5eCY23MLEzewcxxp1Xs6YYEOrJdW8pVHApXdilb24YgbM
         GJLReUNIm0xf5MgHw62VaDBBLmUoTSeD5qYXkNrgpGpq90Uv4OfSmM35gCGIeAHsHD7c
         5DVw==
X-Gm-Message-State: ACrzQf3XADneGDvuNdRZ/bIjJxSTfHQLEt9NdSxW/GtOoW3jeRal1Uo7
        uY73+Us7kXc7oZWk+nMeSIPVKA==
X-Google-Smtp-Source: AMsMyM5j6SlieS8WhzXlMCDit/9ENlLW9wBz60DdYObn9/Dux3ybEv8MDhzasmfU6daWQYDJmzQJnQ==
X-Received: by 2002:aa7:88c7:0:b0:542:3229:8d11 with SMTP id k7-20020aa788c7000000b0054232298d11mr1909374pff.41.1664434088793;
        Wed, 28 Sep 2022 23:48:08 -0700 (PDT)
Received: from leoy-yangtze.lan (173.242.120.49.16clouds.com. [173.242.120.49])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709027fcd00b00176be23bbb3sm4979563plb.172.2022.09.28.23.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 23:48:08 -0700 (PDT)
Date:   Thu, 29 Sep 2022 14:48:03 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] perf: Skip and warn on unknown format 'configN'
 attrs
Message-ID: <YzU/o3kxS/BYpJhn@leoy-yangtze.lan>
References: <20220914-arm-perf-tool-spe1-2-v2-v3-0-8189fc04dcc6@kernel.org>
 <20220914-arm-perf-tool-spe1-2-v2-v3-1-8189fc04dcc6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914-arm-perf-tool-spe1-2-v2-v3-1-8189fc04dcc6@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Rob,

On Wed, Sep 14, 2022 at 03:08:34PM -0500, Rob Herring wrote:

[...]

> +void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu)
> +{
> +	struct perf_pmu_format *format;
> +
> +	list_for_each_entry(format, &pmu->format, list)
> +		if (format->value >= PERF_PMU_FORMAT_VALUE_CONFIG_END) {
> +			pr_warning("WARNING: '%s' format '%s' requires 'perf_event_attr::config%d'"
> +				   "which is not supported by this version of perf!\n",
> +				   pmu->name, format->name, format->value);
> +			return;
> +		}
> +}

Though I saw you and Namhyung have discussion in underway, this patch
set is fine for me.  I validated the patches at my side (with a bit
hacking in Arm SPE driver for faking invert filter).  You could add my
tested tag for this patch set:

Tested-by: Leo Yan <leo.yan@linaro.org>

But I want to remind two things after I used "perf test" to validate
this patch set:

  $ ./perf test list
  6: Parse event definition strings
  6:1: Test event parsing
  6:2: Test parsing of "hybrid" CPU events
  6:3: Parsing of all PMU events from sysfs
  6:4: Parsing of given PMU events from sysfs
  6:5: Parsing of aliased events from sysfs
  6:6: Parsing of aliased events
  6:7: Parsing of terms (event modifiers)
  $ ./perf test -v 6

The first one is this patch set introduces segmentation fault for the
case "Parsing of aliased events" (See tests/parse-events.c).  But the
issue is caused by the test case itself; we need to add below line into
test_event_fake_pmu() for initialisation list header.

    INIT_LIST_HEAD(&perf_pmu__fake.format);

The second question is for testing config3 in "perf test".  You could
see the file tests/parse-events.c has included several test cases for
config/config1/config2.  It's good to add the same testing for config3
as well, please see test__checkevent_pmu() and test__checkterms_simple()
for relevant code.

Thanks,
Leo
