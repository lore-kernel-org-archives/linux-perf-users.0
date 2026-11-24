Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479823;
	b=A0M4QUyuA0yqZb1C0foD6gUhgv3JbQoSE6LWtIn3IPr6/vfCZrY4IHQ9YF+UmFMqjFZ0
	 8Qd0bvy53WdNQxMj3el4TmhFHfTz02eYp94oJ5OQq/ldHFFZSpZfpdOXQMyQThCKgDfFI
	 Uu0Z8T4ykdClizRMZoZ3aoqBdhoApQwa1yPsMXsNrOxPcFB5i/9HY+IJRLStToE0U8T+j
	 YlOUOKo0Wdwp02DQ3j3/rwaERuz5NcSUueA3hVXBRkj5TZUtm09h3HcnZ10K/5skT3RHh
	 FuE+Ig6vTkF4nUZpVgbIgH4b84GB2+EQwnhrVzoW/OCfM4MtZS61ToTo24asQPXjxfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479823;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qVEQ6WrowN6yXKJ64vRKJJ9FOws1/7+odNqRKAVNeWE=;
	b=U6sPYB8FMYFoZth8I9/DSqnxnRKw/Rf689XvNd05dmJIClL+shxxL3kCcxBt4HwtZhjA
	 rjpC2WFwKtVJYxyLEm09xi1CNTrKIwktgMKFEe+yyEFjW2si0CZuwoLkCAR42ikIStv5d
	 yQwKNyl/xdXP8aihkpYtOqVppMCGoCbCOMIIuuOTOBqx9ibTYbPaDp9qIxVPvtyDwCuni
	 v15WkKYM1LfebR05dOHaVQGFCgUvGRjZXy/UfSA4BMTeky2cbfrc5iz1Z6rGU0xPnzM6a
	 aYVeVjFrapa4vtr2LClEb9IWvhfttfTVmUIk7HAC3dB7KEp6KqFKod60olEUhInSoeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dQBqsGyk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55AC606A680;
	Tue, 24 Nov 2026 00:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dQBqsGyk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21B11F000CA;
	Tue, 24 Nov 2026 00:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479823;
	bh=qVEQ6WrowN6yXKJ64vRKJJ9FOws1/7+odNqRKAVNeWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dQBqsGykT+BWbvMYw05yAcavP2Cyw3pebm75cFK05CmwII024RvBCckOAKNiqednt
	 EsIefixFviN6MbUq8MAdoOFECLI8XS4ddjoe97v8XXy66hyTYAkqYud47FZEqh7mSO
	 sjL9wT0HMV9LB6XY4xJu/ixCFE/BC8ojgj3GrZSgJ+7jphPKK9NRulOKOarRTgGcE0
	 TjnFQO9tF8KGweTCiAeLrsZbU4VmfB3GmLfN0AR5lUm14q8LWdJK0lyL102JQJ9ghf
	 mzCSdcliNVQnfzyVDiM7r6HChBYIyOW1+6Ra7gdaZqKzj8umjW3sP1Oxf6DWBT7OAN
	 VfXmm7zS+OLOw==
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
Subject: [RFC PATCH 24/26] KVM: VMX: WARN if the Intel PT PMI handler runs for a mediated PMU
Date: Tue, 24 Nov 2026 00:23:01 +0000
Message-ID: <20261124002303.1785363-25-yosry@kernel.org>
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

vmx_handle_intel_pt_intr() handles ToPA PMIs for guests using Intel PT
by setting the ToPA bit in KVM's software copy of the guest's
GLOBAL_STATUS, and requesting a PMI for the guest.  This doesn't work
with a mediated PMU, as the guest's GLOBAL_STATUS lives in hardware
while the guest context is loaded, and the software copy is overwritten
when the guest context is put.  The GLOBAL_STATUS accessors can't be
used instead, as the handler runs in NMI context.

The handler can't run for a vCPU with a mediated PMU though: while the
guest context is loaded, the LVTPC routes PMIs to the mediated PMI
vector, and perf ignores NMIs (see perf_event_nmi_handler()).  NMIs from
the guest are handled right after the VM-Exit, before the guest context
can be put.  WARN if it runs anyway.

Don't bail after the WARN, as handling the PMI is still the best effort:
the guest still gets a PMI, and setting the ToPA bit in the software
copy is either correct (if the guest context is not loaded) or
harmlessly lost.  Bailing would drop the guest's PMI, and let perf
handle the interrupt as a host Intel PT interrupt.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/vmx/vmx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 68fa251dda600..14d33b7ffcd93 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8484,6 +8484,16 @@ static unsigned int vmx_handle_intel_pt_intr(void)
 	if (!vcpu || !kvm_handling_nmi_from_guest(vcpu))
 		return 0;
 
+	/*
+	 * With a mediated PMU, LVTPC points at the mediated PMI vector while the
+	 * guest runs, so a guest ToPA PMI should never arrive as an NMI. Also,
+	 * hardware GLOBAL_STATUS is authoritative while the guest context is
+	 * loaded, and pmu->global_status is overwritten when it is put, so the
+	 * bit set below would be lost. The GLOBAL_STATUS accessors can't be used
+	 * here either, as this runs in NMI context.
+	 */
+	WARN_ON_ONCE(kvm_vcpu_has_mediated_pmu(vcpu));
+
 	kvm_make_request(KVM_REQ_PMI, vcpu);
 	__set_bit(MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT,
 		  (unsigned long *)&vcpu->arch.pmu.global_status);
-- 
2.56.1.809.ga0b61035b5-goog

