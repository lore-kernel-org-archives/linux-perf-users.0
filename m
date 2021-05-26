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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90585C2B9F7
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 May 2021 03:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64FD16141C
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 May 2021 03:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhEZDgU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 25 May 2021 23:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbhEZDgU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 25 May 2021 23:36:20 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2765C061574;
        Tue, 25 May 2021 20:34:49 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d20so3148639pls.13;
        Tue, 25 May 2021 20:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FZHL/iuYMdL1Q5Q0lbUGAA5ha/63sGJlTW3uVbXhIq4=;
        b=tfq2h68pOgeyPYi2WwvbC0mr3/nLOzleKcaBo7qeKxKEuBZN2n/sQTO5r3oOoRU77k
         dDa2kjzlCGIffxFyJEZdwK7UzpUZrjUfJLoI0bleP/U8mxh0a4Mt5Kaq+vCiDQQw0t9h
         0mnGlPzUg00mXkxEhZ1vJfB+Q2H9WUuSfs7nJ7dBSIkxc5JR/GdU7PT/Qrwe7cGwevMF
         ofKsd3LHUBTuCZsKkW2nefkiJUXU/g43X439I8Pmdb/lroenbB6XT0uSnjCekQQDzFyN
         KwKguzDqhed43sLjIRvETiE09z8vtI1u+704pasfiipsLCtWXQPf/KheC6zm2+Rb/m/S
         mxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FZHL/iuYMdL1Q5Q0lbUGAA5ha/63sGJlTW3uVbXhIq4=;
        b=W2Z4OxU3KKg3vcqW5kg04+9EADSDX5RT/cKePIasnWXpEPPeQo59qPLdDmPkVgWaZS
         ERf4/jQxw0Oko3Dr6Oim3J8GURdZwRQtzujIW0ni+lOBavpOSvoAuIsW9HTrFRm72k9Z
         wPCApqkK4HItsc+xm54DqX+U/2lw2VmweZhpwvyN9rBPDc5vHHD9FyH04BPWStYAyX8L
         F0aVei2nvK0M5Y0eGgboKSup1UYpGbN6BCHNG9ZoHr3dapwFZCqy2CeN+V5EKx6U0z9F
         Z4an8uHKksNXLFhBk3Dw1oFUPLBvUd2e2tn/QugO7L+I9+0N1J4MtxnmQSlKrQf+oWup
         70cQ==
X-Gm-Message-State: AOAM533uQBRZbI4nl6RZUEw2gI7TIruWJXD+L0riw7hawYqAuHWJtlML
        InEPMxKz82GerbGsG+K28DM=
X-Google-Smtp-Source: ABdhPJwdwhVxgyLfExXCQzf7NQL4v9IKZ9R+zj4UIVGPFLllUB5GlQjhZGM9ArTSJKxfN2acoXJQJA==
X-Received: by 2002:a17:90a:55c5:: with SMTP id o5mr33630682pjm.169.1622000089259;
        Tue, 25 May 2021 20:34:49 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id z19sm13008104pjn.0.2021.05.25.20.34.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 May 2021 20:34:48 -0700 (PDT)
From:   Haocheng Xie <xiehaocheng.cn@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haocheng Xie <xiehaocheng.cn@gmail.com>
Subject: [PATCH] perf core: Fix some kernel-doc warnings.
Date:   Wed, 26 May 2021 11:34:38 +0800
Message-Id: <20210526033438.23640-1-xiehaocheng.cn@gmail.com>
X-Mailer: git-send-email 2.9.5
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Fix the following W=1 kernel build warning(s):
kernel/events/core.c:143: warning: Function parameter or member 'cpu' not described in 'cpu_function_call'
kernel/events/core.c:11924: warning: Function parameter or member 'flags' not described in 'sys_perf_event_open'
kernel/events/core.c:12382: warning: Function parameter or member 'overflow_handler' not described in 'perf_event_create_kernel_counter'
kernel/events/core.c:12382: warning: Function parameter or member 'context' not described in 'perf_event_create_kernel_counter'

Signed-off-by: Haocheng Xie <xiehaocheng.cn@gmail.com>
---
 kernel/events/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0d98d6a..7988e40 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -132,6 +132,7 @@ task_function_call(struct task_struct *p, remote_function_f func, void *info)
 
 /**
  * cpu_function_call - call a function on the cpu
+ * @cpu:	target cpu to queue this function
  * @func:	the function to be called
  * @info:	the function call argument
  *
@@ -11917,6 +11918,7 @@ __perf_event_ctx_lock_double(struct perf_event *group_leader,
  * @pid:		target pid
  * @cpu:		target cpu
  * @group_fd:		group leader event fd
+ * @flags:		perf event open flags
  */
 SYSCALL_DEFINE5(perf_event_open,
 		struct perf_event_attr __user *, attr_uptr,
@@ -12373,6 +12375,8 @@ SYSCALL_DEFINE5(perf_event_open,
  * @attr: attributes of the counter to create
  * @cpu: cpu in which the counter is bound
  * @task: task to profile (NULL for percpu)
+ * @overflow_handler: callback to trigger when we hit the event
+ * @context: context data could be used in overflow_handler callback
  */
 struct perf_event *
 perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
-- 
2.9.5

