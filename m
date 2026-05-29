Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2CC38E5C4
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 04:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780030380; cv=none; b=PfsPZuY0BJ8fI/FuU2t0KfpSJ0d3P4bwYid876MeXyK+y04mqxUvyk0GIh82kgmJ4/aI6Q5oTNe14CMF8FozeSbvoph4Cg77uE/KLG9b1VS6grnr1XF/+2y0VQXYCOJ1h+9f+vtaflOOHHKu2hTDUh/pFW7AIvELsOHL7AKD3PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780030380; c=relaxed/simple;
	bh=1Ca+UingKKI7OakWg2HHtB5zTTt6JFEb4Nu7t76Xi6A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k3HzikJ3tkBOrWcJ49lQDBmv2cX2wyEb5sK/8ozwEsfQWys/EttT92EiH4uw/+1rj0nIiKIBJOM2APiPr27xwOiNyhj9AzVEYZ3snsFIEu54+ONeAp5OCfBWL201oFqz0hK8crG1Qd0mtG7KM+ohrds1Pe5NZ58Ccs5FXVe/E0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jSQ8rHzo; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jSQ8rHzo"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8279604464so16425438a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 21:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780030375; x=1780635175; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+IfovqBofwSU9jwSOFvXQcmzOlaSzMdwM/kBN6fDzhI=;
        b=jSQ8rHzofr+tr9GEUoZ/TIwz8f21y9RQoiwjCyLYzPPhqiCSLvTpdxBNaIBQYQUmU3
         7LKTNF1wLtwhxpQp7/fS17UHU7n4aUcF8FX9yDqjnDtbB+BygZxlR1D0Sx/sAvzbI3Jo
         e8KEOQ/6dVpdo40eqhLjlraAl3VhG7K9oOIk0NGzNxxjOwbkfpSxnJfpegEOUj8uzBal
         A7WGu7soLmulYYN753a5w57d51oOul6uLsktCmLdt88pFIFo3amMH9prJX45StkMPMB9
         kq4ZHyfxT5+lVvd0AvKkxrj4H+cFchG4zQy885PgN1WhufowauOPYwggKv3BECoboh7W
         BOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780030375; x=1780635175;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+IfovqBofwSU9jwSOFvXQcmzOlaSzMdwM/kBN6fDzhI=;
        b=bzHDkAD4ztatOSOuziCFMDuslRHl/sgq0TfqZNODPQchzEe7tkV5o9yUGvu5zGfC5r
         L0XJZAd59y6NgxZxcVA/gWnTM2L0JOssA+R8DXI253y+6TB2P0jRqq73a4hFVP4/kaay
         VHEy36KAgfVt2HstpZ8Cbb3ya1vceoPpoJmmJ5TEIRX2sB4Lu5xGspGzKb7rxzOs0fis
         4rzIDfuxvFaUKyVONLWOyE0By0pyxklOirGtGfHuAXYk3yj+IIxuHP67L0xCNYVwExHq
         1nJHHP2+VWm2SoVvGwS4k1PflJk0pYo5UHN1MHnGVO0SkUGyNKkZ/7NgK9Wqw3iiOLIR
         m09Q==
X-Forwarded-Encrypted: i=1; AFNElJ/90MWlrJL5aiEy/wdXjA29d6zTOxMSkhY0fikia4Pt54KJXO+AbZbMmAkP4QXnGolCuYmdCo17KEtS3GBhDI5z@vger.kernel.org
X-Gm-Message-State: AOJu0YyAbxO2dImmhdSALxDl3bxZjxDluVf+rsJTx0W5Hn8J8g78i2Hs
	JuxW4YPsWdPeKo6SqIsNDGBr9UP0uON183NbuWj1zF15nyd9zeoYKAxkzau1eS66yEaP+i/tutW
	BsOW43VyPFQ==
X-Received: from pgcc3.prod.google.com ([2002:a63:1c03:0:b0:c79:8315:4734])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:be8f:b0:3b3:c28:45b3
 with SMTP id adf61e73a8af0-3b411deb29dmr1400607637.26.1780030374584; Thu, 28
 May 2026 21:52:54 -0700 (PDT)
Date: Thu, 28 May 2026 21:51:49 -0700
In-Reply-To: <20260529045155.311805-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529045155.311805-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529045155.311805-8-irogers@google.com>
Subject: [PATCH v1 07/12] perf vendor events intel: Update graniterapids
 events from 1.17 to 1.18
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The updated events and metrics were published in:
https://github.com/intel/perfmon/commit/5b93c8c750300a15b29a9a718511869b280c91f4

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/graniterapids/cache.json | 9 +++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv              | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/cache.json b/tools/perf/pmu-events/arch/x86/graniterapids/cache.json
index db28866444b6..95d6b46f3445 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/cache.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/cache.json
@@ -296,6 +296,15 @@
         "SampleAfterValue": "200003",
         "UMask": "0x40"
     },
+    {
+        "BriefDescription": "Cycles when L1D is locked",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x42",
+        "EventName": "LOCK_CYCLES.CACHE_LOCK_DURATION",
+        "PublicDescription": "This event counts the number of cycles when the L1D is locked. It is a superset of the 0x1 mask (BUS_LOCK_CLOCKS.BUS_LOCK_DURATION).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
     {
         "BriefDescription": "Core-originated cacheable requests that missed L3  (Except hardware prefetches to the L3)",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index a1548f1306a6..b97d19ae4264 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -13,7 +13,7 @@ GenuineIntel-6-CF,v1.23,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-B6,v1.12,grandridge,core
-GenuineIntel-6-A[DE],v1.17,graniterapids,core
+GenuineIntel-6-A[DE],v1.18,graniterapids,core
 GenuineIntel-6-(3C|45|46),v36,haswell,core
 GenuineIntel-6-3F,v29,haswellx,core
 GenuineIntel-6-7[DE],v1.24,icelake,core
-- 
2.54.0.823.g6e5bcc1fc9-goog

