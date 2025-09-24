Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27DE25A352
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 06:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758693777; cv=none; b=qj5xBjIjARQvqydhRCsfCq6Wx8D6XqismUnMWsj6itRXPfqUApCHda5nsCMd5134o9/2KsKOBrCB9BQVA/XxiZR63JdnxYIxIdlyrfiatfkMoIXuljtEZ4Q0F0tfsjMHm1H8G0eVaPSrJ11QgPfORPHLYr3oEpz7deIVFEYATXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758693777; c=relaxed/simple;
	bh=4f8UteEAAKXXLnIaZVqboj+1JKF4R9D1H1JBFam/nTY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=uq+5hqfkGXQPDvcTloGsag1azzzHWKcx+7b0bnfyTHge8mmExynA1XIrC6t+KjYgsFVbyVs2koIA4qw7nVmAYGEvZBIFXmwOovdH9rujShp52XUHiD4BkzihFXRCGOP5hmd06QqXTfo1/HdhfPfMlF8yG2N+cI7QFBF2EXt75Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ey4EY/bC; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ey4EY/bC"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-269939bfccbso81609915ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 23:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758693775; x=1759298575; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P69iPSe+1qLG8k7P5qyASkPxZvhss/JJiTEkX7gdyIo=;
        b=Ey4EY/bCGZgqxF9lbwCURmKfuLujEU2dm+C7DvDKRaNUSYlCOHrSKb0NL1OuGXtQm/
         MMUbGyrVGZ/7lJ19oLtXCmITfXis7ZxZNofWsG4fFxEdQlZJ57ty2cB7CP+EuTyD6Vmj
         WsGA9GL9Mga72BXM03WqStghqGo3fUqiSJu4xyIbBQJK6OMa0oqu3QaFQ6i5RF/vF+2G
         eJpiEiG8PvcuCqLrrRvUjQiNTu+ujJ8C9Tpt0YirRFt66hJDw0uVKQw2Q+bMEcKaNkVv
         MAtxbfbHXAsCH9duGZq4pxLApevvZRJeA20Un230JAc4XzBdHVtSyWUaWWSDcaW3nTyh
         Dp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758693775; x=1759298575;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P69iPSe+1qLG8k7P5qyASkPxZvhss/JJiTEkX7gdyIo=;
        b=rfMTS44yzD6/gEstwsnaBXnBFlh06G2hIgQaTzT8FNHST3kZoTgLuT8w2YCw2/Z01d
         wZe4ESnQq8yX9u7H6STR9X9Y8grOyj/SvCTLS5JpuzimHoeRV/TPBf0uCWDxnODghEF3
         uYlw74epEX98wJP6aIrVlEhB4xqxJtUy6pxnsQl4uFONp01ZqfuQ404J1W3BJWgDODpA
         wuDNdjWsUCcWBsHzt12JfhCHaifKZjcjQXpx+PH2iKNhelz8LdFzEBcfB7VWFt/qhuSk
         5+G8ej4wY7KUVKh4TmIoz/MaBrIwrLGXg/uVdb2aNZfEmEaymwarpHz2GtfJND8AEhqG
         XxUA==
X-Forwarded-Encrypted: i=1; AJvYcCVJMO3JR9ELmt+i4LAPDYjnkVfm2sXqVUyCu+JiqjtcYvVHn9P+X+ZSuVNsGlRAma1cn7SiRr7zs5jMXX2EfNOL@vger.kernel.org
X-Gm-Message-State: AOJu0YyVCWc9OEIHrAiL1qN0z9grThe2Xp3Do+yoa2DCo/UZJXc60IAJ
	C2oFsO2G4wh95WJKyBIwQIHZExVq4+LMq6ufSXaqKCiFRN0mRSJc9wyjUOlwCYo+RMpWsGK9jvc
	ObUf8VfN5FA==
X-Google-Smtp-Source: AGHT+IFqqe+931Ht21O2+lNV2c4QoFc87BRwc5+qH3FUQ+AFS53EMxT79FCln5S8v0dPfoOMlzx2lj+mqr6d
X-Received: from plge16.prod.google.com ([2002:a17:902:cf50:b0:269:80e0:d704])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22c8:b0:272:a900:c42b
 with SMTP id d9443c01a7336-27cc5434e1dmr57043505ad.31.1758693775135; Tue, 23
 Sep 2025 23:02:55 -0700 (PDT)
Date: Tue, 23 Sep 2025 23:02:26 -0700
In-Reply-To: <20250924060229.375718-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924060229.375718-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250924060229.375718-8-irogers@google.com>
Subject: [PATCH v1 07/10] perf vendor events intel: Update meteorlake events
 to v1.17
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Update lunarlake events to v1.17 released in:
https://github.com/intel/perfmon/commit/ec387ac70602283d01da32c2ff5fe9cb15d3d25b

Event json automatically generated by:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 .../pmu-events/arch/x86/meteorlake/cache.json | 36 +++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index aa0e2b0c4ba4..3a15a0f75b96 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -23,7 +23,7 @@ GenuineIntel-6-3E,v24,ivytown,core
 GenuineIntel-6-2D,v24,jaketown,core
 GenuineIntel-6-(57|85),v16,knightslanding,core
 GenuineIntel-6-BD,v1.18,lunarlake,core
-GenuineIntel-6-(AA|AC|B5),v1.16,meteorlake,core
+GenuineIntel-6-(AA|AC|B5),v1.17,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
 GenuineIntel-6-CC,v1.00,pantherlake,core
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json b/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
index f1d8db284a02..d4731e300d6d 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
@@ -1178,6 +1178,30 @@
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts writebacks of modified cachelines that hit in the L3 or were snooped from another core's caches.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.COREWB_M.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F803C0008",
+        "PublicDescription": "Counts writebacks of modified cachelines that hit in the L3 or were snooped from another core's caches. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts writebacks of non-modified cachelines that hit in the L3 or were snooped from another core's caches.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.COREWB_NONM.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F803C1000",
+        "PublicDescription": "Counts writebacks of non-modified cachelines that hit in the L3 or were snooped from another core's caches. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that have any type of response.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1394,6 +1418,18 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts all data read, code read, RFO and ITOM requests including demands and prefetches to the core caches (L1 or L2) that hit in the L3 or were snooped from another core's caches.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F803C4477",
+        "PublicDescription": "Counts all data read, code read, RFO and ITOM requests including demands and prefetches to the core caches (L1 or L2) that hit in the L3 or were snooped from another core's caches. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Any memory transaction that reached the SQ.",
         "Counter": "0,1,2,3",
-- 
2.51.0.534.gc79095c0ca-goog

