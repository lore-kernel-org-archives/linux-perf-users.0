Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6AD3218A1;
	Tue,  9 Sep 2025 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412766; cv=none; b=eNPWcBtA0KVC0ZSDLi7ShQ3Vn2kqv84zUZEBWrt2PWGZSsztC/yVcJKANCJygRLb0ElYDTe9UV+/DRp187ljBF8RsUMZOtW3T31i4Iq86W/BFv2ew1j/R5eIFbPVhUEj+Di/xeMpPcivyEMDiVB4MEC53hWUf9l9tk4P0S5Az5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412766; c=relaxed/simple;
	bh=NgCC4uycfCJaCGJcSahsc+gXSdvMHpeaREjvbA9LRE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kwI2UXyX7e107dKVO6c7xMH3xcPqlJMrr4C5hoKL9vq490bfeDpo23T/MnuUaGCi3fPXzJj05KgaKc1Xedx/xjwil16wciEj7Wfq9uykSLUe3wb3kabndYjDaXqLogYEcI/8INQf+BOYgGmuQHm829BZrmXyOhvYFfgaw7c2hXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfpMNGE4; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfpMNGE4"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so35373285e9.0;
        Tue, 09 Sep 2025 03:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757412762; x=1758017562; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CqCyjP3z7F10tcRyS6ryGhJEoWL9Np/LwW598YFvZGY=;
        b=UfpMNGE4JimHKBcLl7mUPPHr+Ot4OlVubz1aZ3HhPqveNvjTbe0IWroymG0eFtcX6Z
         ingeV1/rSa/ioYsxnsZklbcIBcrAzDtjji6O1OfOyoKwzAyzVVFe3gj3e4xb8QeiKmkO
         IAhv4RFKFhJe6T9+m/gqMcokzvx9bc2LzxymHOp0OGzokacJnE3S3UUhpZFHdxuLlI6C
         MbHxi0tEtl1R155hCVGx6fnr4GAs/aRy5TdQm9YppG/RZGnBCXbgJ+4nI7M9Kcbs5cUh
         LntnS9HsbGezVKZu9463YTjxEqEXyuEVV+k3unl06vOMjCRYXgYtgsyQuyNDYqT4wCOv
         ydtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757412762; x=1758017562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqCyjP3z7F10tcRyS6ryGhJEoWL9Np/LwW598YFvZGY=;
        b=P9zoMzs7pIShNpZ4p4NY2agcM1PV7vZNtOfQWj3VE8WsRBxAouLt81EqVwwr8wF6U2
         XTwVac/G4BH5vei5ytHYgkTCxCaVFzx7iVRTIBSw876LMJANSCNeKbJSQA2SHoIaa2m5
         mr6dFqsIFcqdL/FR3FdHjy7xAFfF5sVErlJe33PdDKxFqNURhbm/fV1ZC+y6ud8xHLAK
         lW3Yv2S1t7VvMV/a899SnSV7Jh/fDdmWAvVIxlCSOgZ9Fd8ZMaAXO4kzDghqYbHGX2RB
         /FhMs0sftx8Su4+QnZNIbVWevtgAEZeN0eDsKmckSlAemTe3fcAwUZz2sMZnRHkGVU0K
         xOFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt5e73ssr/sVPrdkvFRT3A8SMXvaVITdUVv/HrdmEMfFy6s6Wbv3snYtVtyl/z1fCurjJ3TCA9hTiR@vger.kernel.org, AJvYcCVuQva4JK8hBEBamKai5ffWSd/S2lw2zss1LjnmXPdBTnjIK8prGlEUrtgTu0Hukvyxgtg8OeOeVnZk@vger.kernel.org, AJvYcCWikll/4A1LJvEGtxReOlTf0b+kyJAhQvy01LmIBUf0sGOsrFfoNDPMfEesIA0dv9b3hb+j+XJHUhrOeKmR@vger.kernel.org, AJvYcCXQjVv0iQIfJmTXsWkgoX2wbx40bcfrB7HYEQuJzbsyVcL1i0KYeIBLH461KSntus/rx4n66YmqS6f/@vger.kernel.org, AJvYcCXlQUlxh1d3Dh0mQ6MpsE7lazbDX1qy/Q6P0w8LYQjWJjD/+XA/T1YdQ+HGRC4aSfYil1R/oq/L0hio0WfGNdnYqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBr1+3zfhQcu2B2CYDRuvzHeapRBRX0UDQJ+fK7dmYPDzEMky6
	9h3DAM907V2SdyBOJSArrAizfh882XuNfdT6jhzmeZL3jG3yeNQRheyQ
X-Gm-Gg: ASbGncs0Mezx56Wqxym4Hq1aXPk6nH3ZPLaGql+cujSp2hGXD/2lbmrEwcVJAE/GHwF
	o8OfDwVFzEUhpoWs7myiVtQm7TJ92twf6dlnN5iecLvpP8ITTwTJz6ora+H7fkNNPo7ArNfYsWZ
	kEsKIMqoZUDCuDLwxjmzqa+arPsKJi6DlBe3SKd91sBQhEon1hQs6UXuVS2DlkKRKtvD4oRBBQP
	lwD9dcm6h/ba3cU/YY0Fr3lPf6s5e5TSl3JjFvlC2LZXf5+jVqpSzZ1xnjcJmC3Am1CfCPel+u6
	Sy7NIWVaJ6Kv42Drch2UcNlee4fYEhU3BfsUuDSJHRWySwJh4VgleLrzVTo1qOw9Hx78lNjDN6I
	GLa2AkjHq9goe09ERTYbv55hKn53V4R8yBH8OoYymmGFuPYKT4rDDk89989DUcXv83q8W48p8xM
	u6PdoYamQ4WQVzObw=
X-Google-Smtp-Source: AGHT+IHSNt7ZxSHFDDuz04qqP6sftq2n73jb1Nndw6OMb1HkK/pmOtls8a389Ut8g5o8jrLiiEoQmw==
X-Received: by 2002:a05:600c:c297:b0:45c:b5c3:ea37 with SMTP id 5b1f17b1804b1-45dd5b68719mr88577915e9.11.1757412762208;
        Tue, 09 Sep 2025 03:12:42 -0700 (PDT)
Received: from localhost (2a02-8440-7136-74e7-5ebf-4282-0e1a-b885.rev.sfr.net. [2a02:8440:7136:74e7:5ebf:4282:e1a:b885])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75223f3e2sm2041352f8f.44.2025.09.09.03.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 03:12:41 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Tue, 09 Sep 2025 12:12:21 +0200
Subject: [PATCH v6 14/20] Documentation: perf: stm32: add ddrperfm support
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250909-b4-ddrperfm-upstream-v6-14-ce082cc801b5@gmail.com>
References: <20250909-b4-ddrperfm-upstream-v6-0-ce082cc801b5@gmail.com>
In-Reply-To: <20250909-b4-ddrperfm-upstream-v6-0-ce082cc801b5@gmail.com>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Julius Werner <jwerner@chromium.org>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
X-Mailer: b4 0.15-dev-dfb17

From: Clément Le Goffic <clement.legoffic@foss.st.com>

The DDRPERFM is the DDR Performance Monitor embedded in STM32MPU SoC.

This documentation introduces the DDRPERFM, the stm32-ddr-pmu driver
supporting it and how to use it with the perf tool.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 Documentation/admin-guide/perf/index.rst         |  1 +
 Documentation/admin-guide/perf/stm32-ddr-pmu.rst | 86 ++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
index 072b510385c4..33aedc4ee5c3 100644
--- a/Documentation/admin-guide/perf/index.rst
+++ b/Documentation/admin-guide/perf/index.rst
@@ -29,3 +29,4 @@ Performance monitor support
    cxl
    ampere_cspmu
    mrvl-pem-pmu
+   stm32-ddr-pmu
diff --git a/Documentation/admin-guide/perf/stm32-ddr-pmu.rst b/Documentation/admin-guide/perf/stm32-ddr-pmu.rst
new file mode 100644
index 000000000000..5b02bf44dd7a
--- /dev/null
+++ b/Documentation/admin-guide/perf/stm32-ddr-pmu.rst
@@ -0,0 +1,86 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================================
+STM32 DDR Performance Monitor (DDRPERFM)
+========================================
+
+The DDRPERFM is the DDR Performance Monitor embedded in STM32MPU SoC.
+The DDR controller provides events to DDRPERFM, once selected they are counted in the DDRPERFM
+peripheral.
+
+In MP1 family, the DDRPERFM is able to count 4 different events at the same time.
+However, the 4 events must belong to the same set.
+One hardware counter is dedicated to the time counter, `time_cnt`.
+
+In MP2 family, the DDRPERFM is able to select between 44 different DDR events.
+As for MP1, there is a dedicated hardware counter for the time.
+It is incremented every 4 DDR clock cycles.
+All the other counters can be freely allocated to count any other DDR event.
+
+The stm32-ddr-pmu driver relies on the perf PMU framework to expose the counters via sysfs:
+
+On MP1:
+
+    .. code-block:: bash
+
+        $ ls /sys/bus/event_source/devices/stm32_ddr_pmu/events/
+        cactive_ddrc                 perf_lpr_req_with_no_credit  perf_op_is_wr
+        ctl_idle                     perf_lpr_xact_when_critical  perf_selfresh_mode
+        dfi_lp_req                   perf_op_is_activate          perf_wr_xact_when_critical
+        dfi_lp_req_cpy               perf_op_is_enter_powerdown   time_cnt
+        perf_hpr_req_with_no_credit  perf_op_is_rd
+        perf_hpr_xact_when_critical  perf_op_is_refresh
+
+On MP2:
+
+    .. code-block:: bash
+
+        $ ls /sys/bus/event_source/devices/stm32_ddr_pmu/events/
+        dfi_is_act       perf_hpr_req_with_nocredit   perf_op_is_spec_ref
+        dfi_is_mpc       perf_hpr_xact_when_critical  perf_op_is_wr
+        dfi_is_mrr       perf_lpr_req_with_nocredit   perf_op_is_zqcal
+        dfi_is_mrw       perf_lpr_xact_when_critical  perf_rank
+        dfi_is_mwr       perf_op_is_act               perf_raw_hazard
+        dfi_is_mwra      perf_op_is_crit_ref          perf_rdwr_transitions
+        dfi_is_preab     perf_op_is_enter_powdn       perf_read_bypass
+        dfi_is_prepb     perf_op_is_enter_selfref     perf_war_hazard
+        dfi_is_rd        perf_op_is_mwr               perf_waw_hazard
+        dfi_is_rda       perf_op_is_pre               perf_window_limit_reached_rd
+        dfi_is_refab     perf_op_is_pre_for_others    perf_window_limit_reached_wr
+        dfi_is_refpb     perf_op_is_pre_for_rdwr      perf_wr_xact_when_critical
+        dfi_is_wr        perf_op_is_rd                time_cnt
+        dfi_is_wra       perf_op_is_rd_activate
+        perf_act_bypass  perf_op_is_ref
+
+
+The perf PMU framework is usually invoked via the 'perf stat' tool.
+
+
+Example:
+
+    .. code-block:: bash
+
+        $ perf stat --timeout 60000 -e stm32_ddr_pmu/dfi_is_act/,\
+        > stm32_ddr_pmu/dfi_is_rd/,\
+        > stm32_ddr_pmu/dfi_is_wr/,\
+        > stm32_ddr_pmu/dfi_is_refab/,\
+        > stm32_ddr_pmu/dfi_is_mrw/,\
+        > stm32_ddr_pmu/dfi_is_rda/,\
+        > stm32_ddr_pmu/dfi_is_wra/,\
+        > stm32_ddr_pmu/dfi_is_mrr/,\
+        > stm32_ddr_pmu/time_cnt/ \
+        > -a sleep 5
+
+         Performance counter stats for 'system wide':
+
+                    481025      stm32_ddr_pmu/dfi_is_act/
+                    732166      stm32_ddr_pmu/dfi_is_rd/
+                    144926      stm32_ddr_pmu/dfi_is_wr/
+                    644154      stm32_ddr_pmu/dfi_is_refab/
+                         0      stm32_ddr_pmu/dfi_is_mrw/
+                         0      stm32_ddr_pmu/dfi_is_rda/
+                         0      stm32_ddr_pmu/dfi_is_wra/
+                         0      stm32_ddr_pmu/dfi_is_mrr/
+                 752347686      stm32_ddr_pmu/time_cnt/
+
+               5.014910750 seconds time elapsed

-- 
2.43.0

