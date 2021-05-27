Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F4EC4707F
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 May 2021 03:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65176613D3
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 May 2021 03:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbhE0DVz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 May 2021 23:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbhE0DVy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 May 2021 23:21:54 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675C0C061761;
        Wed, 26 May 2021 20:20:20 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id ne24-20020a17090b3758b029015f2dafecb0so1532619pjb.4;
        Wed, 26 May 2021 20:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jG9XU2eeNR1ehF2kR/N0/vaVpfMY3ZfXw7N9zluBZsA=;
        b=pucBPDNbUbbymkln0VlLUx9Os/UgB/JcuM83p/uikHRap5OiDpCh/3bB5aFU7qtHYp
         9OkFOUN26EkM3tz0EKPJIBrkqOBr23gDUlIE8kKgCgFmwAbetV1Nr858F1CShKql1uuo
         GuRn5ZWQkG6eC0QNnCYGs9Pjwj03xqMXJ3uPGq8sZV2DF/iqTfnm35tV6UPVQWcI/qsd
         Vh6dwXj6FleKq1PLxB8aIPVNpuyn9KDrUH7Qjl9Dl0kUTmu50twEOcQ/2Ao00BPCz0Li
         YzfFrjXKi+J9T1aM3rHYC5znGXZgLBiroBYL4dt+S/2kbxMc3x+nKxHEjXYI7pkbo7tQ
         C7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jG9XU2eeNR1ehF2kR/N0/vaVpfMY3ZfXw7N9zluBZsA=;
        b=akb+591AZTImpqdSVLn8pw+Krxpziw1UbBP2LfPekkMYHmOnzTlmcNUg3lYiLV/2l3
         /WmmBmGHqTI9VSg3ZreyM6hlg9P7u5wPu0iDxv7cZEIOsYRvXLJ8/q+4m+10eXzC7l/a
         03oWKVEQ73fq9JzZ5yEKmdwujLn8wKV9MrHdTITOPNy2xQ5khr38Pqh3XOeEctcmRNz0
         YHNn7SR+wSKlZDiurJ+28CxQxfV64dJ3m7JiDbXcr9yjtVPIbjyk/LXg9tBjXH/Vqs+X
         7fPy4qierpoe998OQyDPmOIhQqhZu5MELyg8fBKxS9fIOBouWTwTefG6pVQN7VdSeIVi
         84/Q==
X-Gm-Message-State: AOAM533oVnqBxkM47YCAnaelZk/2V9WLwjSc1G/y6PUYlCIR+DhyYoni
        kS6zwZsAmjeqxq8ZB7rOurk=
X-Google-Smtp-Source: ABdhPJyMfTroJFgSVZtAn6oWtnH/iUtjmTrB/qnFpH/K667kYelHNO0Z/B9baW5R4egcs9obJW/xRQ==
X-Received: by 2002:a17:90a:aa96:: with SMTP id l22mr7063696pjq.173.1622085620045;
        Wed, 26 May 2021 20:20:20 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id l6sm554716pjf.28.2021.05.26.20.20.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 20:20:19 -0700 (PDT)
From:   Haocheng Xie <xiehaocheng.cn@gmail.com>
To:     mingo@kernel.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Haocheng Xie <xiehaocheng.cn@gmail.com>
Subject: [PATCH v2 3/3] perf/hw_breakpoint: Fix kernel-doc warnings in perf hw_breakpoint
Date:   Thu, 27 May 2021 11:19:47 +0800
Message-Id: <20210527031947.1801-4-xiehaocheng.cn@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210527031947.1801-1-xiehaocheng.cn@gmail.com>
References: <20210527031947.1801-1-xiehaocheng.cn@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Fix the following W=1 kernel build warning(s):

  kernel/events/hw_breakpoint.c:461: warning: Function parameter or member 'context' not described in 'register_user_hw_breakpoint'
  kernel/events/hw_breakpoint.c:560: warning: Function parameter or member 'context' not described in 'register_wide_hw_breakpoint'

Signed-off-by: Haocheng Xie <xiehaocheng.cn@gmail.com>
---
 kernel/events/hw_breakpoint.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index b48d703..8359734 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -451,6 +451,7 @@ int register_perf_hw_breakpoint(struct perf_event *bp)
  * register_user_hw_breakpoint - register a hardware breakpoint for user space
  * @attr: breakpoint attributes
  * @triggered: callback to trigger when we hit the breakpoint
+ * @context: context data could be used in the triggered callback
  * @tsk: pointer to 'task_struct' of the process to which the address belongs
  */
 struct perf_event *
@@ -550,6 +551,7 @@ EXPORT_SYMBOL_GPL(unregister_hw_breakpoint);
  * register_wide_hw_breakpoint - register a wide breakpoint in the kernel
  * @attr: breakpoint attributes
  * @triggered: callback to trigger when we hit the breakpoint
+ * @context: context data could be used in the triggered callback
  *
  * @return a set of per_cpu pointers to perf events
  */
-- 
2.9.5

