Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793300771;
	b=ExlvtCnxkQF5+yvBRoefcS6mgqiQohVsPdMsu67MFVkiR/oqk9D6/urqygwBLq3Q6mFC
	 w4zoiEP2hBUMVzk2FPLfpL1ZZPu/2JbIRkOA/vLG1HAEXWvgYSIeipGLACbEQLlcnX101
	 bJstzpyycKs2t00c8s7mbDs8dDl8uYOz+HYE9DsbX7zaFzw6w6h/zZp1CnQIckNmStQzh
	 ZB9rQTZrk2sXkvRa1APsYRpbvagknvjbOd0tWgCZcz7aGA97RMQ4djgMeFSKN200n10OT
	 8lpKl2OClQupeiqqdiyPmNLLmLHHifWgFESBSmyX9WMkYn5tvnjx3jqaECL5vHYXESA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300771;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AXw7KqKlH2Rz3/pp3rDwURQ2YoHMR/NaxAMWXBtsNiU=;
	b=jOSaNe1w4H8l8m2r7iuq3DsUCo9QJhnfVyvJBWvqh9nzJ4uqOGPQ5G6BLGxfUqDe+uhM
	 QDYzaU7hY3pao6urSKEtmPnngbD8QV8wpdfblZnA7sQ1xESKXEqJM/5WWi1yY2biMdJcM
	 1sulQgAi1Yp/6NAqc9qHm+IahLAcDi6GNkms2CtPLSxa91k4I7ncSfsOuYLzwXo5W/xyQ
	 Uy8nTL5osAlyY+J+020MZsguVeaVWLmHcq6f9HQUL11Q37aHuOeNilg8jj1jQ/h+USPcb
	 Z9nBeTt8uof3F8bY7UbzI6TghYY2iUdKFj2QYIIug1EkV1Pai7eAMKMTtm698DO2V0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kd0M8Giu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0865D606A31D;
	Thu, 29 Oct 2026 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kd0M8Giu
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793300770;
	b=FvTd1HuhYnGED9Gk+8PY5A0OojBJJMKNBdyXrSaWoug0X71hh0AKbwxve8avnwsNRbEb
	 rL60yFzwLjWHmvfm362rWPIevyn3RIWpiKCMSdU1IB+46AueswS4kTlThRld/Rm7NrYSz
	 g0Rvt9OEnEEwiFFnQCBx2NNX+0lq+ekyklTsgUYwJmMk4YDfXnuGRpvleh2dmMamwdXIB
	 iE52zRX/UbMYAPLGngIXFqDk2ZeOKAyfnAkhbJS4k6FXmT6UwEdmnVOheWyFh552Bh4EB
	 0vYyntoOy4iEL9+Z0aq6juP8eNenDH2dd6EMMj7cvreWI4yfCWo74/7CcrCHfSmP3Uw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793300770;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AXw7KqKlH2Rz3/pp3rDwURQ2YoHMR/NaxAMWXBtsNiU=;
	b=3mRUrst0HHRme3PzPjJb0CeXio4QqYQnjQVr2N254QMSni0eQZbFtAP7wvQV1EfgMu2w
	 tvEaoCdoOG0DMJVLWNS3OMcdHKtnb3tBOr4s4J+p/E530dZN9pUnKf76lBDmmJo5z9fNV
	 Ul0euUiUJTfyV6ATHL63P5RtloNO7S5PkCHuqR5d98HwWi+cGJVAwVR8/1Foz1k4qbold
	 XkeeL2DRf28p7WXpToBo+BuPa9WMNBBBzxrRjsvHQvDXtbRAm3AjoqGi7A20zb5qXITfk
	 xmpfwzkx1pH9AH9amkPeVbqJIJv99K9C0R6Kv0DKMCqshOlB0aXauLJDJpzFOYyygLg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5E37E1F01824;
	Thu, 29 Oct 2026 19:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793300770;
	bh=AXw7KqKlH2Rz3/pp3rDwURQ2YoHMR/NaxAMWXBtsNiU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Kd0M8GiuQL7UYdJslWJOfRLao3hzcjOJSqi9ItDPIC6CGk2FQ3tRAiUDVFHvoP44+
	 yjz4btnDohv5as3Tn0iBq8lWckD6OaiY+5vgtRMYgvSxLLnW/tLnwIhtEa1ZKDQ9V/
	 EdqTUTZhucsw2+RBElpVSaVTBCKBAO28UpEpOO3Xkv127Ltcm8l54ovjRVueZLsd08
	 u8Hg3ImmUIGVd1CeHdIi0tReH/3M7jm00KaFacmqJytEeMKBCXIAezJpR8zrYxOwXf
	 HeB6XF3eYdAssoiNzjqVSTJtZxReTiLV9eauGXxWMqwzNFr74YBRJ1t03M1RsEDW0M
	 Aqm7K9pqXnl2Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E503C4597E;
	Thu, 29 Oct 2026 19:06:09 +0000 (UTC)
From: Jacob Lefkowitz via B4 Relay <devnull+jlefkowi.akamai.com@kernel.org>
Date: Thu, 29 Oct 2026 19:05:51 +0000
Subject: [PATCH 2/2] perf jevents: add amd specific device table entry
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
Message-Id: <20261029-perf-tools-next-v1-2-a75a2b64a15e@akamai.com>
References: <20261029-perf-tools-next-v1-0-a75a2b64a15e@akamai.com>
In-Reply-To: <20261029-perf-tools-next-v1-0-a75a2b64a15e@akamai.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2229;
 i=jlefkowi@akamai.com; h=from:subject:message-id;
 bh=j4bLiCRAXsXoexcyXQbQXPZqcKbIv4MvmP2HUvoUwU4=;
 b=owEBbQKS/ZANAwAKAdLKfgzjwTS1AcsmYgBq45kgqdp0MDUIlJfWPZQb/ObKYF9NTM7vQwqVq
 O4KeEz/zbyJAjMEAAEKAB0WIQQKFmVpIhg7hFI7scTSyn4M48E0tQUCauOZIAAKCRDSyn4M48E0
 tchWEACGQOvH0tHCJZQYAb4tfQ5W50rZqb0H7Zl60m9LMM8jK/GIYCnL/0YGXolGQWmt82Ed3Z7
 i6StigFwOmKNZfgtheMMfsv6aHVT2CBDkZBCdpEomPZ5ur8HDPk4TOlN5q5uYAzLeWjh9Cb/eJS
 TrgTVLOXKb7xjDzxFTWNcWeOVuggpkHXzLdf+Aeqa8n/MnqojyNUMLrPeP+nqVI7evlbZ0mXudo
 O59eudHMcwRHjSCPEkuccrKKG3r6wj60g8ypUoqK3yjLDTA3nxXUjv4UsqldlNEgn4khiIEb3EY
 Q6jjFKm5rlfUBl6uMAbXPuMp6JRxdWl1+F48yN6BYA2XvpayvBgn7a8VeCkR1phNk21FB9bqhGi
 UJ+nVqVGlEz0SFnT4qbGSEISC9N6qzo6eQ3jMO1w4m1v83w914QLxBapQp3oAhQxe9JtEO4IWsy
 m7L0zPyHcOcCwuSOFfJbCEpxhjFbUgLAJxEpjAERucwBrkRoVenqXU3JsxN+GhGcrS31WpMeOyq
 eaMNG+Ao96p4nTFqqKqbIpeNynhuH/+u4nQnF1z+OpylXVEjEm+ffx+i2wUk/BxaqUyLPIBG6G6
 Lp6Nw0nzpCNW4DsgZOFmQyWP8z8AI40SZzrUIOO9R4/qim/ykImw2jIVXla1vBynNOSCnGLKS0H
 9pFiy1di6We232Q==
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
"%  lpm_iommu_dte_miss_rate" : "100.0"}

Signed-off-by: Jacob Lefkowitz <jlefkowi@akamai.com>
---
 tools/perf/pmu-events/amd_metrics.py | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index dcffd6e268fa..912bceb57d67 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -318,6 +318,37 @@ def AmdIotlb() -> Optional[MetricGroup]:
     )
 
 
+def AmdIommudte() -> Optional[MetricGroup]:
+    global _zen_model
+
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
+                min(d_ratio(dte_mis, lookups), 1),
+                "100%"
+            ),
+            Metric(
+                "lpm_iommu_dte_lookups",
+                "IOMMU device table cache miss rate",
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
     global _zen_model
 
@@ -572,6 +603,7 @@ def main() -> None:
         AmdCtxSw(),
         AmdDtlb(),
         AmdIotlb(),
+        AmdIommudte(),
         AmdIommuptw(),
         AmdItlb(),
         AmdLdSt(),

-- 
2.53.0


