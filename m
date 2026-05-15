Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144803DD85F
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 17:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866070; cv=none; b=XE2J2c+WwGBgC0czLPaq83UINTFv071iaEYMWPNMn3cT9oYkNPdzP5hK639lVa8Wo6XSlGlrDZAU9c2VXVIKwxzj+wzdu0Yv+wVEuinJ4/P4tsSo+WMkd+OGvKo+MuBbi2cLrWiQqDEYF5Kb3rpTx426HpTx9VR10e2UifSzpqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866070; c=relaxed/simple;
	bh=/72P1vHX5az9pC3JqbrWUuqR30PvxE6IyF9r+3WWYK0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HgTCN6TeqrAUkW18meJMaoFfSibLSP0+scDEa80Pk3+CpddlcuCMz1tGcjupys2nJqj8eqAOJYy2ErpbdjwV8xu9ktDubBgdlyFV9A1dxB/d3viaSaeoXeeW+thNoMwI1HomxlI0Ub5xyYrv7CXIuSy6QPUWryzWzsOxLEGNyEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LEkoJ3Jh; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LEkoJ3Jh"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2eebb099efbso567437eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 10:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778866068; x=1779470868; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OFsUkqF4R4XmvHwFWqwYGzuj6yETXwswBIPNiy8h6hw=;
        b=LEkoJ3JhzMpobSPhZhHStaH9JMNlaCOaS/WhdLAMVFF9b99X4fdE4Qq7bR/jKgV1uI
         s2gsWFFqVMvXh35sjyI0+lLeOqqau3rnZpIOQkDN5B98q/jpPzHHkAsID+LzQzUP5DZ9
         7b8+fe4V4JGrGMwT2ceGz7HbGpbtcr7wNv1B1x+Yqj5gcScQMszhR03U6D9VR6op8C9z
         JT/0PJE5INsAiJ/VqO21m3eEf0xdMY28NN4rhsK6jGEcpDlLyuTt1Bv9DNyftuMQFl48
         YXiDo6wr7vnu96BsvIjSjueNoqMrYtft/PtmP1pSTao8HvXBk7fOZzwSgh57BdUp10Z6
         DTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866068; x=1779470868;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OFsUkqF4R4XmvHwFWqwYGzuj6yETXwswBIPNiy8h6hw=;
        b=MU31F5YvQ4KkHG8LS960f7WMXDKCFqn0vSEMMSqmZhS62l2/IesldtjkKjAhj2KO2b
         jEEnlmj9s7nSW51WSaIz1z6IE/e//7FXXe8Sj6U7tBfLJK7DZzX8I8hK9XNYfx7eDj8N
         W/kBE+s9XQTxZjje56J7iCbLLyzf4uLzJ7Jy+vOjM/Iav7YFB4EsgIuXfziQ290ih3po
         ngzSuA11+9zzULMCJe6zGkqC504QQUpIYmG96hozsxJL2weIm9ygLl2aJMjMKBGJQrRR
         hgucSsldW2BukSp81hV3l3sbidLmwU1/Vn5KwaffSCMLGMKXTmyd92vgKWUhSWe/Gk/X
         hExw==
X-Forwarded-Encrypted: i=1; AFNElJ+MtSOIta4CKGGKqoT4BMKzfDz0igdcH9qhkX7u4ZUa4qxD0P9Eh+e646JtFYw0j61tbFu+FbMukJE/gf9pNqZ+@vger.kernel.org
X-Gm-Message-State: AOJu0YwkAGauDEIMk4oJfrLM9lGVcO7VqaRk406FQiUlTVb2J7mj8Ygc
	rBbN6hMj7eCby1L5vn7DeZB4lTWjtZkdVCmoPcsMb1OF/BaUqNAbtyNuG2uW7xeyWCUXeEt8oFs
	kL7JZbw==
X-Received: from dybtv21.prod.google.com ([2002:a05:7300:f495:b0:2ee:b6da:180])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1001:b0:2e5:5bf4:8869
 with SMTP id 5a478bee46e88-303986771bcmr2505655eec.21.1778866067827; Fri, 15
 May 2026 10:27:47 -0700 (PDT)
Date: Fri, 15 May 2026 10:26:33 -0700
In-Reply-To: <20260515172710.428474-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515172710.428474-1-ctshao@google.com>
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
Message-ID: <20260515172710.428474-2-ctshao@google.com>
Subject: [PATCH v6 2/2] perf pmu intel: Adjust cpumasks for sub-NUMA clusters
 on Sapphire Rapids and Emerald Rapids
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, Zide Chen <zide.chen@intel.com>, 
	Ian Rogers <irogers@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Similar to GNR [1], Sapphire Rapids and Emerald Rapids support sub-NUMA
clusters as well. Adjust cpumasks using the same logic as GNR in [1].

Tested on Emerald Rapids with SNC2 enabled:
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
 tools/perf/arch/x86/util/pmu.c | 60 ++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 18 deletions(-)

diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index b8fab260c423..09caec0a32a5 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -22,6 +22,8 @@
 #include "util/env.h"
 #include "util/header.h"

+#define GENUINE_INTEL_SPR "GenuineIntel-6-8F"
+#define GENUINE_INTEL_EMR "GenuineIntel-6-CF"
 #define GENUINE_INTEL_GNR "GenuineIntel-6-A[DE]"

 static bool x86__is_snc_supported(void)
@@ -31,8 +33,10 @@ static bool x86__is_snc_supported(void)

 	if (!checked_if_snc_supported) {

-		/* Graniterapids supports SNC configuration. */
+		/* Sapphirerapids Emeraldrapids Graniterapids support SNC configuration. */
 		static const char *const supported_cpuids[] = {
+			GENUINE_INTEL_SPR, /* Sapphirerapids */
+			GENUINE_INTEL_EMR, /* Emeraldrapids */
 			GENUINE_INTEL_GNR, /* Graniterapids */
 		};
 		char *cpuid = get_cpuid_str((struct perf_cpu){0});
@@ -142,23 +146,43 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
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
+	static const u8 spr_emr_snc2_map[] = { 0, 0, 1, 1 };
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
+				if (strcmp_cpuid_str(GENUINE_INTEL_SPR, cpuid) == 0 ||
+				    strcmp_cpuid_str(GENUINE_INTEL_EMR, cpuid) == 0) {
+					snc_map = spr_emr_snc2_map;
+					snc_map_len = ARRAY_SIZE(spr_emr_snc2_map);
+				} else if (strcmp_cpuid_str(GENUINE_INTEL_GNR, cpuid) == 0) {
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
2.54.0.669.g59709faab0-goog

