Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED308C433ED
	for <linux-perf-users@archiver.kernel.org>; Tue, 11 May 2021 08:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB7A161928
	for <linux-perf-users@archiver.kernel.org>; Tue, 11 May 2021 08:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhEKIHY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 11 May 2021 04:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhEKIHW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 11 May 2021 04:07:22 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC589C06175F
        for <linux-perf-users@vger.kernel.org>; Tue, 11 May 2021 01:06:15 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id q2so15442237pfh.13
        for <linux-perf-users@vger.kernel.org>; Tue, 11 May 2021 01:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=owL/4Levsbr9ZSdMY4wPEiIgPr6GonMYfwkwZ8+sBwc=;
        b=WdsVMzw5hMV3bpevyN4y/+8vNyWJPzr8NHJEo7BFpTmqs+8FT6YlbQUBVryuJ4fWul
         v2u0iA/uN6aXvyuG6a9l92kUtS0KQvwWtUntXwFiTreAedIkwLDK44GOvT4gTqTxH8mh
         9otyMAuHnoEskR24vEZHE5yQnVl5LgxzU0wkreU5hq2Xn7BFc+Z0kBn000Ila/bdjk9o
         2VZmIBcHb2ZgkeK2gBk+V2/O+EqIk0y4Sn8U4TLAPEYUWGDNVIJkQR6dAZrFUZFOlirD
         iTKg9UJ8CXzNuCRMmoN5yb10JdCRrs7zS3zivhAraGN2F3j00nIlYihaqs4+aq7SKb+Q
         cBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=owL/4Levsbr9ZSdMY4wPEiIgPr6GonMYfwkwZ8+sBwc=;
        b=iiANnuDEsaN28GxJmECNN/LLbJS79XttW2UHNHttswTzVCfI3ClkjEGsWYWwNmpkhB
         7JpxPgt/fwqXeilv8sFD1PvbedzGqDhv3+d04G39XWnwYE4ICQktmE+/oQF+3gKJ8LM0
         26XOviuHf0bo8McUEsR+2qUhAPxdO1gTWm3hKjctJZmisey7nenWxRtXQExyNL9KdaAi
         nBrsqPLog4kovBuuJ3MzutCLvwyXHrMr+/TfqCdTus2/dbYapPtYlkzMCzHcMfcFXb0r
         RG8VzBLBC3GKjeE0bKUBI7VMisrHuOOVbhG3WbC7w8+NiIorl+fd8v9NOfXOq7IJjpaj
         hojw==
X-Gm-Message-State: AOAM5308r9Fa5tmMl8EonBj/AkegPgjO01L6ASytsnL4oOGA5CfMoHp9
        SpwK42f6HaivQMO2Ojnbtnz9TmekOiaEJDWc3zQBhQ==
X-Google-Smtp-Source: ABdhPJy/IpuNzfVlzHBbQnYHtWtbClkdPrzK/5eTeFhvGdUmoXvn7GLPxtZ2SwEo8SN6ofJVFb6GhcZ1I1MrmHivm9g=
X-Received: by 2002:a63:e918:: with SMTP id i24mr29602351pgh.118.1620720375143;
 Tue, 11 May 2021 01:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210507095814.17933-1-james.clark@arm.com> <3926c523-3fdb-66de-8b9c-b68290a5053e@arm.com>
 <20210510053904.GB4835@leoy-ThinkPad-X240s>
In-Reply-To: <20210510053904.GB4835@leoy-ThinkPad-X240s>
From:   Denis Nikitin <denik@google.com>
Date:   Tue, 11 May 2021 01:06:03 -0700
Message-ID: <CAOYpmdFYs8=FzpiA-mMNZ=L8B9GRXLfQuEnMeDsvWeeKg2PWtA@mail.gmail.com>
Subject: Re: [RFC PATCH] perf cs-etm: Handle valid-but-zero timestamps
To:     Leo Yan <leo.yan@linaro.org>
Cc:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Al Grant <al.grant@arm.com>,
        Branislav Rankov <branislav.rankov@arm.com>,
        Denis Nikitin <denik@chromium.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        anshuman.khandual@arm.com, Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Leo,



> Just remind, as Mike has mentioned that if the timestamp is zero, it
> means the hardware setting for timestamp is not enabled properly.  So
> for system wide or per CPU mode tracing, it's better to double check
> what's the reason the timestamp is not enabled properly.

The bug is confirmed by HW verification.

>
> IIUC, this patch breaks the existed rational in the code.  Let's think
> about there have 4 CPUs, every CPU has its own AUX trace buffer, and
> when decode the trace data, it will use 4 queues to track the packets
> and every queue has its timestamp.
>
>   CPU0: cs_etm_queue -> ... -> packet_queue->timestamp
>   CPU1: cs_etm_queue -> ... -> packet_queue->timestamp
>   CPU2: cs_etm_queue -> ... -> packet_queue->timestamp
>   CPU3: cs_etm_queue -> ... -> packet_queue->timestamp
>
> The issue is if all CPUs' timestamp are zero, it's impossible to find
> a way to synthesize samples in the right time order.

Is it really impossible or it just can lead to incorrect decoding?
I verified the profiles generated with zero timestamps and this patch
on Trogdor (8 CPU cores) and I don't see any significant difference
in the quality of the AutoFDO profiles.

If mixed packets don't cause errors in reconstructing the branches
but instead mess up with their timeline then it probably won't matter
for AutoFDO which just collects statistics of the branches.
What do you think?

>
> [...]
>
> Thanks,
> Leo

Thanks,
Denis
