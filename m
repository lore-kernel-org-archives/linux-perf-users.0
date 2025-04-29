Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D98274FEE;
	Tue, 29 Apr 2025 03:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745898244; cv=none; b=I3enbHIhaRx9cvPwuYUjLxjFveBJGTJlCP7AvVRUkGqus0bjpIsS+FcwKt3+XtrL32kfNguFwWUdjm5FT2UCs+jf6wp6cXm4Mt9HTDSkA8JvvyQ9HVDYh/mNEAjGIMavU68ixQxLC72NHhKk0DoBjd5xU5wEcKRbKLhGKvK38H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745898244; c=relaxed/simple;
	bh=yx4ulzghzXPNnasdFXmt4DIvCjCuPnUboqBEbKM2bdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xdr6UyFonI99FI8yNf/QUbadtWCbUt1uMV8PsRhlm4ZtV5X1JyzDEODem9IBlZClh27hdBg3HJ/z8D0xg8osz1MLlPDRRmA6FNHIt7pWxGRXTwQlS4fB9wD+CKCaDLR9iCN9zS0GDQiZPB4nRBMH34vqoPSdfj657FrJpiUztsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+lpq8L0; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+lpq8L0"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ff799d99dcso5615603a91.1;
        Mon, 28 Apr 2025 20:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745898242; x=1746503042; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFRFlIe7m8d6IQT5KN9JYG3eex35751hG/N5r2y+/nY=;
        b=E+lpq8L0kTZ9T19mODfSXEubFSr2r3TA6x0LS9yGtaWryhhGAXw3h92Dq3xA4IpWAe
         xOc3DOp9o2IlGei9Ens4FPuQ2atf9qoxyZ6PJ96D5/ZSqkXvtH/8iiLCszXn2RIu+Qg9
         Cm/NbTgoQbvxhEjiu2RrulK19L/ChBpWcbQh4C1CXEciOwPkxtb6E7bEREd5n8j7svjn
         lTz4V+Vl7muDOukCvz7LI+DjEpuNOX1fq/QCreQUXAJAY+p1tvp++aUrJCXb+w1uU8M2
         zc8dNkh6mDmWEj1oialxSUmX2fA8JcyCWESvNvpMEA65TyWm2V0NSsNJyycBavlmJE6Q
         wsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745898242; x=1746503042;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFRFlIe7m8d6IQT5KN9JYG3eex35751hG/N5r2y+/nY=;
        b=rbjpSJZy8Ln7e6mJP7ndQG9fS9l85Fhf1QoB/bJmfyMdajazQ3CWTh/fqql5bBjWYn
         ZGVCp/UbQjh3wH07rmn5FzsZBQduL33S8ohogA0P4Tsu8jK2ULW3UeOE9EDCTfG/IP0G
         XtWkz2LhtRtbrjZoLG6EFhPItrPYuJDop1rzxUqPnBiaYp91Zscm9s0fXsuVb6vdOASp
         px29EakFlIy2RAwYQy3vXFbgaBxeqHcHyNRCA2aeZfb5FAm3ie/qXot8HnHxSf9/nEyo
         6d8JsakS4t7FGrR0uL1tDPQjxjgR4ws0VnOK8mT99fINocVMytvQS+366dyWygORWCaY
         NX4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBDZVqQeoKyEvs7JQdWblgc0C8AjwsykzSJzosAYfnDead15JfaHU3yTJiJW+gZInzUaEhoscAeLUC@vger.kernel.org, AJvYcCVJ0JuqgboI8KwaBIB2h7Cc4fiCtumq5rvCl5fJKxCDtYf/Lxh1XmQhSjeQDpPge4FuHq+xkPYo+1jSJHdK@vger.kernel.org, AJvYcCXR/9TU3WnGv55qOyDPvwFuL+94fm7S+wZUbWmlnpoXUB6Y7di1CilxzBtDZH1pdkbe6oHmJnHbgx44/n8OmYbGFg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw9UbxcutxgkJTmgYXamyOPVQdkgpsiBo2CVOkTfSFBiVl1jeu
	EzQY+ogLmJ5y7qU7SAkU92bB9eD+9bDqDWeACgWfD7RvqzvNQTxA
X-Gm-Gg: ASbGncsyOgGIBLy/DYLezLSaCP0GtG7R+LX2sTaAMRBNZdz6Z839fqf+0QJNRCPXDcE
	vttodM4lnEFsSD8alZti22RZL8WkwXjIjbAvgh3ZZLGbzdTvef4ObzvZBC9gG9RR2SeXncOT9LN
	iWDqnhumSrZfH6xp16fomK67umtlPHVGPGjq6IZibrbwQ2WSLZOWvYfaQa7KdJYgA9Y7ZxRabEe
	wU+LIlqRJQPzQnhyt/2WGLkQJFiAD1z4wsQJtuxeHds0ILEE/f+IpNYJXmhTijasUrKkNism4Ex
	b5ugyZgA2fAef6Rz+rcc4eUrxFmXwBWJoWjwT7IlApMD8PakTOky1xQZzI8Rck3SUE9B
X-Google-Smtp-Source: AGHT+IHDwTFEW5fMEJMTCAe5bu1FvynuHvjqeFfz4UrKJrWoqpXUDYx0ood7wdnra56eD2L29EYWYg==
X-Received: by 2002:a17:90b:4fcd:b0:2ee:edae:75e with SMTP id 98e67ed59e1d1-30a215532a7mr3313636a91.13.1745898241653;
        Mon, 28 Apr 2025 20:44:01 -0700 (PDT)
Received: from [127.0.1.1] (wf121-134.ust.hk. [175.159.121.134])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-309ef03bb7fsm9953249a91.9.2025.04.28.20.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 20:44:01 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 29 Apr 2025 11:42:31 +0800
Subject: [PATCH RESEND v6 07/21] drivers/perf: apple_m1: Support
 per-implementation event attr group
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-apple-cpmu-v6-7-ed21815f0c3f@gmail.com>
References: <20250429-apple-cpmu-v6-0-ed21815f0c3f@gmail.com>
In-Reply-To: <20250429-apple-cpmu-v6-0-ed21815f0c3f@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Sven Peter <sven@svenpeter.dev>, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2222; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=yx4ulzghzXPNnasdFXmt4DIvCjCuPnUboqBEbKM2bdE=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoEErkGoM2RWg0VDlbXiGWY/HfVc4yzBpXpB7XY
 woxK5/rLeOJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaBBK5AAKCRABygi3psUI
 JMDrEACtYSUEFb/komcO9xfM4+iYf4PfbQ9GJmuP6RrVfz23Yo2dm29bjUoeAwfvld16KTouLrg
 DBM5vBZTQOhc8nVNTh9NRNMsYbn1Zffep0SeMhQUDEBNb6NIXhiOHrTY8Nc8KTew4jtAm/h5VmN
 q2t5U+9QXA8+oV6FpBgIEfM66Rli70AIGdTkcyzZsOSx+cPOdM3B3YPLWGCywlRky0nxD2sD6uc
 Sch4WVH6GF/vpAodNYpe8t/BxxKyR2RAz3l1bvf2EmjmrOzLRt9L/GfT/YAE91wWePlgA/rdDP9
 xpEWOJRDVCdXgBAGqVz8npNYMAxC4iCRNFS4g7zhHs8iswoYTYOA4teUDlsHmZKJ2fS4QfE5+d4
 IQc63gns7yaojgY8npYL6c0aK9ZmVkpAzLrrBe0RrR/Q0eedgs5BBDjRudO7l2Rk/hX+RkPrOWp
 5WaGpOv6mZQHQuAtb7+im0jH02X7gcRCZMOUxAFtMimUic5fFIl1yK43fT9sibB4yuh+QN2sAvk
 eEs5+Rxm/2Jl2VpRiTfLtYdwYvtHu8c+KywQyaVsSBaOHfIF4/TIoeijKvpiembgYXRyYm+nPlU
 9SL5FMHxGt40EVGE0RfF7IlfYbfCsTjHw2fs9g7LqaTGstLqxFBud1C3kRfxhtYthe5IR++rsCu
 VV1MRAyn8hGlwpg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

To support implementations with different event numbers for cycles or
instruction events, event attr groups needs to be per-implementation.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 38fb9200369c11d0d7674bec4f350915c67352b9..523ad37a07521692206cc438b8d777f505506c7e 100644
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

