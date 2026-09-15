Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC97396B70;
	Tue, 15 Sep 2026 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487373; cv=none; b=PR2YJO0VCOTf1BnJBdr8NkKKnigF8ATldrkrHTHur0HALR1lihoILfk8hnQ5FPqa23SY5y4IxM9na489BjCCCnwwbcA/QZgSI8aiuEPMI0z+wJH5njPUMp1e30YBdVAH7XmjgZFJQNy8KSL+xdUenVDsmj2wHMIPm72SIwyGo+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487373; c=relaxed/simple;
	bh=AydmBDCGxJoieq4qMCoYXMM5JRa7TDwIw3gGM515xLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d7/zTKIE3i+AKTHzSFBVLhK6Oy7z4bkpa4WUAmthsm525Fdv4DtcFTYlWi3ekFb+08/KB5xGcKqorRQ0elUJ1yES2GP8jRL0aujrP9ShDoJC+Gr+pjlY6YmlZmH95iwTJN1wXqWtA76iN3Vz434z2yF7j1pOq4g5QoJNm/EHXM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ChgiyNeE; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ChgiyNeE"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E1391570;
	Tue, 15 Sep 2026 08:49:26 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2BAD3F882;
	Tue, 15 Sep 2026 08:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789487370; bh=AydmBDCGxJoieq4qMCoYXMM5JRa7TDwIw3gGM515xLI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ChgiyNeE2xQD0onL/5oFutj0JGE3PYEkM4/YTnJoJwh4MYSRTfGG/fvyRDvzxHRmM
	 73uqGT5hvFRPPwYoU1EpC7qfRiCEbzXH8QwNYVN6tLx89J8hEZTvl5y8JbYo2uqxaV
	 4NktOchFCenfKns0ljWbexDM16ZyThJ10tMxs2DU=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 15 Sep 2026 16:48:56 +0100
Subject: [PATCH 10/25] coresight: trbe: Pad snapshot buffers
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-arm_cs_support_aux_sample-v1-10-35cf6f297d20@arm.com>
References: <20260915-arm_cs_support_aux_sample-v1-0-35cf6f297d20@arm.com>
In-Reply-To: <20260915-arm_cs_support_aux_sample-v1-0-35cf6f297d20@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789487340; l=2612;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=AydmBDCGxJoieq4qMCoYXMM5JRa7TDwIw3gGM515xLI=;
 b=bd4sFk+qXNO9HuRRhhh3F+uLaoxL8tn7YVQjLkFsE6GIeJ7NwBuxuMIRYAIx4ZvuAiPAk1bip
 6i8LIzRyHHMA8GEVzvqeMnmAN1Ge4EYpG1tqKv8++0vekOc6OW54RR7
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Snapshot buffers use the head as the write pointer without checking its
alignment or the space remaining before the limit. After a stop or a
move to another CPU, the head can be misaligned for the current TRBE.
It can also leave too little space for the Fill mode out-of-range
workaround.

Pad the head to the current CPU's alignment. If the remaining buffer
cannot hold the minimum trace region, pad to the end of buffer. Update
the head for setting next write pointer.

Fixes: 3fbf7f011f24 ("coresight: sink: Add TRBE driver")
Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 36 ++++++++++++++++++----------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index c7cbca45f2debd4047b93283ea9fe5dd9e1f2ebf..a31f2ebc327cd681344a62de28c0b3840505a9cb 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -374,18 +374,6 @@ static void trbe_pad_buf(struct perf_output_handle *handle, int len)
 		perf_aux_output_skip(handle, len);
 }
 
-static unsigned long trbe_snapshot_offset(struct perf_output_handle *handle)
-{
-	struct trbe_buf *buf = etm_perf_sink_config(handle);
-
-	/*
-	 * The ETE trace has alignment synchronization packets allowing
-	 * the decoder to reset in case of an overflow or corruption.
-	 * So we can use the entire buffer for the snapshot mode.
-	 */
-	return buf->nr_pages * PAGE_SIZE;
-}
-
 static u64 trbe_min_trace_buf_size(struct perf_output_handle *handle)
 {
 	u64 size = TRBE_TRACE_MIN_BUF_SIZE;
@@ -405,6 +393,30 @@ static u64 trbe_min_trace_buf_size(struct perf_output_handle *handle)
 	return size;
 }
 
+static unsigned long trbe_snapshot_offset(struct perf_output_handle *handle)
+{
+	struct trbe_buf *buf = etm_perf_sink_config(handle);
+	struct trbe_cpudata *cpudata = buf->cpudata;
+	u64 buf_size = (u64)buf->nr_pages << PAGE_SHIFT;
+	u64 head = PERF_IDX2OFF(handle->head, buf);
+	u64 next = round_up(head, cpudata->trbe_align);
+
+	/*
+	 * A task event may migrate to a CPU with a different alignment or
+	 * errata. Make sure it has enough space, pad up to the alignment
+	 * required by the current TRBE.
+	 */
+	if (buf_size - next < trbe_min_trace_buf_size(handle))
+		next = buf_size;
+
+	if (next != head) {
+		__trbe_pad_buf(buf, head, next - head);
+		handle->head += next - head;
+	}
+
+	return buf_size;
+}
+
 /*
  * TRBE Limit Calculation
  *

-- 
2.34.1

