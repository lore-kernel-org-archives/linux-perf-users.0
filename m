Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794163132;
	b=FmFzG4IsJpWRheNXWVRxSBjN4tA7/onZPfuBHhOGN96IFfNErhTMTS9mOVc94eZ7dcSX
	 CmO3JCxDGA2AE3q8J6orH3elhB6ME+vmxwb101C/N8aMvrYxKMhb4hqYXF2RI2HxBtGJQ
	 pAiio7zY7o71xyLOsGZXcGSXrtpjSamL+791apjh+cvTdZWhdJIQBTmLWEpCV0vXHk+O4
	 Bn1ycrdCa9H8VAJAxbSUpV0PPPYFEnq76m5o9mfNh2qycss8W7TP0kp3lcSb6HjaFntXJ
	 odtrtXjj7TdxVLWo9LuMWFj9Mqd1C38Gzw1P/y4qTuhmQJjH3bOwOwdkqteniwM9umw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794163132;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=/B4X/7yk4kEItQksOCxb/0SjSH6EesHie45gtXRCpSs=;
	b=QLeCKF6078wiv+JiGhJXhXVNddCHGKvC1MxphdyYQnkxjTg1mtAAfigNOq8Jz4k/dMsf
	 X+QL4hvPmmIH2GYeF8yXMkyVWCBIpkonKhnuPpB4dFkYdBPCoE58yYao8YkUP5H5zJTwR
	 6xRCo4IKGWJiusvX7QHOqRrLi6Hz/yh9MJRZH5odaH8+xVoAFvaQvvBc13DsfOuxV6xTv
	 hYW7cj2OdNTq+8O9CcZwqHfntKpqFbwhWsJpx+hYnEQu0Q1YOdimYZZ5etzk4acYe4IGl
	 6WsOuQL9AkefThb1QOwMkglsSee9eSHDtCGsg/Zq4wlfBDWyrnsgGzAGYrMzipdWCFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BAEQjiHm;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF98C606A320
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Nov 2026 18:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF98C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BAEQjiHm
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-15ea896ddc8so426298c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 08 Nov 2026 10:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794163130; x=1794767930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/B4X/7yk4kEItQksOCxb/0SjSH6EesHie45gtXRCpSs=;
        b=BAEQjiHmB0a914QPpoh2bd0TOlBdK1HpC/KZDK8VMMByjuDA1YtcvBKNqLxLAfqgrE
         JLhI0cfVWdX1qTkHryhVy0Uncr8y0RH9eIjMFeN6q2k1W5Get/4H2dUrZfgnaUYRancd
         o/0wgxynpCBnsJd7x4fqbLDSPBFDWCmJt+9acyRw8YJah32vaTlYS7N9ozTM6+AOUZ+v
         LYZXS2cRvIq0S/+ny8I3I+RePxwDFOiVd78oNeZp5+SwHdRQo+ULruZXE1/xRBYzIOnN
         rLduUE2g7n51P82fvMsKFeQVlYPuSugd7E4NufHB/iGREy7R6zc4W/tXy3frtEdbKAwF
         I7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794163130; x=1794767930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/B4X/7yk4kEItQksOCxb/0SjSH6EesHie45gtXRCpSs=;
        b=hRPNt7UaZn+b3P02uMoPBncdE+bx9+q9cNdhYYOuv3g/ScpSS+pRHAZNA7x8jPtOt1
         WxhIPWhenvVgLCmsvF5DMxQ+z5XjvhoBPwwm7FORJM/duSvWwGpjrqvQiMKmWqAwrEHv
         ZV04NcX3OKfY3EdnwFt2IBWv/4AMjkukNYlt9j/y8bxy9fvjPuqM34+EcZwLRrHJmRSb
         /qH97lu+XI3uQgirhkT4jP4TXdwbdEcRbCoG/eaYPUYYxL5hElXLzpZbT1meD3EDIsll
         pvVpUc8Nyo9+adaT7h+iI4Tv6/vpIVFS4VSztJa6Nhb1QCbNBW8YfXSuhq7+IlGS0BPW
         1Etg==
X-Gm-Message-State: APuU4Z+Gm+ck/+W5honZ4awiEQCfDW8jjFRw3i+jtqpIYb9h3YCkFAlb
	TPqNcO0NLxwiqbiMZqlt8LZieeKrW8x3zikdMuR2H+elUC05elH1ad8LzGsYcA==
X-Gm-Gg: AYBFou27rEiO/t/VThqyJm9NXigA72eCDi3fcDrzmbFf3KJJa9/9xjCgL0u4hlH5dKe
	1TLH3NylUDTIhq4YvD9RM8Wop5/+e3bbfUT3QMgDTc/T3b1pxDWYZ2Yw46tGe8+rPFW+niXco59
	iohtwBc4BV5yGYzv45Jgna4WpNVb2L2EnnMqwcL7WktWdBXMt63/tptXAn/XxEqGl5wV6jkDiSI
	pffwV8MrN23nNA9pN3O3CcfbDhbhotOLZFN8j0r8FiMTf+sqRIxqJGHQTdEN1NxxVKyRXTZc7JV
	9aJrDj31KZEw2uHRTSn5+oo94cae0w0k/7pC1azjd95JZgMghlAkRR42LsZHoTOtBjRuw3DJOR3
	VmxV38ZOd99KZbNEN0iCVmPc3zXPCM255FONrjlDSBw0bZROz5B/7xjQzkw8i5R5A6E30x3mKOJ
	aMvP04Fj8vTyRsFcdTN1aboxSxibZ9TFE1RhMLXMFPM29nJs+5V0G19wPqSwTRsgJGNF0vbdziY
	TpT8d0XtYCD0guNJ50FzHRf03xfjp5Rtsnuk7smPtdg6ltr7t8ecQHUz51WHh6n0DEFr7Lcplmt
	RjJGYJEyPbdCotOgcbAkLvPxVxYunC2ZA/MVv48C6Q==
X-Received: by 2002:a05:7300:ea17:b0:36f:6d81:3f99 with SMTP id 5a478bee46e88-37254d99c2dmr3974841eec.7.1794163129784;
        Sun, 08 Nov 2026 10:38:49 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372632d7d62sm10527237eec.3.2026.11.08.10.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 10:38:49 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.garry@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH] perf vendor events arm64 AmpereOneX: Fix misspelled PublicDescription keys
Date: Sun,  8 Nov 2026 18:38:46 +0000
Message-ID: <20261108183846.3804875-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
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
only the keys it asks for by name, so those 16 fields are dead.

Fixing them does not change the perf list output: every one of the 16
entries has a BriefDescription with the same text, and jevents.py drops
the long description when it equals the brief one (jevents.py:405).
Running jevents.py for arm64 before and after this change gives a
byte-identical generated string table.  This is a cleanup, not a fix for
anything a user can see.

The file becomes self-consistent again, and the field works if the brief
text is ever changed on its own.  No text, name, code or expression
changes.

Written with Hermes Agent, an LLM assistant; the tables were regenerated
with jevents.py on top of this change, perf was not rebuilt.

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

base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
-- 
2.53.0

