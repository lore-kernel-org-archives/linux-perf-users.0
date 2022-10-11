Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521E3C433FE
	for <linux-perf-users@archiver.kernel.org>; Tue, 11 Oct 2022 12:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiJKMrX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 11 Oct 2022 08:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiJKMrW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 11 Oct 2022 08:47:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CB9915E5
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Oct 2022 05:47:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e8-20020a5b0cc8000000b006bca0fa3ab6so13305743ybr.0
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Oct 2022 05:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JZgfsSGBJAIpwrM+kN5gILalFFiDKNqq+i+h/f0T+1w=;
        b=Lhj7yGBgLSbssGDsd2KUsMVfq/iXui4imvLqgRv+9ymf7fd0W+VDlTKnh0f+tpRRXB
         /Br17OtlaZyA2gyUxT98PtVyrIAuDpC/pXipYVvOV8y+f8H4vW+MajDUU3phx5GVqniT
         HPzXIHjVgZ7zojUrVGN8Zida1RvUp9HXnw3R3Rm90a+ZGX1tkwsB9j+AqH0+BXbiF72l
         HQEjtC130tULmZYTQtzesNR494kbdH2bqCeNOTyjf3JroTg4WaW38z8ocmG0723+8zRd
         am3phKQ78ruIuH5HZIEE2opGxyuYN7Xbsf+A6j9hntbwWKvWdfuFZxjWS4penwRx6jCJ
         mWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JZgfsSGBJAIpwrM+kN5gILalFFiDKNqq+i+h/f0T+1w=;
        b=H1R0NkyJRtOkL49Vbm/n2lvaQ9hNuug00U1T2K3bnpgn2AUJlVloFvT1M034H6NzNq
         /kepf9mDazFvrmK8XNqp7qP1WsRtqvx/tSyxayUsLBHarxjlfPo8rpb5lkjFs5ahCKWd
         bpmEt68QHmt3lNSfP3nZAdjnDSTAZjLT4MwYvwHmhL4RiWgKZo4/mnKAO8w5Aw9+uoYP
         Mo2d4r2ENcpOzdbZY/hl0yt0nhek5TduL+YZKn5qyMpN1b4+1xlhAtoGY+oQPzukb8BK
         5N1zQ1vTGZO7SMMDGrmPUCIDKqI/7rFy/2Y4rMCS2K4rP9EoqzJDIYCgP3YTcus0NFS2
         3PNw==
X-Gm-Message-State: ACrzQf1wxE9PigbkO9Nj+q29iD4ihh6llhtkcXDXiph7CUfLv/wGFqIy
        zHeVWi8AcstABQdTnXewA5eGERLJ0Q==
X-Google-Smtp-Source: AMsMyM7mLP7qxYhVaFvAfaOOBR4Ia7Pa0IN/qv4FwNg3SacUjhfZkgOXsyXoCAhZIp/qsLi2hi3T37gusQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:3abd:8519:48e1:da82])
 (user=elver job=sendgmr) by 2002:a25:6dc3:0:b0:6c0:7938:5b3f with SMTP id
 i186-20020a256dc3000000b006c079385b3fmr13344582ybc.625.1665492440186; Tue, 11
 Oct 2022 05:47:20 -0700 (PDT)
Date:   Tue, 11 Oct 2022 14:45:35 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221011124534.84907-1-elver@google.com>
Subject: [PATCH] selftests/perf_events: Add a SIGTRAP stress test with disables
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add a SIGTRAP stress test that exercises repeatedly enabling/disabling
an event while it concurrently keeps firing.

Link: https://lore.kernel.org/all/Y0E3uG7jOywn7vy3@elver.google.com/
Signed-off-by: Marco Elver <elver@google.com>
---
 .../selftests/perf_events/sigtrap_threads.c   | 35 +++++++++++++++++--
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/perf_events/sigtrap_threads.c b/tools/testing/selftests/perf_events/sigtrap_threads.c
index 6d849dc2bee0..d1d8483ac628 100644
--- a/tools/testing/selftests/perf_events/sigtrap_threads.c
+++ b/tools/testing/selftests/perf_events/sigtrap_threads.c
@@ -62,6 +62,8 @@ static struct perf_event_attr make_event_attr(bool enabled, volatile void *addr,
 		.remove_on_exec = 1, /* Required by sigtrap. */
 		.sigtrap	= 1, /* Request synchronous SIGTRAP on event. */
 		.sig_data	= TEST_SIG_DATA(addr, id),
+		.exclude_kernel = 1, /* To allow */
+		.exclude_hv     = 1, /* running as !root */
 	};
 	return attr;
 }
@@ -93,9 +95,13 @@ static void *test_thread(void *arg)
 
 	__atomic_fetch_add(&ctx.tids_want_signal, tid, __ATOMIC_RELAXED);
 	iter = ctx.iterate_on; /* read */
-	for (i = 0; i < iter - 1; i++) {
-		__atomic_fetch_add(&ctx.tids_want_signal, tid, __ATOMIC_RELAXED);
-		ctx.iterate_on = iter; /* idempotent write */
+	if (iter >= 0) {
+		for (i = 0; i < iter - 1; i++) {
+			__atomic_fetch_add(&ctx.tids_want_signal, tid, __ATOMIC_RELAXED);
+			ctx.iterate_on = iter; /* idempotent write */
+		}
+	} else {
+		while (ctx.iterate_on);
 	}
 
 	return NULL;
@@ -208,4 +214,27 @@ TEST_F(sigtrap_threads, signal_stress)
 	EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on, 0));
 }
 
+TEST_F(sigtrap_threads, signal_stress_with_disable)
+{
+	const int target_count = NUM_THREADS * 3000;
+	int i;
+
+	ctx.iterate_on = -1;
+
+	EXPECT_EQ(ioctl(self->fd, PERF_EVENT_IOC_ENABLE, 0), 0);
+	pthread_barrier_wait(&self->barrier);
+	while (__atomic_load_n(&ctx.signal_count, __ATOMIC_RELAXED) < target_count) {
+		EXPECT_EQ(ioctl(self->fd, PERF_EVENT_IOC_DISABLE, 0), 0);
+		EXPECT_EQ(ioctl(self->fd, PERF_EVENT_IOC_ENABLE, 0), 0);
+	}
+	ctx.iterate_on = 0;
+	for (i = 0; i < NUM_THREADS; i++)
+		ASSERT_EQ(pthread_join(self->threads[i], NULL), 0);
+	EXPECT_EQ(ioctl(self->fd, PERF_EVENT_IOC_DISABLE, 0), 0);
+
+	EXPECT_EQ(ctx.first_siginfo.si_addr, &ctx.iterate_on);
+	EXPECT_EQ(ctx.first_siginfo.si_perf_type, PERF_TYPE_BREAKPOINT);
+	EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on, 0));
+}
+
 TEST_HARNESS_MAIN
-- 
2.38.0.rc1.362.ged0d419d3c-goog

