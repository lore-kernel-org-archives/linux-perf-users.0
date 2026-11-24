Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479821;
	b=AljGRF6VCeMwUdCTfyDlQ24KwTwFi1ckOhjXg9bmYElVMk+3FRsM9rupokH8XsZnxZ1E
	 GVODj6EzsApwot1iW9ZrGzIKPBN75B6Mv7rtpSolrnqhPVkSXzvWIbw7xVJfB6H4qU+mv
	 S96ESOnt4W6CHTSi1vszcm2CuONBnoXejmTjEjiwZNXBT0UalJjpd/7B75/ch3GfZPSIY
	 9ynvq3BbM8DpEPI28sJSKRcRmvnvH3pkFD0K/MjJzqnZ8FWW6XyQnZHA2QghJqQASn+Rh
	 221KqO1N6aliOOIQO8c6RPsdwkZF1yCscyJvWVA/lngCbuih51S12kWrgDMew+yVoAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479821;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sCZmrnrpCYbq4AdLgSnvuymwLDDREEzW+1fo2LMXLMQ=;
	b=1u5LzwMji4oEakiENMx7v9LkuWkiTQQH5MCLa1AZ6WB96R1z8Nj9Sfl3Qw3R0Icvtbtv
	 FrlZh0ZsALKcQ2i87MONGbgMmNMRBrZaFM4ugc9BeZe262N6wkHhkdzk5c1p5mcFObQmI
	 A+S4X2xXDI9DjHCFPCBohkysyYd8PQk/Gkg2uJofacvOTmEr7nRtDLIdEDZG1G+gYmkw8
	 uHY+mwZ1YBcW6Gue5/iI9XZ62Bp8BoFECL87GSWzvl1fBLUVteUDDmsY/bcC7RM/dn7XM
	 iBRl6++FnCdeh5yYCdTMga/n3Jl4JIIAJQxmi028oQkKemryv2H8a707xeKTjkw6YFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FzzGacKB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E13606C7BB;
	Tue, 24 Nov 2026 00:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FzzGacKB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BD91F00ADE;
	Tue, 24 Nov 2026 00:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479820;
	bh=sCZmrnrpCYbq4AdLgSnvuymwLDDREEzW+1fo2LMXLMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FzzGacKBjFf2m1Mv8ee12PH0J+rJuGrSg+Ldz0/EZ5+HDSbjJtrz5XOiiX1juWKQZ
	 sMqXZ4uzepom+pbeB/thSnqMnxYG7ZKeDdeCNhNmeK1R0dLWqdI2Ax3cB8r9Gux/Ea
	 7/+zsY8dYIXjxVNv1Kz+t2kPwoiS8Dz2NY/L/9V4yPZa9D5Y+rvSPWZj6QqKs2NJuq
	 zC7K2tMeFzb8coIThHon5guxGjienYwBiiCjbLEs0ah1Ermp8ezW5hgpNlIR2uNle4
	 KOGdge9kE3VAUBbJhX2cmDsArD9P2hNNsH8jWec8u3HhbzRjNvq9XM9UaK+wyHkdDc
	 zw2UraHEcHqGA==
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
Subject: [RFC PATCH 22/26] KVM: x86/pmu: Put the mediated PMU context lazily on slowpath VM-Exits
Date: Tue, 24 Nov 2026 00:22:59 +0000
Message-ID: <20261124002303.1785363-23-yosry@kernel.org>
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

Instead of putting the guest's mediated PMU context on every slowpath
VM-Exit, only put it on slowpath VM-Exits if perf has events conflicting
with the mediated PMU, i.e. events on mediated-capable PMUs or on PMUs
that deliver interrupts like guest PMIs.  Otherwise, leave the guest
context loaded while handling slowpath VM-Exits, and put it when the
vCPU is put (including when the vCPU task is scheduled out), or when
perf reclaims the mediated PMU before accessing it for the host.

Saving and restoring the guest's PMU state on every slowpath VM-Exit is
expensive.  Below is the throughput (median of 10 x 5s runs) of a CPUID
loop in a guest and of netperf TCP_RR between two guests, on AMD Turin
and Intel Granite Rapids, with a mediated PMU before (eager) and after
(lazy) this change, and without a vPMU.  The rows are without perf
events (idle), and with perf events in the guest, in the host, or both:

                          Turin                   Granite Rapids
                 eager     lazy   no vPMU     eager     lazy   no vPMU
  CPUID/s:
    idle        547.8K  1688.6K  1816.5K     687.9K  1386.2K  1352.5K
    guest perf  483.2K  1484.8K        -     631.6K  1266.7K        -
    host perf   342.1K   352.5K        -     418.4K   411.4K        -
    both        339.9K   338.4K        -     403.4K   396.2K        -
  TCP_RR/s:
    idle         43.4K    49.9K    50.4K      12.1K    13.7K    13.8K
    guest perf   42.5K    50.0K        -      12.0K    13.7K        -
    host perf    39.5K    40.1K        -      11.8K    12.0K        -
    both         39.7K    40.0K        -      11.8K    12.0K        -

Without perf events, CPUID throughput improves by 208% on Turin and 102%
on Granite Rapids, reaching 93% and 100% of the throughput without a
vPMU, and TCP_RR throughput improves by 15% and 13%, reaching 99% of the
throughput without a vPMU.  With host perf events, KVM still puts the
guest context on every slowpath VM-Exit, and throughput is within 3% of
before.

KVM already accesses guest PMU state in hardware while the guest context
is loaded, including the LVTPC.  Conflicting events can only be added
after perf reclaims the mediated PMU, and conflicts are checked with
IRQs disabled after the VM-Exit, so host events never run with the guest
context loaded.  As loading and putting the guest context is idempotent,
it doesn't matter which path puts it first.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/pmu.c       | 10 ++++++++++
 arch/x86/kvm/pmu.h       |  1 +
 arch/x86/kvm/x86.c       | 10 ++++++++--
 include/linux/kvm_host.h |  5 +++--
 virt/kvm/kvm_main.c      |  4 +++-
 5 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index d56cd0fa817d7..4879578c7d579 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -223,6 +223,16 @@ void kvm_handle_guest_mediated_pmi(void)
 	kvm_make_request(KVM_REQ_PMI, vcpu);
 }
 
+void kvm_handle_mediated_pmu_reclaim(void)
+{
+	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
+
+	if (WARN_ON_ONCE(!vcpu || !kvm_vcpu_has_mediated_pmu(vcpu)))
+		return;
+
+	kvm_mediated_pmu_put(vcpu);
+}
+
 static inline void __kvm_perf_overflow(struct kvm_pmc *pmc, bool in_pmi)
 {
 	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 317848ac3df7b..89807e7a3c771 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -73,6 +73,7 @@ extern bool enable_mediated_pmu;
 void kvm_pmu_ops_update(const struct kvm_pmu_ops *pmu_ops);
 
 void kvm_handle_guest_mediated_pmi(void);
+void kvm_handle_mediated_pmu_reclaim(void);
 
 static inline bool kvm_pmu_has_perf_global_ctrl(struct kvm_pmu *pmu)
 {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8370ccceadb82..7fb954ed8e84b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2708,6 +2708,11 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 		srcu_read_unlock(&vcpu->kvm->srcu, idx);
 	}
 
+	if (kvm_vcpu_has_mediated_pmu(vcpu)) {
+		scoped_guard(irqsave)
+			kvm_mediated_pmu_put(vcpu);
+	}
+
 	kvm_x86_call(vcpu_put)(vcpu);
 	vcpu->arch.last_host_tsc = rdtsc();
 }
@@ -7176,7 +7181,8 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 #endif
 
 	__kvm_register_perf_callbacks(ops->handle_intel_pt_intr,
-				      enable_mediated_pmu ? kvm_handle_guest_mediated_pmi : NULL);
+				      enable_mediated_pmu ? kvm_handle_guest_mediated_pmi : NULL,
+				      enable_mediated_pmu ? kvm_handle_mediated_pmu_reclaim : NULL);
 
 	if (IS_ENABLED(CONFIG_KVM_SW_PROTECTED_VM) && tdp_mmu_enabled)
 		kvm_caps.supported_vm_types |= BIT(KVM_X86_SW_PROTECTED_VM);
@@ -8433,7 +8439,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 	kvm_load_host_pkru(vcpu);
 
-	if (kvm_vcpu_has_mediated_pmu(vcpu))
+	if (kvm_vcpu_has_mediated_pmu(vcpu) && perf_has_mediated_pmu_conflicts())
 		kvm_mediated_pmu_put(vcpu);
 
 	/*
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6debea9c255ee..3656fa2212c8e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1825,11 +1825,12 @@ static inline bool kvm_arch_intc_initialized(struct kvm *kvm)
 unsigned long kvm_arch_vcpu_get_ip(struct kvm_vcpu *vcpu);
 
 void __kvm_register_perf_callbacks(unsigned int (*pt_intr_handler)(void),
-				   void (*mediated_pmi_handler)(void));
+				   void (*mediated_pmi_handler)(void),
+				   void (*mediated_pmu_reclaim_handler)(void));
 
 static inline void kvm_register_perf_callbacks(void)
 {
-	__kvm_register_perf_callbacks(NULL, NULL);
+	__kvm_register_perf_callbacks(NULL, NULL, NULL);
 }
 
 void kvm_unregister_perf_callbacks(void);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2b9a46bfd3696..1bd3aa2227d28 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -6603,10 +6603,12 @@ static struct perf_guest_info_callbacks kvm_guest_cbs = {
 };
 
 void __kvm_register_perf_callbacks(unsigned int (*pt_intr_handler)(void),
-				   void (*mediated_pmi_handler)(void))
+				   void (*mediated_pmi_handler)(void),
+				   void (*mediated_pmu_reclaim_handler)(void))
 {
 	kvm_guest_cbs.handle_intel_pt_intr = pt_intr_handler;
 	kvm_guest_cbs.handle_mediated_pmi = mediated_pmi_handler;
+	kvm_guest_cbs.reclaim_mediated_pmu = mediated_pmu_reclaim_handler;
 
 	perf_register_guest_info_callbacks(&kvm_guest_cbs);
 }
-- 
2.56.1.809.ga0b61035b5-goog

