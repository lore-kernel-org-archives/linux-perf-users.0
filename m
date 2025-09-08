Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFF72FB98D;
	Mon,  8 Sep 2025 10:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325677; cv=none; b=LQW0kMVUVfP0hnrgxJk4uCgPAsz8qHrnKbXmknE/OedYTvFk2uB682r/dJ1v2ljjlHGx8L7a81wdPTaQE6a58i02Pn977h1aRcaG4rd6oA7vduSPZD0T3qqR1pEvTrsEmDje1VmOjIQAMCSvWK+2/G3v990FYncb7P2LtvrBBio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325677; c=relaxed/simple;
	bh=HNTQqQJemqX0WI0eYRGH+l+1PjBhJi/4JkQ/C04BuCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p4IPude9sxwtm2tlW2aQI02JXGtWfz9Gm9ELaCbhVbtJ5kkDPRhaHn4IXKni8BvsJPBCrzWK0nPkJDFHHS3E2YqiqwvfFoatvoodFloFdM3dfJX3ngAZybXsTVE6+pRZKclTjWgJ74DAI2aN1wphF6TT4KEOfd5veo/doQEk3/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9mPCh3C; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9mPCh3C"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24456ce0b96so44002785ad.0;
        Mon, 08 Sep 2025 03:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757325675; x=1757930475; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gfwDPpCiVyJ0buY5NGtfte2dcu4mrKn89k8yErLBKTw=;
        b=R9mPCh3CIOMCx80sgY750KZ1VZ/hrsXXZLrXA4eyY16h0UMzPVE7dkmqQvKWYnMWPo
         56oxIljtfUdFVOfYIkzJF4liKVbVTk2FdljbBLr404tbbLidrqk2Hvvou5RBJeUTOxOA
         fwqxjPy0f1c6jlyfj6JBcg33aM0F5XyA9Y2B3J7XBCz7Y4hFbf0obuBdvWf1MlvBN9E9
         DYvOE/VrtLE7DW/jxevA9hxAZXQOzdd6oHWjQUvw8MkIgIr+9mvAASDoPGbhtUOPYJy2
         FUQRIXXniXrMzdtFNyz9cr5ItuJTnDyGTDTeExofoyToQV4HsmbdjifqWqP2hiCEbYD6
         mx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757325675; x=1757930475;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfwDPpCiVyJ0buY5NGtfte2dcu4mrKn89k8yErLBKTw=;
        b=PkpueHsYzgGqr6JEGzHa69pr3mVQKsz9ao7XsjTzt/+D6dTPo5M1Tr9llWyNc+d+L2
         ywoHBBiqYsDDpzeVFSN3bzaH24HR/vOJ1/567fkWwfbokDzhDjlAUiVxDjF46lWqkGF8
         5bB99c4Fxu30imLhP+/FAMcMfCRtEiccCYhgB4ylhclTQDwqnNjcAztvLTUEfXo8TECH
         tj0oagtB+F5QJnFPYZ5U5f0iL3XnQCtUWCNfEiO+6NIed/clZ33f+rg2e2q/h6i8ecu1
         3vV1pk8+59zWeiT+jjXEzDBYj1xq9mvy5DUEDwxcJjf7w7PfevNTdgYJpnBxazNkbMK8
         JozQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcpGLcj29UQf0kfFWAx4spefxfL0eRn/0tEJCRdmKrmLfyL3wQagFB4rDY6FVvNL3hg2xhmXGVPx2d@vger.kernel.org, AJvYcCVzu4MukOfdtc3D91ztQ30zdNxOs5FiZPB0B1SxZD8fpo7L+FBfKqqlhsZ7PTtZslPfJCm1lI9x2bVrSVFE@vger.kernel.org, AJvYcCXXUCJS7MR5pKM8HzGGGpBL+GDRSpv07fSRJct3uNdLTtbIf4CslNa70wAntfJeT5NwJHBgM6+ScNg1FB9lo278dw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDvRSbf4eV6j/q9sFagPnCa3tsKhECX280j19UQKbz/VZmLOrq
	H3kZVkK8+rtekEnNDiXGamkuWd4s/K6m+rweUlyeBhmZ6zz/H22QZNdA
X-Gm-Gg: ASbGncu8VzwdFJocyzPoYGi2kB85SG8wxd5x1r59kVPun+l+wwjeIYccNryfMasYg5u
	KCoi1AAH93v8Uz4dirXgce3TNl5cHPhD7SkkDZukXcO3L6a/H5UUXDS0+uNcbfdAu73s4zLxOsq
	wKEw6e4pzy0Mf7bUR3Z1a80ASZRcNY31DlXfVavQAd3n0lLxYviA3+xW1AuazK9kTKkL4cGQZ1v
	Weog+2Dcn1mUEi4+mifrzamOszmiwPU8m1xBes5H2496SD9xV9eRtL1xkhQgVGt0fc2RV80wxxZ
	UuA6EP2SDC/OnIKsh2cHDLUoZPC4hTo6ljdA7XDdX7+y6mojw3A9KhtGUOfabXzMYWkoKQqoJGi
	GUN1yO1NfvJw7UIgsEpdro0lL+kGoWBzwPTl1Uw==
X-Google-Smtp-Source: AGHT+IGLk7qlbfVScOMCIeIb42XcLnwpLlMwiHFaoZOJPZ+XNLGGX7CNUjJexYFNYFgrdXDdh8bXbA==
X-Received: by 2002:a17:902:c653:b0:24e:7af7:111b with SMTP id d9443c01a7336-2517427bc46mr80800895ad.6.1757325675347;
        Mon, 08 Sep 2025 03:01:15 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-24ccfc7f993sm107826545ad.63.2025.09.08.03.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 03:01:14 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 08 Sep 2025 17:58:31 +0800
Subject: [PATCH RESEND v8 07/21] drivers/perf: apple_m1: Support
 per-implementation event attr group
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-apple-cpmu-v8-7-d83b4544dc14@gmail.com>
References: <20250908-apple-cpmu-v8-0-d83b4544dc14@gmail.com>
In-Reply-To: <20250908-apple-cpmu-v8-0-d83b4544dc14@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2222; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=HNTQqQJemqX0WI0eYRGH+l+1PjBhJi/4JkQ/C04BuCI=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBovqlD34FCamS7+BvFxzQI9pN7EpC0Hbp6D6ALC
 y9ge2t7aEmJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaL6pQwAKCRABygi3psUI
 JCtPD/9Ufjt9jmDhmxNUAxoA2V2hfzWrlQmETddcge9lzhC2G+4lt9vtNcKyoJqjbR9EcVuuH+N
 0SF1IYHPgbVm6HiVcUf9sAvi7pQpj3D0tXtvx1y3IIUONGg2MrYDjqbvQyRehoWYfc5c0DzNfRX
 9T3FDbDuaHmQWVLEz4H++z6nnstjCLImgqVDK4WC+QqD3R9vs4QHpkeYvyYKWG5cGm202IL66+Q
 3zfH37A0bK0eRn8dMahrHxWmRImZ8Us1Nm+Q2mVwXDbjHJ8h3PPyuCvggNGXgSk9sz+EuMYRuT+
 EAucmWITr9kYf6lKOZLN4aKXS8Gv66Us+OMTMBEkHjP0cm4s25JZtX7k85vC/SQ0+dNP5mJCITY
 IlA4Dvg1scmk5byxkrCRR1T5BiEdangbWzRvbr/JQpb0bb8fHGxqR+AkeEvf6IELA5cnelHEG9b
 pFXm5yUYNcvOWCJkls3XGyLILQGnP5s/suOebq6BSXb4G4f1qiU56y8kggJ+zRafdDKIzicZ4pa
 bYcNDSgadB939lrENMqO0DQ3yJrLCSTFPX/aEtqdqQ7YQ8WNr83VZJlbcxswJiQfIKTLfEJS7Sf
 T4Kr+YsEgfgZ1sN4PjE+SkVKbuUVPFy1lcD4Rd2t/p85VynzhTwijW/Pir/6Z/qyFdOZVcVPBg2
 UJkGyS4ezYQjliw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

To support implementations with different event numbers for cycles or
instruction events, event attr groups needs to be per-implementation.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 303c0e62432281e899a33fc197365c70078d6ac1..d0362a1813788776f4210523efe33a3018cfef2a 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -668,7 +668,6 @@ static int apple_pmu_init(struct arm_pmu *cpu_pmu, u32 counters)
 	}
 
 	bitmap_set(cpu_pmu->cntr_mask, 0, counters);
-	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] = &m1_pmu_format_attr_group;
 	return 0;
 }
@@ -681,6 +680,7 @@ static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->start		  = m1_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -691,6 +691,7 @@ static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->start		  = m1_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -701,6 +702,7 @@ static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->start		  = m1_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -711,6 +713,7 @@ static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->start		  = m1_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 

-- 
2.51.0

