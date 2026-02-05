Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A98B36F408;
	Thu,  5 Feb 2026 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770282711; cv=none; b=u/3TsFQvDwu6unxhdS4ZtvI4N0oPYcQMEEpu5IpbrVbw8vBV+ISnq1SpFhun97Tn91nBurfbGxDbolGWmgagfc386MDwkZBCtBaXdjOY7Dg0eCJmw0WeQfpGC7aAWaH5GdjBH3/xl+w8C8B0aexpohoNbYYx5yA9pVFh9mNNo+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770282711; c=relaxed/simple;
	bh=a5uJ36hFd3WcbTGXDwuxbS2ULoILWynx3XJ5O3WzJUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ccwO/wIWN1W1P8ZQmPcRQ6JMnVaFAbkyOsDrNYCh+QbAKBoruSaGAS9GaiUkmpPO9Kfwc+7MdsWKkiSNpjZuPkq6TtZlTH3VwS3eWbsKTnnvsHEFDFJgih1wz9ATtLexbnCmkE5gRyVL35+kxjppGeEow8DTUzH2StgFuqyTLwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=n3uQDsH/; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="n3uQDsH/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1770282669;
	bh=vfOYWrmIeO0723UuZAgfE8SD5wha0JiRBuhktfrJEgA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=n3uQDsH/vlFcvHq1PnHRLOe2izbORomRoQNHPsJApR0HjKtqqBkZ7vQInyuVmGJ4c
	 p4YniAIgycxYDi8OCkpNzSy3sRhbVClKOGVdgXkaDkIs0JAMJJyIT0o9XHOhstERbY
	 yGXODABwt0vjntNK0hUeTdWAx8RL7KLJhV1RnfJA=
X-QQ-mid: zesmtpgz5t1770282667tca009809
X-QQ-Originating-IP: l447uHHvOvf6U1tohTXRa2ucxuNIOgWKjXmah5SeQYQ=
Received: from SurfaceBook2-B.localdomain ( [101.70.125.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 05 Feb 2026 17:11:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1450487329459000950
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
Subject: [PATCH v4 5/7] spacemit/t100: Add global filter awareness for RISC-V IOMMU HPM
Date: Thu,  5 Feb 2026 17:11:02 +0800
Message-ID: <9D810C651A88F92D+84147936abc03bb70cc1990dd7157cc02fcebd52.1770281596.git.lv.zheng@linux.spacemit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770281596.git.lv.zheng@linux.spacemit.com>
References: <cover.1769562575.git.lv.zheng@spacemit.com> <cover.1770281596.git.lv.zheng@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: OPv1v8QuUFDkSzcTJbGp7q9/lyAL9aKGDlzv4TBsoRtOjJ3H8XoleF3w
	wfRxpG7jk6DT9nTZLDo5aekSPSqtoSB1bsE75TiZ9EivufE8ud6mGIUo1vvdNq73LcOfggL
	/3habiIw12fBVuXsxMCRraSdyGpI6q5JdCDf159B24FH8BSTc7CRTRWdRAyWsX8uH268zHM
	FCHe+aAeN9DyMSCbvgQMkMPT/M/ERcO+Z+qLFrvhV6hJvbgfrESBt8FVudpDEqRvqc84Z3Z
	zuaE9szm0upMEmbeskMHNTgDWaMrxVy5L/v7xOFb3ZOZ9Fg1VRdLxGl+q2ZqxNt51d+YT6p
	7v1HcFxABbtFtYSAJ2Y0w6ZvjPdlQs47I9nHMBP7aO9yUGrjNQAl0xK86pier4/aXMunWi+
	2O14DaHdWEK9/i0htbEu3+Stg+9yAKNwzTM58GWyAPS4Xq9m37VYE4n65YhkHv+PNaRuqqj
	wKbyLkkEoGFPeWEJqKl4LFxfuwBVrMG24JHiIxKSKLdT/tKmBfHG/ShcDsSljHscIKFAhSB
	UwIv56lSFakqMCgYaWxkt44USz0jjQnVUNQUppgnb9wCnSEPGnfGec3Y64LBC2/PEWjqSHU
	QuNohjnyzrI2mjdLxEVbdhewMgWEVEP7NAzGwPFQjtG6+44ax9EwJEA6gmh0bWrYQO6n82V
	0i+cKbUOwapB91DW4zIVS9A/x9hsogoWTWmjKyvI8nTLEEqvNCzzH52DokTioLTFObq0JJV
	r0fGxnnzQOZfuv+95yFBN25HjD0sBIH4CRnSHxNlIJ+ki9Ad9Cf1yY1LtJtxHgHfrL8wKAD
	0+Ry+pagvKzmvnfVLWpYgcmGqevySX/z9TExwX3jtyGJMDAdwsZJLFryDPMCTki6qQeRgg5
	De946kd6KYKALjYDeGFuu7woH6BSH3QXbWNuTrglDc7tSlndrkdsh+1YSjBYsTnrB8ki523
	Awx15oAQYyeIETW/tQ0za+SVDB4POMmCWlUP7PQrwOojwib5DxLZ9F9mBFRZaTrY9VFSq2x
	rylPq37z48uRbR6hjchjAsvJEyhtLAvTlAeVMUdo8TUuaJPhC4Q1d0g7bLPd5z+e0422uHv
	yPSYeFq2rVdt7QBKsw2R0Y=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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
index 4615c4b161a0..6860714fb61e 100644
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
@@ -405,6 +454,8 @@ static int riscv_iommu_hpm_event_init(struct perf_event *event)
 	}
 
 	if (!is_software_event(event->group_leader)) {
+		if (!riscv_iommu_hpm_events_compatible(event->group_leader, event))
+			return -EINVAL;
 		if (++group_num_events > iommu_hpm->num_counters)
 			return -EINVAL;
 	}
@@ -412,6 +463,8 @@ static int riscv_iommu_hpm_event_init(struct perf_event *event)
 	for_each_sibling_event(sibling, event->group_leader) {
 		if (is_software_event(sibling))
 			continue;
+		if (!riscv_iommu_hpm_events_compatible(sibling, event))
+			return -EINVAL;
 		if (++group_num_events > iommu_hpm->num_counters)
 			return -EINVAL;
 	}
@@ -729,6 +782,8 @@ static int riscv_iommu_hpm_register_unit(struct riscv_iommu_device *iommu,
 	bitmap_zero(iommu_hpm->used_counters, RISCV_IOMMU_HPMCOUNTER_MAX);
 	bitmap_zero(iommu_hpm->supported_events, RISCV_IOMMU_HPMEVENT_MAX);
 
+	iommu_hpm->global_filter = of_device_is_compatible(dev->of_node,
+							   "spacemit,t100");
 	riscv_iommu_hpm_writel(iommu_hpm,
 			       RISCV_IOMMU_REG_IOCOUNTINH, 0xFFFFFFFF);
 	val = riscv_iommu_hpm_readl(iommu_hpm,
@@ -793,8 +848,9 @@ static int riscv_iommu_hpm_register_unit(struct riscv_iommu_device *iommu,
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

