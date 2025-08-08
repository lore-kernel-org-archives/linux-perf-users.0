Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EC827465B
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Aug 2025 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754652229; cv=none; b=Ih0oPFYXLht0Bhit7ya7A1RpdtwiJeC3mk3suhy03GCqyJkzTnQxSvqIUFtaVCBRpE6TIogeLeBEmIbgQZYiq211b8bPZIk2A+9rif7LuVbgMKaUn+fT2/I140ltGnhtNTLksSnaGnTEZWGtJkRrNWcOkIL+TifHc6wLXZrDwco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754652229; c=relaxed/simple;
	bh=51vdVVrDG2YLBYS3Pf8NCD6LBuxxPOs+8V116Ol8P34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FcDx+EYeV3tl0OQ7NaELsbYQ0xrS9fF4ZvZDRMneiZqHu9qW//ICt7ryKKLj4/OHgclA6YeTSG7s9TTQL3N2m10C5pFOZqC7yE+TIZMRwkrBqGrOqMlES0I5QADfslnoSwnHBvk6l6yEhKWtB/sNRta9hPQWDxfMGRG7mEznRKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=omJWWZUz; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="omJWWZUz"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b7886bee77so1563780f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Aug 2025 04:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754652225; x=1755257025; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CE9jiANI0cz/l/cDSr25IEHnZ3OQaeUcRCYLlwFZaDU=;
        b=omJWWZUzdcFut4gg0WYJ+7sTVTNsy45LpZZYfw9yGhUcPO02RcfstVFxNLL7WnUuxM
         TsZAk2a6ck0VKlFRqp2N00Dipo9HlnD7hqve8iZpZ3uFJRkwpEZW1gUP0THmSoMIqINv
         q5Exza0HwePNCIjnoBfvZSfy3hDMfNpcvCvfulzLkiVT9mnNs9AukNg67RFcm2yc5tNS
         F5ZunCkDvQO0eL3dEYkBDee04z+cWvDyZWV9W7CAPO72P+3SpiollnpCoc4akehWQkXH
         xrpyHF+BzP+ZUPHSm+Q5PvX2ag1GkIOZ/+WypxXwu0drJz9xYLYj8vVZr8vhWJUZP4y+
         r7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754652225; x=1755257025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CE9jiANI0cz/l/cDSr25IEHnZ3OQaeUcRCYLlwFZaDU=;
        b=YH6tj0QyiucQPO9WS8ZmJDJRJzmAlsqp6F39nIHSjC9kU8Nwx1YEvNBxi0pc35SOZB
         ioMNfrmr5kQtdfnIcuTTtcwhJjo+XJ0TGM9wXQoPLmIQJKNuEnjoW5WvsrNalMGt0LO4
         RVn+TVOE7CINAA+QZfjZnHIf5CLuE77f5ViDqPyMaYR32tCCHcQpKfbXcX6QGuR830ap
         pnjkIQeZ7smswhnqudi0ue0wb809BBzEnwosE4J6FSz59jKTxYY90RaDNMIlPgosx0JE
         YVPVGOCMsKqdMTN8yJTBj9x4PlrGdcB5uEAYBgdjVI9MLfaiB97YCAj4X0DD8YSJTWMP
         fedw==
X-Forwarded-Encrypted: i=1; AJvYcCVGTnnwtnQasNEQ8hyAdFE1aSsDNEBTh9/R/28gkxDvcQwxhMxzokdP6A0sNC6rgORj4l3T+ravL36UVnKKJs8x@vger.kernel.org
X-Gm-Message-State: AOJu0YwEhyT2xf2VGkZPgqkGYUKmmbtEZeMRfCEaTA+nx9Dtngvr4vU0
	xLm7gzd+v+WIx1VUTrIMK/eT+/XvKqM+kRBjjDVNHk4vZ1r/jUntZ+yG8ZY++TZYqiY=
X-Gm-Gg: ASbGncv7v2/UPcygeCUGl5Ws12aMEwS79f64fM1xoW3Jj8jK2Kd6b+O+SQLhGOd8kmU
	2MjwNxeraKgaX0xnkpvG3fo859dqcw2xzn20xbDMgW99gmUTNk9I9/nlCKMXRmzrCJc4k3cGSir
	mvRLuV1bC/Eytc/TvFoBhg6dpG26LIXwfYQsuEeDkRw69TcYZxGAjG2p6AbTT4CPEARcqwMAXYw
	oKyik52J4rY2fViq1gOjSd9EeD6LJnA15j2G+PduCJGcngFk2fQUock4EZIoAJX5yeOu1J3tZBD
	pAP4JXwxnODD+dRrMCvWjbvDu7CwEA3CuuoAcVbpH8By8fMBh0NYFwK7+Uez8ew5/VaBDccPEuF
	ew3P7LF7S89t7Knxxev6BL4F7apDLYcw=
X-Google-Smtp-Source: AGHT+IFB5Rhb7EHeEiI/ams6KhI9UuNHFiZtaUNiO/aRfCno9CNSrWB+oIrGqone/4N7uev3L98hjA==
X-Received: by 2002:a05:6000:2083:b0:3b8:d493:31f4 with SMTP id ffacd0b85a97d-3b900b83c8bmr1969857f8f.48.1754652225356;
        Fri, 08 Aug 2025 04:23:45 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45923c34af8sm233482635e9.24.2025.08.08.04.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 04:23:44 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 08 Aug 2025 12:22:58 +0100
Subject: [PATCH v6 01/12] arm64: sysreg: Add new PMSFCR_EL1 fields and
 PMSDSFR_EL1 register
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-james-perf-feat_spe_eft-v6-1-6daf498578c8@linaro.org>
References: <20250808-james-perf-feat_spe_eft-v6-0-6daf498578c8@linaro.org>
In-Reply-To: <20250808-james-perf-feat_spe_eft-v6-0-6daf498578c8@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Add new fields and register that are introduced for the features
FEAT_SPE_EFT (extended filtering) and FEAT_SPE_FDS (data source
filtering).

Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 arch/arm64/tools/sysreg | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 696ab1f32a67..b743fc8ffe5d 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2994,11 +2994,20 @@ Field	0	RND
 EndSysreg
 
 Sysreg	PMSFCR_EL1	3	0	9	9	4
-Res0	63:19
+Res0	63:53
+Field	52	SIMDm
+Field	51	FPm
+Field	50	STm
+Field	49	LDm
+Field	48	Bm
+Res0	47:21
+Field	20	SIMD
+Field	19	FP
 Field	18	ST
 Field	17	LD
 Field	16	B
-Res0	15:4
+Res0	15:5
+Field	4	FDS
 Field	3	FnE
 Field	2	FL
 Field	1	FT

-- 
2.34.1

