Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F6339C009;
	Fri,  3 Apr 2026 09:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775209741; cv=none; b=PiPvwhCzDApjnaabjts5pq/NSjXTr860eNOAJrqWcf1En/qkbMa0Ta7J+Rygh2RbCKFEOIZDiBVG1NYhAiS9HCL9acV6CT1kk9HkIRP82jP1qbfAUsy3hNFeS0NabTtTIZDah4HLPWk2yObwzY3W+s2j7S55eW/hd2UbbMX7pho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775209741; c=relaxed/simple;
	bh=xndpCDkl2v9dHVXTBVST0sJ0wJnQ9KxSmdA4RqbyVKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OInc0MWQ0BO6Ux5G0CMTlsETx1EyfsEullCg5yzy7Y/QoKlbp6vvGsQZ3N4sHWvAvfeXp+rxAoDswQ/fD8gFdYE7ZLtFFl8WIt4Fg+K4GmFE368LJoZ20VLKA2UkrsrjR3JohUXFJv1Hpwk3IshpPKSpeS7nqVIK++4X9pSIzrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fnDS85pYqzYQtwD;
	Fri,  3 Apr 2026 17:48:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 3C1E540576;
	Fri,  3 Apr 2026 17:48:50 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with SMTP id _Ch0CgAnB1TwjM9p8K_UDA--.49742S15;
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
Subject: [PATCH v2 13/16] perf annotate-arm64: Support 'add' instruction tracking
Date: Fri,  3 Apr 2026 09:47:57 +0000
Message-Id: <20260403094800.1418825-14-wutengda@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgAnB1TwjM9p8K_UDA--.49742S15
X-Coremail-Antispam: 1UD129KBjvJXoWxZrW5tF4fJF4DKw4fuF1kuFg_yoW5KF43pa
	90kryUGw4Igr12grs3ZFW3XryfKan3W3W5Cryqgw1ayrWayr18ta4vkrW3uayrJrZxAw47
	Jr15Kr4ruw1qkaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Extend update_insn_state() for arm64 to track pointer arithmetic and
member address calculations.

The arm64 'add' instruction frequently calculates structure member
addresses, such as 'add x0, x1, #offset'. Tracking this is essential
to maintain the connection between a base pointer and its derived
member addresses.

The implementation checks if the base register contains a pointer
or a structure type. When an immediate offset is added, use
die_get_member_type() to verify that the resulting offset points to
a valid member within the data type. If valid, update the target
register's type state with the new offset while preserving the base
type information.

A real-world example is shown below:

  ffff80008001c9a8 <flush_ptrace_hw_breakpoint>:
  ffff80008001c9c4:  add  x19, x0, #0xeb8 // x0 (task_struct*) + 0xeb8 -> x19
  ffff80008001c9d0:  ldr  x0, [x19]       // PMU sample

Before this commit, the type flow broke at the 'add' instruction,
leaving the subsequent load with no type information:

  chk [28] reg19 offset=0 ok=0 kind=0 cfa : no type information
  final result: no type information

After this commit, the tracker correctly follows the member address
calculation:

  var [0] reg0 offset 0 type='struct task_struct*'
  add [1c] address of 0xeb8(reg0) -> reg19 type='struct task_struct*'
  chk [28] reg19 offset=0 ok=1 kind=1 (struct task_struct*) : Good!
  found by insn track: 0(reg19) type-offset=0xeb8
  final result: type='struct task_struct'

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index 013b673f4861..d2557b9d6909 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -7,6 +7,7 @@
 #include <linux/zalloc.h>
 #include <linux/string.h>
 #include <regex.h>
+#include <inttypes.h>
 #include "../annotate.h"
 #include "../disasm.h"
 #include "../annotate-data.h"
@@ -308,6 +309,50 @@ static void update_insn_state_arm64(struct type_state *state,
 	sreg = src->reg1;
 	dreg = dst->reg1;
 
+	if (!strcmp(dl->ins.name, "add")) {
+		struct type_state_reg dst_tsr;
+
+		if (!has_reg_type(state, sreg) ||
+		    !has_reg_type(state, dreg) ||
+		    !state->regs[dreg].ok)
+			return;
+
+		tsr = &state->regs[sreg];
+		tsr->copied_from = -1;
+		dst_tsr = state->regs[dreg];
+
+		/* Handle calculation of a register holding a typed pointer */
+		if (dst_tsr.kind == TSR_KIND_POINTER ||
+		    (dst_tsr.kind == TSR_KIND_TYPE &&
+		    dwarf_tag(&dst_tsr.type) == DW_TAG_pointer_type)) {
+			s32 offset;
+
+			if (dst_tsr.kind == TSR_KIND_TYPE &&
+			    __die_get_real_type(&dst_tsr.type, &type_die) == NULL)
+				return;
+
+			if (dst_tsr.kind == TSR_KIND_POINTER)
+				type_die = dst_tsr.type;
+
+			/* Check if the target type has a member at the new offset */
+			offset = dst->offset + dst_tsr.offset;
+			if (die_get_member_type(&type_die, offset, &type_die) == NULL)
+				return;
+
+			tsr->type = dst_tsr.type;
+			tsr->kind = dst_tsr.kind;
+			tsr->offset = offset;
+			tsr->ok = true;
+
+			pr_debug_dtp("add [%x] address of %s%#x(reg%d) -> reg%d",
+				     insn_offset, dst->offset < 0 ? "-" : "",
+				     abs(dst->offset), dreg, sreg);
+
+			pr_debug_type_name(&tsr->type, tsr->kind);
+		}
+		return;
+	}
+
 	/* Register to register transfers */
 	if (!strcmp(dl->ins.name, "mov")) {
 		if (!has_reg_type(state, sreg))
-- 
2.34.1

