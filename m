Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBD11C8621;
	Fri, 14 Mar 2025 08:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940449; cv=none; b=VI0XGmyO9jKUeRRpc+SMJEnSVvzCBJxhwXH4Hi+iQu6FvEd5hepOLByCQq5ccwnd2dPGE0MjpI4INuOt+UCvqaERG847hHG+HE+meLKPCV4dI71tSJ3XAap0cYvZvZgNAyS1CVISv6rH9EzqksWJBzLLVk86T9q+GP7KfbJkUR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940449; c=relaxed/simple;
	bh=nHyj5EU/L98vd3Ddkxb+h2fVE2kG1P9BFZwk9Z5dIyA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HdJppiYOtojD0HxMKaAbalu1a5uVDchZj21ExmlBtgsDAWamTz0atpcGevfZyJiAol4xLW37F/9D60gZilltW3Hc4i1fr2IQ8Ak1sAsPkLuQH7uCwXVpFRr1G45ZRBE8L9oYWwRO1UljSVrYnWcwgzu++CP1uxXo+LvNuNi1dsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZDcht3WbMztQfY;
	Fri, 14 Mar 2025 16:19:10 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 5ED0818006C;
	Fri, 14 Mar 2025 16:20:39 +0800 (CST)
Received: from lihuafei.huawei.com (10.90.53.74) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Mar 2025 16:20:38 +0800
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
Subject: [PATCH 2/7] perf annotate: Advance the mem_ref check to mov__parse()
Date: Sat, 15 Mar 2025 00:21:32 +0800
Message-ID: <20250314162137.528204-3-lihuafei1@huawei.com>
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

Advance the mem_ref check on x86 to mov__parse(), along with the
multi_reg check, to make annotate_get_insn_location() more concise.

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 tools/perf/util/annotate.c | 9 ++++-----
 tools/perf/util/disasm.c   | 8 ++++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 31bb326b07a6..860ea6c72411 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2442,18 +2442,17 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
 				continue;
 		}
 
+		op_loc->mem_ref = mem_ref;
+		op_loc->multi_regs = multi_regs;
+
 		/*
 		 * For powerpc, call get_powerpc_regs function which extracts the
 		 * required fields for op_loc, ie reg1, reg2, offset from the
 		 * raw instruction.
 		 */
 		if (arch__is(arch, "powerpc")) {
-			op_loc->mem_ref = mem_ref;
-			op_loc->multi_regs = multi_regs;
 			get_powerpc_regs(dl->raw.raw_insn, !i, op_loc);
-		} else if (strchr(insn_str, arch->objdump.memory_ref_char)) {
-			op_loc->mem_ref = true;
-			op_loc->multi_regs = multi_regs;
+		} else if (mem_ref) {
 			extract_reg_offset(arch, insn_str, op_loc);
 		} else {
 			char *s, *p = NULL;
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 50c5c206b70e..d91526cff9df 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -607,6 +607,12 @@ static bool check_multi_regs(struct arch *arch, const char *op)
 	return count > 1;
 }
 
+/* Check whether the operand accesses memory. */
+static bool check_memory_ref(struct arch *arch, const char *op)
+{
+	return strchr(op, arch->objdump.memory_ref_char) != NULL;
+}
+
 static int mov__parse(struct arch *arch, struct ins_operands *ops, struct map_symbol *ms __maybe_unused,
 		struct disasm_line *dl __maybe_unused)
 {
@@ -635,6 +641,7 @@ static int mov__parse(struct arch *arch, struct ins_operands *ops, struct map_sy
 	if (ops->source.raw == NULL)
 		return -1;
 
+	ops->source.mem_ref = check_memory_ref(arch, ops->source.raw);
 	ops->source.multi_regs = check_multi_regs(arch, ops->source.raw);
 
 	target = skip_spaces(++s);
@@ -657,6 +664,7 @@ static int mov__parse(struct arch *arch, struct ins_operands *ops, struct map_sy
 	if (ops->target.raw == NULL)
 		goto out_free_source;
 
+	ops->target.mem_ref = check_memory_ref(arch, ops->target.raw);
 	ops->target.multi_regs = check_multi_regs(arch, ops->target.raw);
 
 	if (comment == NULL)
-- 
2.25.1

