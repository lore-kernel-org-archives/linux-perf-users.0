Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538951A3166;
	Mon, 26 Jan 2026 03:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769398600; cv=none; b=mpRd3Dgbp7MCeX4ZkIlnSL+fUcE+eEDHX8OgkmRqL3R0wN9ssZSQAKm8NCa5OrtmL0WrmHJrKHxG1RU6i9k2avdT53zhAmcVK75x+3OLCfJkcp+9+nAZjSpnSs/BjtnbBuN0Sr8WaRDmi++0b0C5rFQWmBy9buaH/z3ta/5HVZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769398600; c=relaxed/simple;
	bh=IoL0BUFyWJmCBdkGKItuiDBMIbQjg6mvYgMEI6krK/Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGt5z7/wh23tn7gFD11DJi570xtvZkhgRWz/A1zANYFOH0nt+yZNoMGYx8OR2i0in9/9QLWRl68wupCAAtBO4BOx0GESEHmPyDX/1fA1dOpvevXbuHquC7H/YQUmF7iQJ07Ts5GfBN3PKxCcaStWekt9gy7sl8nSX9pzKG1iFj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b=rq1Rf5ZT; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b="rq1Rf5ZT"
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 60Q3UW8q017213;
	Mon, 26 Jan 2026 11:30:32 +0800 (+08)
	(envelope-from baisheng.gao@unisoc.com)
Received: from SHDLP.spreadtrum.com (zeshmbx08.spreadtrum.com [10.29.3.106])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4dzv6J0x1jz2P3QY8;
	Mon, 26 Jan 2026 11:24:40 +0800 (CST)
Received: from BJ15137PCW.spreadtrum.com (10.0.73.52) by
 zeshmbx08.spreadtrum.com (10.29.3.106) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Mon, 26 Jan 2026 11:30:30 +0800
From: Baisheng Gao <baisheng.gao@unisoc.com>
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        Mark
 Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <cixi.geng@linux.dev>, <hao_hao.wang@unisoc.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 1/2] perf/arm-ni: Don't crash in probing clock domains without a PMU instance
Date: Mon, 26 Jan 2026 11:30:28 +0800
Message-ID: <20260126033029.7923-2-baisheng.gao@unisoc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126033029.7923-1-baisheng.gao@unisoc.com>
References: <20260126033029.7923-1-baisheng.gao@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 zeshmbx08.spreadtrum.com (10.29.3.106)
X-MAIL:SHSQR01.spreadtrum.com 60Q3UW8q017213
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
	s=default; t=1769398245;
	bh=JJznXfRb1ExPhgEM/qLqi6O5sc5Mc/cQpjqasq10Kfc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=rq1Rf5ZTNsTGKtBFW9tmJo2IU65pSOJ9P5RWdq5PhbZQugVhnOtuHcwkhL8lC9BMf
	 ezheTT0OGk8iXcymBvNZHtWqGHT2thuRfSP1Cq1Q1L3db+zT7Ndy3RqHlj1PdWkGVc
	 nyqoso80N4mnPOtQeVas6imtdY/S+Um0+sXQ+cifXxPK+Y3v41nFwVvF4opsPu346M
	 MFHc/g1eMdywB/YxuolBD2jywyRhau0HKvBJwcIvlo5QU7nziSMHf5agQfQtsOALMc
	 lrX+0s7EJCWvs1BjhuD0Xk66Wq4l9SC9UqlxV14WvOLvrrQTOMcMagUswUoeUz+Sh1
	 xqz3VFumlODxg==

The NULL pmusela pointer implies that current clock domain doesn't have
a PMU instance. Return 0 for probing the next clock domain. Otherwise a
kernel crash will happen.

Signed-off-by: Baisheng Gao <baisheng.gao@unisoc.com>
---
 drivers/perf/arm-ni.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm-ni.c b/drivers/perf/arm-ni.c
index 66858c65215d..53b656983da1 100644
--- a/drivers/perf/arm-ni.c
+++ b/drivers/perf/arm-ni.c
@@ -526,6 +526,7 @@ static int arm_ni_init_cd(struct arm_ni *ni, struct arm_ni_node *node, u64 res_s
 {
 	struct arm_ni_cd *cd = ni->cds + node->id;
 	const char *name;
+	static atomic_t id;
 
 	cd->id = node->id;
 	cd->num_units = node->num_components;
@@ -562,6 +563,11 @@ static int arm_ni_init_cd(struct arm_ni *ni, struct arm_ni_node *node, u64 res_s
 		case NI_TMNI:
 		case NI_CMNI:
 			unit->pmusela = arm_ni_get_pmusel(ni, unit_base);
+			if (!unit->pmusela) {
+				dev_info(ni->dev, "No have PMU %d\n", cd->id);
+				devm_kfree(ni->dev, cd->units);
+				return 0;
+			}
 			writel_relaxed(1, unit->pmusela);
 			if (readl_relaxed(unit->pmusela) != 1)
 				dev_info(ni->dev, "No access to node 0x%04x%04x\n", unit->id, unit->type);
@@ -591,7 +597,7 @@ static int arm_ni_init_cd(struct arm_ni *ni, struct arm_ni_node *node, u64 res_s
 	writel_relaxed(U32_MAX, cd->pmu_base + NI_PMCNTENCLR);
 	writel_relaxed(U32_MAX, cd->pmu_base + NI_PMOVSCLR);
 
-	cd->irq = platform_get_irq(to_platform_device(ni->dev), cd->id);
+	cd->irq = platform_get_irq(to_platform_device(ni->dev), atomic_fetch_inc(&id));
 	if (cd->irq < 0)
 		return cd->irq;
 
-- 
2.34.1

