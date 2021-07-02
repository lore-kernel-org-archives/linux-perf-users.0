Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA2BC11F67
	for <linux-perf-users@archiver.kernel.org>; Fri,  2 Jul 2021 01:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D01361410
	for <linux-perf-users@archiver.kernel.org>; Fri,  2 Jul 2021 01:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbhGBBeZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Jul 2021 21:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbhGBBeZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Jul 2021 21:34:25 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D19C061762
        for <linux-perf-users@vger.kernel.org>; Thu,  1 Jul 2021 18:31:53 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id z4so4744883plg.8
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jul 2021 18:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2VS8QrT4FkOZf/FxdigYQ26l7luOXyTJp7RV8GPJrdE=;
        b=YOglFXKrkWo5dpfRFx0RdzPtuj4a/f0VTge5boEtc45ZjeSKS8YYTXDaYG8IOGMukk
         Xm/WELpFafE2KhJgnmw0qnx2ArVyuGn1DxP6UAFkFtMb617XPjzn2glQ3gOVaWuZStaO
         Gr37qU+YoI9TKhtO6l7ppHSmuaAGUa8DhVMmc8hg9AB8KV9Q1kjrWAB4el6OwPt/Q1zO
         8bnwQ3WvNCUDpG9DuEJPpztMOBVjlbiADAns3GXj+kCNbgBv88a8HHBzWinGKdy3xXu2
         hy9MxJbV2nqnEE+AbQiKuFtgGTVAzH0oX+iZVEOpc2PuQVKrpmtHVd98Ym8XRTyajM3X
         FEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2VS8QrT4FkOZf/FxdigYQ26l7luOXyTJp7RV8GPJrdE=;
        b=jK1DEFXiFI8J40+mm/DQn1NZJAI/S5Wbv2qEVx7Yf+8sOvKIt0yEs3LPtKuH1rGLei
         iEu69T0vmnRBujsf3ze9kQbU8YxcoxKgQySMa+eGmTw88rUm5IS422FOhxA/ES8caAt8
         b2UCLcmCjcUnB/Ld2hyqHbCwOy8dOKj2z3UpYO4ah9fF6wdx5eRgez6kWyis83UIEc9B
         XQG25vevnYPsb0zSgdWEZO85DVPiBWEtAUKw4dLzR64x6BEf6RyuRRsGP16f07xVhyO0
         wcTtWuG3Rd9IVzZXaIMbW2uxtMQgsa3dq6LhjNV2E1OYi8LXF+aMvuZdS5QtoQsCPpcn
         XrKQ==
X-Gm-Message-State: AOAM533Hnro3dGWSS+ji1ZcIoIfGv60O3KSeX9bsjGVJ3FcnfcMKEkwd
        j7Z+Xeo8PgQUkkw5MdLpZe60MA==
X-Google-Smtp-Source: ABdhPJwBlYWe733SkOJLsfGovF+cVSjYu3148ezEuyNifXWhyvR+fX8TyG2SEVd/heJH5iHnBVGNFw==
X-Received: by 2002:a17:90b:4b8d:: with SMTP id lr13mr2402518pjb.89.1625189513083;
        Thu, 01 Jul 2021 18:31:53 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id gz24sm852593pjb.0.2021.07.01.18.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 18:31:52 -0700 (PDT)
Date:   Fri, 2 Jul 2021 09:31:43 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>, Al Grant <Al.Grant@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] perf arm-spe: Don't wait for PERF_RECORD_EXIT
 event
Message-ID: <20210702013143.GB251512@leoy-ThinkPad-X240s>
References: <20210519071939.1598923-1-leo.yan@linaro.org>
 <20210519071939.1598923-6-leo.yan@linaro.org>
 <369fd454-d94d-daa1-ead4-b42645ec4282@arm.com>
 <20210628121217.GD200044@leoy-ThinkPad-X240s>
 <YN31VC9e/33QYhwn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YN31VC9e/33QYhwn@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jul 01, 2021 at 02:03:16PM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > Hi Arnaldo, I confirmed this patch set can be cleanly applied on
> > the latest acme/perf/core branch, so could you pick up this patch
> > set?
> 
> Applied, thanks, please let me know if there is still something
> outstanding,

Thanks, Arnaldo!  I confirmed you don't miss anything.
