Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5074499BF;
	Tue, 18 Aug 2026 09:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046259; cv=none; b=rozq0xQ99YFg0XicmlY4JHypbzW9QSZVLm7AHwo6/cMDKSF5VpqdG4lVqTO4P5Nv2Cij2dobyyjupEd5b7h3XKDfIMZaaoezYpg49+DkF4wRtAHzpEqxIZVo1Ol8XgnS40m/VMAP3WzkGP0V6j0rR8Sdx6KGoEFbDj9P3WoJjIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046259; c=relaxed/simple;
	bh=bmZcLFNpCxR0Qkxf+0p9ueMU7GwY0HDMguZo/mksBlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GERrjNbeVSIn1R6dOrfjfvkdDfplnXw/rsWD5dfyOp5HTWeUCvfqnyefJ8LSupVCQzw8GOmbCA3K4n6QHijfZ71E+WLeggzzbAWPtjOhvYITBnNc03Tlmn8QudyfaJYmQuZC/kwXEE/yW0U5dqhJgjfbmsCQIivEZNm74QgMrOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5d1545b29ae911f19a56ed5b684f684d-20260818
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:5e3649a9-619a-4f11-998c-1d6a987acbfb,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:7da53ff264321fd8d04a5d2fc576adea,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|865|898,TC:nil,Content:0|15|50,EDM:-3,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5d1545b29ae911f19a56ed5b684f684d-20260818
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 288946168; Tue, 18 Aug 2026 17:44:10 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-riscv@lists.infradead.org
Cc: atish.patra@linux.dev, anup@brainfault.org, will@kernel.org, mark.rutland@arm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v2 0/2] perf: RISC-V: fix SBI PMU masks for RV32
Date: Tue, 18 Aug 2026 17:10:00 +0800
Message-ID: <cover.v2.1786434000.git.liuxixin@kylinos.cn>
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

Hi,

Thanks for the review, Paul.

v2 for 1/2: add Fixes and Assisted-by. Overflow masks are u64. On RV32
an unsigned-long bit at index 32 is 0, and BIT_ULL at index 32 is
0x100000000.

v2 for 2/2: same as v1, but do not pass only the first bitmap word into
CFG_MATCH. Walk each word like the stop-all path, with the counter base
set to i times BITS_PER_LONG. Share one helper for the 32-bit argument
split. Also add Fixes and Assisted-by.

Tested on qemu-system-riscv32 with CONFIG_ARCH_RV32I=y: 34 counters,
second word 0x7, CFG_MATCH retried at base 32 when the first word fails.
qemu-system-riscv64 still uses one word. A legacy-only RV32 kernel sets
cycle and instret bits and opens a cycles event. Overflow IRQ was not
taken on this QEMU virt guest, because sscof was not available to Linux.

Thanks,
Xixin Liu

---

Xixin Liu (2):
  perf: RISC-V: use BIT_ULL for u64 overflow masks
  perf: RISC-V: store available counter mask as bitmap

 drivers/perf/riscv_pmu_legacy.c |  5 ++-
 drivers/perf/riscv_pmu_sbi.c    | 88 ++++++++++++++++++++++++++++------------
 include/linux/perf/riscv_pmu.h  |  2 +-
 3 files changed, 66 insertions(+), 29 deletions(-)

-- 
2.43.0

