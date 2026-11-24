Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479817;
	b=AOaiJhax/+/yKNt/sPqQex7DJ39nSoIHTH9iHel3STOYoCmBmzQOZ7tfzselkPGBzDnr
	 TjTEA82WuSjbntEjRVoLSlNNGxQIRaUendhGmH38yoWp0bNLKjNdAfQA5Z+2oGO5mKy1m
	 FMLPJoWmjFIzN3U+jrqde72UhVu8vHpPmkChqSy+/Zc/yoByfHiiycRkd/AfHX/gTseJV
	 H4H39TqTaKmYnrx6HegDNIt1z8b8NOpCEyY2AUKUVEO/TMiFNQ7sA8m3QE6I1QJxK3cih
	 RaYiS7MvUM6UrXxOOQzLX+PbLMwfepliT9v2MifGqu12MkBf0m0bcfQcbzfmcAtrCrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479817;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2u8O2EG46wGM2C9yzrpywzGJ0b8w2Uf602m9vEPbcIY=;
	b=c98Ng7azkALr+9UgdMr3jrAVig7QFu+qBUGIVBM80uf1MDpblw7fiwwpx8A7GMURlpAQ
	 AE6s8Z/kqubNRjD5tmS0zpwXV0rIqh/wp4K8DHrAfK6+QsXZsyR0QtzM9m+N81/hNapUc
	 MZx6uqF/SPAnD+CdftEcAluk8svDZXTAMoNl1L1EEGGBGrm1FxLh5zCHb+qawamAbmHz0
	 qotcmmUjWyTB0h+qq52NR6UX1LwI9U7Em4Mc67UhccTpKJoAObcJUVL+xiJsYZxnxLZZK
	 5t93l1hIL5zz5s7iOeJMFphQ7DzUU6LIRdzyEWaxcpd2sYcaX3Y7RypKCRKixCCh9TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UDVmhO4d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC09C606C794;
	Tue, 24 Nov 2026 00:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UDVmhO4d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23C91F000C6;
	Tue, 24 Nov 2026 00:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479817;
	bh=2u8O2EG46wGM2C9yzrpywzGJ0b8w2Uf602m9vEPbcIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UDVmhO4dcjqeWW8OZFnCMPn315z3laLwvtHMkP5zJGzXv1Ta48hu4jhUg+pRXGLS+
	 JknuAk4rfCNPcdyL1TRuElwJC518gTefy8YVU/BH/9NOe16VTbOW2KbFPLWXCQJVTi
	 UmyUp1rXgJULFUaGlq9MML8jPZeMPlFAQmXOj2iJ3khuoo15DfgRaZhWBRFYcf8a+I
	 UjhObFJuXzhY+opAJ8YvW1Xm+Dy71lfncSxozubmVKKK3g93rL9u3OYoz5wCKyg9TY
	 KxXn5gcYNAiSFNdnLUU9CRKj2H8HZf9ImEtTlf5jc+mCZfaPx0/gPjk7v75BR1/nIF
	 lX98yE9txJydg==
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
Subject: [RFC PATCH 20/26] KVM: x86/pmu: Check for a mediated PMU before loading/putting its context
Date: Tue, 24 Nov 2026 00:22:57 +0000
Message-ID: <20261124002303.1785363-21-yosry@kernel.org>
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

Move the checks for whether the vCPU has a mediated PMU from
kvm_mediated_pmu_load() and kvm_mediated_pmu_put() to their callers, in
preparation for putting the guest context from more places, and
conditionally on whether perf has events conflicting with the mediated
PMU.  The new callers need to check for a mediated PMU first anyway,
e.g. to avoid querying perf or disabling IRQs for vCPUs without a
mediated PMU.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/pmu.c | 6 ++----
 arch/x86/kvm/x86.c | 6 ++++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index cee3c4719dd14..e92a7a1f20a89 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -1420,8 +1420,7 @@ void kvm_pmu_sync_lvtpc(struct kvm_vcpu *vcpu, u32 lvtpc)
 
 void kvm_mediated_pmu_load(struct kvm_vcpu *vcpu)
 {
-	if (!kvm_vcpu_has_mediated_pmu(vcpu) ||
-	    KVM_BUG_ON(!lapic_in_kernel(vcpu), vcpu->kvm))
+	if (KVM_BUG_ON(!lapic_in_kernel(vcpu), vcpu->kvm))
 		return;
 
 	lockdep_assert_irqs_disabled();
@@ -1481,8 +1480,7 @@ static void kvm_pmu_put_guest_pmcs(struct kvm_vcpu *vcpu)
 
 void kvm_mediated_pmu_put(struct kvm_vcpu *vcpu)
 {
-	if (!kvm_vcpu_has_mediated_pmu(vcpu) ||
-	    KVM_BUG_ON(!lapic_in_kernel(vcpu), vcpu->kvm))
+	if (KVM_BUG_ON(!lapic_in_kernel(vcpu), vcpu->kvm))
 		return;
 
 	lockdep_assert_irqs_disabled();
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2cd9ee316aada..8370ccceadb82 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8392,7 +8392,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		run_flags |= KVM_RUN_LOAD_DEBUGCTL;
 	vcpu->arch.host_debugctl = debug_ctl;
 
-	kvm_mediated_pmu_load(vcpu);
+	if (kvm_vcpu_has_mediated_pmu(vcpu))
+		kvm_mediated_pmu_load(vcpu);
 
 	guest_timing_enter_irqoff();
 
@@ -8432,7 +8433,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 	kvm_load_host_pkru(vcpu);
 
-	kvm_mediated_pmu_put(vcpu);
+	if (kvm_vcpu_has_mediated_pmu(vcpu))
+		kvm_mediated_pmu_put(vcpu);
 
 	/*
 	 * Do this here before restoring debug registers on the host.  And
-- 
2.56.1.809.ga0b61035b5-goog

