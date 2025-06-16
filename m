Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A674621ABC8;
	Mon, 16 Jun 2025 01:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750037560; cv=none; b=uw6HF+0JY98+3azZzQKrujQ/VVSTBpky8NnsTzWEXDTis/xAd1ZGOVbwoPR+nh51kCP1WnGVH/jkx+K4pl3WGZMIcOaY1CuOJXaJY3UZAWfXHy17pUppGGMIPpcCwHkigYhUvD3NhQvJ/cPWDxD6G+dmL+3H9Av9S9YLPAzFKsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750037560; c=relaxed/simple;
	bh=rgncqluFC8hqHT0y83Q4VleXE9Vishjne/f3KrvYdxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l2d+YJWGYrxJrhQWS3lx8Nq978unJU7FmPKpRqcw8F962vdicaOW2EgrQdoyFUCaA8FUScjm/elvnXnsiPMISN45w3k9eEM53jcuzxrdNesq1CUHMmBX4G3da6BeWX5zQlYsARPMbaqeMBefk9tWD1CF/SFBgBS/yrsYZy6zShA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBcttQFs; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBcttQFs"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-234fcadde3eso49212575ad.0;
        Sun, 15 Jun 2025 18:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750037557; x=1750642357; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PHnX3hiTgygahZWce81xiavlKw/l1jLJfkiYMRd1Pzk=;
        b=GBcttQFsOdCkS7IwSOQH5MYq2qPeqD7woYiBD/bFkiSkLMv/UeDLBK9cxdWe5F/77c
         lLrGMQAO3937WWIhsT9LIA/RKdsLLh8muLC3Gf6M5DVwaetICOiH8RY8wUs9n0jEh1Dv
         GFWetowMLkzpdnWKHqroNvAcYEEKTfP0mekB/hbCxKhO6d7gm8r5i6WfDuij45kXIWZo
         RyVs9+Y/E6QVQlsZQUmG34c58EX9ZfVV5CZDDBhP/UdsxRE2uCgArLRNTvol/1vp4/8e
         j3awDW8uLfSwaGEB8ZJ7kDKI4Pxmf1hM/YsF0ic+oCkT03UFvQFQEbKJc8f8zHxnU6QD
         aV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750037557; x=1750642357;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHnX3hiTgygahZWce81xiavlKw/l1jLJfkiYMRd1Pzk=;
        b=o0PE6nB6Ehn6Y4nhxZrBnVo0VVgX4FQT5jcm+WuEuh8nTSGwpDh5XxXzJMrfW59z0m
         j7p18Q8/j7Cg14tdMldkV9VEdVRl4MXBBh/YPp0tUpYic1FoyUPjHb0X6G6KKnmCh7PG
         Q6ufy6AABZQ+FKgy18cv29Z2I+amdvXsZeXiDaFEJHJIaDaUHksB7TpGwm49noe5zv4L
         fWMXIW27AUNXsZETYw+gEy+w8A6tfg0YhLQFBG5EJaHA8Q8cXvwT3J3/dVZ5V3wXrKY9
         U0XNHVHiOsxTAaPCWRgLJa3dPGmn2U7jztNLZf5PnEEKfUysy6eHDAqHKuXDrugSfbD+
         g4fA==
X-Forwarded-Encrypted: i=1; AJvYcCUTdwAKC+sTKm+y41mEhSGV6tI40l6bEmxpijuADDZz3KZSTlZS3rsngpYDDOsp9AWeFeJhW7VV9oJX+KUe@vger.kernel.org, AJvYcCWhY7qMsGSCH8UEjA+M9NuAG5c4myt095Sawu9yCXDCHbPMsAsgtideVJsDslUG2BgKVgHjmxV0u+uk@vger.kernel.org, AJvYcCXH/SElclbDtGoI36/6mXQG96E5ayPEN/gwm7JS2c3Cto3UodMgDWWJMFFImhyi8w5nqVE59Q2E5F/VVOM8k2nz3w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/yMj2d4r86Sj7ODjdbd10bieFEWi7JMYQ9zZS1uIfpLU8lp1Z
	N9VXNJdd8ZNO+Z0kMC0TmBY2mwboV6k1AuENjUV4b0aIzggPrTVb1q4DDqTCBQ==
X-Gm-Gg: ASbGncvwxnJ8/QcnyuD/ufTtziX+mQVioq15bhNMGvgIxGiYwhgBRrjU1zZUYU2kohc
	qRRWjo5sYrKbeapAYT3z5UxvbSQw1bQhpSb0JxXgFVAttY/IOryrHxDB15eXks39n9EcdR7quph
	Dsus6NDaQ1T+0HHL7fEDAtcxkzVKilKF7t/JzQl/migxKdp+iUPPqrV02MjCHjjKjbO+YonxJw3
	MOP7Ma3Vy8+4hkYj4hDVX+3PMy7ThUAxbREbj34AKqQl2MXs2ZW0N8HxYejM1vzfhM7aN+M6+DI
	vfBk5oauwCazhU6wbM1Gmx+R5mNFYnNog54vmgveN/poNBT27kgemOjml7GShwgxGWVLui+t434
	Sjw0=
X-Google-Smtp-Source: AGHT+IFudX6EFzo3QF4r2jcIfH6UCpGNE340PBewbeY6d/vvXtFcKmgg2EvJTzMAhvkSU20ywHPdBg==
X-Received: by 2002:a17:903:8c8:b0:234:ed31:fca8 with SMTP id d9443c01a7336-2366b3ac384mr110047745ad.27.1750037556953;
        Sun, 15 Jun 2025 18:32:36 -0700 (PDT)
Received: from [127.0.1.1] (wf121-134.ust.hk. [175.159.121.134])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2365deb2cedsm49932455ad.163.2025.06.15.18.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 18:32:36 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 16 Jun 2025 09:31:56 +0800
Subject: [PATCH RESEND v7 07/21] drivers/perf: apple_m1: Support
 per-implementation event attr group
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-apple-cpmu-v7-7-df2778a44d5c@gmail.com>
References: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
In-Reply-To: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
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
 h=from:subject:message-id; bh=rgncqluFC8hqHT0y83Q4VleXE9Vishjne/f3KrvYdxI=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoT3QXGctIy8HTZc6FMgHV1/cuW5JYoDcpgdCzh
 hOQjXH5VvaJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaE90FwAKCRABygi3psUI
 JCIHD/4jagi5xi8pwdOPV2nlS/vBxkQU9xSTwWSEW9TBVL0HG3+EnbuoWhb/YT39DKjLMeLVGRg
 K83Kdh0wt2khtxKo/eTJqmF0T3G+tOfxnH7DGm+Agr2XA/QwaBk5WV0XqqmnS8wPRAJhAq9LCrO
 mBUFtdHGe2mN0BrmOPyQuDBxegFHJWsm3xYn7F/X9HuddmCYqqRMUoIHOAjfodZ5ajyNLCQomCH
 l8X6T9mECLvhSwp2naJZ3xcrneHmu8CgczyJLojrNoYsGAcZzTFNHjs9spge8O7wzlW36qlzc5k
 Z9JT1yjGopSGnhjSlhhSWVum10qD4ECi8rk9mT8gtGoo2Plj4b1MPQ5XTTwdpd5YhBdYgTV3GcQ
 LHfNEh+t2JroObT7XvHDyoO7SngbK2GJdrh2thXIducD4oeE7b2n+evuUJ4Y0qGdBqe+T8FW7Ci
 2kfWdvYWNFI5S41H8zHM4hJ0sBSU52bF4JHbzH18j7HJd1AgpTeYCzYf8hJebMmblLTRdEiHnQE
 CZHancEpcgYQfI49EFQArnhzS17oVmmciEVZq/H4N1lFwoVXOBMJfb5aXl8rkM8mWcbP5NjnGov
 VWnRv+R3ckH0KWKcXxbGB5pdC5TfT7k3f/MdSFfipW1OXPaOEA65RGpzE2U7YrHIZ+BXyxnVXYs
 jk404JLt7UMwLgw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

To support implementations with different event numbers for cycles or
instruction events, event attr groups needs to be per-implementation.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index f4d8da4a8aa0c197cd16af422b33f4cd943d379d..74e9e643cef7f9a3c9ed599da36cf9b04b124810 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -669,7 +669,6 @@ static int apple_pmu_init(struct arm_pmu *cpu_pmu, u32 counters)
 	}
 
 	bitmap_set(cpu_pmu->cntr_mask, 0, counters);
-	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] = &m1_pmu_format_attr_group;
 	return 0;
 }
@@ -682,6 +681,7 @@ static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->start		  = m1_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -692,6 +692,7 @@ static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->start		  = m1_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -702,6 +703,7 @@ static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->start		  = m1_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -712,6 +714,7 @@ static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->start		  = m1_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 

-- 
2.49.0

