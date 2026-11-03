Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705174;
	b=vtcdacYo1d8XmkL5XiwHX5MXxQJN0e0Ah5gTQFUyRXSdxJasqNjS995DvTeRm1zxoq5S
	 T75Fn3ouu28oh/rI/URrabrBfEJ++UJSGfl+UCZlYau76va+wtqAovi/Jo+Vxe5Uy6RhI
	 zAUZ15l8qVBL/nOBu2sKAmVg0k9NFAdoOtkJwNrP0uIEItoim3xg1A5tigmk33osLy4O8
	 2Q5thCMfoVg4A45Jlgo46TJFPRRRNQkpK+SsPFJyMtozrF4uod2ydxY2OBvQ4WOTAK49Y
	 9qaCWqNeyLcR6gsRhRsE6RSf8ACa351H7UeQRWEPK8CY4ZGu+NJ0FTelNwozuX+Xycw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Lp4wdmDdDgGfM571C6SbLFLVEe7WjqNHUjb+fXlBiiU=;
	b=ICT5WkpbpMrksd/52XqPvGohg3cfnE+OeE9q2JiH2ezDwWOUgunUfmv11y63HA6QzSAq
	 hBrWSP92EHMI+u8bu+0Pdkbxb+4PIAHN4nslGF7mViVQcmGFBp29d3OuLx7jHR12h/s7v
	 Z1IFS9JHoq6rKr5c3lEk9POCUDeL1mWRpmX3tC8ESitkbsYacorTrUG8vkGUDP0WxzshS
	 yAQsw36ENlk9Ki2nSi/6DB92FA5Q5qv8fFbMlrdDvhobjQYk+C64S5sTqB9EGL/iV0XgE
	 30l1hVc62DSgLJXxd0NZ99+oNWvYnP5C9lLzq1xDawpyv0Ro43t3X359LCAuogsS8/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C+KFpBAM;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0930A606B128
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 11:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0930A606B128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C+KFpBAM
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ad787e0593so1927647a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 03:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793705173; x=1794309973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lp4wdmDdDgGfM571C6SbLFLVEe7WjqNHUjb+fXlBiiU=;
        b=C+KFpBAMKOCqw2e53JLxzp3NQkme956G4cYsQYDeAETGMETBjy0BcCeHa9PR24pfN3
         h1ZX1Yjkv50D18WdQgK3YiiDj1pFfDQ1j/+GVLnQ19HZ1qJwR9tTn11mMxQj5D2Kg3C5
         TuvTjrmJ3VRbZ/ZYiWREp0/ePH7x0tJAfeszospGjhTeL/bkeakchkjyaKsXZIKE/fAB
         /mApug4sbBP0PN0L2yjWg0C4OuOWGWqFCWZvcjBodgNUTDZDvpVTqz40oab4viCfog7Z
         x9MgP+oRLQAiccmXjmnin1guZYkPXBiIqsBnpr963oMhbvkw2MP0gq/o5ArVpn40jQFT
         xHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793705173; x=1794309973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lp4wdmDdDgGfM571C6SbLFLVEe7WjqNHUjb+fXlBiiU=;
        b=dm5qLFZfkaJ+uSxzfyQF3xC/If07CTdGsjLSfWUanfjqtp1+qa05jL8iSC3Yhhb0b7
         1N5OdEsFLb1SE+ay25+dFeUysbvXe255FqAIfEnvO6BfhThAdRfo8nWmzSIGCSugHWsB
         0AHSQ4CXAtUmML5ApeYoq8ll8RKRtsNxV15HbTz6quotzAJn5a5sziZdy9qklOg7T5N9
         eBISjFd8iWQQfmHh0ejUS7H7uiquEVBh1qTdjw96ne1etrq4WmFPEUtITsgNeV5TayZ7
         /yjclqSQyjIUWKoZqOdbL894t1MbTxjINseE+h+QurHIXqR/aeQNM/j2UrCbbDN2g0wM
         4hFw==
X-Gm-Message-State: APuU4Z+jiCG45irbw3iX9ASdT9hyGAvJdisaade876WfsETXmpMYpeHR
	DSEQ+3lcm84fDrL3uAj2+DIfqaixHctBBmDFXct1NkpT08kFP4S4Rqsype6G2Q==
X-Gm-Gg: AYBFou1k10YgA0rutakzRgUA4rU6karl71lTwbjY/GZ4vmr7RbZEw/+oZM0c9vlxIVd
	h70fie2xomzhVmixvEKOzqmVjKQD3YXPYkdc8VLDaGKaZ5OEX2Yp/xWB3vHbSzJwO43W1yCFD5l
	8AvrW2+2NRsraWtGbCEyY77yrXvN/4oESKxFPBmHncqDe2yvMj1Q85wNZT8OFK14jZfLDhhfyiC
	wemSMn3FIGXL4svOcKm3LGoaBc99V8R++qOwHsZAlzC0OtphB9MLqId4Rt6mLZ7H5eTNA4ZJ/Tj
	7QMQoVdznlfR+kpT3jw8HPdJZjw8vj9ADpUxOKx0wA6BF0dj+pOpCAnGX7N91TOMzj0mWpdOFJ+
	BsZ1UsI/8eJELWBt96xGns4DpzHV9t12rV6dZLzeuNfZUDRIZAfHKzdtj98qgn4Cl+KG9uLW3jQ
	nwoqinhgA+CAKZZ6+CPADdna4XMAswhEPOWEKlrf6pv0I1f1FX9hKJIdmOAHoW8QM+E6ItcJnQY
	JIUkhc2G6NjpWr7wveiuJpSyAryMqD6a2vNTYL1lcLnZ26jFpeD5wGMOk/lFHaIqvnWUVMzR3ME
	cSZ1UxYp+5mGYPZ84FLD
X-Received: by 2002:a17:90b:2e4f:b0:3ac:8897:7ba4 with SMTP id 98e67ed59e1d1-3ae8957454cmr10055518a91.5.1793705173332;
        Tue, 03 Nov 2026 03:26:13 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c6740a1sm4008443a91.10.2026.11.03.03.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 03:26:12 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	John Garry <john.garry@linux.dev>,
	James Clark <james.clark@linaro.org>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	TAKANO Mitsuhiro <takano32@gmail.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH v2] perf vendor events arm64 AmpereOneX: Deprecate BPU_FLUSH_MEM_FAULT
Date: Tue,  3 Nov 2026 11:26:09 +0000
Message-ID: <20261103112609.3772250-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <42801873-8908-07a6-aed1-c7076c689e8e@os.amperecomputing.com>
References: <42801873-8908-07a6-aed1-c7076c689e8e@os.amperecomputing.com>
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

AmpereOne named event 0x121 BPU_FLUSH_MEM_FAULT until
commit 10a149e4b4a9 ("perf vendor events arm64 AmpereOne: Rename
BPU_FLUSH_MEM_FAULT to GPC_FLUSH_MEM_FAULT") renamed it.  The next patch
in that series, 16438b652b46, added the AmpereOneX tables with the old
name in memory.json, so 0x121 carries two names: GPC_FLUSH_MEM_FAULT in
core-imp-def.json and BPU_FLUSH_MEM_FAULT in memory.json, and the
default perf list output shows both.  The old name has been in every
release since v6.8, so deleting it would break scripts that use it.

Mark the entry deprecated instead of deleting it, as Ian Rogers asked:
perf list then shows 0x121 once while those scripts keep working.  The
x86 tables use the same wording, and
commit eda39f98bbc5 ("perf vendor events amd: Reintroduce deprecated
Zen 5 core events") brought back deprecated AMD events for the same
reason.  The flag is only read when listing; the entry still registers
event=0x121, so perf stat -e bpu_flush_mem_fault resolves as before, and
regenerating the tables changes nothing but that flag.
perf list --deprecated still prints the name in the text output; the
JSON path does not consult the flag, so perf list -j cannot show it.
No metric expression and no other file refers to either name.

The duplicate came in because jevents checks repeated names, not event
codes, and one encoding carrying several names is legitimate, so nothing
is added for that here.  No AmpereOneX machine was available, so the
listing was not run on hardware; Ilkka Koskinen, who added both tables,
tried v1 and v2 and reports that they behave as expected, and his
Acked-by is for this variant.  The JSON edit and this changelog were
written with an LLM assistant, Hermes Agent, working from the code and
the thread; the checks above were run here.

Fixes: 16438b652b46 ("perf vendor events arm64 AmpereOneX: Add core PMU events and metrics")
Suggested-by: Ian Rogers <irogers@google.com>
Link: https://lore.kernel.org/20261021224527.167637-1-takano32@gmail.com
Link: https://lore.kernel.org/CAP-5=fX+2eRGCHcU43sqU=gi9iKvxqyS6ipwRSnvFcap3D+QzQ@mail.gmail.com
Link: https://lore.kernel.org/42801873-8908-07a6-aed1-c7076c689e8e@os.amperecomputing.com
Acked-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
v2: keep the entry and mark it deprecated instead of deleting it,
    as Ian Rogers suggested, and word both descriptions the way
    the x86 tables do.  Ilkka Koskinen Acked-by v1 and asked for it
    to be carried over to v2; the description wording was added on
    top of that, as said in this thread.
v1: https://lore.kernel.org/20261021224527.167637-1-takano32@gmail.com

 .../perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json
index 6c06bc928415..114f95e41e0d 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json
@@ -35,9 +35,10 @@
         "ArchStdEvent": "MEM_ACCESS_CHECKED_WR"
     },
     {
-        "PublicDescription": "Flushes due to memory hazards",
+        "PublicDescription": "This event is deprecated. Refer to new event GPC_FLUSH_MEM_FAULT Flushes due to memory hazards",
         "EventCode": "0x121",
         "EventName": "BPU_FLUSH_MEM_FAULT",
-        "BriefDescription": "Flushes due to memory hazards"
+        "BriefDescription": "This event is deprecated. Refer to new event GPC_FLUSH_MEM_FAULT",
+        "Deprecated": "1"
     }
 ]

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.53.0

