Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A97139C639;
	Fri,  3 Apr 2026 09:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775209741; cv=none; b=PIZzZfyNVvmZY3JrrrPfZrAlcUTbYegipT8Da/Fba2QoJnEfZD96eM1rDBNQegFW6mw2H3eZD465tQI95pXpRLhxwSnZ5vZeOHetu1jfA02corLsZt0fjG9sGGQMMH7xftyEwtlX3GfDo54CsSiEgo0S6+H59O1Bv1Rqhgv1ggQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775209741; c=relaxed/simple;
	bh=zuDXlNuSE9amdNSIYZ6B6P1lL267t0c/ONuA6d0/eDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S1O3X1zLEBO7bHRIuJxad97lH3Brtd38LD3Ze7KtKKZZuEIYcykU+G1EmW27yICMne7wY8Fuq4QgSH59xX3yJICkBxY3wEx5cmKtANpZJPmndTvp7V+8Oj5L0yxg+o3uvVEDDmgOXLzX5wxgaQlIAlMtYGELdK6JNBRxQ6ut4U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fnDS851kmzYQtw2;
	Fri,  3 Apr 2026 17:48:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 26A7540579;
	Fri,  3 Apr 2026 17:48:50 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with SMTP id _Ch0CgAnB1TwjM9p8K_UDA--.49742S14;
	Fri, 03 Apr 2026 17:48:49 +0800 (CST)
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
Subject: [PATCH v2 12/16] perf annotate-arm64: Support 'mov' instruction tracking
Date: Fri,  3 Apr 2026 09:47:56 +0000
Message-Id: <20260403094800.1418825-13-wutengda@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgAnB1TwjM9p8K_UDA--.49742S14
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1rAw1xJFWUCw4DKF45KFg_yoW5Wr1xpa
	1DG345t39Igr12grs3XFWrXa4fKwnagasI934Yqw1avrWakr4rtF97KFWaka15XryxCr43
	Jw1DtrW3Ww1UCaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRGMKuUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Extend update_insn_state() for arm64 to handle register-to-register
'mov' instructions.

When a 'mov' instruction occurs between two registers, the data type
information (DWARF type, kind, and offset) needs to be propagated from
the source register to the destination register. This ensures that if
a pointer or a structure was previously identified in one register,
the tracker continues to recognize it after it is moved.

A real-world example is shown below:

  ffff8000803eebf8 <get_vma_policy>:
  ffff8000803eec20:  mov  x21, x0  // x0 (struct vm_area_struct*) -> x21
  ffff8000803eec28:  ldr  x2, [x0, #112]
  ffff8000803eec2c:  cbz  x2, ffff8000803eec94 <get_vma_policy+0x9c>
  ffff8000803eec94:  ldr  x0, [x21, #152]  // PMU sample

Before this commit, the type of x21 was unknown, causing the subsequent
inference to fail:

  var [0] reg0 offset 0 type='struct vm_area_struct*' size=0x8
  chk [9c] reg21 offset=0x98 ok=0 kind=0 cfa : no type information
  final result: no type information

After this commit, the type of x21 is correctly inferred as 'vm_area_struct':

  var [0] reg0 offset 0 type='struct vm_area_struct*' size=0x8
  mov [28] reg0 -> reg21 type='struct vm_area_struct*' size=0x8
  chk [9c] reg21 offset=0x98 ok=1 kind=1 (struct vm_area_struct*) : Good!
  found by insn track: 0x98(reg21) type-offset=0x98
  final result:  type='struct vm_area_struct' size=0xb0

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index f9100230c2f6..013b673f4861 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -308,6 +308,34 @@ static void update_insn_state_arm64(struct type_state *state,
 	sreg = src->reg1;
 	dreg = dst->reg1;
 
+	/* Register to register transfers */
+	if (!strcmp(dl->ins.name, "mov")) {
+		if (!has_reg_type(state, sreg))
+			return;
+
+		tsr = &state->regs[sreg];
+		tsr->copied_from = -1;
+
+		if (!has_reg_type(state, dreg) ||
+		    !state->regs[dreg].ok) {
+			tsr->ok = false;
+			return;
+		}
+
+		tsr->type = state->regs[dreg].type;
+		tsr->kind = state->regs[dreg].kind;
+		tsr->offset = state->regs[dreg].offset;
+		tsr->ok = true;
+
+		if (tsr->kind == TSR_KIND_TYPE || tsr->kind == TSR_KIND_POINTER)
+			tsr->copied_from = dreg;
+
+		pr_debug_dtp("mov [%x] reg%d -> reg%d",
+			     insn_offset, dreg, sreg);
+		pr_debug_type_name(&tsr->type, tsr->kind);
+		return;
+	}
+
 	if (dloc->fb_cfa) {
 		u64 ip = dloc->ms->sym->start + dl->al.offset;
 		u64 pc = map__rip_2objdump(dloc->ms->map, ip);
-- 
2.34.1

