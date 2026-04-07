Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2F3347BBD
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Apr 2026 20:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775594380; cv=none; b=Y0RIKJALys2qC58HlSAGDrBPJBlTVi8SrRB4OswnZfqFoUF+QSa++Fj8cvvk5TUjM+fPTTD15MYOMZSw1g2Nwu0rSjT00owXqh34ZMGrT89z/RiHNxPL2eI+JjsrcQt2K/EQGagPCkXthvdeUahttB5Eq9lcTENkTloiELE0vo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775594380; c=relaxed/simple;
	bh=qfQlCrwcd7V/Lgyy7of4i6EnWpoN8CvFvTdbIHdZD88=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J/HGDc54FL+OHKqFAO+fB9+5S6jNCE4v6fyT+bm6C4QBmi8voclxKP0TgPPPztX3ZdgCu9DuxQAs6EtybT/ksPw0T2mHVtWRV40c+laQKzCWM34NYAIY5XcnSiNTKnAqRxrwS99Hw/Ia3KrM/ADijUL6CKU4VaekmP4i8hIzUF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dX4gJvWs; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dX4gJvWs"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2cc75e79b97so24446685eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Apr 2026 13:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775594378; x=1776199178; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6+zbvbE5zu1nyMUeEn8sV/Np4P7VcDcjdDMhWQKoykU=;
        b=dX4gJvWs3kE1MdnxJYVnDtk/l9olzOGbKcfwnECP1B0IEYHgUjCcpeHNzIgySF/Cnu
         CpRemc1jvatijZXYG8LxxT/JAWQtL8UV8H0ACOSHu5lG1kEm4EcRxCYYIW4vAlzVUsRi
         QiITDkWPpBkoJxM39BWDVofpChYvyZugPfDXw7Tb2cShskML4z8cJKjY9bLVa0EcKZ0S
         Udcv++4QuKNQ9607Nlet6ZlMCZQMT495POeNmPDXgImNJ3aqFSqccpF/FcpJFWML2ZMW
         OybiKVUf5ValDsy8jwLkdsNqJ49mck9ASTCxCYUxIO/s9tkqmaJcaYICVXRokOVb2dJ8
         863Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775594378; x=1776199178;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+zbvbE5zu1nyMUeEn8sV/Np4P7VcDcjdDMhWQKoykU=;
        b=WXF6DxkUub3BUudISAou80oFvxDLNkmw4hVMoczdTzcagZ9guLYlbEpKHOlg6p97f1
         YonsqwYyhcNHa9+0Muv6EImWITjKUXZ+/wdQZWGXkBGDQoUf20v6MQtUr9Clx/v5I/+o
         m2351oqsrJ6T63OMFKbYTOXdOgREKSmF9hfQM54dCkapVwoYrVWJAw6GHLPwIMW6T/zg
         UmyR/33e0xvpRk8fo/u1X3lZBV3mAlGsCLwN/BwLrRPoZ58t9kRDROIkY/yQjeCAEsuq
         qozCf4duazJyqvhpHP9RxxlOBxP333BuGSrCTH7JMMmVyGFVqLpL6xmwWtsqhNkfTm1y
         kZaA==
X-Forwarded-Encrypted: i=1; AJvYcCUDq8hzLo4slw5nhHBFzpUxB+n1WMzs4cUJarzAuQoD9m3J/pugrrqxy3kFvf4woZW617kklNZfOMZhvL+tYT2e@vger.kernel.org
X-Gm-Message-State: AOJu0YykghNK+bkKa4F3fsfC28QkF3RwcKRDG0UqNTKf0x9pxRknJ2kt
	ouVy8ssHi4RzRSkXyc1ihJ4loaobjMwJfbpEI/0sBXC/hGEJpIPgzj/bTIkjfr7gQOBBS+cAYTP
	KcQCQfw==
X-Received: from dycry1.prod.google.com ([2002:a05:7301:1001:b0:2c6:af43:29fd])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1688:b0:2cb:de38:c76d
 with SMTP id 5a478bee46e88-2cbfcb558f5mr8276208eec.30.1775594377816; Tue, 07
 Apr 2026 13:39:37 -0700 (PDT)
Date: Tue,  7 Apr 2026 13:38:43 -0700
In-Reply-To: <20260407203918.3178481-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407203918.3178481-1-ctshao@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260407203918.3178481-2-ctshao@google.com>
Subject: [PATCH v5 2/2] perf pmu intel: Adjust cpumaks for sub-NUMA clusters
 on Emeraldrapids
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, Zide Chen <zide.chen@intel.com>, 
	Ian Rogers <irogers@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, ravi.bangoria@amd.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Similar to GNR [1], Emeraldrapids supports sub-NUMA clusters as well.
Adjust cpumasks as the logic for GNR in [1].

Tested on Emeraldrapids with SNC2 enabled:
  $ perf stat --per-node -e 'UNC_CHA_CLOCKTICKS,UNC_M_CLOCKTICKS' -a -- sleep 1

   Performance counter stats for 'system wide':

  N0       30        72125876670      UNC_CHA_CLOCKTICKS
  N0        4         8815163648      UNC_M_CLOCKTICKS
  N1       30        72124958844      UNC_CHA_CLOCKTICKS
  N1        4         8815014974      UNC_M_CLOCKTICKS
  N2       30        72121049022      UNC_CHA_CLOCKTICKS
  N2        4         8814592626      UNC_M_CLOCKTICKS
  N3       30        72117133854      UNC_CHA_CLOCKTICKS
  N3        4         8814012840      UNC_M_CLOCKTICKS

         1.001574118 seconds time elapsed

[1] lore.kernel.org/20250515181417.491401-1-irogers@google.com

Reviewed-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/arch/x86/util/pmu.c | 56 +++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index 938be36ec0f7..3743f5145505 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -30,8 +30,9 @@ static bool x86__is_snc_supported(void)
 
 	if (!checked_if_snc_supported) {
 
-		/* Graniterapids supports SNC configuration. */
+		/* Emeraldrapids Graniterapids support SNC configuration. */
 		static const char *const supported_cpuids[] = {
+			"GenuineIntel-6-CF", /* Emeraldrapids */
 			"GenuineIntel-6-A[DE]", /* Graniterapids */
 		};
 		char *cpuid = get_cpuid_str((struct perf_cpu){0});
@@ -141,23 +142,42 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
 	// Compute the IMC SNC using lookup tables.
 	unsigned int imc_num;
 	int snc_nodes = snc_nodes_per_l3_cache();
-	const u8 snc2_map[] = {1, 1, 0, 0};
-	const u8 snc3_map[] = {1, 1, 0, 0, 2, 2};
-	const u8 *snc_map;
-	size_t snc_map_len;
-
-	switch (snc_nodes) {
-	case 2:
-		snc_map = snc2_map;
-		snc_map_len = ARRAY_SIZE(snc2_map);
-		break;
-	case 3:
-		snc_map = snc3_map;
-		snc_map_len = ARRAY_SIZE(snc3_map);
-		break;
-	default:
-		/* Error or no lookup support for SNC with >3 nodes. */
-		return 0;
+	char *cpuid;
+	static const u8 emr_snc2_map[] = { 0, 0, 1, 1 };
+	static const u8 gnr_snc2_map[] = { 1, 1, 0, 0 };
+	static const u8 snc3_map[] = { 1, 1, 0, 0, 2, 2 };
+	static const u8 *snc_map;
+	static size_t snc_map_len;
+
+	/* snc_map is not inited yet. We only look up once to avoid expensive operations. */
+	if (!snc_map) {
+		switch (snc_nodes) {
+		case 2:
+			cpuid = get_cpuid_str((struct perf_cpu){ 0 });
+			if (cpuid) {
+				if (strcmp_cpuid_str("GenuineIntel-6-CF", cpuid) == 0) {
+					snc_map = emr_snc2_map;
+					snc_map_len = ARRAY_SIZE(emr_snc2_map);
+				} else if (strcmp_cpuid_str("GenuineIntel-6-A[DE]", cpuid) == 0) {
+					snc_map = gnr_snc2_map;
+					snc_map_len = ARRAY_SIZE(gnr_snc2_map);
+				}
+				free(cpuid);
+			}
+			break;
+		case 3:
+			snc_map = snc3_map;
+			snc_map_len = ARRAY_SIZE(snc3_map);
+			break;
+		default:
+			/* Error or no lookup support for SNC with >3 nodes. */
+			return 0;
+		}
+
+		if (!snc_map) {
+			pr_warning("Unexpected: can not find snc map config");
+			return 0;
+		}
 	}
 
 	/* Compute SNC for PMU. */
-- 
2.53.0.1213.gd9a14994de-goog

