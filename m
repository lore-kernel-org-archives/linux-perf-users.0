Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1578FC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 18 Jan 2022 12:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236833AbiARMnx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 18 Jan 2022 07:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236802AbiARMnw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 18 Jan 2022 07:43:52 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7FAC06161C
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Jan 2022 04:43:51 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id f21so21764676eds.11
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Jan 2022 04:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rTGN2etA9k5qiSP7ZrVqfOL8gvgrJ9M1T4KKkJp0QWM=;
        b=GgxT31tFLd4a+OUKWDBAd70k8Yeeis6kDp5b2gHUS0rGPxK22UFqKkvQHm0U5/YGny
         WAI5UQZMbjfqyfhFAt3GUf5SW/PEDJsiYw9N45rxF6tP6Nh4J+6RNR/2alpDopSkfSN5
         RcCdPiKochKA+ids16pdZwSQcj+xwNyCSwtpYaGzUTt7zdlLTEcvMm+itvOKBadIBs1C
         SN3Gf7iQ9Hcld3vlEWzY64gJGltq3voMpToPLBCArLOUrq4cgEzzjVDZvnFrgRvmwASO
         fY40TU7it9R2XzyyGOKm4uZft57FbbxvdnfMULLZTfa4jjfoJoBfeGtJAbQtw1czcSDM
         PsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rTGN2etA9k5qiSP7ZrVqfOL8gvgrJ9M1T4KKkJp0QWM=;
        b=B1FK1vbL9UsQEohb/z+TZVMCZhetHPBpZnIlRTXO2IEZvl94qQtzWPuoYPEo2RVD3S
         2o6aU58J51VttenFhZleqcQTgVCLlCZxDCVuiz69mPQ4nuQZJXl3SLvK0jRoIQynHt74
         F1BUI/wq2RyPZRurLiP23LggfonXwo4u8ECpzDTuW+N196xhPP7KP3h3F6PEFK0yq96E
         g2AwzqtBTGl7M9Y4OY3U1AscMn8KvOLytZXrzEmgqq0+du9Er9ITMLmBRrZZPikTmP4t
         nG1bTH8chhqVmcGfOK+tJpth2DQMx36oqTeKCDaIt3qSMZXbAWZm4NnfUNX6BzkNllyr
         b5SA==
X-Gm-Message-State: AOAM530EYGdxJNMCfFMiheJoZ/JLX1bfeamXgkNg6tCljrLvRlWs0ZoH
        6w9uZU9ho4cbdL4gyaqOJf8Lww==
X-Google-Smtp-Source: ABdhPJz18wxKnoCux8+DSsMS7vloPGlf4s5356a/BEFnwnKL4xDDaTm/Qma52lDPuXb9GXYfzIVi+w==
X-Received: by 2002:a17:906:9b87:: with SMTP id dd7mr19839112ejc.178.1642509830140;
        Tue, 18 Jan 2022 04:43:50 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([104.245.96.239])
        by smtp.gmail.com with ESMTPSA id r27sm2379066ejc.42.2022.01.18.04.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 04:43:49 -0800 (PST)
Date:   Tue, 18 Jan 2022 20:43:43 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Marco Elver <elver@google.com>
Cc:     John Garry <john.garry@huawei.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] perf test: Test 73 Sig_trap fails on s390
Message-ID: <20220118124343.GC98966@leoy-ThinkPad-X240s>
References: <20211216151454.752066-1-tmricht@linux.ibm.com>
 <CANpmjNNMWtjcKa961SjEvRbbPXyw5M5SkrXbb3tnyL3_XyniCw@mail.gmail.com>
 <90efb5a9-612a-919e-cf2f-c528692d61e2@huawei.com>
 <20220118091827.GA98966@leoy-ThinkPad-X240s>
 <CANpmjNMPoU+1b1fKFuYDYwisW2YfjQHxGt5hgLp1tioG7C2jmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMPoU+1b1fKFuYDYwisW2YfjQHxGt5hgLp1tioG7C2jmg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jan 18, 2022 at 12:40:04PM +0100, Marco Elver wrote:

[...]

> > Both Arm and Arm64 platforms cannot support signal handler with
> > breakpoint, please see the details in [1].  So I think we need
> > something like below:
> >
> > static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
> > {
> >         ...
> >
> >         if (!BP_SIGNAL_IS_SUPPORTED) {
> >                 pr_debug("Test not supported on this architecture");
> >                 return TEST_SKIP;
> >         }
> >
> >         ...
> > }
> >
> > Since we have defined BP_SIGNAL_IS_SUPPORTED, I think we can reuse it at
> > here.
> >
> > [1] https://lore.kernel.org/lkml/157169993406.29376.12473771029179755767.tip-bot2@tip-bot2/
> 
> Does this limitation also exist for address watchpoints? The sigtrap
> test does not make use of instruction breakpoints, but instead just
> sets up a watchpoint on access to a data address.

Yes, after reading the code, the flow for either instrution breakpoint
or watchpoint both use the single step [1], thus the signal handler will
take the single step execution and lead to the infinite loop.

I am not the best person to answer this question; @Will, could you
confirm for this?  Thanks!

Leo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/kernel/hw_breakpoint.c
