Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F145476FF;
	Tue,  8 Sep 2026 13:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872531; cv=none; b=auKCaNKaX/6oi4xKmZEvqg1vufVrwTr6z7TriqcHFy3c79iG/ImzJtTMy/qsraOIyaX+8hctLgppqGm0dcfsWgjH1tMvYb1SqjPFuQUpWb0i90OJxED3dE3XY+He40lnIAEo80ndpETo0YJMoC8BZX9phK9zwYqghFBSFV0n+5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872531; c=relaxed/simple;
	bh=fgbY3JZBvtsCnq90YEDKMOwFNCgu21d8iZAsVzQ8+oY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZPNij//jacirrfZvIkGdfPxe2dvhUEPCkhBcsiyPczbtrJH+wCdtNKSYRmJXk6uePbY2voSA+5lHiMzGmIqKMhyu3UA2jJ4ftbNwM3WuIZ2qWPGTt3QWXydpohAWq+OfG302jzVIVwruhisBNAKAzFjvqA6Y3LMW6DF0NhMAmK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=fail smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hfPFT5mVmzYQvRD;
	Tue,  8 Sep 2026 21:01:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4FE7740574;
	Tue,  8 Sep 2026 21:01:53 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAni5gpB6BqC9rlBA--.34632S4;
	Tue, 08 Sep 2026 21:01:52 +0800 (CST)
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
Subject: [PATCH v5 02/26] perf llvm: Fix arm64 adrp instruction disassembly mismatch with objdump
Date: Tue,  8 Sep 2026 13:00:58 +0000
Message-Id: <20260908130122.633500-3-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908130122.633500-1-wutengda@huaweicloud.com>
References: <20260908130122.633500-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAni5gpB6BqC9rlBA--.34632S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWryxGryUCF1fAF43uF1fCrg_yoW5ur45pr
	ZFkFZ5Xry5Ar1Sv39IkF47Wrn0yrZ2gF4Yg3y3ArWvkr4ftF97C3yxGFy29F1UXryvq3y5
	CrZ0vFyUGF1kArJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r4a6rW5MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sR_yv3UUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

The operands of 'adrp' instructions parsed by libllvm are currently
represented as raw immediates rather than the "address <symbol+offset>"
format used by objdump. This inconsistency causes arm64_mov__parse()
to fail when parsing these instructions during post-processing.

Example of the mismatch:
  Current: adrp  x18, 8014
  Objdump: adrp  x18, ffff800081f5f000 <this_cpu_vector>

Fix this by manually extracting the target address from the raw adrp
instruction via symbol_lookup_callback(). The address is then converted
to a specific symbol during symbol__disassemble_llvm() and formatted
to match objdump's output, ensuring compatibility with existing
parsers.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/perf/util/llvm.c | 52 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
index a0deb742a733..a78845689aa1 100644
--- a/tools/perf/util/llvm.c
+++ b/tools/perf/util/llvm.c
@@ -9,8 +9,10 @@
 #include "symbol.h"
 #include <errno.h>
 #include <fcntl.h>
+#include <string.h>
 #include <unistd.h>
 #include <linux/zalloc.h>
+#include <linux/bitops.h>
 
 #ifdef HAVE_LIBLLVM_SUPPORT
 #include "llvm-c-helpers.h"
@@ -108,6 +110,16 @@ symbol_lookup_callback(void *disinfo, uint64_t value,
 		storage->branch_addr = value;
 	else if (*ref_type == LLVMDisassembler_ReferenceType_In_PCrel_Load)
 		storage->pcrel_load_addr = value;
+	else if (*ref_type == LLVMDisassembler_ReferenceType_In_ARM64_ADRP) {
+		uint64_t adrp_imm;
+
+		/* immhi (bits 23:5) and immlo (bits 30:29) */
+		adrp_imm = ((value & 0x00ffffe0) >> 3) | ((value >> 29) & 0x3);
+		adrp_imm = sign_extend64(adrp_imm, 20);
+
+		/* Calculate the target page address */
+		storage->pcrel_load_addr = (address & ~0xfffULL) + (adrp_imm << 12);
+	}
 	*ref_type = LLVMDisassembler_ReferenceType_InOut_None;
 	return NULL;
 }
@@ -228,12 +240,42 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 			}
 		}
 		if (storage.pcrel_load_addr != 0) {
-			char *name = llvm_name_for_data(dso, filename,
+			char *name;
+
+			if (arch__is_arm64(args->arch)) {
+				/*
+				 * For arm64, replace the immediate operand with
+				 * the resolved address to match objdump's output.
+				 *
+				 * Example conversion:
+				 *   From: adrp  x18, 8014
+				 *   To:   adrp  x18, ffff800081f5f000
+				 */
+				char *s = strchr(disasm_buf, ',');
+
+				if (s == NULL)
+					goto err;
+
+				s++;
+				*s = '\0';
+				disasm_len = strlen(disasm_buf);
+				disasm_len += scnprintf(disasm_buf + disasm_len,
+							sizeof(disasm_buf) - disasm_len,
+							" %"PRIx64,
 							storage.pcrel_load_addr);
-			disasm_len += scnprintf(disasm_buf + disasm_len,
-						sizeof(disasm_buf) - disasm_len,
-						"  # %#"PRIx64,
-						storage.pcrel_load_addr);
+			} else {
+				/*
+				 * For other archs, append the resolved address
+				 * as an inline comment.
+				 */
+				disasm_len += scnprintf(disasm_buf + disasm_len,
+							sizeof(disasm_buf) - disasm_len,
+							"  # %#"PRIx64,
+							storage.pcrel_load_addr);
+			}
+
+			/* Append the resolved symbol name if available */
+			name = llvm_name_for_data(dso, filename, storage.pcrel_load_addr);
 			if (name) {
 				disasm_len += scnprintf(disasm_buf + disasm_len,
 							sizeof(disasm_buf) -
-- 
2.34.1

