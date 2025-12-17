Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3FC34D92C
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988703; cv=none; b=qXPm0iTsJ8pjjHTHw4vDlj2TYB3G4LyBFTh6ESmR+hgAzdF9ru+FSiRIE5B2/kUq4HJQzH4sTS1GSdiPnoch6Vk44vj9abppTCbD7YQecVyxnb+rMMpJujvsaqmIYcyqSZlPmA446ZMLmXoj8Er8XW6tFSNTvHPtupPur8FH8Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988703; c=relaxed/simple;
	bh=ZZrFSnM4qaLIjy+z2U/97ZkDz6A45/CxzWdqdPeWGg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pUThlTv63Umy8P4m5Lb7si8pFV0AHvbBi6/ytDGoGvXmsYYotNdSMw9AnP+gPD2H7WB2NCrEmDercW7tdpvlfv1W8Xon0BQGs+QFjl27lvPGk/z0E9ifOY045n2UuNnocvdwB8wWGQW/RSmvw51xAEk88MEUdbIntTQeVRfbtXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHf5EvNl; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHf5EvNl"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a0bb2f093aso42546095ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 08:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765988701; x=1766593501; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LJBqWPH2nkiaa34J/fXU+ba5HlDmsksob32XTdaDMY4=;
        b=MHf5EvNlL8SmLc37hVkjSwMX2bwGKRFlxdRE3+519mcGNA2qOX9r2+WGWdrQa2FW4g
         WkkltgC4A5pZcpPZLgpp7uK4kuB3nMZicCH8UIj5DESfCupyOkoGaVeA+Zwd+Z+2rrk9
         dX7DLSQvmMgatZYEofhI7nrTzhE0TGl+VuzzDJEWUed9s63s53v3R6bQo8vMk5RbOKNM
         DYpRUNHR4fIfy0btNVNdpkuChPQBWSaIUsjsjlT50V/ecJdHCInyFCU0K6fg3gadmN2U
         ZI6IyIQBjPgnrHs6IOm0h8id34D/kigt7e9RqFLXF6GRQ9klQtNPBymKTDMMS+vkjyh+
         0SDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765988701; x=1766593501;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LJBqWPH2nkiaa34J/fXU+ba5HlDmsksob32XTdaDMY4=;
        b=D4NNAO0EYczZoZdhi6L6dYDkH8ZiU1BHRthNDDKvFQucUBXgJwYrcJdpCu8hQstJb8
         UfCIqkknDKcO21EuNx/D+9VCDvtHfCB744MJ7wDpk3ae5VoXLgpivK/iE65QXAaiSmIZ
         3LUNzWgfNAxpNf3EEBRFcZPC59bTa44b2YD5H1lK1ZTSZqfefxjUzt+oDHKqj8bCZXr4
         xcn4BqvLIZ6kp1DD/mLP9bcG/5HuwRwV2YR2o4Chqw6Lw7GCA85ye6JGWmeEWT/o7ATO
         UOUM50I0Fwv1ws3+GEFcviXGCT3qE6X45j9oKkGnPn3DEMENNV7iq4M6tzDev1IvIi6Z
         eQjg==
X-Forwarded-Encrypted: i=1; AJvYcCX/ak9ZNmQzXcwC1G6odGlnY2F8MDmHDOwr3JP5a6sWr4NF3l6zySKxDjJGM9oBlQCXNWhSrbvJ1/+H0PouHIXt@vger.kernel.org
X-Gm-Message-State: AOJu0YxcZktFyUIavQYZqDRvPvSyDuxAn6oKx3HYFgSRIo262A4RkggI
	mI4WiWme73Z+CAw4b2wNqpG3cUtrQr8unlE4SE7TBRTuHVt0ZNHnU/1n
X-Gm-Gg: AY/fxX49K3+NxNTjhvzJ247I7kxuF76sXQw4C8d4OhXfnZUOaeGQNKtgCCwci3ySW8u
	9wLYn+iTBvx4jQJXH0xMhnYhEljxgF9sFbsq9ClT4VyPlihZ9iuuw7CVQdr2phV1YMjKWAIhu8b
	QbzUDfy186psX5qvSSnzJqf20hfhvk8Z6i2fnURxkGwsRovuJNShb2os7wQH/XcX75+iWf/9dVx
	hKcB0cVpsOr188wfBTbaldyuI/YeGq8YJ91K2YWKVygRwgbp401qJ3fJ3lH8j0F5AgHG1178M9V
	NRgjyTB4ry6ijBBE0VOK7/+p+QlXT/KYBLNpAgDXCibPJ3UE69PjowYLrkstHTJZdnQ3OOJ8b+g
	5HuOMQz6kFyW+Mv6P1y7BA8zrKB7dNXpZao0A1Uq3iZTFJDBPBr2vtu/bjWngLa/ho1Id5sWWsi
	LN1QRBv9rVTHUA0xByx6JbkiM=
X-Google-Smtp-Source: AGHT+IG0BRya6JcBr0mTcVAqL7t0D9n0v53qOEX5qkYR98IGq7dQZ1TKMwIAOg2C6RQdGKX63TpT6w==
X-Received: by 2002:a17:903:2442:b0:2a0:b62e:e016 with SMTP id d9443c01a7336-2a0b62ee12bmr124556125ad.32.1765988701484;
        Wed, 17 Dec 2025 08:25:01 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a0b0687c62sm122980415ad.88.2025.12.17.08.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 08:25:01 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 18 Dec 2025 00:23:20 +0800
Subject: [PATCH v9 07/21] drivers/perf: apple_m1: Support
 per-implementation event attr group
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-apple-cpmu-v9-7-4deadbe65d03@gmail.com>
References: <20251218-apple-cpmu-v9-0-4deadbe65d03@gmail.com>
In-Reply-To: <20251218-apple-cpmu-v9-0-4deadbe65d03@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2222; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=ZZrFSnM4qaLIjy+z2U/97ZkDz6A45/CxzWdqdPeWGg4=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBpQtlAGMO0GGZLpi1zAtxvLgpEJr3Y9rGS2lnzl
 VwsXzVKlU2JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaULZQAAKCRABygi3psUI
 JG0wD/4xjOyi4wclJt98NB5Fro8UHmkJvVz91tpavZ8ogxOXqWdgOt1/EA3rU8KXW+O2rZ5IYHt
 rGFXDuwHqThtPxSUPe4d30LDij17Eqk09D9s65+BCUfRByroZKPgkuThHAbjGoFncAExxsEAk97
 ARE5Obg1xmTvdcNN+MF9YML5wxXzgiWsgZoQwueb5bv+uJDx6mn2Wa82iZL/R3d+2ZXyF3mSXNm
 nSjF3TvGGee2bmB5yM+aiNq2lhhQIgRjWyyoshfEgccWmWg74iMwXRrqFuyJ7yPvJr5zDateZzw
 t8AhG+FtAU1ZFQe5I0vNDugjZ7MSbGWF3nycpmLPI6gjrMSJvSXm+x9SN/XuiD9z2qb5LTfBs8S
 0zq4bwDU3RLO9d0hlOhqrv7C2bght3tCo0InrHn+7QXPa6kvrqO1KHmWrHY3xPeeX0eAT3F8oRm
 gBJCDa0cMxCD6SuvnsTGMDaTRZtxodGFwyUTOdrVEiUF4W2dN+66pJZW5p0uWcKSJJdNi4++OmH
 tY+8H0KaeclNhGqwJvNk3XGtae2UUbHsnbQr58GCGO9fUGOhW+6gEc/nUKhmxdlYKfygk3K6+9A
 9EYIinsD867fdYWbjzShMO5ggO3TBzTqmeqdSq9Mv6Qy1VXLyXZxxRKbWlufGEK26lQkutjh8zF
 SagzGtDXKJl3dXg==
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
2.52.0

