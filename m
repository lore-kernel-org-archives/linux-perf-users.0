Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BE88F7D;
	Wed,  4 Feb 2026 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770196228; cv=none; b=IijK1blYk9+e2Gg8Mh2uGXBrGqx1J+W1LZJWiZF+8dNwcgK5VpeIK6+owp2Fsrpb+OlQH1KH56JtAzFVoFqf1O6fWaBxIXSPSvusG9Gvp/7a/sRMZC9M73PUaJk3pAm6/nzAJED/dQ06KjQlsYoU6qX4GVIEqQhrHEDug2PzpKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770196228; c=relaxed/simple;
	bh=BYYtxnRnmzVps1K7eRR6V2NQ2T2Srf1CVZFuuJ/Ehuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bae9cZVYvnq/eyeTyh/7P4NLVa/ZakfqG7EioTdc4nhXT1Ut9r41rorGgU5Hxa5o1DN6OE1D7aLyPqx7Ii3ce8VSBd46ghMz6qD+czC31OJb9DXBquGTQ1JQMK4gqD6UqWVy8X5uDVX8SnS6Pz9bi1wEHUH7ZQ1KelT6TzJHhH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=yn7OK24T; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="yn7OK24T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1770196179;
	bh=y9DkLzUrYbFPycckmGkiUce2gXOr2hFfNyty0O3R4MY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=yn7OK24TpJG5WTImUvjZVMrm7SZlk1rMK6ni64S+D9ZaYZ37NpjqD5PCyCdN7RQPG
	 Glsq7yTSC1jCphc3Nepc/Q64nNRwTJfRf5+JhSqtFI3RRUnpkUTF/gmK7pWg5dRynp
	 3XkEocPIcr0D8By+GXaPaY96mVky4nHNYB6vXq+s=
X-QQ-mid: zesmtpsz2t1770196177t740f2e62
X-QQ-Originating-IP: fw2+2nrGLsqH3N4ZDiZZXh9Cx9/Ufu7lLgRpIlNcvJc=
Received: from SurfaceBook2-B.localdomain ( [101.70.125.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 04 Feb 2026 17:09:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5616500725209696300
EX-QQ-RecipientCnt: 19
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
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Jingyu Li <joey.li@spacemit.com>,
	Lv Zheng <lv.zheng@linux.spacemit.com>,
	Zhijian Chen <zhijian@spacemit.com>,
	iommu@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: [PATCH v3 6/8] spacemit/t100: Add global filter awareness for RISC-V IOMMU HPM
Date: Wed,  4 Feb 2026 17:09:31 +0800
Message-ID: <F398E8A96DC9FD91+fbe3e9426509fc888b82d076eb061f9186f25f2a.1770195980.git.lv.zheng@linux.spacemit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770195980.git.lv.zheng@linux.spacemit.com>
References: <cover.1769562575.git.lv.zheng@spacemit.com> <cover.1770195980.git.lv.zheng@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NafziRg7Bx69t5Sy4C0zjzUUCZJOm5JzZ42BiTQbrPCM1Vyk7pY3ba51
	Pmp7RSTu5pqmOeXx1irWIB2OKNFgpmv5z/z0vafOwmqVyXrU2Cv6zgetVXj3AYATtk0YWcH
	TvyifIqXLgrBgKoAx+DtDLigKmP0e/NIUs0h2e3EMmk981XWoPrvC0huirBzKtC/i2AwygM
	SdLJRNxVmZEtT9pHDHqDGpZA0KtJtRlKDAbkY84JvvUFrIPWldWXVP0NLy2GD6SV7HPPke1
	Dei5W7iQ6QywWR+POXxmPmtIQ7Jqq+De7EA1anYbnwE/geNgIqgXNg15lrpvNosSnF92jI3
	+qOxSm2KcYxjodeuJRB9a4T7lNvQt9/Hk06vXMt3HgEQy4LNuYI931LRg1glf7VFEuxJrul
	OwgiHnL4y72jbBIwIs0dH9OyQYsCApPsKXtsSAoLSJ9P7WdkP+p5m0HV9wtqaF1oKdBVafv
	600xwkqCl+ANPN83tbRSWaZSgFKP8wjddaicbNxRfDUYZiWazkcgSZZvWOA/OdGTcT0QrBI
	JOZWYj/NmRCSVRD1LGRtYIdDz2vhLHr8WvK4HDOFTY6l3vIKk0+mOk5T5yYkbDyckIv1KDg
	WEootRH5aAhmUtjtcIN+tPYecNhCuDQSkhu7yUkn1KmiEA+IscasliTJeeLAxSUZRMDPpeT
	VypZh1BKKznblyl1vsLkWgFAG+FSkxYI+2zAuzAl05NC1JScRm3/hFEVHYcMTsbqeNqe+b/
	7BUh+DE2GvYDFOatJqu89sGAL3alIiIALw+pKqkcWmSj4huB951YrYLx9hCRt3MtDRPahjA
	IJI9jXGUwND49uNzMcdSiyLg0RUeQdsJYffy7oHUcRjlQdt4gNUkubiILqNVUa+aCsp/x9+
	mv0DY2b3mgIZRC6b6SW9k/mgLaw22lfxUiZsXUi6JpJgPfikaCLDSKEkL63MgrU/Qp+udwR
	Ljqnlc+h7syD5iMVpnJh24fSHvQxhLWvmJZ8faWZJ6TYq/nrhHUxa1no4SowuvS6ortdt2F
	JEi3WgUh9J1kaXHPminJPMBMNoeMN7Og5NiqiWgr8c6hLBWn/2yXUvhmGiwIL0VgHkHM5gU
	Q==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

Introduces global filter support for RISC-V IOMMU HPM. The global filter
can be seen in SpacemiT T100 which only supports single filter to be
applied to all event counters.

Drivers can program filters in each iohpmevt registers as normal in such a
silicon design, however the underlying hardware filters are wired together
as a global filter applying to all iohpmevt(s). Since the mechanism is
compatible with standard iohpmevt in programming interface, only adds
sanity checks to allow it to be configured with "global" awareness to
inform users a filter incompatiblity.

Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
Signed-off-by: Jingyu Li <joey.li@spacemit.com>
---
 drivers/iommu/riscv/iommu-hpm.c | 68 ++++++++++++++++++++++++++++++---
 drivers/iommu/riscv/iommu.h     |  1 +
 2 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-hpm.c b/drivers/iommu/riscv/iommu-hpm.c
index e140cf59c408..4a739cb0887c 100644
--- a/drivers/iommu/riscv/iommu-hpm.c
+++ b/drivers/iommu/riscv/iommu-hpm.c
@@ -134,6 +134,30 @@ static inline void riscv_iommu_hpm_interrupt_clear(struct riscv_iommu_hpm *hpm)
 	riscv_iommu_hpm_writel(hpm, RISCV_IOMMU_REG_IPSR, RISCV_IOMMU_IPSR_PMIP);
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
+	if (new->pmu != curr->pmu)
+		return false;
+
+	if (to_iommu_hpm(new->pmu)->global_filter &&
+	    !riscv_iommu_hpm_check_global_filter(curr, new))
+		return false;
+
+	return true;
+}
+
 /**
  * riscv_iommu_hpm_event_update() - Update and return RISC-V IOMMU HPM
  *                                  event counters
@@ -268,9 +292,10 @@ static void riscv_iommu_hpm_set_event_filter(struct perf_event *event, int idx,
 			       RISCV_IOMMU_REG_IOHPMEVT(idx), event_cfg);
 }
 
-static void riscv_iommu_hpm_apply_event_filter(struct riscv_iommu_hpm *iommu_hpm,
-					       struct perf_event *event, int idx)
+static int riscv_iommu_hpm_apply_event_filter(struct riscv_iommu_hpm *iommu_hpm,
+					      struct perf_event *event, int idx)
 {
+	unsigned int cur_idx, num_ctrs = iommu_hpm->num_counters;
 	u32 pid_pscid, did_gscid, pv_pscv, dv_gscv, idt, dmask;
 
 	pid_pscid = get_filter_pid_pscid(event);
@@ -280,14 +305,36 @@ static void riscv_iommu_hpm_apply_event_filter(struct riscv_iommu_hpm *iommu_hpm
 	idt = get_filter_idt(event);
 	dmask = get_filter_dmask(event);
 
+	if (iommu_hpm->global_filter) {
+		cur_idx = find_first_bit(iommu_hpm->used_counters, num_ctrs - 1);
+		if (cur_idx == num_ctrs - 1) {
+			/* First event, set the global filter */
+			riscv_iommu_hpm_set_event_filter(event, 0, pid_pscid,
+							 did_gscid,
+							 pv_pscv, dv_gscv, idt, dmask);
+		} else {
+			/* Check if the new event's filter is compatible with
+			 * the global filter
+			 */
+			if (!riscv_iommu_hpm_check_global_filter(iommu_hpm->events[cur_idx + 1],
+								 event)) {
+				dev_dbg(iommu_hpm->pmu.dev,
+					"HPM: Filter incompatible with global filter\n");
+				return -EAGAIN;
+			}
+		}
+		return 0;
+	}
+
 	riscv_iommu_hpm_set_event_filter(event, idx, pid_pscid, did_gscid,
 					 pv_pscv, dv_gscv, idt, dmask);
+	return 0;
 }
 
 static int riscv_iommu_hpm_get_event_idx(struct riscv_iommu_hpm *iommu_hpm,
 					 struct perf_event *event)
 {
-	int idx;
+	int idx, err;
 	unsigned int num_ctrs = iommu_hpm->num_counters;
 	u16 event_id = get_event(event);
 
@@ -309,7 +356,9 @@ static int riscv_iommu_hpm_get_event_idx(struct riscv_iommu_hpm *iommu_hpm,
 		return -EAGAIN;
 	}
 
-	riscv_iommu_hpm_apply_event_filter(iommu_hpm, event, idx);
+	err = riscv_iommu_hpm_apply_event_filter(iommu_hpm, event, idx);
+	if (err)
+		return err;
 	set_bit(idx, iommu_hpm->used_counters);
 
 	return idx;
@@ -409,6 +458,8 @@ static int riscv_iommu_hpm_event_init(struct perf_event *event)
 	}
 
 	if (!is_software_event(event->group_leader)) {
+		if (!riscv_iommu_hpm_events_compatible(event->group_leader, event))
+			return -EINVAL;
 		if (++group_num_events > iommu_hpm->num_counters)
 			return -EINVAL;
 	}
@@ -416,6 +467,8 @@ static int riscv_iommu_hpm_event_init(struct perf_event *event)
 	for_each_sibling_event(sibling, event->group_leader) {
 		if (is_software_event(sibling))
 			continue;
+		if (!riscv_iommu_hpm_events_compatible(sibling, event))
+			return -EINVAL;
 		if (++group_num_events > iommu_hpm->num_counters)
 			return -EINVAL;
 	}
@@ -733,6 +786,8 @@ static int riscv_iommu_hpm_register_unit(struct riscv_iommu_device *iommu,
 	bitmap_zero(iommu_hpm->used_counters, RISCV_IOMMU_HPMCOUNTER_MAX);
 	bitmap_zero(iommu_hpm->supported_events, RISCV_IOMMU_HPMEVENT_MAX);
 
+	iommu_hpm->global_filter = of_device_is_compatible(dev->of_node,
+							   "spacemit,t100");
 	riscv_iommu_hpm_writel(iommu_hpm,
 			       RISCV_IOMMU_REG_IOCOUNTINH, 0xFFFFFFFF);
 	val = riscv_iommu_hpm_readl(iommu_hpm,
@@ -796,8 +851,9 @@ static int riscv_iommu_hpm_register_unit(struct riscv_iommu_device *iommu,
 	if (err)
 		goto err_cpuhp;
 
-	dev_info(dev, "HPM: Registered %s (%d counters, IRQ %d)\n",
-		 pmu_name, iommu_hpm->num_counters, iommu_hpm->irq);
+	dev_info(dev, "HPM: Registered %s (%d counters, IRQ %d, %s filter)\n",
+		 pmu_name, iommu_hpm->num_counters, iommu_hpm->irq,
+		 iommu_hpm->global_filter ? "global" : "per-counter");
 	return 0;
 
 err_cpuhp:
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index d3c11abef5cf..80e96fd7e164 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -42,6 +42,7 @@ struct riscv_iommu_hpm {
 	int on_cpu;
 	struct hlist_node node;
 	const char *identifier;
+	bool global_filter;
 	/*
 	 * Layout of events:
 	 * 0       -> HPMCYCLES
-- 
2.43.0

