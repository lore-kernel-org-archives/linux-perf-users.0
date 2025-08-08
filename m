Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22519274FF5
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Aug 2025 11:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754652234; cv=none; b=p9nKufInOCJAlz7uKU9lNtG/NyuL8+pDZsltB5rGGgQ+osxDSBCugDSaEa64JywQwQDxw0mrxwfqTIN81kgytsl1Fm8NwfH3QuVuiJOV9roX/4qrfQtzD0O33u3YhURJDl4/NCo6uWRIml0bEpIiT+mDtOB8kRjdcSMGuROij1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754652234; c=relaxed/simple;
	bh=2M6WcB6KkvvOnu9SyMhbI08CMGWnnDOzfm+WTNCBqlk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t+oZeAt70yx8gAMfHDmnEmRCQLsKuu7FP/p4H+jmUvInR/Z1D4k+iH7LlzudNCcW1MnQ07oXNvWxQlbOwv1kvXvqzLj3lAehAbhay3czaRGH/dU2QxISEmn1CIYNTeSa7T5iw7TnBVbQtP3SmsuPiFiT/h2lAk3C36zAzFcQaJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ymSeUHxw; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ymSeUHxw"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4589b3e3820so21009175e9.3
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Aug 2025 04:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754652231; x=1755257031; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXydwqwRaP7AXP8zkgHzJDBJPfnaYLIQgQCT9Y2uDB4=;
        b=ymSeUHxwTMKi3VaTYQhTpCgbrrKehNqptGeCmEF0wpl4H8IfvJrneTlgWYbtZNxDcz
         kEtIE7Lhbm0T5A0TrF/xfPFd7V0SMZi2GSmmNI9NxpySw7dLwhZj4ezjZ1evdndqd35f
         fmXVX48v57T+bYYhuELBV0Qhv+Iyn95M09g9LrQOtSXWhLig1+0Jx61oGCLHVtJ047F4
         x6PUcRTpxia53eP6MeiScdh4olyJ8DqXQsXU+pUKS4TMtOG310ngaVMigN+RnVWYiaIX
         LFP9p2yJUtb0n69fLebWucJ/K47rqZ+Kyj92odk+KiPOgEBkYKXMccNaJiClg3YWiH1g
         y3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754652231; x=1755257031;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXydwqwRaP7AXP8zkgHzJDBJPfnaYLIQgQCT9Y2uDB4=;
        b=RIF/gpfYyl3bPOQYmsKbOsatTufjZaFXdKsUfW7JZLtvDuSoZrnuzWww24rrsnFyWO
         vol/5DtncCKZYpwfeW4PlVvporDc7Zl0ryk8Jnut3aTWeniqSD4nl3U2Rn+QibtsHZn1
         r8EPZo1DfLXyR9Lb3WnfCJ/mfaih8tTEWP0dp2B/+JFnBpkpcBMS/FiJF9Zlm2IlKBzm
         RqhOEhD2tbHP4Q72eejnVx2wwDYUabZFoOkta3Q+NIHeTeyZlNJm9dk6Sx1HkDIYWUfx
         2vuKuzSgM6C8IRF4FFnDDl/lKjeKttz/PciCBfL4Pz8Ir8pIWYlilwIAXsMCAFlfmjN6
         zRnw==
X-Forwarded-Encrypted: i=1; AJvYcCWtu0nQQzq4nusgESNk4a4e7cZzH4HU/1Xsoa57FA7eiVxCRDH+sLwB+BdZG0tT3adbJJmYaWZJhhGnuoWj1o5l@vger.kernel.org
X-Gm-Message-State: AOJu0YwVoQp/irAn+2L5yDduygSb32LTlBIirj/SVnO8Uu0oikOSpdBo
	L/DxxKOkH01etqk8ztFIy/C7mSR3MhLkl+xGw6TXnt9FbvsxDRwawrM2f5FzYWlOi2E=
X-Gm-Gg: ASbGnctVSVwbNXdPu1ki1lfLG+aTYkiSEJ8AN4jemC2UwotzgrvLlWeIyA70j2iixRn
	FqH+hJze0sHXLTPH9EMlP33vlA9srLkNPE/D1F+2t8Lb79yM1uoHkc1y2tUKbxKMHcRF8h1lloW
	Rtt0UiQ9Ub0MzjxS9xi8mECm3MhHeaCdCNetcCkQ7XM8NsmMOjyJaCxf0BwpHqCQq4NOg2YXJnn
	Eq8R+60mvHDVwjI5woiqjQwnLs+bWgYMMXpI3TOaumdAQU7ZFDm8aqdQmpRJb9yrFhpFixSRa6C
	DdM7SaLC69bz70h60wiWL3IQUQldB0Z2q53zkyjmrTCUZd5jjcr2lO590vtlnJa+5MoimO+IAUK
	v3WZ0x6vIDxIZu2iW7LrvoUpSrPL9SIw=
X-Google-Smtp-Source: AGHT+IGZt07Gv/AHxus95QP1UL0e334J3rp5xUM7DnDTXPfXeFD0bRifb9xINgGQEjtvNdHSQjLqQA==
X-Received: by 2002:a05:600c:154d:b0:459:d780:3604 with SMTP id 5b1f17b1804b1-459f4f3cf5dmr26410715e9.3.1754652231142;
        Fri, 08 Aug 2025 04:23:51 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45923c34af8sm233482635e9.24.2025.08.08.04.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 04:23:50 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 08 Aug 2025 12:23:02 +0100
Subject: [PATCH v6 05/12] arm64/boot: Factor out a macro to check SPE
 version
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-james-perf-feat_spe_eft-v6-5-6daf498578c8@linaro.org>
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

We check the version of SPE twice, and we'll add one more check in the
next commit so factor out a macro to do this. Change the #3 magic number
to the actual SPE version define (V1p2) to make it more readable.

No functional changes intended.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 arch/arm64/include/asm/el2_setup.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 46033027510c..3a4ca7f9acfb 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -103,8 +103,7 @@
 	csel	x2, xzr, x0, eq			// all PMU counters from EL1
 
 	/* Statistical profiling */
-	ubfx	x0, x1, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
-	cbz	x0, .Lskip_spe_\@		// Skip if SPE not present
+	__spe_vers_imp .Lskip_spe_\@, ID_AA64DFR0_EL1_PMSVer_IMP, x0 // Skip if SPE not present
 
 	mrs_s	x0, SYS_PMBIDR_EL1              // If SPE available at EL2,
 	and	x0, x0, #(1 << PMBIDR_EL1_P_SHIFT)
@@ -255,6 +254,14 @@
 .Lskip_brbe_\@:
 .endm
 
+/* Branch to skip_label if SPE version is less than given version */
+.macro __spe_vers_imp skip_label, version, tmp
+    mrs    \tmp, id_aa64dfr0_el1
+    ubfx   \tmp, \tmp, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
+    cmp    \tmp, \version
+    b.lt   \skip_label
+.endm
+
 /* Disable any fine grained traps */
 .macro __init_el2_fgt
 	mrs	x1, id_aa64mmfr0_el1
@@ -263,10 +270,8 @@
 
 	mov	x0, xzr
 	mov	x2, xzr
-	mrs	x1, id_aa64dfr0_el1
-	ubfx	x1, x1, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
-	cmp	x1, #3
-	b.lt	.Lskip_spe_fgt_\@
+	/* If SPEv1p2 is implemented, */
+	__spe_vers_imp .Lskip_spe_fgt_\@, #ID_AA64DFR0_EL1_PMSVer_V1P2, x1
 	/* Disable PMSNEVFR_EL1 read and write traps */
 	orr	x0, x0, #HDFGRTR_EL2_nPMSNEVFR_EL1_MASK
 	orr	x2, x2, #HDFGWTR_EL2_nPMSNEVFR_EL1_MASK

-- 
2.34.1

