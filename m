Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C946D2D1303;
	Wed,  1 Jul 2026 03:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878102; cv=none; b=NHCiREocxHghm4sIiep/lagi1WVnjG1XwvIpESAeMxUJxIQrv5doTqRnduWtyxEd+5bLfcPGlhaSbONiEvF8Uk/9Fjr1+h0utY3wpyHGqjRvISBlodWoWcan1fMxKorJyoNXlMgU8w6/2XqXWWt+ULGMnSlJ8Y9h3JpgwHBTEjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878102; c=relaxed/simple;
	bh=t5yQ/MUBnZ3uxj+UmQyRpJStf1mMklbsiACDlinDIYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jDwHxbptcJNeAhYW4KwrhoAcd8etlXXITu2786nyluIIz7WQABgIIgBoDyRiMAkGJGoEFj+5z7Wict/qUMV7BU7EJDfxJTlJoDWJWeS4oPZXjGNspsGIiHYXgoNBqkTa2ryti2fzqSjov5zeWBoCw9LRhBBWso72HiqLqLF3YNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gqmNs2GdkzKHMWM;
	Wed,  1 Jul 2026 11:54:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 610984056F;
	Wed,  1 Jul 2026 11:54:46 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBXiyWAj0RqCne9AQ--.26189S17;
	Wed, 01 Jul 2026 11:54:46 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Namhyung Kim <namhyung@kernel.org>,
	james.clark@linaro.org,
	xueshuai@linux.alibaba.com,
	Li Huafei <lihuafei1@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	leo.yan@linux.dev,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH v3 15/21] perf annotate-arm64: Support store instruction tracking
Date: Wed,  1 Jul 2026 03:53:49 +0000
Message-Id: <20260701035355.752944-16-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701035355.752944-1-wutengda@huaweicloud.com>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBXiyWAj0RqCne9AQ--.26189S17
X-Coremail-Antispam: 1UD129KBjvJXoW7CFy7Jr45Zw1ruF48KF1rZwb_yoW8Zw4Upa
	yqk34rKr42qrsYqrnxZF47Wr9xua1fJw4Ykry3AwsIyF42yrn3tFZ5KF42kFWrJrZxCw1U
	Zw1DKr4DZ3yIkaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6x
	kF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkF7I0Ew4C26cxK6c8Ij28IcwCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
	cVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0piPkusUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Extend update_insn_state() for arm64 to handle store (STR) instructions.

Unlike load instructions, store operations do not change the data type
of the registers involved. However, arm64 store instructions sometimes
use pre-index or post-index addressing modes (e.g., str x1, [x0, #8]!),
which modify the base register as a side effect of the memory access.

Call adjust_reg_index_state() for store instructions to ensure the
base register's offset is correctly updated in the type state. This
maintains synchronization between the hardware register state and the
instruction tracker's model during sequential memory operations.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/perf/util/annotate-arch/annotate-arm64.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index b48545f35620..f283596bb058 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -430,7 +430,7 @@ static void update_insn_state_arm64(struct type_state *state,
 	 * the destination register itself to prevent incorrect type propagation.
 	 */
 	if (has_reg_type(state, dst->reg1) &&
-	    strncmp(dl->ins.name, "ld", 2)) {
+	    strncmp(dl->ins.name, "ld", 2) && strncmp(dl->ins.name, "st", 2)) {
 		pr_debug_dtp("%s [%x] invalidate reg%d\n",
 			     dl->ins.name, insn_offset, dst->reg1);
 		invalidate_reg_state(&state->regs[dst->reg1]);
@@ -442,6 +442,16 @@ static void update_insn_state_arm64(struct type_state *state,
 		update_load_insn_state(state, dl, src, dst);
 		return;
 	}
+
+	/* Register to memory transfers */
+	if (!strncmp(dl->ins.name, "st", 2)) {
+		/*
+		 * Store instructions do not change the register type,
+		 * but the base register must be updated for pre/post-index
+		 * modes.
+		 */
+		adjust_reg_index_state(state, dst, "str", insn_offset);
+	}
 }
 #endif
 
-- 
2.34.1

