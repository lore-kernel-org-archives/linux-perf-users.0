Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE3D3D6491
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781292577; cv=none; b=l457zlMCd1aIDi9RrAKQUjLE4tCnRayVF8pJPGf7UbWKplBHVu7y7fj9FWn4Rg4YFeSi/9S2Ec0Egt9397Njzx0gxQ0ROuse+EpImhArvbS1JuZUOsToeqKQij00bBsrw4VWtJvkekVFT7VsW754O5QbRLe27VWXec4//p+BrL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781292577; c=relaxed/simple;
	bh=PiE+dt9fYAPOr4a0xodnENwZbbQVLSZKLUreY8s1sdM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m/RvBMZ2qjYIWsr4LO/dF/q1dxIpogJFt7WzZb+SLt3jhMBB0MSGOB60mrUdB1PtsOe9EJSv5vouQGDTX94oUi0HGiJEDAFeBhoMVGTx47H5tqEjRq8ndETli3n9/dJe7VolqLWvAZH2n7qUSikgzOaFxVKwGergzNoOx0fRBHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SW5dC8lq; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SW5dC8lq"
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-48687e7f161so2129514b6e.2
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 12:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781292571; x=1781897371; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/bPxt/n97qTMkfypzesmceZlZb8m5faMbDtZZOrJQN8=;
        b=SW5dC8lqz/UBlm3Lu7X1m0z/71yQLgEtRYPKMZK1cpEuwZZsSFK4EQIBlpa6Wqsm3l
         buBjy16sghBOemeRpFhO3Re4p7rzssCdeBIRUinGWsHbzXgCJdPKsRBTVs1UnXQbNkRB
         fRzHBzjtH5JffmDvh8cX1POmrgryinwUfSMs0LsiNBL1XCq/XOd33srMvnjZW9z6LYt6
         iyPLmFEIyOOwLBppPPcKI6cPEBD499FrgrkGOY9dyfqyUBMC8KFI6Wk+XM4OeNaGCuzD
         1+alWiegqgXIEsrE62ZsnQ/YB3c0ByPZ6Ck5Ax9wj1rJxOoEgPR9+BExzGYZoLG+a/4R
         s+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781292571; x=1781897371;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/bPxt/n97qTMkfypzesmceZlZb8m5faMbDtZZOrJQN8=;
        b=mZu5oGg457yBCm0+bHSvC48Mx8TeTXpVmkRQzdxaiRk4yG3b36nmx+3rCpJyua+jl+
         sLovdSX3xwBTvbOQfruZUZ4wSWzvA7yRRunx35xvWVBGM9PfEc6jAS5mNjpqRmy0pSYT
         43ZG+30sD+SxRtfuhRa/fYRw9hyTs36Ljb1t4IWOJdb3Z8wLoxLN5dZHg09jJI5Hmlgk
         JOu4TITQNWhA/oCUAwRSD8udpQ9UbVXYTdZ/PzgziGNHID4rPX/P4C8oV5L4pn3flxc3
         OX0ep5I6786La4Tzry/RPfvlD/YTt6EyaT1mdEQkPoaFgjE5FBOdBBdkBSFPR6qkL4f2
         +oOQ==
X-Forwarded-Encrypted: i=1; AFNElJ856fh0kZDgqOKO3S8rCWd5l238iM+XJJsDU74V++JMsdWa3F01XH1+OSMvadiejvRzJ+qjuh0bGpX1Txi0jr/p@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8BOyY2EkKN6GF+K4cwEQV5ODOd3ldXCwnNmRmqwaZkZg0nv2g
	OQ1y3+sWHRh+3+UMWVqNXXT4NnTbB+Ubd28zr6Zhc4ydMIogcUul4O+aMDjvzgO8ftNAnDhXGFc
	MWuOCdZSJUOt/RGBx8ItLMB+1Eg==
X-Received: from ilbdx1-n1.prod.google.com ([2002:a05:6e02:4201:10b0:4fa:1e84:4047])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1308:b0:482:4dbd:4fde with SMTP id 5614622812f47-48741a3b47dmr672091b6e.19.1781292571289;
 Fri, 12 Jun 2026 12:29:31 -0700 (PDT)
Date: Fri, 12 Jun 2026 19:29:09 +0000
In-Reply-To: <20260612192909.1153907-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612192909.1153907-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612192909.1153907-22-coltonlewis@google.com>
Subject: [PATCH 21/21] KVM: arm64: selftests: Relax testing for exceptions
 when partitioned
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

Because the Partitioned PMU must lean heavily on underlying hardware
support, it can't guarantee an exception occurs when accessing an
invalid pmc index.

The ARM manual specifies that accessing PMEVCNTR<n>_EL0 where n is
greater than the number of counters on the system is constrained
unpredictable when FEAT_FGT is not implemented, and it is desired the
Partitioned PMU still work without FEAT_FGT.

Though KVM could enforce exceptions here since all PMU accesses
without FEAT_FGT are trapped, that creates further difficulties. For
one example, the manual also says that after writing a value to
PMSELR_EL0 greater than the number of counters on a system, direct
reads will return an unknown value, meaning KVM could not rely on the
hardware register to hold the correct value.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 .../selftests/kvm/arm64/vpmu_counter_access.c | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c b/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
index 9be6034335283..e8c3856df77b7 100644
--- a/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
+++ b/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
@@ -38,10 +38,14 @@ const char *pmu_impl_str[] = {
 struct vpmu_vm {
 	struct kvm_vm *vm;
 	struct kvm_vcpu *vcpu;
+};
+
+struct guest_context {
 	bool pmu_partitioned;
 };
 
 static struct vpmu_vm vpmu_vm;
+static struct guest_context guest_context;
 
 struct pmreg_sets {
 	u64 set_reg_id;
@@ -342,11 +346,16 @@ static void test_access_invalid_pmc_regs(struct pmc_accessor *acc, int pmc_idx)
 	/*
 	 * Reading/writing the event count/type registers should cause
 	 * an UNDEFINED exception.
+	 *
+	 * If the pmu is partitioned, we can't guarantee it because
+	 * hardware doesn't.
 	 */
-	TEST_EXCEPTION(ESR_ELx_EC_UNKNOWN, acc->read_cntr(pmc_idx));
-	TEST_EXCEPTION(ESR_ELx_EC_UNKNOWN, acc->write_cntr(pmc_idx, 0));
-	TEST_EXCEPTION(ESR_ELx_EC_UNKNOWN, acc->read_typer(pmc_idx));
-	TEST_EXCEPTION(ESR_ELx_EC_UNKNOWN, acc->write_typer(pmc_idx, 0));
+	if (!guest_context.pmu_partitioned) {
+		TEST_EXCEPTION(ESR_ELx_EC_UNKNOWN, acc->read_cntr(pmc_idx));
+		TEST_EXCEPTION(ESR_ELx_EC_UNKNOWN, acc->write_cntr(pmc_idx, 0));
+		TEST_EXCEPTION(ESR_ELx_EC_UNKNOWN, acc->read_typer(pmc_idx));
+		TEST_EXCEPTION(ESR_ELx_EC_UNKNOWN, acc->write_typer(pmc_idx, 0));
+	}
 	/*
 	 * The bit corresponding to the (unimplemented) counter in
 	 * {PMCNTEN,PMINTEN,PMOVS}{SET,CLR} registers should be RAZ.
@@ -459,7 +468,7 @@ static void create_vpmu_vm(void *guest_code, enum pmu_impl impl)
 		vpmu_vm.vcpu, KVM_ARM_VCPU_PMU_V3_CTRL, KVM_ARM_VCPU_PMU_V3_ENABLE_PARTITION);
 	if (!ret) {
 		vcpu_ioctl(vpmu_vm.vcpu, KVM_SET_DEVICE_ATTR, &part_attr);
-		vpmu_vm.pmu_partitioned = partition;
+		guest_context.pmu_partitioned = partition;
 		pr_debug("Set PMU partitioning: %d\n", partition);
 	}
 
@@ -511,6 +520,7 @@ static void test_create_vpmu_vm_with_nr_counters(
 		TEST_ASSERT(!ret, KVM_IOCTL_ERROR(KVM_SET_DEVICE_ATTR, ret));
 
 	vcpu_device_attr_set(vcpu, KVM_ARM_VCPU_PMU_V3_CTRL, KVM_ARM_VCPU_PMU_V3_INIT, NULL);
+	sync_global_to_guest(vpmu_vm.vm, guest_context);
 }
 
 /*
-- 
2.54.0.1136.gdb2ca164c4-goog

