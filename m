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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A17C432BE
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6305E61186
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240955AbhHUJXZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbhHUJWt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:22:49 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06BBC061760;
        Sat, 21 Aug 2021 02:20:36 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u3so25238447ejz.1;
        Sat, 21 Aug 2021 02:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lzouR77OW9nooQQxrqAFj0oMxi+kbjqOBs0ytAr5v0w=;
        b=fVEDPE1qGrefc4fPgIGanm8A7JRLPKnb6uo0CT7JzDhhKiYLn20ovdpI9NovZZmKae
         FBoRoMXFXTMHqOEcALOD1lW7kXumebv9DMEJDEGr3H8CQ15z4DGNrx6gO8K7DT2MEpRi
         LtqcFwhSVP9Z5hiMWreLyM2O5F8Jph/rdEWX0x3gYfTa8Ax6V7W+HP2lMsOWTVl42YOH
         Xy2YAEYlAS0aGN7uHs+yMagCA+TAuk++WV2+fBC3MKoVAXbiQBVz8jp/7KTHJtXd6jzU
         z3+NjV+TqKILTgGpzU8aF2s7HlLdTSfo4AkOAmfkzFQN/eH0ETQELIieM3Juxa2rierB
         7kFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lzouR77OW9nooQQxrqAFj0oMxi+kbjqOBs0ytAr5v0w=;
        b=L43wp90yYnTWSlTARd62xZrO0sam7a3gOAB46uwqaTmCjeKHR/pQnBEF3LvvwYA1mn
         3sOTAeaR5AGpQLNBRLOIhDPTb7it/cWefWTHLmybwgZPylzW2wW4bvzCYcnYYPauOnD4
         i8dSwUqSgwprT8KsS9tn1a7wjCQEpcNcSJ0adpWDDEmg/RitWINuRO8Fc8KtyoYFu1mI
         5sRhQoLghx3btpWhRNIDB0Dk/F6IcO79p9e0JEvooipy2JHG3l1jARe16eapZHozqkcR
         uGic1dTl5IE8v5gBY8Go9UhHr3ZSNMx6BaXy/tF5o5u9ezjqCtsSEor0NL8aM+MGa3ej
         ELpg==
X-Gm-Message-State: AOAM5311KirUNuiKe9PnHxgn77zWmNpvs4eeiNYxIG/eMgcfi3PJzxKa
        4CGxNuWJijYFKA6t4icPJ2w=
X-Google-Smtp-Source: ABdhPJyAAzILA+hmxdZxcTLI9L83c0xsJcIEXV/1vhcSoDzY9Z2RexNuLcOWKzZLJAjQe6eJCqbI8g==
X-Received: by 2002:a17:906:3157:: with SMTP id e23mr26251426eje.29.1629537635274;
        Sat, 21 Aug 2021 02:20:35 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:20:35 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [RFC PATCH v1 37/37] perf test/evlist-open-close: add detailed output mode
Date:   Sat, 21 Aug 2021 11:19:43 +0200
Message-Id: <fd3d0bdaf8dfa4eedd53fbdcf8088b8211a6f191.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch adds a detailed output mode in the perf-test
evlist-open-close. In this output mode, the time taken by each single
evlist function is computed.

Normal mode:
$ sudo ./perf bench internals evlist-open-close
  Number of workers:    1
  Number of cpus:       4
  Number of threads:    1
  Number of events:     1 (4 fds)
  Number of iterations: 100
  Average open-close took:     1199.300 usec (+-      289.699 usec)

Detailed mode:
$ sudo ./perf bench internals evlist-open-close -d
  Number of workers:    1
  Number of cpus:       4
  Number of threads:    1
  Number of events:     1 (4 fds)
  Number of iterations: 100
  Average open-close took:     1199.300 usec (+-      289.699 usec)
                init took:        0.000 usec (+-        0.000 usec)
                open took:       25.600 usec (+-        1.778 usec)
                mmap took:      532.000 usec (+-       58.133 usec)
              enable took:      337.300 usec (+-      194.160 usec)
             disable took:      181.700 usec (+-       85.307 usec)
              munmap took:       22.100 usec (+-        4.045 usec)
               close took:      100.300 usec (+-       21.329 usec)
                fini took:        0.200 usec (+-        0.133 usec)

* init and fini represent the time taken before and after the evlist
  operations (in this case the workqueue setup and teardown operations)

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/bench/evlist-open-close.c | 63 ++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 3 deletions(-)

diff --git a/tools/perf/bench/evlist-open-close.c b/tools/perf/bench/evlist-open-close.c
index 00d0aef564f80d44..8ba2799c66cafb3e 100644
--- a/tools/perf/bench/evlist-open-close.c
+++ b/tools/perf/bench/evlist-open-close.c
@@ -25,12 +25,18 @@
 static int iterations = 100;
 static int nr_events = 1;
 static const char *event_string = "dummy";
+static bool detail;
 
 static inline u64 timeval2usec(struct timeval *tv)
 {
 	return tv->tv_sec * USEC_PER_SEC + tv->tv_usec;
 }
 
+struct timers {
+	struct timeval start, end, diff;
+	struct stats init, open, mmap, enable, disable, munmap, close, fini;
+};
+
 static struct record_opts opts = {
 	.sample_time	     = true,
 	.mmap_pages	     = UINT_MAX,
@@ -60,6 +66,7 @@ static const struct option options[] = {
 	OPT_STRING('u', "uid", &opts.target.uid_str, "user", "user to profile"),
 	OPT_BOOLEAN(0, "per-thread", &opts.target.per_thread, "use per-thread mmaps"),
 	OPT_UINTEGER_OPTARG('j', "threads", &opts.nr_threads, UINT_MAX, "Number of threads to use"),
+	OPT_BOOLEAN('d', "detail", &detail, "compute time taken by single functions"),
 	OPT_END()
 };
 
@@ -113,11 +120,28 @@ static struct evlist *bench__create_evlist(char *evstr)
 	return NULL;
 }
 
-static int bench__do_evlist_open_close(struct evlist *evlist)
+#define START_TIMER(timers) do { \
+	if (detail) { \
+		gettimeofday(&(timers)->start, NULL); \
+	} \
+} while (0)
+
+#define RECORD_TIMER(timers, field) do { \
+	if (detail) { \
+		gettimeofday(&(timers)->end, NULL); \
+		timersub(&(timers)->end, &(timers)->start, &(timers)->diff); \
+		update_stats(&(timers)->field, timeval2usec(&(timers)->diff)); \
+		(timers)->start = (timers)->end; \
+	} \
+} while (0)
+
+static int bench__do_evlist_open_close(struct evlist *evlist, struct timers *timers)
 {
 	char sbuf[WORKQUEUE_STRERR_BUFSIZE];
 	int err = -1, ret;
 
+	START_TIMER(timers);
+
 	if (opts.nr_threads > 1) {
 		err = setup_global_workqueue(opts.nr_threads);
 		if (err) {
@@ -130,23 +154,30 @@ static int bench__do_evlist_open_close(struct evlist *evlist)
 
 		perf_set_multithreaded();
 	}
+	RECORD_TIMER(timers, init);
 
 	err = evlist__open(evlist);
 	if (err < 0) {
 		pr_err("evlist__open: %s\n", str_error_r(errno, sbuf, sizeof(sbuf)));
 		goto out;
 	}
+	RECORD_TIMER(timers, open);
 
 	err = evlist__mmap(evlist, opts.mmap_pages);
 	if (err < 0) {
 		pr_err("evlist__mmap: %s\n", str_error_r(errno, sbuf, sizeof(sbuf)));
 		goto out;
 	}
+	RECORD_TIMER(timers, mmap);
 
 	evlist__enable(evlist);
+	RECORD_TIMER(timers, enable);
 	evlist__disable(evlist);
+	RECORD_TIMER(timers, disable);
 	evlist__munmap(evlist);
+	RECORD_TIMER(timers, munmap);
 	evlist__close(evlist);
+	RECORD_TIMER(timers, close);
 
 out:
 	if (opts.nr_threads > 1) {
@@ -159,10 +190,15 @@ static int bench__do_evlist_open_close(struct evlist *evlist)
 
 		perf_set_singlethreaded();
 	}
+	RECORD_TIMER(timers, fini);
 
 	return err;
 }
 
+#define PRINT_TIMER(timers, field) \
+	printf("%20s took: %12.3f usec (+- %12.3f usec)\n", #field, \
+		avg_stats(&(timers)->field), stddev_stats(&(timers)->field))
+
 static int bench_evlist_open_close__run(char *evstr)
 {
 	// used to print statistics only
@@ -172,10 +208,21 @@ static int bench_evlist_open_close__run(char *evstr)
 	struct stats time_stats;
 	u64 runtime_us;
 	int i, err;
+	struct timers timers;
 
 	if (!evlist)
 		return -ENOMEM;
 
+	init_stats(&time_stats);
+	init_stats(&timers.init);
+	init_stats(&timers.open);
+	init_stats(&timers.mmap);
+	init_stats(&timers.enable);
+	init_stats(&timers.disable);
+	init_stats(&timers.munmap);
+	init_stats(&timers.close);
+	init_stats(&timers.fini);
+
 	init_stats(&time_stats);
 
 	printf("  Number of workers:\t%u\n", opts.nr_threads);
@@ -194,7 +241,7 @@ static int bench_evlist_open_close__run(char *evstr)
 			return -ENOMEM;
 
 		gettimeofday(&start, NULL);
-		err = bench__do_evlist_open_close(evlist);
+		err = bench__do_evlist_open_close(evlist, &timers);
 		if (err) {
 			evlist__delete(evlist);
 			return err;
@@ -211,7 +258,17 @@ static int bench_evlist_open_close__run(char *evstr)
 
 	time_average = avg_stats(&time_stats);
 	time_stddev = stddev_stats(&time_stats);
-	printf("  Average open-close took: %.3f usec (+- %.3f usec)\n", time_average, time_stddev);
+	printf("  Average open-close took: %12.3f usec (+- %12.3f usec)\n", time_average, time_stddev);
+	if (detail) {
+		PRINT_TIMER(&timers, init);
+		PRINT_TIMER(&timers, open);
+		PRINT_TIMER(&timers, mmap);
+		PRINT_TIMER(&timers, enable);
+		PRINT_TIMER(&timers, disable);
+		PRINT_TIMER(&timers, munmap);
+		PRINT_TIMER(&timers, close);
+		PRINT_TIMER(&timers, fini);
+	}
 
 	return 0;
 }
-- 
2.31.1

