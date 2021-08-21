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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F0DC43214
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA698611EF
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbhHUJWz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbhHUJWQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:22:16 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A7EC061150;
        Sat, 21 Aug 2021 02:20:30 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id i6so17675618edu.1;
        Sat, 21 Aug 2021 02:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7abl+gAZuH7R6YORSyN+O64mVlc0Mbp5zWJWP/oVwnA=;
        b=E9vTuDsNMixeT+DjzghClvuYFRyrQnKDWNDbM+PK/N/6dMdUEp9CHjj6xc/dp1EKmV
         y6p4+DVNc2CLvtA+2aY7n+7D+eP79qua6K6PGLZVFK5VB7EZZ7rQO9KfuNySBTPtqX/p
         IsIvGs0+5aooMqWlAudIkWE09LMuYugUYTXirkKMBv/65Owm8uPJgDRfEtZ0wKMnHWBU
         4KC+jS7fUm3tSeHmDKxH+z0u2lVOn7KEAvz7FnA3C7eaSIgmkQE4YZFCJxMWIdYdHB4G
         2oa4sdod8wJxKKmt3M8BDdofjf19FtSUrDTjeuI5adV7D+AyyhiV3PJzgJHmBqqBnZB0
         Qa5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7abl+gAZuH7R6YORSyN+O64mVlc0Mbp5zWJWP/oVwnA=;
        b=Y2l0pJ89Y0k6mtKDQaIEmfuGx4tazfN7dKMR5+LjJAfL/m6UhYfT5zCZ7wVYfcXnTO
         Dmy/CwQyMgkk9828Kyr0J5NY3t1qNxShuedAW2mwgg9W6zs7t541hTmk6W5bcvXOWypQ
         WKLKtf29miMouqrQ5ZQHl+0UlIQZ2mVNTm5T0XWEVI7qYdfDQD5+6ku7YvsgkLezEVmc
         44mW1wGHALb8YIJVtduWmLipWgC62uZrqcRcWLxQqPv/QOnOlAE1p644TQBFuetavBs5
         0XIaRx/REGcb/oE3ugym+MsgE4o3tS/hIU8+bqZBHFZa+/VVTUuyRgMyoDpCNQbHcklt
         QBYA==
X-Gm-Message-State: AOAM5310zQ6/xB+bne4YOdVUyHF+e7bOuGXgqQ0FIqFhQ7Aw8SvvMgIP
        L63mr/gmOKUXkym4xl9tkGI=
X-Google-Smtp-Source: ABdhPJzGKDaoAgL73DeMX395cKj5kss4APYUkRWJKasFLanE0ZJvqxWB38R52XdzUUIbIV/waiRqsg==
X-Received: by 2002:a50:ff03:: with SMTP id a3mr26553586edu.100.1629537628637;
        Sat, 21 Aug 2021 02:20:28 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:20:28 -0700 (PDT)
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
Subject: [RFC PATCH v1 32/37] perf record: add --threads option
Date:   Sat, 21 Aug 2021 11:19:38 +0200
Message-Id: <fc333a628d66e23ac2af6ebd0f16f9b39f9563ba.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch adds a new --threads option to perf-record, which sets the
number of threads to use for multithreaded operations (synthesis and, in
following patches, evlist).

The new option will override the --num-thread-synthesize option if set.
By default, no thread will be used. The option can also be passed
without any argument, setting the number of threads to the number of
online cpus.

Furthermore, two new perf configs are added to selectively disable
multithreading in either synthesis and evlist.

To keep the same behaviour for --num-thread-synthesize, setting only that
option will cause multithreading to be enabled only in synthesis (by
overriding the perf config options for multithreaded synthesis and
evlist).

Examples:
$ ./perf record --threads
uses one thread per cpu for synthesis (and evlist in following patches)

$ ./perf record --threads 2 --num-thread-synthesize 4
the two options shouldn't be mixed, the behaviour would be using 2
threads for everything (4 is ignored)

$ ./perf record --num-thread-synthesize 4
same behaviour as before: 4 threads, but only for synthesis

$ ./perf config record.multithreaded_synthesis=no
$ ./perf record --threads
uses multithreading for everything but synthesis (i.e. evlist in
following patches)

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/Documentation/perf-record.txt |  9 ++++++
 tools/perf/builtin-record.c              | 35 +++++++++++++++++++-----
 tools/perf/util/record.h                 |  3 ++
 3 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index f1079ee7f2ecf4a8..f5525e3a36e0cf2a 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -629,6 +629,15 @@ appended unit character - B/K/M/G
 	The number of threads to run when synthesizing events for existing processes.
 	By default, the number of threads equals 1.
 
+--threads::
+	The number of threads to use for operations which have multithreaded
+	support (synthesize, evlist).
+	Setting this option overrides --num-thread-synthesize.
+	You can selectively disable any of the multithreaded operations through
+	perf-config record.multithreaded-{synthesis,evlist}.
+	By default, the number of threads equals 1.
+	Setting this option without any parameter sets it to the number of online cpus.
+
 ifdef::HAVE_LIBPFM[]
 --pfm-events events::
 Select a PMU event using libpfm4 syntax (see http://perfmon2.sf.net)
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index dc9a814b2e7906fc..7802a0e25f631fac 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1496,7 +1496,7 @@ static int record__synthesize(struct record *rec, bool tail)
 	if (err < 0)
 		pr_warning("Couldn't synthesize cgroup events.\n");
 
-	if (rec->opts.nr_threads_synthesize > 1) {
+	if (rec->opts.multithreaded_synthesis) {
 		perf_set_multithreaded();
 		f = process_locked_synthesized_event;
 	}
@@ -1504,7 +1504,7 @@ static int record__synthesize(struct record *rec, bool tail)
 	err = __machine__synthesize_threads(machine, tool, &opts->target, rec->evlist->core.threads,
 					    f, opts->sample_address);
 
-	if (rec->opts.nr_threads_synthesize > 1)
+	if (rec->opts.multithreaded_synthesis)
 		perf_set_singlethreaded();
 
 out:
@@ -2188,6 +2188,12 @@ static int perf_record_config(const char *var, const char *value, void *cb)
 			rec->opts.nr_cblocks = nr_cblocks_default;
 	}
 #endif
+	if (!strcmp(var, "record.multithreaded-synthesis"))
+		rec->opts.multithreaded_synthesis = perf_config_bool(var, value);
+
+	if (!strcmp(var, "record.multithreaded-evlist"))
+		rec->opts.multithreaded_evlist = perf_config_bool(var, value);
+
 
 	return 0;
 }
@@ -2434,6 +2440,9 @@ static struct record record = {
 		},
 		.mmap_flush          = MMAP_FLUSH_DEFAULT,
 		.nr_threads_synthesize = 1,
+		.nr_threads          = 1,
+		.multithreaded_evlist = true,
+		.multithreaded_synthesis = true,
 		.ctl_fd              = -1,
 		.ctl_fd_ack          = -1,
 	},
@@ -2640,6 +2649,9 @@ static struct option __record_options[] = {
 	OPT_UINTEGER(0, "num-thread-synthesize",
 		     &record.opts.nr_threads_synthesize,
 		     "number of threads to run for event synthesis"),
+	OPT_UINTEGER_OPTARG(0, "threads",
+		     &record.opts.nr_threads, UINT_MAX,
+		     "number of threads to use"),
 #ifdef HAVE_LIBPFM
 	OPT_CALLBACK(0, "pfm-events", &record.evlist, "event",
 		"libpfm4 event selector. use 'perf list' to list available events",
@@ -2915,10 +2927,19 @@ int cmd_record(int argc, const char **argv)
 		rec->opts.comp_level = comp_level_max;
 	pr_debug("comp level: %d\n", rec->opts.comp_level);
 
-	if (rec->opts.nr_threads_synthesize == UINT_MAX)
-		rec->opts.nr_threads_synthesize = sysconf(_SC_NPROCESSORS_ONLN);
-	if (rec->opts.nr_threads_synthesize > 1) {
-		err = setup_global_workqueue(rec->opts.nr_threads_synthesize);
+	if (rec->opts.nr_threads <= 1) {
+		rec->opts.multithreaded_evlist = false;
+		if (rec->opts.nr_threads_synthesize > 1) {
+			rec->opts.multithreaded_synthesis = true;
+			rec->opts.nr_threads = rec->opts.nr_threads_synthesize;
+		} else {
+			rec->opts.multithreaded_synthesis = false;
+		}
+	}
+	if (rec->opts.nr_threads == UINT_MAX)
+		rec->opts.nr_threads = sysconf(_SC_NPROCESSORS_ONLN);
+	if (rec->opts.nr_threads > 1) {
+		err = setup_global_workqueue(rec->opts.nr_threads);
 		if (err) {
 			create_workqueue_strerror(global_wq, errbuf, sizeof(errbuf));
 			pr_err("setup_global_workqueue: %s\n", errbuf);
@@ -2928,7 +2949,7 @@ int cmd_record(int argc, const char **argv)
 
 	err = __cmd_record(&record, argc, argv);
 
-	if (rec->opts.nr_threads_synthesize > 1)
+	if (rec->opts.nr_threads > 1)
 		teardown_global_workqueue();
 out:
 	bitmap_free(rec->affinity_mask.bits);
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 68f471d9a88b2b36..9c47a7904a43ffc7 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -74,6 +74,9 @@ struct record_opts {
 	int	      mmap_flush;
 	unsigned int  comp_level;
 	unsigned int  nr_threads_synthesize;
+	unsigned int  nr_threads;
+	bool	      multithreaded_synthesis;
+	bool	      multithreaded_evlist;
 	int	      ctl_fd;
 	int	      ctl_fd_ack;
 	bool	      ctl_fd_close;
-- 
2.31.1

