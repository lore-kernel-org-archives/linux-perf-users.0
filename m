Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795763454;
	b=RarxZPPSmenIHmtVq/ee0SrkLcjz93xFAEbrJh9TDZdWnwyeS/VqebJwTmF1v/1tXQyc
	 7s0lH93EzfuJj9Zn7p/U+HD+AZg/smguaq3zTQ51/kpkNFxn2/vdVQSk603bx8EnZO+63
	 fvNFQUi2q6zKEhhjcHygXW0phfW+rdRkJ4VU5z25o3/xHY1ke5ufkoSD/MbgyriLxau+U
	 IZWbX9ZF8ENgM0PTFMGSXMhs4z4ZC8U7Mif3jNwmE8niY+bkvIHBcblokVoPxHmjzovIA
	 pmbWsMCnV3URlNQpyYB9Okty8ESMdkfa6BbHVRF239pPoQRq64XabdttNZ6En1o2AOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795763454;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BmIMXQgJGIIqJkFNfsmR4WcLiXrFcXVgQaaICBnrIt4=;
	b=sTECvxqwWyHu81F4s5aVGPnaw30KoccZ36WJXCsY5svUfBNQJc0WT6M5HgsSiP4OmMrI
	 FmEn4sjbKGwGBcBfuYHwauZEJxaGGTlYJaMKZPUJ8N4bvYOwHjy17LMMrKJ2rwNfsWTKO
	 hZOn2s2K3s4/34GIFklBxQWycNSoD9UAHCh3t47jm4veR2CagG1xghv0XArd3Pv8Mroue
	 PETNeVFz0XQBCHoBVeL99xZFMQM7pkwD6Xm902RuGIyOIxlSCVJJwFpARzLtMoJzB79oR
	 YEorecpTcBCxHkRtDRZP4ROpj3cIj6+lwHoxR0zrhtWPZWKv+Gri6tE4PQEXU0HZwgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eEdpprqI;
	arc=none smtp.remote-ip=115.124.30.133
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEFD606A31C;
	Fri, 27 Nov 2026 07:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BEFD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eEdpprqI
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795763445; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=BmIMXQgJGIIqJkFNfsmR4WcLiXrFcXVgQaaICBnrIt4=;
	b=eEdpprqIyC6LP7dUxYTE5Fncyzv4FtLnEoVz6gEl/5mJBFyPJ2gUOCl9iOopB6x+wXG8F0JgtxG7RSEmyWnVQy+jvhQcD7s8FvvE5ExnH0kd1S2nK4m2USMLBASUf37ZgbCUw0H6NZ1rIzJvB0Krsu3aPD5AhFWs1N/R7aCw6jw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=jiangtianfeng@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XFX36RJ_1795763438;
Received: from h68d07384.sqa.eu95.tbsite.net(mailfrom:jiangtianfeng@linux.alibaba.com fp:SMTPD_---0XFX36RJ_1795763438 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Nov 2026 15:10:44 +0800
From: Jiangtian Feng <jiangtianfeng@linux.alibaba.com>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jiangtianfeng@linux.alibaba.com
Subject: [PATCH 2/2] perf/arm_cspmu: nvidia: Fix TGT address-filter slot lifecycle
Date: Fri, 27 Nov 2026 15:10:10 +0800
Message-ID: <20261127071021.820833-3-jiangtianfeng@linux.alibaba.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127071021.820833-1-jiangtianfeng@linux.alibaba.com>
References: <20261127071021.820833-1-jiangtianfeng@linux.alibaba.com>
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

The current lookup returns a free slot before checking later slots for
an identical active filter. After another filter is stopped, a new event
can therefore occupy a different slot from an existing identical filter.
Reset then searches only by base/mask and can release the wrong slot.

Reset also matches zeroed metadata from free slots and decrements their
refcount without checking occupancy. A zero base/mask filter can thus
underflow a free slot's refcount when another filter is stopped first.
Cycle events never allocate an address-filter slot, but their stop path
can still call reset and release another event's filter.

First match an active filter so identical filters share one slot. Only
allocation searches for a free slot afterward. Reset must match an active
slot, and cycle events return without resetting an address filter. This
keeps zero base/mask as valid filter data and does not change the shared
PMU callback ABI.

Qoder, an AI coding assistant, helped analyze the issue, develop the fix
and source-derived state model, and draft this description.

Fixes: 3dd73022306b ("perf/arm_cspmu: nvidia: Add Tegra410 PCIE-TGT PMU")
Signed-off-by: Jiangtian Feng <jiangtianfeng@linux.alibaba.com>
---
 drivers/perf/arm_cspmu/nvidia_cspmu.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.c b/drivers/perf/arm_cspmu/nvidia_cspmu.c
index a0257dc3249d..1e9e52cbec09 100644
--- a/drivers/perf/arm_cspmu/nvidia_cspmu.c
+++ b/drivers/perf/arm_cspmu/nvidia_cspmu.c
@@ -589,7 +589,7 @@ static struct pcie_tgt_data *pcie_tgt_get_data(struct arm_cspmu *cspmu)
 	return ctx->data;
 }
 
-/* Find the first available address filter slot. */
+/* Find an active matching filter or a free slot for allocation. */
 static int pcie_tgt_find_addr_idx(struct arm_cspmu *cspmu, u64 base, u64 mask,
 	bool is_reset)
 {
@@ -597,11 +597,17 @@ static int pcie_tgt_find_addr_idx(struct arm_cspmu *cspmu, u64 base, u64 mask,
 	struct pcie_tgt_data *data = pcie_tgt_get_data(cspmu);
 
 	for (i = 0; i < NV_PCIE_TGT_ADDR_COUNT; i++) {
-		if (!is_reset && data->addr_filter[i].refcount == 0)
+		if (data->addr_filter[i].refcount > 0 &&
+		    data->addr_filter[i].base == base &&
+		    data->addr_filter[i].mask == mask)
 			return i;
+	}
+
+	if (is_reset)
+		return -ENODEV;
 
-		if (data->addr_filter[i].base == base &&
-			data->addr_filter[i].mask == mask)
+	for (i = 0; i < NV_PCIE_TGT_ADDR_COUNT; i++) {
+		if (data->addr_filter[i].refcount == 0)
 			return i;
 	}
 
@@ -748,6 +754,10 @@ static void pcie_tgt_pmu_reset_ev_filter(struct arm_cspmu *cspmu,
 	u64 base, mask;
 	int idx;
 
+	/* Cycle events never allocate an address-filter slot. */
+	if (event->hw.extra_reg.idx == cspmu->cycle_counter_logical_idx)
+		return;
+
 	addr_filter_en = pcie_tgt_pmu_addr_en(event);
 	if (!addr_filter_en)
 		return;
-- 
2.47.3

