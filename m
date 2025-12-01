Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC00825B662;
	Mon,  1 Dec 2025 11:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588137; cv=none; b=fHqQY0VZinrsBq+8zsr2XMXWZN8tMROlupKlvJH+688zgGQXW25fK3QDQsDZc7Ds/owQKV2Ukl0ykQJrMyHulbeK1RoJ+1iUUHaxuPsDKdoRATSd0gg26+06DdvnuVQfyWAF8n+VYVuX4LYyfK8sQPbavKTUU7UGXkjir1Jyjdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588137; c=relaxed/simple;
	bh=LVlL57O5P5f7MwWK5l7g8QTDQyd/AvEeHETO4d4e2Ps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s8hxLvqX9z63kZns+2lFsHoyU81E4U1PDDGQjJnqd1cnwRWK+mDHVMst84BxxCOX08EUU0wINN5NUuYzb5jv8tfUOqlioQ9WAE/ynGtZtC6eqsO2pO3pAANkEZD+ngISPX6YSLoPNWBdoOs/bXeu9pKrwbALRt8TrLA4EgUxweE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A143B153B;
	Mon,  1 Dec 2025 03:22:06 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 805AB3F59E;
	Mon,  1 Dec 2025 03:22:11 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 01 Dec 2025 11:21:52 +0000
Subject: [PATCH 02/19] coresight: trbe: Remove redundant disable operation
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-trbe_buffer_refactor_v1-1-v1-2-7da32b076b28@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764588125; l=2104;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=LVlL57O5P5f7MwWK5l7g8QTDQyd/AvEeHETO4d4e2Ps=;
 b=RpodhpxKvSfrsVziIYFhBHNuTW4TcjqOsI2+VAr7kwEFjn4Vb6bkxQ253NbM7fqnMsHaGEGHR
 zATlaMhkjzpDuIQ/+wXvqc+ZA5nKyeDYzZ5bqIQdpyoe8z14OWmxV+H
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

The trace unit is already disabled when trbe_stop_and_truncate_event()
is called, so draining and stopping the buffer in the function is
redundant.

Remove the unnecessary disable operation and rename the function to
trbe_truncate_event() to better reflect its purpose.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 0ddb3db0213cf0014e29decfb79da68b0a351b31..2f44e4a65e0ee2b2c8fdd06a51ab01fc57f44a4e 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -284,18 +284,10 @@ static void trbe_report_wrap_event(struct perf_output_handle *handle)
 	perf_aux_output_flag(handle, PERF_AUX_FLAG_COLLISION);
 }
 
-static void trbe_stop_and_truncate_event(struct perf_output_handle *handle)
+static void trbe_truncate_event(struct perf_output_handle *handle)
 {
 	struct trbe_buf *buf = etm_perf_sink_config(handle);
 
-	/*
-	 * We cannot proceed with the buffer collection and we
-	 * do not have any data for the current session. The
-	 * etm_perf driver expects to close out the aux_buffer
-	 * at event_stop(). So disable the TRBE here and leave
-	 * the update_buffer() to return a 0 size.
-	 */
-	trbe_drain_and_disable_local(buf->cpudata);
 	perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
 	perf_aux_output_end(handle, 0);
 	*this_cpu_ptr(buf->cpudata->drvdata->handle) = NULL;
@@ -1008,7 +1000,7 @@ static int __arm_trbe_enable(struct trbe_buf *buf,
 	trbe_enable_hw(buf);
 	return 0;
 err:
-	trbe_stop_and_truncate_event(handle);
+	trbe_truncate_event(handle);
 	return ret;
 }
 
@@ -1169,7 +1161,7 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
 		trbe_handle_spurious(handle);
 		break;
 	case TRBE_FAULT_ACT_FATAL:
-		trbe_stop_and_truncate_event(handle);
+		trbe_truncate_event(handle);
 		truncated = true;
 		break;
 	}

-- 
2.34.1

