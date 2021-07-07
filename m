Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F96AC07E95
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jul 2021 22:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 699EC61CD1
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jul 2021 22:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhGGWZE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Jul 2021 18:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhGGWZE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Jul 2021 18:25:04 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753DCC061574
        for <linux-perf-users@vger.kernel.org>; Wed,  7 Jul 2021 15:22:22 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id f10-20020a05620a15aab02903b3210e44dcso2517876qkk.6
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Jul 2021 15:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GxC1RR2Ie4AaPz1UrqPSvRdsqZ6PriUIe7QrSjk3Nok=;
        b=lXIkC7drd+eFIXEVgmLXFkMINrZ1DtNtEorGi9coNlR5JAfefjBQkbOj2cELrfE3YX
         UQc/dDhmfLnBMvId3phAfni0+/B1rThWUMYQSebnfuYjpmP8804Zw29fjL/ysUUFUFjp
         9jIjPBjfUhfUqXEMJULoaq5My7x2DtkQ71fDOUw2fXyRK40/lwm8vgsHGneBX4Slr9Sf
         ovOkyRUM6aVT88aQOZ578duJcEYZbbvWw36jRGjngG/fNskDm3uLgM4WClDjwGvDyo7r
         tgSFg0rZLgcQw1XzJZdt6pUMS1tK3UsKvGRA9ZFwFeR/TZvY2KIk1fCiSFWQNhDAzG4p
         fqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GxC1RR2Ie4AaPz1UrqPSvRdsqZ6PriUIe7QrSjk3Nok=;
        b=IqeF2t84v+85gx3CIanbOwpJBl07t2gC0c+iixiF6VcqUenPjnSEl2kYXy5aA9a+cI
         HKRLt+fLg809YKYXU/d+sMzbM5Ufw2MQ0Eir8GDUkdINZqK6C0wP5RjEBGQgoPj8PchJ
         XGX+LqkbMOcHiTExuIpse48J4fCcmJzK5bspLzXmnw0GPIM7l+WN6mgPUdouGZ0woH+O
         2MJSU9qlOZLUUTFivEtgoJ8Q8hIRag00lmyWkEOlTqe2IFxuXAwY3HARfKI6aLQAjpZR
         /KWDoHnErh5rtcWco8h0uMsMw8OHMuFz2dUEguP90ipS6eRH5XLLUs3kq6KrcnUcgxVo
         zy5w==
X-Gm-Message-State: AOAM531YULIqI+4U+39ENx7RJHOr0WfIkD/PzeN+Vq+jtBiwY8bmFFzc
        s2YpJ4PDSufUI+LJxyokZ7RBozS/MaBt
X-Google-Smtp-Source: ABdhPJwnT76KzRa6MmA1cQqdj+J/a/ALI2W9c7UcnVY2CmJFk1yyMaFsITz/4I6A62FRN7dw4S3wAIjudLU7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:5e6c:1062:c640:34e4])
 (user=irogers job=sendgmr) by 2002:ad4:442d:: with SMTP id
 e13mr11483411qvt.18.1625696540165; Wed, 07 Jul 2021 15:22:20 -0700 (PDT)
Date:   Wed,  7 Jul 2021 15:22:14 -0700
Message-Id: <20210707222214.107849-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [RFC PATCH] perf evlist: Remove group option.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The group option predates grouping events using curly braces added in
commit 89efb029502d ("perf tools: Add support to parse event group syntax")
The --group option was retained for legacy support (in August 2012) but
keeping it adds complexity.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-record.txt |  4 ----
 tools/perf/Documentation/perf-top.txt    |  7 ++-----
 tools/perf/builtin-record.c              |  2 --
 tools/perf/builtin-stat.c                |  6 ------
 tools/perf/builtin-top.c                 |  2 --
 tools/perf/tests/attr/test-record-group  | 22 ----------------------
 tools/perf/tests/attr/test-stat-group    | 17 -----------------
 tools/perf/util/evlist.c                 |  2 +-
 tools/perf/util/evlist.h                 |  1 -
 tools/perf/util/python.c                 |  8 --------
 tools/perf/util/record.c                 |  7 -------
 tools/perf/util/record.h                 |  1 -
 12 files changed, 3 insertions(+), 76 deletions(-)
 delete mode 100644 tools/perf/tests/attr/test-record-group
 delete mode 100644 tools/perf/tests/attr/test-stat-group

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index d71bac847936..d4497e8b25bf 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -236,10 +236,6 @@ OPTIONS
 	Also, by adding a comma, the number of mmap pages for AUX
 	area tracing can be specified.
 
---group::
-	Put all events in a single event group.  This precedes the --event
-	option and remains only for backward compatibility.  See --event.
-
 -g::
 	Enables call-graph (stack chain/backtrace) recording for both
 	kernel space and user space.
diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 9898a32b8d9c..67a1c65c8ebb 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -50,9 +50,6 @@ Default is to monitor all CPUS.
 --count-filter=<count>::
 	Only display functions with more events than this.
 
---group::
-        Put the counters into a counter group.
-
 --group-sort-idx::
 	Sort the output by the event at the index n in group. If n is invalid,
 	sort by the first event. It can support multiple groups with different
@@ -312,10 +309,10 @@ use '-e e1 -e e2 -G foo,foo' or just use '-e e1 -e e2 -G foo'.
 
 		perf top -e cycles,probe:icmp_rcv --switch-on=probe:icmp_rcv
 
-	   Alternatively one can ask for --group and then two overhead columns
+	   Alternatively one can ask for a group and then two overhead columns
            will appear, the first for cycles and the second for the switch-on event.
 
-		perf top --group -e cycles,probe:icmp_rcv --switch-on=probe:icmp_rcv
+		perf top -e '{cycles,probe:icmp_rcv}' --switch-on=probe:icmp_rcv
 
 	This may be interesting to measure a workload only after some initialization
 	phase is over, i.e. insert a perf probe at that point and use the above
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 71efe6573ee7..3ba82ba8404b 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2515,8 +2515,6 @@ static struct option __record_options[] = {
 	OPT_CALLBACK(0, "mmap-flush", &record.opts, "number",
 		     "Minimal number of bytes that is extracted from mmap data pages (default: 1)",
 		     record__mmap_flush_parse),
-	OPT_BOOLEAN(0, "group", &record.opts.group,
-		    "put the counters into a counter group"),
 	OPT_CALLBACK_NOOPT('g', NULL, &callchain_param,
 			   NULL, "enables call-graph recording" ,
 			   &record_callchain_opt),
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f9f74a514315..83f05c835545 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -178,7 +178,6 @@ static bool			topdown_run			= false;
 static bool			smi_cost			= false;
 static bool			smi_reset			= false;
 static int			big_num_opt			=  -1;
-static bool			group				= false;
 static const char		*pre_cmd			= NULL;
 static const char		*post_cmd			= NULL;
 static bool			sync_run			= false;
@@ -798,9 +797,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		child_pid = evsel_list->workload.pid;
 	}
 
-	if (group)
-		evlist__set_leader(evsel_list);
-
 	if (affinity__setup(&affinity) < 0)
 		return -1;
 
@@ -1190,8 +1186,6 @@ static struct option stat_options[] = {
 #endif
 	OPT_BOOLEAN('a', "all-cpus", &target.system_wide,
 		    "system-wide collection from all CPUs"),
-	OPT_BOOLEAN('g', "group", &group,
-		    "put the counters into a counter group"),
 	OPT_BOOLEAN(0, "scale", &stat_config.scale,
 		    "Use --no-scale to disable counter scaling for multiplexing"),
 	OPT_INCR('v', "verbose", &verbose,
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 2d570bfe7a56..53b908fad8f1 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1472,8 +1472,6 @@ int cmd_top(int argc, const char **argv)
 			    "dump the symbol table used for profiling"),
 	OPT_INTEGER('f', "count-filter", &top.count_filter,
 		    "only display functions with more events than this"),
-	OPT_BOOLEAN(0, "group", &opts->group,
-			    "put the counters into a counter group"),
 	OPT_BOOLEAN('i', "no-inherit", &opts->no_inherit,
 		    "child tasks do not inherit counters"),
 	OPT_STRING(0, "sym-annotate", &top.sym_filter, "symbol name",
diff --git a/tools/perf/tests/attr/test-record-group b/tools/perf/tests/attr/test-record-group
deleted file mode 100644
index 14ee60fd3f41..000000000000
--- a/tools/perf/tests/attr/test-record-group
+++ /dev/null
@@ -1,22 +0,0 @@
-[config]
-command = record
-args    = --no-bpf-event --group -e cycles,instructions kill >/dev/null 2>&1
-ret     = 1
-
-[event-1:base-record]
-fd=1
-group_fd=-1
-sample_type=327
-read_format=4
-
-[event-2:base-record]
-fd=2
-group_fd=1
-config=1
-sample_type=327
-read_format=4
-mmap=0
-comm=0
-task=0
-enable_on_exec=0
-disabled=0
diff --git a/tools/perf/tests/attr/test-stat-group b/tools/perf/tests/attr/test-stat-group
deleted file mode 100644
index e15d6946e9b3..000000000000
--- a/tools/perf/tests/attr/test-stat-group
+++ /dev/null
@@ -1,17 +0,0 @@
-[config]
-command = stat
-args    = --group -e cycles,instructions kill >/dev/null 2>&1
-ret     = 1
-
-[event-1:base-stat]
-fd=1
-group_fd=-1
-read_format=3|15
-
-[event-2:base-stat]
-fd=2
-group_fd=1
-config=1
-disabled=0
-enable_on_exec=0
-read_format=3|15
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 6ba9664089bd..fb03c47f8775 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -239,7 +239,7 @@ void __evlist__set_leader(struct list_head *list)
 	}
 }
 
-void evlist__set_leader(struct evlist *evlist)
+static void evlist__set_leader(struct evlist *evlist)
 {
 	if (evlist->core.nr_entries) {
 		evlist->nr_groups = evlist->core.nr_entries > 1 ? 1 : 0;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 2073cfa79f79..e3d0c68c5316 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -203,7 +203,6 @@ int evlist__create_maps(struct evlist *evlist, struct target *target);
 int evlist__apply_filters(struct evlist *evlist, struct evsel **err_evsel);
 
 void __evlist__set_leader(struct list_head *list);
-void evlist__set_leader(struct evlist *evlist);
 
 u64 __evlist__combined_sample_type(struct evlist *evlist);
 u64 evlist__combined_sample_type(struct evlist *evlist);
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 412f8e79e409..1920e9a3d96b 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1109,14 +1109,6 @@ static PyObject *pyrf_evlist__open(struct pyrf_evlist *pevlist,
 				   PyObject *args, PyObject *kwargs)
 {
 	struct evlist *evlist = &pevlist->evlist;
-	int group = 0;
-	static char *kwlist[] = { "group", NULL };
-
-	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|OOii", kwlist, &group))
-		return NULL;
-
-	if (group)
-		evlist__set_leader(evlist);
 
 	if (evlist__open(evlist) < 0) {
 		PyErr_SetFromErrno(PyExc_OSError);
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 43e5b563dee8..a5f2f2cf8001 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -99,13 +99,6 @@ void evlist__config(struct evlist *evlist, struct record_opts *opts, struct call
 	bool use_comm_exec;
 	bool sample_id = opts->sample_id;
 
-	/*
-	 * Set the evsel leader links before we configure attributes,
-	 * since some might depend on this info.
-	 */
-	if (opts->group)
-		evlist__set_leader(evlist);
-
 	if (evlist->core.cpus->map[0] < 0)
 		opts->no_inherit = true;
 
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 68f471d9a88b..d71dee9ce41c 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -13,7 +13,6 @@ struct option;
 
 struct record_opts {
 	struct target target;
-	bool	      group;
 	bool	      inherit_stat;
 	bool	      no_buffering;
 	bool	      no_inherit;
-- 
2.32.0.93.g670b81a890-goog

