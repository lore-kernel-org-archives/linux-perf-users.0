Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4213D548572;
	Tue,  8 Sep 2026 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872533; cv=none; b=nswVoYRxZOfEyBP+b0btTRBwTbE3qV0qj1EWgB+YNE1BVv1CwXpBPHXWHtQHYwYf7juaFhNgqd0tgvK1L/1zXAB6Uy/7CMam+P9zsWcKyAjvvIih0Y3MG0yYYpxplEXoEr4YfOX6yanQxEsBHkmcywN5l7IFUqwP24tlqOGyDFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872533; c=relaxed/simple;
	bh=wd+DkufeoDIg/aUt79AXXStJz/ZyyMUYtSQv9wF8JXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XCF01S2j++06cptxGY7EBVrbdjUVqPPOcZwgx1qKgLqumXz0dYHUpTj8debzAKvsYojWNhj0G2AeD655QTRR0X9tm1bVCC/jhOhrkP66CfDQO9nJKSYddHSPfDZiknJkx+CjNLoNBL9gQJ6f3U9mG+go7Mz8Kzwu84em6tNmb2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hfPGS5rTFzKHN6P;
	Tue,  8 Sep 2026 21:01:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 26ED44057D;
	Tue,  8 Sep 2026 21:01:54 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAni5gpB6BqC9rlBA--.34632S12;
	Tue, 08 Sep 2026 21:01:53 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Namhyung Kim <namhyung@kernel.org>,
	james.clark@linaro.org,
	xueshuai@linux.alibaba.com,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Zecheng Li <zli94@ncsu.edu>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH v5 10/26] perf annotate: Default to --itrace=i1i for data type profiling
Date: Tue,  8 Sep 2026 13:01:06 +0000
Message-Id: <20260908130122.633500-11-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908130122.633500-1-wutengda@huaweicloud.com>
References: <20260908130122.633500-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAni5gpB6BqC9rlBA--.34632S12
X-Coremail-Antispam: 1UD129KBjvJXoW3JFy5ZrykXF4kZw1kXr4Utwb_yoW3Zrykpr
	nxCr9rKwnxXr4rKwnIyF4UZF1Yk34rXFyY9r1YkF4rA3yxur9rtFyxtr15tFW3Xw1DC3sI
	vws09wn8Za1rZaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRGMKuUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

ARM SPE-based sampling can synthesize multiple events on a single
instruction, as shown below. This would affect data type profiling
statistics:

  Available samples
  0 arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=1,min_latency=30/
  0 dummy:u
  84K l1d-miss
  95K l1d-access
  77K llc-miss
  58K llc-access
  9K tlb-miss
  108K tlb-access
  0 branch
  13K remote-access
  108K memory
  108K instructions

While 'perf report' provides an interactive menu for users to select a
specific event to prevent duplicate counting, 'perf annotate' lacks such
a mechanism. Consequently, it counts all instructions across these
overlapping events, which inflates the profile and distorts the data
type statistics.

Although using the '--itrace' option can work around this issue (e.g.:
perf annotate --data-type --stdio --itrace=i1i), it is inconvenient for
users to specify this explicitly every time.

To address this, introduce itrace_synth_opts.default_single_event_per_ip.
Set this field to true when data type profiling is enabled and the user
has not explicitly specified an itrace option. In itrace_synth_opts__set_default(),
use this flag to default to synthesizing at most one event per IP (equivalent
to --itrace=i1i) to prevent duplicate sample counts.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/perf/builtin-annotate.c |  8 ++++++++
 tools/perf/util/arm-spe.c     |  5 ++++-
 tools/perf/util/auxtrace.c    | 12 ++++++++++--
 tools/perf/util/auxtrace.h    |  7 ++++++-
 tools/perf/util/cs-etm.c      |  2 +-
 tools/perf/util/intel-bts.c   |  2 +-
 tools/perf/util/intel-pt.c    |  3 ++-
 7 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 69cb72b2082a..d5b66893c47c 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -873,6 +873,14 @@ int cmd_annotate(int argc, const char **argv)
 	annotate.session = perf_session__new(&data, &annotate.tool);
 	if (IS_ERR(annotate.session))
 		return PTR_ERR(annotate.session);
+	/*
+	 * Hardware tracing (e.g., ARM SPE) may synthesize multiple events per
+	 * instruction. When data type profiling is enabled, default to synthesizing
+	 * at most one event (equivalent to --itrace=i1i) to prevent skewed
+	 * statistics.
+	 */
+	if (annotate.data_type && !itrace_synth_opts.set)
+		itrace_synth_opts.default_single_event_per_ip = true;
 
 	annotate.session->itrace_synth_opts = &itrace_synth_opts;
 
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 401aab529309..ae7a5e9c3892 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -2029,7 +2029,10 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
 		spe->synth_opts = *session->itrace_synth_opts;
 	} else {
-		itrace_synth_opts__set_default(&spe->synth_opts, false);
+		struct itrace_synth_opts *opts = session->itrace_synth_opts;
+		bool single_event_per_ip = opts ? opts->default_single_event_per_ip : false;
+
+		itrace_synth_opts__set_default(&spe->synth_opts, false, single_event_per_ip);
 		/* Default nanoseconds period not supported */
 		spe->synth_opts.period_type = PERF_ITRACE_PERIOD_INSTRUCTIONS;
 		spe->synth_opts.period = 1;
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index aa749e1c3036..ed2113190785 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1478,8 +1478,15 @@ s64 perf_event__process_auxtrace(const struct perf_tool *tool __maybe_unused,
 #define PERF_ITRACE_MAX_LAST_BRANCH_SZ		1024
 
 void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
-				    bool no_sample)
+				    bool no_sample, bool single_event_per_ip)
 {
+	if (single_event_per_ip) {
+		synth_opts->instructions = true;
+		synth_opts->period_type = PERF_ITRACE_PERIOD_INSTRUCTIONS;
+		synth_opts->period = 1;
+		return;
+	}
+
 	synth_opts->branches = true;
 	synth_opts->transactions = true;
 	synth_opts->ptwrites = true;
@@ -1582,7 +1589,8 @@ int itrace_do_parse_synth_opts(struct itrace_synth_opts *synth_opts,
 
 	if (!str) {
 		itrace_synth_opts__set_default(synth_opts,
-					       synth_opts->default_no_sample);
+					       synth_opts->default_no_sample,
+					       synth_opts->default_single_event_per_ip);
 		return 0;
 	}
 
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 6947f3f284c0..5012bead1b92 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -65,6 +65,10 @@ enum itrace_period_type {
  * struct itrace_synth_opts - AUX area tracing synthesis options.
  * @set: indicates whether or not options have been set
  * @default_no_sample: Default to no sampling.
+ * @default_single_event_per_ip: Default to synthesizing at most 1 event per IP
+ *                               (equivalent to --itrace=i1i). Used by commands
+ *                               like 'perf annotate --data-type' to avoid duplicate
+ *                               sample counts for a single instruction.
  * @inject: indicates the event (not just the sample) must be fully synthesized
  *          because 'perf inject' will write it out
  * @instructions: whether to synthesize 'instructions' events
@@ -117,6 +121,7 @@ enum itrace_period_type {
 struct itrace_synth_opts {
 	bool			set;
 	bool			default_no_sample;
+	bool			default_single_event_per_ip;
 	bool			inject;
 	bool			instructions;
 	bool			cycles;
@@ -622,7 +627,7 @@ int itrace_do_parse_synth_opts(struct itrace_synth_opts *synth_opts,
 int itrace_parse_synth_opts(const struct option *opt, const char *str,
 			    int unset);
 void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
-				    bool no_sample);
+				    bool no_sample, bool single_event_per_ip);
 
 size_t perf_event__fprintf_auxtrace_error(union perf_event *event, FILE *fp);
 void perf_session__auxtrace_error_inc(struct perf_session *session,
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 114b3cd2da49..2d1ab34f7b6b 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -3626,7 +3626,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 		etm->synth_opts = *session->itrace_synth_opts;
 	} else {
 		itrace_synth_opts__set_default(&etm->synth_opts,
-				session->itrace_synth_opts->default_no_sample);
+				session->itrace_synth_opts->default_no_sample, false);
 		etm->synth_opts.callchain = false;
 		etm->synth_opts.thread_stack = session->itrace_synth_opts->thread_stack;
 	}
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 02df3e460489..4c9cca3acb6c 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -877,7 +877,7 @@ int intel_bts_process_auxtrace_info(union perf_event *event,
 		bts->synth_opts = *session->itrace_synth_opts;
 	} else {
 		itrace_synth_opts__set_default(&bts->synth_opts,
-				session->itrace_synth_opts->default_no_sample);
+				session->itrace_synth_opts->default_no_sample, false);
 		bts->synth_opts.thread_stack =
 				session->itrace_synth_opts->thread_stack;
 	}
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 9d6628169fd9..8c21c9f52d57 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -4463,7 +4463,8 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 	} else {
 		struct itrace_synth_opts *opts = session->itrace_synth_opts;
 
-		itrace_synth_opts__set_default(&pt->synth_opts, opts->default_no_sample);
+		itrace_synth_opts__set_default(&pt->synth_opts,
+					opts->default_no_sample, false);
 		if (!opts->default_no_sample && !opts->inject) {
 			pt->synth_opts.branches = false;
 			pt->synth_opts.callchain = true;
-- 
2.34.1

