Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ED73947A3;
	Fri,  3 Apr 2026 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775209737; cv=none; b=P5qurhQaRT2tyGySaZxXpE5G4KcAEaAuUZ7ODv3R98KWSUGhIBhBmKsS6ph4g0xxibmK7g2X+EuUTSgicyDwLHhU7bmqY/sOzfmlyDyn9ZlKykmBNkvW451Zd14Nw1rSqbZPILXeKFF0ZJlON3FpTA2I1g2UFh5JAN1438Z722w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775209737; c=relaxed/simple;
	bh=qydWQLkPkS95NbWSLGfg3tq8oFn8ZwP/dQ9wzc11y/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SISlXHf38L0fuiH0eI1ZpsPfJS9M6b7ALi2czjTXkjDmH0bz2DpA4lP8EYjpw1Osg0Dyer7uFR8DuxDFMkMkJzxtWkxmp7UWW5Y6xovk6KU8FeiSdZLGOI4FWIzVeWvbvZHv8sgcleYdE5r+BiTB85bRxRfZHiSIbRvy2p/ZbEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fnDRc3sKlzKHMVF;
	Fri,  3 Apr 2026 17:47:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 26E1940593;
	Fri,  3 Apr 2026 17:48:49 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with SMTP id _Ch0CgAnB1TwjM9p8K_UDA--.49742S3;
	Fri, 03 Apr 2026 17:48:48 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Namhyung Kim <namhyung@kernel.org>,
	leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH v2 01/16] perf llvm: Fix arm64 adrp instruction disassembly mismatch with objdump
Date: Fri,  3 Apr 2026 09:47:45 +0000
Message-Id: <20260403094800.1418825-2-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260403094800.1418825-1-wutengda@huaweicloud.com>
References: <20260403094800.1418825-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAnB1TwjM9p8K_UDA--.49742S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWryxGr4xuw48Zr1UXFW3Awb_yoW5uw43pr
	WDKayrJw4UAr1fXwsIkr47ury5CrWvqFW5Kr43ArsYkr43AFyfC34xGr429a47Xryqvw45
	Ars09FWUWF48JrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQEb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I
	0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
	8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41l
	IxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2
	z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pE9mRrUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

The operands of 'adrp' instructions parsed by libllvm are currently
represented as raw immediates rather than the "address <symbol+offset>"
format used by objdump. This inconsistency causes arm64_mov__parse()
to fail when parsing these instructions during post-processing.

Example of the mismatch:
  Current: adrp x18, 8014
  Fix:     adrp x18, ffff800081f5f000 <this_cpu_vector>

Fix this by manually extracting the target address from the raw adrp
instruction via symbol_lookup_callback(). The address is then converted
to a specific symbol during symbol__disassemble_llvm() and formatted
to match objdump's output, ensuring compatibility with existing
parsers.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/perf/util/llvm.c | 50 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
index a0deb742a733..533d47e8084d 100644
--- a/tools/perf/util/llvm.c
+++ b/tools/perf/util/llvm.c
@@ -94,6 +94,7 @@ static void init_llvm(void)
 struct symbol_lookup_storage {
 	u64 branch_addr;
 	u64 pcrel_load_addr;
+	u64 pcrel_adrp_addr;
 };
 
 static const char *
@@ -108,6 +109,18 @@ symbol_lookup_callback(void *disinfo, uint64_t value,
 		storage->branch_addr = value;
 	else if (*ref_type == LLVMDisassembler_ReferenceType_In_PCrel_Load)
 		storage->pcrel_load_addr = value;
+	else if (*ref_type == LLVMDisassembler_ReferenceType_In_ARM64_ADRP) {
+		uint64_t adrp_imm;
+
+		/* immhi (bits 23:5) and immlo (bits 30:29) */
+		adrp_imm = ((value & 0x00ffffe0) >> 3) | ((value >> 29) & 0x3);
+		/* Sign-extend the 21-bit immediate to 64-bit */
+		if (adrp_imm & (1ULL << 20))
+			adrp_imm |= ~((1ULL << 21) - 1);
+
+		/* Calculate the target page address */
+		storage->pcrel_adrp_addr = (address & ~0xFFFLL) + (adrp_imm << 12);
+	}
 	*ref_type = LLVMDisassembler_ReferenceType_InOut_None;
 	return NULL;
 }
@@ -204,6 +217,7 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 
 		storage.branch_addr = 0;
 		storage.pcrel_load_addr = 0;
+		storage.pcrel_adrp_addr = 0;
 
 		/*
 		 * LLVM's API has the code be disassembled as non-const, cast
@@ -227,6 +241,42 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 				free(name);
 			}
 		}
+		if (storage.pcrel_adrp_addr != 0) {
+			/*
+			 * ADRP (Address Page) instructions encode a 21-bit signed
+			 * immediate offset relative to the current PC's page.
+			 *
+			 * To maintain consistency with standard objdump output,
+			 * we truncate the raw encoded immediate at the comma
+			 * and replace it with the resolved absolute page address.
+			 *
+			 * Example conversion:
+			 * From: adrp x18, 8014
+			 * To:   adrp x18, ffff800081f5f000 <this_cpu_vector>
+			 */
+			char *name;
+			char *s = strchr(disasm_buf, ',');
+
+			if (s == NULL)
+				goto err;
+
+			s++;
+			*s = '\0';
+			disasm_len = strlen(disasm_buf);
+			disasm_len += scnprintf(disasm_buf + disasm_len,
+						sizeof(disasm_buf) - disasm_len,
+						" %"PRIx64,
+						storage.pcrel_adrp_addr);
+			name = llvm_name_for_data(dso, filename,
+						  storage.pcrel_adrp_addr);
+			if (name) {
+				disasm_len += scnprintf(disasm_buf + disasm_len,
+							sizeof(disasm_buf) -
+							disasm_len,
+							" <%s>", name);
+				free(name);
+			}
+		}
 		if (storage.pcrel_load_addr != 0) {
 			char *name = llvm_name_for_data(dso, filename,
 							storage.pcrel_load_addr);
-- 
2.34.1

