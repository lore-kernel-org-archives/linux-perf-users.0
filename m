Received: from out-171.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8000B3C1D7B
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786090199; cv=none; b=KUsJ8jGmkibclarr/0wXZN/7u1u11gLQ2AhNTcmdC9m4IZg3386cxtqNbfVBzWmJMOLAQZu19zG4qrUByEliZ9P6enw+dCfBJXKZeHcTb6btNxp9DDkg5jovjsvToaSyt3tRrMNoS/r7m3wbzrnG/mBXMsUxDk55lMt+zdjECEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786090199; c=relaxed/simple;
	bh=vNNry3FXsrsEI8UhZur0l3Ax5FG8zSBurGO95vodqjM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kjiVZ5gMEF7mtFbmuEQ+PgoA9x4u1gnWrgAFfMqewnuesIZLOslo71ipqjkpyL0A3FvJo1QPgGxYYlB/FDVbqhCPbnT+ONzExU4JMpHLZXYTiVcAZldQn8CMqcWOAenHVXM+6voMUoSEI4gC4uKRDnw5vUacQN48JSrKCIWElrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=He9aUBro; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="He9aUBro"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786090190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uH8jIuxLMy4lWgOnqryCdwNUqd6ifoWFBriuPzXx9AA=;
	b=He9aUBrooZ5ohd6C7fdPaJDlhU5m69w5c/S/QiosjC2gL5wf/hjli79l35ErqUGqNDM4wf
	4NOEaVgD+V0ljF/UEKYif7YF9rX3N94gFDtRFtPRY3lgTQ9Dx7Rxxi5P+8rc8g2pnHFu8n
	qpjCvql4nivbA7VJrQu9Dc6EgjG36DM=
From: Atish Patra <atish.patra@linux.dev>
Date: Fri, 07 Aug 2026 01:09:04 -0700
Subject: [PATCH v9 09/20] RISC-V: Add Ssccfg/Smcdeleg ISA extension
 definition and parsing
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260807-counter_delegation-v9-9-58658104e487@meta.com>
References: <20260807-counter_delegation-v9-0-58658104e487@meta.com>
In-Reply-To: <20260807-counter_delegation-v9-0-58658104e487@meta.com>
To: Will Deacon <will@kernel.org>, Atish Patra <atish.patra@linux.dev>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Ian Rogers <irogers@google.com>, 
 Rob Herring <robh@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 James Clark <james.clark@linaro.org>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org
X-Migadu-Flow: FLOW_OUT

From: Atish Patra <atishp@rivosinc.com>

Smcdeleg extension allows the M-mode to delegate selected counters
to S-mode so that it can access those counters and correpsonding
hpmevent CSRs without M-mode.

Ssccfg (‘Ss’ for Privileged architecture and Supervisor-level
extension, ‘ccfg’ for Counter Configuration) provides access to
delegated counters and new supervisor-level state.

This patch just enables these definitions and enable parsing.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
Link: https://patch.msgid.link/20260701-counter_delegation-v8-9-7909f863a645@meta.com
Signed-off-by: Paul Walmsley <pjw@kernel.org>
Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
---
 arch/riscv/include/asm/hwcap.h |  2 ++
 arch/riscv/kernel/cpufeature.c | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 51ad55b9677a..089353b250b0 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -115,6 +115,8 @@
 #define RISCV_ISA_EXT_SSCSRIND		106
 #define RISCV_ISA_EXT_SMCSRIND		107
 #define RISCV_ISA_EXT_SMCNTRPMF		108
+#define RISCV_ISA_EXT_SSCCFG		109
+#define RISCV_ISA_EXT_SMCDELEG		110
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 1452521d740a..1fe647e03515 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -330,6 +330,27 @@ static const unsigned int riscv_a_exts[] = {
 	RISCV_ISA_EXT_ZKNE,	\
 	RISCV_ISA_EXT_ZKNH
 
+static int riscv_ext_smcdeleg_validate(const struct riscv_isa_ext_data *data,
+				       const unsigned long *isa_bitmap)
+{
+	if (__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_SSCSRIND) &&
+	    __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZIHPM) &&
+	    __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZICNTR))
+		return 0;
+
+	return -EPROBE_DEFER;
+}
+
+static int riscv_ext_ssccfg_validate(const struct riscv_isa_ext_data *data,
+				     const unsigned long *isa_bitmap)
+{
+	if (!riscv_ext_smcdeleg_validate(data, isa_bitmap) &&
+	    __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_SMCDELEG))
+		return 0;
+
+	return -EPROBE_DEFER;
+}
+
 static const unsigned int riscv_zk_bundled_exts[] = {
 	RISCV_ISA_EXT_ZKN,
 	RISCV_ISA_EXT_ZKR,
@@ -576,12 +597,15 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_BUNDLE_VALIDATE(zvksg, riscv_zvksg_bundled_exts, riscv_ext_vector_crypto_validate),
 	__RISCV_ISA_EXT_DATA_VALIDATE(zvkt, RISCV_ISA_EXT_ZVKT, riscv_ext_vector_crypto_validate),
 	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
+	__RISCV_ISA_EXT_DATA_VALIDATE(smcdeleg, RISCV_ISA_EXT_SMCDELEG,
+				      riscv_ext_smcdeleg_validate),
 	__RISCV_ISA_EXT_DATA(smcntrpmf, RISCV_ISA_EXT_SMCNTRPMF),
 	__RISCV_ISA_EXT_DATA(smcsrind, RISCV_ISA_EXT_SMCSRIND),
 	__RISCV_ISA_EXT_DATA(smmpm, RISCV_ISA_EXT_SMMPM),
 	__RISCV_ISA_EXT_SUPERSET(smnpm, RISCV_ISA_EXT_SMNPM, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
 	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
+	__RISCV_ISA_EXT_DATA_VALIDATE(ssccfg, RISCV_ISA_EXT_SSCCFG, riscv_ext_ssccfg_validate),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
 	__RISCV_ISA_EXT_DATA(sscsrind, RISCV_ISA_EXT_SSCSRIND),
 	__RISCV_ISA_EXT_SUPERSET(ssnpm, RISCV_ISA_EXT_SSNPM, riscv_xlinuxenvcfg_exts),

-- 
2.53.0-Meta

