Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3825505FB;
	Tue,  8 Sep 2026 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872748; cv=none; b=RmOwQIUAZSGC6d7bq20cpSaxwP7zIocuefgn0XixP+yrHF19keEizwBcSekiaWUaSog/imnEH7F9izugx8S/bYqXtXhgIHEqApA/vAvrf1W0sbaYfiPGoLMvd4CPcRuLQ2VLh1axm4OmTPnk+d1pWcsOee4IuGd3r7JmjQVHHLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872748; c=relaxed/simple;
	bh=fgbY3JZBvtsCnq90YEDKMOwFNCgu21d8iZAsVzQ8+oY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ua04g52nWB2+cd+EyK8KxQ3RJAJGIx/l2LMWPjfcSA7x+iLCMvbrsdfy4CmGzTPowBt2xhHLQbviWbDDnHASgej/5gwZE1j9T/0fzdGCvRBUKztzxAcMKI6hXqFMd7s8u9yB6dGll/c2YhfC43ZN9udANov2JpOR1ibNobKalvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hfPKt6TmWzYQw0V;
	Tue,  8 Sep 2026 21:04:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 6538640578;
	Tue,  8 Sep 2026 21:05:42 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgDHLUoeCKBqX3XjBA--.22748S4;
	Tue, 08 Sep 2026 21:05:42 +0800 (CST)
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
Date: Tue,  8 Sep 2026 13:05:05 +0000
Message-Id: <aca3c51ca091bdf0c4b49b0721fbbf78a05abcf1.1788872630.git.wutengda@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgDHLUoeCKBqX3XjBA--.22748S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWryxGryUCF1fAF43uF1fCrg_yoW5ur45pr
	ZFkFZ5Xry5Ar1Sv39IkF47Wrn0yrZ2gF4Yg3y3ArWvkr4ftF97C3yxGFy29F1UXryvq3y5
	CrZ0vFyUGF1kArJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
	kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
	C7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26rWY6Fy7MxkF7I0Ew4C26cxK
	6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wryl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Cr1j6rxdMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWx
	JVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7sRk
	sqAUUUUUU==
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

