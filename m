Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E1A137923;
	Fri,  7 Aug 2026 08:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093018; cv=none; b=sW8WXOzEq8Fq0JHGS3KTdhHyFZKv6TJLUzqxtvpXkgdxwjcZtzC3ijo/YMkV1HBc4rUrrzqXC1zb1CDpJsGcCxf3AttOyZQkDONHCkp91VFngzVPiWoIs0BNSMhO3khNcNgZNv00sIzYHZvcgFvTvwrifhyLaG1yV8pj5EhXz5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093018; c=relaxed/simple;
	bh=8mTkfPa8lNb58ev0/Ci5vY7QQedlwltXMKyGqkFedl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BI83vs9STzZ71Gn8ZXGX87nHu8p/vXtnBRrDDZlPw/VFIyRSU0FGNvtTW6B7PUTuV8w38vFXB+pG3h2OYhsCoABCz5oHjDUw8/bgS6BU5p9NmfkLsBARcgy3iMAu0YOQphtat7MPwVz4LHaMftaLBwtzn+6XfbOZQpyaHRNsatk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ed0d6dca923d11f1aa26b74ffac11d73-20260807
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:1adf90be-9f8f-4d82-875a-954d73fa9df5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:6f955b953f9425a81cb56d0c364a5a04,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|865|898,TC:nil,Content:0|15|50
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ed0d6dca923d11f1aa26b74ffac11d73-20260807
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1557473672; Fri, 07 Aug 2026 16:56:49 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-riscv@lists.infradead.org
Cc: atish.patra@linux.dev, anup@brainfault.org, will@kernel.org, mark.rutland@arm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v1 1/2] perf: RISC-V: use BIT_ULL for u64 overflow masks
Date: Fri, 07 Aug 2026 16:50:00 +0800
Message-ID: <prpmask01bitul.1786092600.git.liuxixin@kylinos.cn>
In-Reply-To: <cover.1786092600.git.liuxixin@kylinos.cn>
References: <cover.1786092600.git.liuxixin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py

Overflow status and restart masks are u64, but bits were built with
BIT(). On RV32 that is an unsigned long shift, so indices >= 32 truncate
or wrap and corrupt the mask.

Use BIT_ULL() for those u64 bitops.

Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
---
 drivers/perf/riscv_pmu_sbi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index dfc886dee..93a31d5d5 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -1002,7 +1002,7 @@ static inline void pmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_events *cpu_hw_
 	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
 
 	for_each_set_bit(idx, cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS) {
-		if (ctr_ovf_mask & BIT(idx)) {
+		if (ctr_ovf_mask & BIT_ULL(idx)) {
 			event = cpu_hw_evt->events[idx];
 			hwc = &event->hw;
 			max_period = riscv_pmu_ctr_get_width_mask(event);
@@ -1109,14 +1109,14 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 			hidx = info->csr - CSR_CYCLE;
 
 		/* check if the corresponding bit is set in scountovf or overflow mask in shmem */
-		if (!(overflow & BIT(hidx)))
+		if (!(overflow & BIT_ULL(hidx)))
 			continue;
 
 		/*
 		 * Keep a track of overflowed counters so that they can be started
 		 * with updated initial value.
 		 */
-		overflowed_ctrs |= BIT(lidx);
+		overflowed_ctrs |= BIT_ULL(lidx);
 		hw_evt = &event->hw;
 		/* Update the event states here so that we know the state while reading */
 		hw_evt->state |= PERF_HES_STOPPED;

