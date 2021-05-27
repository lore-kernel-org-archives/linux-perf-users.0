Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062ACC47089
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 May 2021 03:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0F60613B9
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 May 2021 03:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbhE0DVq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 May 2021 23:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbhE0DVp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 May 2021 23:21:45 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02D4C061574;
        Wed, 26 May 2021 20:20:11 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id q6so1940813pjj.2;
        Wed, 26 May 2021 20:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=R7HKUgolZlXbPFqSrogXo/GPxcpvCMNR1c+E1WFALmk=;
        b=VIOsnDpr1Zu1Jz55aBnwNdIgDcB4U2CpVLJPQdsXR4mEP8PEnVzaQ2txOcggmJrRLT
         1yOhPvX7YWwoMMOuYzw3D2PFivXN9eeXPZWRUqOjr4p3VjAk3vdH0Gzkh7UZf7BiVrTf
         8n7R2adMnnHPNymgk5uWOlGWgnffDNiEhldkZ9F8Wx3JQ8Ehwu9I40ox/mVibS48KTLO
         hKTzVwyJUMXsy0n8ZBHDlpytuyakQn0Li2HeIQ7akN1NkFGUQsYFpokyuL5kVBO3eHpx
         PJcgtryC72ul5aBzcGAgrC2Q2GC1k7s6k3/Ehtl/PROunnbqdXg44GCuh9ruWBBwsyTp
         EiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=R7HKUgolZlXbPFqSrogXo/GPxcpvCMNR1c+E1WFALmk=;
        b=dAPKfUi+6yymUFel1CuUlVRrbb48AKJ3yEwmfOmix4O8tG6LugJzQa4yB4To3HlYOi
         g8FxzVzIu+BXS7v3e8uCBV/fpWt0Qu4oCXsc52EgtPdhZmrNWKqHHY03FrImscRDsy1i
         JKBDz4AouQV0AOD33EQn4m0zmP4pXI5fFF7EosZ3mqU6yojiREtq/K4sgktEeNge9gtt
         sYHReAw3esr1Z3uWogU1fRDGgEwIbxKZwgU1CGLjsU+9gd1/AzWet8iWT1yGSMq0dk2a
         SnengbSJYhyUdzTHC1tyduaAeAfNpjiq3xkEAP6jREhCxJ1MSiJEP/71CkMV3I36Wle4
         /TAg==
X-Gm-Message-State: AOAM533PWxKZJ9WMmATrl/6p2nEHV4606/d0livrTuquPUUbgSNTPS07
        FyhL1CxiDVgGVijTZtEj8MA=
X-Google-Smtp-Source: ABdhPJxbz5+mVf8/WlwEPTlkYsyIDPjxNAnfqWeLBsfaA3pT0Jeae0Oef1kCcCs9Lu2x7TFFC59u6w==
X-Received: by 2002:a17:90b:4d85:: with SMTP id oj5mr7236447pjb.178.1622085611138;
        Wed, 26 May 2021 20:20:11 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id l6sm554716pjf.28.2021.05.26.20.20.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 20:20:10 -0700 (PDT)
From:   Haocheng Xie <xiehaocheng.cn@gmail.com>
To:     mingo@kernel.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Haocheng Xie <xiehaocheng.cn@gmail.com>
Subject: [PATCH v2 0/3] perf/events: Fix some build warnings in perf/events subsystem.
Date:   Thu, 27 May 2021 11:19:44 +0800
Message-Id: <20210527031947.1801-1-xiehaocheng.cn@gmail.com>
X-Mailer: git-send-email 2.9.5
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

I have got these warnings when building kernel with  'W=1' options:

  kernel/events/core.c:6670:6: warning: no previous prototype for 'perf_pmu_snapshot_aux' [-Wmissing-prototypes]
  kernel/events/core.c:143: warning: Function parameter or member 'cpu' not described in 'cpu_function_call'
  kernel/events/core.c:11924: warning: Function parameter or member 'flags' not described in 'sys_perf_event_open'
  kernel/events/core.c:12382: warning: Function parameter or member 'overflow_handler' not described in 'perf_event_create_kernel_counter'
  kernel/events/core.c:12382: warning: Function parameter or member 'context' not described in 'perf_event_create_kernel_counter'
  kernel/events/hw_breakpoint.c:461: warning: Function parameter or member 'context' not described in 'register_user_hw_breakpoint'
  kernel/events/hw_breakpoint.c:560: warning: Function parameter or member 'context' not described in 'register_wide_hw_breakpoint'

The 3-patch series will fix these warnings.

Changes from v1:
  - optimize the commit message format.
  - remove superfluous whitespace in the subject.
  - align the arguments of modified function.

Haocheng Xie (3):
  perf core: Make local function perf_pmu_snapshot_aux() static
  perf core: Fix some kernel-doc warnings.
  perf/hw_breakpoint: Fix kernel-doc warnings in perf hw_breakpoint

 kernel/events/core.c          | 12 ++++++++----
 kernel/events/hw_breakpoint.c |  2 ++
 2 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.9.5

