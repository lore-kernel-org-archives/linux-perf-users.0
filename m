Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF17C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 21 Sep 2021 18:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50B9260F3A
	for <linux-perf-users@archiver.kernel.org>; Tue, 21 Sep 2021 18:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhIUSPY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 21 Sep 2021 14:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhIUSPX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 21 Sep 2021 14:15:23 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE02C061574
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Sep 2021 11:13:54 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id h16-20020a05621402f000b0037cc26a5659so3591101qvu.1
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Sep 2021 11:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RT4koZ5R+CdVTEeIOFkU+1hJ09JrE/e1nNnAMwPspPY=;
        b=cUz1z22sEN2xfK2JbxCX00E5p3QYtq31fmNaYrLH0oqFVdam147QHI815uZ2IljOxB
         Bquf17gb9GXBA6Ap494cxOJtYty7qKQo3YeLUdtdYHGT+d7wvfqxsUnP5sk1UeGcBJhZ
         OgmFrBwYqPfdC6TqPSJWrTs4MZpwzYb4GZY4xfbcYDbqkToOdJrMMN+/EYCjD1vAPVhl
         qaZJlIqpK3xEUXUzVEU1r9nC918OxwyNTd3O5IRrnPJDny5e5TRUw8mlk1ci46/KfI1+
         xTBROMIpTzDRmhOljp17HJcofyK5O8aIdt8Otn+hqo+jWArUDnWFndQTFU8hwjPk8nS+
         p1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RT4koZ5R+CdVTEeIOFkU+1hJ09JrE/e1nNnAMwPspPY=;
        b=CkRrZmwNS3AIcAMT/ZlRyJo2aeaBkzGG4Vtlm3jkVsM1lj4ZgxlrGJk0MZguja58n/
         wiLMdUqTu1HnrWY7wjaZpBo79OQqIN1H6MITK/xr38tFIdQIyCYupBKSGqgQmbS4TMXU
         A6nSglUlq25HUovGTQQgwYB8QQ0veqVlCxvtcgAidqsseWzdyT/gvtVF9PhpoecxkbLa
         +A3H5eU3xziNTXNtLGvd1OGeTaSrPj970F+veM41p5NXiJOisYjxy/Z1BgfuCzm1MqR/
         jd3lmlOP1fHZTrzUkWOPGdulVidTd3gppUzMAIW2iNhKdQBQMg5nLSNnltAUyjYHNPRP
         UcUQ==
X-Gm-Message-State: AOAM532qszKkT7BpXbd2EHfwVz7J3WlYYGpQhBW7+eClJozCEkZRJci+
        7XSd116te0LvNIKaDex1VkDwa2/SAgT4
X-Google-Smtp-Source: ABdhPJxeP/bmF6YChX9+qeBhL1OOwWfORBVJFswdF7lfcWklf6KI0/sJ2UMWK2B4Qzpj6lnL9B45Xx/ouS9N
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:dffa:819a:f0e2:47e])
 (user=irogers job=sendgmr) by 2002:a05:6214:13ee:: with SMTP id
 ch14mr32977260qvb.43.1632248034123; Tue, 21 Sep 2021 11:13:54 -0700 (PDT)
Date:   Tue, 21 Sep 2021 11:13:49 -0700
Message-Id: <20210921181349.199780-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v2] perf evlist: Remove group option.
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

v2. is a rebase.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-record.txt |  4 ----
 tools/perf/Documentation/perf-top.txt    |  7 ++-----
 tools/perf/builtin-record.c              |  2 --
 tools/perf/builtin-stat.c                |  6 ------
 tools/perf/builtin-top.c                 |  2 --
 tools/perf/tests/attr/README             |  2 --
 tools/perf/tests/attr/test-record-group  | 22 ----------------------
 tools/perf/tests/attr/test-stat-group    | 17 -----------------
 tools/perf/util/evlist.c                 |  2 +-
 tools/perf/util/evlist.h                 |  2 --
 tools/perf/util/python.c                 |  8 --------
 tools/perf/util/record.c                 |  7 -------
 tools/perf/util/record.h                 |  1 -
 13 files changed, 3 insertions(+), 79 deletions(-)
 delete mode 100644 tools/perf/tests/attr/test-record-group
 delete mode 100644 tools/perf/tests/attr/test-stat-group

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index f1079ee7f2ec..6e27b7227562 100644
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
index b3509d9d20cc..6eab7d059599 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2487,8 +2487,6 @@ static struct option __record_options[] = {
 	OPT_CALLBACK(0, "mmap-flush", &record.opts, "number",
 		     "Minimal number of bytes that is extracted from mmap data pages (default: 1)",
 		     record__mmap_flush_parse),
-	OPT_BOOLEAN(0, "group", &record.opts.group,
-		    "put the counters into a counter group"),
 	OPT_CALLBACK_NOOPT('g', NULL, &callchain_param,
 			   NULL, "enables call-graph recording" ,
 			   &record_callchain_opt),
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f6e87b7be5fa..f0f51e6966ac 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -180,7 +180,6 @@ static bool			topdown_run			= false;
 static bool			smi_cost			= false;
 static bool			smi_reset			= false;
 static int			big_num_opt			=  -1;
-static bool			group				= false;
 static const char		*pre_cmd			= NULL;
 static const char		*post_cmd			= NULL;
 static bool			sync_run			= false;
@@ -800,9 +799,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		child_pid = evsel_list->workload.pid;
 	}
 
-	if (group)
-		evlist__set_leader(evsel_list);
-
 	if (affinity__setup(&affinity) < 0)
 		return -1;
 
@@ -1192,8 +1188,6 @@ static struct option stat_options[] = {
 #endif
 	OPT_BOOLEAN('a', "all-cpus", &target.system_wide,
 		    "system-wide collection from all CPUs"),
-	OPT_BOOLEAN('g', "group", &group,
-		    "put the counters into a counter group"),
 	OPT_BOOLEAN(0, "scale", &stat_config.scale,
 		    "Use --no-scale to disable counter scaling for multiplexing"),
 	OPT_INCR('v', "verbose", &verbose,
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index a3ae9176a83e..bd3704432376 100644
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
diff --git a/tools/perf/tests/attr/README b/tools/perf/tests/attr/README
index a36f49fb4dbe..f538272af57b 100644
--- a/tools/perf/tests/attr/README
+++ b/tools/perf/tests/attr/README
@@ -47,7 +47,6 @@ Following tests are defined (with perf commands):
   perf record -g kill                           (test-record-graph-default)
   perf record --call-graph dwarf kill		(test-record-graph-dwarf)
   perf record --call-graph fp kill              (test-record-graph-fp)
-  perf record --group -e cycles,instructions kill (test-record-group)
   perf record -e '{cycles,instructions}' kill   (test-record-group1)
   perf record -e '{cycles/period=1/,instructions/period=2/}:S' kill (test-record-group2)
   perf record -D kill                           (test-record-no-delay)
@@ -61,6 +60,5 @@ Following tests are defined (with perf commands):
   perf stat -d kill                             (test-stat-detailed-1)
   perf stat -dd kill                            (test-stat-detailed-2)
   perf stat -ddd kill                           (test-stat-detailed-3)
-  perf stat --group -e cycles,instructions kill (test-stat-group)
   perf stat -e '{cycles,instructions}' kill     (test-stat-group1)
   perf stat -i -e cycles kill                   (test-stat-no-inherit)
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
index 5f92319ce258..2e11d82d15e0 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -224,7 +224,7 @@ int __evlist__set_tracepoints_handlers(struct evlist *evlist,
 	return err;
 }
 
-void evlist__set_leader(struct evlist *evlist)
+static void evlist__set_leader(struct evlist *evlist)
 {
 	perf_evlist__set_leader(&evlist->core);
 }
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 97bfb8d0be4f..f92460729d6b 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -201,8 +201,6 @@ void evlist__set_selected(struct evlist *evlist, struct evsel *evsel);
 int evlist__create_maps(struct evlist *evlist, struct target *target);
 int evlist__apply_filters(struct evlist *evlist, struct evsel **err_evsel);
 
-void evlist__set_leader(struct evlist *evlist);
-
 u64 __evlist__combined_sample_type(struct evlist *evlist);
 u64 evlist__combined_sample_type(struct evlist *evlist);
 u64 evlist__combined_branch_type(struct evlist *evlist);
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 8feef3a05af7..9cd79513eebb 100644
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
index bff669b615ee..9e694db7c7ee 100644
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
2.33.0.464.g1972c5931b-goog

