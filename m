Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC302D5A11
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 12:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102460; cv=none; b=aQ/0PrMXi0LsIqCEfmigyKhCZe77297kSkrtUgKIzAF6rEYqr+bQSuNFCw4QTtqIlmTPR3Tm/PlVHHwfUqKTQ5It+CfzpnihA3FXDQwdUsKbBu/ISc5AHS4XEc5RVvJja1Ht2ukFpgKyIdwtBlEgtynXwvMgDU3VExykswUt+Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102460; c=relaxed/simple;
	bh=YxvmYpOV+737fyfcSQi4SIm2ZMFnBONYtUfp6vtMhrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qq5oQA+dRN5qxYl0t7gEIejGa2sIkwDN+7PDdYVwOxDbNKSgeFDqMCSRIUHRFEENZ7BhuNp79obIr5oD8L41EmPYneOqq9oAgERuVkgaHWOUPt5ZlRHod3+GJLrx+qKSHLUDD9qjj5+l9BSTOOa2WC3XkZHprLqBEPtQlqhLR4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hblcpIbX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hblcpIbX"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4563cfac19cso32136195e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 05:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753102456; x=1753707256; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJFteMx4M8CuvuwGOOEAn5xVwGW4RJ+pfzFY5hwg8co=;
        b=hblcpIbXA/mas6RnPSYQCu5EBpYi88Pbi5EKFdR71tlI64dg9eV/4CciBaH6XFYfyM
         E7brlzfprUxin4K/GYaOATNaJPxrqTLYFGR4jFGvwuwD7KBkSqrBtT0hi0YrUMRFq0ye
         9xqAUgLQScA2Dp82S+7113XCA+vw5iYBYXwZIDAxKeDRlhUBiF6fo4zBkwbYUhbliMJd
         ZZz+gOCR4pdX+VqDaDpX+1cFqgPq9j193h5DFBfEz/l98toQeO16kTmyiuiWocP5wHlS
         HGQ/8+FWWseaxxvZ8s2uqUOQ6Gx0RI1fw2Oy6Wk5wczHJXuV9ahFq/s/rLsrHjwjREtc
         0O8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753102456; x=1753707256;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJFteMx4M8CuvuwGOOEAn5xVwGW4RJ+pfzFY5hwg8co=;
        b=l3B7pQ7kjXRoZEfLae2jhptXN7wY3XSnLJVMR2zgaKJjrKmPzPVx5/I2k3VdJbzI4q
         8kn9AXTUowoDdG+D7PxebZRJheOhAA26VFodSMXywNxFguYVs+JYC+Mb53eUPngpK/2L
         p0EeUcWRne41keLHcHuziRmnJ5XNGjWhRyvDYyqr9Pexgb1AYXv7+p90MwXmgYlrZj5p
         22nuOMFsNHpb0PmqHdX08q6OM6vyBYwESB137uxoJWDq6fhreFABwhGAcZy5uaNgQAGS
         idVV86PEctwUGGv3+AxIZprC1+DBsw1np999pSL8KcXZm9TPaTyVpyuioWoqdoLxZrz9
         DjSg==
X-Forwarded-Encrypted: i=1; AJvYcCXWKdbEwMgy3s9cax3s0rJN0HNB//r3o3wFy2sjTzoPP9vAMol+9Rk+8lWkDDPmTEpfwoOgn/nxABfVj22/rj6e@vger.kernel.org
X-Gm-Message-State: AOJu0YyGaEN99GFmXyV6afTfpun8VTbmdiKNw5mDljHRZ/IdVxVe+F47
	ssnsS1tmVAZd9dZe+whyAnpg+FwOIkZ5C7+FAezIyP0fiOdAxO6IU6GnI9UODn0pkDY=
X-Gm-Gg: ASbGncvSsHXB454dFBT5LA5OHbbXJxiHXK7Y5k1GIKTJ8Op9MZe3zoSeD6784RI6tls
	cVZFZC+++Sq9CJRvleItWYHpB4m38NqdLOXQN9/eSgOPfiHvRvlsJMJasv6P8pONs/yniJghxtE
	9P7Kh+i9U0gtyri7koG7CCFBerGlqOLWi0SO4t5qYhDUfFDd0oYBmrziugg+rRqWm3xeeP+4j3Z
	CdbqS9+3Jz5DLHtgEBeZoHI4Vkd9a/urgNRmWDCWMhrt4fUHg8m1QE2KueNG0i0c6QIsrL1cEgy
	pyLSZGPjtDg2XLEkAUVbpM3zD7LNZj3EW+sdJ/hbbHc+5hWh90rS4EW/6eKjESHwKvPvVpi8Hmi
	DGL+pcMuejkGDPwtD4mG73h/iSvJ+rPY=
X-Google-Smtp-Source: AGHT+IGmbQWssAINXf1JMCsxu7iT/5v/bYbxuFsBy9x2nb4iGuog7PTzyHokdJFF6f22G9q2Sa/2qg==
X-Received: by 2002:a05:600c:4f91:b0:456:25e7:bed with SMTP id 5b1f17b1804b1-4562e23b6a5mr208680525e9.14.1753102456271;
        Mon, 21 Jul 2025 05:54:16 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b75de26sm98995225e9.33.2025.07.21.05.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 05:54:15 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 21 Jul 2025 13:53:36 +0100
Subject: [PATCH v4 05/12] arm64/boot: Factor out a macro to check SPE
 version
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-james-perf-feat_spe_eft-v4-5-0a527410f8fd@linaro.org>
References: <20250721-james-perf-feat_spe_eft-v4-0-0a527410f8fd@linaro.org>
In-Reply-To: <20250721-james-perf-feat_spe_eft-v4-0-0a527410f8fd@linaro.org>
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
 Adrian Hunter <adrian.hunter@intel.com>
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
index 9f38340d24c2..2bb0d28952e4 100644
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
@@ -189,6 +188,14 @@
 .Lskip_set_cptr_\@:
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
@@ -196,10 +203,8 @@
 	cbz	x1, .Lskip_fgt_\@
 
 	mov	x0, xzr
-	mrs	x1, id_aa64dfr0_el1
-	ubfx	x1, x1, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
-	cmp	x1, #3
-	b.lt	.Lskip_spe_fgt_\@
+	/* If SPEv1p2 is implemented, */
+	__spe_vers_imp .Lskip_spe_fgt_\@, #ID_AA64DFR0_EL1_PMSVer_V1P2, x1
 	/* Disable PMSNEVFR_EL1 read and write traps */
 	orr	x0, x0, #(1 << 62)
 

-- 
2.34.1

