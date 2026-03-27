Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD0028726D;
	Fri, 27 Mar 2026 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774632337; cv=none; b=ZQ05RDAIZAl4PchpFSUwwqAEsG3i7zLO427HGKrg9im3N+Tjn62FW9i7EhXR/y82mDPz1UCcAIRSGq+0jm3v0A5iVd4Ly18elOJZpoBGMDrIjUphhjujy7BivhfBBQMvWiOO0JZp0yKvqCXWcFSPon/N+cyRqbRbdir1zvJyA/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774632337; c=relaxed/simple;
	bh=BtmBe1lZNU1bmJI1iYVGd2tNmnmFPMHpX8Sj3GHYJnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XulhV4xonyvetnFzZD/49Ib5M9heh2CUYj/BRWwvni7Trgi/iCBSnHwLKddS2Qw52JmgYNdU8qYwMC6OcBSZu4GJHTlelbZuombvA2gWj/RckKVtjI2rskIx5gRljIm8gQ2FSMbTN7S/rjsIFHOYzJgYhJdDg/wRjrznc/RKk6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fGIsnlVe; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fGIsnlVe"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5BEF35AA;
	Fri, 27 Mar 2026 10:25:29 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C9283F99C;
	Fri, 27 Mar 2026 10:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774632335; bh=BtmBe1lZNU1bmJI1iYVGd2tNmnmFPMHpX8Sj3GHYJnU=;
	h=From:Date:Subject:To:Cc:From;
	b=fGIsnlVeEkRwKVXxZK9lGRCF1508s8drUaTLxqNAEBivjVDf525bOsdf0GAu/4rbC
	 B4TiDGKr3mXJk/0TCv2xSizqPtOe8slf1m7dVajQB+/uGsLDBKJJO7TJoqMHPatdPq
	 SPyg3Af131xLL+VzNjd1SOtgjpFqDNVVPM0ZYdxA=
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 27 Mar 2026 17:25:27 +0000
Subject: [PATCH] perf metricgroup: Correctly return syntax error
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-perf_fix_metrics_group-v1-1-49e4b8ee9a08@arm.com>
X-B4-Tracking: v=1; b=H4sIAIa9xmkC/x2MWwqAIBAArxL7nWCaRl0lQnqstR+VrBVBdPekz
 4GZeSAiE0ZosgcYL4q0bwmKPINx6bcZBU2JQUllpVaVCMjeebrdigfTGN3M+xlEOaAxg9LW1xZ
 SHBiT9I/b7n0/HO+G3GgAAAA=
X-Change-ID: 20260327-perf_fix_metrics_group-4be55b236f96
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774632334; l=1840;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=BtmBe1lZNU1bmJI1iYVGd2tNmnmFPMHpX8Sj3GHYJnU=;
 b=TSHI8bydyKho0Ecn/MjJgb4aSfddoGg0K/At3XmRqd76bd5UDYAjG4tR9PFlI7DASq3SEgA2i
 y9QAomrb94yBmoPUrtCJS2LcgvfDKjOt3W39VmkTjfGPVC2E8TjdKLE
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

On arm64 platforms, some CPU variants return zero for the number of slots
when invoking tool_pmu__cpu_slots_per_cycle().  This leads to metric
expression parsing failures, e.g.:

  metric expr 100 * (STALL_SLOT_BACKEND / (CPU_CYCLES * #slots) - BR_MIS_PRED * 3 / CPU_CYCLES) for backend_bound
  parsing metric: 100 * (STALL_SLOT_BACKEND / (CPU_CYCLES * #slots) - BR_MIS_PRED * 3 / CPU_CYCLES)
  Failure to read '#slots' literal: #slots = nan
  syntax error

expr__find_ids() returns a positive value for syntax errors, but this is
not respected.  Fix this by checking for any non-zero return value from
expr__find_ids().

Do not add a Fixes tag, as this is a rare case that can only be reproduced
by deliberately setting the PERF_CPUS env variable.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/metricgroup.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 7e39d469111b2995f5a2636529d6985eac595f76..1119bb1c99dbd9d32601b8aeebed7d5638872366 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -909,10 +909,12 @@ static int __add_metric(struct list_head *metric_list,
 		expr = metric_no_threshold ? pm->metric_name : pm->metric_threshold;
 		visited_node.name = "__threshold__";
 	}
-	if (expr__find_ids(expr, NULL, root_metric->pctx) < 0) {
+
+	/* The expression parser returns a positive value on syntax error */
+	if (expr__find_ids(expr, NULL, root_metric->pctx))
 		/* Broken metric. */
 		ret = -EINVAL;
-	}
+
 	if (!ret) {
 		/* Resolve referenced metrics. */
 		struct perf_pmu *pmu;

---
base-commit: 54fcc7f6ec3944ae7c1b0246a999744e33839cdb
change-id: 20260327-perf_fix_metrics_group-4be55b236f96

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

