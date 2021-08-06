Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92779C4320E
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 01:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79B5E611CA
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 01:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243165AbhHFBdz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 5 Aug 2021 21:33:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50778 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243204AbhHFBdx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 5 Aug 2021 21:33:53 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D88BD223C2;
        Fri,  6 Aug 2021 01:33:37 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3CF1613DD1;
        Fri,  6 Aug 2021 01:33:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yIbaA3CRDGFiBgAAMHmgww
        (envelope-from <dave@stgolabs.net>); Fri, 06 Aug 2021 01:33:36 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 2/3] perf/bench-futex: Add --mlockall parameter
Date:   Thu,  5 Aug 2021 18:33:28 -0700
Message-Id: <20210806013329.94627-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210806013329.94627-1-dave@stgolabs.net>
References: <20210806013329.94627-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This adds, across all futex benchmarks, the -m/--mlockall option
which is a common operation for realtime workloads by not incurring
in page faults in paths that are deterministic. As such, threads
started after a call to mlockall(2) will generate page faults
immediately since the new stack is immediately forced to memory,
due to the MCL_FUTURE flag.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 tools/perf/bench/futex-hash.c          | 9 +++++++++
 tools/perf/bench/futex-lock-pi.c       | 9 +++++++++
 tools/perf/bench/futex-requeue.c       | 9 +++++++++
 tools/perf/bench/futex-wake-parallel.c | 9 +++++++++
 tools/perf/bench/futex-wake.c          | 9 +++++++++
 5 files changed, 45 insertions(+)

diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index 2d86602f89e2..ba8ceff4e098 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
 #include <sys/time.h>
+#include <sys/mman.h>
 #include <perf/cpumap.h>
 
 #include "../util/stat.h"
@@ -51,6 +52,7 @@ struct parameters {
 	unsigned int runtime;
 	bool silent;
 	bool fshared;
+	bool mlockall;
 };
 
 static struct parameters params = {
@@ -69,6 +71,8 @@ static const struct option options[] = {
 		     "Silent mode: do not display data/details"),
 	OPT_BOOLEAN( 'S', "shared",  &params.fshared,
 		     "Use shared futexes instead of private ones"),
+	OPT_BOOLEAN( 'm', "mlockall",  &params.mlockall,
+		     "Lock all current and future memory"),
 	OPT_END()
 };
 
@@ -155,6 +159,11 @@ int bench_futex_hash(int argc, const char **argv)
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
 
+	if (params.mlockall) {
+		if (mlockall(MCL_CURRENT | MCL_FUTURE))
+			err(EXIT_FAILURE, "mlockall");
+	}
+
 	if (!params.nthreads) /* default to the number of CPUs */
 		params.nthreads = cpu->nr;
 
diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
index 9fc994beb933..ab387e73839e 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -21,6 +21,7 @@
 #include <err.h>
 #include <stdlib.h>
 #include <sys/time.h>
+#include <sys/mman.h>
 
 struct worker {
 	int tid;
@@ -44,6 +45,7 @@ struct parameters {
 	bool multi;
 	bool silent;
 	bool fshared;
+	bool mlockall;
 };
 
 static struct parameters params = {
@@ -61,6 +63,8 @@ static const struct option options[] = {
 		     "Params.Silent mode: do not display data/details"),
 	OPT_BOOLEAN( 'S', "shared",  &params.fshared,
 		     "Use shared futexes instead of private ones"),
+	OPT_BOOLEAN( 'm', "mlockall",  &params.mlockall,
+		     "Lock all current and future memory"),
 	OPT_END()
 };
 
@@ -178,6 +182,11 @@ int bench_futex_lock_pi(int argc, const char **argv)
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
 
+	if (params.mlockall) {
+		if (mlockall(MCL_CURRENT | MCL_FUTURE))
+			err(EXIT_FAILURE, "mlockall");
+	}
+
 	if (!params.nthreads)
 		params.nthreads = cpu->nr;
 
diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
index b65761e98245..51f2c0d5e6f8 100644
--- a/tools/perf/bench/futex-requeue.c
+++ b/tools/perf/bench/futex-requeue.c
@@ -27,6 +27,7 @@
 #include <err.h>
 #include <stdlib.h>
 #include <sys/time.h>
+#include <sys/mman.h>
 
 static u_int32_t futex1 = 0, futex2 = 0;
 
@@ -43,6 +44,7 @@ struct parameters {
         unsigned int nrequeue;
 	bool silent;
 	bool fshared;
+	bool mlockall;
 };
 
 static struct parameters params = {
@@ -62,6 +64,8 @@ static const struct option options[] = {
 		     "Silent mode: do not display data/details"),
 	OPT_BOOLEAN( 'S', "shared",   &params.fshared,
 		     "Use shared futexes instead of private ones"),
+	OPT_BOOLEAN( 'm', "mlockall",  &params.mlockall,
+		     "Lock all current and future memory"),
 	OPT_END()
 };
 
@@ -145,6 +149,11 @@ int bench_futex_requeue(int argc, const char **argv)
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
 
+	if (params.mlockall) {
+		if (mlockall(MCL_CURRENT | MCL_FUTURE))
+			err(EXIT_FAILURE, "mlockall");
+	}
+
 	if (!params.nthreads)
 		params.nthreads = cpu->nr;
 
diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
index a80dfff5fe37..d6d71374f535 100644
--- a/tools/perf/bench/futex-wake-parallel.c
+++ b/tools/perf/bench/futex-wake-parallel.c
@@ -34,6 +34,7 @@ int bench_futex_wake_parallel(int argc __maybe_unused, const char **argv __maybe
 #include <err.h>
 #include <stdlib.h>
 #include <sys/time.h>
+#include <sys/mman.h>
 
 struct thread_data {
 	pthread_t worker;
@@ -60,6 +61,7 @@ struct parameters {
 	unsigned int nblocked_threads;
 	bool silent;
 	bool fshared;
+	bool mlockall;
 };
 
 static struct parameters params;
@@ -73,6 +75,8 @@ static const struct option options[] = {
 		     "Silent mode: do not display data/details"),
 	OPT_BOOLEAN( 'S', "shared",  &params.fshared,
 		     "Use shared futexes instead of private ones"),
+	OPT_BOOLEAN( 'm', "mlockall",  &params.mlockall,
+		     "Lock all current and future memory"),
 	OPT_END()
 };
 
@@ -250,6 +254,11 @@ int bench_futex_wake_parallel(int argc, const char **argv)
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
 
+	if (params.mlockall) {
+		if (mlockall(MCL_CURRENT | MCL_FUTURE))
+			err(EXIT_FAILURE, "mlockall");
+	}
+
 	cpu = perf_cpu_map__new(NULL);
 	if (!cpu)
 		err(EXIT_FAILURE, "calloc");
diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
index 22763774ede7..66f1338d66bc 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -27,6 +27,7 @@
 #include <err.h>
 #include <stdlib.h>
 #include <sys/time.h>
+#include <sys/mman.h>
 
 /* all threads will block on the same futex */
 static u_int32_t futex1 = 0;
@@ -44,6 +45,7 @@ struct parameters {
         unsigned int nwakes;
 	bool silent;
 	bool fshared;
+	bool mlockall;
 };
 
 static struct parameters params = {
@@ -63,6 +65,8 @@ static const struct option options[] = {
 		     "Silent mode: do not display data/details"),
 	OPT_BOOLEAN( 'S', "shared",  &params.fshared,
 		     "Use shared futexes instead of private ones"),
+	OPT_BOOLEAN( 'm', "mlockall",  &params.mlockall,
+		     "Lock all current and future memory"),
 	OPT_END()
 };
 
@@ -153,6 +157,11 @@ int bench_futex_wake(int argc, const char **argv)
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
 
+	if (params.mlockall) {
+		if (mlockall(MCL_CURRENT | MCL_FUTURE))
+			err(EXIT_FAILURE, "mlockall");
+	}
+
 	if (!params.nthreads)
 		params.nthreads = cpu->nr;
 
-- 
2.26.2

