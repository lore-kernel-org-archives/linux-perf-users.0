Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814A0C433E0
	for <linux-perf-users@archiver.kernel.org>; Fri, 22 Jan 2021 16:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AC4D2226A
	for <linux-perf-users@archiver.kernel.org>; Fri, 22 Jan 2021 16:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbhAVQ4R (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 22 Jan 2021 11:56:17 -0500
Received: from foss.arm.com ([217.140.110.172]:55614 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729620AbhAVQUl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 22 Jan 2021 11:20:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F99911D4;
        Fri, 22 Jan 2021 08:19:44 -0800 (PST)
Received: from e125528.arm.com (unknown [10.57.9.161])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A681C3F719;
        Fri, 22 Jan 2021 08:19:38 -0800 (PST)
From:   Alexandre Truong <alexandre.truong@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Alexandre Truong <alexandre.truong@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Al Grant <al.grant@arm.com>, James Clark <james.clark@arm.com>,
        Wilco Dijkstra <wilco.dijkstra@arm.com>
Subject: [PATCH 1/4] perf tools: record aarch64 registers automatically
Date:   Fri, 22 Jan 2021 16:18:51 +0000
Message-Id: <20210122161854.5289-1-alexandre.truong@arm.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On arm64, automatically record all the registers if the frame pointer
mode is on. They will be used to do a dwarf unwind to find the caller
of the leaf frame if the frame pointer was omitted.

Signed-off-by: Alexandre Truong <alexandre.truong@arm.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Kemeng Shi <shikemeng@huawei.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Al Grant <al.grant@arm.com>
Cc: James Clark <james.clark@arm.com>
Cc: Wilco Dijkstra <wilco.dijkstra@arm.com>
---
 tools/perf/arch/arm64/util/machine.c | 5 +++++
 tools/perf/builtin-record.c          | 7 +++++++
 tools/perf/util/callchain.h          | 2 ++
 3 files changed, 14 insertions(+)

diff --git a/tools/perf/arch/arm64/util/machine.c b/tools/perf/arch/arm64/util/machine.c
index d41b27e781d3..6ba1d356a20c 100644
--- a/tools/perf/arch/arm64/util/machine.c
+++ b/tools/perf/arch/arm64/util/machine.c
@@ -25,3 +25,8 @@ void arch__symbols__fixup_end(struct symbol *p, struct symbol *c)
 		p->end = c->start;
 	pr_debug4("%s sym:%s end:%#lx\n", __func__, p->name, p->end);
 }
+
+void arch__add_leaf_frame_record_opts(struct record_opts *opts)
+{
+	opts->sample_user_regs = arch__user_reg_mask();
+}
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 7bb10e9863bd..a5161f54b838 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2243,6 +2243,10 @@ static int record__parse_mmap_pages(const struct option *opt,
 	return ret;
 }
 
+void __weak arch__add_leaf_frame_record_opts(struct record_opts *opts __maybe_unused)
+{
+}
+
 static int parse_control_option(const struct option *opt,
 				const char *str,
 				int unset __maybe_unused)
@@ -2810,6 +2814,9 @@ int cmd_record(int argc, const char **argv)
 	/* Enable ignoring missing threads when -u/-p option is defined. */
 	rec->opts.ignore_missing_thread = rec->opts.target.uid != UINT_MAX || rec->opts.target.pid;
 
+	if (callchain_param.enabled && callchain_param.record_mode == CALLCHAIN_FP)
+		arch__add_leaf_frame_record_opts(&rec->opts);
+
 	err = -ENOMEM;
 	if (evlist__create_maps(rec->evlist, &rec->opts.target) < 0)
 		usage_with_options(record_usage, record_options);
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 5824134f983b..77fba053c677 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -280,6 +280,8 @@ static inline int arch_skip_callchain_idx(struct thread *thread __maybe_unused,
 }
 #endif
 
+void arch__add_leaf_frame_record_opts(struct record_opts *opts);
+
 char *callchain_list__sym_name(struct callchain_list *cl,
 			       char *bf, size_t bfsize, bool show_dso);
 char *callchain_node__scnprintf_value(struct callchain_node *node,
-- 
2.23.0

