Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24767C48BC2
	for <linux-perf-users@archiver.kernel.org>; Mon, 28 Jun 2021 01:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00DCE61423
	for <linux-perf-users@archiver.kernel.org>; Mon, 28 Jun 2021 01:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhF1Bdx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 27 Jun 2021 21:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhF1Bdx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 27 Jun 2021 21:33:53 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EE9C061574
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Jun 2021 18:31:27 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id w15so9448139pgk.13
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Jun 2021 18:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XY1v4wQPZXeUEo4/Ib4mftoEqzCDn6DSUGjjwDuyBRE=;
        b=FQ9lPlRpChEJNBV1I2n07ASVhvbA4e/+UW2OaF0a95J/WR4CZsFgIHlqTQP7bs1KoP
         PBBh/9jthXzZvfPY9kmZFR1MwQgvX7JGxRKK0nCqbr0qwUFSglMwTJbbH4BIoCa3BjLV
         AZEY/vnzjxAID0P7ckWHvJqTXFNW+VLNUbMJ2DaeYRtzsFEiHPq8aXjhO7IVmOkPKMfn
         7lLf9Ms77XCPQp469oRPKqNzZq/20iNGjjL/7Y75RnQyvum6ARDZD43tFirnYsE/xsLe
         KJku0ieyxGoSmDxwRWQDu2vQiN0XAOlfStmWwoCcmcVepNhDwA4r+rzOrUmLGHMNIJC5
         B0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XY1v4wQPZXeUEo4/Ib4mftoEqzCDn6DSUGjjwDuyBRE=;
        b=i3Kl13psAQWQo1AhEAeuwndGn1H/SJ44k9ZkRCz+zLbU1G20NgYX1B+LhdxIfCPp7Z
         VnLuVQ1CpJ9WJb4xIcGDHJQpDvo4Zf/jhXt0D0FG1oOsbmBawn9l/vRjCAZ801d9hT2v
         mFWbZwLK4rqAWP9kFmmWYeiGZXC5DGBiAewhrhiSbdn1LR8MaTE4s0qQl2CW40wTSzXI
         ix64a5tF+FuTh2kBJim3rTTzshe/xb0xxl0xvK5k8uQE3TDNeum3AMjgU1JZjWHqNb45
         h3Osm7ebLUYDta7U24AxrO0tOEzzlJVjYf344p9FfICAvTWGwaFvGuFN161vUMCEaX1o
         am0g==
X-Gm-Message-State: AOAM531IaYyYcZZRxLNQRrPRr8Djeo+dG31Vl13ob+/n/eDZz+57kxIj
        /Xj9AUye5zCINkq30AyZ3hpFqA==
X-Google-Smtp-Source: ABdhPJwbluA4O/54AMZ1I1l5jNnR1ZVwqNEM2VriU8rA5cXtdQHddLL5iz3dG/aJx1cdsWqjy/SD9g==
X-Received: by 2002:a63:d909:: with SMTP id r9mr21255556pgg.285.1624843887047;
        Sun, 27 Jun 2021 18:31:27 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id l12sm11884145pff.105.2021.06.27.18.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 18:31:26 -0700 (PDT)
Date:   Mon, 28 Jun 2021 09:31:19 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Denis Nikitin <denik@google.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 3/3] perf cs-etm: Remove callback
 cs_etm_find_snapshot()
Message-ID: <20210628013119.GB158794@leoy-ThinkPad-X240s>
References: <20210528161552.654907-1-leo.yan@linaro.org>
 <20210528161552.654907-4-leo.yan@linaro.org>
 <05442998-05f6-c41c-5a78-3f6723558825@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05442998-05f6-c41c-5a78-3f6723558825@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi James,

On Tue, Jun 22, 2021 at 03:29:35PM +0100, James Clark wrote:
> 
> 
> On 28/05/2021 17:15, Leo Yan wrote:
> > The callback cs_etm_find_snapshot() is invoked for snapshot mode, its
> > main purpose is to find the correct AUX trace data and returns "head"
> > and "old" (we can call "old" as "old head") to the caller, the caller
> > __auxtrace_mmap__read() uses these two pointers to decide the AUX trace
> > data size.
> > 
> > cs_etm_find_snapshot() should be removed with below reasons:
> 
> Hi Leo,
> 
> I came across this other comment in coresight-tmc-etr.c that should probably
> be fixed up if we remove cs_etm_find_snapshot(). The same is duplicated in a
> few other files:
> 
> 	/*
> 	 * In snapshot mode we simply increment the head by the number of byte
> 	 * that were written.  User space function  cs_etm_find_snapshot() will
> 	 * figure out how many bytes to get from the AUX buffer based on the
> 	 * position of the head.
> 	 */
> 	if (etr_perf->snapshot)
> 		handle->head += size;

Good finding!  I will fix the comments in next version.

Thanks a lot for the reviewing and testing!

Leo
