Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEDFC47082
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Jun 2021 00:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE77461351
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Jun 2021 00:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhFIAXN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Jun 2021 20:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhFIAXN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Jun 2021 20:23:13 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCA2C061574
        for <linux-perf-users@vger.kernel.org>; Tue,  8 Jun 2021 17:21:19 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso322067pjb.4
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Jun 2021 17:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SUSurW0ZMpnhJbzbS53tzEqvRTwb1JQbgIpFtsDUWIc=;
        b=goZ/SSCbwi7fd6AwwMEZoYjuXpEq5Qpa/PVXI2TpzZL1qeEBx92eBiFPVPZe4ELYzh
         0s87uJVTFrMy0eoj7jUOzZviLk4ERwufGsLCFoXKARsjB93n9pyK8jWVgtFltmV75aRM
         XUMz5bIBsWr06SsrNmdY5hc6pIuqD7aQ3nAD5PLog2kQxr2iPsk9If/UKa2SLorT1mko
         drZUZQxFvZ8RQtsCrRrmeFUbVLsj1yGPnwVOCyo3VeBvDXJsDK23dhpxPnUDXMR8QJ3K
         ZX/Fm5cEvZhcJ+WVP20cemfigfPm9g+FF64KDIzzHZnmHiMWK7evyS2IPoKsMwf1n8GA
         0Q7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SUSurW0ZMpnhJbzbS53tzEqvRTwb1JQbgIpFtsDUWIc=;
        b=FhCLWYXDRgoae7okSORN9x5w9X4gMsEJeCypMBtAid4bMygeD1pg0RfV44i65Bpvdf
         ENI43Chs3XzZ7tgT1VE/8lSsQrGehxhZczKItqNShqTzzDsyylCBZlZ0tR0hm3xCwclt
         d9T74b3Q8dt8phkDZ0pCsjPtiJ1yOLdlzJ2DNIybkSVIunW0Lb8V/qx7EFdmIkdhZ5If
         bbqX6f9DVrP2DLphfKr1xLO8/5ov9KhkVbww1XUDoQmKEhefM9l/SQulBzgICGcL166u
         E66hFuh0uC9+kFCveKFKkFDyzGB/NfiQve3NTEZQoOEwYzZ1WeA7bTvRtpd0hGAv9EFs
         Sdcg==
X-Gm-Message-State: AOAM533zTTtDCL1SVMkDv8WpZbfpl5K6W9ekmApjOaS3HW0Q7a/rkjnN
        pK2YOVjtIGycKlr/JwvKFoVOCg==
X-Google-Smtp-Source: ABdhPJzz/Yg5KVuOOZfw/OoZ0q9ATA2yy973WJeZW1TwozVYZniWMUiBan3/hasgUiRAdAz0S2kOJQ==
X-Received: by 2002:a17:90a:4092:: with SMTP id l18mr7543340pjg.35.1623198079227;
        Tue, 08 Jun 2021 17:21:19 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id fs10sm3314608pjb.31.2021.06.08.17.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 17:21:18 -0700 (PDT)
Date:   Wed, 9 Jun 2021 08:21:11 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 7/8] perf auxtrace: Use WRITE_ONCE() for updating
 aux_tail
Message-ID: <20210609002111.GC4640@leoy-ThinkPad-X240s>
References: <20210602103007.184993-1-leo.yan@linaro.org>
 <20210602103007.184993-8-leo.yan@linaro.org>
 <YL47tdD0ygaErZu+@hirez.programming.kicks-ass.net>
 <YL+jHu4c5rLkKb9i@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL+jHu4c5rLkKb9i@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

On Tue, Jun 08, 2021 at 02:04:30PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jun 07, 2021 at 05:31:01PM +0200, Peter Zijlstra escreveu:
> > On Wed, Jun 02, 2021 at 06:30:06PM +0800, Leo Yan wrote:
> > > Use WRITE_ONCE() for updating aux_tail, so can avoid unexpected memory
> > > behaviour.
> > > 
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > 
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Leo, this one is dependendant on the 6/8, will wait for a resubmission,
> keeping 5/8 tho, as was Acked and applies cleanly, perf/core.

Yeah, will respin for patches 6/8 and 7/8.

Thanks for merging patch 5/8.

Leo
