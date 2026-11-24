Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479819;
	b=c4Tkc9fKBAsDu+MDJULhubEWH9BaR2lLTmejc1q+F80AxMbe8YPFt2PMZ2/wS5faAjqs
	 glH9eIfmPuLGSnlYxKfYRAf/rJfiGdQGKh4L6SiZAtuj3dSJspujaEcjN5m3YpmBzaFCx
	 FvNRMkY6kXm26jHEmkUecUG2FwDZxm2e/nNqYywoHUIitDGYts+yJbUE68YMy68wkf56F
	 IoURt713nCujP8H7aZm29P/88CgJFdqEw3/4oSAgh0+jC7wy+TwEbASSVpNyZHvbYJgbQ
	 wVcxYJQI5Dwgt7PqSVZ0VZXj+HiSwX11Kws26wvPAv8bRUwR9Zkz+UCVdqtN19TJbAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479819;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mQOzi/AaGUN2LLStWaDBGp6mIFFtRvMsQoOA5hxwfKY=;
	b=gBaswrjzz6GRXCAM+q0WvA2GLjLR+so3Thlcn/KZUu3N3OM8LSQgUniU1odTGjyG/Vnv
	 Qb3UkmPWUzKV+IhJ9kPYLoDIOvT4AMfkalNLTPVPuVLusRTMdJUVA8f/QtHXYcauFiHRh
	 U93uQBuFXBvT0lonMowXxgVbeyzuZjfkNIyM2xjDjlLP+my78fjgtRlU3zJQAzcXdKzFk
	 Oq7rf9zuSMlLZjjokZAUHGi/VxHmzlBnKwM5ALL9H8AwnwMQDBgsc6hy14ezjTMFU5Vyd
	 9uxFDJbSWDYyqvjPDr2lqWwK+leeJmyNkwziSfK28rFH5XWgvAniompx6Ixf47+NsTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AW8gwmUV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE18606C7A5;
	Tue, 24 Nov 2026 00:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AW8gwmUV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43AC41F000C6;
	Tue, 24 Nov 2026 00:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479819;
	bh=mQOzi/AaGUN2LLStWaDBGp6mIFFtRvMsQoOA5hxwfKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AW8gwmUVqDqO0fSEn5Yns1ryoSIjXjupJ/Eanptv6ZuusGu4sCxcxW2yckrdUyAp8
	 NcBpBEqSCGK0LlMYUJMQOcUf4ghcIE8gcJZ4gjJzglh58SfyUCXCrXFigE0Vtgeb/W
	 Eo4ZTeQE7VAKWyGuInkszi1Q5IqOBEtqw+kv069Wdu3CG0e7Q8/0t18jWirzaP9XMl
	 CVnxLDHrbE9ugDQuwx+yGqIUTxDKUwU+BYB2AO63Jf56aQI2iKyAmc4HMG82E8DEYX
	 olwfrNSf2eaHfxN5KdTS39mFfU9GD47uyUVLZgqC+abz4YNZMULcFPVDrxvGs2Noe/
	 SbVBAgTBoPYGw==
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
Subject: [RFC PATCH 21/26] KVM: x86/pmu: Make loading/putting the mediated PMU context idempotent
Date: Tue, 24 Nov 2026 00:22:58 +0000
Message-ID: <20261124002303.1785363-22-yosry@kernel.org>
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

Make kvm_mediated_pmu_load() and kvm_mediated_pmu_put() bail if the
guest context is already loaded or put, respectively, in preparation for
leaving the guest context loaded across slowpath VM-Exits.
kvm_mediated_pmu_load() will still be called on every vcpu_enter_guest(),
even if the guest context is still loaded, and kvm_mediated_pmu_put()
will be called from multiple paths, e.g. on slowpath VM-Exits, on
vcpu_put(), and when perf reclaims the mediated PMU, any of which may
find the guest context already put.

Checking the per-CPU state is sufficient, as only the running vCPU's
guest context can be loaded on a CPU: it is put on vcpu_put() before
another vCPU can run.

Move lockdep_assert_irqs_disabled() before the checks, so that callers
are verified to have IRQs disabled even if loading/putting is skipped.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/pmu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index e92a7a1f20a89..d56cd0fa817d7 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -1420,11 +1420,12 @@ void kvm_pmu_sync_lvtpc(struct kvm_vcpu *vcpu, u32 lvtpc)
 
 void kvm_mediated_pmu_load(struct kvm_vcpu *vcpu)
 {
-	if (KVM_BUG_ON(!lapic_in_kernel(vcpu), vcpu->kvm))
-		return;
-
 	lockdep_assert_irqs_disabled();
 
+	if (is_guest_mediated_pmu_loaded() ||
+	    KVM_BUG_ON(!lapic_in_kernel(vcpu), vcpu->kvm))
+		return;
+
 	perf_load_guest_context();
 
 	/*
@@ -1480,11 +1481,12 @@ static void kvm_pmu_put_guest_pmcs(struct kvm_vcpu *vcpu)
 
 void kvm_mediated_pmu_put(struct kvm_vcpu *vcpu)
 {
-	if (KVM_BUG_ON(!lapic_in_kernel(vcpu), vcpu->kvm))
-		return;
-
 	lockdep_assert_irqs_disabled();
 
+	if (!is_guest_mediated_pmu_loaded() ||
+	    KVM_BUG_ON(!lapic_in_kernel(vcpu), vcpu->kvm))
+		return;
+
 	/*
 	 * Defer handling of PERF_GLOBAL_CTRL to vendor code.  On Intel, it's
 	 * atomically cleared on VM-Exit, i.e. doesn't need to be clear here.
-- 
2.56.1.809.ga0b61035b5-goog

