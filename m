Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF45822F14D
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Jun 2025 19:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748892552; cv=none; b=I1Cwkl6ti9HXw/Ky5A5BsBS8UftMEJrt7UXfRlmJFddfDmkX4zWVqhPCb6LtoAXVCbzZQILLZBo51gXAHr+6SAKuEBdBNKeyt6SNF0BP2IkH2jMTsRaAru8KcWf5wJj0IWdcE/YwDRzLByxjUMTlskvwah2XDs6M4LQxUMzcttA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748892552; c=relaxed/simple;
	bh=gJd6Sg7X96ujBJm4xpL0n0BwR1+EO0NbIRmkP5OmPT4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bd7CEimTiyeEF13S3zFFMk25y2zwWFmmdegSTY0ZZ32iWIkbJQk7G/5PXHUjnmKZTAEX4wxV6sIgMulbRDLFcOFo9OSuJGQQCx5I2fJmM8WxxMrn33k7zar5whIiQQJWX4/RbYoN9QtabRBWpp1EJmEULulDKTUmI01kJO79AaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2xu2INbU; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2xu2INbU"
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3ddb4ed2dcbso9577765ab.3
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Jun 2025 12:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748892548; x=1749497348; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0IRqT9xxCS8Kun6mHdSmbCCnl/MV3abA8LdyACjVeWc=;
        b=2xu2INbUiEVO58sHWysGfajYXYbVRySX9C+ukIFuCbZus28tfF7BD8AUPLaV1F7Yth
         Bf18oBamSW5HRxtDbCD9OCDzc1XpVbHrEEbK96ANoi+l0BDOuCnOJMdH8q5J7tymddYw
         0zAfaEfnUi1JiSpu6RAZcKgF2Xei1aiM7frXiXB/BNU/TwdnlMDaWqN6bhIBSyXoltkg
         ++mJs6PYNlsnIHIlMjUbwc6LhPPd3UxEAJrzkxv1NO6KK/rHatAqurZcTVgqc7KOUTGv
         pzrPqFV4ovefeICec3AfoXqQof+JuMNZM/Zu6Lde/yDChtNXgITM6hr3WXPrlIO1gjMC
         U41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748892548; x=1749497348;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0IRqT9xxCS8Kun6mHdSmbCCnl/MV3abA8LdyACjVeWc=;
        b=PhETByF1LWFznOco/EvVABMZLpTq3oB8NoRlRazSdJrtSvs1CIKuP3uQg7z9znkV9X
         t0jGfY81lgr6eNQAEGnD8KvKYz6tgkFjMLQZfWJvqHX5tytymPNdTGHiHNUV9/c/2jpj
         MU9sOjzxg2oxPTuJQoUb8gy/yL1+QWazzXqtFA/f1tXTIpXYrL5pyM4EcveCy8EckSjj
         rpC1Ydt7Xn/pd92fcCAe/qGkIfPIxjjnfgMXSBywIAPUsUysuzRXE+nWM1SVGzniAuE9
         hArObv1T5rQSWlv7SFi67eRMFsendjgCQC1av3DbtTcbIJ/WLhG0hJU4XFgSXfUU40MV
         046g==
X-Forwarded-Encrypted: i=1; AJvYcCV9WSRg750jysmFbCCQRJsiFEW1YzpM6nOFuAKqHCQ6YMXG3jZ8pZZ0ILrN15hvtqGD4a2xR/xCvY8PFNs02Gom@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzj5zKOQHtozFQc7fDFvHeezB5wCrJdrcQIbUdS08+Br42gjkV
	8vkevdewX4chVSJbXXxdEHEzCllvm9hofQliLF86vYoww/sEHYEqqsTLgsxrYZ2zZ3MKmCc4QC3
	E6Rpq6V+UKPiNSr0IujcBtNeEcQ==
X-Google-Smtp-Source: AGHT+IFMVeKyETkycXmBUpASHlOBIqAlJOgdAa/bpyVkcS9jV+S6qkzUphiHGfVK6q8KTzMSYrzDWRGuInC2fMT41A==
X-Received: from ilbbk6.prod.google.com ([2002:a05:6e02:3286:b0:3dd:b580:4100])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:4515:10b0:3dd:b5c6:421f with SMTP id e9e14a558f8ab-3ddb5c642c8mr13690965ab.6.1748892547783;
 Mon, 02 Jun 2025 12:29:07 -0700 (PDT)
Date: Mon,  2 Jun 2025 19:26:55 +0000
In-Reply-To: <20250602192702.2125115-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250602192702.2125115-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250602192702.2125115-11-coltonlewis@google.com>
Subject: [PATCH 10/17] KVM: arm64: Writethrough trapped PMEVTYPER register
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

With FGT in place, the remaining trapped registers need to be written
through to the underlying physical registers as well as the virtual
ones. Failing to do this means delaying when guest writes take effect.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/sys_regs.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index d368eeb4f88e..afd06400429a 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -18,6 +18,7 @@
 #include <linux/printk.h>
 #include <linux/uaccess.h>
 #include <linux/irqchip/arm-gic-v3.h>
+#include <linux/perf/arm_pmu.h>
 #include <linux/perf/arm_pmuv3.h>
 
 #include <asm/arm_pmuv3.h>
@@ -942,7 +943,11 @@ static bool pmu_counter_idx_valid(struct kvm_vcpu *vcpu, u64 idx)
 {
 	u64 pmcr, val;
 
-	pmcr = kvm_vcpu_read_pmcr(vcpu);
+	if (kvm_vcpu_pmu_is_partitioned(vcpu))
+		pmcr = read_pmcr();
+	else
+		pmcr = kvm_vcpu_read_pmcr(vcpu);
+
 	val = FIELD_GET(ARMV8_PMU_PMCR_N, pmcr);
 	if (idx >= val && idx != ARMV8_PMU_CYCLE_IDX) {
 		kvm_inject_undefined(vcpu);
@@ -1037,6 +1042,22 @@ static bool access_pmu_evcntr(struct kvm_vcpu *vcpu,
 	return true;
 }
 
+static void writethrough_pmevtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
+				   u64 reg, u64 idx)
+{
+	u64 evmask = kvm_pmu_evtyper_mask(vcpu->kvm);
+	u64 val = p->regval & evmask;
+
+	__vcpu_sys_reg(vcpu, reg) = val;
+
+	if (idx == ARMV8_PMU_CYCLE_IDX)
+		write_pmccfiltr(val);
+	else if (idx == ARMV8_PMU_INSTR_IDX)
+		write_pmicfiltr(val);
+	else
+		write_pmevtypern(idx, val);
+}
+
 static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			       const struct sys_reg_desc *r)
 {
@@ -1063,7 +1084,9 @@ static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	if (!pmu_counter_idx_valid(vcpu, idx))
 		return false;
 
-	if (p->is_write) {
+	if (kvm_vcpu_pmu_is_partitioned(vcpu) && p->is_write) {
+		writethrough_pmevtyper(vcpu, p, reg, idx);
+	} else if (p->is_write) {
 		kvm_pmu_set_counter_event_type(vcpu, p->regval, idx);
 		kvm_vcpu_pmu_restore_guest(vcpu);
 	} else {
-- 
2.49.0.1204.g71687c7c1d-goog

