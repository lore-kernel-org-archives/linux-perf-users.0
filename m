Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BEC36C5B4;
	Wed,  1 Jul 2026 03:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878100; cv=none; b=Cprs9qAHGkxWCSSs+RyrCwOjqwFgbIn0YG4zb3PGfpXI/JVBJYiHH0Byjn462uHWCfTImtreuQ6BEmV+Wc8X5J3jAVTTAMPIYNrlPFEiDZd8i2M1lZu4v/0a1uu/QQTaUOhmrYsHPTp6U6gzF5FGwiSlrfzegdn3pm7zU34cAIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878100; c=relaxed/simple;
	bh=w7xBSfnJPLMyPT1K8WFaqKtbccpqenIaNFSPlcXOr4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uwD3UBrWNVJi4P5gsAXxoL2jjbRQ7ZCyXIyolI6bfNUFCESa2dP2nSXF71ArKkwMrnNz1kbwzEsFf/g5vyXSLEarh0P8T9V0rCTqucatBzo9K7Pzf81oVwwib7G1QzTIZOnAB3m4eL0oPriSYyHBqa7fRVTpwBroATKTbS4WUiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gqmNr02nYzKHMS1;
	Wed,  1 Jul 2026 11:54:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 134FE40570;
	Wed,  1 Jul 2026 11:54:45 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBXiyWAj0RqCne9AQ--.26189S3;
	Wed, 01 Jul 2026 11:54:44 +0800 (CST)
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
Subject: [PATCH v3 01/21] perf capstone: Fix kernel map reference count leak
Date: Wed,  1 Jul 2026 03:53:35 +0000
Message-Id: <20260701035355.752944-2-wutengda@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgBXiyWAj0RqCne9AQ--.26189S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AF18Ww17Ary8uw4xtr48tFb_yoW8urW5pw
	sakw1rJa1kJw13G39xJanYqry3urZ5JF4fKasFkr1Fyrn5XrnxtayxKa45tF1UJrWkGr15
	Arn09ry5Wr98tF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I
	0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
	8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41l
	IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIx
	AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0piLvtZUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

In print_capstone_detail(), maps__find() is used to locate the kernel
map. This function increments the reference count of the found map
object. However, the current implementation fails to call map__put()
after the map is no longer needed, leading to a reference count leak.

Fix this by adding a map__put(map) call to properly release the
reference after use.

Fixes: 92dfc59463d5 ("perf annotate: Add symbol name when using capstone")
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/perf/util/capstone.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index 5ad537fea436..9bba78ee0c5a 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -302,6 +302,7 @@ static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
 	for (i = 0; i < insn->detail->x86.op_count; i++) {
 		struct cs_x86_op *op = &insn->detail->x86.operands[i];
 		u64 orig_addr;
+		struct map *found_map = NULL;
 
 		if (op->type != X86_OP_MEM)
 			continue;
@@ -317,19 +318,22 @@ static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
 		if (dso__kernel(map__dso(map))) {
 			/*
 			 * The kernel maps can be split into sections, let's
-			 * find the map first and the search the symbol.
+			 * find the map first and then search the symbol.
 			 */
-			map = maps__find(map__kmaps(map), addr);
-			if (map == NULL)
+			found_map = maps__find(map__kmaps(map), addr);
+			if (found_map == NULL)
 				continue;
+			map = found_map;
 		}
 
 		/* convert it to map-relative address for search */
 		addr = map__map_ip(map, addr);
 
 		sym = map__find_symbol(map, addr);
-		if (sym == NULL)
+		if (sym == NULL) {
+			map__put(found_map);
 			continue;
+		}
 
 		if (addr == sym->start) {
 			scnprintf(buf, len, "\t# %"PRIx64" <%s>",
@@ -338,6 +342,7 @@ static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
 			scnprintf(buf, len, "\t# %"PRIx64" <%s+%#"PRIx64">",
 				  orig_addr, sym->name, addr - sym->start);
 		}
+		map__put(found_map);
 		break;
 	}
 }
-- 
2.34.1

