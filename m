Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314BDC432BE
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 04:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17BDC6101D
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 04:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhHIEdm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 00:33:42 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60850 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbhHIEdk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Aug 2021 00:33:40 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6D63D1FD85;
        Mon,  9 Aug 2021 04:33:19 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7354413398;
        Mon,  9 Aug 2021 04:33:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iPUtDg2wEGEfDQAAMHmgww
        (envelope-from <dave@stgolabs.net>); Mon, 09 Aug 2021 04:33:17 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     acme@kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 4/7] perf/bench-futex: Add --mlockall parameter
Date:   Sun,  8 Aug 2021 21:32:58 -0700
Message-Id: <20210809043301.66002-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210809043301.66002-1-dave@stgolabs.net>
References: <20210809043301.66002-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This adds, across all futex benchmarks, the -m/--mlockall option
which is a common operation for realtime workloads by not incurring
in page faults in paths that want determinism. As such, threads
started after a call to mlockall(2) will generate page faults
immediately since the new stack is immediately forced to memory,
due to the MCL_FUTURE flag.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 tools/perf/bench/futex-hash.c          | 7 +++++++
 tools/perf/bench/futex-lock-pi.c       | 7 +++++++
 tools/perf/bench/futex-requeue.c       | 7 +++++++
 tools/perf/bench/futex-wake-parallel.c | 8 ++++++++
 tools/perf/bench/futex-wake.c          | 8 ++++++++
 tools/perf/bench/futex.h               | 1 +
 6 files changed, 38 insertions(+)

diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index b71a34204b79..af9fbb409472 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
 #include <sys/time.h>
+#include <sys/mman.h>
 #include <perf/cpumap.h>
 
 #include "../util/stat.h"
@@ -55,6 +56,7 @@ static const struct option options[] = {
 	OPT_UINTEGER('f', "futexes", &params.nfutexes, "Specify amount of futexes per threads"),
 	OPT_BOOLEAN( 's', "silent",  &params.silent, "Silent mode: do not display data/details"),
 	OPT_BOOLEAN( 'S', "shared",  &params.fshared, "Use shared futexes instead of private ones"),
+	OPT_BOOLEAN( 'm', "mlockall", &params.mlockall, "Lock all current and future memory"),
 	OPT_END()
 };
 
@@ -141,6 +143,11 @@ int bench_futex_hash(int argc, const char **argv)
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
index bc208edf3de3..d2927d2eb3f7 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -21,6 +21,7 @@
 #include <err.h>
 #include <stdlib.h>
 #include <sys/time.h>
+#include <sys/mman.h>
 
 struct worker {
 	int tid;
@@ -47,6 +48,7 @@ static const struct option options[] = {
 	OPT_BOOLEAN( 'M', "multi",   &params.multi, "Use multiple futexes"),
 	OPT_BOOLEAN( 's', "silent",  &params.silent, "Silent mode: do not display data/details"),
 	OPT_BOOLEAN( 'S', "shared",  &params.fshared, "Use shared futexes instead of private ones"),
+	OPT_BOOLEAN( 'm', "mlockall", &params.mlockall, "Lock all current and future memory"),
 	OPT_END()
 };
 
@@ -164,6 +166,11 @@ int bench_futex_lock_pi(int argc, const char **argv)
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
index 4001312122be..88cb7e2a6729 100644
--- a/tools/perf/bench/futex-requeue.c
+++ b/tools/perf/bench/futex-requeue.c
@@ -27,6 +27,7 @@
 #include <err.h>
 #include <stdlib.h>
 #include <sys/time.h>
+#include <sys/mman.h>
 
 static u_int32_t futex1 = 0, futex2 = 0;
 
@@ -50,6 +51,7 @@ static const struct option options[] = {
 	OPT_UINTEGER('q', "nrequeue", &params.nrequeue, "Specify amount of threads to requeue at once"),
 	OPT_BOOLEAN( 's', "silent",   &params.silent, "Silent mode: do not display data/details"),
 	OPT_BOOLEAN( 'S', "shared",   &params.fshared, "Use shared futexes instead of private ones"),
+	OPT_BOOLEAN( 'm', "mlockall", &params.mlockall, "Lock all current and future memory"),
 	OPT_END()
 };
 
@@ -133,6 +135,11 @@ int bench_futex_requeue(int argc, const char **argv)
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
index ea4fdea6e2f3..ef1f8237fd81 100644
--- a/tools/perf/bench/futex-wake-parallel.c
+++ b/tools/perf/bench/futex-wake-parallel.c
@@ -34,6 +34,7 @@ int bench_futex_wake_parallel(int argc __maybe_unused, const char **argv __maybe
 #include <err.h>
 #include <stdlib.h>
 #include <sys/time.h>
+#include <sys/mman.h>
 
 struct thread_data {
 	pthread_t worker;
@@ -61,6 +62,8 @@ static const struct option options[] = {
 	OPT_UINTEGER('w', "nwakers", &params.nwakes, "Specify amount of waking threads"),
 	OPT_BOOLEAN( 's', "silent",  &params.silent, "Silent mode: do not display data/details"),
 	OPT_BOOLEAN( 'S', "shared",  &params.fshared, "Use shared futexes instead of private ones"),
+	OPT_BOOLEAN( 'm', "mlockall", &params.mlockall, "Lock all current and future memory"),
+
 	OPT_END()
 };
 
@@ -238,6 +241,11 @@ int bench_futex_wake_parallel(int argc, const char **argv)
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
index 1cf651c8ee5c..40e492c7996a 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -27,6 +27,7 @@
 #include <err.h>
 #include <stdlib.h>
 #include <sys/time.h>
+#include <sys/mman.h>
 
 /* all threads will block on the same futex */
 static u_int32_t futex1 = 0;
@@ -51,6 +52,8 @@ static const struct option options[] = {
 	OPT_UINTEGER('w', "nwakes",  &params.nwakes, "Specify amount of threads to wake at once"),
 	OPT_BOOLEAN( 's', "silent",  &params.silent, "Silent mode: do not display data/details"),
 	OPT_BOOLEAN( 'S', "shared",  &params.fshared, "Use shared futexes instead of private ones"),
+	OPT_BOOLEAN( 'm', "mlockall", &params.mlockall, "Lock all current and future memory"),
+
 	OPT_END()
 };
 
@@ -141,6 +144,11 @@ int bench_futex_wake(int argc, const char **argv)
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
 
+	if (params.mlockall) {
+		if (mlockall(MCL_CURRENT | MCL_FUTURE))
+			err(EXIT_FAILURE, "mlockall");
+	}
+
 	if (!params.nthreads)
 		params.nthreads = cpu->nr;
 
diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index f7cd22bbd677..1c8fa469993f 100644
--- a/tools/perf/bench/futex.h
+++ b/tools/perf/bench/futex.h
@@ -19,6 +19,7 @@ static int futex_flag = 0;
 struct bench_futex_parameters {
 	bool silent;
 	bool fshared;
+	bool mlockall;
 	bool multi; /* lock-pi */
 	unsigned int runtime; /* seconds*/
 	unsigned int nthreads;
-- 
2.26.2

