Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54BC275869
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Aug 2025 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754652237; cv=none; b=HaFCg0V1wC2T1IwzwEhBI8AEIbLpQTFcQ3Hjrb9fzplvyhzQQTC3qD7QXrVoOxRffVdcyGyWYV1APOp4BybaHO79Ez7R8+eVZvdsXWtv3A5yRzUfaQ3BhDQDd/gjghGQ1uMeKmFVI+1PyHUZu7WY6I0KT122/EuT2NsAajw3t4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754652237; c=relaxed/simple;
	bh=+2GYlOZHwCZ0lRFJU17Kz/6XYFxNBVKE33Il+Q5Ltpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CHrDBrc3b0+4B2MHGyyyuNNtruZYBj4rUERtfqeycMsnMbwy7Oet3uzTr5avKvj4Opb2pll3OI0YhAmWXSu2zwvAqzcrEOSppTOzi2tSan2eBeTlo5qU5h8uGlCqcLPz5a1sn+x99f7416sXXI35EshzQpKvnt5UipnOXTpPGIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e/Gs44vQ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e/Gs44vQ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b78d729bb8so1375500f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Aug 2025 04:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754652234; x=1755257034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tCkPGBMU9cuxNuxHQvLapYjmFGObKhPk55g8w7OjRxY=;
        b=e/Gs44vQS6XqDUlpse74/TptHOfjxJxFtj2RcxZmdmXKFiJRK55dsddDwgQiJzhkuT
         znEsLZFnlXrgSsGF6HEBUWS8/DR1k3y0eA97HLXElduQxWBMS46X/J+D4B9MjmA2lbIH
         wlr81QJj4nUjy0AKmvHRmK30Fwa471gprd4fZPIYH2MBCHIqUucy/yqoirr7+SZ+EBjF
         91dSxhjXI8h2wX6A5g/mqJzYhMleeUidLu9weuDEQ5fJYB8dZeK4IDdIGmM23wjy1a+t
         P769y3srJpmZU0Met5M6M1YiUU4ZmHSgJXcDeAtNXfErMeulfqOvjsIYCfgBfFNMJ082
         FwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754652234; x=1755257034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCkPGBMU9cuxNuxHQvLapYjmFGObKhPk55g8w7OjRxY=;
        b=ilQkyc8RdrTj/AbmjFQ87DITnZzz+EPyzy2mVcZRdCjzN5gVUbZxTAprei2+bKenqF
         tWzigGt3KrBChuQx8RTpc/I36blhajJNgtobRiKdTxaHs57hX9Kd9KQ//Hs5H2T7oIzF
         5DB+Dkt8/jKgp2cvEmTkn2yqpjcNlk5ccF1H0/11LDP6Z0EHRTKF9PlimTpjEbrylcfp
         SSO+gLsBI3qsRhPChWQta0R/hgCEfRCe86+HgATaqF7sWEjJj9RdLXfb5Yicr7lIh4xm
         os6SjCO+NF15M/GH3bd752hdz58C0rZXxwEnBPl4GVdkN9eN0xXYEFVDz9kLqZ8PCuxp
         G4Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUffhDrJrliPFVOJ5K29Ft5S8RFjHkevqIgyh7Qg0J/OeCxHoqNGpG1A4fwOgzr+bnh++E/diOd3ieTwLnYDGHx@vger.kernel.org
X-Gm-Message-State: AOJu0YxKKpIcLSyDS520SJbxDCCJ00KACKXKrLJSUn+CMKmpXHtfP1Qe
	gIZbZACjFZRs29B62i1tnrSS67TDnOMjazdtco2S5do2z4F/VUL5keNgtP0UXrof6Lc=
X-Gm-Gg: ASbGnct/Nz/4YK1RDSdfix8Fnw1JGwhiSjaT5noUgzg4u6sPIGv0+04CwxYtgGtyv0J
	gwCx9lGoSVKF40vRqzDT8lO20TbltAC6mB6XE/tVktxObPRRg2fyUynnuOoTNrE+GwGIJSOxWL1
	SnF7UbmOTYSYhZortPjSAAeXOWFv08CjBH7JD5wDYEP2TBuRE4ITbMh+RvwyK0Queq2dpSifeSj
	nOlZRVMjKOu4Iv5vhuTRYxMtlCAo0hw0qdhod7rmSwl5syyMAMfc1WeCAAJD1JXmZOo3xQU+CeM
	71sFa6+tJBo5rk0uHR4uJQHBFT5z+gh6FttB5IF5LIbS7gZ7+FsesGsJCaAYgSydexTSkde6lpz
	KnZ+rrd5K+CYb10AGlhBdaiEa9OESCZ4=
X-Google-Smtp-Source: AGHT+IHbD1rxZ+hael7UI+V4nWIH1JBGIhGROdLFUhD8+vK/+XpzNrjCzw2lcwqBQ5oIfEeaFLVqCQ==
X-Received: by 2002:a05:6000:288b:b0:3b5:f0aa:b1e5 with SMTP id ffacd0b85a97d-3b900b4dac6mr1921081f8f.19.1754652233967;
        Fri, 08 Aug 2025 04:23:53 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45923c34af8sm233482635e9.24.2025.08.08.04.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 04:23:53 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 08 Aug 2025 12:23:04 +0100
Subject: [PATCH v6 07/12] KVM: arm64: Add trap configs for PMSDSFR_EL1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-james-perf-feat_spe_eft-v6-7-6daf498578c8@linaro.org>
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

SPE data source filtering (SPE_FEAT_FDS) adds a new register
PMSDSFR_EL1, add the trap configs for it. PMSNEVFR_EL1 was also missing
its VNCR offset so add it along with PMSDSFR_EL1.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 arch/arm64/include/asm/vncr_mapping.h | 2 ++
 arch/arm64/kvm/emulate-nested.c       | 1 +
 arch/arm64/kvm/sys_regs.c             | 1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/vncr_mapping.h b/arch/arm64/include/asm/vncr_mapping.h
index f6ec500ad3fa..c2485a862e69 100644
--- a/arch/arm64/include/asm/vncr_mapping.h
+++ b/arch/arm64/include/asm/vncr_mapping.h
@@ -94,6 +94,8 @@
 #define VNCR_PMSICR_EL1         0x838
 #define VNCR_PMSIRR_EL1         0x840
 #define VNCR_PMSLATFR_EL1       0x848
+#define VNCR_PMSNEVFR_EL1       0x850
+#define VNCR_PMSDSFR_EL1        0x858
 #define VNCR_TRFCR_EL1          0x880
 #define VNCR_MPAM1_EL1          0x900
 #define VNCR_MPAMHCR_EL2        0x930
diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
index 90cb4b7ae0ff..aeaba7813275 100644
--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -1185,6 +1185,7 @@ static const struct encoding_to_trap_config encoding_to_cgt[] __initconst = {
 	SR_TRAP(SYS_PMSIRR_EL1,		CGT_MDCR_TPMS),
 	SR_TRAP(SYS_PMSLATFR_EL1,	CGT_MDCR_TPMS),
 	SR_TRAP(SYS_PMSNEVFR_EL1,	CGT_MDCR_TPMS),
+	SR_TRAP(SYS_PMSDSFR_EL1,	CGT_MDCR_TPMS),
 	SR_TRAP(SYS_TRFCR_EL1,		CGT_MDCR_TTRF),
 	SR_TRAP(SYS_TRBBASER_EL1,	CGT_MDCR_E2TB),
 	SR_TRAP(SYS_TRBLIMITR_EL1,	CGT_MDCR_E2TB),
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 82ffb3b3b3cf..d1a55cf589b7 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -3083,6 +3083,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_PMBLIMITR_EL1), undef_access },
 	{ SYS_DESC(SYS_PMBPTR_EL1), undef_access },
 	{ SYS_DESC(SYS_PMBSR_EL1), undef_access },
+	{ SYS_DESC(SYS_PMSDSFR_EL1), undef_access },
 	/* PMBIDR_EL1 is not trapped */
 
 	{ PMU_SYS_REG(PMINTENSET_EL1),

-- 
2.34.1

