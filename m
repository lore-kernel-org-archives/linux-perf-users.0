Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B315F5158A8
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 19:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018074; cv=none; b=BvFUoT4c0xIJNN962wT6KW2HDSeKZoFM25AnsblkB5o/EDieOB0MgzbDWzXMyMkbJiNZq5xgscGp7NkGLTfHNJKPR9QTB0yiB9w2xrTTYjTwcRTjZrXzO6EfcMa3/0KGZQ0VyXYVDlkVf/DbCYW0no2B+1Wxye7BFS/901Q6MI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018074; c=relaxed/simple;
	bh=yQyUCvXgCTKSDHTiDA7xPhq5TbGRGnImWydXeQVvkAk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nSFWUwPBfhWs15w8Pv2BnQpYaKg31ctF+a/FQLDKMrWBfIWIcYXsVhcKEneMhvl3zzEZ6PE5vsIO8+1wAuj7HeBjW6KQ4n56+sewHnbwM284oSjga914Zoesy9KqbpJtobwaRXAgbEJ9dZzvc1tAbMwYwZ2qxYpblkHGiW8dg8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FRg2wr0b; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FRg2wr0b"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-86b3c58d686so6879025b3a.3
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 12:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790018071; x=1790622871; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=blyc7W90tCE2hYz98LJODWSBqsvdm4nd3UjPM9vihBM=;
        b=FRg2wr0bRZWIuBrVWpTdBHpXMPGsWeqFzTk9y8Fikgkp6E15bEkF1gwi5RZwMfCjrH
         HpV7urJ0b9rrFMhMCxifRHx85HDZ2om+KHotmdPzDsUOQiI26xMD3k6CCsG7B9WpZfTo
         efLLcmoMtIdVE4cShD97MA7IhCrgawrRuo6aFlhKTZ83aQKtHzkfsTlwxFn4rwyFieZn
         j+OsiCUmUYX7ZnFVFa0nSY4kOIjXvH8VeeZKF/ioeWLobFUi6YpomvK4OjGVzEwLk8ii
         U4kVBZWXnjx19d5/woplEb2l8rmP7ZOTuk91BCxshMWGP19U8KnsPLhJ7u/xzuQm5zE7
         MEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790018071; x=1790622871;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=blyc7W90tCE2hYz98LJODWSBqsvdm4nd3UjPM9vihBM=;
        b=q6+c27rZrnPFTRyetRPBXuOgZp3qLxSeS94j8IcQfLafSW1XTwW3wheWsHOaynjvMv
         f/fPiUWV9s0UAUlFTVkU9tDkOLHQtFeWL3ieJBa2P4tqBCv5bOL/nlj5iMxtvVMKwQRy
         ySi6LzojS9ARXoUzN5g/bUh8+/Egua5yvbHAXR875r0zWZk9ZNu25Nf3dJUW80VXwipl
         CUuOO5KcwSxW66W3WKpLkcVbm0qS174MD/M18UCYD/kohEdrTHTbYcc6WmD7lHk0urrG
         ihK0as/bwZD3FRr6vcJh1emmCIzRuGMxg9ciF4IFEB5kq7jSKNY3ltBL5sODaTv8krQU
         S+YQ==
X-Forwarded-Encrypted: i=1; AKwUvBykvrBHEiCUv3Nh9U4kQUqIPeIua8yCdbb9iC+xbpiHMZMf3UHJ/nVn3AwJCm0Jm2exlmXwg7p+fWgKXLhmZZ83@vger.kernel.org
X-Gm-Message-State: AFuF++kGNx5HQZI8VDeHStNqWn8MSH/GINYWvfw5pjIaWPd2AB24/o4U
	eG0MS6RTKAARhYPorcGh2t9x47iSGwoXvHpG4O8AoKfq91DRefPQo+3WXlpRdFT4Z+SUZNd25Dl
	R4EdoRw==
X-Received: from pfrb17.prod.google.com ([2002:aa7:8ed1:0:b0:86d:adb4:abb8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:124c:b0:873:2525:9a00
 with SMTP id d2e1a72fcca58-874d8b82281mr15799924b3a.0.1790018070774; Mon, 21
 Sep 2026 12:14:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 12:14:17 -0700
In-Reply-To: <20260921191418.950933-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921191418.950933-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921191418.950933-10-seanjc@google.com>
Subject: [PATCH v4 09/10] KVM: VMX: Only tell perf to enable PEBS counters for
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Jim Mattson <jmattson@google.com>, 
	Mingwei Zhang <mizhang@google.com>, Stephane Eranian <eranian@google.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

When passing the guest's requested PEBS_ENABLE (or rather, KVM's version
of PEBS_ENABLE on behalf of the guest), omit counters that are locally
disable and/or don't have a perf event (due to contention), in addition to
omitting counters that are cross-mapped in the host.

In practice, this should be a nop as perf will already have disabled the
associated counter, i.e. cpuc->pebs_enabled should have been cleared, but
paranoia is cheap, and the existing code _looks_ wrong.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 30 ++++++++++++++++--------------
 arch/x86/kvm/vmx/vmx.c       | 11 +----------
 arch/x86/kvm/vmx/vmx.h       | 15 ++++++++++++++-
 3 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 040b8e80cf86..472cf51298b4 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -747,34 +747,36 @@ static void intel_pmu_cleanup(struct kvm_vcpu *vcpu)
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
index 8f7d0620f44c..2d0443562a16 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7364,20 +7364,11 @@ static void atomic_switch_perf_msrs(struct vcpu_vmx *vmx)
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
index 5c4e2cf6256c..1db461060c7e 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -664,7 +664,20 @@ static __always_inline struct vcpu_vmx *to_vmx(struct kvm_vcpu *vcpu)
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
2.55.0.1082.g2b9226bbc0-goog

