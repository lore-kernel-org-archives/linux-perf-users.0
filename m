Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C600639891E
	for <linux-perf-users@vger.kernel.org>; Wed, 27 May 2026 22:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779920380; cv=none; b=e4+F4h3lmDYUi/WKDS0G/TwhdwdneazDjLoF63wzUzzjTJx75C/KlTFOZ988MLBhQdiwoTPVW4d2K2S5tkS0yxxNip5cYH6l/+FH64haTU5upZrkP3M/h5Yd/F0Wco/GRKPMbbLg1mErtdF5+NwHCcJUE8gYQEV3Ign+Vc+bNOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779920380; c=relaxed/simple;
	bh=OwjjbUXIh/Q8uHSaHlWGNZW15jr4+wuurC/oCQI5Ah8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T+VqsNMDsMM1iXgubA3EHq8MxegMi1D/6pyiPCSvRm785LJ32nVz4rs0sKZef9vJyWBy0ENGT/rgLNX4rYD/MYtRXczMMFNX9zaVGzzNjF4R5r8SVr2By8LbLfwtboF8KeWGPsi53vB1P3h37dkYq46zy8mwAx6L9LxeI3uYc9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wFOxxVvq; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wFOxxVvq"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba054e0304so105842325ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 27 May 2026 15:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779920378; x=1780525178; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRXJCfwRo3QkGaLw7zb+TtC40Urk7RfXrq7asrwHnPY=;
        b=wFOxxVvqhtxFTIJugpXeV/BdZx6zg60mCoCe/+6lEhU6Lm4WY+frY2xc2zWN//xmmD
         sHLucOz343bRl12aLt8ixqpawtCeizPT+BsrkDXHllxK/TppVpu5wAJOjUUNhYxEo7Mn
         Lq2Lwjrof1vOCRqHnzPoD/L/8Hnp9Rvrb36loMrExbDqXxSN/6sppo/34lGz3LciCzkx
         ywUGLoITCq+OgurMXOpeoU4Nya5PKtMzbFgAr/iUhfAe9UIl44R2+zRboEtQp6KQn63m
         EONEiI7ZHzKcVyryZZl/7zygjuH/hiNBlHN6Yj3xRbKhQqKnKggrHBeZZG/w0MqX0qBx
         ZoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779920378; x=1780525178;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRXJCfwRo3QkGaLw7zb+TtC40Urk7RfXrq7asrwHnPY=;
        b=Uj8yJZZD263O+wmkEfnjJSNufPqoPxAP5AdaR973c6ucWdFo04mbDAfYrq8STb3Ufe
         xHh8HwcF9r7G6d5H+STEjjsuxf7re2xawQGKFuqzbSuPI1zdm8Q1F3SxjyCqdIHVmBUl
         rHoWIYZZKBFqtITM2UJZwS95me0L13mLDx4SEtcRHHXe2Oe+d2hh+3FQ13DQMS7U1MKs
         miyJmfwOoXc6nwSt265C5VZ8afDg2P3GSRqFZ7loiCjjxrJ1FBnGgj/TKH47lkbX3Fnk
         LCnNzPN/3pN3jFKLqBbj5RPn4xgcc//tqEX4wvnk0IMlcYO9GcK+Ftck3LyCyJmu7p50
         LZww==
X-Forwarded-Encrypted: i=1; AFNElJ/kzTGQpH2AdiaWEzHKTSOVRLZxtlKpuZIaX5cIUcvLO7/+egPsqnle1aEA5ODMIlUkyMwdJSuQ3krvhTElKMMl@vger.kernel.org
X-Gm-Message-State: AOJu0YxxtBmPk7jSdqiu3cmMC+nmMTIvTgTsJ05+JZdjpqUE97CpjhFQ
	Iwh0H3lQK0YZKSUY77K0AzJf9iLtlNAXY3Mhd2+LGklKYSOdI8jL50ARSRgL3+2Dm8njmvdVXzj
	+l9dw+g==
X-Received: from plble4.prod.google.com ([2002:a17:902:fb04:b0:2ae:66c7:db93])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ccca:b0:2ba:4086:ef93
 with SMTP id d9443c01a7336-2bea2221e87mr258185225ad.10.1779920377684; Wed, 27
 May 2026 15:19:37 -0700 (PDT)
Date: Wed, 27 May 2026 15:19:34 -0700
In-Reply-To: <20260527221934.3830896-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527221934.3830896-1-ctshao@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260527221934.3830896-2-ctshao@google.com>
Subject: [PATCH RESEND v7 2/2] perf pmu intel: Adjust cpumasks for sub-NUMA
 clusters on Sapphire Rapids and Emerald Rapids
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

