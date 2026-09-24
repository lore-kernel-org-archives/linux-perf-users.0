Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88054AF17C
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269496; cv=none; b=TAEVpfAqaYRJihnwXqgp2bFqWAWuhyKd8Jf00VMOUlNGD6bCokNdt1VOygffWk342DXZNpZmSCbgkYNLJrkshJYxHeW/AvbrKhEss/M5LQWiHG+hA7fwbB01aMjdnbYIKT4Fh5CkL/4LoVprApC29B2BG11iiQiTBe8HZD6hmag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269496; c=relaxed/simple;
	bh=zHnRZ+fpQuVPCHcqMCSLhDrr6++nIoQY4LcK+JEb2fM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Je4rJqXnvVKH1hqKAZhCeqQ1VPR5Ej62m9QHDDgiMUAsW7ovHVG6SDoNSj9P6Sw5AZI3OgBwUC3kRjCxNcDk5FdHn5p5rGE1bLBi5O2/x1L+S7VtK35PZ/pquimlR3oLIWeQ3hGu30ysJS290kUX7QZ9BA2vIExiaZj7LQLifXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ouaMoQ6A; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ouaMoQ6A"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-338c2e27430so2141437eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 10:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790269494; x=1790874294; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ISBPYfoRX1y2wna029OoWmealtEkIJKMINn9ddsuUrQ=;
        b=ouaMoQ6ARgF7RrBd/u+epuKgJaqX2uZWz4QqL68atbmFW5XjhmhJTJtLMlCHy68o2A
         hSqeyeuz4EWnefiZNXo+doS/DBhV7OwF7jlE1Pz4rVVaXJLbStoeuTpnYjyvJSOXL+Qr
         DfUWSWH2SnTf+LTj4ZS5BEOlXtp1ntPatvciMxuw/ZCTr89KPlr1t/WjuF9xFZl17jCl
         cJlTxe261mZGn2aU7FrIBnyNT0bcXnRGdXaiOMQhXCgjDxgaSOi4XUgARnKwq3BN2T6v
         oVdgAfJHSbzqjsa59b1nwRpWC8TYJ1Oxzl3tCsUyv/26EDgjvugbWjyykeYUPsR2Fw7r
         Q4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269494; x=1790874294;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ISBPYfoRX1y2wna029OoWmealtEkIJKMINn9ddsuUrQ=;
        b=X+72LL3yJfUnqBba2mr1v6owxJPnYL+Q59dajT5S+GNPivUBFuHN0fWyH+BBygh+M2
         eCc2MBsTuMktDIATfuvWaeD5cOBdd3JP36QRBoC8nI10RP135A9TI6dLX3pFZAai8SvW
         bDz9HdX/qxtg9W/97cAA/0A0p/RSHguuwAE3H4MXCw9/hsSNr8k//XBCg4JLGs6jUSZS
         y+etLSp4uc2HuFLQJSf+o7ZW8Ws0qODMqtO54RguUOoUgt2h8/tHW3KNfpXJQGWok1H2
         moFyL3ozoee1Q3fyrpdzLhKg4bP/zDqaTHv5l51MjPAmnnoGv5ISHNkyrCiqRTNxueiO
         FnQA==
X-Forwarded-Encrypted: i=1; AKwUvBwxdWOcRi4Sgq4JIxclNNmsS92hUe/IlUnUjkuDm9mTK+9nNzSZvXJ+tT7H41xxOIsU/3aNlNy+tQs0bpeHFoTc@vger.kernel.org
X-Gm-Message-State: AFuF++lNlZjS34mhCNvV6RahbcRJP05qdLLJpTLw9+uj5lE/IoqF/Uc4
	UWFoV38Uf5tRyaqHToGs2Xita7++ZuSzgfHVe4J6ZYZlDGMUTzXVmAfpHH+l8nKd7/sZzx9RpE+
	AQfrQDTMDaw==
X-Received: from dlag11.prod.google.com ([2002:a05:701b:250b:b0:144:d025:68b5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4554:20b0:143:7001:7640
 with SMTP id a92af1059eb24-14503fd2247mr2519203c88.39.1790269492538; Thu, 24
 Sep 2026 10:04:52 -0700 (PDT)
Date: Thu, 24 Sep 2026 10:03:43 -0700
In-Reply-To: <20260924170346.3872848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924053645.3555041-1-irogers@google.com> <20260924170346.3872848-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924170346.3872848-24-irogers@google.com>
Subject: [PATCH v2 23/26] perf vendor events intel: Fix lunarlake umask encoding.
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, dapeng1.mi@linux.intel.com, 
	namhyung@kernel.org, edward.baker@intel.com, perry.taylor@intel.com, 
	eranian@google.com
Cc: adrian.hunter@intel.com, afaerber@suse.de, ctshao@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mani@kernel.org, mingo@redhat.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Fix UMaskExt that was wrongly encoded when the UMask was 0.

Fixes: 23878069de30 ("perf vendor events: Update/add Lunarlake events/metrics")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/lunarlake/cache.json    | 3 +++
 tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/cache.json b/tools/perf/pmu-events/arch/x86/lunarlake/cache.json
index 5b350233a5e1..c77040e87639 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/cache.json
@@ -848,6 +848,7 @@
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.MEMSIDE_CACHE",
         "PublicDescription": "Retired load instructions which data source is memory side cache. Available PDIST counters: 0,1",
         "SampleAfterValue": "100007",
+        "UMask": "0x100",
         "Unit": "cpu_core"
     },
     {
@@ -901,6 +902,7 @@
         "EventName": "MEM_LOAD_RETIRED.L1_HIT_L1",
         "PublicDescription": "Counts retired load instructions with at least one uop that hit in the Level 1 of the L1 data cache. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
+        "UMask": "0x100",
         "Unit": "cpu_core"
     },
     {
@@ -1093,6 +1095,7 @@
         "EventCode": "0x44",
         "EventName": "MEM_STORE_RETIRED.MEMSIDE_CACHE",
         "SampleAfterValue": "100021",
+        "UMask": "0x400",
         "Unit": "cpu_core"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json b/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
index 8be3ea336bb8..5d8bd972d463 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
@@ -190,6 +190,7 @@
         "EventName": "BR_INST_RETIRED.COND_TAKEN_FWD",
         "PublicDescription": "Counts taken forward conditional branch instructions retired. Available PDIST counters: 0,1",
         "SampleAfterValue": "400009",
+        "UMask": "0x100",
         "Unit": "cpu_core"
     },
     {
@@ -474,6 +475,7 @@
         "EventName": "BR_MISP_RETIRED.COND_TAKEN_FWD",
         "PublicDescription": "Counts taken forward conditional mispredicted branch instructions retired. Available PDIST counters: 0,1",
         "SampleAfterValue": "400009",
+        "UMask": "0x100",
         "Unit": "cpu_core"
     },
     {
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

