Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C703289806
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 22:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752533990; cv=none; b=eIvcx/xROltmrZxqlSOW/JvDirrAp2BsKBvFOyrTfO3kxn4l1DViBXdx51uG7Zrsb8yj0Ny7JMtK/bf6dBd1Uher4Z4D/BcTsaJS1CDzlkcdeq2Ntw70bklAv8k6Lbet+ht5Cey+GFpLtSEIe0mdByy46eGcYGE1C6DltdR3QQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752533990; c=relaxed/simple;
	bh=mWJcjSVKE8Hfx300gV16GcG/h8AihYm2XSLxVa+DzAI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sudUEF5acxdypQvOMYYokOsDfaQ4dF0lA7BOnTwH3sRtMCQR3kkspXCHiKENdIx7YzGIw9gGnYcyqkYsEp3cxg+mwxLvXWpPEkmTktKCvmHQ88GYXOfBZqG2mbCmS3JnuIvF4Vna8/mXHf2YCmVaxcrEFFDCGrhnjeRqp+PK444=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pjH4MbZ0; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pjH4MbZ0"
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-41b3d208dbeso486378b6e.2
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 15:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752533986; x=1753138786; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ryTFSv4SUuWjEo9ITdyyZg4InYYKN2XpVG4LgfvjWks=;
        b=pjH4MbZ0x9G6pHcOh9BvWzJuRti5JoL4VbVQ8m90VL+t++U2CaefiZa7JzJQajMx9D
         9tnI44qGuwLFskwN+M9GnThbO1JFiPJfj4WFlGTEz3XwO7troJEonPSqECvEkkpTyOkR
         VXtn88JHnj0LoiSfOsonWlng/A8pJxnkeBIIouH7hmG87cTOrQE/Z9HIlwVZEePp1KsG
         jPFiCM95nK7fEHf8ZeFUS27PM0utf3B3HQdvt39bob25lpxVIJF90KDM7cHBCa2TAvEF
         HTxpE7NZVOfbvWNugLqFA1Snlee7Yel5PAiPFmnIUPENEBIKTaWgZGxVOtPEjkSZtIjT
         yVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752533986; x=1753138786;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ryTFSv4SUuWjEo9ITdyyZg4InYYKN2XpVG4LgfvjWks=;
        b=bVEtqtai5yKzlkLenmH3OFZrW1MoelDWNMq5aj3wdC30XDRupV8yoSJub3uJ+dlKDm
         hdel5jzsmHCks3SaWHM61KhU4r4dlVd2WpWQVSSX6y1IiJmGyH57lSzwqag5YavDqJWx
         +lJ4XhvowHYTqjY+mvV4LZQ7jJG0Ot1tw8O2R3aL3v3wfNa6y1yBFcOwwS/y5GsiURfH
         1NkOlqlRC67WhY5W1pZZK8A6Q8jpBJuGCgOo3vkskIkc7IjsFiULp4vGb1aMxHx+rubh
         aUfJUejyol8X7Hg+XpjQ+UzGklRm1z/2EWBW9DC4qZpVcXaoFfSzJG9Zjs26/DCpANNN
         sN5w==
X-Forwarded-Encrypted: i=1; AJvYcCWBb4rwCSUP+ofCqpqsAlDNCoo1PAacFlHK4oL+6didLvo5qbz111H0gfl+e7SkQ8WHAl98CUc6zzoekHopZtz6@vger.kernel.org
X-Gm-Message-State: AOJu0YwVAZNhBJZuFio/5yRwmM0ZxHPLwxQ3DCCb81MEjQWODoejFRaL
	WyWbPPln5SVq57Gg7u/C6VPZMtMPLmoiMgbjF4+V8URVzS+MzI9huQR2ay7KV2Sx8FJp21LVAq4
	Fez2YHUEJ9xeC7nzFmQhO1PWqUw==
X-Google-Smtp-Source: AGHT+IH/cZ/kysTLecvFDqp/vKXsI7g6OHRQd1TfsMdUj361wwQB7SXIxVBhNRKY/b1QS1sS6spRQdB4N1nadhlFuA==
X-Received: from oibix7.prod.google.com ([2002:a05:6808:5187:b0:40a:fcea:87ac])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1a0e:b0:40b:4208:7fc0 with SMTP id 5614622812f47-4150faa232dmr10429766b6e.30.1752533985740;
 Mon, 14 Jul 2025 15:59:45 -0700 (PDT)
Date: Mon, 14 Jul 2025 22:59:09 +0000
In-Reply-To: <20250714225917.1396543-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714225917.1396543-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714225917.1396543-16-coltonlewis@google.com>
Subject: [PATCH v4 15/23] KVM: arm64: Account for partitioning in PMCR_EL0 access
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

For some reason unknown to me, KVM allows writes to PMCR_EL0.N even
though the architecture specifies that field as RO. Make sure these
accesses conform to additional constraints imposed when the PMU is
partitioned.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/pmu.c      | 2 +-
 arch/arm64/kvm/sys_regs.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index 30244eb7bc9b..1e5f46c1346c 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -883,7 +883,7 @@ u64 kvm_pmu_accessible_counter_mask(struct kvm_vcpu *vcpu)
 u64 kvm_vcpu_read_pmcr(struct kvm_vcpu *vcpu)
 {
 	u64 pmcr = __vcpu_sys_reg(vcpu, PMCR_EL0);
-	u64 n = vcpu->kvm->arch.nr_pmu_counters;
+	u64 n = kvm_pmu_guest_num_counters(vcpu);
 
 	if (vcpu_has_nv(vcpu) && !vcpu_is_el2(vcpu))
 		n = FIELD_GET(MDCR_EL2_HPMN, __vcpu_sys_reg(vcpu, MDCR_EL2));
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index ad9c406734a5..e3d4ca167881 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1247,7 +1247,9 @@ static int set_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 	 */
 	if (!kvm_vm_has_ran_once(kvm) &&
 	    !vcpu_has_nv(vcpu)	      &&
-	    new_n <= kvm_arm_pmu_get_max_counters(kvm))
+	    new_n <= kvm_arm_pmu_get_max_counters(kvm) &&
+	    (!kvm_vcpu_pmu_is_partitioned(vcpu) ||
+	     new_n <= kvm_pmu_hpmn(vcpu)))
 		kvm->arch.nr_pmu_counters = new_n;
 
 	mutex_unlock(&kvm->arch.config_lock);
-- 
2.50.0.727.gbf7dc18ff4-goog

