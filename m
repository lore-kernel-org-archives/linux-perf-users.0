Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0303536E489;
	Fri,  7 Aug 2026 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093018; cv=none; b=ExX+YltwcqblPCxGB1Z0XCoQ8cQOJjO3a9npAiPOf4wgzQY7RmIN9CsjP3WGmwTqjGCPutVisvLXrHfl+e1jYhne9m87xpdB74sSLho3qSxO2fxNgpeGRRjVWYvPpWGxDRkaUqOO2Oi3wl+PwTcf+CejyVdDsAvVUmm7T5u0rJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093018; c=relaxed/simple;
	bh=VIAQi57asQHh4Zub9X9yU7pZoBu8qDZG910fm2mNhfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dj0cTSTg4ZadhZdGDCOd/d8+UptD/NLsMREcQfAxr3F69POV71366Nnddsd4UF2+V8gd/2LiqZOf13HWjJaey1bqZk2mLx6Vje5PFbHafJ8mKWjujjfQvO1H5hn8si3DLMSOWYrM/M1jb6SDfNOMf9fQpK8aO72fWXQdfVSqfZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ebb01f68923d11f1aa26b74ffac11d73-20260807
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:4eeddb90-fa73-474a-986e-260bf26ea54f,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:234afb9af18c4a6d3f3da314451f87e8,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ebb01f68923d11f1aa26b74ffac11d73-20260807
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 186140113; Fri, 07 Aug 2026 16:56:47 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-riscv@lists.infradead.org
Cc: atish.patra@linux.dev, anup@brainfault.org, will@kernel.org, mark.rutland@arm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v1 0/2] perf: RISC-V: fix SBI PMU masks for RV32
Date: Fri, 07 Aug 2026 16:50:00 +0800
Message-ID: <cover.1786092600.git.liuxixin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py

Hi,

This series fixes two RV32 mask-width issues in the SBI PMU driver:

  1) Overflow status / restart tracking is u64 but used BIT(), which is
     an unsigned long shift and breaks for indices >= 32 on RV32
  2) The available-counter mask was a single unsigned long while
     iteration uses RISCV_MAX_COUNTERS (64), so RV32 can read past the
     object; store it as a DECLARE_BITMAP

Patches are independent. Please review.

Thanks,
Xixin Liu

---

Xixin Liu (2):
  perf: RISC-V: use BIT_ULL for u64 overflow masks
  perf: RISC-V: store available counter mask as bitmap

 drivers/perf/riscv_pmu_legacy.c |  5 +++--
 drivers/perf/riscv_pmu_sbi.c    | 35 ++++++++++++++++++++++------------
 include/linux/perf/riscv_pmu.h  |  2 +-
 3 files changed, 27 insertions(+), 15 deletions(-)

-- 
2.43.0

