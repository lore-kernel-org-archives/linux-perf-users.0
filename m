Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0076C1624FC;
	Fri, 14 Mar 2025 08:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940442; cv=none; b=R4/T5nXaOm1YrB/iPHRHbe8uU9FIsbtl3FCnb+5lv1DH7/Mh89XPms9wox8Rveak8KNK5fCaFYfLO3bBdFNpLBQMxWUIJrrOTfbG6Los92qvJ0ZrFf4Z0UF8+EnsOh7E1G4h2XNrOVmus5Wx5xWdK06B09YCvF0Opb1vLDDtecw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940442; c=relaxed/simple;
	bh=t9juaD9MSFgXqlvz3+rde4oX975yHryy60Tb0U3EBLk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tp12P9n8Ye9oWJv5UpITUzrreTcl0Dr39RUxwFHcN512DiAYT77kdq210Y925dT6VQt+eO/z1vs3jl2OkJgQtFObBhAMwPNJWspE8geD/BftZY1jeUrqURreWZIs//O5qqC7OX9VVkVNOEhO2LKsbu0dZL3P/6wXrngTuf4Tqbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZDchc4gCbz1R6Wc;
	Fri, 14 Mar 2025 16:18:56 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 995EC14022D;
	Fri, 14 Mar 2025 16:20:38 +0800 (CST)
Received: from lihuafei.huawei.com (10.90.53.74) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Mar 2025 16:20:37 +0800
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
Subject: [PATCH 1/7] perf annotate: Handle arm64 load and store instructions
Date: Sat, 15 Mar 2025 00:21:31 +0800
Message-ID: <20250314162137.528204-2-lihuafei1@huawei.com>
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

Add ldst_ops to handle load and store instructions in order to parse
the data types and offsets associated with PMU events for memory access
instructions. There are many variants of load and store instructions in
ARM64, making it difficult to match all of these instruction names
completely. Therefore, only the instruction prefixes are matched. The
prefix 'ld|st' covers most of the memory access instructions, 'cas|swp'
matches atomic instructions, and 'prf' matches memory prefetch
instructions.

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 tools/perf/arch/arm64/annotate/instructions.c | 67 ++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm64/annotate/instructions.c b/tools/perf/arch/arm64/annotate/instructions.c
index d465d093e7eb..c212eb7341bd 100644
--- a/tools/perf/arch/arm64/annotate/instructions.c
+++ b/tools/perf/arch/arm64/annotate/instructions.c
@@ -6,7 +6,8 @@
 
 struct arm64_annotate {
 	regex_t call_insn,
-		jump_insn;
+		jump_insn,
+		ldst_insn; /* load and store instruction */
 };
 
 static int arm64_mov__parse(struct arch *arch __maybe_unused,
@@ -67,6 +68,57 @@ static struct ins_ops arm64_mov_ops = {
 	.scnprintf = mov__scnprintf,
 };
 
+static int arm64_ldst__parse(struct arch *arch __maybe_unused,
+			     struct ins_operands *ops,
+			     struct map_symbol *ms __maybe_unused,
+			     struct disasm_line *dl __maybe_unused)
+{
+	char *s, *target;
+
+	/*
+	 * The part starting from the memory access annotation '[' is parsed
+	 * as 'target', while the part before it is parsed as 'source'.
+	 */
+	target = s = strchr(ops->raw, '[');
+	if (!s)
+		return -1;
+
+	while (s > ops->raw && *s != ',')
+		--s;
+
+	if (s == ops->raw)
+		return -1;
+
+	*s = '\0';
+	ops->source.raw = strdup(ops->raw);
+
+	*s = ',';
+	if (!ops->source.raw)
+		return -1;
+
+	ops->target.raw = strdup(target);
+	if (!ops->target.raw) {
+		zfree(ops->source.raw);
+		return -1;
+	}
+	ops->target.mem_ref = true;
+
+	return 0;
+}
+
+static int ldst__scnprintf(struct ins *ins, char *bf, size_t size,
+			   struct ins_operands *ops, int max_ins_name)
+{
+	return scnprintf(bf, size, "%-*s %s,%s", max_ins_name, ins->name,
+			 ops->source.name ?: ops->source.raw,
+			 ops->target.name ?: ops->target.raw);
+}
+
+static struct ins_ops arm64_ldst_ops = {
+	.parse	   = arm64_ldst__parse,
+	.scnprintf = ldst__scnprintf,
+};
+
 static struct ins_ops *arm64__associate_instruction_ops(struct arch *arch, const char *name)
 {
 	struct arm64_annotate *arm = arch->priv;
@@ -77,6 +129,8 @@ static struct ins_ops *arm64__associate_instruction_ops(struct arch *arch, const
 		ops = &jump_ops;
 	else if (!regexec(&arm->call_insn, name, 2, match, 0))
 		ops = &call_ops;
+	else if (!regexec(&arm->ldst_insn, name, 2, match, 0))
+		ops = &arm64_ldst_ops;
 	else if (!strcmp(name, "ret"))
 		ops = &ret_ops;
 	else
@@ -107,6 +161,15 @@ static int arm64__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 		      REG_EXTENDED);
 	if (err)
 		goto out_free_call;
+	/*
+	 * The ARM64 architecture has many variants of load/store instructions.
+	 * It is quite challenging to match all of them completely. Here, we
+	 * only match the prefixes of these instructions.
+	 */
+	err = regcomp(&arm->ldst_insn, "^(ld|st|cas|prf|swp)",
+		      REG_EXTENDED);
+	if (err)
+		goto out_free_jump;
 
 	arch->initialized = true;
 	arch->priv	  = arm;
@@ -117,6 +180,8 @@ static int arm64__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 	arch->e_flags = 0;
 	return 0;
 
+out_free_jump:
+	regfree(&arm->jump_insn);
 out_free_call:
 	regfree(&arm->call_insn);
 out_free_arm:
-- 
2.25.1

