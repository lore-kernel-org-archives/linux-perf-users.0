Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.7 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782C5C07E99
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Jul 2021 08:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BF68613C9
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Jul 2021 08:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhGEIrn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 5 Jul 2021 04:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhGEIrm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 5 Jul 2021 04:47:42 -0400
Received: from mail-lj1-x24a.google.com (mail-lj1-x24a.google.com [IPv6:2a00:1450:4864:20::24a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E44C061760
        for <linux-perf-users@vger.kernel.org>; Mon,  5 Jul 2021 01:45:06 -0700 (PDT)
Received: by mail-lj1-x24a.google.com with SMTP id 70-20020a2e09490000b02901827163ceefso1496022ljj.18
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Jul 2021 01:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=XT1F6bsaZFgcmmxxyjZZuJTZD371QBzAaF2qKad4ZRA=;
        b=vN2Y2GrXM9wFYnK8wro/zQ6xDDmrrViyrbnBQ/4RMgPlUiGyKcoYBPaG1wATVX1mUc
         HLLbWWydLEqq+/RJ8CvpnNaii17d0JfOUVy3Mc9JbwsqeWqH7aKWjt7xHWqLYzdP6USq
         myjSXPGUDxoAoC8er0ihCXFL4B1umZj8KSlEd2WQOO/OF3SD6fsbJlMNS+levqcWDZtE
         P717hU7sFwpkOAu26fqpZOF5y9tekPitlEOa4PDHMpZcjdYNS0otmoJBrj16WB4XXwx7
         yHqFBHAIswo7fFD3lYb5dIXaxP2ZnUxMyfYPPD+auIZzPgWS5+50kXLs82lARyxwGE1o
         8LOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=XT1F6bsaZFgcmmxxyjZZuJTZD371QBzAaF2qKad4ZRA=;
        b=RniTORGmk2g1PZfcFMlRv/fc+ofiKFjC/P/hOTy8x0xquXCvYVTIXlxNEdDab3Z/a6
         8oKHHSGAb3r7VRaa9aRBBRxPEd+bsop9/eUUy7GvvBb84hL7zZ1or1rVb04IbIlCV1hE
         s+e5HBZzCZf53mK4JGPcc7+OCWC4IvKT3LFq1VsHvr9F2P/JCYjNmZ5wYTFiks6E95s8
         1+psP0PiW382kGuhXCrkitLKAaqyFuTyGOL7yqC6tgpsoxQnKrp/RipCyxQTR3uuNBSK
         K+2ps26nTQdkEoGJjijdi2cNg81mxpKlDCAFP0NsSkcL9N9cDmPc3WHS4sI53L3zyQwj
         6iqg==
X-Gm-Message-State: AOAM531Hii474nzuJt+ByyYyS8sLHXjJBvUMMXZKLJ5OnPL7YbV2vhXj
        z/Z2xmOyRStSSw4bI9gRiVwJg32jfg==
X-Google-Smtp-Source: ABdhPJwJJ8IYO0yfnhbmAMrM9usbbtUz3OfJO2G4Ka8fzvRpGpNhtc7thfb1yiXSp6CO0GpfORq4d5EOjA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:dddd:647c:7745:e5f7])
 (user=elver job=sendgmr) by 2002:a19:6d01:: with SMTP id i1mr10104024lfc.422.1625474704103;
 Mon, 05 Jul 2021 01:45:04 -0700 (PDT)
Date:   Mon,  5 Jul 2021 10:44:52 +0200
Message-Id: <20210705084453.2151729-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v3 1/2] perf: Fix required permissions if sigtrap is requested
From:   Marco Elver <elver@google.com>
To:     elver@google.com, peterz@infradead.org
Cc:     tglx@linutronix.de, mingo@kernel.org, dvyukov@google.com,
        glider@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, ebiederm@xmission.com,
        omosnace@redhat.com, serge@hallyn.com,
        linux-security-module@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If perf_event_open() is called with another task as target and
perf_event_attr::sigtrap is set, and the target task's user does not
match the calling user, also require the CAP_KILL capability or
PTRACE_MODE_ATTACH permissions.

Otherwise, with the CAP_PERFMON capability alone it would be possible
for a user to send SIGTRAP signals via perf events to another user's
tasks. This could potentially result in those tasks being terminated if
they cannot handle SIGTRAP signals.

Note: The check complements the existing capability check, but is not
supposed to supersede the ptrace_may_access() check. At a high level we
now have:

	capable of CAP_PERFMON and (CAP_KILL if sigtrap)
		OR
	ptrace_may_access(...) // also checks for same thread-group and uid

Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
Cc: <stable@vger.kernel.org> # 5.13+
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Marco Elver <elver@google.com>
---
v3:
* Upgrade ptrace mode check to ATTACH if attr.sigtrap, otherwise it's
  possible to change the target task (send signal) even if only read
  ptrace permissions were granted (reported by Eric W. Biederman).

v2: https://lkml.kernel.org/r/20210701083842.580466-1-elver@google.com
* Drop kill_capable() and just check CAP_KILL (reported by Ondrej Mosnacek).
* Use ns_capable(__task_cred(task)->user_ns, CAP_KILL) to check for
  capability in target task's ns (reported by Ondrej Mosnacek).

v1: https://lkml.kernel.org/r/20210630093709.3612997-1-elver@google.com
---
 kernel/events/core.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index fe88d6eea3c2..f79ee82e644a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12152,10 +12152,33 @@ SYSCALL_DEFINE5(perf_event_open,
 	}
 
 	if (task) {
+		unsigned int ptrace_mode = PTRACE_MODE_READ_REALCREDS;
+		bool is_capable;
+
 		err = down_read_interruptible(&task->signal->exec_update_lock);
 		if (err)
 			goto err_file;
 
+		is_capable = perfmon_capable();
+		if (attr.sigtrap) {
+			/*
+			 * perf_event_attr::sigtrap sends signals to the other
+			 * task. Require the current task to also have
+			 * CAP_KILL.
+			 */
+			rcu_read_lock();
+			is_capable &= ns_capable(__task_cred(task)->user_ns, CAP_KILL);
+			rcu_read_unlock();
+
+			/*
+			 * If the required capabilities aren't available, checks
+			 * for ptrace permissions: upgrade to ATTACH, since
+			 * sending signals can effectively change the target
+			 * task.
+			 */
+			ptrace_mode = PTRACE_MODE_ATTACH_REALCREDS;
+		}
+
 		/*
 		 * Preserve ptrace permission check for backwards compatibility.
 		 *
@@ -12165,7 +12188,7 @@ SYSCALL_DEFINE5(perf_event_open,
 		 * perf_event_exit_task() that could imply).
 		 */
 		err = -EACCES;
-		if (!perfmon_capable() && !ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
+		if (!is_capable && !ptrace_may_access(task, ptrace_mode))
 			goto err_cred;
 	}
 
-- 
2.32.0.93.g670b81a890-goog

