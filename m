Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4B03C199C
	for <linux-perf-users@vger.kernel.org>; Wed, 27 May 2026 22:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779920051; cv=none; b=G3XDScdhy1nhFRIG0YM/K6pdM1BpIT0f+Pa5mREdInyH4PoAdscwaIpf2gdqJYwFhjwJ6hT8uOOaUH+QOqLBF4aT+B3hFF2RCmTA0b0LdSUZ5p2mjCSrdgFETFCjUJYYDYb3OnYBKCvZe6ZZiP5+v/SwkcSJ2I4EGMlwLFQqMvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779920051; c=relaxed/simple;
	bh=OwjjbUXIh/Q8uHSaHlWGNZW15jr4+wuurC/oCQI5Ah8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WZbzngWytCEzuS5GhSo7OKP7W1amXqW0sk0+HGuC3W9nUMBR5++Nswzuesxxfn6zCN5MpVEkXsivrzyXzXPcVter+9/aBE9vFD80H7Z+/hsNMNDlULutiL+z3mPub4l5T63TvZ4E71uqWBCI04fl11G6DRbdWR12J/WcdTXGC9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iTWNd8d+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iTWNd8d+"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36642d2f4deso23356855a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 27 May 2026 15:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779920050; x=1780524850; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRXJCfwRo3QkGaLw7zb+TtC40Urk7RfXrq7asrwHnPY=;
        b=iTWNd8d+VIyPgaXUcpskeQ7j3a2+9ME4MKUCoQcP2sNEheynAPAfmdKjy3RRsaYLdJ
         1fFE7PigT2lwkvwcEDNdMuZnbTau/ve8PH/e9O9VotvTxpXdcv74uwr49VnLTagLkSNi
         logu3rCTvR1Tos9wyBBuIZRxF5QI3p29bg+OllzMcB0NMoo1mcI8ap09/XQXHDLbMMKQ
         ZjFiRq7XXehcEPtznSB82hy0oWnwHyGfJU5qhmbPAhPmpvfZk6D10sMfhMLJVbNW/WT5
         x+kQxmXnvRoD81NYa/6wPr69bvVY5nXtNvt0ZelIbwqbj+Csbcu3AdLRBflV8VTSfANC
         0CZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779920050; x=1780524850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRXJCfwRo3QkGaLw7zb+TtC40Urk7RfXrq7asrwHnPY=;
        b=j25Dt6wae7ImXLCZZQ0VN/3dQ2yVgN8IKYqZe9FN7vX6H2IojR1YCFJELdD5b/j2Gg
         dzcblqlnEhtqqds8BRH77vEvwxqk3unlyQF0JxInv6myoQDrCqQXNiczciwirqXvRciL
         gH+Dx3t2WQ3wkV+kNmJRtw48fh+xvOHCFe5pTCvk5Fr7Lq8DKPJ4ISkq0p24KVEMdbpU
         bnyDQCpYFvU1Uz1lC4RLHIi2XVoe+gdIG+fCrUKcJFVa93cI1dxuTc6zt8DzYxASEHuV
         drGb5an0xpQzD8r3w2XM/b4TKyr1EF7t1H/PTM3QcXjS310XQRHUAXp1FgbOVRsGyLE4
         1LjA==
X-Forwarded-Encrypted: i=1; AFNElJ/fz3oMrJNxiUO97yKFzepXH47ayrBpJdv2cOrJrrPjY0PyeMkxvfBsqkihe3qbX9fK25tswU9MiMY585UzPqzq@vger.kernel.org
X-Gm-Message-State: AOJu0YyCQ0T8Sg+zr1XBhq88HMJ7QOc9GyHtuQzWhEgYebuuO6NONBb+
	aB6SA7f+4lg3qbNQsM5B77NVs+Yon6cl7hXn+vIIrMRg1Fk/Ee2Mld1ykdBQuRkPlGYTyU35AX0
	gVXyC5w==
X-Received: from pgtq7.prod.google.com ([2002:a65:6847:0:b0:c80:2656:4e70])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f8b:b0:35f:b987:4dac
 with SMTP id 98e67ed59e1d1-36a67454586mr24890718a91.12.1779920049747; Wed, 27
 May 2026 15:14:09 -0700 (PDT)
Date: Wed, 27 May 2026 15:14:06 -0700
In-Reply-To: <20260527221406.3826216-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515172710.428474-1-ctshao@google.com> <20260527221406.3826216-1-ctshao@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260527221406.3826216-2-ctshao@google.com>
Subject: [PATCH v7 2/2] perf pmu intel: Adjust cpumasks for sub-NUMA clusters
 on Sapphire Rapids and Emerald Rapids
From: Chun-Tse Shao <ctshao@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Zide Chen <zide.chen@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chun-Tse Shao <ctshao@google.com>
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
Assisted-by: Gemini:gemini-3.1-pro-preview
---
 tools/perf/arch/x86/util/pmu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index 9b00d5720fb7..2c24ef3140da 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -23,6 +23,8 @@
 #include "util/env.h"
 #include "util/header.h"

+#define GENUINE_INTEL_SPR "GenuineIntel-6-8F"
+#define GENUINE_INTEL_EMR "GenuineIntel-6-CF"
 #define GENUINE_INTEL_GNR "GenuineIntel-6-A[DE]"

 static bool cached_snc_supported;
@@ -30,8 +32,10 @@ static pthread_once_t snc_support_once = PTHREAD_ONCE_INIT;

 static void init_snc_support(void)
 {
-	/* Graniterapids supports SNC configuration. */
+	/* Sapphirerapids Emeraldrapids Graniterapids support SNC configuration. */
 	static const char *const supported_cpuids[] = {
+		GENUINE_INTEL_SPR, /* Sapphirerapids */
+		GENUINE_INTEL_EMR, /* Emeraldrapids */
 		GENUINE_INTEL_GNR, /* Graniterapids */
 	};
 	char *cpuid = get_cpuid_str((struct perf_cpu){0});
@@ -161,6 +165,7 @@ static void init_snc_map(void)
 {
 	int snc_nodes = snc_nodes_per_l3_cache();
 	char *cpuid;
+	static const u8 spr_emr_snc2_map[] = { 0, 0, 1, 1 };
 	static const u8 gnr_snc2_map[] = { 1, 1, 0, 0 };
 	static const u8 snc3_map[] = { 1, 1, 0, 0, 2, 2 };

@@ -168,7 +173,11 @@ static void init_snc_map(void)
 	case 2:
 		cpuid = get_cpuid_str((struct perf_cpu){ 0 });
 		if (cpuid) {
-			if (strcmp_cpuid_str(GENUINE_INTEL_GNR, cpuid) == 0) {
+			if (strcmp_cpuid_str(GENUINE_INTEL_SPR, cpuid) == 0 ||
+			    strcmp_cpuid_str(GENUINE_INTEL_EMR, cpuid) == 0) {
+				cached_imc_snc_map = spr_emr_snc2_map;
+				cached_imc_snc_map_len = ARRAY_SIZE(spr_emr_snc2_map);
+			} else if (strcmp_cpuid_str(GENUINE_INTEL_GNR, cpuid) == 0) {
 				cached_imc_snc_map = gnr_snc2_map;
 				cached_imc_snc_map_len = ARRAY_SIZE(gnr_snc2_map);
 			}
--
2.54.0.823.g6e5bcc1fc9-goog

