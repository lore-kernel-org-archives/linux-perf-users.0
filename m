Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D08C433B4
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Apr 2021 12:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AA3F60FDB
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Apr 2021 12:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhD1ML1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 28 Apr 2021 08:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbhD1ML1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 28 Apr 2021 08:11:27 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05F2C061574
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Apr 2021 05:10:42 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id i190so3999738pfc.12
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Apr 2021 05:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s7mu3Y57y5pIYV5d5iJoFXFZCLGLwoNbNqQX0X7z0Zs=;
        b=Ty4icl1hwYcx6Mccl628E1fNZPDzCPs8J+a+/jdQxwQvLzhdDQ//MF5VZ8YXBSIuuB
         r2mIsCIGvRmwGA0AM4ES/stj3Sb70QXi58E7mxDyagBZOBOCcVrwQZoKx+mtPlMK9Ahq
         tCvLkOe1nPZcfT9fBkjswZxSruSBmCpWMxKSTcvFio/qgOoGs9nJWqDKmNViyGOBqeCC
         oGNV9upPPtR+CMaqvAJOpNAs/Hq1v0HwrK0Gg7Rh9Q4rj7v0gJQh8PrztTlDm+YM7IyY
         A0GnTr+QkE007DyfdxUkLMz5d89GsuFh+0myw1+V6vanAq/UxHHSqGWnrBqZlZjuum2e
         MFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s7mu3Y57y5pIYV5d5iJoFXFZCLGLwoNbNqQX0X7z0Zs=;
        b=RY7yX7C9YK2REjay+dXiSwEPMNkKZIazC4jEqeo1U59AEtxVF8h0ARCrxddNTwP9Mv
         zod+N4OFE+XS5HVBc911ERgi1NLOJ8LuIf/y3KQasAO67RXCArZyNVJdoIxu8J/nkGom
         Ol44NvP4+P0vk46uprcS3wIzQorGlFtEZHGW2LFa40NeF2eDBuwdA0OyqqZlZBBxXtfs
         lgjSVqZqCXN8xOOVgKbokCDZOD5Nr71LhJTOZo2+kY4aOSMPX8I3634nrBvGX6DOenFn
         xaAFd4VojYV/+TicuikpDijx+yubgYpUWD7lb67Zs2S1uYNDgeRpyfSPcaLZUj60hWmK
         370w==
X-Gm-Message-State: AOAM532IjV/rBj2ZuskdW6SkNOiOtyXdL086RtVoCvx8TOUyuUkI1WWh
        wLG+ApnuvdRWGpouSiMsQU1E1MkDTxAmCI6l
X-Google-Smtp-Source: ABdhPJwox8rEBC6U4+uFv589rsUYqLMjwrXh7LvPbDrasneJRTvtTgTxHnAqQQhdmZ2kxi1/gFtxeA==
X-Received: by 2002:a62:16c9:0:b029:24b:a41e:cd6 with SMTP id 192-20020a6216c90000b029024ba41e0cd6mr5105498pfw.52.1619611842411;
        Wed, 28 Apr 2021 05:10:42 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-18-166-74-158.ap-east-1.compute.amazonaws.com. [18.166.74.158])
        by smtp.gmail.com with ESMTPSA id g4sm2535924pgu.46.2021.04.28.05.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 05:10:42 -0700 (PDT)
Date:   Wed, 28 Apr 2021 20:10:37 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] perf: Allow TIME_CONV to be backwards-compatible
 and dump it
Message-ID: <20210428121037.GA5939@leoy-ThinkPad-X240s>
References: <20210428115749.5229-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428115749.5229-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Apr 28, 2021 at 07:57:45PM +0800, Leo Yan wrote:
> The event PERF_RECORD_TIME_CONV was extended for clock parameters, but
> the tool fails to be backwards-compatible for the old event format.

Please ignore this patch series and directly review patch set v3.  Sorry
for noise.

Thanks,
Leo
