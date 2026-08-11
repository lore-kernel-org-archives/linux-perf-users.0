Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F01B1F3BA4;
	Tue, 11 Aug 2026 06:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786430813; cv=none; b=m5iUMZEY68NQAqhMeIh4Tp7cZyRN+P4CDJ2h+C3OTerkDUcp2eGolzND+InObdtaSGJ9Q2zNCw0x97eC8a86WNxdd2DmMkvBtp60qS0cIuD8TfaVjigJkzjpOzYgABQ9ok1jaM2euJy/LNxQjIN3fYJiNbq/E/YTQGu0/F1V9rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786430813; c=relaxed/simple;
	bh=e5488UFZitb7gha26SyvCYFa0Rq+cewpWOxkL8RfvWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMAH+WkQifGl2hX4cFNPoe3EzyEV/rasDTk3DrNnDAq4xQwFUU/ciqlHx1D4n/ZFofJy82bUObkDsPj+l3NBGp/arZjDnhjWyeZVmBvIZ37SWzsI1IVlj92nEFeF8lc6WghhmftM5IldUlzhms+5eNG1rNjop6dO3fZVAfOrMn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6ac332b2955011f1aa26b74ffac11d73-20260811
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:a73af0d5-b5ef-4b25-adfa-b9cacb7e3291,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:fa7966228d4a12c53e14123b7712b27c,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|865|898,TC:nil,Content:0|15|50
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6ac332b2955011f1aa26b74ffac11d73-20260811
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 249032367; Tue, 11 Aug 2026 14:46:44 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-riscv@lists.infradead.org
Cc: atish.patra@linux.dev, anup@brainfault.org, will@kernel.org, mark.rutland@arm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v2 0/1] perf: RISC-V: check cpu_hw_evt before dereference in overflow IRQ
Date: Tue, 11 Aug 2026 11:51:00 +0800
Message-ID: <cover.v2.1786420235.git.liuxixin@kylinos.cn>
In-Reply-To: <prp0001riscv.1786064390.git.liuxixin@kylinos.cn>
References: <prp0001riscv.1786064390.git.liuxixin@kylinos.cn>
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

Thanks for the review, Paul.

v2 adds Fixes for the snapshot commit that introduced the early load,
and Assisted-by for DeepSeek v3 help. Code change is unchanged from v1.

Thanks,
Xixin Liu

---

Xixin Liu (1):
  perf: RISC-V: check cpu_hw_evt before dereference in overflow IRQ

 drivers/perf/riscv_pmu_sbi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.43.0

