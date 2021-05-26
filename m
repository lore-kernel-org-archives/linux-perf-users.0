Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07718C47082
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 May 2021 11:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBEA661360
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 May 2021 11:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhEZL4Y (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 May 2021 07:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbhEZL4M (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 May 2021 07:56:12 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CFFC0612A3;
        Wed, 26 May 2021 04:52:37 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g24so640585pji.4;
        Wed, 26 May 2021 04:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=i729nvpoejgH5we6w7xS3AV1jor9J8GyOV0EJU3jiD4=;
        b=VPWKEccBupTFWslwHxLiFI9gwfqebaQ8M/J1wTkCKuO9P8+WMYg4frl/s3ackUPkMf
         yf5B6E2cAODYsTEyQnEjQl7ks4e1QRgKIFb6mLaibSs4xswmQPQHp3fjL2+o+pJdIGFQ
         lpeco+2Goc4Rbhg/SoRtftMbnQ3qna66ltJ5KNS1/p+scS4c+/xAeYlhErjp5Fq8HMNQ
         U9Niq5swRDi2jz0+SrH2ZFl270OXALO8RJJ+JgGkoogMDeFvo9woRaQMugVIevYlQ1iS
         zZmKtmHUe8jWc+hh50y4+duOaFZ5FOi+XQe2blcYVrJ1gs8vV72s7Mp8JQYyhHJ5pnG3
         C8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i729nvpoejgH5we6w7xS3AV1jor9J8GyOV0EJU3jiD4=;
        b=Ns8Cv/QtMfPXxmjhHXsvTDwSyj+v7GC6WVp8sbpUeJrGIppvMlkFp8pVCgntS3eab2
         cKXwX0vaGS2hGrqithDEY7tnZFIcXIEhA3OsC+60bMYACvSI+qHPIbm2vmhj9xcvhxbH
         F9ItYdE5T6QMCJ9qaOTR83P/5K70yT2BAl+ruk8ej4b0w3K0yHRnQe8VMTs5VyN+mQIW
         aHJ1FzhS+lsPQLjLlucuElmTpcM6FHZzIsHyvKo1mv3PHJfKergi4ZW9lCWSf8pCDu5K
         x1IpIHUh0C9WS/bs5y7KV8UzGiR3OCWq/8qxQIS3gPfJaEg+OMCOCrp6XXkp22CJfdDF
         7qbw==
X-Gm-Message-State: AOAM531SKXboeUdf2NpY3GuAD0aJRqWVz/DP8xi8ayzccGVMfSf7D4q0
        uTEWnLTAlZf4phpkfEblLu4=
X-Google-Smtp-Source: ABdhPJwL8ArjPwktMSW5odm65pZIrmMKwRfAR2UCdSx2qb+FbONaZSQKiBm7ynXoViRjFvST/qHqkw==
X-Received: by 2002:a17:90a:7f85:: with SMTP id m5mr36078482pjl.128.1622029957262;
        Wed, 26 May 2021 04:52:37 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id s48sm15328843pfw.205.2021.05.26.04.52.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 04:52:36 -0700 (PDT)
From:   Haocheng Xie <xiehaocheng.cn@gmail.com>
To:     mingo@kernel.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Haocheng Xie <xiehaocheng.cn@gmail.com>
Subject: [PATCH 0/3] Fix some build warnings in perf/events subsystem.
Date:   Wed, 26 May 2021 19:52:17 +0800
Message-Id: <20210526115220.19134-1-xiehaocheng.cn@gmail.com>
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

Haocheng Xie (3):
  perf core:  Make local function perf_pmu_snapshot_aux() static
  perf core: Fix some kernel-doc warnings.
  perf/hw_breakpoint: Fix kernel-doc warnings in perf hw_breakpoint

 kernel/events/core.c          | 6 +++++-
 kernel/events/hw_breakpoint.c | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.9.5

