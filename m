Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794018111;
	b=EHY1yMNSK9JESOTOMBDCL5YG5xVW+Obb1+o5f6xww6cxNss0EOD853GD/jd8fdoAHyiE
	 cBCXzQwHLs3DeXeWbGXNUTjdAdKQkStuUPOYrmEE8LJNBNmXWh+oI2LAK3pAfMyliC+yY
	 j5jZgqPY3PMLvz+enPWot4oYvhd6r5UO6DHdLhe5kGC76LDyOyZ/v0BN1tpzF01+AaT1v
	 VDPuo2+EdXBwv29/dxrcsEsP+hyx3pc+s+ysUmN+o6dEEmCNYofURtfEeml4Umn8adkhQ
	 6+vKKGNdwIJtRXqA9REUY97HSLb7aHIPixTfmGUMV+2jPhgqzmztDsZjLNmPx2GUlkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794018111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gpBdG3pRFRFDOygXYdEjj/pMvx6yFZ2VtI5mPZqbzcw=;
	b=yCAHPWXV1uUgM5oZ6/OYFWmh1rqHj4GXjrlytYV8QBTdnCF2b9kiexUDllst4KsVhoqo
	 BK/NIMAyV3RQoR1RvH44yO67Eu9WkwOa1ZtKyHECYsnUbbgGO+APRBz1K8Ysd1pMlGE72
	 8WPmWtH72qLXX9mri1YVT/ZHjdQWpjnIPa9kVzqya4bgwpkjVtlaCP8FX2TZUVg2C0w+A
	 +6xdj55BBSpO4COafiErrHb3VfS/GduaE8hqWjWDZPluTfPCZoZrr4OWy+DTtMbhbkIrV
	 DJzEEPCh6RbVCxoFYhbG39hlYIu9Uht0OIuRg8YSoWc1b3qUwms983h/H69ffX0A+hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="NyvR+/mA";
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7708606A32D
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 02:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7708606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NyvR+/mA
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cdb1199bfd8so523546a12.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Nov 2026 18:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794018110; x=1794622910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gpBdG3pRFRFDOygXYdEjj/pMvx6yFZ2VtI5mPZqbzcw=;
        b=NyvR+/mAFfA3M7V1gGR2mCO2pVeaG2NOy+TdnwoN7CY5IFjwkfDK2cwanQ0it77Tcx
         /1rzkkdwkVBwqfcoL6ym9SoDVy9fZXS2pnCuYwZn2pfVNJDrC9aNiBZypz8VSJK7mR1E
         ecxt2Q1xYD2YYLcmihlz7nb70PudIgdmH4gD88zs8Qdn6qkScADWr3lpvnWQiTVJ6LLp
         x+HO8+YSpAHIOR4BYLjmSV8MB6xe9NHCmqPX3xMhlV6K82MBnhSN6ER1x0kHQYH21qeb
         /a57zhsMwhzkw9kWU/M1iBAdlhO32PcJs+lcnLF/rW31OCnkY+MB1ytS6MkHUbBQGtqu
         gozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794018110; x=1794622910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gpBdG3pRFRFDOygXYdEjj/pMvx6yFZ2VtI5mPZqbzcw=;
        b=SF3uPpnQG00Lo3TEeL1jmaTG8s/pmvGv9mXLxugF7Lp6OVotKgdtzzaAHImCXCzr5K
         ssyJdXLxN4vPVhCqCQCJRp783RtBON2cdP+mQ8MrfYjKSlECxGNm6CjO3fc2/rTfEgW8
         3lhG1m5TiscFry5C2Dn3JtsDy1YHxN3CtVZtsuDcZBrVZsQzxtGBcF99f+CYG5fXUH/i
         N6GlllMsGx7kMzrudZEfxAKXXjqPo+ZOCV+ylyFimf2utA/si62dXpZupSXmAK4HDRPt
         41ruuyS6n6Ar5R9HbfDoRF8W/pvh3b9e/iTp9NWiPA9yxMaJg+VPWPm+rtkI/bKYbUk7
         wqMw==
X-Gm-Message-State: APuU4Z8jOM6hzjKVGAF+SLPmQICRZTNs1uMv2vRvHne9N1yalzddJUsF
	MRbQWipJD9c3wxJJ1bbnKCITz2sJoaD8yRx6zDRG/eFtcniC/jmW8ZAueaXRdu1k
X-Gm-Gg: AYBFou3FPbkzSMBnuVhaURuJvrqPR1fQPTYHQctYE2dlbkEBY4BawWbNxsi8gQP8JoN
	bEOH5W3p8jEpDuO4zQxjENFqVIOJfTeG9IJSo/4LMiA5QGUdcob1a9J7yKrhCTJAcxvsstneeJF
	GtXl+ka3bQEGR1LudvdH+IDvCKXuJ2CntgcQGO0zFBIK8a/hD0kCx5ltc4Qh2ZPdrIhEnZUAWTG
	ZBRDLnUnPa6J/OXb7j5XeRQGQYasbK16zOLwTFsymUbTdR3qouG/k+9g+SaJQWgwyUcwEord6ar
	xyFOVd2NNrTDXQxFF3FWdLVMnWU/9rM2JxLZrEWocu17PAh0DE7Lb+F/LkHLFwZn5EvlYJi8toF
	V1BWEhBE7XI2bbNIDO2QbfgC0vbcp9cp7ASK91z9bHJPXJzRCCUUXa01TlVuIGl48mwuzts4WBC
	E/i8GNbe/oQUc5SYn3ZGqMeZjxko3bhbxPBtrcfard7V5VgPaVGT7qSLacq7AXN0Q6VabZ9Le0M
	kO5hDypmjYv1ahtkwiuP4SZm1klqY1b4yPw0paF3pOYAj/lpyhiknvbur4qxFNIQsiGT1g4hXCC
	QoDQXuMJrHREypcBu1lF
X-Received: by 2002:a17:90b:2e0b:b0:3ac:b048:fa13 with SMTP id 98e67ed59e1d1-3b0db7258a0mr3904710a91.67.1794018110033;
        Fri, 06 Nov 2026 18:21:50 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1057c3db1sm1287015a91.4.2026.11.06.18.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 18:21:49 -0800 (PST)
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
Subject: [PATCH v3] perf vendor events arm64 AmpereOneX: Deprecate BPU_FLUSH_MEM_FAULT
Date: Sat,  7 Nov 2026 02:21:45 +0000
Message-ID: <20261107022145.1713159-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103112609.3772250-1-takano32@gmail.com>
References: <20261103112609.3772250-1-takano32@gmail.com>
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
release since v6.8, so removing the name would break anything that
refers to it.

Mark the entry deprecated instead of deleting it, as Ian Rogers asked:
perf list then shows 0x121 once, and perf stat -e bpu_flush_mem_fault
keeps working.  The x86 tables use the same wording, and the same
reasoning brought back deprecated AMD events in
commit eda39f98bbc5 ("perf vendor events amd: Reintroduce deprecated
Zen 5 core events").  The entry still registers event=0x121, and no
other event changes; after regenerating the tables only the two
descriptions and the deprecation flag differ.
perf list --deprecated still prints the name in the text output.  perf
list -j cannot show deprecated events at all: the JSON printer honours
the flag, but --deprecated is wired only into the text print state, so
the JSON state never sees it.  No metric expression and no other file
refers to either name.

The duplicate came in because jevents checks repeated names, not event
codes, and one encoding carrying several names is legitimate, so nothing
is added for that here.  No AmpereOneX machine was available, so the
listing was not run on hardware; Ilkka Koskinen, who added both tables,
tried v1 and v2 and reports that they behave as expected, and his
Acked-by covers v2, which differs from this version only in that full
stop.  The JSON edit and this changelog were written with an LLM
assistant, Hermes Agent, working from the code and the thread; the
checks above were run here.

Fixes: 16438b652b46 ("perf vendor events arm64 AmpereOneX: Add core PMU events and metrics")
Suggested-by: Ian Rogers <irogers@google.com>
Link: https://lore.kernel.org/20261021224527.167637-1-takano32@gmail.com
Link: https://lore.kernel.org/CAP-5=fX+2eRGCHcU43sqU=gi9iKvxqyS6ipwRSnvFcap3D+QzQ@mail.gmail.com
Link: https://lore.kernel.org/42801873-8908-07a6-aed1-c7076c689e8e@os.amperecomputing.com
Link: https://lore.kernel.org/a188c604-46c0-48fb-9cbd-9eacad88b5c9@linaro.org
Reviewed-by: James Clark <james.clark@linaro.org>
Acked-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
v3: add the full stop after the new event name, as James Clark
    asked, and carry his Reviewed-by.  Also correct three
    statements in this changelog: the JSON printer does consult
    the flag (the option is simply not wired to it),
    regeneration changes the two descriptions as well as the
    flag, and Ilkka Koskinen's Acked-by was given for v2.

 .../perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json
index 6c06bc928415..b0934a7b252c 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json
@@ -35,9 +35,10 @@
         "ArchStdEvent": "MEM_ACCESS_CHECKED_WR"
     },
     {
-        "PublicDescription": "Flushes due to memory hazards",
+        "PublicDescription": "This event is deprecated. Refer to new event GPC_FLUSH_MEM_FAULT. Flushes due to memory hazards",
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

