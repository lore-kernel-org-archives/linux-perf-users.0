Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2068E23498E
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Jun 2025 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748892561; cv=none; b=mNLI0KrxqvSZkolvugMpLVBlLeFA5MiyFvE1GIOEbPVnqtSDagnEXp+A/fWQKia6wrKABdqRnk8XfkJrJIpx6ZLpuNRQmCMAqojWmWKujw/ZLj/p25nqyF5Hk5Zxr0M/a+jRq7E5M2wVTM1BMaT9DeIpgRkPbFn2A3c152xm4pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748892561; c=relaxed/simple;
	bh=rVIheqH0+/PJT/lcs6JePPwGwkoQWcSv5wqNXPtE6ls=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CIPMVCF6+ZVfEVlKbOX5GrNzG1a5C1RZiOMvoBrSpm8NJaEyAoxbUMzgcYnh7cZgLU/iwrvan6KqanSH1akLR6+44BUuEzd4/HUJA3Yjdkk8BtDu+Rjq2VrGGxQUzovU8+SK8aO5+iNWcUSLFe8EJwxvTpeh5X8/M2N+zF2shwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iVF2U7KN; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iVF2U7KN"
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-60be0456405so1476509eaf.2
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Jun 2025 12:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748892555; x=1749497355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=26CTSmqDyxITTH+s3Gb/2J4B5NVYM/QmbIppKLMrdxo=;
        b=iVF2U7KNerA2yKX30lgFz560RP6ahSkVuDbEImHI8MLTQoKAfuMMuNkwLrPVfzp1G0
         G8fteJN4JgmbdVyEYbWDqD2Qb6JCYDbrVKcQ4u+y700djaB94a2GDRDPgNrLuzojdTdK
         WqCYuqlBdJNiYLwSbi58SJLdlpJHp4UVyHCkNXqkubUEYoCiDi0F7BVI5mPNIKHEFZN7
         ozO5+CQ3kLvaMNFnj7i8ShAKOo676CAFm8/E5REfbPRnHLPkQ5VdFvv78mxXMUOnK+JE
         zquKYMlg+/ahB/l4hqjQWxOF43zSAUUVM+WekZkUTTP0rVEugEa7ujZO2Gqs36DAsujF
         WqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748892555; x=1749497355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26CTSmqDyxITTH+s3Gb/2J4B5NVYM/QmbIppKLMrdxo=;
        b=ZJj2wkFYdZ5OxV/SfCZCpa4byRDFWMuTjiY7m7EQVRUe96OBrkrdvYc/w+b1DMYVUU
         7byRdkSg+SGnnB0OF63KR62EO/csmO6zEfoY7ZIk563nTnDyxUQlxOVBjr+CQGBn4aqE
         Er9Zv3XbY7oSVNIy2RM4z3Nf1++R2fRRY7+xeMutV5+Hao8msfDY4rqw3sow+m4WgKe6
         CAJne4NzwUyxlZM0gVHB1JZ2CO7JAys8DWdNuA3pJpk1fmHisaKkSFD55TcC3oTyniqh
         5V64cqetdGOLnvGu1P6yhSBJ+v3047cfD5KgyD3aQu/agWe71aV+hz727QKZBcVzeIZI
         ocqw==
X-Forwarded-Encrypted: i=1; AJvYcCUSqyJMGlPURGBY97qrfVt9ByBgSF8xHZKqG2xIt0KtelyeTB2NKmJCEyIW4gWHZOucChx3KRoU/wnlld5RaEpU@vger.kernel.org
X-Gm-Message-State: AOJu0YxiJTOLzOrLdRXNo+RF3coLJiJqiiWkuqc6FEVUysum5UQt3z0l
	MLoSL4liMzYkbkmQJFDQj5b70WzKItjYFa4MR0XqYvCnbNXC3/IhXEsbjuDgUMa1f9tNsz6DR4+
	EckeOg3LFPruE8bVIPEaO1S01Xw==
X-Google-Smtp-Source: AGHT+IGRQ3tQu2xw3SSP0wfqw8hVdXkUiNnwLp3FSZDPtlEdZWrls30MkwdnKq2FbM4pg171i7/WNDJ2D1arVSPVXw==
X-Received: from oibbo14.prod.google.com ([2002:a05:6808:228e:b0:406:4510:b017])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:6b8d:b0:403:3e86:ab4c with SMTP id 5614622812f47-4067e6d94d1mr7758695b6e.39.1748892555108;
 Mon, 02 Jun 2025 12:29:15 -0700 (PDT)
Date: Mon,  2 Jun 2025 19:27:02 +0000
In-Reply-To: <20250602192702.2125115-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250602192702.2125115-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250602192702.2125115-18-coltonlewis@google.com>
Subject: [PATCH 17/17] KVM: arm64: selftests: Add test case for partitioned PMU
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

Run separate test cases for a partitioned PMU in
vpmu_counter_access. Notably, partitioning the PMU untraps PMCR_EL0.N,
so that is no longer settable by KVM.

Add a boolean argument to run_access_test() that will partition the
PMU by reserving one host counter if true then run the test for the
PMCR_EL0.N value that implies, one less than the number of counters on
the host system.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 tools/include/uapi/linux/kvm.h                |  2 +
 .../selftests/kvm/arm64/vpmu_counter_access.c | 40 ++++++++++++++++---
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index b6ae8ad8934b..cb72b57b9b6c 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -930,6 +930,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_X86_APIC_BUS_CYCLES_NS 237
 #define KVM_CAP_X86_GUEST_MODE 238
 #define KVM_CAP_ARM_WRITABLE_IMP_ID_REGS 239
+#define KVM_CAP_ARM_PARTITION_PMU 242
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1356,6 +1357,7 @@ struct kvm_vfio_spapr_tce {
 #define KVM_S390_SET_CMMA_BITS      _IOW(KVMIO, 0xb9, struct kvm_s390_cmma_log)
 /* Memory Encryption Commands */
 #define KVM_MEMORY_ENCRYPT_OP      _IOWR(KVMIO, 0xba, unsigned long)
+#define KVM_ARM_PARTITION_PMU	_IOWR(KVMIO, 0xce, u8)
 
 struct kvm_enc_region {
 	__u64 addr;
diff --git a/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c b/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
index f16b3b27e32e..e06448c1fbb5 100644
--- a/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
+++ b/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
@@ -369,6 +369,7 @@ static void guest_code(uint64_t expected_pmcr_n)
 	pmcr = read_sysreg(pmcr_el0);
 	pmcr_n = get_pmcr_n(pmcr);
 
+	/* __GUEST_ASSERT(0, "Expect PMCR: %lx", pmcr); */
 	/* Make sure that PMCR_EL0.N indicates the value userspace set */
 	__GUEST_ASSERT(pmcr_n == expected_pmcr_n,
 			"Expected PMCR.N: 0x%lx, PMCR.N: 0x%lx",
@@ -508,16 +509,18 @@ static void test_create_vpmu_vm_with_pmcr_n(uint64_t pmcr_n, bool expect_fail)
  * Create a guest with one vCPU, set the PMCR_EL0.N for the vCPU to @pmcr_n,
  * and run the test.
  */
-static void run_access_test(uint64_t pmcr_n)
+static void run_access_test(uint64_t pmcr_n, bool partition)
 {
 	uint64_t sp;
 	struct kvm_vcpu *vcpu;
 	struct kvm_vcpu_init init;
+	uint8_t host_counters = (uint8_t)partition;
 
 	pr_debug("Test with pmcr_n %lu\n", pmcr_n);
 
 	test_create_vpmu_vm_with_pmcr_n(pmcr_n, false);
 	vcpu = vpmu_vm.vcpu;
+	vcpu_ioctl(vcpu, KVM_ARM_PARTITION_PMU, &host_counters);
 
 	/* Save the initial sp to restore them later to run the guest again */
 	sp = vcpu_get_reg(vcpu, ARM64_CORE_REG(sp_el1));
@@ -529,6 +532,8 @@ static void run_access_test(uint64_t pmcr_n)
 	 * check if PMCR_EL0.N is preserved.
 	 */
 	vm_ioctl(vpmu_vm.vm, KVM_ARM_PREFERRED_TARGET, &init);
+	vcpu_ioctl(vcpu, KVM_ARM_PARTITION_PMU, &host_counters);
+
 	init.features[0] |= (1 << KVM_ARM_VCPU_PMU_V3);
 	aarch64_vcpu_setup(vcpu, &init);
 	vcpu_init_descriptor_tables(vcpu);
@@ -609,7 +614,7 @@ static void run_pmregs_validity_test(uint64_t pmcr_n)
  */
 static void run_error_test(uint64_t pmcr_n)
 {
-	pr_debug("Error test with pmcr_n %lu (larger than the host)\n", pmcr_n);
+	pr_debug("Error test with pmcr_n %lu (larger than the host allows)\n", pmcr_n);
 
 	test_create_vpmu_vm_with_pmcr_n(pmcr_n, true);
 	destroy_vpmu_vm();
@@ -629,20 +634,45 @@ static uint64_t get_pmcr_n_limit(void)
 	return get_pmcr_n(pmcr);
 }
 
-int main(void)
+void test_emulated_pmu(void)
 {
 	uint64_t i, pmcr_n;
 
-	TEST_REQUIRE(kvm_has_cap(KVM_CAP_ARM_PMU_V3));
+	pr_info("Testing Emulated PMU\n");
 
 	pmcr_n = get_pmcr_n_limit();
 	for (i = 0; i <= pmcr_n; i++) {
-		run_access_test(i);
+		run_access_test(i, false);
 		run_pmregs_validity_test(i);
 	}
 
 	for (i = pmcr_n + 1; i < ARMV8_PMU_MAX_COUNTERS; i++)
 		run_error_test(i);
+}
+
+void test_partitioned_pmu(void)
+{
+	uint64_t i, pmcr_n;
+
+	pr_info("Testing Partitioned PMU\n");
+
+	pmcr_n = get_pmcr_n_limit();
+	run_access_test(pmcr_n - 1, true);
+
+	/* Partitioning implies only one PMCR.N allowed */
+	for (i = 0; i < ARMV8_PMU_MAX_COUNTERS; i++)
+		if (i != pmcr_n)
+			run_error_test(i);
+}
+
+int main(void)
+{
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_ARM_PMU_V3));
+
+	test_emulated_pmu();
+
+	if (kvm_has_cap(KVM_CAP_ARM_PARTITION_PMU))
+		test_partitioned_pmu();
 
 	return 0;
 }
-- 
2.49.0.1204.g71687c7c1d-goog

