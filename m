Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27D02D879E
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102462; cv=none; b=LmxBU9wVxKXNUjjo2fQFpRIkxUZ91ueV55NzDEGQW+/5hMRaSHx6vPLdexxghB0dHBmT9xj1naNV+CXvQ3qHaOxXhqQRX92G5M+P9oIBEC4qyklk09NdKPSnhJ1RuRoR7tisCmaGakdsl0NbB8/zXV6/ZH01ko9LlIdDszLmnC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102462; c=relaxed/simple;
	bh=hLgSVAZXcKLj9iMv2rrwXU/lzaoYubHOtjtwFpzEH48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mH1dd7dgySCLaGs8WCIV3T2T4Jo394P2k42iCAgiPFi2lbD4JPiMYaaTUgSZ+cAC5o5Izf93Y/N6fRWsk17Msd0VvHrJ1Iyxvnzn8y8pFLOyrexbvcyS3u/QlSw8PginP1J50NduY6SPKI8aaNDZa2HF//lmYdFD9tfORu+ktkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kYfKmEmT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kYfKmEmT"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso33127995e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 05:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753102459; x=1753707259; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oBEcxDyhRjewO1Y6U9fnxashwhAKoNPmyA1X1nUDdJU=;
        b=kYfKmEmTmW/4cXDIq0/Fx7Fq2U9zjvl6AruLdrwuG6+sMS2OFYXYIAnAza2p6fZpbg
         H5QwJpqIBKKjUV4wb8CnfLqqZfkqaAhNTxHDqTlR+5IZT6W4vat7+NMRVx/V+K5MMhSw
         Iwcex4Qch80Fg9l/89JVqvufvJAV5F9FyOgO30fEyUWDI4IaXi2X/EeB7WDi9FUURRgh
         UoStq47/y/PFkRhpOu6xWycCfsVhgyIG1HFB0f4RwPV7x1JheDFjRth4XB0EIa0iecXZ
         AdEY+kbmsNXSnQdtc3N4nl7Klp90T840hinnU2b2Rd+Zr9887/JRanJ4WBUX7HQln4XF
         8ulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753102459; x=1753707259;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBEcxDyhRjewO1Y6U9fnxashwhAKoNPmyA1X1nUDdJU=;
        b=PLailJo+HvUlDVqKVPO8P5FSZq3Oe7ZOTguGt8icwTzIblx8st1UFjEse/c2eCUA+z
         aqgGWT8VqwmJeA7jW8eF3xHfRkJtSpOx/u55CexOeVxygnbWzS4/jiZAdQcELYsYINXC
         soC+yg7cqdT9BOY6EBdogrpfDk9SsF/QeyGkFQGSBDv/9qy9AFy5t0OTVaQ0CF7D4grM
         tXECn4yqkuTQfmu09c3mWPuQtnusbcoEI5t4jpWrvwCi9h0CbgtznO4FoGAAG4x3/r4O
         WOCfgYFXLdowKU/TxPo9us32knDh4DH5IY3dl65SJuNkHtxAy480AmZovTCN9o1OBrGJ
         HKLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf/oFqc10xrJcHCFC1m/OyGztIeHidEAuHu8f8hiGqLRUy6G0+MNeHxGEOagOS48/s6Us6/uhPbds6m304DD/G@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+iR76jdXJrUTpA0USlwhDjL7aGGNcPo41XiuZimC+hP9Qwy7Y
	BC1IdXNwBi5ESqDPKrnD+nvF1efOtDA08R6Dk6SZBZM3ZsuI3GNdSUSuCI9fiN6mXC8=
X-Gm-Gg: ASbGncvcRd594FAjPdckdyeAZ39sS7gVVa7GBhlex0OnOrpuGxoLsisK/j663Sdm7vg
	U6twxQrYgjv9RlLMlXWzdX4fzdq8Dr+EiwVvyQGKRB8+pMCH2FyCi8LYB5/QE78Ae2WsbL2Z4fJ
	dlJzGpo8h6gxOPWS6+Fca3D7CQa78uKs5iT4MrdbsCEwQ2jyPMDc8qgsFuvjNQqwLDKXIByx+XI
	M412HvpE29BPPJWMuy/MBurV2vPBKE1Xs5ZmCERnQWBjXEIECFCHnCiby2eGx2h7fheP0G1veW0
	Cg6t7PrwW6XHeG5MC/e7uwxq/Vefohfz2ijZ6WXDtsZuY9ddlmXONjnlA6/GOXYYXaEHQygYQ8f
	fPw+BCJd+mOTxUj9hi2cfEl124ZpxgF4=
X-Google-Smtp-Source: AGHT+IFQ1W9RXFUvbYcVwuXuyPJydskAvKt1bW7ZkyNo1Omk2ZtSQ1JxYK5EzOAeDKe7/8CRt880JQ==
X-Received: by 2002:a05:600c:348c:b0:456:1d4e:c14f with SMTP id 5b1f17b1804b1-4564ab4fe8cmr29396345e9.28.1753102458979;
        Mon, 21 Jul 2025 05:54:18 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b75de26sm98995225e9.33.2025.07.21.05.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 05:54:18 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 21 Jul 2025 13:53:38 +0100
Subject: [PATCH v4 07/12] KVM: arm64: Add trap configs for PMSDSFR_EL1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-james-perf-feat_spe_eft-v4-7-0a527410f8fd@linaro.org>
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
 kvmarm@lists.linux.dev, Leo Yan <leo.yan@arm.com>, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

SPE data source filtering (SPE_FEAT_FDS) adds a new register
PMSDSFR_EL1, add the trap configs for it. PMSNEVFR_EL1 was also missing
its VNCR offset so add it along with PMSDSFR_EL1.

Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 arch/arm64/include/asm/vncr_mapping.h | 2 ++
 arch/arm64/kvm/emulate-nested.c       | 1 +
 arch/arm64/kvm/sys_regs.c             | 1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/vncr_mapping.h b/arch/arm64/include/asm/vncr_mapping.h
index 6f556e993644..dba0e58a5fac 100644
--- a/arch/arm64/include/asm/vncr_mapping.h
+++ b/arch/arm64/include/asm/vncr_mapping.h
@@ -92,6 +92,8 @@
 #define VNCR_PMSICR_EL1         0x838
 #define VNCR_PMSIRR_EL1         0x840
 #define VNCR_PMSLATFR_EL1       0x848
+#define VNCR_PMSNEVFR_EL1       0x850
+#define VNCR_PMSDSFR_EL1        0x858
 #define VNCR_TRFCR_EL1          0x880
 #define VNCR_MPAM1_EL1          0x900
 #define VNCR_MPAMHCR_EL2        0x930
diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
index 3a384e9660b8..60bd8b7f0e5b 100644
--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -1174,6 +1174,7 @@ static const struct encoding_to_trap_config encoding_to_cgt[] __initconst = {
 	SR_TRAP(SYS_PMSIRR_EL1,		CGT_MDCR_TPMS),
 	SR_TRAP(SYS_PMSLATFR_EL1,	CGT_MDCR_TPMS),
 	SR_TRAP(SYS_PMSNEVFR_EL1,	CGT_MDCR_TPMS),
+	SR_TRAP(SYS_PMSDSFR_EL1,	CGT_MDCR_TPMS),
 	SR_TRAP(SYS_TRFCR_EL1,		CGT_MDCR_TTRF),
 	SR_TRAP(SYS_TRBBASER_EL1,	CGT_MDCR_E2TB),
 	SR_TRAP(SYS_TRBLIMITR_EL1,	CGT_MDCR_E2TB),
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index c20bd6f21e60..82bddd631b47 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -3010,6 +3010,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_PMBLIMITR_EL1), undef_access },
 	{ SYS_DESC(SYS_PMBPTR_EL1), undef_access },
 	{ SYS_DESC(SYS_PMBSR_EL1), undef_access },
+	{ SYS_DESC(SYS_PMSDSFR_EL1), undef_access },
 	/* PMBIDR_EL1 is not trapped */
 
 	{ PMU_SYS_REG(PMINTENSET_EL1),

-- 
2.34.1

