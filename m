Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E16F472544
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785942153; cv=none; b=QVJYRgymjEAZ4MCUojL/0IyS1EI5pdsSc+d3kcpn1YdBsprnZHGknIsAb2pkz0ulW8Zin/b0dmPye5GBm8XZPQF0xcSNg9ytSHWHUPr3USQQr3JZGSMZNTeyeivbHakPdwdzeggS5pwqU60Kf0VmPCEYGnoyFn4j6PMeztZDkTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785942153; c=relaxed/simple;
	bh=VH4YTMPA+h4gFcjeTLNCMEDNTFyTTnloH2eynxYw6wk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M1cqDjrO7rucmpZ7vbMbw6V3Ly77r4iuzGHsXTZaWKm2UhL6QMBARH6XSgptdT1X0MX2sMlVZq2nxAShWoyl7kdoScbml2ApJLltPiCvtK/3e7waqleTmMm6aevNnm+A+ygZXmSvHcvtPoqbUTAcsZxfteCLjDbHD8AK+ZTmDIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xaO5rAoK; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xaO5rAoK"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f703a9d05so742813f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 08:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785942148; x=1786546948; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Unst9+FN4mg5CbM6AsDlSUXG1OgVFlSrNMGKLNQM9fc=;
        b=xaO5rAoKIokRKS29hMu5ORnKf97qq0xMcmlaZ4Yuwil1Y95ZfuHKZxe6XmpG0R1Y3y
         m2vZiCYjAypQces7TKH5axIJX2/TFymCrXvtaIpvLpSPLtXa46Gk576UYKsPiNTWKDO0
         cHRcbjNpJF5S3TNoIZkP41UDrP9pcfM2NXm4mU6+c3qnmaMLNvERTe9Ezn3OfIZPWjKy
         GzKAgcUiBnQmPZQCAJtJ/uSvybcwfJELyx8x+IPfCQdUlJz3cNVdVhM60YbOHeOPAYjW
         G2IoH7XHCWPaUj97Zf0N3cGRbPXPBD4ydneGUKsxXTIUx2SwrNMTlopP2BnCMIOVUxCE
         ZW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785942148; x=1786546948;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Unst9+FN4mg5CbM6AsDlSUXG1OgVFlSrNMGKLNQM9fc=;
        b=ov5I06jdUm7Veo02RJRZ7x7PHk+RK38Jf7Svdj6gUke7f1Lq3NMARVlOds4jmvoeyl
         +pFiHPOyvjNVuH7erNtiHRDE7KSWHWMqDsnKORz1udYL+f7niwcJ059Mdtpo6F3+zEVW
         yqpOzog/q/iaX0J3gTJ7ioOWy13gIWQNkd74NpCqrodksabKSY6krIVpUWZ23ozPoVor
         YpAhi4opBUfc3XLZeglefgqGLNrrPIxKgK42B3hSGEf9y2K6WqI6QE1RA3MNQ5ejFaxs
         5Oh1EZcAUyJcAWsFPtnWn9lv41umP5muZFlJB9aKUj6AEO0CYB3TSVh24WXG7vX6WE1p
         O6Vw==
X-Forwarded-Encrypted: i=1; AHgh+Rpvf+rmY9X76rLkGk9USIskXjjuD91rGh4/+9ESgN84xorK/szHASf1WMzkjUwXlK+EDpgoi60FPvHiaVGON7BX@vger.kernel.org
X-Gm-Message-State: AOJu0YzBXLbmklxettEu0b/NbfV2AFNTnZ/emKKTauQrBqMZuc/dzriw
	Crm0NppoAi5qNjE8QGll9yk0AYYMXo6/J5XjcG2tLEaSYOiUzppCxzYzSmCiMKU/kdE=
X-Gm-Gg: AR+sD11ZxjkbVoQ+JJfBLKDz+04lELQtvmcfX63dq6iJI2unbi+yqTwdALrvv+kIU9J
	KAbHBh+fPNhkkSzPp2obtzN4THvABYN1OY3qVAZaDPBMpKKch5pb/pI1vi6kZMh74omcbh/vyiF
	33ZcbovmYWtujA2yz2R9ZpoSvkNDUnwMaErjlqAAJwRZzcuuJ9cnATpsMIwFWrIC8dORddUdOOL
	rioj3wFApy9xP4nxZqd+rnXPHYgrCpfW5pJoou9awflUf/BFJrYwooL2GebvXZ62ReLy/YOiGvX
	MSkjwLc7yew9A4xdotLJhsSHeR5lVmm469u0Qc1+tqvCly2TDohhUpdSg/wDkkQ3bHwvhNcKnJz
	2Azh0bKsqX8qsagbphKlzhuINaXDA4WmDAT4jU/tIBzKKTxpzSfvx5543CKzjS9nqzm5KG19K60
	+xcMF/g9fNixem0tE48GO5faSXOl9LKd4/bDHXUQ6KVX+vnTi+Osj2iTXHc1JN/8Xg
X-Received: by 2002:a05:6000:41d0:b0:45e:73eb:5119 with SMTP id ffacd0b85a97d-47fec62ea74mr13867635f8f.22.1785942148094;
        Wed, 05 Aug 2026 08:02:28 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec23ede6sm10308695f8f.30.2026.08.05.08.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 08:02:27 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 05 Aug 2026 16:01:53 +0100
Subject: [PATCH 3/3] perf: arm_spe: Add support for a 'software' discard
 mode
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-james-spe-software-discard-v1-3-0ff0e44c4c92@linaro.org>
References: <20260805-james-spe-software-discard-v1-0-0ff0e44c4c92@linaro.org>
In-Reply-To: <20260805-james-spe-software-discard-v1-0-0ff0e44c4c92@linaro.org>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Leo Yan <leo.yan@arm.com>, Suzuki Poulose <Suzuki.Poulose@arm.com>, 
 Al Grant <Al.Grant@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

Currently discard mode needs hardware support, but we can get something
that appears pretty similar to userspace by writing to a single page
allocated by the driver and not emitting aux records.

Remove the -EOPNOTSUPP, as now we use the same discard mode format attr
as with HW support but fall back to the software version.

Don't call perf_get_aux() in discard mode as it unconditionally
dereferences a NULL event->rb when handle->event exists, which can now
be true.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/perf/arm_spe_pmu.c | 160 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 134 insertions(+), 26 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 562a1d3be39f..093fa3cc5084 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -60,6 +60,7 @@ static bool get_spe_event_has_cx(struct perf_event *event)
 }
 
 #define ARM_SPE_BUF_PAD_BYTE			0
+#define ARM_SPE_DISCARD_BUF_SIZE		SZ_4M
 
 struct arm_spe_pmu_buf {
 	int					nr_pages;
@@ -67,6 +68,12 @@ struct arm_spe_pmu_buf {
 	void					*base;
 };
 
+struct arm_spe_pmu_sw_discard_buf {
+	struct page				*page;
+	void					*base;
+	refcount_t				refcount;
+};
+
 struct arm_spe_pmu {
 	struct pmu				pmu;
 	struct platform_device			*pdev;
@@ -85,7 +92,7 @@ struct arm_spe_pmu {
 #define SPE_PMU_FEAT_LDS			(1UL << 4)
 #define SPE_PMU_FEAT_ERND			(1UL << 5)
 #define SPE_PMU_FEAT_INV_FILT_EVT		(1UL << 6)
-#define SPE_PMU_FEAT_DISCARD			(1UL << 7)
+#define SPE_PMU_FEAT_HW_DISCARD			(1UL << 7)
 #define SPE_PMU_FEAT_EFT			(1UL << 8)
 #define SPE_PMU_FEAT_FDS			(1UL << 9)
 #define SPE_PMU_FEAT_DEV_PROBED			(1UL << 63)
@@ -218,7 +225,8 @@ static const struct attribute_group arm_spe_pmu_cap_group = {
 #define ATTR_CFG_FLD_store_filter_CFG		config	/* PMSFCR_EL1.ST */
 #define ATTR_CFG_FLD_store_filter_LO		34
 #define ATTR_CFG_FLD_store_filter_HI		34
-#define ATTR_CFG_FLD_discard_CFG		config	/* PMBLIMITR_EL1.FM = DISCARD */
+/* PMBLIMITR_EL1.FM = DISCARD, or scratch buffer if no HW support */
+#define ATTR_CFG_FLD_discard_CFG		config
 #define ATTR_CFG_FLD_discard_LO			35
 #define ATTR_CFG_FLD_discard_HI			35
 #define ATTR_CFG_FLD_branch_filter_mask_CFG	config	/* PMSFCR_EL1.Bm */
@@ -309,9 +317,6 @@ static umode_t arm_spe_pmu_format_attr_is_visible(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct arm_spe_pmu *spe_pmu = dev_get_drvdata(dev);
 
-	if (attr == &format_attr_discard.attr && !(spe_pmu->features & SPE_PMU_FEAT_DISCARD))
-		return 0;
-
 	if (attr == &format_attr_inv_event_filter.attr && !(spe_pmu->features & SPE_PMU_FEAT_INV_FILT_EVT))
 		return 0;
 
@@ -368,6 +373,82 @@ static bool arm_spe_discard_mode(struct perf_event *event)
 	return ATTR_CFG_GET_FLD(&event->attr, discard);
 }
 
+static bool arm_spe_uses_sw_discard_buf(struct perf_event *event)
+{
+	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
+
+	return arm_spe_discard_mode(event) &&
+	       !(spe_pmu->features & SPE_PMU_FEAT_HW_DISCARD);
+}
+
+static void arm_spe_pmu_free_discard_buf(struct perf_event *event)
+{
+	struct arm_spe_pmu_sw_discard_buf *buf = event->pmu_private;
+
+	event->pmu_private = NULL;
+	if (!refcount_dec_and_test(&buf->refcount))
+		return;
+
+	vunmap(buf->base);
+	__free_page(buf->page);
+	kfree(buf);
+}
+
+/*
+ * Map a single page multiple times to make up ARM_SPE_DISCARD_BUF_SIZE.
+ *
+ * This reduces the number of interrupts that have to be serviced in software
+ * discard mode, but at the same time only uses a page of memory. We don't need
+ * to worry about samples being overwritten because they're never read.
+ */
+static int arm_spe_pmu_alloc_discard_buf(struct perf_event *event)
+{
+	int node = (event->cpu == -1) ? -1 : cpu_to_node(event->cpu);
+	int nr_pages = ARM_SPE_DISCARD_BUF_SIZE / PAGE_SIZE;
+	struct arm_spe_pmu_sw_discard_buf *buf;
+	struct page **pglist;
+	int i;
+
+	if (event->parent) {
+		buf = event->parent->pmu_private;
+		refcount_inc(&buf->refcount);
+		event->pmu_private = buf;
+		event->destroy = arm_spe_pmu_free_discard_buf;
+		return 0;
+	}
+
+	buf = kzalloc_node(sizeof(*buf), GFP_KERNEL, node);
+	if (!buf)
+		return -ENOMEM;
+
+	buf->page = alloc_pages_node(node, GFP_KERNEL, 0);
+	if (!buf->page)
+		goto out_free_buf;
+
+	pglist = kvmalloc_array(nr_pages, sizeof(*pglist), GFP_KERNEL);
+	if (!pglist)
+		goto out_free_page;
+
+	for (i = 0; i < nr_pages; i++)
+		pglist[i] = buf->page;
+
+	buf->base = vmap(pglist, nr_pages, VM_MAP, PAGE_KERNEL);
+	kvfree(pglist);
+	if (!buf->base)
+		goto out_free_page;
+
+	refcount_set(&buf->refcount, 1);
+	event->pmu_private = buf;
+	event->destroy = arm_spe_pmu_free_discard_buf;
+	return 0;
+
+out_free_page:
+	__free_page(buf->page);
+out_free_buf:
+	kfree(buf);
+	return -ENOMEM;
+}
+
 /* Convert between user ABI and register values */
 static u64 arm_spe_event_to_pmscr(struct perf_event *event)
 {
@@ -617,10 +698,26 @@ static u64 arm_spe_pmu_next_off(struct perf_output_handle *handle)
 static void arm_spe_pmu_begin_discard(struct perf_output_handle *handle,
 				      struct perf_event *event)
 {
-	u64 limit;
+	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
+	struct arm_spe_pmu_sw_discard_buf *discard_buf = event->pmu_private;
+	u64 base, limit;
+
+	if (spe_pmu->features & SPE_PMU_FEAT_HW_DISCARD) {
+		limit = FIELD_PREP(PMBLIMITR_EL1_FM, PMBLIMITR_EL1_FM_DISCARD);
+		limit |= PMBLIMITR_EL1_E;
+	} else {
+		base = (u64) discard_buf->base;
+		limit = base + ARM_SPE_DISCARD_BUF_SIZE;
+		limit |= PMBLIMITR_EL1_E;
+		write_sysreg_s(base, SYS_PMBPTR_EL1);
 
-	limit = FIELD_PREP(PMBLIMITR_EL1_FM, PMBLIMITR_EL1_FM_DISCARD);
-	limit |= PMBLIMITR_EL1_E;
+		/*
+		 * Track the event so we can access the discard buffer through
+		 * event->pmu_private. perf_aux_output_begin() normally handles
+		 * this, but we can do it manually if that's not being used.
+		 */
+		handle->event = event;
+	}
 
 	write_sysreg_s(limit, SYS_PMBLIMITR_EL1);
 }
@@ -757,15 +854,20 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
 	enum arm_spe_pmu_buf_fault_action act;
 	u64 aux_flags;
 
-	if (!perf_get_aux(handle))
+	if (!event)
+		return IRQ_NONE;
+
+	if (!arm_spe_discard_mode(event) && !perf_get_aux(handle))
 		return IRQ_NONE;
 
 	act = arm_spe_pmu_buf_get_fault_act(&aux_flags);
 	if (act == SPE_PMU_BUF_FAULT_ACT_SPURIOUS)
 		return IRQ_NONE;
 
-	perf_aux_output_flag(handle, aux_flags);
-	arm_spe_perf_aux_output_end(handle);
+	if (!arm_spe_discard_mode(event)) {
+		perf_aux_output_flag(handle, aux_flags);
+		arm_spe_perf_aux_output_end(handle);
+	}
 
 	/*
 	 * Ensure perf callbacks have completed, which may disable the
@@ -819,6 +921,7 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
 static int arm_spe_pmu_event_init(struct perf_event *event)
 {
 	u64 reg;
+	int ret;
 	struct perf_event_attr *attr = &event->attr;
 	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
 
@@ -880,14 +983,16 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	    !(spe_pmu->features & SPE_PMU_FEAT_EFT))
 		return -EOPNOTSUPP;
 
-	if (arm_spe_discard_mode(event) &&
-	    !(spe_pmu->features & SPE_PMU_FEAT_DISCARD))
-		return -EOPNOTSUPP;
-
 	set_spe_event_has_cx(event);
 	reg = arm_spe_event_to_pmscr(event);
-	if (reg & (PMSCR_EL1_PA | PMSCR_EL1_PCT))
-		return perf_allow_kernel();
+	if (reg & (PMSCR_EL1_PA | PMSCR_EL1_PCT)) {
+		ret = perf_allow_kernel();
+		if (ret)
+			return ret;
+	}
+
+	if (arm_spe_uses_sw_discard_buf(event))
+		return arm_spe_pmu_alloc_discard_buf(event);
 
 	return 0;
 }
@@ -954,23 +1059,26 @@ static void arm_spe_pmu_stop(struct perf_event *event, int flags)
 	arm_spe_pmu_disable_and_drain_local();
 
 	if (flags & PERF_EF_UPDATE) {
+		enum arm_spe_pmu_buf_fault_action act;
+
 		/*
 		 * If there's a fault pending then ensure we contain it
 		 * to this buffer, since we might be on the context-switch
 		 * path.
 		 */
-		if (perf_get_aux(handle)) {
-			enum arm_spe_pmu_buf_fault_action act;
-
-			act = arm_spe_pmu_buf_get_fault_act(&aux_flags);
+		act = arm_spe_pmu_buf_get_fault_act(&aux_flags);
+		if (!arm_spe_discard_mode(event) && perf_get_aux(handle)) {
 			perf_aux_output_flag(handle, aux_flags);
 			arm_spe_perf_aux_output_end(handle);
-
-			/* Assume PMBSR only needs clearing for real faults */
-			if (act != SPE_PMU_BUF_FAULT_ACT_SPURIOUS)
-				write_sysreg_s(0, SYS_PMBSR_EL1);
+		} else {
+			/* Discard mode tracks event outside of perf_aux_output_X() */
+			handle->event = NULL;
 		}
 
+		/* Assume PMBSR only needs clearing for real faults */
+		if (act != SPE_PMU_BUF_FAULT_ACT_SPURIOUS)
+			write_sysreg_s(0, SYS_PMBSR_EL1);
+
 		/*
 		 * This may also contain ECOUNT, but nobody else should
 		 * be looking at period_left, since we forbid frequency
@@ -1180,7 +1288,7 @@ static void __arm_spe_pmu_dev_probe(void *info)
 		spe_pmu->features |= SPE_PMU_FEAT_ERND;
 
 	if (spe_pmu->pmsver >= ID_AA64DFR0_EL1_PMSVer_V1P2)
-		spe_pmu->features |= SPE_PMU_FEAT_DISCARD;
+		spe_pmu->features |= SPE_PMU_FEAT_HW_DISCARD;
 
 	if (FIELD_GET(PMSIDR_EL1_EFT, reg))
 		spe_pmu->features |= SPE_PMU_FEAT_EFT;

-- 
2.43.0

