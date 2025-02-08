Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C91142E67
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Feb 2025 02:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738980087; cv=none; b=W6yitNh2MiGNIDJHkpWsYC/3XNOAh37Da1eyexGzrLXsYGZ3R+2ML06GJ5K+tv9dm8W1RDD3Wgp7V4zXfaXUkGbvlU0NhU/U0cjy/uexw8ZHaCKAUPvqW5WdFjtyy9Wz8Fb46kJjJwmH9raKXNm15yHSgtNdhZ2BhLGwbxmaqKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738980087; c=relaxed/simple;
	bh=+qAoXvS6xc+m3hsF9w5PjnIq4aq3I0ctOVpDSrBl1Js=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=quTg8zB9nmVPyt647tvHbL3nU2KIXX84QOuJJ824Fb7gDaMqF6FY89RI9JCD7nHjlzBh/ModeClHGZfyH+DXrgDRzplBFqs1L9Tomn4Xp5iaCTvzDQoECpPS/+gvG6FNSuFltacS7bKrM5gQ1A4RTJewrj4IGHEREGfzK2pIu3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MJOwVkia; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MJOwVkia"
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3d04dde4aa8so47477135ab.2
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 18:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738980084; x=1739584884; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4O4akjcxYhNwCefv175mmgU5vTvI8B0CXOe+M7wmIh8=;
        b=MJOwVkiaTNmmHXpFv7tvDvYSHkOIeeQ8GOYVKIWreZhvgR7iE5rVwvGJPJYzbtbdRY
         ZfG0PJT8eNunXQTkdnpiz7FbKo0lstO2mNPj85OIGBDkI13bRq7vweLDskr2KUH1OG8U
         LT1rTQ+oJ1sFIu0tbRTJ9Dx34VSlXNqGMV2gbVgcimn5D6Pwli0s2bws2vNq0YPcdncc
         5thRoqlTYP/6D4RuzcUTrILqxzXVMIdEKZFuQxLqN+8sBelEIVcGLFr/UErWYFMJV/g8
         oYSchDvC7LKeo+/gaUcnBadyMLvKzDNEMo51LlYrvTV0yQkuQPjWnIvcNFSJkzL05qK/
         cZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738980084; x=1739584884;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4O4akjcxYhNwCefv175mmgU5vTvI8B0CXOe+M7wmIh8=;
        b=YxyvN7XioEetvDebVNv0uMsawqHRIGGqHE1hr0y90IlyutAR0CRkBr5Y2Y4pEVWvRd
         mHS/WTjindbx+rtH36q3dQIxgOR1LCbisKATENr4Fsu9qq7gD/J+Y3d8M6bRuqas8WRl
         4/+iYT0gEgHY6UdRJqIVTbVmF3DDDcgFr97lpCGLqK6D4ozgeb0qNIx/xeBbIFx0RAyK
         6eAdMyTiTimtH5iNgA5mXAwNUbGNX+EmybZGED/LrQRCplLydU78cpOOHdg9MgL3Q+H+
         zpczNBlBu3ORo1t3OWt0z+fs54kHSYHn3k1hIfES3koVdhP2mUtQydguO5gyCFWCmYgt
         ZV0g==
X-Forwarded-Encrypted: i=1; AJvYcCWf4QIymPX7IBhH2wyrvM6ifIxWf/7IgZg8w0IzodeQGeUpyQytJCQRZ8SXpmnNK53lW/zK4y9TdjK+R5VjcsAh@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8fGuRLc6SK4flA2psxxPCTC0fX180p6noEJ25CL2s91EDvjB6
	5EA9r3Z+LlKUvjs+yzXZ40jQjn2QX9ZlEc79fa8O05H6xfSoWcgRd2u8mTAwPOHwvN8vv+ERNor
	/sZVJGQk9oOlnHxu1xAzRUA==
X-Google-Smtp-Source: AGHT+IGWeZpc2qa1ckU4PjgV51Y7Hx9W1wQ1TYRDVmT/vQly3n2guK7Orb67xhImPnqLeWrkenED8+oum8nOVfQ3mw==
X-Received: from ilbee27.prod.google.com ([2002:a05:6e02:491b:b0:3ce:69d1:ce53])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:17ce:b0:3d0:1bc4:77a0 with SMTP id e9e14a558f8ab-3d13da22469mr48897165ab.0.1738980083677;
 Fri, 07 Feb 2025 18:01:23 -0800 (PST)
Date: Sat,  8 Feb 2025 02:01:08 +0000
In-Reply-To: <20250208020111.2068239-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250208020111.2068239-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250208020111.2068239-2-coltonlewis@google.com>
Subject: [RFC PATCH v2 1/4] perf: arm_pmuv3: Generalize counter bitmasks
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

These bitmasks are valid for enable and interrupt registers as well as
overflow registers. Generalize the names.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 include/linux/perf/arm_pmuv3.h | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
index d698efba28a2..c2448477c37f 100644
--- a/include/linux/perf/arm_pmuv3.h
+++ b/include/linux/perf/arm_pmuv3.h
@@ -223,16 +223,23 @@
 				 ARMV8_PMU_PMCR_X | ARMV8_PMU_PMCR_DP | \
 				 ARMV8_PMU_PMCR_LC | ARMV8_PMU_PMCR_LP)
 
+/*
+ * Counter bitmask layouts for overflow, enable, and interrupts
+ */
+#define ARMV8_PMU_CNT_MASK_P		GENMASK(30, 0)
+#define ARMV8_PMU_CNT_MASK_C		BIT(31)
+#define ARMV8_PMU_CNT_MASK_F		BIT_ULL(32) /* arm64 only */
+#define ARMV8_PMU_CNT_MASK_ALL		(ARMV8_PMU_CNT_MASK_P | \
+					 ARMV8_PMU_CNT_MASK_C | \
+					 ARMV8_PMU_CNT_MASK_F)
 /*
  * PMOVSR: counters overflow flag status reg
  */
-#define ARMV8_PMU_OVSR_P		GENMASK(30, 0)
-#define ARMV8_PMU_OVSR_C		BIT(31)
-#define ARMV8_PMU_OVSR_F		BIT_ULL(32) /* arm64 only */
+#define ARMV8_PMU_OVSR_P		ARMV8_PMU_CNT_MASK_P
+#define ARMV8_PMU_OVSR_C		ARMV8_PMU_CNT_MASK_C
+#define ARMV8_PMU_OVSR_F		ARMV8_PMU_CNT_MASK_F
 /* Mask for writable bits is both P and C fields */
-#define ARMV8_PMU_OVERFLOWED_MASK	(ARMV8_PMU_OVSR_P | ARMV8_PMU_OVSR_C | \
-					ARMV8_PMU_OVSR_F)
-
+#define ARMV8_PMU_OVERFLOWED_MASK	ARMV8_PMU_CNT_MASK_ALL
 /*
  * PMXEVTYPER: Event selection reg
  */
-- 
2.48.1.502.g6dc24dfdaf-goog

