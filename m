Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E382522B6;
	Mon,  1 Dec 2025 11:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588138; cv=none; b=rjQL1cE9F5and33FDzG8ndZGzVhFD2BWPtkM/jdZWva0ox0VmfmJQX1dF91binxgB3ytfHGYPNVZunbOgm/rQa2CmAmmSFpeI3yuFu8eGi83ZIpfh6lXSDOnX3IowioFhJ+a8n0s2xJ8fIG6zIRnuV3+WHr/nQ8s9MDyV8WdTKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588138; c=relaxed/simple;
	bh=VfCA2xij8QWg5fgbHHGPURuv0el1gynI6szJM+HB2gM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qp9tc9j2OilAGy6FJBleYYrms6Qw5i8R8ovACq5YlSJIkj0BQYUHkfbkGp8T1/47UKcEmNqhPmxUkO4evQZIn+T3WOWsxnWMvroeHMksD8lA1WQ5GswI+JRUdqgC5zGsGbeA6KTWnkQYeCxELB8QVgRnc4+ZYKRCfAx+TxLh8oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A7E01595;
	Mon,  1 Dec 2025 03:22:09 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DDCB3F59E;
	Mon,  1 Dec 2025 03:22:14 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 01 Dec 2025 11:21:53 +0000
Subject: [PATCH 03/19] coresight: trbe: Remove buffer disabling in
 trbe_handle_overflow()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-trbe_buffer_refactor_v1-1-v1-3-7da32b076b28@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764588125; l=915;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=VfCA2xij8QWg5fgbHHGPURuv0el1gynI6szJM+HB2gM=;
 b=NvAsNFDv9EktNPgNlt7jE4Vq/oSojP7+Zpm263ij1qv1aKjw9OdZ8wn5/U+WsXIYyLxV6Tg3h
 MBbs3Y9nF7nAHA8KocPCKyG6btzGt3FDSCrNGhjQ12VNAYoSLGxxsL/
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

When trbe_handle_overflow() runs, the buffer has already been disabled
and drained, so the duplicate operation is unnecessary.  Remove it.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 2f44e4a65e0ee2b2c8fdd06a51ab01fc57f44a4e..f5597bd9b5fba9a8f5053d5823b03380fd468b5c 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -1077,7 +1077,6 @@ static int trbe_handle_overflow(struct perf_output_handle *handle)
 		 * is able to detect this with a disconnected handle
 		 * (handle->event = NULL).
 		 */
-		trbe_drain_and_disable_local(buf->cpudata);
 		*this_cpu_ptr(buf->cpudata->drvdata->handle) = NULL;
 		return -EINVAL;
 	}

-- 
2.34.1

