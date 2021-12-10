Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2E1C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Dec 2021 17:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243095AbhLJR0B (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Dec 2021 12:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbhLJR0A (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Dec 2021 12:26:00 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A25C0617A1
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Dec 2021 09:22:25 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so9898096pjc.4
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Dec 2021 09:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wXxIFl9RShCE91zPfAkRMM2xkNysozE7SyLpZ9J+nMQ=;
        b=EpE/rgKdOcYRenD95ZbWiQrngH8Tl15OH1snNOs8EPxs3GgWkEvorwVblkx2wsBJUg
         WA+LTAFlx2XwAeZr3dV3mIAIjR9vXel5L/1w3zL8PpIYRc6aoBxfFrNowMuiolR8T7hU
         7EpFi6deY8yIV1h0OjLPFhXPScAQYwqYMi2tndjchJBe921C8lJDx8fk4UTYBGT2gGyB
         JOz7BhUosg66vAmhJkHA2QSfqnU0tkxSYJYnARFGaLBCwvuNKkuTRXCd3tCqu1cSCC+J
         PlMrXVfKzQKW9+/1/BkY5DQXDsC5eqvUWki3FrzIo9wgpEPzQRjehGuL+1vDtm+SPOaI
         GTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wXxIFl9RShCE91zPfAkRMM2xkNysozE7SyLpZ9J+nMQ=;
        b=X8tq2jRIhwtPbgJCWNoyIdgM2N0KPlpq2ghDxQs4u68CjfVQcf2c0Fwr/h5RwF+gWl
         DDFqsIzd8C3vymNYL/0CwEWn/RrEtjzmlaDynCie6NL5CP2StdNXlLbs68JJKHTXmtSU
         0pYVS2eUJ06kZ0E5OeMC/fAdHftaqYazhDgrvcI4Pfk9qQogkgUZOpsCo8UreLNyi9pU
         EanddxC9FAkhreUgKXuXQ3GGDeOZud6zS5MM2Q9xVqXdr5Xuphw43F7n2lW6m/z0fAcR
         s/LAwUAs69JTkoKTI23D/lzULkl7t/ddzLS/aab4p7Cyj/wP4ZYtbokuZj9s9ZNJSZv4
         z5Ng==
X-Gm-Message-State: AOAM530GCZ+eVyiV7ONrfRUJ9cbFiDIoxhjqFJTiW6uPEp4G9wVPctTa
        4sEt31leUMCQ+Kl87IgLHotusg==
X-Google-Smtp-Source: ABdhPJx7Vdr5SMDMisR3Ceovs6RgrPHB/lYT7Zy/5wLyTyte6MMYQevltUY2u+OivAZiAKVpeaB1Pw==
X-Received: by 2002:a17:90b:4f49:: with SMTP id pj9mr24773259pjb.159.1639156944110;
        Fri, 10 Dec 2021 09:22:24 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id h66sm3110587pgc.34.2021.12.10.09.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 09:22:23 -0800 (PST)
Date:   Fri, 10 Dec 2021 10:22:20 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/3] coresight: Fail to open with return stacks if they
 are unavailable
Message-ID: <20211210172220.GA1238770@p14s>
References: <20211208160907.749482-1-james.clark@arm.com>
 <20211208160907.749482-2-james.clark@arm.com>
 <b52ef2f3-9e30-59a6-2aea-e46c93915868@arm.com>
 <b61ef2e3-e573-4867-af5d-fd5fabece4b1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b61ef2e3-e573-4867-af5d-fd5fabece4b1@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi James,

On Thu, Dec 09, 2021 at 11:13:55AM +0000, James Clark wrote:
> 
> 
> On 09/12/2021 11:00, Suzuki K Poulose wrote:
> > On 08/12/2021 16:09, James Clark wrote:
> >> Maintain consistency with the other options by failing to open when they
> >> aren't supported. For example ETM_OPT_TS, ETM_OPT_CTXTID2 and the newly
> >> added ETM_OPT_BRANCH_BROADCAST all return with -EINVAL if they are
> >> requested but not supported by hardware.
> >>
> >> The consequence of not doing this is that the user may not be
> >> aware that they are not enabling the feature as it is silently disabled.
> >>
> >> Signed-off-by: James Clark <james.clark@arm.com>
> >> ---
> >>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 13 +++++++++----
> >>   1 file changed, 9 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> >> index d2bafb50c66a..0a9bb943a5e5 100644
> >> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> >> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> >> @@ -674,10 +674,15 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
> >>       }
> >>         /* return stack - enable if selected and supported */
> >> -    if ((attr->config & BIT(ETM_OPT_RETSTK)) && drvdata->retstack)
> >> -        /* bit[12], Return stack enable bit */
> >> -        config->cfg |= BIT(12);
> >> -
> >> +    if (attr->config & BIT(ETM_OPT_RETSTK)) {
> >> +        if (!drvdata->retstack) {
> >> +            ret = -EINVAL;
> >> +            goto out;
> >> +        } else {
> >> +            /* bit[12], Return stack enable bit */
> >> +            config->cfg |= BIT(12);
> >> +        }
> > 
> > nit: While at this, please could you change the hard coded value
> > to ETM4_CFG_BIT_RETSTK ?
> > 
> I started changing them all because I had trouble searching for bits by name but then
> I thought it would snowball into a bigger change so I undid it.
> 
> I think I'll just go and do it now if it's an issue here.

I can apply this set right away and you send another patch to fix all hard coded
bitfields or you can send another revision with all 4 patches included in it
(bitfields fix plus these 3).  Just let me know what you want to do.  And next
time please add a cover letter.

Thanks,
Mathieu

> 
> > Otherwise, looks good to me
> > 
> > Suzuki
