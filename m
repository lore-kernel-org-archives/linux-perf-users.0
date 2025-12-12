Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B142DCF57;
	Fri, 12 Dec 2025 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765543459; cv=none; b=LAXw3NF4uk2oEEGP1Wj2VMhuw1yYCufpUE/oL4yKYV5NMFQGga7idMNvU5046sInRm5xOECt3Q7Kkx9gr1eo0zKqGWEOt7OZhtpETyKXHm4kiel28rBI06wCreISqtZZDKF4cK61mAhbyT8dsWvrwfV1YCyohP9tIoDrsEVNO2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765543459; c=relaxed/simple;
	bh=sp+2q6qeoU0+pjYU9fNG2ACBWigW5kP1p4wDjC597s0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lSubseOyyLR0nqubt0DuL3cx3Z6pb/cAG7j4TXu+WJ7WpALWuijfeBpg/+q4yphKDUH1wItkQeUyVLEXfPUQZdlA/boQ3Jw/slpvV0uBi6zm6kN4e8m66G6CZi8H6eZHqkCCdIBOh1E2NTLL5fqLik0JvWyMjM75ul1mnDCRh/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A6C81063;
	Fri, 12 Dec 2025 04:44:10 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5983A3F762;
	Fri, 12 Dec 2025 04:44:15 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 12 Dec 2025 12:44:03 +0000
Subject: [PATCH 1/2] perf mem: Simplify Arm SPE event config
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-perf_c2c_update_event-v1-1-29a26c7a949b@arm.com>
References: <20251212-perf_c2c_update_event-v1-0-29a26c7a949b@arm.com>
In-Reply-To: <20251212-perf_c2c_update_event-v1-0-29a26c7a949b@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Al Grant <al.grant@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765543453; l=1229;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=sp+2q6qeoU0+pjYU9fNG2ACBWigW5kP1p4wDjC597s0=;
 b=WtTBLg90hz4iozrcKt/DR2JMlbDo5seVwB0gJbLVV0qhcSov+byYDDyNoEyXcWhI2r4ETJVrm
 RLh5i2/PnzyC6mySa4WrVn0Yv1krPhLQ894CyHDDjowSTMbFaN/xKH5
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Since configuration fields default to zero, the zero assignments are
redundant, remove them.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/arch/arm64/util/mem-events.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arm64/util/mem-events.c b/tools/perf/arch/arm64/util/mem-events.c
index 9f8da7937255cc9b14c3c58a1119b40bd0c76f6b..eaf00e0609c6c1b7d939a02fe3794471d1ed119b 100644
--- a/tools/perf/arch/arm64/util/mem-events.c
+++ b/tools/perf/arch/arm64/util/mem-events.c
@@ -6,7 +6,7 @@
 #define E(t, n, s, l, a) { .tag = t, .name = n, .event_name = s, .ldlat = l, .aux_event = a }
 
 struct perf_mem_event perf_mem_events_arm[PERF_MEM_EVENTS__MAX] = {
-	E("spe-load",	"%s/ts_enable=1,pa_enable=1,load_filter=1,store_filter=0,min_latency=%u/",	NULL,	true,	0),
-	E("spe-store",	"%s/ts_enable=1,pa_enable=1,load_filter=0,store_filter=1/",			NULL,	false,	0),
+	E("spe-load",	"%s/ts_enable=1,pa_enable=1,load_filter=1,min_latency=%u/",	NULL,	true,	0),
+	E("spe-store",	"%s/ts_enable=1,pa_enable=1,store_filter=1/",			NULL,	false,	0),
 	E("spe-ldst",	"%s/ts_enable=1,pa_enable=1,load_filter=1,store_filter=1,min_latency=%u/",	NULL,	true,	0),
 };

-- 
2.34.1

