Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795579226;
	b=CQ2yz0aB1bayw8idg6AYquUqF30dEWnPpoWDI8rqHkHV5okMC9juNKHVQf0Z0sI0VZeN
	 /K7JhokTo1PARfdGMfrL/3klhghPSnC/s7+K2jgpXbr/DAJ0XqFZ/9VPZxTLgLvu9ZHbe
	 OlC06SkJZR6KzLs3dNxFDQqQ0U8Do4VlUiECn2xFHmwvyaAdx+vz5g7dShX4Oz+OwdCsK
	 vGUnKNhSEDxHy37X/wMYx4pCpBZrrjMdFXwDt2wnTncUKGQQX9SVkq8x0SZ4iJ7LRUOU7
	 V6qpSRcaINzXwYrZjmelD6IbWM63syG3wxk+AeR5bpy38AuK1uuruy9XrricwoGKNgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795579226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Z272wPPw5zG0BP9Dk4LUCTCHRpu0SV9ZoE4xf+jSm8M=;
	b=mFXXQmT53UG4hlnx2H7seeY4s4fKsMd9/rA6yrcIwqpesUohMIge8rN+uA6e9FhOQY4v
	 8PHlQO13AZPWAyK3ST1fJv/hjEXXhQ59MXv0QvliqQe8sV+iPFVHS6suR7tGAEDVshIEw
	 BLI0eWe7148wurU8PNBqkW2rD0T3eMyhr0x5YcJoov5BM40mMWMV+goGUnxLPgqbJ5igI
	 I68DgYlUERhFpb4Rb3T3sUVDzwncyRvSaWEMpJ2Jjzh8+3etTs+g4ObOrQZvFfYAFA+E/
	 NagA9XElokYZQ7aJUk9etPgSpFaYcEtreMgd3UXnznGMQJKeCmXYmX9BHmDdCViEMtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RJpK21Ep;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA06C606A339
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 04:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA06C606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RJpK21Ep
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b546061d58so11951778c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 20:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795579225; x=1796184025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z272wPPw5zG0BP9Dk4LUCTCHRpu0SV9ZoE4xf+jSm8M=;
        b=RJpK21EpflpA3/7NObWyZFF1JNJSszim3rhf+YafYYjaM2mX+PBbXaAQW+qeVLLTSD
         SSa9XJdmEjQT7ZlWlx2TZWc+KXzgjClEMEZum/p6SUKXH859QgpNVT0BC/GKQIV7KI61
         w2bOyjkIK2CkGlxwlOc2AHx4Ial3b1KzOY6Ob3nnRcB8Fy90M/pQOE+9VJP6s/OU4VUr
         41zB+UHvTNGHzHcLf7bAR3ejJBikTJ1qhkwl0UCu/Fs5s1F2YmPnm91JPpIZBYu14UJY
         hWotx7eZVGzOAS5q4gI0i158tQgSE4OeW3pjG3YB/eRrZLfxcBPb2NsWJAiP82Q9Lpdr
         KqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795579225; x=1796184025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z272wPPw5zG0BP9Dk4LUCTCHRpu0SV9ZoE4xf+jSm8M=;
        b=CTuIQCCwM4GSwaInojyiY9TUv8VcnqVnKgXfMYPMUssl+qNdBHl9tC8PvJVgRDA2s0
         fW8S43Ngmj3J2Dv3glyXBrCeLwNlQP+4+ZvO4qnGc2wJbQWpB2/TVBMNZWNnXjlgAMYG
         3LBmzyfgv5oikvpxBz8MH84jQjGVshfpqiX+Kl3iBb5T8a/yo0CgEeKqvePCTX73kgWs
         vrq0qj1TpMtp8NiZ8BJ6S6EoprhtvE0cLuExPRe9gkRjlIS+mCC1vGI9tGvYDU0MdbWU
         C/Q/G/GBt2ciy4iM80Ia2u6B1mXWCiBvBYwtvr31hemldJq5SPKlr9Ac9k49LT41X6rE
         DXLA==
X-Gm-Message-State: APuU4Z/Norxjj1y5JMMuG0sADzd0mfGQUIc3XcGkhPHmu2JF47I57pA3
	WBmQEMHB/IKQRoXOjpgmeWswskhW2M9YUKdkuiJujzHaacHufrnjaqcwxU77Ew0l
X-Gm-Gg: AZFdTZeiSUfjn4Kn7+ZVQCV2Gu/yYW5gSAOdBcmftg0+cqycgEvbOAVXBpXAsEVC0+f
	xTh5t6EjHClKhrNIyPVmCsFUwY+0kST4B5CNWkD8IAQelqLYZ2saGAMlFgCQpPq744AjTHoYbzO
	YuCI9qm9G5h9FdQuizHEWEWKfX+ZogD22ZnFqPdPNuRyzzQ7I72f4NsEBOJhpaRYmOmyxoxdMHO
	kf58CyVD1b1QlBPpePAiI9pCVvI9qGZ7AJkwAUk6FfgwQ9W1/VCdXBrHWBTwFzJdcLNxoeGa/1X
	oSmoLDMPUbFzStVVsgQ/e+lUm/PJHSnTqTBiEO169JbE8Y1Bw0+OUUHjO23pIQ+8i7pilbG+C/l
	mWqkFEyf3sP+P14GkAGksXj0LFmgwOCi5gMsYAw/HP9b5ZqTpO1FeuAvz0kbSw65+8wNRydP9y/
	iSwYHepfmMNGZcpBqnmxoDMnxVUYVlEaMTGJUqslv1UKCpum0OXEeuaICDdizLKyM4vqvvev5F8
	Uw/+j2gTXKEMGw36cSee0kdwtbvoLBPkxdFb7iSWRHv5vhgUBo18Sn4K/Nd+2b39RYQej6Hx4M3
	USJitlsdVGyJBr9PDLZu
X-Received: by 2002:a05:7022:92a:b0:143:26eb:18e9 with SMTP id a92af1059eb24-1b5568eb4dfmr23336562c88.28.1795579224787;
        Tue, 24 Nov 2026 20:00:24 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55684c85fsm57094127c88.14.2026.11.24.20.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:00:24 -0800 (PST)
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
Subject: [PATCH v13 1/2] perf vendor events arm64 AmpereOneX: Fix misspelled PublicDescription keys
Date: Wed, 25 Nov 2026 04:00:15 +0000
Message-ID: <20261125040016.1675748-2-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125040016.1675748-1-takano32@gmail.com>
References: <20261125040016.1675748-1-takano32@gmail.com>
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

Sixteen of the 28 entries in mmu.json spell PublicDescription as
"PublicDescrition"; the other 12 spell it correctly.  jevents.py reads
only the keys it asks for by name, so those 16 fields are dead: the text
is dropped without a word and never reaches the generated tables.

Fixing them does not change the perf list output: every one of the 16
entries has a BriefDescription with the same text, and jevents.py drops
the long description when it equals the brief one.

Running jevents.py for arm64 before and after this change gives a
byte-identical generated string table, pmu-events-string.c.

The file becomes self-consistent, and the field works if the brief
text is ever changed on its own.  No text, name, code or expression
changes.

The three AMD entries that spelled BriefDescription as "BriefDescript6ion"
were fixed in a separate patch, which is already in perf-tools-next as
commit edd09316bd37 ("perf vendor events amd: Fix a misspelled JSON key"),
so this patch now touches only the AmpereOneX file.

Written with Hermes Agent, an LLM assistant; the author reviewed it and
ran the generator as described.  perf was built, not run against
hardware.

Fixes: 16438b652b46 ("perf vendor events arm64 AmpereOneX: Add core PMU events and metrics")
Acked-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 .../arch/arm64/ampere/ampereonex/mmu.json     | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

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
-- 
2.53.0

