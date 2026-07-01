Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF92B368293;
	Wed,  1 Jul 2026 03:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878094; cv=none; b=rjhGLOhpsUhUeXXDLGKAL67gGojMi3WjPDA/QHSwQwEhZ18oqe+GH6LPJt9/Z+aP+3JRWIKRUEbeSNIUzkf/Jf+VWVNUiZ+DT56R0nV2RRcRsatUsHWFyMu4/sZfLvN65cqQl0Duu+13KEzjWlZNj67yftYa99+McgQF8lU9YOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878094; c=relaxed/simple;
	bh=bLezi/SX8MjrI+efADm45mrDQwz9ecAuBcCkgfyXWCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rKAz9wwB/cG5LfoPDEtJdOaJkdZWZyE1Izoa0jJrNyJRNt7Ql4oLE8z7JiSitVIkvaTLYsE0yzdkZ71yv7FOCKhL8gomSEqYO2T8T30JkIvbleFnG99nbC1rmTxUG7fzl2mLrJjQGFa+rzEvdAVRWSfUjkdfiOV05jEK+cwczNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gqmN00QvFzYQtqq;
	Wed,  1 Jul 2026 11:53:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id E417C40572;
	Wed,  1 Jul 2026 11:54:45 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBXiyWAj0RqCne9AQ--.26189S12;
	Wed, 01 Jul 2026 11:54:45 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Namhyung Kim <namhyung@kernel.org>,
	james.clark@linaro.org,
	xueshuai@linux.alibaba.com,
	Li Huafei <lihuafei1@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	leo.yan@linux.dev,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH v3 10/21] perf annotate: Deduplicate overlapping ARM SPE events for data type profiling
Date: Wed,  1 Jul 2026 03:53:44 +0000
Message-Id: <20260701035355.752944-11-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701035355.752944-1-wutengda@huaweicloud.com>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBXiyWAj0RqCne9AQ--.26189S12
X-Coremail-Antispam: 1UD129KBjvJXoWxGr4fWrWxGr4xtFW5Aw47Jwb_yoW5uFW8pF
	srWw13KF48Xrs3Kw4fAw4xGr13K3yfXay5Grna93yqy3ZF9Fy0qFWxtw1YyFW5Xrnxt34a
	vw4DKryUZ348taDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6x
	kF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkF7I0Ew4C26cxK6c8Ij28IcwCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
	cVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0piPkusUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

When data type profiling is enabled on ARM SPE, multiple overlapping
events (e.g., l1d-miss, tlb-access) are synthesized for a single sampled
instruction, as shown below:

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

Although using the '--itrace' option can work around this issue, for example:

  # perf annotate --data-type --stdio --itrace=i1i

it is inconvenient for users to specify this explicitly every time.

To address this, implement automatic deduplication in process_sample_event()
by retaining only the comprehensive "instructions" event when data type
annotation is enabled and no explicit itrace options are configured.

To achieve this, also set 'event->auxtrace_info.type' in arm_spe_prep_sample()
so that 'perf annotate' can correctly identify ARM SPE events during
sample processing.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/perf/builtin-annotate.c | 13 +++++++++++++
 tools/perf/util/arm-spe.c     |  1 +
 2 files changed, 14 insertions(+)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 69cb72b2082a..46b2bd3fb201 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -283,9 +283,22 @@ static int process_sample_event(const struct perf_tool *tool,
 				struct machine *machine)
 {
 	struct perf_annotate *ann = container_of(tool, struct perf_annotate, tool);
+	struct evsel *evsel = sample->evsel;
 	struct addr_location al;
 	int ret = 0;
 
+	/*
+	 * ARM SPE synthesizes multiple overlapping events (e.g., l1d-miss,
+	 * tlb-access) for a single sampled instruction. When data type is
+	 * enabled, counting all of these overlapping events would inflate
+	 * the profile and distort the data type statistics. To avoid this,
+	 * deduplicate by retaining only the comprehensive "instructions" event.
+	 */
+	if (ann->data_type && !ann->session->itrace_synth_opts->set &&
+	    event->auxtrace_info.type == PERF_AUXTRACE_ARM_SPE &&
+	    strcmp(evsel->name, "instructions") != 0)
+		return 0;
+
 	addr_location__init(&al);
 	if (machine__resolve(machine, &al, sample) < 0) {
 		pr_warning("problem processing %s (%u) event at offset %#" PRIx64 ", skipping it.\n",
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 552f063f126e..e027e3b200bf 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -403,6 +403,7 @@ static void arm_spe_prep_sample(struct arm_spe *spe,
 	event->sample.header.type = PERF_RECORD_SAMPLE;
 	event->sample.header.misc = sample->cpumode;
 	event->sample.header.size = sizeof(struct perf_event_header);
+	event->auxtrace_info.type = PERF_AUXTRACE_ARM_SPE;
 }
 
 static void arm_spe__prep_branch_stack(struct arm_spe_queue *speq)
-- 
2.34.1

