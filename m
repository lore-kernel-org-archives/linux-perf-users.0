Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271D31AAA1A;
	Fri, 14 Mar 2025 08:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940445; cv=none; b=nM/X5Ym5ZMpJWnDxQCNc8agUwl4PKysqAo6WbbLYdlNqJsQxAGWlws4vwdpMTpz6JcuHuglLdjFaBJ+sATU/X0YKjLKIcjrDKQdEVWMTs6sAHfU730eTR3Gwv44bu/goB2y/W+r7BY4tgwRha4+gQ6r4HDTwZZrEjPZIRClmBLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940445; c=relaxed/simple;
	bh=il+4NZp6/CIc+/doN1p81C7ZGRGabOWPMUdXgs51CeY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oq01rkql6JjuC1ejbcrhMMAr/jeJIN2ZWRlHsjxqXmh/alOy6pl+PQrFQK4Y8BhhHu3LGQnyPQJXo4hveeXhILR9zGiTr5KM5946GazQwF0yKmVIvdUggQ/Z1/suZut7S0JyLidashnuMTobnYv41RpPw+TUAY6ykTdc9WtDYpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZDcfx5lN6zCtSS;
	Fri, 14 Mar 2025 16:17:29 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id AF96F1800E4;
	Fri, 14 Mar 2025 16:20:41 +0800 (CST)
Received: from lihuafei.huawei.com (10.90.53.74) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Mar 2025 16:20:40 +0800
From: Li Huafei <lihuafei1@huawei.com>
To: <namhyung@kernel.org>, <acme@kernel.org>, <leo.yan@linux.dev>,
	<james.clark@linaro.org>, <mark.rutland@arm.com>, <john.g.garry@oracle.com>,
	<will@kernel.org>, <irogers@google.com>
CC: <mike.leach@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<kjain@linux.ibm.com>, <mhiramat@kernel.org>, <atrajeev@linux.vnet.ibm.com>,
	<sesse@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <lihuafei1@huawei.com>
Subject: [PATCH 5/7] perf annotate-data: Support instruction tracking for arm64
Date: Sat, 15 Mar 2025 00:21:35 +0800
Message-ID: <20250314162137.528204-6-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250314162137.528204-1-lihuafei1@huawei.com>
References: <20250314162137.528204-1-lihuafei1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf500004.china.huawei.com (7.202.181.242)

Support for arm64 instruction tracing. This patch addresses the scenario
where type information cannot be found during multi-level pointer
references. For example, consider the vfs_ioctl() function:

 long vfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
     int error = -ENOTTY;

     if (!filp->f_op->unlocked_ioctl)
         goto out;

     error = filp->f_op->unlocked_ioctl(filp, cmd, arg);
     if (error == -ENOIOCTLCMD)
         error = -ENOTTY;
 out:
     return error;
 }

The 'SYSCALL_DEFINE3(ioctl)' inlines vfs_ioctl, and the assembly
instructions for 'if (!filp->f_op->unlocked_ioctl)' are as follows:

 ldr     x0, [x21, #16]
 ldr     x3, [x0, #80]
 cbz     x3, ffff80008048e9a4

The first instruction loads the 'filp->f_op' pointer, and the second
instruction loads the 'filp->f_op->unlocked_ioctl' pointer. DWARF
generates type information for x21, but not for x0. Therefore, if
PMU sampling occurs on the second instruction, the corresponding data
type cannot be obtained. However, by using the type information and
offset from x21 in the first ldr instruction, we can infer the type
of x0 and, combined with the offset, resolve the accessed data member.

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 tools/perf/arch/arm64/annotate/instructions.c | 44 ++++++++++++++++++-
 tools/perf/util/annotate-data.c               |  3 +-
 tools/perf/util/annotate-data.h               |  2 +-
 tools/perf/util/disasm.c                      |  3 ++
 4 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/arm64/annotate/instructions.c b/tools/perf/arch/arm64/annotate/instructions.c
index 54497b72a5c5..f70d93001fe7 100644
--- a/tools/perf/arch/arm64/annotate/instructions.c
+++ b/tools/perf/arch/arm64/annotate/instructions.c
@@ -215,7 +215,8 @@ extract_reg_offset_arm64(struct arch *arch __maybe_unused,
 	static bool regex_compiled;
 
 	if (!regex_compiled) {
-		regcomp(&reg_off_regex, "^\\[(sp|[xw][0-9]{1,2})(, #(-?[0-9]+))?\\].*",
+		regcomp(&reg_off_regex,
+			"^\\[(sp|[xw][0-9]{1,2})(, #(-?[0-9]+))?\\].*",
 			REG_EXTENDED);
 		regex_compiled = true;
 	}
@@ -250,3 +251,44 @@ extract_reg_offset_arm64(struct arch *arch __maybe_unused,
 	free(str);
 	return 0;
 }
+
+#ifdef HAVE_LIBDW_SUPPORT
+static void
+update_insn_state_arm64(struct type_state *state, struct data_loc_info *dloc,
+			Dwarf_Die * cu_die __maybe_unused, struct disasm_line *dl)
+{
+	struct annotated_insn_loc loc;
+	struct annotated_op_loc *dst = &loc.ops[INSN_OP_TARGET];
+	struct type_state_reg *tsr;
+	Dwarf_Die type_die;
+	int sreg, dreg;
+
+	if (strncmp(dl->ins.name, "ld", 2))
+		return;
+
+	if (annotate_get_insn_location(dloc->arch, dl, &loc) < 0)
+		return;
+
+	sreg = get_arm64_regnum(dl->ops.source.raw);
+	if (sreg < 0)
+		return;
+	if (!has_reg_type(state, sreg))
+		return;
+
+	dreg = dst->reg1;
+	if (has_reg_type(state, dreg) && state->regs[dreg].ok &&
+	    state->regs[dreg].kind == TSR_KIND_TYPE &&
+	    dwarf_tag(&state->regs[dreg].type) == DW_TAG_pointer_type &&
+	    die_deref_ptr_type(&state->regs[dreg].type,
+			       dst->offset, &type_die)) {
+		tsr = &state->regs[sreg];
+		tsr->type = type_die;
+		tsr->kind = TSR_KIND_TYPE;
+		tsr->ok = true;
+
+		pr_debug_dtp("load [%x] %#x(reg%d) -> reg%d",
+			     (u32)dl->al.offset, dst->offset, dreg, sreg);
+		pr_debug_type_name(&tsr->type, tsr->kind);
+	}
+}
+#endif
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 976abedca09e..2bc8d646eedc 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1293,7 +1293,8 @@ static enum type_match_result find_data_type_insn(struct data_loc_info *dloc,
 
 static int arch_supports_insn_tracking(struct data_loc_info *dloc)
 {
-	if ((arch__is(dloc->arch, "x86")) || (arch__is(dloc->arch, "powerpc")))
+	if ((arch__is(dloc->arch, "x86")) || (arch__is(dloc->arch, "powerpc")) ||
+	    (arch__is(dloc->arch, "arm64")))
 		return 1;
 	return 0;
 }
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 98c80b2268dd..717f394eb8f1 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -190,7 +190,7 @@ struct type_state_stack {
 };
 
 /* FIXME: This should be arch-dependent */
-#ifdef __powerpc__
+#if defined(__powerpc__) || defined(__aarch64__)
 #define TYPE_STATE_MAX_REGS  32
 #else
 #define TYPE_STATE_MAX_REGS  16
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 1035c60a8545..540981c155f9 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -129,6 +129,9 @@ static struct arch architectures[] = {
 		.name = "arm64",
 		.init = arm64__annotate_init,
 		.extract_reg_offset = extract_reg_offset_arm64,
+#ifdef HAVE_LIBDW_SUPPORT
+		.update_insn_state = update_insn_state_arm64,
+#endif
 	},
 	{
 		.name = "csky",
-- 
2.25.1

