Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46031412C11;
	Sat,  8 Aug 2026 12:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786193080; cv=none; b=XUrI0+rTZG+m6qub16WQIxOJb19gCbwTB53Wg6+lKg1fvukqrpfNMDpl0ElNCvUWcBQ2ZkLk9PVX7d0lX7+MPLd1qKp9CNwWRIQxwP3PU1fxhEyRO06fsfmXthu9JWDh9W8VPnwivXeUkTGnYPSo1t/oBeMN52/YoKCidL+tKZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786193080; c=relaxed/simple;
	bh=uTqKpFd5ac5nw5tkzre5QVhienCAJgAdr+wqaZdg/8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UZoDA3XFC97+xTz2kM/5moxNunTMNmqFCwujhrBAL/kkV+oEmBoyIo0hrSlq7cNkaNMJfqysl5FiBhLY81Ky6Htt+0XVHk4M0LyiKYP8uTl7MnoOc8TkRzw9aVKiRGDV8M02/+2MFWPEaScii3usd9GYZF7D6h2Iz+DIQ/OTe60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hHKvC1LrJzKHND9;
	Sat,  8 Aug 2026 20:24:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 474EE4057D;
	Sat,  8 Aug 2026 20:24:18 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgB34YjkH3dqbrhMBg--.41805S11;
	Sat, 08 Aug 2026 20:24:17 +0800 (CST)
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
Subject: [PATCH v4 09/23] perf annotate: Deduplicate overlapping ARM SPE events for data type profiling
Date: Sat,  8 Aug 2026 12:23:46 +0000
Message-Id: <20260808122400.2961238-10-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260808122400.2961238-1-wutengda@huaweicloud.com>
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgB34YjkH3dqbrhMBg--.41805S11
X-Coremail-Antispam: 1UD129KBjvJXoWxGr4fWrWxGr4xtFW5Aw47Jwb_yoWrtrW3pr
	sI9w15KwnYqr4rKrn3ZF4UXryS93yfXFZ8GwnFya15A3y3ur95tFyxtr15tFZxXwn8Z34a
	vws0ga98G34rZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YV
	CY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20xyl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRQYFCDUUUU
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

Although using the '--itrace' option can work around this issue (e.g.:
perf annotate --data-type --stdio --itrace=i1i), it is inconvenient for
users to specify this explicitly every time.

To address this, introduce itrace_synth_opts.dont_overlap. Set this to true
when data type profiling is enabled and the user has not explicitly
specified an itrace option. Then, during arm_spe_process_auxtrace_info(),
adjust the synthesized event options based on the dont_overlap value to
only enable instruction event synthesis, thereby achieving automatic
deduplication.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/perf/builtin-annotate.c |  8 ++++++++
 tools/perf/util/arm-spe.c     | 17 +++++++++++++++++
 tools/perf/util/auxtrace.h    |  2 ++
 3 files changed, 27 insertions(+)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 69cb72b2082a..616f54bf4868 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -873,6 +873,14 @@ int cmd_annotate(int argc, const char **argv)
 	annotate.session = perf_session__new(&data, &annotate.tool);
 	if (IS_ERR(annotate.session))
 		return PTR_ERR(annotate.session);
+	/*
+	 * Hardware tracing (e.g.: ARM SPE) may generate overlapping events
+	 * per instruction. When data type profiling is enabled, enable
+	 * dont_overlap to deduplicate them to avoid skewed stats, but only
+	 * if user hasn't specified itrace options (respect user override).
+	 */
+	if (annotate.data_type && !itrace_synth_opts.set)
+		itrace_synth_opts.dont_overlap = true;
 
 	annotate.session->itrace_synth_opts = &itrace_synth_opts;
 
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 401aab529309..1721882423f6 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -2033,6 +2033,9 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 		/* Default nanoseconds period not supported */
 		spe->synth_opts.period_type = PERF_ITRACE_PERIOD_INSTRUCTIONS;
 		spe->synth_opts.period = 1;
+
+		if (session->itrace_synth_opts)
+			spe->synth_opts.dont_overlap = session->itrace_synth_opts->dont_overlap;
 	}
 
 	if (spe->synth_opts.period_type != PERF_ITRACE_PERIOD_INSTRUCTIONS) {
@@ -2044,6 +2047,20 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 		ui__warning("Arm SPE has a hardware-based sampling period.\n\n"
 			    "--itrace periods > 1i downsample by an interval of n SPE samples rather than n instructions.\n");
 
+	if (spe->synth_opts.dont_overlap) {
+		/*
+		 * The 'instructions' event is the most comprehensive,
+		 * synthesize it exclusively.
+		 */
+		spe->synth_opts.flc = false;
+		spe->synth_opts.llc = false;
+		spe->synth_opts.tlb = false;
+		spe->synth_opts.branches = false;
+		spe->synth_opts.remote_access = false;
+		spe->synth_opts.mem = false;
+		spe->synth_opts.instructions = true;
+	}
+
 	err = arm_spe_synth_events(spe, session);
 	if (err)
 		goto err_free_queues;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 6947f3f284c0..ebb4e9e8e574 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -80,6 +80,7 @@ enum itrace_period_type {
  * @intr_events: whether to synthesize interrupt events
  * @errors: whether to synthesize decoder error events
  * @dont_decode: whether to skip decoding entirely
+ * @dont_overlap: whether to deduplicate overlapping events
  * @log: write a decoding log
  * @calls: limit branch samples to calls (can be combined with @returns)
  * @returns: limit branch samples to returns (can be combined with @calls)
@@ -128,6 +129,7 @@ struct itrace_synth_opts {
 	bool			intr_events;
 	bool			errors;
 	bool			dont_decode;
+	bool			dont_overlap;
 	bool			log;
 	bool			calls;
 	bool			returns;
-- 
2.34.1

