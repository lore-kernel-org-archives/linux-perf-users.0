Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77830414A21;
	Sat,  8 Aug 2026 12:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786193076; cv=none; b=fFXDrwaPUABTfpZd7YxcNCMdZKY2hhgjexis5oxLGCEFCIP5O7E+28tVaNnyOs55Eo2KspZX9EYvMtmIL0KLAcV292zsLth/j+K2fpOKNjFYm0iOCf8GES/KQ7AO7siO8p10MBMhLPmgtbeuvwrhCW5+huaJKzeJyWVkBOHdEN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786193076; c=relaxed/simple;
	bh=fgjFC7OTBNn6kbehtQ5xn7LKorTtVxFcSxZLVls5MdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tiSijlveE5R4Oi0QGQunWQuLLw88cFdKZCCR/a1TLf8TV7L0XQiY2dYVIYUYHaeKBVjC0rZIDBnHjXVvhB8mUJuPQ9nq6GbEQO0l6v4qEdwHNbgPEQUhn9tvuRAM1cSWrZiUtSMyoO4me8jkwiZvAOFBKl4/fcv+TascxQooLGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hHKvB2l5czKHMnt;
	Sat,  8 Aug 2026 20:24:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 7E4E240571;
	Sat,  8 Aug 2026 20:24:17 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgB34YjkH3dqbrhMBg--.41805S4;
	Sat, 08 Aug 2026 20:24:17 +0800 (CST)
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
Subject: [PATCH v4 02/23] perf llvm: Fix arm64 adrp instruction disassembly mismatch with objdump
Date: Sat,  8 Aug 2026 12:23:39 +0000
Message-Id: <20260808122400.2961238-3-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260808122400.2961238-1-wutengda@huaweicloud.com>
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgB34YjkH3dqbrhMBg--.41805S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWryxGr4xuw48Zr4xCFykKrg_yoW5ZF4fpr
	ZFka95Jry5Ar1fZ39IkF47WFn0yrZ2gF45K3y3ArWvkr4ftFyxC34xGry29F1DXryqq3y5
	ArZIvFyUGF4kArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQCb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I
	0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
	8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41l
	IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMI
	IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRQL00DUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

The operands of 'adrp' instructions parsed by libllvm are currently
represented as raw immediates rather than the "address <symbol+offset>"
format used by objdump. This inconsistency causes arm64_mov__parse()
to fail when parsing these instructions during post-processing.

Example of the mismatch:
  Current: adrp  x18, 8014
  Fix:     adrp  x18, ffff800081f5f000 <this_cpu_vector>

Fix this by manually extracting the target address from the raw adrp
instruction via symbol_lookup_callback(). The address is then converted
to a specific symbol during symbol__disassemble_llvm() and formatted
to match objdump's output, ensuring compatibility with existing
parsers.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/perf/util/llvm.c | 50 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
index a0deb742a733..6b53b283205a 100644
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
@@ -230,10 +242,40 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 		if (storage.pcrel_load_addr != 0) {
 			char *name = llvm_name_for_data(dso, filename,
 							storage.pcrel_load_addr);
-			disasm_len += scnprintf(disasm_buf + disasm_len,
-						sizeof(disasm_buf) - disasm_len,
-						"  # %#"PRIx64,
-						storage.pcrel_load_addr);
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
+							storage.pcrel_load_addr);
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
 			if (name) {
 				disasm_len += scnprintf(disasm_buf + disasm_len,
 							sizeof(disasm_buf) -
-- 
2.34.1

