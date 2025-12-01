Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCDA30C61B;
	Mon,  1 Dec 2025 11:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588178; cv=none; b=dpYtwRFdkwqOrLhVlO5mERlwD6raZNygbRmPmNEH/i+gmipAc5Gw7uM69C6iNeiLvlcYJHk+Jvb4wA7u9wVyT7dGSq6zG10O8gu6FiAQn+Vm4V4aI79AN9BhJu46ZpwEqlezPlee2R4blILAKwYUQIiv4u4lHrWAFJZScYqWgKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588178; c=relaxed/simple;
	bh=eJElq7gC/JnnPBEjj1BBHX13g7bjZ8CcdBXjEePLB/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FUAgs58C2otWx0H1mC+9bp7KsPVz3kpG8Ja8aDdDBU6mynIJTru1mP0W5h3XsfwdG4+zBICc77GrEjsEduvU+DXY9InA+gEQsCZS1kFVOm4C2BrYe2Yij7xHkETib2gsUEORKK/M7Eia4GbQCsfRpvPh7xdP6psA66FAAipPhYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F3091595;
	Mon,  1 Dec 2025 03:22:48 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E8DC3F59E;
	Mon,  1 Dec 2025 03:22:53 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 01 Dec 2025 11:22:07 +0000
Subject: [PATCH 17/19] coresight: trbe: Enable circle mode for snapshot
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-trbe_buffer_refactor_v1-1-v1-17-7da32b076b28@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764588125; l=1408;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=eJElq7gC/JnnPBEjj1BBHX13g7bjZ8CcdBXjEePLB/4=;
 b=HQEoNUUs9+ttxYbCdH0xtRa8oIkNFKPAR0kgNljjd84BooIOh8Sfb9YOFOnI16mZeSDc1ZOIV
 omtaVR/7aqGAU2xmRk+/cxq/XLmW1ei1HSb3CgzG5AArMTyPRhhjME1
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

A snapshot session captures trace data only when userspace receives a
signal and disables tracing. Before disabling, enable circle mode
instead of fill mode to avoid unnecessary interrupt handling.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 0551ea9b4f8286c156e3c9c7ac94e2ecd3b9dc3f..ee9993d518d2a41f0d709b7d0690b2dfe0bef2d9 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -635,6 +635,12 @@ static void set_trbe_limit_pointer_enabled(struct trbe_buf *buf)
 	trblimitr &= ~TRBLIMITR_EL1_TM_MASK;
 	trblimitr &= ~TRBLIMITR_EL1_LIMIT_MASK;
 
+	if (buf->snapshot) {
+		trblimitr |= FIELD_PREP(TRBLIMITR_EL1_FM_MASK, TRBLIMITR_EL1_FM_CBUF) |
+			     FIELD_PREP(TRBLIMITR_EL1_TM_MASK, TRBLIMITR_EL1_TM_IGNR);
+		goto enable_trace_buf;
+	}
+
 	if (!buf->trbe_count ||
 	    buf->trbe_write + buf->trbe_count == buf->trbe_limit) {
 		/*
@@ -669,6 +675,7 @@ static void set_trbe_limit_pointer_enabled(struct trbe_buf *buf)
 			     FIELD_PREP(TRBLIMITR_EL1_TM_MASK, TRBLIMITR_EL1_TM_STOP);
 	}
 
+enable_trace_buf:
 	trblimitr |= (addr & PAGE_MASK);
 	set_trbe_enabled(buf->cpudata, trblimitr);
 }

-- 
2.34.1

