Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11350C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 18 Feb 2022 10:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbiBRKqh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 18 Feb 2022 05:46:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbiBRKqg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 18 Feb 2022 05:46:36 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6942B3ADF
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Feb 2022 02:46:18 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 132so7488445pga.5
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Feb 2022 02:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LAy9H/l1KWh4fEiWJeqleJ0QHDEZvecxPJTGx+dOoeQ=;
        b=zQP2DkmSP1w7wdCEkRYZL2SWr0Uiz5YUoO4L3J7HwGpQwYrcKDP63GwwH/Gsj6yuZ1
         pIHm70tjJtva+sTQdqzGCOmW4jwYLxAo0zg6kR2v/fC946ru/zrSYEvqOeUU4LkXY5WJ
         zKlZQM78u+OGQwISssqDFOqK1or0PGBvJW0W0/7ievNql9gZ7DHcPoVGwMJoU/oNZQDJ
         5aeeJ1VIVZRvp6D+dMbkfCtQDPUJqokovXvViqUVo9s8DITwT4MUbobl8D/Y9MIpha/6
         4f55G83fZpO0Q281Vw24tnz1PBW3InBaFE24y+s79Y/l4JDK7TMLNaSDfHg8QTNnEpPB
         qUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LAy9H/l1KWh4fEiWJeqleJ0QHDEZvecxPJTGx+dOoeQ=;
        b=zx6a9gj/K8GTlMVvRtBzirM5qcJ65CSp56lQz4JWGUw+ZPX30rFmPO7V914m7vPYpO
         c7v2IrZcRhZI1QQRUxGib+9Oxtcf2Olb6m8VvWTdsdOytNJqDmh/k9lCUjZiBADN9/fY
         avQLfgY6udZSvr5bu1Ogy38HRhOaCjPna7nKb1GCfogBcE9ZtObIoiK+ez7RMDGkJoCu
         QYNT3pMpKU+PL2/cTGIOvfj/dwAWJ3hs8mdAAOC6sAtraPJogEd+9QruvbTqGiEBnCUV
         gmubNf8EZ4z4fB0+SJsr3ZkL0ftUOZNyx5CkubOeq3cOm45+Lb7fFGuIWMkQSuEodBaQ
         00aw==
X-Gm-Message-State: AOAM531IUuyJZ+GFiNfIqkYNmu72/OHhYxcYcOdgKBGC33sz4BOmW0t+
        3uQ/b0sjR7jxt+kVAVzuNjtztg==
X-Google-Smtp-Source: ABdhPJwGtw4sZz0qpalh7OWQa3lBdQSvJkO1h9NOHuXGe8fFyRc9X4o4BQsE0THQpb5h03AeDkUGUQ==
X-Received: by 2002:a62:7554:0:b0:4e1:5898:4fbb with SMTP id q81-20020a627554000000b004e158984fbbmr7102723pfc.2.1645181177951;
        Fri, 18 Feb 2022 02:46:17 -0800 (PST)
Received: from leoy-ThinkPad-X240s (216.24.179.146.16clouds.com. [216.24.179.146])
        by smtp.gmail.com with ESMTPSA id np15sm4919722pjb.44.2022.02.18.02.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 02:46:17 -0800 (PST)
Date:   Fri, 18 Feb 2022 18:46:11 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
        elver@google.com, dvyukov@google.com, will@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        tmricht@linux.ibm.com, irogers@google.com
Subject: Re: [PATCH v2] perf test: Skip Sigtrap test for arm+aarch64
Message-ID: <20220218104611.GD56419@leoy-ThinkPad-X240s>
References: <1645176813-202756-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645176813-202756-1-git-send-email-john.garry@huawei.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Feb 18, 2022 at 05:33:33PM +0800, John Garry wrote:
> Skip the Sigtrap test for arm + arm64, same as was done for s390 in
> commit a840974e96fd ("perf test: Test 73 Sig_trap fails on s390"). For
> this, reuse BP_SIGNAL_IS_SUPPORTED - meaning that the arch can use BP to
> generate signals - instead of BP_ACCOUNT_IS_SUPPORTED, which is
> appropriate.
> 
> As described by Will at [0], in the test we get stuck in a loop of handling
> the HW breakpoint exception and never making progress. GDB handles this
> by stepping over the faulting instruction, but with perf the kernel is
> expected to handle the step (which it doesn't for arm).
> 
> Dmitry made an attempt to get this work, also mentioned in the same thread
> as [0], which was appreciated. But the best thing to do is skip the test
> for now.
> 
> [0] https://lore.kernel.org/linux-perf-users/20220118124343.GC98966@leoy-ThinkPad-X240s/T/#m13b06c39d2a5100d340f009435df6f4d8ee57b5a
> 
> Fixes: Fixes: 5504f67944484 ("perf test sigtrap: Add basic stress test for sigtrap handling")
> Signed-off-by: John Garry <john.garry@huawei.com>

I tested this patch on my Juno board:

root@Juno:# ./perf test 73
 73: Sigtrap                                                         : Skip

Tested-by: Leo Yan <leo.yan@linaro.org>
