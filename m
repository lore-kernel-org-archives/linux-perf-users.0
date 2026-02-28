Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9C743E9CC;
	Sat, 28 Feb 2026 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772290036; cv=none; b=NE19FcgOf+L0Mkx9jFwVtBGxS9tVpaFbcp17jDID5PtD0MMiFNYI+KzIIHAPuOmI4UeM3Ay3jEYFf/ckitVkoIK0AE3aXhgwKC96Lu0O6XicX4P4NfcNnZficUCwr8NWazGgIKoMhAud3566UGjFfiUcJr7oxJCGTz59Nzp1xsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772290036; c=relaxed/simple;
	bh=fXa1lkiUZ/QL0botgKsdNtPqBfZ3NrLi1gXFYHiWXyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OnXTCQzRr55cQRcorNeST7u5gW+dL+lCdzuuVjV/dKFrUPGbVoAKynnaUfRAdgB9/W+1o3w8H/GSbnctlrjlqSR3YWpGzeNg8V1oOjGLpu0LsfvZSHFnaoz7ZVqD4rvQ1tScHFVKPWpW3OVkQ3/TEWWaTza8xPQXaFQp5GK07Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=QB2R3PjW; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="QB2R3PjW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1772289912;
	bh=9Rddjh34nxVG+T9ZP2MtutmhQmrdK8gCR5+Qv674HF8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=QB2R3PjW44GYFJHJ9bvKy1LFrpCj7gdSzJmMorkTLlxbP1tAdWkIHUgUv1JAK7ANX
	 DDPJCkRBp8HaEk4BoSDLcdeG/DwEnvAT7C9rH19O19EIK2yfQRH7fyukwn7THabWPJ
	 33P6SLDaHnFRoskklX+ESA6p03dYjGvtGvB8fmhs=
X-QQ-mid: zesmtpgz5t1772289906t83a7a01f
X-QQ-Originating-IP: 1WCF6GkPzDS7btEb31Vfq+QwqZVOwt20SD8/fLmXg9E=
Received: from SurfaceBook2-B.localdomain ( [183.193.112.19])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 28 Feb 2026 22:45:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5539244136546253988
EX-QQ-RecipientCnt: 33
From: Lv Zheng <lv.zheng@linux.spacemit.com>
To: Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Yixun Lan <dlan@kernel.org>
Cc: Jingyu Li <joey.li@spacemit.com>,
	Lv Zheng <lv.zheng@linux.spacemit.com>,
	Zong Li <zong.li@sifive.com>,
	Yaxing Guo <guoyaxing@bosc.ac.cn>,
	Zhijian Chen <zhijian@spacemit.com>,
	iommu@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/8] spacemit/t100: Add global filter awareness for RISC-V IOMMU HPM
Date: Sat, 28 Feb 2026 22:44:59 +0800
Message-ID: <E8CA8C0C8D600441+344b42b8c982867a1b51324b252a4315aaa54f89.1772289741.git.lv.zheng@linux.spacemit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1772289741.git.lv.zheng@linux.spacemit.com>
References: <cover.1772289741.git.lv.zheng@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MKRFeTdpYQoNtPE/J6vyUX9BItjFAnSVyy5uvWZGBUc9CVm47J5UkbIY
	MhavoejMUyHjl+a7UMV++yxIW53msrRBq+yblY5cdW1JUvRqiV4LEsagpD+j+YL2GDOkNDv
	Rf0YH4D2Xd1AXaH+o2wSgq3rMkEEMmgGLHYDNVojZT4d9Dmw2hhpHhX6l4nnRc5xbSQPa/f
	TXmBpUrraBJPfnVpuWQOslqEliPQ4b4Z/8aqT7ggrUlVJM89YFIRg0BDUNs63HPtng/Gc4Z
	LNXXvE6HFBnDbHuHYqLnNZaGXXyhiPbwmhLR6NKna5y/dCGA8qj/Q16bsmmZFAxS4HUJMjv
	KLrAqbYFASLl253kgfNGAtts+mt9WBY8qz2jrvj/PTHp/8a2jNO/c2F91xdP4F2I0Ao6mEQ
	0B5cINtWaACx4QEqy3CoY4qIieBNsGej61iwf5OKFLLvUEAAByOaaKguE2eGNDlSpqoeMLF
	u5+IgxoJWgI7R3Ye0374it629X3GM3cAyi6AAgFmmAPTvEnRy44HqLWxFnVtGlaWWfXSiU9
	5SMaILxTEoQzqPv7plPoYuZCz5Wszk+tmDxBC+Y43QNsKC7LpAC4HgQ4f2EJSXIJ7Av+HUJ
	ZNN0IuHdgKfFsp7cNSev6GQGRVI6oe1eE8rLEjmltcjsevYfVwi42Nf2/jK4t+RONiHaFwv
	MJeBWimCdxYmERXYWjRBid47X8cz01Bs/WTh27P60zFSvf/rntyVIFuKJvgVGzw72eWfsZ1
	LjXBBzkrE6jOFKgecdDuMB3jydrQV82cvGPDmBaLNMQtWaquP3NBxpp7w3Xq4vQMK9a47Rn
	nhyjvGifRE7As0sHF3UlHP13BccrOfeuDqxkpFliVp7sKnzbNTaHYckUw53CC9DzTXuumfY
	jkXgh3QGoTJuqekRyReVLOQTNPdmApfgBQrfd51DmFvFrA5D6VdM3mQ8bbMx4MKBPsevLzo
	Qk72gwhLisLtXX37Fv2iL2uU/2dFmLlXn0uFwFygmPC59Nc42gAzreq2nR8+y3QeJJbsKyW
	nQcXkaXRyXxPkMDD376Qsp/TsHJuMBfigK6bk68jPZBywrbABztyQmxz/CAC94zeLaF3wyr
	elpeq4JnTR6jsGVcY+FZI2Jj/Urj8gW13IBPplyU5M9
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

Adds global filter support for RISC-V IOMMU HPM. The global filter can be
seen in SpacemiT T100 which only supports single filter to be applied to
all event counters.

Drivers can program filters in each iohpmevt registers as normal in such a
silicon design, however the underlying hardware filters are wired together
as a global filter applying to all iohpmevt(s). Since the mechanism is
compatible with standard iohpmevt in programming interface, only adds
sanity checks to allow it to be configured with "global" awareness to
inform users a filter incompatiblity.

Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
Signed-off-by: Jingyu Li <joey.li@spacemit.com>
---
 drivers/iommu/riscv/iommu.c    |  5 ++
 drivers/perf/riscv_iommu_hpm.c | 94 ++++++++++++++++++++++++++++++++--
 include/linux/riscv_iommu.h    |  2 +
 3 files changed, 96 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 1aa942486e3a..21ff7e50d115 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1717,6 +1717,11 @@ static void riscv_iommu_enumerate_hpm(struct riscv_iommu_device *iommu)
 		.base = iommu->reg + RISCV_IOMMU_REG_IOCOUNTOVF,
 	};
 
+	if (of_device_is_compatible(iommu->dev->of_node, "spacemit,t100")) {
+		hpm_info->global_filter = true;
+		params.name = "spacemit_ioats_hpm";
+	}
+
 	ret = riscv_iommu_subdev_add(iommu, &params);
 	if (ret) {
 		kfree(hpm_info);
diff --git a/drivers/perf/riscv_iommu_hpm.c b/drivers/perf/riscv_iommu_hpm.c
index 4d5ce0f380e7..efa65caef0dc 100644
--- a/drivers/perf/riscv_iommu_hpm.c
+++ b/drivers/perf/riscv_iommu_hpm.c
@@ -87,6 +87,7 @@ struct riscv_iommu_hpm {
 	void __iomem *base;
 	unsigned int irq;
 	unsigned int on_cpu;
+	bool global_filter;
 	struct hlist_node node;
 	/*
 	 * Layout of events:
@@ -210,6 +211,33 @@ static inline void riscv_iommu_hpm_interrupt_clear(struct riscv_iommu_hpm *hpm)
 	riscv_iommu_clear_pmip(hpm->subdev);
 }
 
+static bool riscv_iommu_hpm_check_global_filter(struct perf_event *curr,
+						struct perf_event *new)
+{
+	return get_filter_pid_pscid(curr) == get_filter_pid_pscid(new) &&
+	       get_filter_did_gscid(curr) == get_filter_did_gscid(new) &&
+	       get_filter_pv_pscv(curr) == get_filter_pv_pscv(new) &&
+	       get_filter_dv_gscv(curr) == get_filter_dv_gscv(new) &&
+	       get_filter_idt(curr) == get_filter_idt(new) &&
+	       get_filter_dmask(curr) == get_filter_dmask(new);
+}
+
+static bool riscv_iommu_hpm_events_compatible(struct perf_event *curr,
+					      struct perf_event *new)
+{
+	struct riscv_iommu_hpm *hpm;
+
+	if (new->pmu != curr->pmu)
+		return false;
+
+	hpm = to_iommu_hpm(new->pmu);
+	if (hpm->global_filter &&
+	    !riscv_iommu_hpm_check_global_filter(curr, new))
+		return false;
+
+	return true;
+}
+
 /**
  * riscv_iommu_hpm_event_update() - Update and return RISC-V IOMMU HPM
  *                                  event counters
@@ -344,9 +372,10 @@ static void riscv_iommu_hpm_set_event_filter(struct perf_event *event, int idx,
 			       RISCV_IOMMU_REG_IOHPMEVT(idx), event_cfg);
 }
 
-static void riscv_iommu_hpm_apply_event_filter(struct riscv_iommu_hpm *hpm,
-					       struct perf_event *event, int idx)
+static int riscv_iommu_hpm_apply_event_filter(struct riscv_iommu_hpm *hpm,
+					      struct perf_event *event, int idx)
 {
+	unsigned int cur_idx, num_ctrs = hpm->num_counters;
 	u32 pid_pscid, did_gscid, pv_pscv, dv_gscv, idt, dmask;
 
 	pid_pscid = get_filter_pid_pscid(event);
@@ -356,8 +385,32 @@ static void riscv_iommu_hpm_apply_event_filter(struct riscv_iommu_hpm *hpm,
 	idt = get_filter_idt(event);
 	dmask = get_filter_dmask(event);
 
+	if (hpm->global_filter) {
+		cur_idx = find_first_bit(hpm->used_counters, num_ctrs - 1);
+		if (cur_idx == num_ctrs - 1) {
+			/* First event, set the global filter at iohpmevt0 */
+			riscv_iommu_hpm_set_event_filter(event, 0, pid_pscid,
+							 did_gscid,
+							 pv_pscv, dv_gscv, idt, dmask);
+		} else {
+			/* Check if the new event's filter matches the global filter */
+			if (!riscv_iommu_hpm_check_global_filter(hpm->events[cur_idx + 1],
+								 event)) {
+				dev_dbg(hpm->pmu.dev,
+					"HPM: Filter incompatible with global filter\n");
+				return -EAGAIN;
+			}
+			/* Program event at this counter; filter is shared by hardware */
+			riscv_iommu_hpm_set_event_filter(event, idx, pid_pscid,
+							 did_gscid,
+							 pv_pscv, dv_gscv, idt, dmask);
+		}
+		return 0;
+	}
+
 	riscv_iommu_hpm_set_event_filter(event, idx, pid_pscid, did_gscid,
 					 pv_pscv, dv_gscv, idt, dmask);
+	return 0;
 }
 
 static int riscv_iommu_hpm_get_event_idx(struct riscv_iommu_hpm *hpm,
@@ -385,7 +438,8 @@ static int riscv_iommu_hpm_get_event_idx(struct riscv_iommu_hpm *hpm,
 		return -EAGAIN;
 	}
 
-	riscv_iommu_hpm_apply_event_filter(hpm, event, idx);
+	if (riscv_iommu_hpm_apply_event_filter(hpm, event, idx))
+		return -EAGAIN;
 	set_bit(idx, hpm->used_counters);
 
 	return idx;
@@ -484,6 +538,8 @@ static int riscv_iommu_hpm_event_init(struct perf_event *event)
 	}
 
 	if (!is_software_event(event->group_leader)) {
+		if (!riscv_iommu_hpm_events_compatible(event->group_leader, event))
+			return -EINVAL;
 		if (++group_num_events > hpm->num_counters)
 			return -EINVAL;
 	}
@@ -491,6 +547,8 @@ static int riscv_iommu_hpm_event_init(struct perf_event *event)
 	for_each_sibling_event(sibling, event->group_leader) {
 		if (is_software_event(sibling))
 			continue;
+		if (!riscv_iommu_hpm_events_compatible(sibling, event))
+			return -EINVAL;
 		if (++group_num_events > hpm->num_counters)
 			return -EINVAL;
 	}
@@ -593,10 +651,33 @@ static const struct attribute_group riscv_iommu_hpm_format_group = {
 	.attrs = riscv_iommu_hpm_formats,
 };
 
+static ssize_t riscv_iommu_hpm_global_filter_show(struct device *dev,
+						  struct device_attribute *attr,
+						  char *buf)
+{
+	struct riscv_iommu_hpm *hpm = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%s\n",
+			  hpm->global_filter ? "true" : "false");
+}
+
+static struct device_attribute riscv_iommu_hpm_global_filter_attr =
+	__ATTR(global_filter, 0444, riscv_iommu_hpm_global_filter_show, NULL);
+
+static struct attribute *riscv_iommu_hpm_vendor_attrs[] = {
+	&riscv_iommu_hpm_global_filter_attr.attr,
+	NULL
+};
+
+static const struct attribute_group riscv_iommu_hpm_vendor_group = {
+	.attrs = riscv_iommu_hpm_vendor_attrs,
+};
+
 static const struct attribute_group *riscv_iommu_hpm_attr_grps[] = {
 	&riscv_iommu_hpm_cpumask_group,
 	&riscv_iommu_hpm_events_group,
 	&riscv_iommu_hpm_format_group,
+	&riscv_iommu_hpm_vendor_group,
 	NULL
 };
 
@@ -776,6 +857,7 @@ static int riscv_iommu_hpm_probe(struct auxiliary_device *auxdev,
 	hpm->base = subdev->base;
 	hpm->on_cpu = raw_smp_processor_id();
 	hpm->irq = info->irq;
+	hpm->global_filter = info->global_filter;
 
 	bitmap_zero(hpm->used_counters, RISCV_IOMMU_HPMCOUNTER_MAX);
 	bitmap_zero(hpm->supported_events, RISCV_IOMMU_HPMEVENT_MAX);
@@ -831,8 +913,9 @@ static int riscv_iommu_hpm_probe(struct auxiliary_device *auxdev,
 
 	auxiliary_set_drvdata(auxdev, hpm);
 
-	dev_info(dev, "HPM: Registered %s (%d counters, IRQ %d)\n",
-		 hpm_name, hpm->num_counters, hpm->irq);
+	dev_info(dev, "HPM: Registered %s (%d counters, IRQ %d, %s filter)\n",
+		 hpm_name, hpm->num_counters, hpm->irq,
+		 hpm->global_filter ? "global" : "per-counter");
 
 	return 0;
 }
@@ -847,6 +930,7 @@ static void riscv_iommu_hpm_remove(struct auxiliary_device *auxdev)
 
 static const struct auxiliary_device_id riscv_iommu_hpm_ids[] = {
 	{ .name = "iommu.riscv_iommu_hpm" },
+	{ .name = "iommu.spacemit_ioats_hpm" },
 	{}
 };
 MODULE_DEVICE_TABLE(auxiliary, riscv_iommu_hpm_ids);
diff --git a/include/linux/riscv_iommu.h b/include/linux/riscv_iommu.h
index 0447bc4d1fab..6af592dfaa00 100644
--- a/include/linux/riscv_iommu.h
+++ b/include/linux/riscv_iommu.h
@@ -36,9 +36,11 @@ struct riscv_iommu_subdev {
 /**
  * struct riscv_iommu_hpm_info - HPM info for IOATS (main IOMMU HPM)
  * @irq: interrupt number
+ * @global_filter: true if single global filter
  */
 struct riscv_iommu_hpm_info {
 	unsigned int irq;
+	bool global_filter;
 };
 
 /**
-- 
2.43.0

