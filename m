Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD0930AACA;
	Mon,  1 Dec 2025 11:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588155; cv=none; b=hqMzkrGB4XSkA+dyDWExsFhqmXPPEZpAYvlotyiqklB4eolZsIJ3aicr23wweQBv3e8HTexMvngI89Ud+5VPubTPxC5Bg6srrQhMy+nCuLFLYFoRJbdw8VYPYYVjgYTTrHk6WKELlX6JdkvelZAeVx0nHKP/ltpdt0BeLTpuMdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588155; c=relaxed/simple;
	bh=ksnOW813/iK1sop8lflRXFLjB5lzQz2UyBhXvDajeUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f/iAhsW0UVEBB8OVWlJmo27zqrv2V+YsmOMS+ZP0OyOGsHJ7B2xd6CUY8tBa0hEhMl3swqg/yQlUSaMDhsKB+j2zit+84TTI++0HgDNO8mpSHJLNOdEVG6a9QWzeVfU3E+XTBGxMwtOZnY5W+sAkgRA37FyPlzhDJARm54u9Nks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35121153B;
	Mon,  1 Dec 2025 03:22:26 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13E583F59E;
	Mon,  1 Dec 2025 03:22:30 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 01 Dec 2025 11:21:59 +0000
Subject: [PATCH 09/19] coresight: trbe: Add fault action argument to
 trbe_handle_overflow()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-trbe_buffer_refactor_v1-1-v1-9-7da32b076b28@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764588125; l=1665;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=ksnOW813/iK1sop8lflRXFLjB5lzQz2UyBhXvDajeUw=;
 b=FymtGmZmDoYUeDSYYDJzHDfusIr5gd+3LCACayX07U7EGpHbpD/+PMIJnWQTugSmTqfH0PXGq
 LRhPTtr7wwiAxLQTaUOGwzOHMYh5s/lK2CI47ZA0OnwDtEerPJg1MSC
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Add a new argument to trbe_handle_overflow() for the fault action, which
is used to compare the wrap event for trace size calculation.

No functional change intended; this is preparation for a later update.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 0caa4a6b437a3aa39fc6bcc72a23711b54f7c598..f56ecdeaa6596afb440e4d53732e08a85f9bf89d 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -1078,14 +1078,15 @@ static void trbe_handle_spurious(struct perf_output_handle *handle)
 	set_trbe_enabled(buf->cpudata, trblimitr);
 }
 
-static int trbe_handle_overflow(struct perf_output_handle *handle)
+static int trbe_handle_overflow(struct perf_output_handle *handle,
+				enum trbe_fault_action act)
 {
 	struct perf_event *event = handle->event;
 	struct trbe_buf *buf = etm_perf_sink_config(handle);
 	unsigned long size;
 	struct etm_event_data *event_data;
 
-	size = trbe_get_trace_size(handle, buf, true);
+	size = trbe_get_trace_size(handle, buf, act == TRBE_FAULT_ACT_WRAP);
 	if (buf->snapshot)
 		handle->head += size;
 
@@ -1179,7 +1180,7 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
 
 	switch (act) {
 	case TRBE_FAULT_ACT_WRAP:
-		truncated = !!trbe_handle_overflow(handle);
+		truncated = !!trbe_handle_overflow(handle, act);
 		break;
 	case TRBE_FAULT_ACT_SPURIOUS:
 		trbe_handle_spurious(handle);

-- 
2.34.1

