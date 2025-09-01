Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D1A3314DE
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Sep 2025 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756730521; cv=none; b=ttc23JCtVayd9UWnn4i9TaY3u6kEehwq7mqG6R+Sv8yJ9xgul1frqA6hcuEXWetljlAI+RyMsBF2ZuPhgIFR1oo6jWo6nUeCOp4zkFuCWMNp0nTIgo1+QRo64RQis/LrUf10XE6/QL/C4wUdooduC/mAeh0Mx0Z8mwdu2E2Tsuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756730521; c=relaxed/simple;
	bh=hHJpIJlIFEz6CSYyOaizP0+u4TVXaro/PALZLQfLUyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LL+Eg8UpW6N+0yNym49dDYuYn2E4OpGCex3HRM1e8qH7APcgRETjc9dGFrIEL4JS+pXJ8A7NJjcIz2c5+x5FtLlhA8U/Mnxfkn+41xkYsbhgc9IW59iF0RXoxJMs9jCyVwu0ytIVUwxwP8O77Mt3bSQwNZsVr61NV8bUuNMQNBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tGzKKMuN; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tGzKKMuN"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b7d87b90fso27015115e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Sep 2025 05:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756730517; x=1757335317; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OSNn3QEar0+QuKyDmtURSQ4BVOB8JOPxQiblvR548LM=;
        b=tGzKKMuN73bqybJ2SbOIMdNZ5i0hurffWI2ph4yCsvcjkKuUgQRkQnAYCoLXqrtJrW
         jPKjr8djh9GiXy1bDxU4raXSsIyDhfsAKIOLvkukL62QTMLJ/x6MAl3HzZ8TJhl4m2Tm
         sqYjF0CToRzrFZkWAUfsLnPtgiG9+UZJ6btzX8f9pjbU/v6JtIjnbRtfUf1eMk5QYQZA
         pfd2ZiBb2/+gghHp0YRrxu1t6WnSxo7aBY4pVjzd0J8Cof+15AKB1HTrvIhFXJP4ZmI5
         DryN9SHDlS1f0Eq9GjiaygkqxHSK2GTyGgRFZfMaesSGgovF+OptRgA3EsARfZ/SPHyG
         aAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756730517; x=1757335317;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSNn3QEar0+QuKyDmtURSQ4BVOB8JOPxQiblvR548LM=;
        b=jHWoIS74DhplpSUo0J2MXm1ht4iCtszqFg3kxI9Gb9MmA8hvzq74SCSYsYcQb3gN6t
         lxm+wP9MhoORPy+XSCoRqMbn7scvZvcXMTwuHq9cgn7pp2qHMiExjKmOnEISKohHKYAB
         0PzQJvAk0FWI/W18kRlaCfucIbpIlTVTef6Su0hpOrP6H4UEn4LFxf4OB9a0zdaS2UPM
         Sl88p1tIneKPbucP4NkhcShRMPCdHQoWZYLgobpnHv+RiZZV0wMzQfZycmsOGwJkDTEQ
         AiaJ/z/JmaqWr0moYFzpJ8p34I/f3krMwOqlDu+ybMg/3CKxAl/PVNx/aymqmfZbicv9
         4Z/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJt6JKVfdVVW4PoXq6B+XcUrznZ1ISDnHd6lZZNEW90nadHW/I0xqtbNbipXbiBLM7dBp0A87/vK3vVECTJdhl@vger.kernel.org
X-Gm-Message-State: AOJu0YzfUUqnzwnBIeBuuszmuu9pz/4GRS6sKpFkhlMbkJtjta7mSWDN
	MyCaCWqYkz2jad7CU3nR3AYiPjxIg9wK35vIcpfRLq0mq+q5DvD4TChngKPmkthHSWg=
X-Gm-Gg: ASbGncvgEsguezxt9G/d5b5EUORVBbpZMj48PZlon37VusrFHq/d4YPDy25bpxcv+JV
	ul3BUA/D4x9a5W76vn0PMzd0n6Qtx67QQgEfhBCaBGGv9WeHX79fZLazwYbHan8w64J2Sv6uGJx
	zz87vcbCK4YPWgOCNnjwrHe0qF4uXUKSTcLj4oDGPu3Td5SrV0r/Ga1rHWJ+rrPPIJZYy1SYiup
	bW2PPuOcmRvp8YcCdfaKHF0aLdmlJ2gPQi/ekZ4CntLLFrXEuDUYovZb1DK4IeefOpmdUQwbOg4
	wi5geZfG7efLkxRI7RMLmAVQxScJB84ST8ik9rcGuLfdHlXkyYyfiFbD/rypYFDKSszDBDNAwCO
	rbJG4LBno5zrUL07VqGGmyDFolXBN61CjtY75N0Q70QP644EOhxFi
X-Google-Smtp-Source: AGHT+IFhQWkNlLbN+/KIksY266G8T+wNBjSFtPM3Dq8DGWiTprcVcLD3OEdLOpKY4eMNn6tRYHKpVg==
X-Received: by 2002:a05:600c:810c:b0:45b:92a6:63e3 with SMTP id 5b1f17b1804b1-45b92a665f4mr3191135e9.9.1756730517057;
        Mon, 01 Sep 2025 05:41:57 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e898b99sm154946315e9.19.2025.09.01.05.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:41:56 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 01 Sep 2025 13:40:35 +0100
Subject: [PATCH v8 06/12] arm64/boot: Enable EL2 requirements for
 SPE_FEAT_FDS
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-james-perf-feat_spe_eft-v8-6-2e2738f24559@linaro.org>
References: <20250901-james-perf-feat_spe_eft-v8-0-2e2738f24559@linaro.org>
In-Reply-To: <20250901-james-perf-feat_spe_eft-v8-0-2e2738f24559@linaro.org>
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

SPE data source filtering (optional from Armv8.8) requires that traps to
the filter register PMSDSFR be disabled. Document the requirements and
disable the traps if the feature is present.

Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 Documentation/arch/arm64/booting.rst | 11 +++++++++++
 arch/arm64/include/asm/el2_setup.h   | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
index 2f666a7c303c..e4f953839f71 100644
--- a/Documentation/arch/arm64/booting.rst
+++ b/Documentation/arch/arm64/booting.rst
@@ -466,6 +466,17 @@ Before jumping into the kernel, the following conditions must be met:
     - HDFGWTR2_EL2.nPMICFILTR_EL0 (bit 3) must be initialised to 0b1.
     - HDFGWTR2_EL2.nPMUACR_EL1 (bit 4) must be initialised to 0b1.
 
+  For CPUs with SPE data source filtering (FEAT_SPE_FDS):
+
+  - If EL3 is present:
+
+    - MDCR_EL3.EnPMS3 (bit 42) must be initialised to 0b1.
+
+  - If the kernel is entered at EL1 and EL2 is present:
+
+    - HDFGRTR2_EL2.nPMSDSFR_EL1 (bit 19) must be initialised to 0b1.
+    - HDFGWTR2_EL2.nPMSDSFR_EL1 (bit 19) must be initialised to 0b1.
+
   For CPUs with Memory Copy and Memory Set instructions (FEAT_MOPS):
 
   - If the kernel is entered at EL1 and EL2 is present:
diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index a305386eb2e3..b37da3ee8529 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -392,6 +392,17 @@
 	orr	x0, x0, #HDFGRTR2_EL2_nPMICFILTR_EL0
 	orr	x0, x0, #HDFGRTR2_EL2_nPMUACR_EL1
 .Lskip_pmuv3p9_\@:
+	/* If SPE is implemented, */
+	__spe_vers_imp .Lskip_spefds_\@, ID_AA64DFR0_EL1_PMSVer_IMP, x1
+	/* we can read PMSIDR and */
+	mrs_s	x1, SYS_PMSIDR_EL1
+	and	x1, x1,  #PMSIDR_EL1_FDS
+	/* if FEAT_SPE_FDS is implemented, */
+	cbz	x1, .Lskip_spefds_\@
+	/* disable traps of PMSDSFR to EL2. */
+	orr	x0, x0, #HDFGRTR2_EL2_nPMSDSFR_EL1
+
+.Lskip_spefds_\@:
 	msr_s   SYS_HDFGRTR2_EL2, x0
 	msr_s   SYS_HDFGWTR2_EL2, x0
 	msr_s   SYS_HFGRTR2_EL2, xzr

-- 
2.34.1

