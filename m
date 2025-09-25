Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA63D3101B5
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Sep 2025 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821271; cv=none; b=hT34w3/HR5Y4i9BlrZYGisgGtNeqb+ew7HN2r4B1oUdb/g/ZfQZmrh4t/whk3s9SV0eZsxKv2UyLoMs2HV43fnHbiITJHRvMnJWQgiWU2PorKpfw6Ai8+xRnu4E+lWB1MDwNMaOGz7ow4GtKx8tOoAB2cRn6vIWORlb4DIIsHTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821271; c=relaxed/simple;
	bh=PpkXYXg9GXehn9kAhfMc34VfzpX2CR6PHHD0O+cL6Jc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=mMqO17766LtIidDyjuM+obaKEZIE/ZFksTwl2GM3pUCutu6c9JTcwQVUzpmcGLCIqf2JYf7OfMgj6jynnwAZ/9O9hRQUYYhtlbOYyALUS4LKGQimjKoG1m44vXkBAWPBWL7cx1XGlag9/opUum3VlN0iE1I41Sln6We5HICu9kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KjyiWwZd; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KjyiWwZd"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7810e5a22f3so696759b3a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Sep 2025 10:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758821269; x=1759426069; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jqwTAn1UWldDlHvSlgVybH00KpadDuea+reoIjfCw60=;
        b=KjyiWwZdAWkRI3WewTYHBVkjHmdNwoyOJDmI5+8VF5reZ+/mvC1XddMTMxr9gJkRl2
         LkwGL7iwSeb95JCYYCEFcV6z5n71r9Ub/HB+mUWfJxTZRvBvjXzZktVLL0tzrxaIfWXP
         WZNQ9FRkJZoJ8XqzU0zl9R/8oKKqyla7yn6T3b98i38+WsvlhGGxL4Y/FV7YVZnJXNrq
         bYs7vvWWrMU9UDZ5Rm237SaSr0H+XrpSBosH0DKJBYJA6qYIY94u4X3sZzmju8n1eJlw
         9u3Bg73WvbFBVQJ3BSrycgw8/7bUtK3a1pKBLrLd4iezYoB96LfIKiZfg2ITAV5uurK/
         cMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821269; x=1759426069;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jqwTAn1UWldDlHvSlgVybH00KpadDuea+reoIjfCw60=;
        b=dIhOHfDHeB8WRK6E+Wo47dxS7cgI3b+/KWjLxH3gjn0QnY5GbUNqoKRDHAWH+Dnk5B
         sUt8GOAP+6sVE01roYF+497WGM54X3c3MVknQgxJR16itZlDqO1ssrZfFN7YjQYttgpI
         BjZ3EXaW831EfaxX06b72Un2tD7XbpCvPE8zrx4UkkjT790E+v7Jzz1Uv81Imw0+BWca
         OH1a8RIdhVay+PHPq/K3p2GbQfrU0boRhXytEsuGGSyTSsZky6BLhlKHJ6eq7gDmZlVR
         VpVmdL8m1K1u+wXaJI7onW/BgwoSF7hfVnHM7fqhphI3YdBcQukHISvLnfcbdw1H80uM
         JK+A==
X-Forwarded-Encrypted: i=1; AJvYcCVw0Iur3WqA4z8qbRqSPI0Y1cR1Ya11RBJlJ4I6PsvF37RmqTQAERztVtSPJ7jogzCq8xF+kDnaB13lB4Ez7ARd@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvhp82za/TiRyW+J7uHkF/6cnNMCt9Uthug0SWI+eheDLRjcXo
	OrkKG5qKVw5wpyT+6RzcEADTXSav12t0ifmH4+BakOTJjNb+5er7vOCMAWshr6WUfcbCalbVgDN
	FwLntDru5SQ==
X-Google-Smtp-Source: AGHT+IGkMXXQiMjZDL94qNso3pCiau3Vfe8C6wq/0r4dAPUmCQUz8U9eIU/wu75tDxbflA1r2g7/cUcrYlQS
X-Received: from pgbcq4.prod.google.com ([2002:a05:6a02:4084:b0:b55:a4b:fe47])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d12:b0:2e5:c9ee:96fa
 with SMTP id adf61e73a8af0-2e7d53bff65mr4520614637.34.1758821269156; Thu, 25
 Sep 2025 10:27:49 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:27:30 -0700
In-Reply-To: <20250925172736.960368-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250925172736.960368-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925172736.960368-5-irogers@google.com>
Subject: [PATCH v2 04/10] perf vendor events intel: Update grandridge events
 to v1.10
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
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
2.51.0.536.g15c5d4f767-goog

