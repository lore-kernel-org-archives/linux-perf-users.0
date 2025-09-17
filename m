Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EF92FB63A;
	Wed, 17 Sep 2025 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130927; cv=none; b=P77npUj/FTraVZylPYCXWn19dg6uztoCM21ZMW/oFFtkuT4LJUX4Ig9d5ehAFpUL/vygybsJ0ew1x+vWeEABXsuhcNfjU7BvLGR+g14wXsDB8zg8awTeKjnnZwjByj9bMjykvIs+BiHdbvMveFkgX9OrhKfRdznUHS5JQEfqLdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130927; c=relaxed/simple;
	bh=xznId6KLEjexVhy44PArHFtKkaLQrxQlKITeJniEfMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nX0g1bjV8doqnfclTDBG5La9+d1seUqzJ3SGXtphuZXXtGq9wOIB4+U+wCpViBi+pCsrGKnLNiEPplpeAVo83Yu/XqmgtcMPXQ3LrR9Qk+P5alTvLOVb9yPUP27SBE+20n6mTA6g1LdYRT51SG5vTbA9dik9ZYgqN9Q0Sp8CNHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3DE426B9;
	Wed, 17 Sep 2025 10:41:56 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5608A3F694;
	Wed, 17 Sep 2025 10:42:03 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 17 Sep 2025 18:41:38 +0100
Subject: [PATCH 1/2] coresight: trbe: Prevent overflow in PERF_IDX2OFF()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-fix_aux_trace_index-v1-1-e36a76ac6292@arm.com>
References: <20250917-fix_aux_trace_index-v1-0-e36a76ac6292@arm.com>
In-Reply-To: <20250917-fix_aux_trace_index-v1-0-e36a76ac6292@arm.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Tamas Zsoldos <tamas.zsoldos@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758130921; l=966;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=xznId6KLEjexVhy44PArHFtKkaLQrxQlKITeJniEfMw=;
 b=xm7EqYkG+5d5BnteZZCaYjnZng4eknZZdmbDF+4qbTnRmbX8O0oYWWZNZ524Yz6+MGMQaq42R
 A8hgQsIIvpdCneK9sYCcTau5oHci7VEb13RVQmcwjMCjNofM/d119GP
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Cast nr_pages to unsigned long to avoid overflow when handling large
AUX buffer sizes (>= 2 GiB).

Fixes: 3fbf7f011f24 ("coresight: sink: Add TRBE driver")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 8267dd1a2130d37d9507791620ea7bc8cbcd675c..8f426f94e32a15fd26e6c4e42385a5d93a7b7c1a 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -23,7 +23,8 @@
 #include "coresight-self-hosted-trace.h"
 #include "coresight-trbe.h"
 
-#define PERF_IDX2OFF(idx, buf) ((idx) % ((buf)->nr_pages << PAGE_SHIFT))
+#define PERF_IDX2OFF(idx, buf) \
+	((idx) % ((unsigned long)(buf)->nr_pages << PAGE_SHIFT))
 
 /*
  * A padding packet that will help the user space tools

-- 
2.34.1

