Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4772848A1
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Jan 2026 09:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767258181; cv=none; b=Zbbl2oGgDuXCrq5Wqmme1P3JPm7ZQpttrSJDgbHx/U3MdWcTqSbHvb2UI9CnMaIqVunngxPtt5AKZYOIPL0Lvb9z9NxlLELXudlcBRJv5/wWvjH7jSDcKJOqLRBdnRJA70YGMd4LsRqD1hgR0W9xzDa5otVko3pA8WsYt7PvX+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767258181; c=relaxed/simple;
	bh=k9d/lT0gR+BsCohUFGgU5dkmO2RpQMNkTOvLv5F+1Zc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aVjU8lzB5vQSLShNY9QsS/bLsvdUmfUt0HcfGm++G3SPPyJEzuPdxy/OhiXvJAZ4wQFMw+ce2arJzfcL8FovwGY+4Ee9SzNA97iprHdMvMrO/Bo7nGye2d8hLP6NPkstR67TzFuvhfpW2+bvAZr9cLObBVfHTkQFI6/OQOTumB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLYnWxDv; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLYnWxDv"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso15255631b3a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jan 2026 01:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767258179; x=1767862979; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xDPN6/vJo47740N6QbPC+6K796StMLGbxQxmitpGhW4=;
        b=DLYnWxDvGA/7TsFmmppt6WZZGKkXk+BW/hsAeo659I6+5ucSGdxxjT6h1xtQGqmwlz
         qMDu7r2i2GDs0UOWvmjNNgV/mQPTlCEsiEaN9Gbf7Tn38642JxrhecJH21EA4PDpkdWU
         Jbn0Jdi2fVC3sX8f8HCHdmT8a7EpP2HaQoKa9rC0S8JQFoAhn1DWMELLNUQJKcpOytqo
         GhhTzguQk2t4EpLJLMR4/Xbm4FFyJOsecqAeyksVogv7ZIeAHi8V0TVywt3t6UsbRy90
         4NZLdR/tKBseOlz4QQrbdHOwUv47EYRgrRPXravbYVwJ347HmK0uLQAONPlzmaAOeuQL
         9P4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767258179; x=1767862979;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xDPN6/vJo47740N6QbPC+6K796StMLGbxQxmitpGhW4=;
        b=d/DsK+r3EW3Gi6c93ZEcO6VN4DQbuFLbpCpHJ8zBVgECu2i25qEoVa6see5WFxDXbc
         wtWkpMX9EdcAd+UhC6JO/M3BfUETrfN5guSj7MnjvHzy0GMsXRT0tGfguuq5vlUooDM7
         X6Ad0JDy7bVpnhcuSvKuhBCMIM8/2Oe4qYxqpCLp3RJZDhtoarbWcfkrWsTp6j1D+LpS
         6GZynkh+Ams3OSOCGZaQIlnBP3DUrlJDbB6rXGH2rnr8AY5CkeB2hjsBiXAtvAB2/dT8
         2/tdj+beYJubKFe4Ye+Ha7BouwCeVFZzX1Tv8CYx/j2dvlO/pFDU/iNPcC2V91WEscXf
         LPmw==
X-Forwarded-Encrypted: i=1; AJvYcCVDBMFFshwf9H5dmnlv3KiYig8Tfpubz95a1NdSuBhg8tMNqXxtU943ZZW93RE3L5qCuo5U68+EXkISkaQXDrlj@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg2K2W3ZDgiYxiyrkGGjclUwDXYjuyeu/XP3bPPECPJH4DiA47
	2foyrUHgIy2VA0MHTQt1OR3owT200z8U1ZSWRuwpvov84lqDm89X7POT
X-Gm-Gg: AY/fxX5AfhAg+UMYtBzs0h0clmAu2X8LLQN+Tz3agX3axkoy/SFBTI9lJumu9/Qg/HD
	4SiaXZ3IWhQoR6HmgS1pjsA0wqjvCll0znShT2LWhp09qTguv80AliZqxAPBH+gLqT/UOP0KWwT
	mn/eADbAQevUaKsz3b/b+7rr2QUqYNLr6ZXFiqJjTJKVLtX5K/8Tw6FgR4TvDZHF1K/j3+UDXA9
	xwA+PqYZarw3JBJPi3MFdOQdA5nr39NJq/GdQZum9Qre57H781pW1O7HgnBUMACJx5KuE9ObwFc
	kTApWRmhUAffYu16nSV6e0+ck6aC/oc2HnKeH2PtIYZVdwwPwMBhgh/1RMdDKZAY7jCI1+5oxFC
	sUCXh1w/8fGCNGtxnteQZOTEm8Lngdti5ozRlc/UcTmrA88aSpp1miqPhfbB4WPAZS+vNwlM4bt
	uq+gs9wxPiucZ4
X-Google-Smtp-Source: AGHT+IGp06A95VtNsDuHQDY+7c9VWV7Q35S5rGZeleM+b9X7CGhsSB3XJnieMhxkxoxEhcSW9EnMFA==
X-Received: by 2002:a05:6a00:2998:b0:792:5db2:73ac with SMTP id d2e1a72fcca58-7ff64403c13mr36009776b3a.7.1767258179113;
        Thu, 01 Jan 2026 01:02:59 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac29bsm37182957b3a.39.2026.01.01.01.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 01:02:58 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 01 Jan 2026 17:01:43 +0800
Subject: [PATCH v10 07/21] drivers/perf: apple_m1: Support
 per-implementation event attr group
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-apple-cpmu-v10-7-48812c529ffc@gmail.com>
References: <20260101-apple-cpmu-v10-0-48812c529ffc@gmail.com>
In-Reply-To: <20260101-apple-cpmu-v10-0-48812c529ffc@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2228; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=k9d/lT0gR+BsCohUFGgU5dkmO2RpQMNkTOvLv5F+1Zc=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBpVjgnrBr6sEatcXYFZIFrxk4paYlmBpg0jYmmj
 PlXMpBhHf+JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaVY4JwAKCRABygi3psUI
 JDGUD/0f8DiiF7tPJvy4tiRUfMyih3V1IJASfGdC4Rye3V+p80kHdfPEcVWUeUOgs/Ug/Uul4y5
 OOuKuCoqeoi/9EV/wtA5u6ihDrpg1Tif5RPhFJZSPaRrPFXGrZRWS/NwN9MoaNelp+0x7u5Hpbw
 BZ9HUNCfv0lu+qs15G9zPoNXzk/caXq7lBBezpLCo99fzq47eochYkXdqyrS43KqgAcUncWPQlP
 ETpVJYPgKTSRxjZQM7p25aAg4/mn562xxtGpwZ8ImLwMYyr2/F2zRoSzic4oURaVF+gTKX62lc/
 AV0zUsHPfeKIS1xcMZ8cvFiL7VGlSLGYhTLBCHPSpPgcJA6becbCMB8JJ5T8xG6nGDmN44dAsz2
 yYw2TX04yVAM8jSQ3Uj7pei1U/WDnVQo0IY8+IAgWUX9xyZxeK/xWWQGILLnuUZBF25bVCkMRTq
 9E7owcSymKYUKj459MHBzrCw6bcy+2GSOf//A5ydwrg0cdGFylNzTeMJrZXnrzrFKmGvbBDeDe1
 FyPMry6luwdhtHi/lRzmQGce0vWYs2xVX/NvnDscwpthQQ5dyxRReDZJWvx61ZpbSmyUGonx1du
 ye+RJW/1eRJLmlvp67/VhnqhmJ6GaCcL73fOpD1O1bG9Flg9GtfneDWeOVuwyGjAz90ImNDGOo5
 fBfPi1OgQMPD+ow==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

To support implementations with different event numbers for cycles or
instruction events, event attr groups needs to be per-implementation.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 0655eeaea96b46d638b0998944c30a07f3273c2b..f903cebf566be6b40f260d81a70cefa4858bc085 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -670,7 +670,6 @@ static int apple_pmu_init(struct arm_pmu *cpu_pmu, u32 nr_counters)
 	}
 
 	bitmap_set(cpu_pmu->cntr_mask, 0, nr_counters);
-	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] = &m1_pmu_format_attr_group;
 	return 0;
 }
@@ -683,6 +682,7 @@ static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->start		  = m1_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -693,6 +693,7 @@ static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->start		  = m1_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -703,6 +704,7 @@ static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->start		  = m1_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -713,6 +715,7 @@ static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->start		  = m1_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 

-- 
2.52.0

