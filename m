Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B866B30B538
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Dec 2025 20:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765313568; cv=none; b=psYkY5eOxS4o3csRCd/SEZ7drqapeaQ7QG1cdNyGDaVOHhRJ+5ufBhspg8dNLasxSzDjjYmS94hkJD5n/2rRmf0u427j1opOq8Ejbu3emJ1YYRn/5wZdlalpsVZh3hcSu/e1PP9noS6mBChIA2hK496aH/Xw7NA2gYjvPoOqSHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765313568; c=relaxed/simple;
	bh=SQ6Z1MwvA88uzbzI+XtO/m3rZVQWhJdhjpiP6b/54yU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZtygIHa9XjpZPSYRzw012t8QFIsTdq2fsvCj48AW2q70LlFcM3Ne2L2ha4NMsvt1gD03Un//3TTAyclTMZii1M5Ie4PN1eQRngORs2dRRJqfXyQTfSt6c2rquxdck5p8DVE1ox7033kfg5iSR1gBIo9Z8yg2Ze16gR+j/9HXZBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NjO85hTh; arc=none smtp.client-ip=209.85.210.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NjO85hTh"
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-7c70930bdf4so11578691a34.2
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Dec 2025 12:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765313559; x=1765918359; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AJ1EthCH6ONdnoakqWvxYQ6ZZxvXCgKuA673W4BNIkM=;
        b=NjO85hThyzj4e4bH2Q8L543JCE8LzD6NXroOyfbotIbCzHulF9cs6kDlQFj+cvomJI
         CaCR1Nep2aoyrGzODkBnuMn/BOhor3Qx+F3c0TskjOtdPO8bcQmL5EGU0vcU0aobz2ur
         vGOpwI5rw43T4NMEbZOe254HA1sbZV8W6iPtscoq901pKz5vW4x6XqmfbQkVLWqm0S2M
         iiAay1X35PcJji9EcLXbvB+qqwI5ni8OQi7CBoWf84r7QU5yW0C0+oHrynvqyj0HbveK
         +M7AJyIXCU7cF67gXKso6tx8UyM5eqRuTe5g8CpkgSR1IyzC4Q7/OVIv2mv/CZ/VScSs
         5b2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765313559; x=1765918359;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AJ1EthCH6ONdnoakqWvxYQ6ZZxvXCgKuA673W4BNIkM=;
        b=ivZ8pNqtkh0ZXMVmrtKq9GzOTRWQoM7tQV9o4f0vLw2NtDrci0O8i77NNNty2f7Ca3
         xuBCptNLqKAwCdwDPmqs7rl90QG+P7R8hMMIFctzjA7VjMYKO429OipprL4JIN5LT8+K
         MkPtygC7MsWJLP0l0LhuLpWs012pc9I+N/6J0q+E3SMnqDGpIY9DqPS5T0pjddrxMvV9
         yQV+2pzW1TIWrdP1yb8mR6zFpjQSAK6wYMJTOgHhldzEmRB/fzUkWvglE101XdqGXBN6
         PthZzs5TgdrswFna8t51lMKGFrjr9d2ceZFh6xOIIS2PyxuCIbm/qwqbt6cdS9/b11cC
         EjdA==
X-Forwarded-Encrypted: i=1; AJvYcCX6gNa/FRrakkV5WBCLuVZdeYpeH50oO7bLHIEqP/1I/XR626eA6CpKbutuOLIf9P3Ut13r7cn2ib4UVwCuRZ+1@vger.kernel.org
X-Gm-Message-State: AOJu0YyFJtpvYNDA9cKt/qid5NhCwejeTgTj+fZ3zlQGEBBh5PW/GhQn
	1hEIGuyy98NOHR/ilMo/+35/jnPf0pyPJKGG+gbsaGsGYHF7i9XqV2s01q62e4fVZevuc1FY1Ax
	44F7y2KJbKh4zKWK+hdyRluq2/w==
X-Google-Smtp-Source: AGHT+IEXFAGDtIzcAMUsWr76V/QsGbzsYAGUdLx+/ZdxOcslRVX0AGiIPoGFGxMRz56nzOeGb3yai/VbNoKlqj0WOg==
X-Received: from jabgz26.prod.google.com ([2002:a05:6638:6b1a:b0:5b7:27fd:4267])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a4a:ee05:0:b0:657:717a:8c8 with SMTP id 006d021491bc7-65b2abef8e5mr121600eaf.3.1765313559184;
 Tue, 09 Dec 2025 12:52:39 -0800 (PST)
Date: Tue,  9 Dec 2025 20:51:10 +0000
In-Reply-To: <20251209205121.1871534-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251209205121.1871534-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
Message-ID: <20251209205121.1871534-14-coltonlewis@google.com>
Subject: [PATCH v5 13/24] KVM: arm64: Writethrough trapped PMOVS register
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

Because PMOVS remains trapped, it needs to be written through when
partitioned to affect PMU hardware when expected.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/include/asm/arm_pmuv3.h | 10 ++++++++++
 arch/arm64/kvm/sys_regs.c          | 17 ++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
index 60600f04b5902..3e25c0313263c 100644
--- a/arch/arm64/include/asm/arm_pmuv3.h
+++ b/arch/arm64/include/asm/arm_pmuv3.h
@@ -140,6 +140,16 @@ static inline u64 read_pmicfiltr(void)
 	return read_sysreg_s(SYS_PMICFILTR_EL0);
 }
 
+static inline void write_pmovsset(u64 val)
+{
+	write_sysreg(val, pmovsset_el0);
+}
+
+static inline u64 read_pmovsset(void)
+{
+	return read_sysreg(pmovsset_el0);
+}
+
 static inline void write_pmovsclr(u64 val)
 {
 	write_sysreg(val, pmovsclr_el0);
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 2e6d907fa8af2..bee892db9ca8b 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1307,6 +1307,19 @@ static bool access_pminten(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	return true;
 }
 
+static void writethrough_pmovs(struct kvm_vcpu *vcpu, struct sys_reg_params *p, bool set)
+{
+	u64 mask = kvm_pmu_accessible_counter_mask(vcpu);
+
+	if (set) {
+		__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, |=, (p->regval & mask));
+		write_pmovsset(p->regval & mask);
+	} else {
+		__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, &=, ~(p->regval & mask));
+		write_pmovsclr(p->regval & mask);
+	}
+}
+
 static bool access_pmovs(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			 const struct sys_reg_desc *r)
 {
@@ -1315,7 +1328,9 @@ static bool access_pmovs(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	if (pmu_access_el0_disabled(vcpu))
 		return false;
 
-	if (p->is_write) {
+	if (kvm_vcpu_pmu_is_partitioned(vcpu) && p->is_write) {
+		writethrough_pmovs(vcpu, p, r->CRm & 0x2);
+	} else if (p->is_write) {
 		if (r->CRm & 0x2)
 			/* accessing PMOVSSET_EL0 */
 			__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, |=, (p->regval & mask));
-- 
2.52.0.239.gd5f0c6e74e-goog

