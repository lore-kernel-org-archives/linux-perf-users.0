Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4A5C11F65
	for <linux-perf-users@archiver.kernel.org>; Wed, 30 Jun 2021 09:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 267A261CA3
	for <linux-perf-users@archiver.kernel.org>; Wed, 30 Jun 2021 09:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbhF3JkN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 30 Jun 2021 05:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbhF3JkN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 30 Jun 2021 05:40:13 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1604C06175F
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Jun 2021 02:37:43 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id c15-20020a056000184fb0290124a352153cso647686wri.9
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Jun 2021 02:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JhgrCS9Vj640V8x1cFNbO5yNaZtMM+Zz5JPkP+NN88k=;
        b=hOGR+88o6wgh2BS77C9e3IW5lpLeoKlfQpOyo0vBRi0/nOkMjDwyqlhB1sCe+OArkh
         9qxed+lEX/yr9DODAh2C+/67NHa38Ru3QIfEuTWy+N0mZPdR3yc9FmtU7HR5TSYrw4XR
         Pnbphx2nxpTq0y3aE6Xf1wIJNFBrQor8dRtXxpwz+UWHJbubCIMHVOdhrDBe7YaQ9KF1
         N4zqbDnQD4evL1iqNYm8CkXIeoIU8aKeMUq622KMpnRNff716iQW6ahiSRDH2jjddvWf
         dHcLiyQq9vn9oEC7xE6//J8vX3Onwt2Syz6i/JKPiGuxKlfK/BuNH3TSq8mNnz0JrMNR
         /Kmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JhgrCS9Vj640V8x1cFNbO5yNaZtMM+Zz5JPkP+NN88k=;
        b=Z8+YJqAKmaWuoNpdxdmis8cM54CQ+fqTsrqun3WrAGT3Y43y1qbM9lbpRYinOvf114
         tN59O6J/eM8lOIfd7wRpS88w29JorwIPnNag03GvtyC9Rc/p9pnHLXvzJCdbkATRTr/2
         vNdxQO3CPaqWDqTOUVftif6EcJae2PmmSkLqqOrAZo8U6Wk0q3E7iDOq0vqIUhi/gAUz
         xkUcoaoiFYJvgiG+8lVr6FqwMDun1YA8leebqsqWIo63DqyuT7uTT8RSlZnzm+H1+R3K
         vexr/9LDRJ8PXw3zeRKKfjE0nszTBiyHLDxJVl2Rs9xLZw5RyOm+t5PBl405g++iMnI6
         SZiQ==
X-Gm-Message-State: AOAM5334/XvauhdwrrUqGJufxigs3SeBABLH3X9mkW5tGbXt6jSJAUXM
        tqTAY4yG2UQ+bZ8uCgOPi4MCtjYOkw==
X-Google-Smtp-Source: ABdhPJy8vek+rU0qtXlFDtYJdt3+PNfx3+B41Bo8Y+sjctSSWlzprffXwO4wD8JBVvpgXgYl9+b5QOromw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:d0e2:84e5:6f2a:9752])
 (user=elver job=sendgmr) by 2002:a1c:e486:: with SMTP id b128mr3501221wmh.58.1625045861994;
 Wed, 30 Jun 2021 02:37:41 -0700 (PDT)
Date:   Wed, 30 Jun 2021 11:37:09 +0200
Message-Id: <20210630093709.3612997-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH] perf: Require CAP_KILL if sigtrap is requested
From:   Marco Elver <elver@google.com>
To:     elver@google.com, peterz@infradead.org
Cc:     tglx@linutronix.de, mingo@kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, serge@hallyn.com, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-security-module@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If perf_event_open() is called with another task as target and
perf_event_attr::sigtrap is set, and the target task's user does not
match the calling user, also require the CAP_KILL capability.

Otherwise, with the CAP_PERFMON capability alone it would be possible
for a user to send SIGTRAP signals via perf events to another user's
tasks. This could potentially result in those tasks being terminated if
they cannot handle SIGTRAP signals.

Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/capability.h |  5 +++++
 kernel/events/core.c       | 13 ++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 65efb74c3585..1c6be4743dbe 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -264,6 +264,11 @@ static inline bool bpf_capable(void)
 	return capable(CAP_BPF) || capable(CAP_SYS_ADMIN);
 }
 
+static inline bool kill_capable(void)
+{
+	return capable(CAP_KILL) || capable(CAP_SYS_ADMIN);
+}
+
 static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
 {
 	return ns_capable(ns, CAP_CHECKPOINT_RESTORE) ||
diff --git a/kernel/events/core.c b/kernel/events/core.c
index fe88d6eea3c2..1ab4bc867531 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12152,10 +12152,21 @@ SYSCALL_DEFINE5(perf_event_open,
 	}
 
 	if (task) {
+		bool is_capable;
+
 		err = down_read_interruptible(&task->signal->exec_update_lock);
 		if (err)
 			goto err_file;
 
+		is_capable = perfmon_capable();
+		if (attr.sigtrap) {
+			/*
+			 * perf_event_attr::sigtrap sends signals to the other
+			 * task. Require the current task to have CAP_KILL.
+			 */
+			is_capable &= kill_capable();
+		}
+
 		/*
 		 * Preserve ptrace permission check for backwards compatibility.
 		 *
@@ -12165,7 +12176,7 @@ SYSCALL_DEFINE5(perf_event_open,
 		 * perf_event_exit_task() that could imply).
 		 */
 		err = -EACCES;
-		if (!perfmon_capable() && !ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
+		if (!is_capable && !ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
 			goto err_cred;
 	}
 
-- 
2.32.0.93.g670b81a890-goog

