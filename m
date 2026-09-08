Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676095476D3;
	Tue,  8 Sep 2026 13:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872528; cv=none; b=eqXFdDL5jMljYV/emsUv080VINIh9kfCml6ZJ8sqOAocYwAN7a8ydcYekpPcC+WiQdO3gvlaN3vHOjTLxNKg6L44KZnEL0kNBUV83nPvHiZ9R5fPlh8XHnYQhGzPyk+GrUPWsOYR/8fFKtvaqbQxVon925s20z7JHPVa9dZmAsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872528; c=relaxed/simple;
	bh=msO7gvzMCmQxp+5FSP1qIEkxjs1eIW94fah/aqxDUBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y7FNCaAeJKnLd3zpXL20KGEU1HNR9tchSdNkXTJoJ7FpBkIGLu4tzbBAGunLb8JK0mSON0MzEMCJ8lPkM92xnIyKxk3F7OZzWj0V68AZLnlrXzoVVvwOyCw+tDo9KCT505gAZ+MX1vjdF4SikxJO/1MM4yaMXcPtm+/Zpwsxg+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hfPFV62yyzYQvV5;
	Tue,  8 Sep 2026 21:01:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 591D64057A;
	Tue,  8 Sep 2026 21:01:54 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAni5gpB6BqC9rlBA--.34632S14;
	Tue, 08 Sep 2026 21:01:53 +0800 (CST)
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
Subject: [PATCH v5 12/26] perf annotate-data: Extract invalidate_reg_state() as a common helper
Date: Tue,  8 Sep 2026 13:01:08 +0000
Message-Id: <20260908130122.633500-13-wutengda@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAni5gpB6BqC9rlBA--.34632S14
X-Coremail-Antispam: 1UD129KBjvJXoWxGr1rJry8CF1ktr17Kr4UJwb_yoW5XrW5p3
	yDC347Gw43Gr4FgwnxJFW3XFWF9r1fXa4Fk3sYyan2vFWIyrn3JF92qFy5tFW7Xr93Gw12
	yw1qgr4DJayxKaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRGMKuUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

The invalidate_reg_state() function is currently static and only used
within the x86 data type profiling implementation. To prepare for adding
arm64 instruction tracking support, extract it as a common helper that
can be shared across architectures.

No functional change intended.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/perf/util/annotate-arch/annotate-x86.c | 9 ---------
 tools/perf/util/annotate-data.c              | 9 +++++++++
 tools/perf/util/annotate-data.h              | 1 +
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
index 1acf31a2c759..aa381d25a63b 100644
--- a/tools/perf/util/annotate-arch/annotate-x86.c
+++ b/tools/perf/util/annotate-arch/annotate-x86.c
@@ -207,15 +207,6 @@ static int x86__cpuid_parse(struct arch *arch, const char *cpuid)
 }
 
 #ifdef HAVE_LIBDW_SUPPORT
-static void invalidate_reg_state(struct type_state_reg *reg)
-{
-	reg->kind = TSR_KIND_INVALID;
-	reg->ok = false;
-	reg->lifetime_active = false;
-	reg->lifetime_end = 0;
-	reg->copied_from = -1;
-}
-
 static void update_insn_state_x86(struct type_state *state,
 				  struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				  struct disasm_line *dl)
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 4e4c58764082..104b80d471f1 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -638,6 +638,15 @@ struct type_state_stack *findnew_stack_state(struct type_state *state,
 	return stack;
 }
 
+void invalidate_reg_state(struct type_state_reg *reg)
+{
+	reg->kind = TSR_KIND_INVALID;
+	reg->ok = false;
+	reg->lifetime_active = false;
+	reg->lifetime_end = 0;
+	reg->copied_from = -1;
+}
+
 /* Maintain a cache for quick global variable lookup */
 struct global_var_entry {
 	struct rb_node node;
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index c26130744260..453e13bbe3e2 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -258,6 +258,7 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
 				Dwarf_Die *type_die, int ptr_offset);
 struct type_state_stack *find_stack_state(struct type_state *state,
 						int offset);
+void invalidate_reg_state(struct type_state_reg *reg);
 bool get_global_var_type(Dwarf_Die *cu_die, struct data_loc_info *dloc,
 				u64 ip, u64 var_addr, int *var_offset,
 				Dwarf_Die *type_die);
-- 
2.34.1

