Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8037C432BE
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 04:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDC426101E
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 04:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhHIEdk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 00:33:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60830 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbhHIEdh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Aug 2021 00:33:37 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 15BDB1FD84;
        Mon,  9 Aug 2021 04:33:17 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E2D713398;
        Mon,  9 Aug 2021 04:33:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +O30BguwEGEfDQAAMHmgww
        (envelope-from <dave@stgolabs.net>); Mon, 09 Aug 2021 04:33:15 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     acme@kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 3/7] perf/bench-futex: Factor out futex_flag
Date:   Sun,  8 Aug 2021 21:32:57 -0700
Message-Id: <20210809043301.66002-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210809043301.66002-1-dave@stgolabs.net>
References: <20210809043301.66002-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This is common across all tests, move it into futex.h.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 tools/perf/bench/futex-hash.c          | 1 -
 tools/perf/bench/futex-lock-pi.c       | 1 -
 tools/perf/bench/futex-requeue.c       | 1 -
 tools/perf/bench/futex-wake-parallel.c | 1 -
 tools/perf/bench/futex-wake.c          | 1 -
 tools/perf/bench/futex.h               | 3 +++
 6 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index ddca7558e559..b71a34204b79 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -30,7 +30,6 @@
 #include <err.h>
 
 static bool done = false;
-static int futex_flag = 0;
 
 struct timeval bench__start, bench__end, bench__runtime;
 static pthread_mutex_t thread_lock;
diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
index ce980df23bb0..bc208edf3de3 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -32,7 +32,6 @@ struct worker {
 static u_int32_t global_futex = 0;
 static struct worker *worker;
 static bool done = false;
-static int futex_flag = 0;
 static pthread_mutex_t thread_lock;
 static unsigned int threads_starting;
 static struct stats throughput_stats;
diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
index 66747bfe22cf..4001312122be 100644
--- a/tools/perf/bench/futex-requeue.c
+++ b/tools/perf/bench/futex-requeue.c
@@ -36,7 +36,6 @@ static pthread_mutex_t thread_lock;
 static pthread_cond_t thread_parent, thread_worker;
 static struct stats requeuetime_stats, requeued_stats;
 static unsigned int threads_starting;
-static int futex_flag = 0;
 
 static struct bench_futex_parameters params = {
 	/*
diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
index 958372ad159c..ea4fdea6e2f3 100644
--- a/tools/perf/bench/futex-wake-parallel.c
+++ b/tools/perf/bench/futex-wake-parallel.c
@@ -53,7 +53,6 @@ static pthread_cond_t thread_parent, thread_worker;
 static pthread_barrier_t barrier;
 static struct stats waketime_stats, wakeup_stats;
 static unsigned int threads_starting;
-static int futex_flag = 0;
 
 static struct bench_futex_parameters params;
 
diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
index 9ed4d65416f3..1cf651c8ee5c 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -37,7 +37,6 @@ static pthread_mutex_t thread_lock;
 static pthread_cond_t thread_parent, thread_worker;
 static struct stats waketime_stats, wakeup_stats;
 static unsigned int threads_starting;
-static int futex_flag = 0;
 
 static struct bench_futex_parameters params = {
 	/*
diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index 6f8b85b67348..f7cd22bbd677 100644
--- a/tools/perf/bench/futex.h
+++ b/tools/perf/bench/futex.h
@@ -13,6 +13,9 @@
 #include <sys/types.h>
 #include <linux/futex.h>
 
+/* FUTEX_PRIVATE_FLAG or zero */
+static int futex_flag = 0;
+
 struct bench_futex_parameters {
 	bool silent;
 	bool fshared;
-- 
2.26.2

