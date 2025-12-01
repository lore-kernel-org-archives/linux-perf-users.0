Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0ED2E5D17;
	Mon,  1 Dec 2025 11:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588147; cv=none; b=IVaBrCYRZ3dwkCBXqpBiOvfH1AYVVVluGkL0NNz/Gk22S9fj6bCJfwvBxrlSIqxtqRT02FT7J8EhZRyCYd8vPQjraXMeMDGGx+uSJ8yHEjPA1hzvVosyGZ+eViMcIhT4b58wjA1daXqD5SvDYs/37VwBqsBVfIfxJpIqF8ACfqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588147; c=relaxed/simple;
	bh=rS7n6GqYxBhjQifAmikJPjJWBJ0+WduJEB52j0HxrUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eg4cdltKMHXo2fmNZpOUFhSFKsxeQ3M7MgsjB4ogYh5vSdBbYGfYQjFiesMYqQuSI8DHP0Hdr7YkwoNVqhufUF/ls6y6dPZ5VFbygTJkqAPdocAFsCQpk0HTSFwXKeVwfgALFfP9l26iG6+1WTUO/YAY/N2qFBaSHyBwadcXW5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6BA3153B;
	Mon,  1 Dec 2025 03:22:17 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A89F83F59E;
	Mon,  1 Dec 2025 03:22:22 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 01 Dec 2025 11:21:56 +0000
Subject: [PATCH 06/19] coresight: trbe: Refactor syndrome decoding
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-trbe_buffer_refactor_v1-1-v1-6-7da32b076b28@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764588125; l=4359;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=rS7n6GqYxBhjQifAmikJPjJWBJ0+WduJEB52j0HxrUc=;
 b=j2R99VhM0xRCEGs9Df6BspIDlCsqEPA0TdAW9zgg7opexB+TMQv2IZXgjHuEHaqsxSf8Rfn+0
 siZbfpHRgTVA2u0tY12czMXtmPRWBTWMLKT9N+FT+TZqLe27g92sSq0
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

It gives priority to TRBSR_EL1.EA (external abort); an external abort
will immediately bail out and return an error.

Next, the syndrome decoding is refactored based on two levels of
information: the EC (Event Class) bits and the BSC (Trace Buffer Status
Code) bits.

If TRBSR_EL1.EC==0b000000, the driver continues parsing TRBSR_EL1.BSC to
identify the specific trace buffer event.  Otherwise, any non-zero
TRBSR_EL1.EC is treated as an error.

For error cases, the driver prints an error string and dumps registers
for debugging.

No additional checks are required for wrap mode beyond verifying the
TRBSR_EL1.WRAP bit, even on units with overwrite errata, as this bit
reliably indicates a buffer wrap.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 60 +++++++++++++++++++++-------
 drivers/hwtracing/coresight/coresight-trbe.h |  8 ++--
 2 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 9e565122816949b37b8ff5e4ba04cfbc317c6f25..28e2bfa68074f19ccaa4a737d00af577aea818fe 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -643,29 +643,61 @@ static void trbe_enable_hw(struct trbe_buf *buf)
 static enum trbe_fault_action trbe_get_fault_act(struct perf_output_handle *handle,
 						 u64 trbsr)
 {
+	const char *err_str;
 	int ec = get_trbe_ec(trbsr);
 	int bsc = get_trbe_bsc(trbsr);
-	struct trbe_buf *buf = etm_perf_sink_config(handle);
-	struct trbe_cpudata *cpudata = buf->cpudata;
 
 	WARN_ON(is_trbe_running(trbsr));
-	if (is_trbe_trg(trbsr) || is_trbe_abort(trbsr))
-		return TRBE_FAULT_ACT_FATAL;
 
-	if ((ec == TRBE_EC_STAGE1_ABORT) || (ec == TRBE_EC_STAGE2_ABORT))
-		return TRBE_FAULT_ACT_FATAL;
+	if (is_trbe_abort(trbsr)) {
+		err_str = "External abort";
+		goto out_fatal;
+	}
 
-	/*
-	 * If the trbe is affected by TRBE_WORKAROUND_OVERWRITE_FILL_MODE,
-	 * it might write data after a WRAP event in the fill mode.
-	 * Thus the check TRBPTR == TRBBASER will not be honored.
-	 */
-	if ((is_trbe_wrap(trbsr) && (ec == TRBE_EC_OTHERS) && (bsc == TRBE_BSC_FILLED)) &&
-	    (trbe_may_overwrite_in_fill_mode(cpudata) ||
-	     get_trbe_write_pointer() == get_trbe_base_pointer()))
+	switch (ec) {
+	case TRBE_EC_OTHERS:
+		break;
+	case TRBE_EC_BUF_MGMT_IMPL:
+		err_str = "Unexpected implemented management";
+		goto out_fatal;
+	case TRBE_EC_GP_CHECK_FAULT:
+		err_str = "Granule Protection Check fault";
+		goto out_fatal;
+	case TRBE_EC_STAGE1_ABORT:
+		err_str = "Stage 1 data abort";
+		goto out_fatal;
+	case TRBE_EC_STAGE2_ABORT:
+		err_str = "Stage 2 data abort";
+		goto out_fatal;
+	default:
+		err_str = "Unknown error code";
+		goto out_fatal;
+	}
+
+	switch (bsc) {
+	case TRBE_BSC_NOT_STOPPED:
+		break;
+	case TRBE_BSC_FILLED:
+		break;
+	case TRBE_BSC_TRIGGERED:
+		err_str = "Unexpected trigger status";
+		goto out_fatal;
+	default:
+		err_str = "Unexpected buffer status code";
+		goto out_fatal;
+	}
+
+	if (is_trbe_wrap(trbsr))
 		return TRBE_FAULT_ACT_WRAP;
 
 	return TRBE_FAULT_ACT_SPURIOUS;
+
+out_fatal:
+	pr_err_ratelimited("%s on CPU %d [TRBSR=0x%016llx, TRBPTR=0x%016llx, TRBLIMITR=0x%016llx]\n",
+			   err_str, smp_processor_id(), trbsr,
+			   read_sysreg_s(SYS_TRBPTR_EL1),
+			   read_sysreg_s(SYS_TRBLIMITR_EL1));
+	return TRBE_FAULT_ACT_FATAL;
 }
 
 static unsigned long trbe_get_trace_size(struct perf_output_handle *handle,
diff --git a/drivers/hwtracing/coresight/coresight-trbe.h b/drivers/hwtracing/coresight/coresight-trbe.h
index 45202c48accec7c86ba56130e2737bc2d1830fae..d7f7cd763c0c7139cf322b7336ee563073e3bea0 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.h
+++ b/drivers/hwtracing/coresight/coresight-trbe.h
@@ -35,9 +35,11 @@ static inline bool is_trbe_enabled(void)
 	return trblimitr & TRBLIMITR_EL1_E;
 }
 
-#define TRBE_EC_OTHERS		0
-#define TRBE_EC_STAGE1_ABORT	36
-#define TRBE_EC_STAGE2_ABORT	37
+#define TRBE_EC_OTHERS			0x0
+#define TRBE_EC_GP_CHECK_FAULT		0X1e
+#define TRBE_EC_BUF_MGMT_IMPL		0x1f
+#define TRBE_EC_STAGE1_ABORT		0x24
+#define TRBE_EC_STAGE2_ABORT		0x25
 
 static inline int get_trbe_ec(u64 trbsr)
 {

-- 
2.34.1

