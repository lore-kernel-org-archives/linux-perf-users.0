Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618772676FC;
	Fri, 14 Feb 2025 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739543449; cv=none; b=XcNp+oBb99V3k++Tos1d1sqGuypiqKpo4xTK4G4YWUA9wYwUI6wTl5ZkVcNgq73gp5IENFpG2tsRKJcT1Idr5Vqjl9FzvdsdfNa4WndTEN+gNekcPxsAk8DTkKkCU/EVIAyLkFlYfoG1c62GofsU+mfDorqicHD/phVKbmhVOrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739543449; c=relaxed/simple;
	bh=ODunfawf7CVe5hX+5as3cMBvBCM9oIodivRV8l+gVA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rwUbIYJtw5N4iQRIkdHNYvDtNv/yNJz+a/GyUuB0F2BmxHd2Abjq7nfVc3E9UM7TIY+jfV+m1u8AjwUUTnh0/tQMLxq1IeLfJgnYG8FN9QDnWIQLzkulB0vA1clzq60IYISdeNQrB/H4CLJRBBvDu8uUENt7cNrMvoLFeo6O2JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emMdo8vp; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emMdo8vp"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220c2a87378so30542755ad.1;
        Fri, 14 Feb 2025 06:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739543448; x=1740148248; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkIjPnn91/SRZervKGZC0B8yDAzqnA9SsHweWh8Mdhs=;
        b=emMdo8vpthencf5bfp1BfQfEwOc9ASs46euj5cHdxPQLmiBrP+zpEccmi2To5jZvB5
         jQ/ligbbF3aK7ttWOaQPtBi3yFRlxySA9wTSao/vRMqP+vzsvVpYWGRlXO9D3QMt7rSM
         fBKuRJhmHkgTA0LpCz5FHx6/52vfe1+sc70OQGhZT+5j7Ggw9zOL0LcTmK+QhhWqxQOQ
         fcoaIl/ivz7IjdEsz35VEdhAGFtdxTgVvhFutZgyxJwdwdIVM/3tecwEkej6kXPdo4YA
         EPj4udm7uzxxwzjLN+gVlNjBl4hIVghZDFHbgtuUBynFizIeP1gUvPOUbklCHxB2696W
         nf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739543448; x=1740148248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkIjPnn91/SRZervKGZC0B8yDAzqnA9SsHweWh8Mdhs=;
        b=M/DMAAZYW1t6rqF3V7Tph5xWC22eis7974NNLs6U+TjAjPJ8MTHp5tmQtpu4WR5Vba
         H4hg4jouEBUUFCX8DycvsLk1IpL3K4CVkjEV3E76U1j/0uVRnfHl5i1Pf801U+pp1RaE
         g+QVp64FUCac850/nhUrt2i9H78lhVWZHZ1wDR9s1ZajPIp5inIFDI0M9iC+eFSotX17
         d9mfI6KDl/CJtEUM/0ke+d0cZckc9hExFfJj3s04g8gyk54agcKdiJ1Sp5nYCkX5Xtui
         e6sbT/X8I08RToGW25tRI3nRBuraVmPn+ng4kZxrNc3vT2F7RtY97KGW3QifloQnVL5m
         iS2w==
X-Forwarded-Encrypted: i=1; AJvYcCUQYye43HJBKmoOB6lgm60aF12VaSUE1lousHkzQdjfeg5WjfcXApokhzom4HWpa8PkV9Y7vmhGCkpIsKU59l/ftg==@vger.kernel.org, AJvYcCWVIYwKpMQKDkbQig0XkVn9QUvKhHQj9Z5TkYv+QrZrVWaWDs4GUHbvixT0mOQn0wEU79NPbfhY+H06@vger.kernel.org, AJvYcCXRIBCnJyVazf/vItUfunYLfkiA/j1lBi2Sw0KE5G/5T4QH/mxvVyGEDr3mIXbxFURaRCz/epgbPZEH9nfi@vger.kernel.org
X-Gm-Message-State: AOJu0YzXW0pWC3g7InSRkBp0RCwmaG7vpoD9GvzhUcyXFKNzk8LJcxqx
	mMD2dzcbU2/TRXyEQ86f4Df/ix0bPvNIFftjn+zxZ1EJlsRCj/vY
X-Gm-Gg: ASbGncvO4UUQtvWqM+L7/EFJ1YvYCvdHllOoylhrZfjuQ4dr6Fs2NR0t/TvYhPdqdv5
	Lz+P0amthtbOOZGk8Wnjaq+GFrPESFcma550WpaFIiuF3tFASt5HExidFNIQnaF7iVRw11BTXJ3
	h4ms5/4fRqSlz0dQpw/JDmw1lZt5nY1h2Aw06wmndbx8P79wkbgFIljY2esYLEyJ3obHlwDwJRu
	SiZxdnUAA4XopqcQm3RnMG1RzYZCi7EkfTPEJTK5wV39IfUXTV0ghaw3SmU5sWSHba3+6DYcL7U
	wnqB8KDspg0hUEjvtg==
X-Google-Smtp-Source: AGHT+IFglqPtbNOR5d6lPNgfHapWAMCKOc/XtNXDkRhnLODWQ8FuM92j2yXPlsrbIGhvAMP7bUtYFA==
X-Received: by 2002:a17:902:e551:b0:221:1c2:2012 with SMTP id d9443c01a7336-22101c2226dmr5121005ad.49.1739543447628;
        Fri, 14 Feb 2025 06:30:47 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-220d545c8d1sm29490315ad.113.2025.02.14.06.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 06:30:47 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Fri, 14 Feb 2025 22:28:32 +0800
Subject: [PATCH v4 06/11] drivers/perf: apple_m1: Support
 per-implementation event attr group
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-apple-cpmu-v4-6-ffca0e45147e@gmail.com>
References: <20250214-apple-cpmu-v4-0-ffca0e45147e@gmail.com>
In-Reply-To: <20250214-apple-cpmu-v4-0-ffca0e45147e@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2273; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=ODunfawf7CVe5hX+5as3cMBvBCM9oIodivRV8l+gVA4=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnr1OANQD+IsUSDqrlORfp2jkKJ1QfjHu80PWed
 wsiCyMmfLiJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ69TgAAKCRABygi3psUI
 JJ8BEACp0B2nKDD0n9WAUS7AUfltglql9y7lURBC6T+c1+vW0x6Je4TI4EG8CG+yKDEjyQEL15p
 NewACnfSOBVXdxztSY+6+NvYRbO+W8KZgDlbM4aOAKOg1JrEOtigSYje8BqJbcTWwDC10sIAzSN
 vAeBN+rANWdrNouVd0H4CCxfo71A2rKPX7VAtQA1fFOuQtS/UG+v7t1pgltm64gCXZqIywyyEcY
 vgJfZWDLlg91TPdqKrHKm7fKQK81c+bF+I3Fwc2eeDyeIhmx8nCTmJ4vc4BwitobujK4h7Mwcy0
 h8Vzqcij+mPbzO2JRwWnaVuI9ngQLF6baMNd4s7+dKxixy0Ubav/CSXn6QT+UWm2w5ibSPxlhiC
 erl8bLI9FkEUg3jS9/LljeNidQOOhHaIuLmWim4Sg5biRxitgYnCZsV4o83a0eOstJvmuvm3dWl
 dWCpf/qltjbZS9dfBYgiJQ9ZoqGRMV3tX4IXN/RNw8CUeGqJf8p63a26N+rW6VEQeoyGupejGxS
 wWfyiDPKNt0hhn6ygb/2AlMgsFWmghqaaZgAapSOJTXjtTmxcjDexxEXbl5F9XzdgOvTQEJZEWh
 DW8fpWzU/U3GHBHDe2blGQUT3Wm6oFMPVfApfu4+amZjmISqbPhftYJEVBnS6a9RHTlyEOEIC2o
 kt852ZFaa0zC7RA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

To support implementations with different event numbers for cycles or
instruction events, event attr groups needs to be per-implementation.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index b601d585d204f9e59ad7f5216679b97852a46a04..f98f3e95bfdbb5e9d0fe66357f6037f056fbf25c 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -612,7 +612,6 @@ static int apple_pmu_init(struct arm_pmu *cpu_pmu, u32 counters)
 	cpu_pmu->set_event_filter = m1_pmu_set_event_filter;
 
 	bitmap_set(cpu_pmu->cntr_mask, 0, counters);
-	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] = &m1_pmu_format_attr_group;
 	return 0;
 }
@@ -625,6 +624,7 @@ static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->start		  = m1_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -635,6 +635,7 @@ static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->start		  = m1_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -645,6 +646,7 @@ static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->start		  = m1_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -655,6 +657,7 @@ static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->start		  = m1_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 

-- 
2.48.1

