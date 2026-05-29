Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B7B38C410
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 04:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780030385; cv=none; b=E7c6fHf4J5jBcOFI/eIhD6OGxH2iseCOyfZi0yiQ151IzPMkwNoXTo6S44w+BF0qUaLUKMjm/ccVZeFTkc7EPxSa03EMpEFKwQPJTLPSUv8vXCvCeirWinc6DFr3DCNrjLLcUqgI3MHeYZnoElwuCWzT+disL2yKMEtVQ/hJVHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780030385; c=relaxed/simple;
	bh=/fPq/RrdFH1LUkHJg07DzWsDeZ0uBdvxsVQIztEztxw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GT96AIxZXVFcvItHlOdFa0P2g8p3eyLzB7FAHpETQEYDrwjQAIWYjHTDCJZ4mDd+k7wrvD8mTY+hnH4Fb4Wu+I5GrK5jKTWJtuVpPtTPHERboe5DIk8N3aHkbc/n02dm+WzxNhisS97S4MpKauR+Omi7JwgrADBlUOqSZIQmKLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OoI+UdRA; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OoI+UdRA"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b4530a90fdso96053955ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 21:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780030381; x=1780635181; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ov+ajvhWEvEJoWVffhOo5d/I4k27kOwcpZYwN40Hqto=;
        b=OoI+UdRAJ6K6inZLozVag/X95FJQ/znm3Es4J8T7mwz3fQAJg7on8MXJPMqwKWchPw
         gx33yE2PJwEshq+vH+SwOKissZqN75q8a0dxXfLHPXA33hdaYSF+uW+TB090lSXq2aTr
         9702l6D99p78H3URYheHJZDJJ4Zv93G1QwY2hKRwT9lAyXr5uv8WGhBz89hNnvWvJNZM
         Faug3MOOtHdPzlWUxXbJu4dKLi/Rr55gSWhPsgWkOLufs0vhrs+VjRxJ5QfFp/f6FYb4
         qG08Wp7EFlrd99v/Wz02Hm32zj2quINwg3aq32OHgouKxczabiXY8P8rx2ux6/YgI4E2
         NECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780030381; x=1780635181;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ov+ajvhWEvEJoWVffhOo5d/I4k27kOwcpZYwN40Hqto=;
        b=iPhL7dEuxPj63bNfRYQLnx4vRLRsogf25jrmUh7rh9YZSlMdW3pbLtdHwbIWrgpao2
         RxlhDEuFpYNDDuxH2y/36/HKIEVLIcGRD30s7Bh7W+wRn7A9zT0IkiyDfBBHeI7pVU7X
         ZgRxin/xk1FBDeqBJx+OesyU3DYH+mLqkNMaVqomkcg76n16vQU9GM/Gr0Ub6G0hIa4V
         FqYSCP8ZMVScmPqXP/G0/wIQHRn+TPxo70V7rTyDF47hWRU28xdUd3/AVwUZtnGgFNeZ
         oEIOXrZs+l3ZYTgF7pKaBHF62J9bxi+vZQsxckl/r/mo+dEjkLXf9TPuf4aMZMspqKW0
         VJxQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Ys9qydObKiVF1lUsLfkoA+Ne/Hi2e2XGs3l/QOOeRe4F3z/ZWqSH3YMvXIfXGoUrWn6CUht2AIvRZjAuR7zxh@vger.kernel.org
X-Gm-Message-State: AOJu0YwKGQPKka0XL1dXnry3BlaO7hFOgR2obwKyzK58awuQkZ56oZSJ
	4P6qkctZMdtjU+24xgu0LQnYzqVXuW++5JRlJnnpn+CGJAGsncw2Xe9wcpkMeoQaLn7pZ3wwWoL
	H+xv7BgzKdQ==
X-Received: from plbjc6.prod.google.com ([2002:a17:903:25c6:b0:2bd:9b10:8067])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2b0b:b0:2bd:d7b5:83ed
 with SMTP id d9443c01a7336-2bf20bdf1a3mr19071465ad.39.1780030380954; Thu, 28
 May 2026 21:53:00 -0700 (PDT)
Date: Thu, 28 May 2026 21:51:50 -0700
In-Reply-To: <20260529045155.311805-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529045155.311805-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529045155.311805-9-irogers@google.com>
Subject: [PATCH v1 08/12] perf vendor events intel: Update lunarlake events
 from 1.21 to 1.22
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
https://github.com/intel/perfmon/commit/fae822a0f9318e602902eeb2166b966a28c715f8

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/lunarlake/cache.json  | 20 +++++++++++++++++++
 .../arch/x86/lunarlake/pipeline.json          |  9 +++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/cache.json b/tools/perf/pmu-events/arch/x86/lunarlake/cache.json
index 2db3e8a51fbd..92a3667b4520 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/cache.json
@@ -289,6 +289,16 @@
         "UMask": "0x2",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "All requests that hit L2 cache. [This event is alias to L2_RQSTS.HIT]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.HIT",
+        "PublicDescription": "Counts all requests that hit L2 cache. [This event is alias to L2_RQSTS.HIT]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x5f",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts the number of total L2 Cache Accesses that resulted in a Miss from a front door request only (does not include rejects or recycles), per core event",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -387,6 +397,16 @@
         "UMask": "0x21",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "All requests that hit L2 cache. [This event is alias to L2_REQUEST.HIT]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.HIT",
+        "PublicDescription": "Counts all requests that hit L2 cache. [This event is alias to L2_REQUEST.HIT]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x5f",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Read requests with true-miss in L2 cache [This event is alias to L2_REQUEST.MISS]",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json b/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
index d98723b3cd78..d66eafccebbb 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
@@ -315,6 +315,15 @@
         "UMask": "0xfd",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of relative JMP branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.REL_JMP",
+        "SampleAfterValue": "200003",
+        "UMask": "0xdf",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the total number of mispredicted branch instructions retired for all branch types.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index b97d19ae4264..4176d22da1a7 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -22,7 +22,7 @@ GenuineIntel-6-3A,v24,ivybridge,core
 GenuineIntel-6-3E,v24,ivytown,core
 GenuineIntel-6-2D,v24,jaketown,core
 GenuineIntel-6-(57|85),v16,knightslanding,core
-GenuineIntel-6-BD,v1.21,lunarlake,core
+GenuineIntel-6-BD,v1.22,lunarlake,core
 GenuineIntel-6-(AA|AC|B5),v1.20,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
-- 
2.54.0.823.g6e5bcc1fc9-goog

