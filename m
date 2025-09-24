Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C82B24A066
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 06:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758693771; cv=none; b=VusiYeggWdeVBGO2Jji3FpAMxzkxK5R6sKhmo20ZtK6ZUDFull/hHk3bJIhWrXkRsQUsEioB1Q6mS6xoM3kRmyxex9NAkL6VjGBfLfo6WQYxjUqyuWbpRq1I1fFt9eKDZNEKyuL7OI3KkPmLnNAoVDpUUWqsG67H1GlhHj1E8J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758693771; c=relaxed/simple;
	bh=VlBzm4sQ+K7RqzqDXx9u2XN09xpSsntef8scOgjmO6c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ldAXCc0MzchlThSMUMIuxRI2zXy+XmfAcJjdhOHAX39nO4pNQQchh1NXQhtRk1qLAyWKJ9Dg7bn/q3zlkaexNDkESOp5DtZ9NDcg2DQaU1F9TrWXR/zn3eGXbDanGk3fehwj2Jn1pjKmAEQmnjbkcU4a8uDCaMtRQbuDVgiNQ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JRfGfZ63; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JRfGfZ63"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-27c62320f16so25954585ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 23:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758693769; x=1759298569; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=plTyOlm01Lu+32dYRONMwBTr1DEdYenlGFnsI+q2WIg=;
        b=JRfGfZ63uplY/3kO0SH/mnxwrO0qw0P3/Ss+vQShCoGCy6L2xMZElzQscMKjSU5SHf
         Es3+sx+SuzXcTfI1HofQUTxAs4PbtPohhWV5A1XpR52jg0g/5x20azRWjUH3tKd1eY8L
         CJ75IMUmrSCcIXkzf8gqupTanfjHHC87JY+nSqTWHScCcTDX7+q0jA21IwB1nfbLP2aH
         zD2+1kzyMWkmiBEyr3MCOR6retTJV9/Iwh5ZFpKuukX9SuL36BwFkP5BGSxe5jBbnFp5
         CbGB5JqRDUb51Ytsvoiim4Lr8sffXYvEYwVvU2GPci4OHSsxzWJ3HxMfN7YsaX4A5Cz5
         dwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758693769; x=1759298569;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=plTyOlm01Lu+32dYRONMwBTr1DEdYenlGFnsI+q2WIg=;
        b=EiTDFZGesnHsbsbjCwc1BwHIupVEHkeCboWq0tesPvgWa/aOKGZGnI/+XrtwPPNdpW
         4duDLvzgd9nekfIxzZ/sgiiTDJYe4FxOkTAuOeE+aWLeNMNcIGknNpxFbdoRL/HWJpFI
         lyzNX9mv4Zwj4ZZq2FwO2JTy+okA3lQivT2h1NWkagmCFM7wa7qJyUBj6QO67Kz4FNx0
         MXZP/GQy+yBLSNE7rRRCRbssSSuh8IoAUevT69DVUswBYMbMMQ8U/qkwzD75l0Qltvt+
         SMhlPLc3R3z11QKyEVJNsjQxsG49rWR7BnCE7cJiS1yuIzSPuwmNFxi7s4tcPDUid7D5
         miCA==
X-Forwarded-Encrypted: i=1; AJvYcCVhY9cTLJz5u0ePJTZAlGghOrfHgrS5Hkw5lAp0zfqbY2nHAYBSSGuG957CDMSiEGVVsSkwHfQGjifKZV0bKyrV@vger.kernel.org
X-Gm-Message-State: AOJu0YzCgcb8DX6EaTCbk7Fhi/n6W7MLnD7VbDcyWjz33Ug2GjcrkShW
	pzKVakhNX6ZNhe1AOmgBFxvb/W1waQ39aDjtI+8EbJTLjVul1/6HYtuyMoz9tc7AgOlkPM4AOGq
	JMmgD9OiiSw==
X-Google-Smtp-Source: AGHT+IHLH36G0jqLqswFH+QMg2Fx2jrBGAbZ/gMyA8lOGOWb1W/XupEgWZBVdhuGX7CQVIvpG4t7VJBhwVqL
X-Received: from plec19.prod.google.com ([2002:a17:902:f313:b0:269:937c:75b3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c7:b0:27d:69de:edca
 with SMTP id d9443c01a7336-27d69def40amr48076015ad.13.1758693769329; Tue, 23
 Sep 2025 23:02:49 -0700 (PDT)
Date: Tue, 23 Sep 2025 23:02:23 -0700
In-Reply-To: <20250924060229.375718-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924060229.375718-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250924060229.375718-5-irogers@google.com>
Subject: [PATCH v1 04/10] perf vendor events intel: Update grandridge events
 to v1.10
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

Update grandridge events to v1.10 released in:
https://github.com/intel/perfmon/commit/c3028836415b8b5d31b8439eefc087492148c19f

Event json automatically generated by:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/grandridge/cache.json | 20 +++++++++----------
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/grandridge/cache.json b/tools/perf/pmu-events/arch/x86/grandridge/cache.json
index 877052db1490..9abddb06a837 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/cache.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/cache.json
@@ -286,7 +286,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_1024",
@@ -297,7 +297,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
@@ -308,7 +308,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
@@ -319,7 +319,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_2048",
@@ -330,7 +330,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
@@ -341,7 +341,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
@@ -352,7 +352,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
@@ -363,7 +363,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
@@ -374,7 +374,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
@@ -385,7 +385,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index dec7bdd770cf..888d38e49766 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -12,7 +12,7 @@ GenuineIntel-6-9[6C],v1.05,elkhartlake,core
 GenuineIntel-6-CF,v1.20,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
-GenuineIntel-6-B6,v1.09,grandridge,core
+GenuineIntel-6-B6,v1.10,grandridge,core
 GenuineIntel-6-A[DE],v1.12,graniterapids,core
 GenuineIntel-6-(3C|45|46),v36,haswell,core
 GenuineIntel-6-3F,v29,haswellx,core
-- 
2.51.0.534.gc79095c0ca-goog

