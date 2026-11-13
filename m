Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552779;
	b=ADVAbn3M9g49Z2ijZ9Zcch9z+6Kx5YpBLIX4T6d4czHcATZQkW3X5J2M8YRcJusx5tE9
	 liFx0qqXVYaYG+5laoHjMzmvaGBKr9xMWl6OexWXyKjJ3wYwD90m8Hlun54NSwUNgR3iw
	 gbdw0T4zqfkbGXKECByyz/Tr+E6GbjCsv08TrbYOr3t0KFQEpquhHkAf/eD4RWWMfi1uR
	 fVShiyTYnv5d3QI5/hkUC7hUpAAZHBSAdmlOmPIuJHyBQgFaFi2CqFsWMRpicReQFnpdo
	 6KFuSUTru8rEWz53N4JNjI1HZmh5CJrIVcbm1xFpUWNduAWQhDZ0es/ZMI3FFESufcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552779;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VIJHAgcH0kNWNFXAVV2FGeNxRIHtnxTUPfAN1k4v8u4=;
	b=zs4dRIWwraD8iKFi6dyGXHGc7xNg5+rVxRYDAluUkiFmfvDjvK7nG9+oVOMR6rBC334T
	 bi0lJJM/uH8OMsMC+p+hGkR3YdFNp+YjJzBe8A6PoIdXv1omv8/+dSCW8K04DtEikR95o
	 bMGlcDh8GhWlZsU1hmp8/92z9tl6vkgsaoR5gax9tGpqPsYVTIaNenjYs8vdy//8P7ut7
	 PMGH4SYNYQZ0hBMDUkV9NbMyfxSh/gFGn/HbVuayftW5zWQB0RygNSYC5padffZvXM778
	 +u6gMTdFXxy6wbbDd+UffGmo0nxvs4+oAWegLYBcqmHoFGCasb8WyxNS72B2Q3hYHPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rk08dtVx;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E032D606A334
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 06:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E032D606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rk08dtVx
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b5efadd183so801374b3a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 22:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794552778; x=1795157578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VIJHAgcH0kNWNFXAVV2FGeNxRIHtnxTUPfAN1k4v8u4=;
        b=Rk08dtVx4lCFtpfuuUl022D9CDEsg7463Ro0IujuUYYx0m+kLT1CYmxAom5uSHr29v
         dCBzY40erU72AEmYZjsChyYPPs9v7+tzmoAscD0rqe2YEWRz86PFXu2a1f8LmQwOqHFa
         UoIHRK+mPc1SdThfCKBSOALw9CLE1bno63yygSz71zhk2CJ8g1SYBdPSGMHqt5I3wyea
         eKG2DAo6NYR04C8ur/j4D+iVHaWqNUaPLz+88sNWa2ApY7UOx0jLt6ZLE1dfv2TLdRR8
         z7WVn+eNOcdA3JPfUEd3thgmGJRy2aJqlORvzl1yPryjxW/L8GnFovsQn6DURi68aaiV
         mzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794552778; x=1795157578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VIJHAgcH0kNWNFXAVV2FGeNxRIHtnxTUPfAN1k4v8u4=;
        b=IKj7q408Kp+G75pClFmlUeEBtmp2OttG8hiIrVysLa4D+j1e2Ojzy9wrnlU6gQ8shN
         zfLXPNZXgSj5F1nzu0WmCJlEqiY8Z5gw0QwMN4UY6WlF9lMXFuHU4qdYzIqeuUovIt6d
         Z2Nx0LvHSQIt0JEgw+LOV43IFIJiWQ6ZR1lKQYYnUlHAXZoRVv0K+9+bAD8D94xFSeXq
         wkPCoBEcUZCjhXzl2DqhpKP7cCWEqyLRHYqne/cRJYFoMDtBAMglsKeEr03wC0Nmdecx
         iPEIxeVi9OQSFMlFTt+TtjmojUaX6mCm2mgjTlMtOOVudbhkkJbyES9/fC0onsy3akRM
         nRjw==
X-Gm-Message-State: APuU4Z/lYXj3pUc2BKk3sUhIyD7bpfFY4nVnnhAITim+AiYT/Mx/jmwP
	llj3aIU0MIhquwJhMEeA+qASwiwUjdT6xivAZ+S8guqFpHPq2nTwpPPjSeVFjg==
X-Gm-Gg: AYBFou2aRXdiR2N9Gc7LmDO74GuWHo9rUOBhHFaKqpQo3XhB2RDWb1ua+CMt/ShYe9n
	Y7KCtcJdCMvP/QLeuoV5x/AVecKmkk6Umj1imsHHont1e/dMKCZ5gZqlQs6g2qyHOXO9qUivAS/
	ztwVnj8meiYzQD/yfBa7DcQ/FXWGxPFQP1S6na8BvZEtSL8CZO8KPqbbV1JLmcA8SoVfg5ToPvW
	9csj2z4MmFNAtLT/3yROMHObmK+9qLmc+cgkUG7j0nJ34vRbU4RZ2JOb5JF4Z7uJGOi6Jf9zes/
	3C19JdH9KyfVvc8ZgR0Ct2qEvSAsBKssynEAyzo2McmApKNccDppbZOJCJ8MqjQOFrgNFOBIg5i
	1/Y7YaL+qbMS6zUySPZA7o7bUI8LPJQ7zB7gAhnIU9cb4+fO3qdYyIpFGqwX698LF3XiskChB72
	N7rPoiG6oVjFWAOIEUi75wQq32reQ9N4br1+Jlj13zUoIYzVmWtforzeD9y+M2jcOidgzZ+6zzi
	dwMgTy0QXaq4vi57v9Z888qtROA7pwZNdLAKmTcOrTfyKzwHbkPOVS0umPfvZ9WdRftY+j2xKcc
	qqtc0LKsQLkvbjOhxeCw
X-Received: by 2002:a17:90b:5910:b0:3ae:3b3d:c617 with SMTP id 98e67ed59e1d1-3b1b0cc8f69mr806113a91.29.1794552777743;
        Thu, 12 Nov 2026 22:52:57 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b3d279d8sm869257a91.2.2026.11.12.22.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 22:52:57 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: James Clark <james.clark@linaro.org>,
	Ian Rogers <irogers@google.com>,
	John Garry <john.garry@linux.dev>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v2] perf vendor events arm64 AmpereOneX: Fix misspelled PublicDescription keys
Date: Fri, 13 Nov 2026 06:52:53 +0000
Message-ID: <20261113065253.746615-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108183846.3804875-1-takano32@gmail.com>
References: <20261108183846.3804875-1-takano32@gmail.com>
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
byte-identical generated string table (1580383 bytes both times).

The file becomes self-consistent again, and the field works if the brief
text is ever changed on its own.  No text, name, code or expression
changes.

Written with Hermes Agent, an LLM assistant; the author reviewed it and
ran the generator as described.  perf was built, not run against
hardware.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
v2: rebased on 7.4-rc2.  The arm64 string table generated with
    jevents.py is byte identical before and after the change
    (1580383 bytes), measured again on this base.

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

base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.53.0

