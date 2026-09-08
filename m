Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2D85505F8;
	Tue,  8 Sep 2026 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872751; cv=none; b=r9alpJ5UAJbQoAKtYSFdcBqn11/ynjrejtplza3OTUChvoGKrFNKNJNesUgGA9axglpzT5Liy3/7WCx8zgA28YhsFSdYX+yrBcrtR4UhqehEr47s3trLtVltx+XIM4WcvPQdhV0cazsbu3QXwMPkMGtNQl2SYXyI51FGrdOz3wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872751; c=relaxed/simple;
	bh=wd+DkufeoDIg/aUt79AXXStJz/ZyyMUYtSQv9wF8JXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gd1idV6KaujK4sIQE10WSDA5TcyBt/47MzU6W90nC97IQJUiVV0kuvdtwVQHpGf6gARv7vXsuLCW7FnxDZUIHNnCaJ0f+1/hMGgqmEhXiALGW12e2PwMIrVVDsdc1YLpn92/rP0CbvOev7ZCkbtwyOPBhVHbm38adc3cydVK+G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hfPKv4rk5zYQw6L;
	Tue,  8 Sep 2026 21:04:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 2DF2540578;
	Tue,  8 Sep 2026 21:05:43 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgDHLUoeCKBqX3XjBA--.22748S12;
	Tue, 08 Sep 2026 21:05:42 +0800 (CST)
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
Date: Tue,  8 Sep 2026 13:05:13 +0000
Message-Id: <a30bf174539765875129c06381932702934fd0c9.1788872630.git.wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDHLUoeCKBqX3XjBA--.22748S12
X-Coremail-Antispam: 1UD129KBjvJXoW3JFy5ZrykXF4kZw1kXr4Utwb_yoW3Zrykpr
	nxCr9rKwnxXr4rKwnIyF4UZF1Yk34rXFyY9r1YkF4rA3yxur9rtFyxtr15tFW3Xw1DC3sI
	vws09wn8Za1rZaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHCb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
	xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8
	JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
	AGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26rWY6Fy7MxkF7I0Ew4C2
	6cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Cr1j6rxdMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa
	7xRxnoUUUUUUU==
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

