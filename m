Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7849A55C1A1;
	Tue,  8 Sep 2026 13:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872761; cv=none; b=pDIJ4ZCnIFypu459JkKM1NYqw2ql3qpY+/s4A1Y/LN+T5nL9ZYrt6pP31BR+1d2WceM0UlSlJW8qZpjNLmc0D1weXGa/Oc5DbSSitMz7T3ftLaWFg0/NKvtcaanv5bhVG0iry8ml8HpKCuojmP02kG72d7XnZOW1rZqa25ysyTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872761; c=relaxed/simple;
	bh=WiVkJiyLDFCwqUT2Y/Uaz10t53zYqOC8o/b/TybqJis=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vDjEKDTe6jHidtaLLTd/HN5sE3Nk62IKS5rEFOA2ApfL5DsiWk6jIjC0w2Hg/dhmiyK3WTQbljwX0iGYgvJAMjmIGnfG2Ku9XnH7FuOVuJ2v8YL3M9qH0ywpRq+ZX2dFXQ51kyzTQszPD6/zG0dNqq8vEyo4JxxWMZmFz7YS0bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hfPLt3VgczKHN8r;
	Tue,  8 Sep 2026 21:05:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id CD9F74056E;
	Tue,  8 Sep 2026 21:05:43 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgDHLUoeCKBqX3XjBA--.22748S20;
	Tue, 08 Sep 2026 21:05:43 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Namhyung Kim <namhyung@kernel.org>,
	james.clark@linaro.org,
	xueshuai@linux.alibaba.com,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Zecheng Li <zli94@ncsu.edu>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH v5 18/26] perf annotate-data: Expand type_state_reg imm_value to u64
Date: Tue,  8 Sep 2026 13:05:21 +0000
Message-Id: <288e59160bf51e04ba6112676bf8315279635d13.1788872630.git.wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDHLUoeCKBqX3XjBA--.22748S20
X-Coremail-Antispam: 1UD129KBjvJXoWxJr18try5GrW7ZF1DCr4kZwb_yoW8Cw43p3
	90k347Gw15Wr4YgrnxtFWrXFyS9F13Za4fGryYgw1fZFWSqFn3tFyIqrWYyFW8W3s7Cw1U
	JwnYgr4Dt3ykGaUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
	xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8
	JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
	AGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26rWY6Fy7MxkF7I0Ew4C2
	6cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Cr1j6rxdMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuYvj
	4E73dUUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

The arm64 'adrp + add/ldr' instruction pair involves global variable address
calculation and passing, which requires storing the 64-bit address in
type_state_reg. Currently, there is no field in type_state_reg that can
hold such an address. The most likely candidate for reuse is imm_value,
but it is defined as u32, which limits the size of values it can carry.

To address this, expand imm_value from u32 to u64. Also update related
compilation warnings and fix the sign-extension issue introduced by this
change.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/perf/util/annotate-arch/annotate-x86.c | 4 ++--
 tools/perf/util/annotate-data.h              | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
index aa381d25a63b..f5e40cef08ab 100644
--- a/tools/perf/util/annotate-arch/annotate-x86.c
+++ b/tools/perf/util/annotate-arch/annotate-x86.c
@@ -536,11 +536,11 @@ static void update_insn_state_x86(struct type_state *state,
 
 		if (src->imm) {
 			tsr->kind = TSR_KIND_CONST;
-			tsr->imm_value = src->offset;
+			tsr->imm_value = (s64)src->offset;
 			tsr->offset = 0;
 			tsr->ok = true;
 
-			pr_debug_dtp("mov [%x] imm=%#x -> reg%d\n",
+			pr_debug_dtp("mov [%x] imm=%#"PRIx64" -> reg%d\n",
 				     insn_offset, tsr->imm_value, dst->reg1);
 			return;
 		}
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index e6ca47e25e04..3bce63e23a58 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -173,7 +173,7 @@ extern struct annotated_data_stat ann_data_stat;
  */
 struct type_state_reg {
 	Dwarf_Die type;
-	u32 imm_value;
+	u64 imm_value;
 	/*
 	 * The offset within the struct that the register points to.
 	 * A value of 0 means the register points to the beginning.
-- 
2.34.1

