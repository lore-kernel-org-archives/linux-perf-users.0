Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EAFC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 12:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93D1A6125F
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 12:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbhKHMWa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 07:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhKHMWa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 07:22:30 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E69CC061570
        for <linux-perf-users@vger.kernel.org>; Mon,  8 Nov 2021 04:19:46 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id r80so4668340pgr.9
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 04:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=d59ik40JE0Qg3xm+KRc3jyIsznq3a6nYEStgAFHetjk=;
        b=LVtY1Lsh1wJYicQvyIVdY0tOx9qkIjnGmoLMa1DHI9La8HlsCMrrqGVxG7vwFGnMmQ
         T2MqqJ0Ff5RI5vC+JexZJyuZ6KqnRZHj1RyIZbO2YkVnwL364B52gXu7iZ7xp5Gj2nsN
         Fi92+Up394d+7EDBMvmyfX5UUgYFP3CIt3PXQdWCF/+eLkUtzOKtUw+ACsBpvkSVmkFj
         3aE94dmPFrlswRsyIBBynPKEWtpGaBgFne3jsjtdbW+M2L164sX3MDlrkMm/Sb7Ys5+p
         du4w4WW0VJN2gqu8POXwZz+4RFzMuoczriXHNFIsMMFHv23idnMjtHcYy+bp3tWWYbdo
         emyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=d59ik40JE0Qg3xm+KRc3jyIsznq3a6nYEStgAFHetjk=;
        b=2dyhsJmLhooq0S6HX8n/vjm2ntdljZLtSwcbZDodIz8rAAXwwycjgBKFE1ZioRVDGy
         z24JS3rTlqC39HrQ+fR3Eub6PIvi5Y06cGQsBVpnU046L2lpwwKqT4vYvDO5mq8B37or
         FfZtp+RW2PYO7hzFqhrD7RbAH+BmejDdYlrLsodCurlsir+T6KETk1nlvha+HAYsnSrC
         civGqTKqC9eLE3g63MkaV5NfTTv6U+aqZbfaDgXeY1KVvPUKZGEj7YX/QYRUNUD3m4FN
         L2YXXoDliDi/yJEiVqcms7rEzEWe7B9hg2qi7hSleW5xIgzQskwVr430UlGiKy+ogci3
         U59g==
X-Gm-Message-State: AOAM533ON8rP2aybuoEo0D7KloQb9pMXm05/v0QQIaQxhLdpxDgnMTzT
        aH0ds5wgir1+iZux8ObmU2Lxpw==
X-Google-Smtp-Source: ABdhPJyVfx5SOGb17HjhO58f/lcqYt0rzNVO+yQVzsPtkOBZCJ1ixqdBfeouuQV39ZUsv1TF6Ly3GA==
X-Received: by 2002:a63:6c4a:: with SMTP id h71mr55126977pgc.173.1636373985723;
        Mon, 08 Nov 2021 04:19:45 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id j7sm12068918pjf.41.2021.11.08.04.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 04:19:45 -0800 (PST)
Date:   Mon, 8 Nov 2021 20:19:41 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     John Garry <john.garry@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Question: SMMUv3 PMU event aliasing
Message-ID: <20211108121941.GC1267967@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi John,

[ + mailing list ]

I'd like to confirm the latest upstream status for SMMUv3 PMU event
aliasing.

I see the patch set v6 of "perf pmu-events: Support event aliasing for
system PMUs" [1] has been landed on the mainline kernel, and as an
example, imx8mm DDR PMU has been supported as system PMU [2].

On the other hand, I can see patch set 5 contains the SMMUv3 PMU event
aliasing with patch "perf vendor events arm64: Add Architected events
smmuv3-pmcg.json" [3], but this patch was left out in patch set 6 and
it's never landed on the mainline kernel.

Could you share current status (or plan) for upstreaming SMMUv3 PMU
event alias?  Or if there have any block issue to prevent merging the
changes in the mainline kernel?

Thanks for your help!

Leo

[1] https://lore.kernel.org/lkml/1607080216-36968-1-git-send-email-john.garry@huawei.com/
[2] pmu-events/arch/arm64/freescale/imx8mm/sys/ddrc.json
[3] https://lore.kernel.org/lkml/1604666153-4187-6-git-send-email-john.garry@huawei.com/
