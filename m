Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793654069;
	b=lowyfG8LcOPejDCHMHsmfGKk9UVM4mwTZFg5503Uf0Z1jeaIS4z0rbYGbYOnPdEMJtnw
	 cW2i1cx8XA6NUsi8KyVN2F1+UQuRLEsiq6WO1RDTXEZKm/lRSyoVrGr+TgU64i+l2t3Mv
	 BInYdj1sEw+M0kXe7bQ25X0d3uQAnak9UNjiZ102n+ZzuJ8Fh6g4anCmK84GWV/lxdWiy
	 t8/hbhPCNHP919/K77sQvtT6kuxtgRXHXob1QvZ+Gsy1XiJsw2j/kY+vy0Opg5+Qsv7XM
	 hFbukQVNMDx4nCVJhICxrQbY1f4UxKZT9W6FiLhmSHQAwMeNNJ2s4RvNN1uri8Pbkog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654069;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Odnk7WgHn5U8Xk5ai/aYpT0eWB4gdIOVafLZ8UKejdM=;
	b=hZ1oVhTynH4fc2+NNM4XjS/hqFJu8rb2m2ZOa54iUbcJKU9yyXf9kEqWonY7SyZN1YO0
	 AhZdurZMtMv04dX9KXyc4ycEBqEUjB2bY3HbiFvIPnCt/r6ym0teiOuifFdIw+3nEkhrs
	 5voKh4KgmMvGUc8gCX3vHP4ZGoKcYoDbUzpKf1CLAhRoQ8Gahfz4h5fRUHSxizH+vOeyM
	 5lRPo9lwV7P0QMCk3MkvdEADrUdNL4Mmv7XC6g5piQiHYKjO82q4sRnuwzZpC1n5TZCVl
	 VN/SdBBtRTe/6yUw3XyS9bQWUsOzI6y44yNIMlnCXmqCmkAKfxYh99Y/WGEB+HtCaRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gnWXY2M8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E46606A32C;
	Mon,  2 Nov 2026 21:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gnWXY2M8
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793654069;
	b=W5A7KZA5+S0Rk9ogT1go96ciR9cPUE0jGzsnBJKbUwT5McFx7O83lNqplNhWNFehRj1v
	 VarcTCyc8pkGEniKt7btW+HZyDGXtwRN52oeoBSoiF4NBf6DGDtWrldBOCfH0U9+vyo2R
	 90wgIInIW2AZi+z3hUhDDrFS8McxG4+TFZahi8V/HdsSNInaAcNICn+V9AFBKCehh1Iie
	 EXgvCwpu+OqKvteKYfUaLyOU+/B3V4p2ornc4WKMVnbJfouh8B6wBNqu9doMAzMlBsSuc
	 hIRCIchHrOUnuIeOARisyVc0e7co6/OfAsIgkwvH+ceD9dk8T0RKHDFpbfnPrpZsDYg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793654069;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Odnk7WgHn5U8Xk5ai/aYpT0eWB4gdIOVafLZ8UKejdM=;
	b=qTMmn8WBUoTVJXkWm6AceEiCf0EAcckWZXzBpZnXCBh2LihOEEmy1OQle5c5UZeEqcAt
	 OhGhdwqDU5h8dJSXLsZbaq0HjwYv0/YsrHpTJgheyKZpvXGWq8giqozzlZj2VTYz6lImi
	 DrlE7it8exLR+QBFhy2Ig/FwKOxiB/HLHoW0B/U59MOD1xaFtpSscS4Q5Mxpn6i4lPq0g
	 o/nKnowTyMEqCFbVkgono3gH6o+nzrHzKPcCKaKO+iw1LySuLz/CzZb9+xCnXGCZ8unov
	 HwroES4gijcVSrMW8djy5vosBksjGfMJQbHwRQTxU251x3f1nFMZfGJS7yC4C6AkEmA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8CD221F00A17;
	Mon,  2 Nov 2026 21:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793654069;
	bh=Odnk7WgHn5U8Xk5ai/aYpT0eWB4gdIOVafLZ8UKejdM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=gnWXY2M8+hOF/YsgY3ARQZsDLSInhFdUK6ovBynIIRxSyC+hHnQ+QFhzyldfL3Ab8
	 68TqYeNzaYqTqs1kF4+Z4EYPn7i6XFhk4WVkZCQrayiyJTtXspX3Ftk7wylknN6pzy
	 3m2uoO+o/hKAyaXPPCJJukvG62ApEme8xGjfArbJjrbiQoMjo8RGjb0FG1zyVoOwf8
	 sMRQTv8TxqlvuTaL/bbl/T8aJ+HQYFQzCr5z7umBR6tNVpiaimcVDoHQ1qIMf8ZeR1
	 Y2N9MvDV42xGzRWTzH/d1hsWW+gCPXavdzTHtCXS5inO4LDFySUZ4OJzCZxFbD+8kW
	 +a7HGF2QIPnmg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0E2F446645;
	Mon,  2 Nov 2026 21:14:28 +0000 (UTC)
From: Jacob Lefkowitz via B4 Relay <devnull+jlefkowi.akamai.com@kernel.org>
Date: Mon, 02 Nov 2026 21:14:16 +0000
Subject: [PATCH v2 1/2] perf jevents: add iommu page table walk metrics
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
Message-Id: <20261102-perf-tools-next-v2-1-4d237f886710@akamai.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3362;
 i=jlefkowi@akamai.com; h=from:subject:message-id;
 bh=o+fTHAReSL+rEvSd6OyDxXB8zlYMgzMiuuHLzYKbvtA=;
 b=owEBbQKS/ZANAwAKAdLKfgzjwTS1AcsmYgBq6P0yeccUtD2GLhej/d2Lavjp2eNUncZ012Hbe
 GNY/SMVB1eJAjMEAAEKAB0WIQQKFmVpIhg7hFI7scTSyn4M48E0tQUCauj9MgAKCRDSyn4M48E0
 tRJED/0Sba2qk0SsG8L3HcbaWylkq/NbfhGCI8nOYlremFZXTbIuAg3+CLg8cM0hChvAqfhkNll
 K87NzMDOwGdEgkRPngmFdHlBClMRXU8bGGMeMOFiqYX/uCnOkgZBJdCxwBrM4kDMweXZeU1pNMc
 rapnrsIvkNOamrOUAHFV62r9G+RI0oTu58JGSwSlDC14YsNBULXG2LDwuwT+Yz9hCicFjdLQFxg
 ACeFHxf6vRGZ3CdKFVTnU+91EP1sWfVZ72vccn+a8yaR/iTGjlVLU9vFPIMuvfC+v4k0T3qdjqr
 t0JPvpaDIEDPNzWN4mkWngP9eDdaBtKl6nBUeANXkziGwqscrU4ubuzP4bKJ8BzL9FABJYcDIx0
 IC8BdXAp+ZcTmJMCnSHUHAB4RiUAFs2rDaPudGfhySZZer6ucR96kLhyipGHIVKBI94bRhbthIF
 Wsg4lRbbSdwR+XBNLPe80Exz3p8fvWnkEWqPCps0+JNKE4RMkd8v8zj7eWEgyDyfWnt/QfmoCmj
 aUBLVQvrdxKCyOMwFons6T8jsemhJH2p/k8nerKf3ZXNgTlFCT23ROoqtby0lNosw9vq36znJvo
 7MT+4ZPqON5YozilW+iUwgcEIxtHUw0mfly8Bp+GhBe77QtZGYtMh6M2k1yMD68PfrzM6eF1Q80
 9NfTGqngAr2hiVw==
X-Developer-Key: i=jlefkowi@akamai.com; a=openpgp;
 fpr=0A16656922183B84523BB1C4D2CA7E0CE3C134B5
X-Endpoint-Received: by B4 Relay for jlefkowi@akamai.com/default with
 auth_id=1357
X-Original-From: Jacob Lefkowitz <jlefkowi@akamai.com>
Reply-To: jlefkowi@akamai.com
Content-Transfer-Encoding: 7bit

From: Jacob Lefkowitz <jlefkowi@akamai.com>

Adds page table walk metrics specfically to perf jevents for AMD
platforms to enhance observability into IOMMU overhead. The metrics
are supported on Zen 2 and neweer processors. They are implemented
using the amd_iommu PMU events.

The list of metrics added here are:
- lpm_iommu_ptw_reads_per_tlb_miss
- lpm_iommu_ptw_nested_read_ratio
- lpm_iommu_ptw_guest_read_ratio
- lpm_iommu_trans_per_sec

The changes here have been tested with 'sleep 10' as the workload:

perf stat -M iommuptw --per-socket --metric-only -j -a -- sleep 10
{"socket" : "S0", "counters" : 8,
"reads/tlb_miss lpm_iommu_ptw_reads_per_tlb_miss" : "0.5",
"%  lpm_iommu_ptw_nested_read_ratio" : "none",
"%  lpm_iommu_ptw_guest_read_ratio" : "0.0",
"trans/s  lpm_iommu_trans_per_sec" : "971.5"}
{"socket" : "S1", "counters" : 0,
"reads/tlb_miss  lpm_iommu_ptw_reads_per_tlb_miss" : "none",
"%  lpm_iommu_ptw_nested_read_ratio" : "none",
"%  lpm_iommu_ptw_guest_read_ratio" : "none,
"trans/s  lpm_iommu_trans_per_sec" : "none"}

Signed-off-by: Jacob Lefkowitz <jlefkowi@akamai.com>
---
 tools/perf/pmu-events/amd_metrics.py | 45 ++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 42569b9153f4..452b88033492 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -318,6 +318,50 @@ def AmdIotlb() -> Optional[MetricGroup]:
     )
 
 
+def AmdIommuptw() -> Optional[MetricGroup]:
+    if _zen_model < 2:
+        return None
+
+    walks = Event("amd_iommu/mem_iommu_tlb_pte_mis/") + Event(
+        "amd_iommu/mem_iommu_tlb_pde_mis/"
+    )
+    pt_rd = Event("amd_iommu/page_tbl_read_tot/")
+    pt_rd_nst = Event("amd_iommu/page_tbl_read_nst/")
+    pt_rd_gst = Event("amd_iommu/page_tbl_read_gst/")
+    trans = Event("amd_iommu/mem_trans_total/")
+
+    return MetricGroup(
+        "iommuptw",
+        [
+            Metric(
+                "lpm_iommu_ptw_reads_per_tlb_miss",
+                "Average IOMMU page table reads per IOTLB miss",
+                d_ratio(pt_rd, walks),
+                "reads/tlb_miss"
+            ),
+            Metric(
+                "lpm_iommu_ptw_nested_read_ratio",
+                "Share of IOMMU page table reads from nested (host) tables",
+                d_ratio(pt_rd_nst, pt_rd),
+                "100%"
+            ),
+            Metric(
+                "lpm_iommu_ptw_guest_read_ratio",
+                "Share of IOMMU page table reads from guest tables",
+                d_ratio(pt_rd_gst, pt_rd),
+                "100%"
+            ),
+            Metric(
+                "lpm_iommu_trans_per_sec",
+                "IOMMU translation requests per second",
+                d_ratio(trans, interval_sec),
+                "trans/s"
+            )
+        ],
+        description="IOMMU page table walk metrics"
+    )
+
+
 def AmdItlb():
     l2h = Event("bp_l1_tlb_miss_l2_tlb_hit", "bp_l1_tlb_miss_l2_hit")
     l2m = Event("bp_l1_tlb_miss_l2_tlb_miss.all", "l2_itlb_misses",)
@@ -526,6 +570,7 @@ def main() -> None:
         AmdCtxSw(),
         AmdDtlb(),
         AmdIotlb(),
+        AmdIommuptw(),
         AmdItlb(),
         AmdLdSt(),
         AmdUpc(),

-- 
2.53.0


