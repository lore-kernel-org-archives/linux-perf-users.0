Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.249.212.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503973;
	b=dBmo8ml9xb0uE+CwTvylHCNSyMJQHZiVmIjoVpzktAdqe2jqMOtgKJfsjbQSOi19Pl1Y
	 BxPqssEANFAfSBjvXYHabd+HAzo1jIV9q7R06iFg9ahB9J2qU9+ZCiK/OyryDfc0bb/KJ
	 fY8yXN5f7KmN/dpyM7cyX3muFej0zVP9MMnvSkvrxB9zRlUJHggH3hShHC9YjPYn0Qm1s
	 1MI38TwkNP8W5k4bxGAFrKY+m5HIekXAok30eFTVcMjYmfOLgIpSaM1foAjRBE6cWBhkz
	 vurdWxPE71yGkPGfCG0L4OjYqgYzpSqVRh/cUcCQFKrXjwfllDdx7A1qaxXFOAUlehg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503973;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=YSxOc9RSBc/7XL7i6RQr/k6774k4YAacfF3TFX6F7GQ=;
	b=rTGf3+XEel0cIZYMYiqfPAUKIKeJz3XgCoR3eLYZrvfBVPTziVpOBoI1Erq3fy+R/40v
	 SOQiN7GtZI07nxTsjPT+S8oGQ5hJCdDOKfhPDl4ieBdvVKC6BdFYdomDg/7iJs3Jj0/fO
	 XhrNzcVOpu78EQiaPXw5B1wkyvH2Jri732dv49htfnp9FJzovKtuRhFAYF6zJQ1JMiocq
	 +2YJNHjanSi6flTeRXPhFJZyGJbLDwICsSGFNAFvByzHjdQ/uo3EEFwnKnEaobuc+foOD
	 uW0CCDvqUuXKHO3xLm3ff6jzgD+BGk2T4fbSSrezG8Wq8Sj5l/BKHCSo2adZRL3yR3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=45.249.212.51
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AD5606F45A;
	Tue, 20 Oct 2026 13:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89AD5606F45A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j8DFw5F7PzYQtwV;
	Tue, 20 Oct 2026 21:45:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id B28AB40A22;
	Tue, 20 Oct 2026 21:45:58 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgB3QOaGcNdq8xegBA--.22174S11;
	Tue, 20 Oct 2026 21:45:58 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Namhyung Kim <namhyung@kernel.org>,
	james.clark@linaro.org,
	xueshuai@linux.alibaba.com,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
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
Subject: [PATCH v8 09/15] perf annotate-x86: Delete stale stack state on store of untracked register
Date: Tue, 20 Oct 2026 13:45:05 +0000
Message-Id: <60c5fe1ce61fb79c9506516221deb18aa728b4c5.1792411435.git.wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792411435.git.wutengda@huaweicloud.com>
References: <cover.1792411435.git.wutengda@huaweicloud.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgB3QOaGcNdq8xegBA--.22174S11
X-Coremail-Antispam: 1UD129KBjvJXoWxur4xGry8KFyxtF43Jr4xWFg_yoWrJr4kpr
	yDC343Ww17Gr4SqrnxAF45XF95urs7X3WrC3s0qwn2vF1xJr1fG3s7tFWYyF47Xr92kw12
	yw1UKr4DXa12gaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YV
	CY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20xyl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRQYFCDUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

When a register without a tracked type is stored to a stack slot that
previously held a valid type, the code currently performs an early return.
This leaves the old type information intact in the stack state.

As a result, a stale type bug occurs:
1. A tracked register is stored into a stack slot.
2. The register becomes untracked/invalid (e.g., across a function call).
3. The now-untracked register is stored into the same stack slot.
4. Subsequent loads from that slot erroneously pick up the old stale type
   because the stack entry was never invalidated.

Fix this by introducing delete_stack_state() to search and free a stack
entry for a given offset. When storing an untracked or invalid source
register into a stack location, call delete_stack_state() to delete the
stale entry before returning.

Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/perf/util/annotate-arch/annotate-x86.c | 17 +++++++++++++----
 tools/perf/util/annotate-data.c              | 10 ++++++++++
 tools/perf/util/annotate-data.h              |  1 +
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
index 21729e153fa0..3a6ea7e978e0 100644
--- a/tools/perf/util/annotate-arch/annotate-x86.c
+++ b/tools/perf/util/annotate-arch/annotate-x86.c
@@ -753,15 +753,24 @@ static void update_insn_state_x86(struct type_state *state,
 	}
 	/* Case 3. register to memory transfers */
 	if (!src->mem_ref && dst->mem_ref) {
-		if (!has_reg_type(state, src->reg1) ||
-		    !state->regs[src->reg1].ok)
-			return;
-
 		/* Check stack variables with offset */
 		if (dst->reg1 == fbreg || dst->reg1 == state->stack_reg) {
 			struct type_state_stack *stack;
 			int offset = dst->offset - fboff;
 
+			if (!has_reg_type(state, src->reg1) ||
+			    !state->regs[src->reg1].ok) {
+				stack = find_stack_state(state, offset);
+				/*
+				 * Preserve compound states when only a member
+				 * is overwritten.
+				 */
+				if (stack && !stack->compound)
+					delete_stack_state(state, offset);
+
+				return;
+			}
+
 			tsr = &state->regs[src->reg1];
 
 			stack = find_stack_state(state, offset);
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 9ed0780d6244..1d47db3a9dd9 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -761,6 +761,16 @@ struct type_state_stack *findnew_stack_state(struct type_state *state,
 	return stack;
 }
 
+void delete_stack_state(struct type_state *state, int offset)
+{
+	struct type_state_stack *stack = find_stack_state(state, offset);
+
+	if (stack) {
+		list_del(&stack->list);
+		free(stack);
+	}
+}
+
 void invalidate_reg_state(struct type_state_reg *reg)
 {
 	reg->kind = TSR_KIND_INVALID;
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index dccd56759cea..425d9ddfad41 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -268,6 +268,7 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
 				Dwarf_Die *type_die, int ptr_offset, u64 imm_value);
 struct type_state_stack *find_stack_state(struct type_state *state,
 						int offset);
+void delete_stack_state(struct type_state *state, int offset);
 void invalidate_reg_state(struct type_state_reg *reg);
 bool get_global_var_type(Dwarf_Die *cu_die, struct data_loc_info *dloc,
 				u64 ip, u64 var_addr, int *var_offset,
-- 
2.34.1

