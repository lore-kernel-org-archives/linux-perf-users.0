Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DEF30B519
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Dec 2025 20:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765313565; cv=none; b=EonED6lfHHkHCuzKLd2gngInF0xpmDfp4UV1QXmMs2aznQsZjWOYXmcFI8jE45nMTAI/fNOyl3je5DA4ajz9XldQXZWOBkSC4vL1eOcfAtEuVDz+tYeOh3qs7ogB19GugO05036bqo/KYkd/4GJHc0y3ia/jCCHK5661vbADWuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765313565; c=relaxed/simple;
	bh=gK8PYV0Ut8umvNmJJee7/9an5YvBL6+gILLBE0W0pjA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VZukx/Fp45R/Lj/eUh+oqjqSO/I/OuhVIH/+95w/LA/Gla8TCUuoINO5nN/iAMkTYNUBBCwSinoeqDKv1VmgH5wbHF1dpb6DjqRkKnuSFRD2ZrwvxOaV02fFaK9YjLRJCF6ZFtgO1ErkiKVScLHXaDTxTM87bIdyCjXKP0mtqRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h9C/SU9i; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h9C/SU9i"
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-6576fd62dffso7563444eaf.2
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Dec 2025 12:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765313558; x=1765918358; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eILdFka/rsHJNMit/75Sq+eu11TjmQop/YtCpvpq3fA=;
        b=h9C/SU9i2BXm+Lt0xk3FLwcDlrhZL2w2HyL8nkPrMRnLsTD8Pchpd6M+9UjatznUW1
         58UsYkrlw+KcchRgEvezNdHMPAMblwq9n9sBCx4XrvXHYj0/TARXIHgk63VCbFaSr77f
         Q3N/Ze0T0j1C1BF+2cPh67ZHahfH/Zr4xUkrXGaSLgoGK6WRBSgLB/51GuzoACm0XMaJ
         RlF+58zx7vjCqqQKPcRokis5+3Gix69D32ufx6BkteQWxgx2uoxLpvzZqtrKt/Kq9MLH
         yZAhvikIyjq4V9ULTCm71XL//6zqS94Q9rOSuLeQACQBHwSDFLQSi2z0WLPaQ6WUfAMc
         QR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765313558; x=1765918358;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eILdFka/rsHJNMit/75Sq+eu11TjmQop/YtCpvpq3fA=;
        b=sdBKP071layWagZ+sfDGD71lZX7XdTGd/a4xR7cZFb07j+uhF2+63Ci1iBrJ0my+rO
         ZBCnZ+JrD0rgaasj+hmabwt8q4GMPx6MfgMZL7Rd8WdJnxsJlMYP7vfyokoGg7T0zmst
         E8vgB9vA7mTnHVW/o/R84yTQ7PGj+gOYjw0StefO9UY/4ljEa6j+akSPf7VKS5QlM11/
         FoypHHiP35yanCmEPPr6uR6Jm4vkO3fNtDF6PzonMi3QhXMWttg9ZOmmlg37uyrP9fJy
         VKpANe+PCPbVlgAu5d4dw+aDSCKcoUm4FdU8T1kYFTKOKRPYipZfvvm3Aj+Krqfu4/9G
         i7EA==
X-Forwarded-Encrypted: i=1; AJvYcCWWAHpHYttRSwdhmmqT2fzoe/z5Ji0Fnlus1DqAlo8V+2YIoFVzceiDrFGUJmUO0/wzUq9FIXqER1l9fs7XsOr7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+0X8Lscw16KNQn/iJhFGwRuaVJzEeTRhLS0WuHz8TO6430VFb
	Dx2qMxDwWDHNNBapmSx0KqAhnPPB8cBI3ZlmlpjTeEAHDpMwPY+Y87T8xunVz4yhS1Vlb+4vRed
	dEyVuLem8dsD9kJVbiWaba6WEVQ==
X-Google-Smtp-Source: AGHT+IGFO7LxHdl3SUALrs39mwNrx9NW2pYEpCVi8R5YZ4pkCq168hpaasS4MHYzaxE05YVUGX0GL3A0G5bIBNL23w==
X-Received: from ilbcp5.prod.google.com ([2002:a05:6e02:3985:b0:433:e44:c729])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:4d08:b0:659:9a49:8f57 with SMTP id 006d021491bc7-65b2abec3e1mr136653eaf.28.1765313558233;
 Tue, 09 Dec 2025 12:52:38 -0800 (PST)
Date: Tue,  9 Dec 2025 20:51:09 +0000
In-Reply-To: <20251209205121.1871534-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251209205121.1871534-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
Message-ID: <20251209205121.1871534-13-coltonlewis@google.com>
Subject: [PATCH v5 12/24] KVM: arm64: Use physical PMSELR for PMXEVTYPER if partitioned
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Because PMXEVTYPER is trapped and PMSELR is not, it is not appropriate
to use the virtual PMSELR register when it could be outdated and lead
to an invalid write. Use the physical register when partitioned.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/include/asm/arm_pmuv3.h | 7 ++++++-
 arch/arm64/kvm/sys_regs.c          | 9 +++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
index 27c4d6d47da31..60600f04b5902 100644
--- a/arch/arm64/include/asm/arm_pmuv3.h
+++ b/arch/arm64/include/asm/arm_pmuv3.h
@@ -70,11 +70,16 @@ static inline u64 read_pmcr(void)
 	return read_sysreg(pmcr_el0);
 }
 
-static inline void write_pmselr(u32 val)
+static inline void write_pmselr(u64 val)
 {
 	write_sysreg(val, pmselr_el0);
 }
 
+static inline u64 read_pmselr(void)
+{
+	return read_sysreg(pmselr_el0);
+}
+
 static inline void write_pmccntr(u64 val)
 {
 	write_sysreg(val, pmccntr_el0);
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 0c9596325519b..2e6d907fa8af2 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1199,14 +1199,19 @@ static bool writethrough_pmevtyper(struct kvm_vcpu *vcpu, struct sys_reg_params
 static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			       const struct sys_reg_desc *r)
 {
-	u64 idx, reg;
+	u64 idx, reg, pmselr;
 
 	if (pmu_access_el0_disabled(vcpu))
 		return false;
 
 	if (r->CRn == 9 && r->CRm == 13 && r->Op2 == 1) {
 		/* PMXEVTYPER_EL0 */
-		idx = SYS_FIELD_GET(PMSELR_EL0, SEL, __vcpu_sys_reg(vcpu, PMSELR_EL0));
+		if (kvm_vcpu_pmu_is_partitioned(vcpu))
+			pmselr = read_pmselr();
+		else
+			pmselr = __vcpu_sys_reg(vcpu, PMSELR_EL0);
+
+		idx = SYS_FIELD_GET(PMSELR_EL0, SEL, pmselr);
 		reg = PMEVTYPER0_EL0 + idx;
 	} else if (r->CRn == 14 && (r->CRm & 12) == 12) {
 		idx = ((r->CRm & 3) << 3) | (r->Op2 & 7);
-- 
2.52.0.239.gd5f0c6e74e-goog

