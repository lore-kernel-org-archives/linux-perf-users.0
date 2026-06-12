Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5563B8BD5
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 19:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781292567; cv=none; b=uvsjSti/GnZWmTPxPM8y7zLYY/ytWFFp7xPc3NfdTQnNqxYPrjYu5HjmmeETgbHLkvRG1mj0XkN7QRnn/OQkKVa9VF1D/W4IAU8Y5cWjVRFuxPlH0Yc4g66qHh0+HPBKp7z0JnMCBtugIWEtnXJSc2dsyeNgvSKTMG2iaAllgL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781292567; c=relaxed/simple;
	bh=ZG9ZKKsG5def4qAkO71pmX+aMwBP6QL7ujSsyD5d3oQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sCGp2MmNjsez8KkJ4O8u3XCzjrmLy1QZ8WZ4COpAgntb5P+PBfby86SSuS91vZHGNj+TLHXYoWOOpY3MQqI2rEXP2Bpj+AuW0QVzcMVVWVDi/yuuVsMEvg9zgQgAYmNyQ33KaHkcXYKsuclXiR06y8ItJ661qfv2XzKUZg4GCo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SyDtXmjB; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SyDtXmjB"
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-486055c1c6fso1104001b6e.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 12:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781292560; x=1781897360; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zUfvJDWatpVt+iiRM4HzP8H2jLIkMlFqueFXiDB4Pis=;
        b=SyDtXmjB9DRRaNSRzpLU1B/JEaDKfRT9w2ln2DX2NfVIRixXLQ4IYrEfGN52Iq9lQK
         X6u0LkCEGrjDl2jC6ksr4/QmJrlekkW6h5py/Qq7HOE+F8fHJLYglbK6DDmOkggCTuPD
         hPYI7re+lGjDA4BxqYKk331B4z+A0PaBIOk/+y/spK/LASM/vVdYWMSTdddoLgR2b2Dg
         ke/JvBcx2fFBwn/E4rY3wuM3YE86n4+w5c6pcOl+g7ubHwbCRLwCPCXsquAgjqRHOh2L
         rJCZ+XCkRGIAeFu9MMCZeI022C2q770TOHghaXAjPirpqqBXuee3ipgmSd0MAy4/K9Z6
         qEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781292560; x=1781897360;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zUfvJDWatpVt+iiRM4HzP8H2jLIkMlFqueFXiDB4Pis=;
        b=Ke3bes1waj33M7Yq38G+tpJrsrtBZS5IwRMwTkipsWBMYcKr1rA+ZoE8CnqLPCHxyx
         2u/5TfrXQCuS5e0beUBXgeEVKddZ0Ef4VfO9xHfHutGRpbG3ZO+LcsYN+OTnY/uIjld2
         qBuHn/upOCMSca+/9No1btU87oFNFEoSSXPixr6P+OTsxvCsrgvmTvl+dJbT6atoyV2u
         ipeAsDrTMuY69QJP4bmppqMuuT8b4Hh5igmH/I6N9EPFTBRZ8nhk09Vu4jjcEUoRnDN7
         wu8VZNx5xOflsOLVGmLkiGczmlWBvvS9KkHMR03MwUeEABgb5GerCV2iow+BLqEcEIal
         XyQw==
X-Forwarded-Encrypted: i=1; AFNElJ+Qgn6TiLhMVzIpH3n/mNQXn74x83zCd6K/CKrfXzYeiwNVVZR0IBoA30zmG95zmhJh3o+G36njj7ZztIt9bmrI@vger.kernel.org
X-Gm-Message-State: AOJu0YyNNmqb1OikBsVhLVe+6kbh0mvhnquWON4EhWTsOUHEwSPJx9Nl
	q7RVbWG+MzD5jX+paKxcAlQu5dxkER9DmFvdQ4xgtCzWEXe/uAeGrp3mluP+5FDmZsZszIKw+LO
	n04d/FbdEgPL64x8+P2mQvW+6bg==
X-Received: from jabjq11.prod.google.com ([2002:a05:6638:8d8b:b0:5e2:7e1d:1f79])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1790:b0:47b:bd7b:10e5 with SMTP id 5614622812f47-4872f35387fmr2525333b6e.3.1781292559384;
 Fri, 12 Jun 2026 12:29:19 -0700 (PDT)
Date: Fri, 12 Jun 2026 19:28:58 +0000
In-Reply-To: <20260612192909.1153907-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612192909.1153907-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612192909.1153907-11-coltonlewis@google.com>
Subject: [PATCH 10/21] KVM: arm64: Set up MDCR_EL2 to handle a Partitioned PMU
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Alexandru Elisei <alexandru.elisei@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Mingwei Zhang <mizhang@google.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Shuah Khan <shuah@kernel.org>, Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, 
	James Clark <james.clark@linaro.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Set up MDCR_EL2 to handle a Partitioned PMU. If partitioned, set the
HPME, HPMD, and HCCD bits. If we have the ability to use Fine Grain
Traps (FEAT_FGT) also, unset the TPM and TPMCR bits that trap all PMU
accesses and set HPMN to the correct number of guest counters so
hardware enforces the right values.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/debug.c | 27 ++++++++++++++++++++++++---
 arch/arm64/kvm/pmu.c   |  7 +++++++
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index f4d7b12045e8f..c84321277d893 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -43,14 +43,35 @@ static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
 	 * This also clears MDCR_EL2_E2PB_MASK and MDCR_EL2_E2TB_MASK
 	 * to disable guest access to the profiling and trace buffers
 	 */
-	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN,
-					 *host_data_ptr(nr_event_counters));
+
+	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN, *host_data_ptr(nr_event_counters));
 	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TPM |
 				MDCR_EL2_TPMS |
 				MDCR_EL2_TTRF |
 				MDCR_EL2_TPMCR |
 				MDCR_EL2_TDRA |
-				MDCR_EL2_TDOSA);
+				MDCR_EL2_TDOSA |
+				MDCR_EL2_HPME);
+
+	if (kvm_pmu_is_partitioned(vcpu->kvm)) {
+		u8 nr_guest_cntr = vcpu->kvm->arch.nr_pmu_counters;
+
+		vcpu->arch.mdcr_el2 |= (MDCR_EL2_HPMD | MDCR_EL2_HCCD);
+
+		/*
+		 * Take out the coarse grain traps if we are using
+		 * fine grain traps and enforce counter access with
+		 * HPMN.
+		 */
+		if (!vcpu_on_unsupported_cpu(vcpu) &&
+		    cpus_have_final_cap(ARM64_HAS_FGT) &&
+		    (cpus_have_final_cap(ARM64_HAS_HPMN0) || nr_guest_cntr > 0)) {
+			vcpu->arch.mdcr_el2 &= ~(MDCR_EL2_TPM | MDCR_EL2_TPMCR | MDCR_EL2_HPMN);
+			vcpu->arch.mdcr_el2 |= FIELD_PREP(MDCR_EL2_HPMN, nr_guest_cntr);
+		}
+
+
+	}
 
 	/* Is the VM being debugged by userspace? */
 	if (vcpu->guest_debug)
diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index 9ad3520417413..55cda8021400a 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -552,6 +552,13 @@ u8 kvm_arm_pmu_get_max_counters(struct kvm *kvm)
 	if (cpus_have_final_cap(ARM64_WORKAROUND_PMUV3_IMPDEF_TRAPS))
 		return 1;
 
+	/*
+	 * If partitioned then we are limited by the max counters in
+	 * the guest partition.
+	 */
+	if (pmu_is_partitioned(arm_pmu))
+		return arm_pmu->max_guest_counters;
+
 	/*
 	 * The arm_pmu->cntr_mask considers the fixed counter(s) as well.
 	 * Ignore those and return only the general-purpose counters.
-- 
2.54.0.1136.gdb2ca164c4-goog

