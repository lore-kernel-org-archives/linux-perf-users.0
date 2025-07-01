Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D08527A101
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Jul 2025 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751383985; cv=none; b=eMGE4TAYC7AzqwseFWThLKEfGhx2wNpSo50p4e9sCTd0cV0fOtBwx0j2CrsMh6ftpJJn8F44n9ZQyxdwHsDIF5UonSD3xl/O3CqxSI863FWUjSkLCBecW/ymjgcbD+QOQ7NgNr9MFmJ7dg627pReBag3cG0sGYnPuPMYz+ft830=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751383985; c=relaxed/simple;
	bh=M/PRojLQRqIlDBhV5W9w+wqo0IQL6dvXbm4tDkWhbz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lga8nlMr2/MrGciO6cXaupk/RaVenIyJIS/wl3VIl44joHp59WZUiRUaity+eHX0c8yCGAjtpD0KPl9edt+XF/Z4cJrSOnsuN3poCJxSaTasvLBokvT7Cgc8pdxYJWOPPPmiy/WTJq5uJ9HBNIPvoF5zrl5+wl0ER4LjtK4WL68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ouB8tePV; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ouB8tePV"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4530921461aso38589985e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Jul 2025 08:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751383982; x=1751988782; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vyyFEki2WqLFGTJNxhVqg6BOlJH2bPcjpIbwwiG1+ts=;
        b=ouB8tePVKF4OH1IqUKVdCCSxM337dFyySH66QsBaIwQ6tNS/4vpIEGDXT45zFBy/I6
         f2w6uynFARbLQG3KjlD7MNEtSSGKvRKfk6Z/R7h1OP0kxYKRfoHCpGDYRLKcyJDyRZ0O
         3V+WXAUbJMxqMdqDJd+8m/1+l1UBFfY74NbxxNEPaELvF2A1YmUkiZLPv/h077LH0M8a
         mPVxbLFSKihUqYDH/qDMf6IA1QP1WROwuh/jTNWBgtONlQnWu/WJGqDSxS81mMo2SSiB
         7s7kGpgIKGIRlWuT1ptqXsI4ka78PkLb5QbKLZhIS5OuO8VGM1dMttENY5oFEz8GNWoE
         b6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751383982; x=1751988782;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vyyFEki2WqLFGTJNxhVqg6BOlJH2bPcjpIbwwiG1+ts=;
        b=g60fCvCn2MQhNyoOgsMBVNrwWf8jj3UQHeCQHmtkPF/4tBszjycAxxPqpu4sR4S6iv
         7kgJu12dUnix6FAdvvmwfR7/n5Pp619OeQFuN2Yqi+emj5Rchi/SVDGesMrapV2RA4mH
         376ezkD0XvmsUAW40tQeCeN08l7NSTXyRoRkCmvQhQNQWHXJgWhZKqfdhC6jFAvwM/ZZ
         F71DLHKY5wrS1yRACiWq04cQb2RahVTH0bU81vxfzSFiE5XtmSDGQdW+vxMtEkdfoPXY
         Pa8yLWZnfqRwwWhuGHJp1fEcyRKHvgt0tOB6NQxM/gwJEnFCAM9fW9ymX5YuBK3IlEqe
         tsSw==
X-Forwarded-Encrypted: i=1; AJvYcCU6b9WoA7GhMRmadb33boIb9kzq/vPyfjG7kyFZwowEwhWNlyWKO+Yu2pjGuN1Q/P5NWCJmHuQgcUyqJUmYD23v@vger.kernel.org
X-Gm-Message-State: AOJu0YxThK9HhcWSxt2MgX3ikZjFJ1WpXCX8T7WrPUYCbbaus4fqBYt4
	hyjOtUT1UBIcSF97Wy36MQKkVvoXdEQ1mf3fnbKpCHBMh4UBuH5HRslHl2u2DbGTQZc=
X-Gm-Gg: ASbGncs/mlIBNx2RfOCGhKeYLyU7NQ1oGhdTck4z2cvnwRsq8GCqtKkPw8DA0D2WV2L
	pOB3HxQKziXfZdQeAnjokzigvc8zGtRVixGvzL+Uf/o/yQ6f4LHnSoXD/wWPe13Avw3Gvrfh7M5
	97XLUwayFrd86CVaVaZy+aJMw5FzmLWmCaCh092RVD2kfCFBQhyC36BT0Ye/sTaqMogmwWpS6TC
	U+Nycwzq5EITu+fX4c3Ubdl7KIAryxOkpuY/EK8B2oaQZcRjt7hvSjYJtXWlIjzVWl8PBbOmKth
	M5RmhYLBKqKX0RQRk44ulHiHQLzw8nGCQzG+MvIinO51/qnQAeBe9xXEX/pJJKJX+1nJM00=
X-Google-Smtp-Source: AGHT+IHRSBNBwwc+SffZeGA8Ju+5Y/kf7iR6/4sPiOrk5WPd20gCoDRBdDhmJvz8jb8uT7zF55j0eQ==
X-Received: by 2002:a05:600c:198d:b0:453:b44:eb71 with SMTP id 5b1f17b1804b1-4538f2148b1mr164983525e9.19.1751383981587;
        Tue, 01 Jul 2025 08:33:01 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c80b5a3sm13435002f8f.40.2025.07.01.08.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 08:33:01 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 01 Jul 2025 16:31:59 +0100
Subject: [PATCH 3/3] perf: arm_spe: Add support for SPE VM interface
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-james-spe-vm-interface-v1-3-52a2cd223d00@linaro.org>
References: <20250701-james-spe-vm-interface-v1-0-52a2cd223d00@linaro.org>
In-Reply-To: <20250701-james-spe-vm-interface-v1-0-52a2cd223d00@linaro.org>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Alexandru Elisei <Alexandru.Elisei@arm.com>, 
 Anshuman Khandual <Anshuman.Khandual@arm.com>, 
 Rob Herring <Rob.Herring@arm.com>, Suzuki Poulose <Suzuki.Poulose@arm.com>, 
 Robin Murphy <Robin.Murphy@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

DEN0154 describes the new SPE VM interface, which allows the hypervisor
to define a max buffer size hint and to raise a new buffer management
error for exceeding it.

Report the size as a capability to userspace, and prevent larger buffers
from being allocated in the driver. Although it's a only a hint and
smaller buffers may also be disallowed in some scenarios, a larger
buffer is never expected to work so we can fail early. Failures after
arm_spe_pmu_setup_aux() have to happen asynchronously through the buffer
management event.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 arch/arm64/include/asm/sysreg.h |  1 +
 arch/arm64/tools/sysreg         |  6 +++++-
 drivers/perf/arm_spe_pmu.c      | 26 ++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index f1bb0d10c39a..9c48a7119aa7 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -367,6 +367,7 @@
 #define PMBSR_EL1_BUF_BSC_MASK		PMBSR_EL1_MSS_MASK
 
 #define PMBSR_EL1_BUF_BSC_FULL		0x1UL
+#define PMBSR_EL1_BUF_BSC_SIZE		0x4UL
 
 /*** End of Statistical Profiling Extension ***/
 
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 8a8cf6874298..d6bb1736f554 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2976,7 +2976,11 @@ Field	7:0	Attr
 EndSysreg
 
 Sysreg	PMBIDR_EL1	3	0	9	10	7
-Res0	63:12
+Res0	63:48
+Field	47:46	MaxBuffSize_RES
+Field	45:41	MaxBuffSize_E
+Field	40:32	MaxBuffSize_M
+Res0	31:12
 Enum	11:8	EA
 	0b0000	NotDescribed
 	0b0001	Ignored
diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 5829947c8871..23f18dc2890c 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -92,6 +92,7 @@ struct arm_spe_pmu {
 	u16					max_record_sz;
 	u16					align;
 	struct perf_output_handle __percpu	*handle;
+	u64					max_buff_size;
 };
 
 #define to_spe_pmu(p) (container_of(p, struct arm_spe_pmu, pmu))
@@ -115,6 +116,7 @@ enum arm_spe_pmu_capabilities {
 	SPE_PMU_CAP_FEAT_MAX,
 	SPE_PMU_CAP_CNT_SZ = SPE_PMU_CAP_FEAT_MAX,
 	SPE_PMU_CAP_MIN_IVAL,
+	SPE_PMU_CAP_MAX_BUFF_SIZE,
 };
 
 static int arm_spe_pmu_feat_caps[SPE_PMU_CAP_FEAT_MAX] = {
@@ -132,6 +134,8 @@ static u32 arm_spe_pmu_cap_get(struct arm_spe_pmu *spe_pmu, int cap)
 		return spe_pmu->counter_sz;
 	case SPE_PMU_CAP_MIN_IVAL:
 		return spe_pmu->min_period;
+	case SPE_PMU_CAP_MAX_BUFF_SIZE:
+		return spe_pmu->max_buff_size;
 	default:
 		WARN(1, "unknown cap %d\n", cap);
 	}
@@ -164,6 +168,7 @@ static struct attribute *arm_spe_pmu_cap_attr[] = {
 	SPE_CAP_EXT_ATTR_ENTRY(ernd, SPE_PMU_CAP_ERND),
 	SPE_CAP_EXT_ATTR_ENTRY(count_size, SPE_PMU_CAP_CNT_SZ),
 	SPE_CAP_EXT_ATTR_ENTRY(min_interval, SPE_PMU_CAP_MIN_IVAL),
+	SPE_CAP_EXT_ATTR_ENTRY(max_buff_size, SPE_PMU_CAP_MAX_BUFF_SIZE),
 	NULL,
 };
 
@@ -631,6 +636,9 @@ arm_spe_pmu_buf_get_fault_act(struct perf_output_handle *handle)
 	case PMBSR_EL1_BUF_BSC_FULL:
 		ret = SPE_PMU_BUF_FAULT_ACT_OK;
 		goto out_stop;
+	case PMBSR_EL1_BUF_BSC_SIZE:
+		err_str = "Buffer size too large";
+		goto out_err;
 	default:
 		err_str = "Unknown buffer status code";
 	}
@@ -896,6 +904,7 @@ static void *arm_spe_pmu_setup_aux(struct perf_event *event, void **pages,
 	int i, cpu = event->cpu;
 	struct page **pglist;
 	struct arm_spe_pmu_buf *buf;
+	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
 
 	/* We need at least two pages for this to work. */
 	if (nr_pages < 2)
@@ -910,6 +919,10 @@ static void *arm_spe_pmu_setup_aux(struct perf_event *event, void **pages,
 	if (snapshot && (nr_pages & 1))
 		return NULL;
 
+	if (spe_pmu->max_buff_size &&
+	    nr_pages * PAGE_SIZE > spe_pmu->max_buff_size)
+		return NULL;
+
 	if (cpu == -1)
 		cpu = raw_smp_processor_id();
 
@@ -999,6 +1012,17 @@ static void arm_spe_pmu_perf_destroy(struct arm_spe_pmu *spe_pmu)
 	perf_pmu_unregister(&spe_pmu->pmu);
 }
 
+static u64 arm_spe_decode_buf_size(u64 pmbidr)
+{
+	u64 mantissa = FIELD_GET(PMBIDR_EL1_MaxBuffSize_M, pmbidr);
+	u8 exp = FIELD_GET(PMBIDR_EL1_MaxBuffSize_E, pmbidr);
+
+	if (exp == 0)
+		return mantissa << 12;
+
+	return (mantissa | 0b1000000000) << (exp + 11);
+}
+
 static void __arm_spe_pmu_dev_probe(void *info)
 {
 	int fld;
@@ -1033,6 +1057,8 @@ static void __arm_spe_pmu_dev_probe(void *info)
 		return;
 	}
 
+	spe_pmu->max_buff_size = arm_spe_decode_buf_size(reg);
+
 	/* It's now safe to read PMSIDR and figure out what we've got */
 	reg = read_sysreg_s(SYS_PMSIDR_EL1);
 	if (FIELD_GET(PMSIDR_EL1_FE, reg))

-- 
2.34.1

