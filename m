Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E89C4320A
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF6BC61186
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240984AbhHUJW5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbhHUJWc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:22:32 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4FCC061153;
        Sat, 21 Aug 2021 02:20:34 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bt14so25230366ejb.3;
        Sat, 21 Aug 2021 02:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a/3m71kP0tYYLOMpvrgSKthU0QKRYTlQxU81VqWCx9s=;
        b=h/o/tTy2sYra0Z5LDpF/y/DoixhjUiOfLebPC7Rky5s8foQj/crzoXJFtUSV7el98k
         kyXQWsGaFFhpPN9URIVO9wBzWmM/x9vPRFaK+PZE+fe5jTTJQy+js9eykztwU0rlcTmU
         QsGysI70+aY6WYjnaOvQC47YpgzbpwwD/oCtlJoeLdFEHXHL1NhXpH7EOgu/gp8Sg6Fu
         DSGYmZ+vSOImtYI6ImDViFuZNX40sq22PukcEY8NW3ZF4vDYxuB4PW8dbeb2YqqnxOom
         0F2lRj+FU9Rc1SRw8YwvmF1vAbqsgi6HPuvP0SGge1u15Ar60vEnxCXuM+F9ibpe3ToI
         2cJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a/3m71kP0tYYLOMpvrgSKthU0QKRYTlQxU81VqWCx9s=;
        b=KExSUBP3siULC2H8pZupoWITXwZRQhCitYdjeqPSViRCB//EmpvJZSkgxUsOxQHKtf
         CWVsbhwiuzYqEjBml7JSihtfOmK1iiNZSzzyh/ZjjFKaxIMFX0XR16/f16RQZen2h24b
         jgMLYeA7qdsPM+JJtF48dD4HiyuSUerKHUoTHmVh163RtmaiiHhT1rrd7lnY9vwoNqVQ
         A0jUfqWp0vSw/qNNQw/dlfGXXOFOOyYYZxaSHuDmvuw5/Ww6ZsAAJeRTQcwA64QyzQs8
         vFLVRhZiXpClYKgMHrmq83dJ0plOOmDRFiQuma//kBII7tLV9OgbWZaPHCQ1zjp4YmTc
         Tsug==
X-Gm-Message-State: AOAM533nSoKjJNF4+M2JKG3c/w4z2gn/jL6Fr3P8e4wCPbl44juCP8lF
        TB8OUnOKWnyQJFhe962hAQjEBAaEbrlj8RwaqxA=
X-Google-Smtp-Source: ABdhPJyvyfWAk6gfVyzKvye/3Td3EzcXlBFfZ38ePuBh4t2TM/Z2PKThH+yw05dhhZwEEwbDOQYGQA==
X-Received: by 2002:a17:906:b890:: with SMTP id hb16mr25194842ejb.383.1629537632804;
        Sat, 21 Aug 2021 02:20:32 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:20:32 -0700 (PDT)
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
Subject: [RFC PATCH v1 35/37] perf test/evlist-open-close: add multithreading
Date:   Sat, 21 Aug 2021 11:19:41 +0200
Message-Id: <e01604581141e02aa29f1940879971c7e1ed791e.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch adds the new option -j/--threads to use multiple threads in
the evlist operations in the evlist-open-close benchmark.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/bench/evlist-open-close.c | 46 ++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/tools/perf/bench/evlist-open-close.c b/tools/perf/bench/evlist-open-close.c
index 674cb14cbaa9ef2c..c18aa85725281795 100644
--- a/tools/perf/bench/evlist-open-close.c
+++ b/tools/perf/bench/evlist-open-close.c
@@ -12,6 +12,8 @@
 #include "../util/parse-events.h"
 #include "internal/threadmap.h"
 #include "internal/cpumap.h"
+#include "../util/util.h"
+#include "../util/workqueue/workqueue.h"
 #include <linux/perf_event.h>
 #include <linux/kernel.h>
 #include <linux/time64.h>
@@ -35,7 +37,8 @@ static struct record_opts opts = {
 		.default_per_cpu = true,
 	},
 	.mmap_flush          = MMAP_FLUSH_DEFAULT,
-	.nr_threads_synthesize = 1,
+	.nr_threads          = 1,
+	.multithreaded_evlist = true,
 	.ctl_fd              = -1,
 	.ctl_fd_ack          = -1,
 };
@@ -51,6 +54,7 @@ static const struct option options[] = {
 	OPT_STRING('t', "tid", &opts.target.tid, "tid", "record events on existing thread id"),
 	OPT_STRING('u', "uid", &opts.target.uid_str, "user", "user to profile"),
 	OPT_BOOLEAN(0, "per-thread", &opts.target.per_thread, "use per-thread mmaps"),
+	OPT_UINTEGER_OPTARG('j', "threads", &opts.nr_threads, UINT_MAX, "Number of threads to use"),
 	OPT_END()
 };
 
@@ -106,18 +110,32 @@ static struct evlist *bench__create_evlist(char *evstr)
 
 static int bench__do_evlist_open_close(struct evlist *evlist)
 {
-	char sbuf[STRERR_BUFSIZE];
-	int err = evlist__open(evlist);
+	char sbuf[WORKQUEUE_STRERR_BUFSIZE];
+	int err = -1, ret;
+
+	if (opts.nr_threads > 1) {
+		err = setup_global_workqueue(opts.nr_threads);
+		if (err) {
+			create_workqueue_strerror(global_wq, sbuf, sizeof(sbuf));
+			pr_err("setup_global_workqueue: %s\n", sbuf);
+			return err;
+		}
+		if (evlist->core.all_cpus->nr <= workqueue_nr_threads(global_wq))
+			workqueue_set_affinities_cpu(global_wq, evlist->core.all_cpus);
 
+		perf_set_multithreaded();
+	}
+
+	err = evlist__open(evlist);
 	if (err < 0) {
 		pr_err("evlist__open: %s\n", str_error_r(errno, sbuf, sizeof(sbuf)));
-		return err;
+		goto out;
 	}
 
 	err = evlist__mmap(evlist, opts.mmap_pages);
 	if (err < 0) {
 		pr_err("evlist__mmap: %s\n", str_error_r(errno, sbuf, sizeof(sbuf)));
-		return err;
+		goto out;
 	}
 
 	evlist__enable(evlist);
@@ -125,7 +143,19 @@ static int bench__do_evlist_open_close(struct evlist *evlist)
 	evlist__munmap(evlist);
 	evlist__close(evlist);
 
-	return 0;
+out:
+	if (opts.nr_threads > 1) {
+		ret = teardown_global_workqueue();
+		if (ret) {
+			destroy_workqueue_strerror(err, sbuf, sizeof(sbuf));
+			pr_err("teardown_global_workqueue: %s\n", sbuf);
+			err = ret;
+		}
+
+		perf_set_singlethreaded();
+	}
+
+	return err;
 }
 
 static int bench_evlist_open_close__run(char *evstr)
@@ -143,6 +173,7 @@ static int bench_evlist_open_close__run(char *evstr)
 
 	init_stats(&time_stats);
 
+	printf("  Number of workers:\t%u\n", opts.nr_threads);
 	printf("  Number of cpus:\t%d\n", evlist->core.cpus->nr);
 	printf("  Number of threads:\t%d\n", evlist->core.threads->nr);
 	printf("  Number of events:\t%d (%d fds)\n",
@@ -226,6 +257,9 @@ int bench_evlist_open_close(int argc, const char **argv)
 		exit(EXIT_FAILURE);
 	}
 
+	if (opts.nr_threads == UINT_MAX)
+		opts.nr_threads = sysconf(_SC_NPROCESSORS_ONLN);
+
 	err = target__validate(&opts.target);
 	if (err) {
 		target__strerror(&opts.target, err, errbuf, sizeof(errbuf));
-- 
2.31.1

