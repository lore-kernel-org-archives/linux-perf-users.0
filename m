Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76A93976BA;
	Wed, 16 Sep 2026 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522220; cv=none; b=HjYbfYamUMewJdQHjQ/3o1jjv9rZt8d7PYzIHsp8qUvKuS7n967Sopmz/gp6BTALeqgXn6yz5FsknrAZQLpb2Ed+poS338GLUJzSvpnmT7sQlUtqhonsPCbDuH2PQwXBk+0XQec+2YpkMG5xrZSEyHX11dg35xytvRI7kvYfJps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522220; c=relaxed/simple;
	bh=s9n095wSUCsRXSW/632bX+pY7fxYSqIcMHlvjqJeZTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=elZ+ExPLf/qNwW8D5EGQQZZVd6xmxfTg+TTXbqodGVk2TGRfU4xQF++XJ1oV0fyE3oQ4kWcEBAIyG9leGxnq5DVRnR67PLmFiIpwTpS6gJYLBwfniKd844/gLojMWIuvkQj/GAE7LKWj8BcWrQid8amksaHztId2QUDVQDgYjTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hl1XT5dN0zYQtqn;
	Wed, 16 Sep 2026 09:30:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E24D64057D;
	Wed, 16 Sep 2026 09:30:05 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAn+CoH8alqUcjbAQ--.36458S12;
	Wed, 16 Sep 2026 09:30:05 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Namhyung Kim <namhyung@kernel.org>,
	james.clark@linaro.org,
	xueshuai@linux.alibaba.com,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>,
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
Subject: [PATCH v6 10/26] perf annotate: Default to --itrace=i1i for data type profiling
Date: Wed, 16 Sep 2026 01:29:24 +0000
Message-Id: <3d2b93b84d7059024f40528153dc6b6a20461c77.1789521520.git.wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1789521520.git.wutengda@huaweicloud.com>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAn+CoH8alqUcjbAQ--.36458S12
X-Coremail-Antispam: 1UD129KBjvJXoW3JFy5ZrykXF4kZw1kXr4Utwb_yoW3ZFWDpr
	nxCr9rKwnxXr4rKwnIya1UZF1Yk34rXFyY9r10kF4rA3yxur9rtFyxtr15tFW3Xw1DC3sI
	vws09wn8Za1rZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUH2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7Cj
	xVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxc
	IEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc7CjxVAKzI0EY4vE52x082I5
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr
	0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
	42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sRNg4S3UUUU
	U==
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

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
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
index 850fc72fa75f..8863f3a570f6 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -885,6 +885,14 @@ int cmd_annotate(int argc, const char **argv)
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

