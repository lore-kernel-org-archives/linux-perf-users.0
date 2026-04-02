Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617EA2D47F1;
	Thu,  2 Apr 2026 16:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145899; cv=none; b=ESTPoHhdKwHggLlslwN44KZzt8LCqzjBIe/Qt6upsqDO/qBkLsgeqL/K/z3oEnYBKwSxu7FUWd4JRfgc/hEvg8KmbyPX6sf2bDzI27XzEwSvJNedRzX4P7fr6d2UpNT8MUbNdUQ4zMLKPSqeodCF8Rej+quCIKvsviSXk+FUcag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145899; c=relaxed/simple;
	bh=5WSu1/ie1OJl/4DZsPZl0F7y0MW2cOIYvfLiJjg60Js=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ohPYEAa31KCFrUAQkXDj63ZbFrbNTIwP9ERWkQ9scXoQSx6LZBYu+jBBCFB0iZqfgYygebG7krJKC7/FZc6y/Ez+nAvzY1oYy7egqU+ZX95bABMRuMwUENdo46Ol//wXo8I6m+k8oUfSnN7KYR5f+UQS4297XxVcIEQuc9vM2aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Q/3yPQEK; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Q/3yPQEK"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1479833EA;
	Thu,  2 Apr 2026 09:04:51 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 852F03F915;
	Thu,  2 Apr 2026 09:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775145896; bh=5WSu1/ie1OJl/4DZsPZl0F7y0MW2cOIYvfLiJjg60Js=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q/3yPQEKVqW16+WV+L4ucRwi33/sx5g0TKdqC7aRYunvVvwRs0rd+q0onCusgGqEw
	 SVS8Y4W243LBDe94jzT241SmSk0a1onbCn6gx7n8Ewzumb+8RPUpid/h6XfHzWsW2J
	 h/fTSbkOCibm+q9X505xYW219PAOcRCfYhQNd5eM=
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 02 Apr 2026 17:04:47 +0100
Subject: [PATCH v2 1/3] perf expr: Return -EINVAL for syntax error in
 expr__find_ids()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-perf_fix_metrics_group-v2-1-1f9427a5d763@arm.com>
References: <20260402-perf_fix_metrics_group-v2-0-1f9427a5d763@arm.com>
In-Reply-To: <20260402-perf_fix_metrics_group-v2-0-1f9427a5d763@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775145893; l=1594;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=5WSu1/ie1OJl/4DZsPZl0F7y0MW2cOIYvfLiJjg60Js=;
 b=M1/NlrOkRD5yyxhSniPGs9UucDTANLPvoXS/Jgl1RKHJNlx9XziZRytFgAAzOilIhZqqHdrUp
 qakczbxljn0A8frT27n2qw4k+BoQxTz9MteSMOw6LSXkiT9nAJyvDlY
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

expr__find_ids() propagates the parser return value directly.  For syntax
errors, the parser can return a positive value, but callers treat it as
success, e.g., for below case on Arm64 platform:

  metric expr 100 * (STALL_SLOT_BACKEND / (CPU_CYCLES * #slots) - BR_MIS_PRED * 3 / CPU_CYCLES) for backend_bound
  parsing metric: 100 * (STALL_SLOT_BACKEND / (CPU_CYCLES * #slots) - BR_MIS_PRED * 3 / CPU_CYCLES)
  Failure to read '#slots' literal: #slots = nan
  syntax error

Convert positive parser returns in expr__find_ids() to -EINVAL, as a
result, the error value will be respected by callers.

Before:

  perf stat -C 5
  Failure to read '#slots'Failure to read '#slots'Failure to read '#slots'Failure to read '#slots'Segmentation fault

After:

  perf stat -C 5
  Failure to read '#slots'Cannot find metric or group `Default'

Fixes: ded80bda8bc9 ("perf expr: Migrate expr ids table to a hashmap")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/expr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 465fe2e9bbbeff52d3eebfe71aec53f1e5709991..b7664cb68554b284c2b64ca750bdfb114fa5515e 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -376,7 +376,8 @@ int expr__find_ids(const char *expr, const char *one,
 	if (one)
 		expr__del_id(ctx, one);
 
-	return ret;
+	/* A positive value means syntax error, convert to -EINVAL */
+	return ret > 0 ? -EINVAL : ret;
 }
 
 double expr_id_data__value(const struct expr_id_data *data)

-- 
2.34.1

