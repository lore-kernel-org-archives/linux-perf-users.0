Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586AE29B766
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Feb 2026 01:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770427441; cv=none; b=mlbqlUfe6Qkg8UVb0E/JGvIpKmEVfkWmQ4JcDgdrovaFRNdfILRzqeyKQwgZpmYdF+MIwpkAV7RH47t7VkKUsWvIFEAVKDAAUUxkZW7I2IAqAWVsFuC09w60XR5g7Nxch348AVxBcTXFi5qaxuE7DQX0o6d4QYoAM5FHmeHdUvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770427441; c=relaxed/simple;
	bh=mQ5q0HDnakbHZK2u/uTVHdKjCxIgiQ2sBFsmmZJNZvY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fZJXbfJgo6CiTY2qQesNgj92gLKqv2BocIJcqPBTwbjxc8WrzgXNco1Bc1Y/qz/GK0A8YPflFiyrWiWte8qUnfSdtl9VKQspvSlAHRbyNMlLNt3gO9HXZ0WrmEAsK6tRtck6FpgUPrKbP3SiMUXm6yOHZcTIDxCcygpnmhhnqaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=diRXKb4h; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="diRXKb4h"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a7d7b87977so27935575ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Feb 2026 17:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770427441; x=1771032241; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K4Q9ET/TKOgMPaBFA8KfQMo0cbmVTdTajIMx+Sh9uYE=;
        b=diRXKb4hCcG6gHjq/zAnZWtJSDpIbkI6n+P1xmfteNCZbRwDIk50qwRgdIfaxpEEvr
         4eZTaa7ks9jyEFeysvDb3YhObDQxdnJvJY64dpQ8luZnWdbXQRpAxX/vofc5BS7H/NsJ
         4A6iYxnVuCQkdgbhgAZRXBW5NYCEWQNLfj9PnYId6GD5i85FQFsj+zzWCDpxN3YjYAxp
         RkfQYESkPG/p1feMJMIkLjTvl1dDjS4wRPGeGvR1Qt4LTfLOq05h6wVLoFdxaaI9AoQS
         6HYDdavo9ZMc8w5Uoi9DV2I2FnI6GGAdRCM7jtiuXc5PS/NK1PevfRv78izxKs+hlhWk
         hf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770427441; x=1771032241;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4Q9ET/TKOgMPaBFA8KfQMo0cbmVTdTajIMx+Sh9uYE=;
        b=TJRbfBxoMfSwOB3B5gWn91pjehEDWd6keQC68XtnvvB/+KxNazbJs/X/jtORgMH93W
         9Ab7NuqKqBfxu/Wl/cNwSdCcoBexV5EZNoLZxFD9dsbePgq2wD0t1DYnA/gj30yX9X26
         W5p8hsLVu4tXDSxC/l31vD4hpaH/duFDNMO1jIHojzp7sYUi8kfJCRzAUy722n5VoHup
         Ee4eTY+3LXr6V4MWp7Cx5HUAOmQWC1sxoGotwLJo2ehpfScYNDeAdm6RFVOwJxYnOoKA
         33Y75tAeAiOZwoVz96CQlhGtI4c0Okx9BAkV7JXkTzDRWFg6NQxtvdD9R1GEe7dca2n+
         oYuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2CdW4tvjN1HU2zQFqiuwklO9yg7yudMwNgHyUwQmWGQbCVmxYcPwYcGTaHoBpZdhEb37f3wlGILz4sACr3Odz@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc8XmVXLPrpTYFKtoFvNDtQI4T5U5sktc2mYuZC0dqO2VCDl5a
	vF8s7o0LZVVlutEimvIVbO5+TcWoHdOnmAfj3zTUHmfcuF91wyfVp1nOKraaIuoeXPoUMb9ShBK
	1oUQwpJmmuMT4OQ==
X-Received: from pleu16.prod.google.com ([2002:a17:903:41d0:b0:29f:2fcb:60c8])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3885:b0:29f:1bf:6424 with SMTP id d9443c01a7336-2a95163750fmr44168655ad.18.1770427440755;
 Fri, 06 Feb 2026 17:24:00 -0800 (PST)
Date: Fri,  6 Feb 2026 17:23:31 -0800
In-Reply-To: <20260207012339.2646196-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260207012339.2646196-1-jmattson@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260207012339.2646196-6-jmattson@google.com>
Subject: [PATCH v3 5/5] KVM: selftests: x86: Add svm_pmu_host_guest_test for
 Host-Only/Guest-Only bits
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Mingwei Zhang <mizhang@google.com>, Sandipan Das <sandipan.das@amd.com>
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a selftest to verify KVM correctly virtualizes the AMD PMU Host-Only
(bit 41) and Guest-Only (bit 40) event selector bits across all relevant
SVM state transitions.

The test programs 4 PMCs simultaneously with all combinations of the
Host-Only and Guest-Only bits, then verifies correct counting behavior:
  1. SVME=0: all counters count (Host-Only/Guest-Only bits ignored)
  2. Set SVME=1: Host-Only and neither/both count; Guest-Only stops
  3. VMRUN to L2: Guest-Only and neither/both count; Host-Only stops
  4. VMEXIT to L1: Host-Only and neither/both count; Guest-Only stops
  5. Clear SVME=0: all counters count (bits ignored again)

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 tools/testing/selftests/kvm/include/x86/pmu.h |   6 +
 .../selftests/kvm/include/x86/processor.h     |   2 +
 .../kvm/x86/svm_pmu_host_guest_test.c         | 199 ++++++++++++++++++
 4 files changed, 208 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 58eee0474db6..f20ddd58ee81 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -112,6 +112,7 @@ TEST_GEN_PROGS_x86 += x86/svm_vmcall_test
 TEST_GEN_PROGS_x86 += x86/svm_int_ctl_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_shutdown_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_soft_inject_test
+TEST_GEN_PROGS_x86 += x86/svm_pmu_host_guest_test
 TEST_GEN_PROGS_x86 += x86/tsc_scaling_sync
 TEST_GEN_PROGS_x86 += x86/sync_regs_test
 TEST_GEN_PROGS_x86 += x86/ucna_injection_test
diff --git a/tools/testing/selftests/kvm/include/x86/pmu.h b/tools/testing/selftests/kvm/include/x86/pmu.h
index 72575eadb63a..af9b279c78df 100644
--- a/tools/testing/selftests/kvm/include/x86/pmu.h
+++ b/tools/testing/selftests/kvm/include/x86/pmu.h
@@ -38,6 +38,12 @@
 #define ARCH_PERFMON_EVENTSEL_INV		BIT_ULL(23)
 #define ARCH_PERFMON_EVENTSEL_CMASK		GENMASK_ULL(31, 24)
 
+/*
+ * These are AMD-specific bits.
+ */
+#define AMD64_EVENTSEL_GUESTONLY		BIT_ULL(40)
+#define AMD64_EVENTSEL_HOSTONLY			BIT_ULL(41)
+
 /* RDPMC control flags, Intel only. */
 #define INTEL_RDPMC_METRICS			BIT_ULL(29)
 #define INTEL_RDPMC_FIXED			BIT_ULL(30)
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 4ebae4269e68..10ee2d4db1e3 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -19,6 +19,8 @@
 #include "kvm_util.h"
 #include "ucall_common.h"
 
+#define __stack_aligned__	__aligned(16)
+
 extern bool host_cpu_is_intel;
 extern bool host_cpu_is_amd;
 extern uint64_t guest_tsc_khz;
diff --git a/tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c b/tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c
new file mode 100644
index 000000000000..a08c03a40d4f
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KVM nested SVM PMU Host-Only/Guest-Only test
+ *
+ * Copyright (C) 2026, Google LLC.
+ *
+ * Test that KVM correctly virtualizes the AMD PMU Host-Only (bit 41) and
+ * Guest-Only (bit 40) event selector bits across all SVM state
+ * transitions.
+ *
+ * Programs 4 PMCs simultaneously with all combinations of Host-Only and
+ * Guest-Only bits, then verifies correct counting behavior through:
+ *   1. SVME=0: all counters count (Host-Only/Guest-Only bits ignored)
+ *   2. Set SVME=1: Host-Only and neither/both count; Guest-Only stops
+ *   3. VMRUN to L2: Guest-Only and neither/both count; Host-Only stops
+ *   4. VMEXIT to L1: Host-Only and neither/both count; Guest-Only stops
+ *   5. Clear SVME=0: all counters count (bits ignored again)
+ */
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "svm_util.h"
+#include "pmu.h"
+
+#define L2_GUEST_STACK_SIZE	255
+
+#define EVENTSEL_RETIRED_INSNS	(ARCH_PERFMON_EVENTSEL_OS |	\
+				 ARCH_PERFMON_EVENTSEL_USR |	\
+				 ARCH_PERFMON_EVENTSEL_ENABLE |	\
+				 AMD_ZEN_INSTRUCTIONS_RETIRED)
+
+/* PMC configurations: index corresponds to Host-Only | Guest-Only bits */
+#define PMC_NEITHER	0  /* Neither bit set */
+#define PMC_GUESTONLY	1  /* Guest-Only bit set */
+#define PMC_HOSTONLY	2  /* Host-Only bit set */
+#define PMC_BOTH	3  /* Both bits set */
+#define NR_PMCS		4
+
+/* Bitmasks for which PMCs should be counting in each state */
+#define COUNTS_ALL	(BIT(PMC_NEITHER) | BIT(PMC_GUESTONLY) | \
+			 BIT(PMC_HOSTONLY) | BIT(PMC_BOTH))
+#define COUNTS_L1	(BIT(PMC_NEITHER) | BIT(PMC_HOSTONLY) | BIT(PMC_BOTH))
+#define COUNTS_L2	(BIT(PMC_NEITHER) | BIT(PMC_GUESTONLY) | BIT(PMC_BOTH))
+
+#define LOOP_INSNS	1000
+
+static __always_inline void run_instruction_loop(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < LOOP_INSNS; i++)
+		__asm__ __volatile__("nop");
+}
+
+static __always_inline void read_counters(uint64_t *counts)
+{
+	int i;
+
+	for (i = 0; i < NR_PMCS; i++)
+		counts[i] = rdmsr(MSR_F15H_PERF_CTR + 2 * i);
+}
+
+static __always_inline void run_and_measure(uint64_t *deltas)
+{
+	uint64_t before[NR_PMCS], after[NR_PMCS];
+	int i;
+
+	read_counters(before);
+	run_instruction_loop();
+	read_counters(after);
+
+	for (i = 0; i < NR_PMCS; i++)
+		deltas[i] = after[i] - before[i];
+}
+
+static void assert_pmc_counts(uint64_t *deltas, unsigned int expected_counting)
+{
+	int i;
+
+	for (i = 0; i < NR_PMCS; i++) {
+		if (expected_counting & BIT(i))
+			GUEST_ASSERT_NE(deltas[i], 0);
+		else
+			GUEST_ASSERT_EQ(deltas[i], 0);
+	}
+}
+
+struct test_data {
+	uint64_t l2_deltas[NR_PMCS];
+	bool l2_done;
+};
+
+static struct test_data *test_data;
+
+static void l2_guest_code(void)
+{
+	run_and_measure(test_data->l2_deltas);
+	test_data->l2_done = true;
+	vmmcall();
+}
+
+static void l1_guest_code(struct svm_test_data *svm, struct test_data *data)
+{
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE] __stack_aligned__;
+	struct vmcb *vmcb = svm->vmcb;
+	uint64_t deltas[NR_PMCS];
+	uint64_t eventsel;
+	int i;
+
+	test_data = data;
+
+	/* Program 4 PMCs with all combinations of Host-Only/Guest-Only bits */
+	for (i = 0; i < NR_PMCS; i++) {
+		eventsel = EVENTSEL_RETIRED_INSNS;
+		if (i & PMC_GUESTONLY)
+			eventsel |= AMD64_EVENTSEL_GUESTONLY;
+		if (i & PMC_HOSTONLY)
+			eventsel |= AMD64_EVENTSEL_HOSTONLY;
+		wrmsr(MSR_F15H_PERF_CTL + 2 * i, eventsel);
+		wrmsr(MSR_F15H_PERF_CTR + 2 * i, 0);
+	}
+
+	/* Step 1: SVME=0 - Host-Only/Guest-Only bits ignored; all count */
+	wrmsr(MSR_EFER, rdmsr(MSR_EFER) & ~EFER_SVME);
+	run_and_measure(deltas);
+	assert_pmc_counts(deltas, COUNTS_ALL);
+
+	/* Step 2: Set SVME=1 - In L1 "host mode"; Guest-Only stops */
+	wrmsr(MSR_EFER, rdmsr(MSR_EFER) | EFER_SVME);
+	run_and_measure(deltas);
+	assert_pmc_counts(deltas, COUNTS_L1);
+
+	/* Step 3: VMRUN to L2 - In "guest mode"; Host-Only stops */
+	generic_svm_setup(svm, l2_guest_code,
+			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	vmcb->control.intercept &= ~(1ULL << INTERCEPT_MSR_PROT);
+
+	run_guest(vmcb, svm->vmcb_gpa);
+
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_VMMCALL);
+	GUEST_ASSERT(data->l2_done);
+	assert_pmc_counts(data->l2_deltas, COUNTS_L2);
+
+	/* Step 4: After VMEXIT to L1 - Back in "host mode"; Guest-Only stops */
+	run_and_measure(deltas);
+	assert_pmc_counts(deltas, COUNTS_L1);
+
+	/* Step 5: Clear SVME - Host-Only/Guest-Only bits ignored; all count */
+	wrmsr(MSR_EFER, rdmsr(MSR_EFER) & ~EFER_SVME);
+	run_and_measure(deltas);
+	assert_pmc_counts(deltas, COUNTS_ALL);
+
+	GUEST_DONE();
+}
+
+int main(int argc, char *argv[])
+{
+	vm_vaddr_t svm_gva, data_gva;
+	struct test_data *data_hva;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
+	TEST_REQUIRE(kvm_is_pmu_enabled());
+	TEST_REQUIRE(get_kvm_amd_param_bool("enable_mediated_pmu"));
+	TEST_REQUIRE(host_cpu_is_amd && kvm_cpu_family() >= 0x17);
+
+	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
+
+	vcpu_alloc_svm(vm, &svm_gva);
+
+	data_gva = vm_vaddr_alloc_page(vm);
+	data_hva = addr_gva2hva(vm, data_gva);
+	memset(data_hva, 0, sizeof(*data_hva));
+
+	vcpu_args_set(vcpu, 2, svm_gva, data_gva);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+		break;
+	case UCALL_DONE:
+		break;
+	default:
+		TEST_FAIL("Unknown ucall %lu", uc.cmd);
+	}
+
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.53.0.rc2.204.g2597b5adb4-goog

