Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0570BC433E0
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Mar 2021 08:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C466D64FC0
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Mar 2021 08:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbhCJIiT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 Mar 2021 03:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbhCJIhx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Mar 2021 03:37:53 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6207C06174A
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Mar 2021 00:37:52 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m22so32072095lfg.5
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Mar 2021 00:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=IRYx2mpIgXGXvPxAmMF2cwzaBZqCvnZYDwdOQK7J3Og=;
        b=i1bBjprS+YR2jVFnKNq8BsEAJTAb3ogmqgvRHPtLNvoJ1DnoHIXWA0boFKCQcu4gc1
         n8+WnkzpODFFaVH/VQsJOtdna5jmhtO8tNjgm5cLTNee+Diz7052BvlZ32jodywJQZFv
         10cGJ5sAf7OLW/Vb9xpuVz6ZKJB0l3DHGAWidqjXahviQ+huwB7qCoSbzOe3bNkDXn5F
         S8cMC7MhS5s2uihf4GaF7bGRdU/TJsbKZbfIQAD+axlGzueqYUTT2nGcsgcH64t4i+RF
         CwI6isEo9hdM3v6YRsnRiy/QqXr4FcbjK4kvoUVdjF/X9GvtiMEx1t8MNcu6FsxN1vGi
         YUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IRYx2mpIgXGXvPxAmMF2cwzaBZqCvnZYDwdOQK7J3Og=;
        b=gNauk+B+44rEescJcphoLsAKn2vjduvIzaqwfMK1NlsJm3F75jOqR1eyl+L5e50kvJ
         Ddik4ctfQnhX+ECpwbYxGy19lWAiA3AXMqI8ycnL5EQMxqoHxzFgAhtAHrVQZgbjWJI6
         wq/L+VB6MDwM2J/Y6Km43JLB2D6njkNQuDPUaupyu36U/4RdGwZicXASRMU8Fi06oXEW
         t5wOLHGYVCKfx8k5gDhB1qYZpZFjRc1L2vHuKpCDL8SMU059xYxToDZOcP3MYqhQEJL0
         EQa6jzCvr+f5rhabEjMZ7xB9Ejc89pA5R2TAvgmdR5WSajK5klI6cePHrtnf8SUXNcXw
         apcw==
X-Gm-Message-State: AOAM531G4qOzOkNnD86e/R8+zrvZQFT7dgmh6wmu/Y6WvjsBKmsV5ntt
        SPebvgYxS8kQOvetEIREAIegPK+fI3LygnhZ/DBJNyZo/r2A1w==
X-Google-Smtp-Source: ABdhPJwxA74OIh4CCgamBZ2Afd0pDLAOWyXIPsWa2feYyMANxAjVMNirHl7VvwBrHXun7hzGF9g/L9CgsYwIE2KItZw=
X-Received: by 2002:a05:6512:398e:: with SMTP id j14mr1511717lfu.9.1615365471269;
 Wed, 10 Mar 2021 00:37:51 -0800 (PST)
MIME-Version: 1.0
From:   rainkin <rainkin1993@gmail.com>
Date:   Wed, 10 Mar 2021 16:37:15 +0800
Message-ID: <CAHb-xauBfO+Ted+0e-rGQaz-Tq3hqbbrFUCdSpOkWBvrWkZdXQ@mail.gmail.com>
Subject: [Question] Cannot sample lbr callchain on qemu-kvm guest machine
To:     linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello~

My config:
===============
Host:
CPU: i7-10700
Kernel (5.8.0-41-generic)
Ubuntu (20.10)
Qemu (5.0.0, Debian 1:5.0-5ubuntu9.6)
===============
Guest:
CPU: host-passthrough (qemu -cpu host,migratable=on)
Kernel: 5.4.0-66-generic
Ubuntu: 18.04
perf: 5.4.86
===============

I try to collect lbr callchain on a virtual machine.
Thus I execute the following commands on the virtual machine:
"sudo perf record -e cycles --call-graph lbr"
and get the following errors:
" cycles: PMU Hardware doesn't support sampling/overflow-interrupts.
Try 'perf stat' "

Does anyone know the reason?

Thanks
Rainkin
