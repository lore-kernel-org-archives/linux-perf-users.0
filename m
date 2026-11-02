Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793654069;
	b=gdqPosZnnlGFHRiplMs3kNf/xQ6Jv4NQs8HtR2k+x9EmWSrIsAafWPPwF4PLTGMJcptV
	 kFf0kVSVbRXKL5Dojjvg14VwIFf0pDD1fDto2BtQ0Uf1EZmm8djkKSY+qHRslwbrRhyEy
	 t/NSV4GdtbRuPc2JzFCnPYDjr2p5aDy8R067qXFZm7jOiqmjiXdhfNMRNfFdFT2YV9eaw
	 qcKYpdrk1SMaaDMtpdSViZxTQkNb6bAQSLaIoGfydfTh3Xm5kMbq6xSIzE7oK1AdDZgnh
	 4SqPa52AwBJArKylskLaUa9ail2nXI7eO2exxFVVlBUcZMBKl9nc5wGzsEvG49rJnsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654069;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gyWsIZOGhAmg21n52Wtet/iHA6IBSj3zms1Jf8j6n0g=;
	b=MuS/dKZWxHEtybXScQ/FnlFClJPs5dS1ZnVtR+uWmR+6dLKV3TKeKYAurAvUtLDL/Rqk
	 X4ldGuY0rZd4I9tdOl0h3i1fw0TlE8WK5oPT/YOuoLPtsk2l1RkpZT1JjCXH8adeqsPE+
	 EfG0T6fnipG7fz7lCH9h+5U7O66P+zlGI9kXX5oA7NnpuP8DI3Z9We1Y3GsCXKWXn430W
	 yBUIP0pHVaF7hpU6hdKS9Fm30/1wK3C8hWL9yjg04HyetuqjdxxUNmkh9G2lRWb0zMQXE
	 frIiWdY5a4MYUhQJBg5nbgAZOOYfyJcMItz4R4thEiP8G2nyK9XZMC2qDuReoukwAXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LzEmiaO4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D86606A326;
	Mon,  2 Nov 2026 21:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LzEmiaO4
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793654069;
	b=1+HZK8njiO3VLoFfDfD4uMto8A0IpZELQavVSGRKzNZ1bofgE9Cy/mZVFt758+sVtT9E
	 1hR3C0YOPmCGjPh1KTXHwhfM5L7x4JImaA2gycnH1O/WcAabPWZySNwoSmLjUSwKcil94
	 k2Y96ZRFR9/BfNeNnWjzFX4XXMLECv79R2lmWalicG+8/vKyroTPNe36h01iBVw/YCd2W
	 Zniz47TqojOJ+O/y2SPmY/3LhOchFrCAKqRpmmvFIKNUpex/X1KslSmwDTDA7VTBzXg28
	 Ip9Y3UXNJ3EnGQ96HqSdokM/UN7VnA/wMOwPIXPRLBx27eT7vVrCEcmcYS0A4z4aaKA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793654069;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gyWsIZOGhAmg21n52Wtet/iHA6IBSj3zms1Jf8j6n0g=;
	b=ocojTYY6h13lb+CdZ83mk+P88ydzHRnOP0FOsRfcGm2U/ytiOeYJ7ovVGjRCbAioQgui
	 Wm8QYqHUkvhyHnzmJSVeYusz8knsB7BFMRoZMmZPP0i0EqWZi5nNw/mrixynCqPrLBVTz
	 DTJZz1iF0L+Sywye+KRQOibuKbSjR2MuS2GBKQuwH9U1Eer2j3BQeEPEpj36MWz1H/5eO
	 HYCuXbWO/k5wI4wNCW2+b3WL/7LKHcP29kS70BBeUgyKTE9DH60ZzqJ9/pLOx1G8EHtSN
	 rbQyHR6zDrwBAsaody1In/3R6pNZ6zQfN9oJrSBLKpWeoqeREg92PuMFRMPsQ6cPYoQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9220A1F00A18;
	Mon,  2 Nov 2026 21:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793654069;
	bh=gyWsIZOGhAmg21n52Wtet/iHA6IBSj3zms1Jf8j6n0g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=LzEmiaO4hYrvoD4H/0NzKBDQsLvUOjz8fGEVo44jjjdTbS2HF40WpoVl8OccJ+A5j
	 DFXwVKAjnkGPRB20F/P/lbMu7+met5Rh96XFPBG30msAJldSinLYUEqlEzJ4ijK27P
	 8fjDdF1xLsrr/898S5C75JxzLheu/HgIGgBe11aA27sDwxs3gKRVbwv/30kem8jbFp
	 gBZ9zrtgpfzFTtAwEO+BjMR5W37a+VUpvpB/9eA0qPCDBSsw0SrDhB4mKnk7hv9XVA
	 58vMvzzQfrx6XMi1UwieISjULPyHOAjEmPFH88nQ7XiTM4V2QGR78fMbvd7zPqYlew
	 SXLq76qNwE4HA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1AC9246686;
	Mon,  2 Nov 2026 21:14:28 +0000 (UTC)
From: Jacob Lefkowitz via B4 Relay <devnull+jlefkowi.akamai.com@kernel.org>
Date: Mon, 02 Nov 2026 21:14:17 +0000
Subject: [PATCH v2 2/2] perf jevents: add amd specific device table entry
 metrics
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261102-perf-tools-next-v2-2-4d237f886710@akamai.com>
References: <20261102-perf-tools-next-v2-0-4d237f886710@akamai.com>
In-Reply-To: <20261102-perf-tools-next-v2-0-4d237f886710@akamai.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ben Chaney <bchaney@akamai.com>, Matt Pelland <mpelland@akamai.com>, 
 Jacob Lefkowitz <jlefkowi@akamai.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2209;
 i=jlefkowi@akamai.com; h=from:subject:message-id;
 bh=liVzmx/OhcmtQ0v9uWwEdDDwpJFJAvmAPKfhOvaaGtU=;
 b=owEBbQKS/ZANAwAKAdLKfgzjwTS1AcsmYgBq6P0z1sUnsehURv0ALuYnX1+zEAwb5p3U5PjJv
 oEGb4ghktyJAjMEAAEKAB0WIQQKFmVpIhg7hFI7scTSyn4M48E0tQUCauj9MwAKCRDSyn4M48E0
 te7HD/0QD4bsU5JlUnn0wH2XgtqBjawzmQiqfUzZH9u9gN+d3nGBKQs5skQMG5TWckPPvVFczI5
 Q2y8kSwYY+yrmEn2g/9tf9i1yl8NerMFCKXYpObkSPRLSKXhg6q4EZ8xllUVz0LLpPUeqTJhzqR
 u185cvqeWB7CP3vCW2ataEdMCFVW1HXGg7Tk37LWtNtFsRU9kPcc8v4sVJZlzJfgqraGuehAQF4
 CjSTe4UalT0c78WC1TciXG5PFDoZG7J4OPwCz3uGSzFBmXP740b8nLvPHuT8/vYb4BIrv5t0LmW
 Sh45TxR2q8qFriuvAqsQy7a1Bgg8Ut57/n+8UJ1mHrR71sZo2EVKCBfJxk6cl0Krc6ar4Tr1n+X
 D2Y9bg1R1k/riX49n0rtDR7NavjFxrCADDXM/l64jEEs4gJi8GTxngBENu9FkKjBWaSMh69+lgn
 Dt0p9bvjTKaFnb9XyUq+JXkp9l5GhT0ZUud7ceouxRBBnUZM760JV67R8E+6FAtx01mIhcC+whN
 MsGu1wstc4QfHdC3JEaklajKtSSFbW42M9ArpCq9dilyr1FB/AakgKoXAqDsoCL634ARaCDKv8T
 WRt49feqhciT/ABIfTK3ZvgRQ2JNnHs0tHuyHfHfu8BKbh8VJfZEtp7mZyPrRXY7ckZkyp1/me2
 afyBcIWWeSccv1g==
X-Developer-Key: i=jlefkowi@akamai.com; a=openpgp;
 fpr=0A16656922183B84523BB1C4D2CA7E0CE3C134B5
X-Endpoint-Received: by B4 Relay for jlefkowi@akamai.com/default with
 auth_id=1357
X-Original-From: Jacob Lefkowitz <jlefkowi@akamai.com>
Reply-To: jlefkowi@akamai.com
Content-Transfer-Encoding: 7bit

From: Jacob Lefkowitz <jlefkowi@akamai.com>

Adds AMD specific device table entry metrics to perf jevents.
These metrics are only allowed on Zen 2+ processors and are
implemented using the 'amd_iommu' PMU events.

The list of metrics added are:
- lpm_iommu_dte_miss_rate
- lpm_iommu_dte_lookups

The metrics were tested with the standard 'sleep' workload:

perf stat -M iommudte --per-socket --metric-only -j -a -- sleep 10
{"socket" : "S0", "counters" : 8,
"lookups/s  lpm_iommu_dte_lookups" : "4117.3",
"%  lpm_iommu_dte_miss_rate" : "0.0"}
{"socket" : "S1", "counters" : 0,
"lookups/s  lpm_iommu_dte_lookups" : "none",
"%  lpm_iommu_dte_miss_rate" : "none"}

Signed-off-by: Jacob Lefkowitz <jlefkowi@akamai.com>
---
 tools/perf/pmu-events/amd_metrics.py | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 452b88033492..fd0bd9f16529 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -318,6 +318,35 @@ def AmdIotlb() -> Optional[MetricGroup]:
     )
 
 
+def AmdIommudte() -> Optional[MetricGroup]:
+    if _zen_model < 2:
+        return None
+
+    dte_hit = Event("amd_iommu/mem_dte_hit/")
+    dte_mis = Event("amd_iommu/mem_dte_mis/")
+    lookups = dte_hit + dte_mis
+
+    return MetricGroup(
+        "iommudte",
+        [
+            Metric(
+                "lpm_iommu_dte_miss_rate",
+                "IOMMU device table cache miss rate",
+                d_ratio(dte_mis, lookups),
+                "100%"
+            ),
+            Metric(
+                "lpm_iommu_dte_lookups",
+                "IOMMU device table cache lookups",
+                d_ratio(lookups, interval_sec),
+                "lookups/s"
+            )
+        ],
+        description="IOMMU Device Table Cache Metrics"
+    )
+
+
+
 def AmdIommuptw() -> Optional[MetricGroup]:
     if _zen_model < 2:
         return None
@@ -570,6 +599,7 @@ def main() -> None:
         AmdCtxSw(),
         AmdDtlb(),
         AmdIotlb(),
+        AmdIommudte(),
         AmdIommuptw(),
         AmdItlb(),
         AmdLdSt(),

-- 
2.53.0


