Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479816;
	b=w92eT6YQ7hwQsoGEFraJ0omjZZmnYSNnMU1ZWtaPTNescsQ8LLNhGoiMA0cnDilMu3rW
	 05SFHdkqikeC4ld6KoX7o9Fpamxc5fG6SeULOvxrYKdlu1944xByHvCePujECEI2CN6Oj
	 eCG5a5QYxi//lqNpMzcDZSzDupXl+SN1AXJYtQy6T7Gtr50UTD37jR6NtbqG5ANcbabiK
	 S7hKRB9T+ipOYJgB3exILqBBHMKJ0YOatUQc9U6aJCagCkujqQ7/G5U5cS/G+LZ6qyao6
	 Oin8M5JcifKHs/hF+yrYLuhQGTHgXT7hXkgD64zKPXIC0l41Yhsn35qEXLIHAQp1imw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479816;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=g81gOaTWdgV7XGkTndQbTnqFQqIwR4QxEPYE59gd45w=;
	b=QNikgZ60x6Fvc4tqM9xRezJBRjJsk1naKyjOD0WXdfTCZbroj0NUT70VwxmG3vt4B9Ok
	 7u4IUWYdJpbbhc1Yi9rh5tGS8mwm2xhV27E0vh1gLdLvlELiXbitzmVEpi38ijOfk3ovP
	 PNieeCfJ8HIT+TU5TcVNnv9SmrPqCMlGshvDXkTrpAcldbpqV9n9f8t0w7FYq69Gce8//
	 XQtZQo18VTNUy5MOqcd1b1ZIzFnEXtYwbDsUY/XuOoTOk6wRVs7X7xnG9zwdeHkSJ8EAc
	 cv9j4SxXjscc3pdhpApvKwdNOVcbSBr2gt+v7Wng9u7/N4925532l24YdScsK9QifPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nSmO8XIp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6945760A382C;
	Tue, 24 Nov 2026 00:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nSmO8XIp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6518B1F000EE;
	Tue, 24 Nov 2026 00:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479816;
	bh=g81gOaTWdgV7XGkTndQbTnqFQqIwR4QxEPYE59gd45w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nSmO8XIpfUQD6/iTSh+2mPmoruUZ3cTXDcVlzhbfCRBqDpzczA4hVlw+JYgxZgROu
	 iWPZdyJIzKROOAFiuAR5tpUgy0m85ju1AMkrC9Y6q0cR5i/kv7hEOgMc/hbGfCU0S7
	 zWYfBwosepNaupcXhUTQGX0ZEnNcKj0JtIU4Q7D9puKI3wbUL00ITt16homvRYZTA7
	 4ckpNuyjGYwL4x5qh2aNDDM3cp7SWkynGyoKlMXyPb8beQP70FrzwcpNRcJndTnheh
	 3M97etV3Hbd1Ecic4Ye88Po/V/ICxqF7CawNqWbRwLVmuQJ+NGdAKqtKHxSyWuBPV9
	 T0TDrlOhwVC4w==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mingwei Zhang <mizhang@google.com>,
	Jim Mattson <jmattson@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [RFC PATCH 19/26] KVM: x86/pmu: Sync the guest's LVTPC to hardware if the guest context is loaded
Date: Tue, 24 Nov 2026 00:22:56 +0000
Message-ID: <20261124002303.1785363-20-yosry@kernel.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
In-Reply-To: <20261124002303.1785363-1-yosry@kernel.org>
References: <20261124002303.1785363-1-yosry@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for leaving the guest's mediated PMU context loaded
during slowpath VM-Exit handling, propagate writes to the guest's
virtual LVTPC to hardware if the guest context is loaded.

The guest's LVTPC is emulated by KVM: guest writes are intercepted and
only update the virtual LVTPC, and its mask bit is only written to the
hardware LVTPC when the guest context is loaded.  Currently, the guest
context is put on every VM-Exit that isn't handled in the fastpath and
loaded again before the next VM-Enter, and fastpath handlers never write
the virtual LVTPC, so changes reach hardware before the guest runs
again.  Once the guest context stays loaded across slowpath VM-Exits,
changes wouldn't reach hardware until the guest context is put and
loaded again.

For example, KVM masks the virtual LVTPC when delivering a PMI.  If the
guest context is loaded while the virtual LVTPC is masked and then stays
loaded, the guest unmasking LVTPC at the end of its PMI handler would
only update the virtual LVTPC, leaving the hardware LVTPC masked, and
the guest would stop getting PMIs.

Hook kvm_lapic_set_reg(), which handles all writes to the virtual
LVTPC, except for kvm_apic_set_state() restoring the APIC state from
userspace, which can't happen with the guest context loaded.

RFC note: Intel CPUs also set the mask bit in the hardware LVTPC when
delivering a PMI.  KVM emulates this by masking the virtual LVTPC, which
is now propagated to hardware, but it doesn't do so if the guest's CPUID
isn't Intel-compatible, or if delivering the PMI fails (e.g. the guest's
APIC is hardware-disabled, or the virtual LVTPC has an invalid delivery
mode).  In those cases, the hardware LVTPC stays masked while the guest
context stays loaded, instead of being unmasked at the next VM-Enter.
Cross-vendor configurations aren't supported with a mediated PMU, and
the other cases require a misconfigured guest, so this is ignored for
now.  If it matters, kvm_pmu_deliver_pmi() could resync the hardware
LVTPC when the virtual LVTPC remains unmasked.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/lapic.c |  4 ++++
 arch/x86/kvm/pmu.c   | 15 +++++++++++++++
 arch/x86/kvm/pmu.h   |  1 +
 3 files changed, 20 insertions(+)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index d341801b61cba..b554c0e949886 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -46,6 +46,7 @@
 #include "cpuid.h"
 #include "hyperv.h"
 #include "smm.h"
+#include "pmu.h"
 
 #ifndef CONFIG_X86_64
 #define mod_64(x, y) ((x) - (y) * div64_u64(x, y))
@@ -94,6 +95,9 @@ static int kvm_lapic_msr_write(struct kvm_lapic *apic, u32 reg, u64 data);
 static inline void kvm_lapic_set_reg(struct kvm_lapic *apic, int reg_off, u32 val)
 {
 	apic_set_reg(apic->regs, reg_off, val);
+
+	if (reg_off == APIC_LVTPC)
+		kvm_pmu_sync_lvtpc(apic->vcpu, val);
 }
 
 static __always_inline u64 kvm_lapic_get_reg64(struct kvm_lapic *apic, int reg)
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 11d12093d3a6a..cee3c4719dd14 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -1403,6 +1403,21 @@ static void kvm_pmu_load_guest_pmcs(struct kvm_vcpu *vcpu)
 	}
 }
 
+/*
+ * Mirror a change of the guest's virtual LVTPC into hardware if the guest's
+ * mediated PMU context is loaded. Only the mask bit of the guest's LVTPC is
+ * reflected in hardware (perf owns the vector and delivery mode).
+ */
+void kvm_pmu_sync_lvtpc(struct kvm_vcpu *vcpu, u32 lvtpc)
+{
+	if (!kvm_vcpu_has_mediated_pmu(vcpu))
+		return;
+
+	guard(irqsave)();
+	if (is_guest_mediated_pmu_loaded())
+		perf_load_guest_lvtpc(lvtpc);
+}
+
 void kvm_mediated_pmu_load(struct kvm_vcpu *vcpu)
 {
 	if (!kvm_vcpu_has_mediated_pmu(vcpu) ||
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 6a340a66e9246..317848ac3df7b 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -330,6 +330,7 @@ void kvm_pmu_destroy(struct kvm_vcpu *vcpu);
 int kvm_vm_ioctl_set_pmu_event_filter(struct kvm *kvm, void __user *argp);
 void kvm_pmu_instruction_retired(struct kvm_vcpu *vcpu);
 void kvm_pmu_branch_retired(struct kvm_vcpu *vcpu);
+void kvm_pmu_sync_lvtpc(struct kvm_vcpu *vcpu, u32 lvtpc);
 void kvm_mediated_pmu_load(struct kvm_vcpu *vcpu);
 void kvm_mediated_pmu_put(struct kvm_vcpu *vcpu);
 
-- 
2.56.1.809.ga0b61035b5-goog

