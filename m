Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05046C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Mar 2022 10:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbiCVKnn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Mar 2022 06:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiCVKnl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Mar 2022 06:43:41 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBE281186
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Mar 2022 03:42:13 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o7-20020a05600c4fc700b0038c87edc21eso1395853wmq.0
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Mar 2022 03:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=vCQ8yvQZrq5DlVAWjFgARpvOjjNUPnfe4PnTinAQEg4=;
        b=OSq+o0I6V4hvpejOocVKh4QvbV7PukShyPEtAAfowSaUdbtPIE+DDmHXFr9MCKbCID
         f5swJriUB6SJnYMOOr9x7ilJzNHzbxkd7yoOeYPR5uI5ADkpAGWnchmWj6ozM63VjDux
         CP1f3oaPfFN6FA+gjOQf6pPb3WAic3QoS3H3mujxo+Q+GHDJP+nVM0iGwCfBwELdt7It
         K1c5j2f/PHj35YntxQBS+Z/C29OzupM5g33K7BTG6/w5NgFkZWddLKlCNgyAd36AjknK
         vXfAJaTZLyUkLeqZi/2waAqALHoPQsOflDauHnpN8I3K9uMMbHy/FNUWO1d1rMKI803k
         TBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vCQ8yvQZrq5DlVAWjFgARpvOjjNUPnfe4PnTinAQEg4=;
        b=GVOb2OQYRqifs+qQ9WlidlNNXP1L5qgz3r4paUO5/GmGzb43SZbHA1e9+7PiAeBD6D
         d4woganh/wyTmWNrJLSlJSAe09fCJMiWVWWLRZyPNGFkY+R4KwWOxCO/5gs08fL59Sti
         Ef4htBCfQJ0L0753RL7xid5yePcRQpK4TGOYsNP7VFDw034GowP2GA5h3iJng0xUibXA
         UYcZlv6sO+kqD3S3bOYqEf0QVstg6pCrsfDcaOR0JcpDAI0poAKkWsHLHQDm4kgeLPh/
         FrDEUsBCTI0Jlw6T3IR+MWSbPJfJO/SN2KgQi8l2/mZ8dEqT41Qhfkl61oS+ePrhfaXm
         NaQQ==
X-Gm-Message-State: AOAM532IqG84Cr/rp3h1yKJON99zrcSBQRBKy8o+xSeqvckvsisLYMto
        y+a6N5VkVOV0tOfhUfC5RwWGUw==
X-Google-Smtp-Source: ABdhPJzBs9zqbxV4VovtzRunQCoQQapJqNzsmcJBCU0RZJ/hPmh0128AGwMJWw+sRlqnT96Om2IoMQ==
X-Received: by 2002:a5d:5504:0:b0:203:e3be:518b with SMTP id b4-20020a5d5504000000b00203e3be518bmr21741803wrv.462.1647945732046;
        Tue, 22 Mar 2022 03:42:12 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:3aa9:ba1f:ba59:87ba])
        by smtp.gmail.com with ESMTPSA id q14-20020a1cf30e000000b0038986a18ec8sm1584774wmq.46.2022.03.22.03.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 03:42:11 -0700 (PDT)
Date:   Tue, 22 Mar 2022 11:42:06 +0100
From:   Marco Elver <elver@google.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: RFC: Use of user space handler vs. SIG_DFL on forced signals
Message-ID: <Yjmn/kVblV3TdoAq@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,

Currently force_sig_info_to_task() will always unblock a blocked signal
but deliver the signal to SIG_DFL:

	[...]
	 * Note: If we unblock the signal, we always reset it to SIG_DFL,
	 * since we do not want to have a signal handler that was blocked
	 * be invoked when user space had explicitly blocked it.
	[...]

Is this requirement part of the POSIX spec? Or is the intent simply to
attempt to do the least-bad thing?

The reason I'm asking is that we've encountered rare crashes with the
new SIGTRAP on perf events, due to patterns like this:

	<set up SIGTRAP on a perf event>
	...
	sigset_t s;
	sigemptyset(&s);
	sigaddset(&s, SIGTRAP | <and others>);
	sigprocmask(SIG_BLOCK, &s, ...);
	...
	<perf event triggers>

When the perf event triggers, while SIGTRAP is blocked, force_sig_perf()
will force the signal, but revert back to the default handler, thus
terminating the task.

For other types of signals, is the assumption here that if user space
blocked the signal, it might not be able to handle it in the first
place?

For SIGTRAP on perf events we found this makes the situation worse,
since the cause of the signal wasn't an error condition, but explicitly
requested monitoring. In this case, we do in fact want delivery of the
signal to user space even if the signal is blocked, i.e.
force_sig_perf() should be an unblockable forced synchronous signal to
user space!

If there is no good reason to choose SIG_DFL, our preference would be to
allow this kind of "unblockable forced" signal to the user space handler
for force_sig_perf() -- with the caveat whoever requests SIGTRAP on perf
events must be able to provide a handler that can always run safely. But
we think that's better than crashing.

The below patch would do what we want, but would like to first confirm
if this is "within spec".

Thoughts?

Thanks,
-- Marco

------ >8 ------

From: Marco Elver <elver@google.com>
Date: Mon, 21 Mar 2022 22:18:09 +0100
Subject: [PATCH RFC] signal: Always unblock signal to user space for
 force_sig_perf()

With SIGTRAP on perf events, we have encountered termination of
processes due to user space attempting to block delivery of SIGTRAP.
Consider this case:

	<set up SIGTRAP on a perf event>
	...
	sigset_t s;
	sigemptyset(&s);
	sigaddset(&s, SIGTRAP | <and others>);
	sigprocmask(SIG_BLOCK, &s, ...);
	...
	<perf event triggers>

When the perf event triggers, while SIGTRAP is blocked, force_sig_perf()
will force the signal, but revert back to the default handler, thus
terminating the task.

With forced signals, the whole premise of sigprocmask() is invalidated
since the signal is still delivered, only to the default signal handler.
The assumption here is that if user space blocked the signal, it might
not be able to handle it in the first place.

However, for SIGTRAP on perf events we found this makes the situation
worse, since the cause of the signal wasn't an error condition, but
explicitly requested monitoring. In this case, we do in fact want
delivery of the signal to user space even if the signal is blocked, i.e.
force_sig_perf() should be an unblockable forced synchronous signal to
user space.

Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/signal.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 38602738866e..04b7a178a5f3 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1303,6 +1303,7 @@ int do_send_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *p
 
 enum sig_handler {
 	HANDLER_CURRENT, /* If reachable use the current handler */
+	HANDLER_UNBLOCK, /* Use the current handler even if blocked */
 	HANDLER_SIG_DFL, /* Always use SIG_DFL handler semantics */
 	HANDLER_EXIT,	 /* Only visible as the process exit code */
 };
@@ -1311,9 +1312,11 @@ enum sig_handler {
  * Force a signal that the process can't ignore: if necessary
  * we unblock the signal and change any SIG_IGN to SIG_DFL.
  *
- * Note: If we unblock the signal, we always reset it to SIG_DFL,
- * since we do not want to have a signal handler that was blocked
- * be invoked when user space had explicitly blocked it.
+ * Note: If we unblock the signal and handler != HANDLER_UNBLOCK, we always
+ * reset it to SIG_DFL, since we do not want to have a signal handler that was
+ * blocked be invoked when user space had explicitly blocked it. If handler is
+ * HANDLER_UNBLOCK, user space will always receive the signal and is expected to
+ * provide a handler that is safe in all contexts.
  *
  * We don't want to have recursive SIGSEGV's etc, for example,
  * that is why we also clear SIGNAL_UNKILLABLE.
@@ -1332,7 +1335,8 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t,
 	ignored = action->sa.sa_handler == SIG_IGN;
 	blocked = sigismember(&t->blocked, sig);
 	if (blocked || ignored || (handler != HANDLER_CURRENT)) {
-		action->sa.sa_handler = SIG_DFL;
+		if (handler != HANDLER_UNBLOCK)
+			action->sa.sa_handler = SIG_DFL;
 		if (handler == HANDLER_EXIT)
 			action->sa.sa_flags |= SA_IMMUTABLE;
 		if (blocked) {
@@ -1816,7 +1820,11 @@ int force_sig_perf(void __user *addr, u32 type, u64 sig_data)
 	info.si_perf_data = sig_data;
 	info.si_perf_type = type;
 
-	return force_sig_info(&info);
+	/*
+	 * Delivering SIGTRAP on perf events must unblock delivery to not
+	 * kill the task, but attempt delivery to the user space handler.
+	 */
+	return force_sig_info_to_task(&info, current, HANDLER_UNBLOCK);
 }
 
 /**
-- 
2.35.1.894.gb6a874cedc-goog

