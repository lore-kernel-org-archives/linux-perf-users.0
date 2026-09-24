Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85F64BD7AF
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271003; cv=none; b=lCkIUs//YtehF8ZgAHiQ/xteXDMHWIEQ5yRd6c2Mle8R0pr8YsyZdRyIsj8vSbuhfdPCc8u7uyHpOSAW8QKqdvUvE3PTPPtOtAuhPGAhP6r73C5gbYeZySKLW5+5edW4oc8gIrIcWwmsLJ4R1h6LyFG7woTuYRtYmr/9YDmiD4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271003; c=relaxed/simple;
	bh=IN31WrfS1s8qFktZQMlnwARlViS4koxlqeS4XeefkuQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kAlPa46v1uRItdhVB4C/D9aB8YlJ+JT0TQvPiRCcqr54Nhaw8MqhHmhF816plsZxeQiLqGThmlnUhaA0xSJiszAaBZx513/j1l6OvyAa90yGyxRJspvWX7R82zpRdrOIvXDpYe2hq9yxuReb7g98jxUdw3x85BCwd94Z7WJAyok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oqBMrg9X; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oqBMrg9X"
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4a41f46d629so215450b6e.3
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 10:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790270994; x=1790875794; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ly1RhTg1DzFLFPcD4bZskzHIIlqyteQE9EzO1zay/Fc=;
        b=oqBMrg9XrCsqJqn3PcCj9pfde5PRmv5sWBdpZVfDUUmEqErryEFKGUrHJQzBSQ5cOG
         6zv0JWE6ObwwqjhHPqVuN5sXilJmomZkLfMAwN7NlrDWfCcKWqefUswd7ZxK4ah3Qk1c
         KeG98O7vxRS1GHCWy4K2mgxbKsP2PZWIwU/GujBI6wtWph29US9OeedQy6Ne1oM+e16l
         Z8K2aXLDcE7VvYcu/LYWJR+eEsOH0iqklZLmoIQJ9+bzhnU0XQzfbqfSW1+yMC/k2gOP
         I/IX/sCa/cQ3Zwfmxs8bj5u7K7r+f+FwtIw4MIcre44zZPcxhTUruqjPr4KGrPAPXaJ/
         i+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790270994; x=1790875794;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ly1RhTg1DzFLFPcD4bZskzHIIlqyteQE9EzO1zay/Fc=;
        b=BJvyny6rpozIYcxsqMnRdLK5B6u14YbZngJFwiran2vfPKJdXvRFrd0GiYydSMAyPG
         jLKMUEMlEMh3t/wGVgEkDge7HnYP3PxlYuyj9o1NAIKtQNE/XKm9mgVKKPLOO/+1G4oG
         xYlPVyJAKYQmpk76VbJKHGpGCdDNQycYqSk3uo4ZPixjhggHCQWIOwniQNh5FvaSIANP
         BCEgh/GNC/GZoY2PrsoNxSHfkR5sS2FYGfxHAcu2VXszaMaTd31h31f9pNawvJDiNOUS
         5kbHKj1NAwdVKJe3Uqr4KGX32Oyl8G2ZN5yo+WgfENVNKqfhG5xlRLs5bZzwUZeQvERd
         s9qA==
X-Forwarded-Encrypted: i=1; AKwUvBwZxzUB7v+hU1gZyB79DJfxssPzhtsfcQpmlfwtsyNkroReRexT2m2z1xSV4STOIQze6Bvuu2//qbtFjK6FF0E9@vger.kernel.org
X-Gm-Message-State: AFuF++nZUwmOdPJgSc7kb6pKwo8EKDri0gFx6MAwGJzEdpoyyiY5u/W/
	i2ZtOpqK0eBEs9CPHhJE7XNIi1DncBHEFKgdqlAC/p7SfB1eGzpGjwYYSx9wA2py9Q/OIf4QqhJ
	v3UybEus60nTG4aTPdtkNmxKIug==
X-Received: from iofj3.prod.google.com ([2002:a05:6602:7083:b0:9af:289c:476c])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:80b1:b0:4b9:e65b:8c2b with SMTP id 5614622812f47-4d72931dd72mr3225441b6e.25.1790270994011;
 Thu, 24 Sep 2026 10:29:54 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:29:22 +0000
In-Reply-To: <20260924172928.2110956-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924172928.2110956-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924172928.2110956-17-coltonlewis@google.com>
Subject: [PATCH v9 16/22] KVM: arm64: Apply dynamic guest counter reservations
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	James Clark <james.clark@linaro.org>, Robin Murphy <robin.murphy@arm.com>, 
	Zide Chen <zide.chen@intel.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Mingwei Zhang <mizhang@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, Shuah Khan <shuah@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Reserve and release guest PMU counters dynamically during vCPU load and
put rather than statically at VM creation.

Add kvm_pmu_set_guest_counters() in arch/arm64/kvm/pmu-direct.c, called
from kvm_pmu_load() and kvm_pmu_put(). When the requested guest counter
mask collides with active host events in cpuc->used_mask (or when
releasing counters after squeezing a host event), invoke
perf_pmu_resched_update() with kvm_pmu_update_mask() to update the
per-CPU cpuc->cntr_mask between scheduling host events out and back in;
otherwise update cpuc->cntr_mask directly with interrupts disabled.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/pmu-direct.c  | 77 ++++++++++++++++++++++++++++++++++++
 include/linux/perf/arm_pmu.h |  1 +
 2 files changed, 78 insertions(+)

diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
index a22c9258c2452..31d5afc44f36e 100644
--- a/arch/arm64/kvm/pmu-direct.c
+++ b/arch/arm64/kvm/pmu-direct.c
@@ -115,6 +115,77 @@ u64 kvm_pmu_direct_pmcr_read(struct kvm_vcpu *vcpu)
 		ARMV8_PMU_PMCR_N);
 }
 
+/* Callback to update counter mask between perf scheduling */
+static void kvm_pmu_update_mask(struct pmu *pmu, void *data)
+{
+	struct arm_pmu *arm_pmu = to_arm_pmu(pmu);
+	struct pmu_hw_events *cpuc = this_cpu_ptr(arm_pmu->hw_events);
+	unsigned long *new_mask = data;
+
+	bitmap_copy(cpuc->cntr_mask, new_mask, ARMPMU_MAX_HWEVENTS);
+}
+
+/**
+ * kvm_pmu_set_guest_counters() - Handle dynamic counter reservations
+ * @cpu_pmu: struct arm_pmu to potentially modify
+ * @guest_mask: new guest mask for the pmu
+ *
+ * Check if guest counters will interfere with current host events and
+ * call into perf_pmu_resched_update if a reschedule is required.
+ */
+static void kvm_pmu_set_guest_counters(struct arm_pmu *cpu_pmu, u64 guest_mask)
+{
+	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
+	DECLARE_BITMAP(guest_bitmap, ARMPMU_MAX_HWEVENTS);
+	DECLARE_BITMAP(new_mask, ARMPMU_MAX_HWEVENTS);
+	unsigned long flags;
+	bool need_resched = false;
+
+	bitmap_from_arr64(guest_bitmap, &guest_mask, ARMPMU_MAX_HWEVENTS);
+	bitmap_copy(new_mask, cpu_pmu->cntr_mask, ARMPMU_MAX_HWEVENTS);
+
+	local_irq_save(flags);
+	if (guest_mask) {
+		/* Subtract guest counters from available host mask */
+		bitmap_andnot(new_mask, new_mask, guest_bitmap, ARMPMU_MAX_HWEVENTS);
+
+		/* Did we collide with an active host event? */
+		if (bitmap_intersects(cpuc->used_mask, guest_bitmap, ARMPMU_MAX_HWEVENTS)) {
+			int idx;
+
+			need_resched = true;
+			cpuc->host_squeezed = true;
+
+			/* Look for pinned events that are about to be preempted */
+			for_each_set_bit(idx, guest_bitmap, ARMPMU_MAX_HWEVENTS) {
+				if (test_bit(idx, cpuc->used_mask) && cpuc->events[idx] &&
+				    cpuc->events[idx]->attr.pinned) {
+					pr_warn_once("perf: Pinned host event squeezed out by KVM guest PMU partition\n");
+					break;
+				}
+			}
+		}
+	} else {
+		/*
+		 * Restoring to full mask.
+		 * Only resched if we previously squeezed an event.
+		 */
+		if (cpuc->host_squeezed) {
+			need_resched = true;
+			cpuc->host_squeezed = false;
+		}
+	}
+	if (!need_resched)
+		/* Host was never using guest counters anyway */
+		bitmap_copy(cpuc->cntr_mask, new_mask, ARMPMU_MAX_HWEVENTS);
+	local_irq_restore(flags);
+
+	if (need_resched) {
+		/* Collision: run full perf reschedule */
+		perf_pmu_resched_update(&cpu_pmu->pmu, kvm_pmu_update_mask, new_mask);
+	}
+}
+
 /**
  * kvm_pmu_host_counter_mask() - Compute bitmask of host-reserved counters
  *
@@ -255,6 +326,7 @@ static void kvm_pmu_apply_event_filter(struct kvm_vcpu *vcpu)
  */
 void kvm_pmu_load(struct kvm_vcpu *vcpu)
 {
+	struct arm_pmu *pmu;
 	unsigned long guest_counters;
 	u64 mask;
 	u8 i;
@@ -269,7 +341,9 @@ void kvm_pmu_load(struct kvm_vcpu *vcpu)
 
 	preempt_disable();
 
+	pmu = vcpu->kvm->arch.arm_pmu;
 	guest_counters = kvm_vcpu_pmu_guest_counter_mask(vcpu);
+	kvm_pmu_set_guest_counters(pmu, guest_counters);
 	kvm_pmu_apply_event_filter(vcpu);
 
 	for_each_set_bit(i, &guest_counters, ARMPMU_MAX_HWEVENTS) {
@@ -329,6 +403,7 @@ void kvm_pmu_load(struct kvm_vcpu *vcpu)
  */
 void kvm_pmu_put(struct kvm_vcpu *vcpu)
 {
+	struct arm_pmu *pmu;
 	unsigned long guest_counters;
 	unsigned long flags;
 	u64 mask;
@@ -345,6 +420,7 @@ void kvm_pmu_put(struct kvm_vcpu *vcpu)
 
 	preempt_disable();
 
+	pmu = vcpu->kvm->arch.arm_pmu;
 	guest_counters = kvm_vcpu_pmu_guest_counter_mask(vcpu);
 	mask = guest_counters;
 
@@ -395,5 +471,6 @@ void kvm_pmu_put(struct kvm_vcpu *vcpu)
 	write_sysreg(val & mask, pmovsclr_el0);
 	local_irq_restore(flags);
 
+	kvm_pmu_set_guest_counters(pmu, 0);
 	preempt_enable();
 }
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index be1e345e99a77..45658273ffa86 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -76,6 +76,7 @@ struct pmu_hw_events {
 
 	/* Active events requesting branch records */
 	unsigned int		branch_users;
+	bool host_squeezed;
 };
 
 enum armpmu_attr_groups {
-- 
2.56.0.rc1.310.g51773c2048-goog

