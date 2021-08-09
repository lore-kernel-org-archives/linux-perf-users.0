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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681F3C4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 20:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F7606101D
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 20:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbhHIUMc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 16:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbhHIUMc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Aug 2021 16:12:32 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFD1C0613D3;
        Mon,  9 Aug 2021 13:12:11 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id go31so31106118ejc.6;
        Mon, 09 Aug 2021 13:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w+dBzHW48cveY5JsyQnk8n0R9kV70jWvNFWpGE+wfRU=;
        b=YU9UiG5QIKr4XDzOWUqLc9Zm3kFStGD4O+HM2N3art3vHr9eRYtjO1rL5p/Noz8hiY
         51Y60Z2ktKL2GlMfppfq63EeHH3odlxNux7BTB6SctBuFtG4nrS60Htk3Bv8pCDAAlIJ
         GevLHfoJsTPz4NS3p54/XGAgP7gpBOr/2Wfio90kVI6eCMV2F4DmRrFTR2sga5wKuidU
         XLPkZE8/XuqpQIMBRs/tARKXo4j7MOx7ibSUCsP18vwK+7Ms0J9x58KsUIz0iCGE1TfB
         SDXKdopK4IgCK896S/tsQ0BDVIzHMQEHFjQmp+bB3v/4HAsVuoDhUGwuecYAlUbLwjsw
         Pxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w+dBzHW48cveY5JsyQnk8n0R9kV70jWvNFWpGE+wfRU=;
        b=PlwDdNhy+Xj9u/3gUwRkf9eZ55uYT9r+D4Ndxtp0TZRL34C6wBTRyVkg5fWCi7b0dG
         O2i7iyvD40u8C3ofb72sx+qwEKOtC4tNuMF/j7rEKyf84RaMd0IfBEbB81JbU5FWEvIa
         GMPVFwfhtzc8QFTzNg1tgNMquQrCNufKzmQKY0M1BSuSirVAYvAvJwGt9nyzkY4ZriSt
         t+o3DYbwk0jkbfmnUDyI0+0+r+fDIxBF4ZmycH06zusDWiFnuEaSO4VZ+Q+Nqixr3bb/
         McCDRLt+bW8OysftdSRu8tDXhh0c3rYUA64rtsSXnONQX5bYvecJksPMlkvBZyDtXF+2
         +7pQ==
X-Gm-Message-State: AOAM5337DJlx4VrHDUtWcdct6ZZZ6nfSFSQQ9I6eg6RsS4YgRGI381qC
        8K9aJF8f9D884O2ftBV7bTjHcQKEo97xRiUhpkE=
X-Google-Smtp-Source: ABdhPJwnKX2MyVHQs1+p42xzm2fb5BCCV6yKk9mjFk/cJfh+atSSAOvJDNEDE4FJCUT3JjwS/Up7Aw==
X-Received: by 2002:a17:906:2bd0:: with SMTP id n16mr20559410ejg.132.1628539929826;
        Mon, 09 Aug 2021 13:12:09 -0700 (PDT)
Received: from honeypot.epfl.ch ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id h19sm8611109edt.87.2021.08.09.13.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 13:12:03 -0700 (PDT)
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
Subject: [PATCH] perf bench: add benchmark for evlist open/close operations
Date:   Mon,  9 Aug 2021 22:11:02 +0200
Message-Id: <20210809201101.277594-1-rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This new benchmark finds the total time that is taken to open, mmap,
enable, disable, munmap, close an evlist (time taken for new,
create_maps, config, delete is not counted in).
The evlist can be configured as in perf-record using the
-a,-C,-e,-u,--per-thread,-t,-p options.
The events can be duplicated in the evlist to quickly test performance
with many events using the -n options.
Furthermore, also the number of iterations used to calculate the
statistics is customizable.

Examples:
- Open one dummy event system-wide:
$ sudo ./perf bench internals evlist-open-close
  Number of cpus:       4
  Number of threads:    1
  Number of events:     1 (4 fds)
  Number of iterations: 100
  Average open-close took: 613.870 usec (+- 32.852 usec)

- Open the group '{cs,cycles}' on CPU 0
$ sudo ./perf bench internals evlist-open-close -e '{cs,cycles}' -C 0
  Number of cpus:       1
  Number of threads:    1
  Number of events:     2 (2 fds)
  Number of iterations: 100
  Average open-close took: 8503.220 usec (+- 252.652 usec)

- Open 10 'cycles' events for user 0, calculate average over 100 runs
$ sudo ./perf bench internals evlist-open-close -e cycles -n 10 -u 0 -i 100
  Number of cpus:       4
  Number of threads:    328
  Number of events:     10 (13120 fds)
  Number of iterations: 100
  Average open-close took: 180043.140 usec (+- 2295.889 usec)

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/bench/Build               |   1 +
 tools/perf/bench/bench.h             |   1 +
 tools/perf/bench/evlist-open-close.c | 275 +++++++++++++++++++++++++++
 tools/perf/builtin-bench.c           |   1 +
 4 files changed, 278 insertions(+)
 create mode 100644 tools/perf/bench/evlist-open-close.c

diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
index e43f46931b41b78f..61d45fcb4057c945 100644
--- a/tools/perf/bench/Build
+++ b/tools/perf/bench/Build
@@ -13,6 +13,7 @@ perf-y += synthesize.o
 perf-y += kallsyms-parse.o
 perf-y += find-bit-bench.o
 perf-y += inject-buildid.o
+perf-y += evlist-open-close.o
 
 perf-$(CONFIG_X86_64) += mem-memcpy-x86-64-asm.o
 perf-$(CONFIG_X86_64) += mem-memset-x86-64-asm.o
diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index eac36afab2b39fa5..b3480bc33fe84885 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -48,6 +48,7 @@ int bench_epoll_ctl(int argc, const char **argv);
 int bench_synthesize(int argc, const char **argv);
 int bench_kallsyms_parse(int argc, const char **argv);
 int bench_inject_build_id(int argc, const char **argv);
+int bench_evlist_open_close(int argc, const char **argv);
 
 #define BENCH_FORMAT_DEFAULT_STR	"default"
 #define BENCH_FORMAT_DEFAULT		0
diff --git a/tools/perf/bench/evlist-open-close.c b/tools/perf/bench/evlist-open-close.c
new file mode 100644
index 0000000000000000..40bce06f5ca7bef3
--- /dev/null
+++ b/tools/perf/bench/evlist-open-close.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <limits.h>
+#include "bench.h"
+#include "../util/debug.h"
+#include "../util/stat.h"
+#include "../util/evlist.h"
+#include "../util/evsel.h"
+#include "../util/strbuf.h"
+#include "../util/record.h"
+#include "../util/parse-events.h"
+#include "internal/threadmap.h"
+#include "internal/cpumap.h"
+#include <linux/perf_event.h>
+#include <linux/kernel.h>
+#include <linux/time64.h>
+#include <linux/string.h>
+#include <subcmd/parse-options.h>
+
+#define MMAP_FLUSH_DEFAULT 1
+
+static int iterations = 100;
+static int nr_events = 1;
+static const char *event_string = "dummy";
+
+static struct record_opts opts = {
+	.sample_time	     = true,
+	.mmap_pages	     = UINT_MAX,
+	.user_freq	     = UINT_MAX,
+	.user_interval	     = ULLONG_MAX,
+	.freq		     = 4000,
+	.target		     = {
+		.uses_mmap   = true,
+		.default_per_cpu = true,
+	},
+	.mmap_flush          = MMAP_FLUSH_DEFAULT,
+	.nr_threads_synthesize = 1,
+	.ctl_fd              = -1,
+	.ctl_fd_ack          = -1,
+};
+
+static const struct option options[] = {
+	OPT_STRING('e', "event", &event_string, "event",
+		     "event selector. use 'perf list' to list available events"),
+	OPT_INTEGER('n', "nr-events", &nr_events,
+		     "number of dummy events to create (default 1). If used with -e, it clones those events n times (1 = no change)"),
+	OPT_INTEGER('i', "iterations", &iterations,
+		"Number of iterations used to compute average (default=100)"),
+	OPT_BOOLEAN('a', "all-cpus", &opts.target.system_wide,
+		"system-wide collection from all CPUs"),
+	OPT_STRING('C', "cpu", &opts.target.cpu_list, "cpu",
+		    "list of cpus where to open events"),
+	OPT_STRING('p', "pid", &opts.target.pid, "pid",
+		    "record events on existing process id"),
+	OPT_STRING('t', "tid", &opts.target.tid, "tid",
+		    "record events on existing thread id"),
+	OPT_STRING('u', "uid", &opts.target.uid_str, "user",
+		   "user to profile"),
+	OPT_BOOLEAN(0, "per-thread", &opts.target.per_thread,
+		    "use per-thread mmaps"),
+	OPT_END()
+};
+
+static const char *const bench_usage[] = {
+	"perf bench internals evlist-open-close <options>",
+	NULL
+};
+
+static int evlist__count_evsel_fds(struct evlist *evlist)
+{
+	struct evsel *evsel;
+	int cnt = 0;
+
+	evlist__for_each_entry(evlist, evsel) {
+		cnt += evsel->core.threads->nr * evsel->core.cpus->nr;
+	}
+
+	return cnt;
+}
+
+static struct evlist *bench__create_evlist(char *evstr)
+{
+	struct evlist *evlist;
+	struct parse_events_error err;
+	int ret;
+
+	evlist = evlist__new();
+	if (!evlist) {
+		pr_err("Not enough memory to create evlist\n");
+		return NULL;
+	}
+
+	bzero(&err, sizeof(err));
+	ret = parse_events(evlist, evstr, &err);
+	if (ret) {
+		parse_events_print_error(&err, evstr);
+		pr_err("Run 'perf list' for a list of valid events\n");
+		ret = 1;
+		goto out_delete_evlist;
+	}
+
+	ret = evlist__create_maps(evlist, &opts.target);
+	if (ret < 0) {
+		pr_err("Not enough memory to create thread/cpu maps\n");
+		goto out_delete_evlist;
+	}
+
+	evlist__config(evlist, &opts, NULL);
+
+	return evlist;
+
+out_delete_evlist:
+	evlist__delete(evlist);
+	return NULL;
+}
+
+static int bench__do_evlist_open_close(struct evlist *evlist)
+{
+	int err = -1;
+	char sbuf[STRERR_BUFSIZE];
+
+	err = evlist__open(evlist);
+	if (err < 0) {
+		pr_err("evlist__open: %s\n",
+			 str_error_r(errno, sbuf, sizeof(sbuf)));
+		return err;
+	}
+
+	err = evlist__mmap(evlist, opts.mmap_pages);
+	if (err < 0) {
+		pr_err("evlist__mmap: %s\n",
+			 str_error_r(errno, sbuf, sizeof(sbuf)));
+		return err;
+	}
+
+	evlist__enable(evlist);
+
+	evlist__disable(evlist);
+	evlist__munmap(evlist);
+	evlist__close(evlist);
+
+	return 0;
+}
+
+static int bench_evlist_open_close__run(char *evstr)
+{
+	struct evlist *evlist;
+	struct timeval start, end, diff;
+	double time_average, time_stddev;
+	int i;
+	int err;
+	u64 runtime_us;
+	struct stats time_stats;
+
+	init_stats(&time_stats);
+
+	// used to print statistics only
+	evlist = bench__create_evlist(evstr);
+
+	printf("  Number of cpus:\t%d\n", evlist->core.cpus->nr);
+	printf("  Number of threads:\t%d\n", evlist->core.threads->nr);
+	printf("  Number of events:\t%d (%d fds)\n",
+		evlist->core.nr_entries, evlist__count_evsel_fds(evlist));
+	printf("  Number of iterations:\t%d\n", iterations);
+
+	evlist__delete(evlist);
+
+	for (i = 0; i < iterations; i++) {
+		pr_debug("Started iteration %d\n", i);
+		evlist = bench__create_evlist(evstr);
+		gettimeofday(&start, NULL);
+		err = bench__do_evlist_open_close(evlist);
+		if (err) {
+			evlist__delete(evlist);
+			return err;
+		}
+
+		gettimeofday(&end, NULL);
+		timersub(&end, &start, &diff);
+		runtime_us = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
+		update_stats(&time_stats, runtime_us);
+
+		evlist__delete(evlist);
+		pr_debug("Iteration %d took:\t%ldus\n", i, runtime_us);
+	}
+
+	time_average = avg_stats(&time_stats);
+	time_stddev = stddev_stats(&time_stats);
+	printf("  Average open-close took: %.3f usec (+- %.3f usec)\n",
+		time_average, time_stddev);
+
+	return 0;
+}
+
+static char *bench__repeat_event_string(const char *evstr, int n)
+{
+	int err, i, final_size, str_size;
+	struct strbuf buf;
+	char sbuf[STRERR_BUFSIZE];
+
+	str_size = strlen(evstr);
+	final_size = str_size * n + n;
+
+	err = strbuf_init(&buf, final_size);
+	if (err) {
+		pr_err("strbuf_init: %s\n",
+			 str_error_r(err, sbuf, sizeof(sbuf)));
+		goto out_error;
+	}
+
+	for (i = 0; i < n; i++) {
+		err = strbuf_add(&buf, evstr, str_size);
+		if (err) {
+			pr_err("strbuf_add: %s\n",
+				str_error_r(err, sbuf, sizeof(sbuf)));
+			goto out_error;
+		}
+
+		err = strbuf_addch(&buf, i == n-1 ? '\0' : ',');
+		if (err) {
+			pr_err("strbuf_addch: %s\n",
+				str_error_r(err, sbuf, sizeof(sbuf)));
+			goto out_error;
+		}
+	}
+
+	return strbuf_detach(&buf, NULL);
+
+out_error:
+	strbuf_release(&buf);
+	return NULL;
+}
+
+
+int bench_evlist_open_close(int argc, const char **argv)
+{
+	int err = 0;
+	char *evstr, errbuf[BUFSIZ];
+
+	argc = parse_options(argc, argv, options, bench_usage, 0);
+	if (argc) {
+		usage_with_options(bench_usage, options);
+		exit(EXIT_FAILURE);
+	}
+
+	err = target__validate(&opts.target);
+	if (err) {
+		target__strerror(&opts.target, err, errbuf, BUFSIZ);
+		pr_err("%s\n", errbuf);
+		goto out;
+	}
+
+	err = target__parse_uid(&opts.target);
+	if (err) {
+		target__strerror(&opts.target, err, errbuf, BUFSIZ);
+		pr_err("%s", errbuf);
+		goto out;
+	}
+
+	/* Enable ignoring missing threads when -u/-p option is defined. */
+	opts.ignore_missing_thread = opts.target.uid != UINT_MAX || opts.target.pid;
+
+	evstr = bench__repeat_event_string(event_string, nr_events);
+	if (!evstr) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	err = bench_evlist_open_close__run(evstr);
+
+	free(evstr);
+out:
+	return err;
+}
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 62a7b7420a448517..d0895162c2ba6411 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -88,6 +88,7 @@ static struct bench internals_benchmarks[] = {
 	{ "synthesize", "Benchmark perf event synthesis",	bench_synthesize	},
 	{ "kallsyms-parse", "Benchmark kallsyms parsing",	bench_kallsyms_parse	},
 	{ "inject-build-id", "Benchmark build-id injection",	bench_inject_build_id	},
+	{ "evlist-open-close", "Benchmark evlist open and close",	bench_evlist_open_close	},
 	{ NULL,		NULL,					NULL			}
 };
 
-- 
2.31.1

