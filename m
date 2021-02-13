Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A49C433E0
	for <linux-perf-users@archiver.kernel.org>; Sat, 13 Feb 2021 07:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D492B64E64
	for <linux-perf-users@archiver.kernel.org>; Sat, 13 Feb 2021 07:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhBMHJY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 13 Feb 2021 02:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhBMHJV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 13 Feb 2021 02:09:21 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF7DC0613D6
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Feb 2021 23:08:41 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id m2so1108301pgq.5
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Feb 2021 23:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zDy6QKCa+RVR/NM5Rdt2ekYrIEZ99lrar03e/i4SbqA=;
        b=Xq7vjH+Yt5HnZXuBWqLOOeedf34oL8xeI9GRwj5m6nNVLD2kwORCGCY99o8t3wXd4s
         KF2JVb4UQJvSqZkeoHLAEQL85gbAqEdWb9Bg4B7K9VwhXxGFilPL8bLk4g78ZmAtkj4q
         b3FrK4U5k4eSMvz3A4HHzmhZwPebQryrSR+CM8S5/FlfUnGZMP5I4dRVK/Pn02QsV3Tm
         GKLC9o92EKrLzEedvrR2HYbaA2C1DcGtxdjgMjFYMm7DJpgQ1O7YAtpRr0wXCmKcd65h
         ZNa8e5e7BoKasumvgDv1RVI2NW/hVBw96c4zpoMVTTEkYOgPdBSdJ9JiQL/dwUv3x6mL
         Jg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zDy6QKCa+RVR/NM5Rdt2ekYrIEZ99lrar03e/i4SbqA=;
        b=kB5EO//88UA8hloZuslISSa56nZGhWQ2OXy0NtYUhuf28LcZboCGpNsrOAWMU/MLvu
         Ryga0Kbs2EQMF/75HJjGJfbpGb2X/41TTb2TCblDr0lBImqB4jKRk46YpdGdQ0ZZnHBu
         ZuJjAZaf63V/4+G/Zn3wJGP4zpntGl4y8Nfq2Bo6hIiAfvD6TVNfCd2wDjxlb7hVBW8f
         Imlp6qKPD2fV/4my5iBKczGtZAPMyOL7hg4b8hrLrF144k3mdp8HPmLHcuMyxFV/MQHB
         KoikyekYD3wuTfgHpepp1UYGeMAN/2TOq/mLMmQNkte1XzPNenW/QunFmTb+3iR2pV8Y
         Vwsw==
X-Gm-Message-State: AOAM530qAPcVRBJ8qsY/v1d0Mk4zaudRLFqXZSS4Pcv1Stf6AGOmc9RP
        DdaMJqg7Gln1oHVaVZPre4NR26kMjpfRSei3
X-Google-Smtp-Source: ABdhPJwdMhcWHD+R5/QzHkgpKUru9dGEyiejH4XYb5cR9CaQqAs1Gq8PjReSj6usoBeFpGIu5Sp64w==
X-Received: by 2002:a63:e0c:: with SMTP id d12mr6686959pgl.67.1613200121047;
        Fri, 12 Feb 2021 23:08:41 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id t21sm10710009pfe.174.2021.02.12.23.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 23:08:40 -0800 (PST)
Date:   Sat, 13 Feb 2021 15:08:35 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Al Grant <al.grant@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 1/6] perf arm-spe: Enable sample type
 PERF_SAMPLE_DATA_SRC
Message-ID: <20210213070825.GD103221@leoy-ThinkPad-X240s>
References: <20210211133856.2137-1-james.clark@arm.com>
 <20210212204340.GJ1398414@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212204340.GJ1398414@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Feb 12, 2021 at 05:43:40PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Feb 11, 2021 at 03:38:51PM +0200, James Clark escreveu:
> > From: Leo Yan <leo.yan@linaro.org>
> > 
> > This patch is to enable sample type PERF_SAMPLE_DATA_SRC for Arm SPE in
> > the perf data, when output the tracing data, it tells tools that it
> > contains data source in the memory event.
> 
> Thanks, series applied.

Thanks a lot, James and Arnaldo.
