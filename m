Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA5D31A56D;
	Thu,  2 Apr 2026 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145900; cv=none; b=JEotyJI6DDZ1/tVIcbpbHHPqivhqbl+rz1ZLdS2UQD7BGeryz8ERZyZWh6cQIeRtbjgNC7ltup6FVzQI+OmcXGk5e/tI+lsTUv3r8+BjkU5KD8nZXjjqcRBOmnoOk0OfQCULZlRg9vq6ca/mCoeX6hEtkewcFQQ7dH9ROVIG2aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145900; c=relaxed/simple;
	bh=QEiALosLovqc7yLlBCwbeZxclFmLViVyOfgBejS+sUE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lQJtqwcUhQXhSIECt0oU6f3XnyaPN3APkEnkQqWtcp2+pnmbk3PkZnL1o3bLLDMA1v9ExxEwRLgrZeg2e+LxhiB8YkJjkNx4sEpF5oM6+KG75empvya2lrUgIzlpRP9YMNAs51lvVK6a7vRNYfk5Y/Y3d7x9RcEe/2Lall5PFxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=V+SeRZyF; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="V+SeRZyF"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA429344A;
	Thu,  2 Apr 2026 09:04:52 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 370113F915;
	Thu,  2 Apr 2026 09:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775145898; bh=QEiALosLovqc7yLlBCwbeZxclFmLViVyOfgBejS+sUE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=V+SeRZyF/P6jXLGZq1GkpVxR5yll9fft0pySAR39RObiH4Ux2qllq1HCoRR9k258W
	 9eDVc4BoxCTr7sCprHTG9mi7a30zU1nglJ+IqXD6mgC/FWNLwQy1NnpJodkVFcq5yq
	 5IumIyaWuqV31x8adTgVWW3EFyADI+5WLIb19HaE=
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 02 Apr 2026 17:04:48 +0100
Subject: [PATCH v2 2/3] perf expr: Add '\n' in literal parse errors
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-perf_fix_metrics_group-v2-2-1f9427a5d763@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775145893; l=1016;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=QEiALosLovqc7yLlBCwbeZxclFmLViVyOfgBejS+sUE=;
 b=f0pIB4u1amtKL8neDNnzsKwFXxUwONVPlIRT3cJkJCtMPFJzrarBSl7KdDalM7F8GYv2ftqyb
 fa0Xnv6k+GRCZgPjN6niLyxDwUoZ/SFWDvZAJ6lVTjP4Fv7cIkRcBN0
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Add a trailing newline for logs.

Before:

  perf stat -C 5
  Failure to read '#slots'Cannot find metric or group `Default'

After:

  perf stat -C 5
  Failure to read '#slots'
  Cannot find metric or group `Default'

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/expr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index b7664cb68554b284c2b64ca750bdfb114fa5515e..644769e927089ea1dd2f9252078c35a69fa48dce 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -407,9 +407,9 @@ double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx
 					 &count))
 			result = count;
 		else
-			pr_err("Failure to read '%s'", literal);
+			pr_err("Failure to read '%s'\n", literal);
 	} else {
-		pr_err("Unrecognized literal '%s'", literal);
+		pr_err("Unrecognized literal '%s'\n", literal);
 	}
 
 	pr_debug2("literal: %s = %f\n", literal, result);

-- 
2.34.1

