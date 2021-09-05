Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69078C433FE
	for <linux-perf-users@archiver.kernel.org>; Sun,  5 Sep 2021 21:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 533A66103B
	for <linux-perf-users@archiver.kernel.org>; Sun,  5 Sep 2021 21:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238290AbhIEV0J (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 5 Sep 2021 17:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238335AbhIEVZ7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 5 Sep 2021 17:25:59 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE74C06179A
        for <linux-perf-users@vger.kernel.org>; Sun,  5 Sep 2021 14:24:55 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n5so6774713wro.12
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Sep 2021 14:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U3Ro53yz8uw6vk4h4zC5lI6ueqo991M4PwceXdZ+bXY=;
        b=vQ8N7ru7WahMrJRdMS90zF/LDCNk/RYQV9OofxORJyliNuh5Gh6yaPmND+PUS0T0bK
         UP8514godi00eChnDkrSAUjxHUMderXcNW0jBsBfsDSR86clxCPxPB0O5NmvLjnp5BVf
         MIGFuabyVniHnpIPdxCh5O4r3SfvTNvPA+LPKOz10jDLcJJenMxqPIDm7dxaStXwCAE9
         sIZK5dK9KPL68594iLPsh7PDYzOUWXcatIxXvbWPPGAJkgOlcf3HzCB3v546IY2pxwpN
         k25em+rs9WQEOGy/szRbjWiAerQC9Y2InEpKalEySYG/DSov2i9j+Xkw2XPtrzR5qibR
         2yhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U3Ro53yz8uw6vk4h4zC5lI6ueqo991M4PwceXdZ+bXY=;
        b=D/gTcdZS2cRXB3Msz1AfNxSvSwZmjUyiog6qjdNpmodMu9RYM4xgVkC+arqwwyJANT
         BJrN8dUBhmXknf3feTV7OIDcsm+fWNJbmLSpdcoZat3xNifq9yTWTnw4M8kx1tubIapf
         YmySc2AndyV29KiXK5FjVV09Ztfa0Mfi6i9+pZir85hz1Cf2nesnreMMNOStgrASDq+b
         xSm4ivXFvp3kJsugP43hu8X+cyW8F/FpW9TCbRk1C/Kv5VQnQ4sFoCpEtsGDAtlMGglE
         fpTzlM95c4Rq7uztvZaLsLBP/XSuMu/IvvnbCCkNPuqNJ9mX+qrkv+h1pFZ1eyVgUWVW
         /pMg==
X-Gm-Message-State: AOAM530E4vp3drHxOtjpK51k67h1J8zYp1qPwx3rvDFqx53YAE58sTdn
        uvoiivOgusYWIBtnkxguGCiU5wJvsVIu1OgAYRZr4A==
X-Google-Smtp-Source: ABdhPJyJEJvlxVUrEiEYvPim72MfF6HcVKkJK+/ZbECHn7x8no3FMAchzagrpcHRErlr4pLxjvDOSsBw2laSTnMlU2I=
X-Received: by 2002:a05:6000:160c:: with SMTP id u12mr9848692wrb.128.1630877093840;
 Sun, 05 Sep 2021 14:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210806134109.1182235-1-james.clark@arm.com> <20210806134109.1182235-9-james.clark@arm.com>
 <de23e803-3840-501e-87a8-39eed7ba434b@arm.com> <YTIElk3Zv3VNJU+q@kernel.org> <YTIMhNAAtm/s2gjV@kernel.org>
In-Reply-To: <YTIMhNAAtm/s2gjV@kernel.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Sun, 5 Sep 2021 22:24:43 +0100
Message-ID: <CAJ9a7Vg_hNPugGBNnZCQ=eewqcoxjH=sCr0_wMW4yaCfJYyEXQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] perf cs-etm: Print the decoder name
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Reviewed-by: Mike Leach <mike.leach@linaro.org>


On Fri, 3 Sept 2021 at 12:52, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Fri, Sep 03, 2021 at 08:18:46AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Sep 03, 2021 at 10:17:25AM +0100, Suzuki K Poulose escreveu:
> > > On 06/08/2021 14:41, James Clark wrote:
> > > > Use the real name of the decoder instead of hard-coding "ETM" to avoid
> > > > confusion when the trace is ETE. This also now distinguishes between
> > > > ETMv3 and ETMv4.
> > > >
> > > > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> > > > Signed-off-by: James Clark <james.clark@arm.com>
> > >
> > > Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >
> > Thanks, collected the Reviewed-by.
>
> Everything is in my tmp.perf/core branch now, pending test build in my
> containers.
>
> - Arnaldo



--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
