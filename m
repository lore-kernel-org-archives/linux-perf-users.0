Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BD54218B0
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 21:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777929534; cv=none; b=QFSgzgo0a9/EYpRMsQmLVb6sFsz/3id+POiYk0ko44JKz+ZXxMAPGHvzyXtC8N/fi2LRFYs4Es7FNHYmyIjVavHYuZqfc2qD4upspOh1fsn0YlqBNI/MwI8LE+n5wf+0aqSWJngwC3PxEgN5vaU9S7lzwDayWTgxDg2FktBt05E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777929534; c=relaxed/simple;
	bh=fWZg9y5aLAFSBW2MiwOhHFnYu+Ty84504Z5PuiRS96o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=de7cS89h8ww7+SLV9a66h18k3lNBtnNO8i6dJS0Ppy6+7uq2CTV4hl15tWnzIOgwRywkjV26DIb44gaWub7HbY8NPyFM64ejE7iY+TyNYLILswGZp7Ava7tRxnu+yuZBsOU0F+8eUPOhlPSnWkGDmiccQQ5Z+D8Fdt4aKSJXOoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I7+RVT59; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I7+RVT59"
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-7dcd603855aso9860924a34.0
        for <linux-perf-users@vger.kernel.org>; Mon, 04 May 2026 14:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777929525; x=1778534325; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vvvExWFpSdxF1U5r97vObpZLpBpbjqEmnZt44hIldRo=;
        b=I7+RVT594HzAjLodptZF7ldu0HiqJ25zvNcbD51VDkRdkubXJjQJohPbAmtyjlr6wS
         2do8Pgx5lU0wGmeG7gWViK0l3Q7nC0TZ7g2dBTkVrl5X89JAnMPxp/WXYbziCXPLVQ7n
         sRO/UlUuKaKfk57DVw0yV/TAPvRMuLZKLP50Afbghhb0ZLYSoOL4FC9sENi+7OTBISJ6
         Y7RDmLXLz4wU6ZMSLXfsxWBQr9tHoRq2T/YQMS9aw8otlFLengTBcAESp05TaMhGlILc
         qUn0rk19sODgNrQivabAeSAkz2FHI/7kzqVjuOUFMWJ3RxbLZcL7eem02wWnxdzLHqu4
         ZpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777929525; x=1778534325;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vvvExWFpSdxF1U5r97vObpZLpBpbjqEmnZt44hIldRo=;
        b=Xruui7YygEZBRd12MyZzpXzcqByE05BC3EaASiAye+d0xEx1M7XLJOLV2ESd41Czcd
         0vF0HpCMt9ipe92qARuR92SO70KXnq5wrX27ATuoKd6t9a9Yw/Ic38QnDoWJQ/l43W6z
         etUn7etluynaWhoj68pQ5Hpb+wvbaaxfCgEuRU459p6WUpMp954E0m8Y79nm7m6bV1Gf
         /kMJipvGbUBh/yaZyS89bbczGU57hx5qvKCWt79zIEEoiaQFyQ4YS4CFJzZPWsRQcnCZ
         fTwcdXzHF/GSGj3leDIQ3gz+db1sOKzGMJPp8aEWq6LS7A3mT+Yww51TeFMJ3KPwnuog
         jitw==
X-Forwarded-Encrypted: i=1; AFNElJ/Kt4po65SFzILFBF2x3OpCsp2OGZykgMj6D+mzI4fW+zwEJYqr7hlAFxvMof3S7N7vY5Yfu2nXSNbebS7s+yqS@vger.kernel.org
X-Gm-Message-State: AOJu0YxeLdTB4t70ZPyZrS0JsnBByFXWv5LuCjC2GQ7CSa25U7x6naaZ
	UKC/0V/33Shn9jE+dPEI5rg7trRGIqh3Z7w3qk3PEHreiBt88vVIG3mUlhVjaozdbVRSrQusHSA
	aOjk5UKLTDUj8IBw+Qz9RR635gg==
X-Received: from ilpy14.prod.google.com ([2002:a92:c74e:0:b0:4fe:8f5f:a030])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:2b03:b0:693:7a6f:b311 with SMTP id 006d021491bc7-6989150d84emr387036eaf.22.1777929525215;
 Mon, 04 May 2026 14:18:45 -0700 (PDT)
Date: Mon,  4 May 2026 21:18:06 +0000
In-Reply-To: <20260504211813.1804997-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504211813.1804997-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504211813.1804997-14-coltonlewis@google.com>
Subject: [PATCH v7 13/20] KVM: arm64: Apply dynamic guest counter reservations
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Alexandru Elisei <alexandru.elisei@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Mingwei Zhang <mizhang@google.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Shuah Khan <shuah@kernel.org>, Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, 
	James Clark <james.clark@linaro.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Apply dynamic guest counter reservations by checking if the requested
guest mask collides with any events the host has scheduled and calling
pmu_perf_resched_update() with a hook that updates the mask of
available counters in between schedule out and schedule in.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/pmu-direct.c  | 69 ++++++++++++++++++++++++++++++++++++
 include/linux/perf/arm_pmu.h |  1 +
 2 files changed, 70 insertions(+)

diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
index 2252d3b905db9..14cc419dbafad 100644
--- a/arch/arm64/kvm/pmu-direct.c
+++ b/arch/arm64/kvm/pmu-direct.c
@@ -100,6 +100,73 @@ u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu)
 	return *host_data_ptr(nr_event_counters);
 }
 
+/* Callback to update counter mask between perf scheduling */
+static void kvm_pmu_update_mask(struct pmu *pmu, void *data)
+{
+	struct arm_pmu *arm_pmu = to_arm_pmu(pmu);
+	unsigned long *new_mask = data;
+
+	bitmap_copy(arm_pmu->cntr_mask, new_mask, ARMPMU_MAX_HWEVENTS);
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
+	bool need_resched = false;
+
+	bitmap_from_arr64(guest_bitmap, &guest_mask, ARMPMU_MAX_HWEVENTS);
+	bitmap_copy(new_mask, cpu_pmu->hw_cntr_mask, ARMPMU_MAX_HWEVENTS);
+
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
+					pr_warn_ratelimited("perf: Pinned host event squeezed out by KVM guest PMU partition\n");
+					break;
+				}
+			}
+		}
+	} else {
+		/*
+		 * Restoring to hw_cntr_mask.
+		 * Only resched if we previously squeezed an event.
+		 */
+		if (cpuc->host_squeezed) {
+			need_resched = true;
+			cpuc->host_squeezed = false;
+		}
+	}
+
+	if (need_resched) {
+		/* Collision: run full perf reschedule */
+		perf_pmu_resched_update(&cpu_pmu->pmu, kvm_pmu_update_mask, new_mask);
+	} else {
+		/* Host was never using guest counters anyway */
+		bitmap_copy(cpu_pmu->cntr_mask, new_mask, ARMPMU_MAX_HWEVENTS);
+	}
+}
+
 /**
  * kvm_pmu_host_counter_mask() - Compute bitmask of host-reserved counters
  * @pmu: Pointer to arm_pmu struct
@@ -218,6 +285,7 @@ void kvm_pmu_load(struct kvm_vcpu *vcpu)
 
 	pmu = vcpu->kvm->arch.arm_pmu;
 	guest_counters = kvm_pmu_guest_counter_mask(pmu);
+	kvm_pmu_set_guest_counters(pmu, guest_counters);
 	kvm_pmu_apply_event_filter(vcpu);
 
 	for_each_set_bit(i, &guest_counters, ARMPMU_MAX_HWEVENTS) {
@@ -319,5 +387,6 @@ void kvm_pmu_put(struct kvm_vcpu *vcpu)
 	val = read_sysreg(pmintenset_el1);
 	__vcpu_assign_sys_reg(vcpu, PMINTENSET_EL1, val & mask);
 
+	kvm_pmu_set_guest_counters(pmu, 0);
 	preempt_enable();
 }
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index f7b000bb3eca8..63f88fec5e80f 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -75,6 +75,7 @@ struct pmu_hw_events {
 
 	/* Active events requesting branch records */
 	unsigned int		branch_users;
+	bool host_squeezed;
 };
 
 enum armpmu_attr_groups {
-- 
2.54.0.545.g6539524ca2-goog

