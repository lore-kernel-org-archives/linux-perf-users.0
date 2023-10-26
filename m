Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207378BF6
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Oct 2023 00:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EMgWPyDd"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633BF128
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Oct 2023 17:32:19 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d81e9981ff4so267575276.3
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Oct 2023 17:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698280338; x=1698885138; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f0o2QGOYpWvrS5QomD5183Br64G7wtY83rPo3ufwL6Y=;
        b=EMgWPyDdsFImZKMCvlR0ypPHjvkhDSzD5NY051EvmC3AWUGU7Q3W3vVKvBM9y+NoIe
         bK3QOyA25F0YMc7LvmUqAMpPFOwVodX6RgoNZwFScaZPUAawyYF39eQ6KfRbEyz9JnlM
         WAKFBhXAZSNzbkdY4b2KhPNAlRr4UA6N1KVd2zNdKDg2aIC4B2eHAkpPfvDS4epA6+r/
         b4OwOslqFxkLmw/ItH/Iw8NOUnLJ32g0Vf2gDxDOnJGhBMI7D+OlsJdYT50ZDtMnV14p
         EseS2OfB2vTAzCBiCg/WzWWlDmgy4lGagfhcel6Dm/SDck5kO/Lomr5r2dBqCBtcuZoh
         yAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698280338; x=1698885138;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f0o2QGOYpWvrS5QomD5183Br64G7wtY83rPo3ufwL6Y=;
        b=tkcIgpSYi+RARD52z3/utrPsxAXQz0ug55PebBapoVqHmkYI+9pk9TEEL1hdoaAQns
         sWIS9f15BmyV/7zashmQhOtSRK7QICAFobsMLiKif96XU/2A3lHIyMdG1BWTzs29I0OV
         TUKFm2n45JRNIDqg3u/UHQVY+4bZpNt3LBrd3tWRkPRqeb7nmr8xOf5YQ0xZxObjjL0m
         v2noOp1XAnBCRmMeU0DJNKaDy6MIzt8rrgVZlWoDhtTxhet7eN87ic3EcANUMoLIVC9e
         A7jN6htBDk8LBq528Uff1fsP8YcE5t1GkeoSmyR3LR9i4THhEpI9efR+eh+CcAen84DB
         /aqw==
X-Gm-Message-State: AOJu0YxkL4z9JZzw9Z+Qudc3T4hgLVSw4+yOze7MyXQi/WxHVvC72EZw
	v/oYqLaw+TqNkGOqEhoTocE4+eYcQpey
X-Google-Smtp-Source: AGHT+IF1cwrsEyzuVS9KZU+3VmcSVvsCXZpcsJTz4G8EDpFMEYvpmszDn2wC5rVGmu3CjzSDWsbhcuhkA7wv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:19cd:8b4f:c0f5:e803])
 (user=irogers job=sendgmr) by 2002:a25:e753:0:b0:da0:491a:c242 with SMTP id
 e80-20020a25e753000000b00da0491ac242mr111017ybh.7.1698280338663; Wed, 25 Oct
 2023 17:32:18 -0700 (PDT)
Date: Wed, 25 Oct 2023 17:31:42 -0700
In-Reply-To: <20231026003149.3287633-1-irogers@google.com>
Message-Id: <20231026003149.3287633-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231026003149.3287633-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v1 2/9] perf vendor events intel: Update emeraldrapids to v1.01
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Zhengjun Xing <zhengjun.xing@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"

Update emeraldrapids to v1.01 from v1.00 adding the changes from:
https://github.com/intel/perfmon/commit/3993b600e032a9fd443ffd828aab73de7cb167e5

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/emeraldrapids/uncore-cache.json  | 36 +++++++++++++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-cache.json b/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-cache.json
index cf6fa70f37c1..bf5a511b99d1 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-cache.json
@@ -3448,6 +3448,15 @@
         "UMask": "0x10c8168201",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_CXL_EXP_LOCAL",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_CXL_EXP_LOCAL",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x20c8168201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Inserts for DRds issued by IA Cores targeting DDR Mem that Missed the LLC",
         "EventCode": "0x35",
@@ -3838,6 +3847,15 @@
         "UMask": "0x10c8068201",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_CXL_EXP_LOCAL",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_CXL_EXP_LOCAL",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x20c8068201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Inserts RFO misses from local IA",
         "EventCode": "0x35",
@@ -4877,6 +4895,15 @@
         "UMask": "0x10c8168201",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_CXL_EXP_LOCAL",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_CXL_EXP_LOCAL",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x20c8168201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Occupancy for DRds issued by iA Cores targeting DDR Mem that Missed the LLC",
         "EventCode": "0x36",
@@ -5267,6 +5294,15 @@
         "UMask": "0x10c8068201",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_CXL_EXP_LOCAL",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_CXL_EXP_LOCAL",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x20c8068201",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Occupancy; RFO misses from local IA",
         "EventCode": "0x36",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index c09b81d8d5e1..7093561389a1 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -7,7 +7,7 @@ GenuineIntel-6-56,v11,broadwellde,core
 GenuineIntel-6-4F,v22,broadwellx,core
 GenuineIntel-6-55-[56789ABCDEF],v1.20,cascadelakex,core
 GenuineIntel-6-9[6C],v1.04,elkhartlake,core
-GenuineIntel-6-CF,v1.00,emeraldrapids,core
+GenuineIntel-6-CF,v1.01,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-B6,v1.00,grandridge,core
-- 
2.42.0.758.gaed0368e0e-goog

