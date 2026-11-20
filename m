Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795154982;
	b=otgwXX/+ubd8WKFuFdjqOF+ImGGffshQk9HzqRIYaq4xmpQdsrAG57DLOHLs2UkUCPY3
	 eSwgNtrmw5D0iTpXEZZ+fT7fSV9xvrB3oy8oIOXQtUkKmQktP5w4mvANlvwDdhCbjuzME
	 CcZlPybpLGpN3kim2/sn6DNSgfS4m8EstNh4fVwydtMofRmvWrjKi3AMu3xEwwvbv8/VA
	 rCxRDt27p2r2B8pOKsFjksKlbPWfCuS9hKvQrRFeocZxq3JEJwkkRkYv0vlWI5bsYhWbe
	 BBm5BldkelhbjnSoFGgpaq4sCfgw9TtSSToDr6DbVWHSKglfDLi17Q3ID6VPZ5/HA7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795154982;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3/jsMe/Qc48pu/imVYvdVloDOJ6fnxt5dXnAjgruQUk=;
	b=M6Tk80fcBJXoMd+9A1ZuJiSsvnZ6cNSRDiURI9ZOudKfAgcRq0eH8iFfBQCZJDkF1Ejo
	 i3clUT+SkZrl6wT6AN2zl19fRybL4l560pIZbOQEXDDht5rRiTvpiJL2LHiPt1wMy3NBR
	 dcQE/BoENuKrqQYwWNF3wksxxL6X2limdFkSHWcHSZIm2UT90t3TqMuMww12+VQ9UzP23
	 DqlrB/GxJ66BLxZqq10lVw1fGIqeFmF98GaJbqp+AjGajXY7GOl4p/MHAsa1lIa4ymrVa
	 YC4gDIUG+Xw4gODPjIPphKyu1gXs+LXGO3dfQ/09/PI6XYd5tPSGAIvsZ7bXRDJaVEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ZNLC/+KK";
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A96606A515
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 06:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87A96606A515
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZNLC/+KK
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-38190551625so848701eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 22:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795154979; x=1795759779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3/jsMe/Qc48pu/imVYvdVloDOJ6fnxt5dXnAjgruQUk=;
        b=ZNLC/+KKO/zsPwDZnKuVNFPUzzfCRknD54wV/ZMZhhFH9p/ceGnz/hHxMkVTEgQrl0
         q4a4bFoQBQ7gY7s6DNkjrmyMcdqtzj37mOfeF/P5CuEBn7fv2+ucpifW/AIkpdXNP6P3
         g5zDeJYP/lWSRn84wRZBZGICJ3YkdwS6DCw0HSb5eT+K/yKBN7vPHkR5vBUDI9N5yH9d
         GLxE4Ahswd/UBjWZ0vvrajQ19QLwuRUG6ZxvXBl/GWoTZjOi6Jjk2nK5b4YgTdDFyWhi
         qpdyCPrvkiuyZLxCOHHGePsGPKt7l+BmbTq3GG3hbXtNF/wFgPq3KgY1hvrPBKYbfmCO
         +rqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795154979; x=1795759779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3/jsMe/Qc48pu/imVYvdVloDOJ6fnxt5dXnAjgruQUk=;
        b=P4a072e4s9XDBp2wViCH/JOfwnI/pjJ6KMdxJDpp58qQ1VWWzezJ92ReVL2CmAInw0
         ThBj/acyTbs6E9WAqq014/n3C0EqOh5AhzpPI/zVsmpvlAQgYb06XOpE7f1YQcbksqnD
         E0tyjw0x0xONe3jNTr/4c53xrtXLU6YSwF6W932POSR30NyCsE7gHRUNdIqOso9cv4g9
         bega14O/cZXSLkrAjp+GNM4OxaN5DVMYz0cfpwCmFaj8quzrTgStoVCH9570dqvRen0J
         lGw0zdr1YuoDZ2XbWoTI+36Im7AWchP3STPebsT0LqoHV68h6qIeE76Usr8/umQ6k8Wo
         VWnA==
X-Gm-Message-State: APuU4Z+Cq4uB6RHIzgMTAj1HZcQD1/gV9elXUONkRAZfGn2ydj1d6VkI
	mlQD+FIC1jLZ3o/90YNRcEbYMhtjQ+9Q8bg2EnacNO+gCPz2HQiR3plj97nMxOah
X-Gm-Gg: AZFdTZfhJqGjjg6NoU0SoobCXq97jqkle9RJ3DZ5SwNba9VJ11U0SaA2zOpLkOLWMIm
	3A75l5Kk2iV3NFJZbNbT5uquN0zu1N4UEX1w5ezCdZ0R9L4O06so/p0yGZL45E5h2wZktcchU7m
	arn+BNcDp8eVuxrB2Am16ks5BTyNzFd39q5Go4zMjqjNT4FB2mY1ohtqDviDnINUl/HtuJOixNy
	zeF/z4i/DU9QAjWnoYVN4QuknFamS7MozqL8Fyy0zpYOayFEXnhxJjPAp2WQg7kW5R9kq1tbnUd
	aQMRmZw3Zxk4mF1ynBaoZqVbmYTHqaGQQ7FqRvHGb5iQq0L2HZ7iwb9ST9kaGY0gvtL8Dq3k32n
	grOQp7H6oHwaYitlmzPxtpLJMKPGHVKEh31cUXiO1ojVUw8CKxBNnKYfMnyzDItgAqPF8hp/AbV
	wzQFEXVU7IVFzV2q/78mo01wE+CeqkCYqfEqxWIomVM28CC33r0lgXNkrJNxlgVq9vtGkf0DStZ
	qbtXbfW0OWuL476mU8PfEMebkaK7VWKwtcnMpySefjqAFt5HFWKOiGB8VccCSJMMOzS40klKObh
	VjdalP265vGNneVaYcAI
X-Received: by 2002:a05:693c:83cf:10b0:376:b957:c01 with SMTP id 5a478bee46e88-3856f755152mr1860396eec.16.1795154978549;
        Thu, 19 Nov 2026 22:09:38 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c0c1dsm4609725eec.21.2026.11.19.22.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 22:09:38 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.garry@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@arm.com>,
	Leo Yan <leo.yan@linux.dev>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH v11 1/2] perf vendor events: Fix misspelled keys in the event tables
Date: Fri, 20 Nov 2026 06:09:30 +0000
Message-ID: <20261120060931.711483-2-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120060931.711483-1-takano32@gmail.com>
References: <20261113032927.634183-1-takano32@gmail.com>
 <20261120060931.711483-1-takano32@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sixteen objects in arch/arm64/ampere/ampereonex/mmu.json carry
"PublicDescrition" and one object in each of amdzen4/cache.json,
amdzen5/load-store.json and amdzen6/load-store.json carries
"BriefDescript6ion".  jevents.py reads only the keys it knows by name, so
these fields have no effect: the text is dropped without a word and never
reaches the generated tables.

For the three AMD events that leaves them with no description at all, and
the text comes back.  The AmpereOneX events carry the same text in
BriefDescription and the generator drops a duplicate long description, so
the generated arm64 tables are unchanged.

This is the same change as "perf vendor events arm64 AmpereOneX: Fix
misspelled PublicDescription keys" (Message-ID
<20261113065253.746615-1-takano32@gmail.com>) and "perf vendor events amd:
Fix a misspelled JSON key" (<20261108184600.3810059-1-takano32@gmail.com>),
squashed into one patch so that this series applies on its own.

Written with Hermes Agent, an LLM assistant; the author reviewed it and
ran the generator as described.

Fixes: 16438b652b46 ("perf vendor events arm64 AmpereOneX: Add core PMU events and metrics")
Fixes: 658448281d19 ("perf vendor events amd: Add Zen 4 core events")
Fixes: 45c072f2537a ("perf vendor events amd: Add Zen 5 core events")
Fixes: 2f42fb0661d9 ("perf vendor events amd: Add Zen 6 core events")
Acked-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 .../arch/arm64/ampere/ampereonex/mmu.json     | 32 +++++++++----------
 .../pmu-events/arch/x86/amdzen4/cache.json    |  2 +-
 .../arch/x86/amdzen5/load-store.json          |  2 +-
 .../arch/x86/amdzen6/load-store.json          |  2 +-
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/mmu.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/mmu.json
index 66d83b680651..9457f9be4ecc 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/mmu.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/mmu.json
@@ -30,37 +30,37 @@
         "BriefDescription": "Data TLB translation cache hit on S2L2 walk cache entry"
     },
     {
-        "PublicDescrition": "Data TLB translation cache hit on S2L1 walk cache entry",
+        "PublicDescription": "Data TLB translation cache hit on S2L1 walk cache entry",
         "EventCode": "0xd805",
         "EventName": "MMU_D_TRANS_CACHE_HIT_S2L1_WALK",
         "BriefDescription": "Data TLB translation cache hit on S2L1 walk cache entry"
     },
     {
-        "PublicDescrition": "Data TLB translation cache hit on S2L0 walk cache entry",
+        "PublicDescription": "Data TLB translation cache hit on S2L0 walk cache entry",
         "EventCode": "0xd806",
         "EventName": "MMU_D_TRANS_CACHE_HIT_S2L0_WALK",
         "BriefDescription": "Data TLB translation cache hit on S2L0 walk cache entry"
     },
     {
-        "PublicDescrition": "Data-side S1 page walk cache lookup",
+        "PublicDescription": "Data-side S1 page walk cache lookup",
         "EventCode": "0xd807",
         "EventName": "MMU_D_S1_WALK_CACHE_LOOKUP",
         "BriefDescription": "Data-side S1 page walk cache lookup"
     },
     {
-        "PublicDescrition": "Data-side S1 page walk cache refill",
+        "PublicDescription": "Data-side S1 page walk cache refill",
         "EventCode": "0xd808",
         "EventName": "MMU_D_S1_WALK_CACHE_REFILL",
         "BriefDescription": "Data-side S1 page walk cache refill"
     },
     {
-        "PublicDescrition": "Data-side S2 page walk cache lookup",
+        "PublicDescription": "Data-side S2 page walk cache lookup",
         "EventCode": "0xd809",
         "EventName": "MMU_D_S2_WALK_CACHE_LOOKUP",
         "BriefDescription": "Data-side S2 page walk cache lookup"
     },
     {
-        "PublicDescrition": "Data-side S2 page walk cache refill",
+        "PublicDescription": "Data-side S2 page walk cache refill",
         "EventCode": "0xd80a",
         "EventName": "MMU_D_S2_WALK_CACHE_REFILL",
         "BriefDescription": "Data-side S2 page walk cache refill"
@@ -90,61 +90,61 @@
         "BriefDescription": "Level 2 instruction translation buffer allocation"
     },
     {
-        "PublicDescrition": "Instruction TLB translation cache hit on S1L2 walk cache entry",
+        "PublicDescription": "Instruction TLB translation cache hit on S1L2 walk cache entry",
         "EventCode": "0xd901",
         "EventName": "MMU_I_TRANS_CACHE_HIT_S1L2_WALK",
         "BriefDescription": "Instruction TLB translation cache hit on S1L2 walk cache entry"
     },
     {
-        "PublicDescrition": "Instruction TLB translation cache hit on S1L1 walk cache entry",
+        "PublicDescription": "Instruction TLB translation cache hit on S1L1 walk cache entry",
         "EventCode": "0xd902",
         "EventName": "MMU_I_TRANS_CACHE_HIT_S1L1_WALK",
         "BriefDescription": "Instruction TLB translation cache hit on S1L1 walk cache entry"
     },
     {
-        "PublicDescrition": "Instruction TLB translation cache hit on S1L0 walk cache entry",
+        "PublicDescription": "Instruction TLB translation cache hit on S1L0 walk cache entry",
         "EventCode": "0xd903",
         "EventName": "MMU_I_TRANS_CACHE_HIT_S1L0_WALK",
         "BriefDescription": "Instruction TLB translation cache hit on S1L0 walk cache entry"
     },
     {
-        "PublicDescrition": "Instruction TLB translation cache hit on S2L2 walk cache entry",
+        "PublicDescription": "Instruction TLB translation cache hit on S2L2 walk cache entry",
         "EventCode": "0xd904",
         "EventName": "MMU_I_TRANS_CACHE_HIT_S2L2_WALK",
         "BriefDescription": "Instruction TLB translation cache hit on S2L2 walk cache entry"
     },
     {
-        "PublicDescrition": "Instruction TLB translation cache hit on S2L1 walk cache entry",
+        "PublicDescription": "Instruction TLB translation cache hit on S2L1 walk cache entry",
         "EventCode": "0xd905",
         "EventName": "MMU_I_TRANS_CACHE_HIT_S2L1_WALK",
         "BriefDescription": "Instruction TLB translation cache hit on S2L1 walk cache entry"
     },
     {
-        "PublicDescrition": "Instruction TLB translation cache hit on S2L0 walk cache entry",
+        "PublicDescription": "Instruction TLB translation cache hit on S2L0 walk cache entry",
         "EventCode": "0xd906",
         "EventName": "MMU_I_TRANS_CACHE_HIT_S2L0_WALK",
         "BriefDescription": "Instruction TLB translation cache hit on S2L0 walk cache entry"
     },
     {
-        "PublicDescrition": "Instruction-side S1 page walk cache lookup",
+        "PublicDescription": "Instruction-side S1 page walk cache lookup",
         "EventCode": "0xd907",
         "EventName": "MMU_I_S1_WALK_CACHE_LOOKUP",
         "BriefDescription": "Instruction-side S1 page walk cache lookup"
     },
     {
-        "PublicDescrition": "Instruction-side S1 page walk cache refill",
+        "PublicDescription": "Instruction-side S1 page walk cache refill",
         "EventCode": "0xd908",
         "EventName": "MMU_I_S1_WALK_CACHE_REFILL",
         "BriefDescription": "Instruction-side S1 page walk cache refill"
     },
     {
-        "PublicDescrition": "Instruction-side S2 page walk cache lookup",
+        "PublicDescription": "Instruction-side S2 page walk cache lookup",
         "EventCode": "0xd909",
         "EventName": "MMU_I_S2_WALK_CACHE_LOOKUP",
         "BriefDescription": "Instruction-side S2 page walk cache lookup"
     },
     {
-        "PublicDescrition": "Instruction-side S2 page walk cache refill",
+        "PublicDescription": "Instruction-side S2 page walk cache refill",
         "EventCode": "0xd90a",
         "EventName": "MMU_I_S2_WALK_CACHE_REFILL",
         "BriefDescription": "Instruction-side S2 page walk cache refill"
diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/cache.json b/tools/perf/pmu-events/arch/x86/amdzen4/cache.json
index e6d710cf3ce2..01c848a9dbb3 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen4/cache.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen4/cache.json
@@ -182,7 +182,7 @@
   {
     "EventName": "ls_inef_sw_pref.all",
     "EventCode": "0x52",
-    "BriefDescript6ion": "Software prefetches that did not fetch data outside of the processor core for any reason.",
+    "BriefDescription": "Software prefetches that did not fetch data outside of the processor core for any reason.",
     "UMask": "0x03"
   },
   {
diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json b/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
index b1994539ece8..774da0bfa0dd 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
@@ -351,7 +351,7 @@
   {
     "EventName": "ls_inef_sw_pref.all",
     "EventCode": "0x52",
-    "BriefDescript6ion": "Software prefetches that did not fetch data outside of the processor core for any reason.",
+    "BriefDescription": "Software prefetches that did not fetch data outside of the processor core for any reason.",
     "UMask": "0x03"
   },
   {
diff --git a/tools/perf/pmu-events/arch/x86/amdzen6/load-store.json b/tools/perf/pmu-events/arch/x86/amdzen6/load-store.json
index 4291eb59426f..4adba70bffb1 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen6/load-store.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen6/load-store.json
@@ -351,7 +351,7 @@
   {
     "EventName": "ls_inef_sw_pref.all",
     "EventCode": "0x52",
-    "BriefDescript6ion": "Software prefetches that did not fetch data outside of the processor core for any reason.",
+    "BriefDescription": "Software prefetches that did not fetch data outside of the processor core for any reason.",
     "UMask": "0x03"
   },
   {
-- 
2.53.0

