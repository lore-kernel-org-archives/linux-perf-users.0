Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9292EBDFA;
	Fri,  3 Apr 2026 09:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775209737; cv=none; b=dMErsAaYicbi/QiYg6gBFXM7h8f8x+lXCINUC0Mp/sD3Mf5phOS3IyBXe2gODhksz6dgqLkw57P+fOIxUVViHY8wwEw6GPLwLsHaZIUJvmvzH/4Fwp/XSGfvpMnPFQIsj7VHNvCH/D2wgjEjIYBa2aYuLJrn1mtDmMMKGuNFB8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775209737; c=relaxed/simple;
	bh=jMy56hKqdpViAZv3gZ6YW4UUvdg2RoLyFJrgdkVBxvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J8gdKodOvw8nU9OdSC2bU5Z/NNqXIX8qhhaIjjaIHTumE5hg4IvL1J/qEVXmUIHOwKE6fgTUJEqLtOKitwQgUV76YVditFsmpXxBUqYfwhJvlaHwI2EXUflquxiudV8Z+jbMb0DnH+TevzrOTVzGVZ42+ndN/KlNVvqSBEvBn0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fnDS75hpBzYQtsd;
	Fri,  3 Apr 2026 17:48:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 3ABF540570;
	Fri,  3 Apr 2026 17:48:49 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with SMTP id _Ch0CgAnB1TwjM9p8K_UDA--.49742S4;
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
Subject: [PATCH v2 02/16] perf capstone: Fix arm64 jump/adrp disassembly mismatch with objdump
Date: Fri,  3 Apr 2026 09:47:46 +0000
Message-Id: <20260403094800.1418825-3-wutengda@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgAnB1TwjM9p8K_UDA--.49742S4
X-Coremail-Antispam: 1UD129KBjvJXoWxtF4rKFyrWF1xJF15Cw1UAwb_yoW7ZFy8pw
	4DCw15Jws5Xr1fWws3Ga1kXw1Y9rWfXF1Yk3yxK39akrnayrn3XFWxKFya9Fn8Gry8Gw42
	yFs0vF15Wrn5JrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRXwIDUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

The jump and adrp instructions parsed by libcapstone currently lack
symbolic representation and use a '#' prefix for addresses. This
format is inconsistent with objdump's output, which causes subsequent
parsing in jump__parse() and arm64_mov__parse() to fail.

Example mismatch:
  Current: b #0xffff8000800114c8
  Fix:     b ffff8000800114c8 <el0t_64_sync+0x108>

  Current: adrp x18, #0xffff800081f5f000
  Fix:     adrp x18, ffff800081f5f000 <this_cpu_vector>

Fix this by implementing extended formatting for these arm64
instructions during symbol__disassemble_capstone(). This ensures
the output matches objdump's expected style, including the raw
address and the associated <symbol+offset> suffix.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/perf/util/capstone.c | 107 ++++++++++++++++++++++++++++++++-----
 tools/perf/util/disasm.c   |   5 ++
 tools/perf/util/disasm.h   |   1 +
 3 files changed, 101 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index 25cf6e15ec27..1d8421d2d98c 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -255,10 +255,6 @@ static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
 	struct map *map = args->ms->map;
 	struct symbol *sym;
 
-	/* TODO: support more architectures */
-	if (!arch__is_x86(args->arch))
-		return;
-
 	if (insn->detail == NULL)
 		return;
 
@@ -305,6 +301,98 @@ static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
 	}
 }
 
+static void format_capstone_insn_x86(struct cs_insn *insn, char *buf,
+				     size_t len, struct annotate_args *args,
+				     u64 addr)
+{
+	int printed;
+
+	printed = scnprintf(buf, len, "       %-7s %s",
+			    insn->mnemonic, insn->op_str);
+	buf += printed;
+	len -= printed;
+
+	print_capstone_detail(insn, buf, len, args, addr);
+}
+
+static void format_capstone_insn_arm64(struct cs_insn *insn, char *buf,
+				       size_t len, struct annotate_args *args,
+				       u64 addr)
+{
+	struct map *map = args->ms->map;
+	struct symbol *sym;
+	char *last_imm, *endptr;
+	u64 orig_addr;
+
+	scnprintf(buf, len, "       %-7s %s",
+		  insn->mnemonic, insn->op_str);
+	/*
+	 * Adjust instructions to keep the existing behavior with objdump.
+	 *
+	 * Example conversion:
+	 * From: b #0xffff8000800114c8
+	 * To:   b ffff8000800114c8 <el0t_64_sync+0x108>
+	 */
+	switch (insn->id) {
+	case ARM64_INS_B:
+	case ARM64_INS_BL:
+	case ARM64_INS_CBNZ:
+	case ARM64_INS_CBZ:
+	case ARM64_INS_TBNZ:
+	case ARM64_INS_TBZ:
+	case ARM64_INS_ADRP:
+		/* Extract last immediate value as address */
+		last_imm = strrchr(buf, '#');
+		if (!last_imm)
+			return;
+
+		orig_addr = strtoull(last_imm + 1, &endptr, 16);
+		if (endptr == last_imm + 1)
+			return;
+
+		/* Relocate map that contains the address */
+		if (dso__kernel(map__dso(map))) {
+			map = maps__find(map__kmaps(map), orig_addr);
+			if (map == NULL)
+				return;
+		}
+
+		/* Convert it to map-relative address for search */
+		addr = map__map_ip(map, orig_addr);
+
+		sym = map__find_symbol(map, addr);
+		if (sym == NULL)
+			return;
+
+		/* Symbolize the resolved address */
+		len = len - (last_imm - buf);
+		if (addr == sym->start) {
+			scnprintf(last_imm, len, "%"PRIx64" <%s>",
+				  orig_addr, sym->name);
+		} else {
+			scnprintf(last_imm, len, "%"PRIx64" <%s+%#"PRIx64">",
+				  orig_addr, sym->name, addr - sym->start);
+		}
+		break;
+	default:
+		break;
+	}
+}
+
+static void format_capstone_insn(struct cs_insn *insn, char *buf, size_t len,
+				 struct annotate_args *args, u64 addr)
+{
+	/* TODO: support more architectures */
+	if (arch__is_x86(args->arch))
+		format_capstone_insn_x86(insn, buf, len, args, addr);
+	else if (arch__is_arm64(args->arch))
+		format_capstone_insn_arm64(insn, buf, len, args, addr);
+	else {
+		scnprintf(buf, len, "       %-7s %s",
+			  insn->mnemonic, insn->op_str);
+	}
+}
+
 struct find_file_offset_data {
 	u64 ip;
 	u64 offset;
@@ -381,14 +469,9 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 
 	free_count = count = perf_cs_disasm(handle, buf, buf_len, start, buf_len, &insn);
 	for (i = 0, offset = 0; i < count; i++) {
-		int printed;
-
-		printed = scnprintf(disasm_buf, sizeof(disasm_buf),
-				    "       %-7s %s",
-				    insn[i].mnemonic, insn[i].op_str);
-		print_capstone_detail(&insn[i], disasm_buf + printed,
-				      sizeof(disasm_buf) - printed, args,
-				      start + offset);
+		format_capstone_insn(&insn[i], disasm_buf,
+				     sizeof(disasm_buf), args,
+				     start + offset);
 
 		args->offset = offset;
 		args->line = disasm_buf;
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 40fcaed5d0b1..988b2b748e11 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -202,6 +202,11 @@ bool arch__is_powerpc(const struct arch *arch)
 	return arch->id.e_machine == EM_PPC || arch->id.e_machine == EM_PPC64;
 }
 
+bool arch__is_arm64(const struct arch *arch)
+{
+	return arch->id.e_machine == EM_AARCH64;
+}
+
 static void ins_ops__delete(struct ins_operands *ops)
 {
 	if (ops == NULL)
diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index a6e478caf61a..d3730ed86dba 100644
--- a/tools/perf/util/disasm.h
+++ b/tools/perf/util/disasm.h
@@ -111,6 +111,7 @@ struct annotate_args {
 const struct arch *arch__find(uint16_t e_machine, uint32_t e_flags, const char *cpuid);
 bool arch__is_x86(const struct arch *arch);
 bool arch__is_powerpc(const struct arch *arch);
+bool arch__is_arm64(const struct arch *arch);
 
 extern const struct ins_ops call_ops;
 extern const struct ins_ops dec_ops;
-- 
2.34.1

