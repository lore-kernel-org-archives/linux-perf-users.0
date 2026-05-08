Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0928A3BF666
	for <linux-perf-users@vger.kernel.org>; Fri,  8 May 2026 23:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778282047; cv=none; b=iVqxACHnyTra9OZdffYywbA0QT8z2CGbNmlhqDCy7xm1QwJhO8nVK+a7zTGOHPqAwYxwO9v5PqKBtVq45YO4qIIS2MurNxd3+xqVj0zZvpgkSQ/lKJbeAs8n3spPrf4cyIzbwFi2rNyLRom9ZjUDlupaspc+K6nkvVpbmGXGtuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778282047; c=relaxed/simple;
	bh=QUSnhE9ck70LWBa0E8tFu6PQQvS6B9ynchkFpZ3LobQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aaqtDWJAxs4u4IrroBsKgUbmfTdqWoNqUW9SNtp3OYGvNqNOGtjAgFjoE9qb7NOyXtVS3SE0TuKpPSf3Qcov6ufwR7oeEy7vWtP4iqMjGIAL3GnelzcNdQePT98z35kdOGCZoDWreO9Em+2CPl8MLAGmVcLmZFxWt2ycfZ56IRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VFoSOovv; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VFoSOovv"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-354c44bf176so3011159a91.0
        for <linux-perf-users@vger.kernel.org>; Fri, 08 May 2026 16:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778282045; x=1778886845; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Tth6ytDURza4+B9GhJKjukpnUFdXZZplI0rD3xV9jqc=;
        b=VFoSOovvx+lQu5yRR8Ucn0k5rXbEXku8B0lKbcTUvMd/74jTt/BsXl30jXOEjqplNI
         tQMxysvypgHU+VljU0tJznwQvOXVwc1Pe3OyJe96cS+xfcMumsVpesOZbtv9IKJfWOj5
         p6vnn87RFsaQGGpKLFFN8oA3s2BRHDLLpcJN/wEinhlQfL5/gCQzdt0ZlEjn7GTKxfTk
         3ObVKeSIgqsQh1rm5y5v68T1aSG9lJeDKj7+mgDriCiJJ/7cM5qWMWxwFHWXAkdcJtm/
         gQkQddQ1VzkM+df6eEvaa8yQQcC6VlYGRY6s0+3rUPc+EC+qDbpUxjlwD/JmmugTyMtG
         fZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778282045; x=1778886845;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tth6ytDURza4+B9GhJKjukpnUFdXZZplI0rD3xV9jqc=;
        b=Uv+daklA4ih5gsV7CEmlv9Yya05b8YJDnwDFOCIn9WViqw6IHAlNakTc0a2qP9crnA
         szylQeUk7X9vpHVtm6seEn+WSXaGIHOXERz5zWBN1Vz6dWqjkGiCyakcaOoEdZVWUUZz
         T4xX9rYNg05JPbrmNH6WDzSDGNBtODuYn4WG+GFUB0i9p8WCcNsXqF91FAf6cjeAQWC6
         ecjvYxcJFHrGMZBdDn5fyfVmGvDECc031ZMZBE7xqBSk7pPl3LvqbtykU2yKMbKzpBTr
         YK07mDn9r7zV7rC0rjjA4THz7neBa7OTA5hCS1ED4FMUq717FHfUzlTVix4FJtAkp5nr
         ZIfw==
X-Forwarded-Encrypted: i=1; AFNElJ9JJ/BC72HC+jw+W6iA4jEqzwgqveuagEIYMSLbir5XJbOrEXC4Q5UO0bCx8/mscfWus/ITI9z2YVhyD0sy+RML@vger.kernel.org
X-Gm-Message-State: AOJu0YyS3X3KiRaLBXm6eTmVPLREkW56j6JYv8qz6F8QjwdVGPSjHoMS
	TpGa3h2uoTGmCUiv+trz/rY+XZ+vttuF7t/azVUa5Sv8sc7erIw3dGo8/CAyFGXd9rlxM9nfhKy
	2efBu/g==
X-Received: from pgne29.prod.google.com ([2002:a63:745d:0:b0:c79:81df:1175])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5683:b0:359:87a8:e65c
 with SMTP id 98e67ed59e1d1-365ac080573mr15363603a91.17.1778282045290; Fri, 08
 May 2026 16:14:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  8 May 2026 16:13:53 -0700
In-Reply-To: <20260508231353.406465-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508231353.406465-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508231353.406465-10-seanjc@google.com>
Subject: [PATCH v3 9/9] KVM: VMX: Only tell perf to enable PEBS counters for
 fully enabled PMCs
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Stephane Eranian <eranian@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

When passing the guest's requested PEBS_ENABLE (or rather, KVM's version
of PEBS_ENABLE on behalf of the guest), omit counters that are locally
disable and/or don't have a perf event (due to contention), in addition to
omitting counters that are cross-mapped in the host.

In practice, this should be a nop as perf will already have disabled the
associated counter, i.e. cpuc->pebs_enabled should have been cleared, but
paranoia is cheap, and the existing code _looks_ wrong.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 30 ++++++++++++++++--------------
 arch/x86/kvm/vmx/vmx.c       | 11 +----------
 arch/x86/kvm/vmx/vmx.h       | 15 ++++++++++++++-
 3 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 659fe097b904..1e420c8bca9d 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -736,34 +736,36 @@ static void intel_pmu_cleanup(struct kvm_vcpu *vcpu)
 		intel_pmu_release_guest_lbr_event(vcpu);
 }
 
-u64 intel_pmu_get_cross_mapped_mask(struct kvm_pmu *pmu)
+u64 __intel_pmu_compute_pebs_enable(struct kvm_pmu *pmu)
 {
-	u64 host_cross_mapped_mask;
+	u64 guest_pebs_enable = pmu->pebs_enable & pmu->global_ctrl;
+	u64 pebs_enable = 0;
 	struct kvm_pmc *pmc;
 	int bit, hw_idx;
 
 	/*
-	 * Provide a mask of counters that are cross-mapped between the guest
-	 * and the host, i.e. where a guest PMC is mapped to a host PMC with a
-	 * different index.  PEBS records hold a PERF_GLOBAL_STATUS snapshot,
-	 * and so PEBS-enabled counters need to hold the correct index so as
-	 * not to confuse the guest.
+	 * Omit counters that are locally disabled, don't have a perf event, or
+	 * ended up with a perf event that is using a different counter than
+	 * the guest, i.e. where the guest PMC is different than the host PMC
+	 * being used on behalf of the guest.  PEBS records include
+	 * PERF_GLOBAL_STATUS, and so using a counter with a different index
+	 * means the guest will see overflow status for the wrong counter(s).
 	 */
-	host_cross_mapped_mask = 0;
-
-	kvm_for_each_pmc(pmu, pmc, bit, (unsigned long *)&pmu->global_ctrl) {
+	kvm_for_each_pmc(pmu, pmc, bit, (unsigned long *)&guest_pebs_enable) {
 		if (!pmc_is_locally_enabled(pmc) || !pmc->perf_event)
 			continue;
 
 		/*
-		 * A negative index indicates the event isn't mapped to a
+		 * Note, a negative index indicates the event isn't mapped to a
 		 * physical counter in the host, e.g. due to contention.
 		 */
 		hw_idx = pmc->perf_event->hw.idx;
-		if (hw_idx != pmc->idx && hw_idx > -1)
-			host_cross_mapped_mask |= BIT_ULL(hw_idx);
+		if (hw_idx != pmc->idx)
+			continue;
+
+		pebs_enable |= BIT_ULL(pmc->idx);
 	}
-	return host_cross_mapped_mask;
+	return pebs_enable;
 }
 
 static bool intel_pmu_is_mediated_pmu_supported(struct x86_pmu_capability *host_pmu)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index fbe3ce5f5a51..31675e5cf563 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7314,20 +7314,11 @@ static void atomic_switch_perf_msrs(struct vcpu_vmx *vmx)
 		return;
 
 	struct x86_guest_pebs guest_pebs = {
-		.enable = pmu->pebs_enable,
+		.enable = intel_pmu_compute_pebs_enable(pmu),
 		.ds_area = pmu->ds_area,
 		.data_cfg = pmu->pebs_data_cfg,
 	};
 
-	/*
-	 * Disable counters where the guest PMC is different than the host PMC
-	 * being used on behalf of the guest, as the PEBS record includes
-	 * PERF_GLOBAL_STATUS, i.e. the guest will see overflow status for the
-	 * wrong counter(s).
-	 */
-	if (guest_pebs.enable & pmu->global_ctrl)
-		guest_pebs.enable &= ~intel_pmu_get_cross_mapped_mask(pmu);
-
 	/* Note, nr_msrs may be garbage if perf_guest_get_msrs() returns NULL. */
 	msrs = perf_guest_get_msrs(&nr_msrs, &guest_pebs);
 	if (!msrs)
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 0c4563472940..b055731efd2d 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -659,7 +659,20 @@ static __always_inline struct vcpu_vmx *to_vmx(struct kvm_vcpu *vcpu)
 	return container_of(vcpu, struct vcpu_vmx, vcpu);
 }
 
-u64 intel_pmu_get_cross_mapped_mask(struct kvm_pmu *pmu);
+u64 __intel_pmu_compute_pebs_enable(struct kvm_pmu *pmu);
+
+static inline u64 intel_pmu_compute_pebs_enable(struct kvm_pmu *pmu)
+{
+	/*
+	 * Avoid the function call overhead in the common case that the guest
+	 * isn't using PEBS.
+	 */
+	if (!(pmu->pebs_enable & pmu->global_ctrl))
+		return 0;
+
+	return __intel_pmu_compute_pebs_enable(pmu);
+}
+
 int intel_pmu_create_guest_lbr_event(struct kvm_vcpu *vcpu);
 void vmx_passthrough_lbr_msrs(struct kvm_vcpu *vcpu);
 
-- 
2.54.0.563.g4f69b47b94-goog

