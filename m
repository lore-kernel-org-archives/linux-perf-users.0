Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697BCEC875B
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Sep 2023 21:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240869AbjIGVJL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Sep 2023 17:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjIGVJI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Sep 2023 17:09:08 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D155092
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Sep 2023 14:09:04 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-414ba610766so109291cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Sep 2023 14:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694120944; x=1694725744; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=22+VoOjuMAdph8IrYWRiY4zsDuiQCgTZzignJ/ClYnM=;
        b=FXrPxqtRuRqapkVU9y6XOJqtj94kvGpxbpMz1TXZDY4Dqy9ogquMK+Fsmvl0xsyGRl
         DTh8U6gDpnxVPPr2JkXU+RKNp6GqzIPkplvB+ZAaMewypkWO9WY435Y25ruizteW4lQ4
         f/KHwFaULevfiz13y5A4KugAKCRSWJh94w20R60Dlcu9+ieRkVc4J4yT8IYFNsbAzj4M
         wCmNMCyol7n+SxI7zHZXdaQ1f1Gq/D1CmD0cY3jnKXRBwF/MFqIgYySrNZM94NZ2VQrZ
         tRvhgvyNmL6OzTtEBuyMGx6GsK9Qrw16JMTKdVUc0yzFAbnlp36GnGCJS8UHAIOHUbBD
         IQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694120944; x=1694725744;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=22+VoOjuMAdph8IrYWRiY4zsDuiQCgTZzignJ/ClYnM=;
        b=THUDawsKhmZ9NuFMa6ppTEbQhpm3ifFEUh+v4z4pAyKHCRBtCI3KgFubm2B8gHvs0c
         n52H0fvmP+rsvPLFYfFdTSuqu+YD53T2uA1kxlKXUQ7AwolqX7WmDCYKvvyGn2OzCu2e
         nChxQuLLPdIe8Hk3CmmpnLPRgsgiZ3zgBFiBqMpiKwA46CWBk7jy1tcShzgwn5z74yf+
         BAsXh7k/yVS8vhWKLStngFJ2nCidhvZvOICXwZOMYTaNkeor4P4AjBtJnXXiaV5Lq1Fz
         /DdruVdsWXR3sNNqvmKo2fLGp4dtbsMjzdKPkWZ1hkXeAa8O/g5Vc1ybrpGaW2w8xXmR
         GPYw==
X-Gm-Message-State: AOJu0YzFdI921TRebu51J3YPcM5lZSbermqidbw53IrttAa2FNE0lEsz
        jR7SqjNMbDMernTxGzfSkjlwllCUirVkMN6Tb//IJA==
X-Google-Smtp-Source: AGHT+IH0bqp69IwP0nbtOI1C7kMBG9qxqTyXjsHNa5y3rlH3t1fG4i5HYjxHC5R3Uy0w/g95P4um9nBAL5s700Wo8Zs=
X-Received: by 2002:a05:622a:1990:b0:40f:dc70:fde2 with SMTP id
 u16-20020a05622a199000b0040fdc70fde2mr75764qtc.26.1694120943771; Thu, 07 Sep
 2023 14:09:03 -0700 (PDT)
MIME-Version: 1.0
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 7 Sep 2023 14:08:52 -0700
Message-ID: <CAP-5=fXSiO87=tyax4p6uVHRhpWtK4HGPoMCYUEDcJxd+O67zA@mail.gmail.com>
Subject: Perf metrics for ARM64 Raspberry Pi
To:     Jumana MP <jumana.mp@arm.com>, James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

we have common metrics for ARM64:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/arch/arm64/sbsa.json?h=perf-tools-next

but they don't apply on common platforms like raspberry pi 4 as
standard metrics still need a reference from the model metrics to the
standard one like:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json?h=perf-tools-next#n3

In the mapfile.csv a raspberry pi matches cortex-a57-a72 which has no
metrics. I was wondering what it would take to add these metrics?
However, it appears the standard metrics use events that are undefined
at least in json like stall_slot_frontend:
```
$ grep -r stall_slot_frontend tools/perf/pmu-events/arch/arm64/
tools/perf/pmu-events/arch/arm64/sbsa.json:        "MetricExpr": "100
* (stall_slot_frontend / (#slots * cpu_cycles))",
```
as they are coming from sysfs:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/drivers/perf/arm_pmuv3.c?h=perf-tools-next#n233
and are missing on the raspberry pi:
```
$ ls /sys/devices/armv8_cortex_a72/events/
br_mis_pred        cpu_cycles    l1d_cache         l1i_cache_refill  mem_access
br_pred            exc_return    l1d_cache_refill  l1i_tlb_refill
memory_error
bus_access         exc_taken     l1d_cache_wb      l2d_cache         sw_incr
bus_cycles         inst_retired  l1d_tlb_refill    l2d_cache_refill
ttbr_write_retired
cid_write_retired  inst_spec     l1i_cache         l2d_cache_wb
```
Looking at:
https://documentation-service.arm.com/static/60250c7395978b529036da86?token=
It seems some of the metrics like "operations wasted" could be had
even on earlier revision PMUs. Are there any plans in this regard?

Thanks,
Ian
