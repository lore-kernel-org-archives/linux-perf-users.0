Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BDE3081D8;
	Mon,  1 Dec 2025 11:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588141; cv=none; b=llEapL4maaXDE9efZOAu5pfn6ISzRSCGrEsOeogFkyJt9l95c5vOIbu4eDDuCIpw7SbXVjimWHIQKERxXbErHjUzkrhVz9MJNdsRyu+rYxUNYLZBT8vcHiuaguQFpYpc2JvG9RAeNDJUGNswdILdtktUOHSUYa83UwOsOoJs3vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588141; c=relaxed/simple;
	bh=rwVi7zeVOB5lCUwpbBU1QGzW3dLjviyCuoRWQcOnTXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PPYfQPFxHs5aTwPwoq0wDMO5x7Dv4ktmguJr8ZV4dtxQQJPBkdpY0FwdWi/K5+vtLBCnI7pR0RdPHa7WNstbJ1g0Blw/IF1YNtV1U2G3BflGjEnshcS2am2XITBfQJ3Kh8mjirpsVoahkghsaxX0rBGby6V+3O9pQKkz2xIN4GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37C4F153B;
	Mon,  1 Dec 2025 03:22:12 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A1423F59E;
	Mon,  1 Dec 2025 03:22:16 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 01 Dec 2025 11:21:54 +0000
Subject: [PATCH 04/19] coresight: trbe: Remove set_trbe_disabled() from the
 enable flow
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-trbe_buffer_refactor_v1-1-v1-4-7da32b076b28@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764588125; l=995;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=rwVi7zeVOB5lCUwpbBU1QGzW3dLjviyCuoRWQcOnTXc=;
 b=byRbhSXOveTKDzaZ6UfsBWqNMZLzd5c09kdE4FJAAR83fUUILgQ6dH7iEJgIYK7SVLuqRvmiR
 AJBg9vHJgk0BRv30MlxVjW2mCg43KL5W0mXtjeU+k8b7JgnpuVfWeWm
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

set_trbe_disabled() should never appear in the enable flow, otherwise,
it may potentially hide bugs in the disable flow.

Remove set_trbe_disabled() from the enable path.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index f5597bd9b5fba9a8f5053d5823b03380fd468b5c..e426991e2c2c398a9d3982e9d0f7f542e404cbab 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -629,7 +629,6 @@ static void trbe_enable_hw(struct trbe_buf *buf)
 	WARN_ON(buf->trbe_hw_base < buf->trbe_base);
 	WARN_ON(buf->trbe_write < buf->trbe_hw_base);
 	WARN_ON(buf->trbe_write >= buf->trbe_limit);
-	set_trbe_disabled(buf->cpudata);
 	clr_trbe_status();
 	set_trbe_base_pointer(buf->trbe_hw_base);
 	set_trbe_write_pointer(buf->trbe_write);

-- 
2.34.1

