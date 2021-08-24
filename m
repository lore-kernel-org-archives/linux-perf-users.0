Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E50C4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Aug 2021 08:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99CE861165
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Aug 2021 08:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbhHXIsN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 24 Aug 2021 04:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbhHXIsM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 24 Aug 2021 04:48:12 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7E4C061757
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Aug 2021 01:47:28 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id oc2-20020a17090b1c0200b00179e56772d6so1283294pjb.4
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Aug 2021 01:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tVJAPvgMbNMhxKXeO03R+hvScbq+4VlPa0BONKG03BI=;
        b=OZM/afBgpyVQNHRrSarWgAojEw2soUXGQh9h6ar4I9ajCIv9dZOpX6cavspPTyl0Ys
         BiPBXCYdmJ8b/Vt0bucTBHRVM2rv5rI5nrBJTbHNd6ikCMbC+9qu3eEwIl+sTyRsoX2z
         vEMbtb/XaOyn3yKZ3180nL7zOrw1PPyKD71c26BfyD5X3tRsi5E3uIJzODi4A8VPLvEq
         CXrUgpV6be+NDKcjg8WL+sxWhXstM1Zc8p3qLjfKQq4cWxomD1wK8RPBNTaa/UYjq719
         QT97KcKkv/IusGpcd3YMaT0mplIl1isyBpa+kWr6bbG5vEakL6BZRm0lHsm23qIELGiV
         KsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tVJAPvgMbNMhxKXeO03R+hvScbq+4VlPa0BONKG03BI=;
        b=qXgCosWVXoNzagYU4BqTu1G61dtyzurn1lTWLaqpApDEqcm9Sra1dHFAXMqBkwC3II
         15UM0zm21s3RUq47HdNxPPxSFkkLQ0eeNyyZ2TLZ49SWolgy/hlRe1CcvE1bPZFNiTsP
         gBnIINnorbuytCNkOuLmBJa6a8Vd9HG2GeZD0Y0BlU5ecHkDbhBZceR5QoHquExekfI3
         yBco5c8J1mq63u9qtm5WBV5U+0yRkiun93PEpizb/rXueLKo7wdwAhTrSuvW0icODeLl
         Rug54/fqFuza67q5Uf7tVHduyFZFz5D4U+7CkcS6z2iNM55zqEecnyH2BWUHvDjOqP8b
         DZyA==
X-Gm-Message-State: AOAM533cRDnGy4t+N7OnwxmxZRB98roI7ZGGFvhCrAGM+zjSIaAYlFlB
        lsjh0W3bUQB5xSrzZFcE/Ctujw==
X-Google-Smtp-Source: ABdhPJzLsDqCQjs9/UG+SPzsKTBx3iLUeU+n5rJbxZCsyzTYuB7pN12asph1b+jsKUJm3U94dvzPYg==
X-Received: by 2002:a17:90b:116:: with SMTP id p22mr3289987pjz.67.1629794847869;
        Tue, 24 Aug 2021 01:47:27 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id f137sm18728068pfa.160.2021.08.24.01.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 01:47:27 -0700 (PDT)
Date:   Tue, 24 Aug 2021 16:47:20 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        linux-perf-users@vger.kernel.org, mike.leach@linaro.org,
        acme@kernel.org, suzuki.poulose@arm.com,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] Support ETE decoding
Message-ID: <20210824084720.GG204566@leoy-ThinkPad-X240s>
References: <20210806134109.1182235-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806134109.1182235-1-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Mathieu, Suzuki, Mike,

On Fri, Aug 06, 2021 at 02:41:00PM +0100, James Clark wrote:
> Changes since v1:
>  * Re-implement with a new magic number instead of piggybacking on ETMv4
>  * Improve comments and function name around cs_etm_decoder__get_etmv4_arch_ver()
>  * Add a warning for unrecognised magic numbers
>  * Split typo fix into new commit
>  * Add Leo's reviewed-by tags
>  * Create a new struct for ETE config (cs_ete_trace_params) instead of re-using ETMv4 config
> 
> Applies to perf/core f3c33cbd922
> Also available at https://gitlab.arm.com/linux-arm/linux-jc/-/tree/james-ete-v2

I have finished the review for this patch series and it's good form for
me.  Since this patch series is to enable new feature for ETE, it's
good if any of you could review as well before merging.

Thanks,
Leo
