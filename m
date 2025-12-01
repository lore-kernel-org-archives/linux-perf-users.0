Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675023093A7;
	Mon,  1 Dec 2025 11:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588150; cv=none; b=AN+HKr3mxERo8wR6PHmz/b3Lqn2GVJTSNxx4na6usHl0q5XY6VCBlb/ggypJbVByMlms21tKlS0Cm7ixhoWlOzLpFdAq9uKKxf5dWXJziU7qqcNUbJdGFpuD50FjJ5CWKSVDbYFpBqa3vsYKuYxojRfZZr+26dKEMoZRV+o5FvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588150; c=relaxed/simple;
	bh=W/JeYnunOoLhYN6hczuLJvjEZ+swqNz13PSBPwFvoT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iErbId2Q0XiYd3VxC6ZF2i2nAtal9V1EldXSQBUWpgwuEFTKumSjjYr2zIUZ6NgNYIq5XnmSUngDwBif57FQtrZ+uDp3Ae6ffySAft3V7NfGoncxy1po67c160pp1AuLMlNkEAFezGaHiaRqGLpdY1cahGx6y+2brhVxrFJS+/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97E18153B;
	Mon,  1 Dec 2025 03:22:20 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7651C3F59E;
	Mon,  1 Dec 2025 03:22:25 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 01 Dec 2025 11:21:57 +0000
Subject: [PATCH 07/19] coresight: trbe: Refactor AUX flag setting
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-trbe_buffer_refactor_v1-1-v1-7-7da32b076b28@arm.com>
References: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
In-Reply-To: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Tamas Petz <tamas.petz@arm.com>, 
 Tamas Zsoldos <tamas.zsoldos@arm.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764588125; l=3290;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=W/JeYnunOoLhYN6hczuLJvjEZ+swqNz13PSBPwFvoT8=;
 b=49j4rwio/yVC2wwPB9Z9UiUECEUH03HHUoBb3VifuBNB8Y+ISShfg7DiQ4nBoshKwWSux9vlm
 TWhR+mz3crPCd5r1VNehnxNPG5t14B+GOOMRrPM/R8VEmlDUI1ARPhp
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Rather than spreading AUX flag setting in different functions, use
trbe_get_fault_act() as a central place for setting the flag.

Later we will support WRAP mode with continuous trace, so the WRAP
event does not necessarily cause the trace discontinuity, change to
check the stop status instead.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 38 +++++++++++++---------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 28e2bfa68074f19ccaa4a737d00af577aea818fe..b06885a08e082fd34f68d9588518807b5c47c86e 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -265,25 +265,6 @@ static void trbe_reset_local(struct trbe_cpudata *cpudata)
 	write_sysreg_s(0, SYS_TRBSR_EL1);
 }
 
-static void trbe_report_wrap_event(struct perf_output_handle *handle)
-{
-	/*
-	 * Mark the buffer to indicate that there was a WRAP event by
-	 * setting the COLLISION flag. This indicates to the user that
-	 * the TRBE trace collection was stopped without stopping the
-	 * ETE and thus there might be some amount of trace that was
-	 * lost between the time the WRAP was detected and the IRQ
-	 * was consumed by the CPU.
-	 *
-	 * Setting the TRUNCATED flag would move the event to STOPPED
-	 * state unnecessarily, even when there is space left in the
-	 * ring buffer. Using the COLLISION flag doesn't have this side
-	 * effect. We only set TRUNCATED flag when there is no space
-	 * left in the ring buffer.
-	 */
-	perf_aux_output_flag(handle, PERF_AUX_FLAG_COLLISION);
-}
-
 static void trbe_truncate_event(struct perf_output_handle *handle)
 {
 	struct trbe_buf *buf = etm_perf_sink_config(handle);
@@ -687,6 +668,23 @@ static enum trbe_fault_action trbe_get_fault_act(struct perf_output_handle *hand
 		goto out_fatal;
 	}
 
+	/*
+	 * Mark the buffer to indicate that there was a WRAP event by
+	 * setting the COLLISION flag. This indicates to the user that
+	 * the TRBE trace collection was stopped without stopping the
+	 * ETE and thus there might be some amount of trace that was
+	 * lost between the time the WRAP was detected and the IRQ
+	 * was consumed by the CPU.
+	 *
+	 * Setting the TRUNCATED flag would move the event to STOPPED
+	 * state unnecessarily, even when there is space left in the
+	 * ring buffer. Using the COLLISION flag doesn't have this side
+	 * effect. We only set TRUNCATED flag when there is no space
+	 * left in the ring buffer.
+	 */
+	if (!is_trbe_running(trbsr))
+		perf_aux_output_flag(handle, PERF_AUX_FLAG_COLLISION);
+
 	if (is_trbe_wrap(trbsr))
 		return TRBE_FAULT_ACT_WRAP;
 
@@ -878,7 +876,6 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
 			goto done;
 		}
 
-		trbe_report_wrap_event(handle);
 		wrap = true;
 	}
 
@@ -1099,7 +1096,6 @@ static int trbe_handle_overflow(struct perf_output_handle *handle)
 	if (buf->snapshot)
 		handle->head += size;
 
-	trbe_report_wrap_event(handle);
 	perf_aux_output_end(handle, size);
 	event_data = perf_aux_output_begin(handle, event);
 	if (!event_data) {

-- 
2.34.1

