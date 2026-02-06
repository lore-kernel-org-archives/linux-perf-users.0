Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467821D5CDE;
	Fri,  6 Feb 2026 01:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770341265; cv=none; b=stoJXZQbXsF7sh9gJWtJFA6C8Fg446/zcqI6/EU6cEMr8aNfNSfLCS+rjyYfvFdAHx5ODnn6i/9/y9i3hEIs42uhdRgCm3z/ZP6lyyivB6mv8PEiEmm3t1/oLGvPaQZIanARx40SXO27XNmBp90W2woj6YK//Z6dcXcMAOJ3FiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770341265; c=relaxed/simple;
	bh=ANpJIzR5HNcYo8sicxLeFSQ9MPvJSBTXMXVoccQ4Xts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DGq1SlGxFM9d0OvJiAjadDQNMvZWI859VtZrG4cZvfsLsqcvIGX5qOBUjfQqkHpOVH6k0/b0/lKGzuwWLSIEG3DsY6Xk2dHmK+w1Nwu1k12BArH4i7Vfo5YM23fKAxMt0y7kz5Y7w3SXDpt8aUUaJzhyZaC8xIOggFVUar0/t2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjPz31Yu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjPz31Yu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4B6C4CEF7;
	Fri,  6 Feb 2026 01:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770341264;
	bh=ANpJIzR5HNcYo8sicxLeFSQ9MPvJSBTXMXVoccQ4Xts=;
	h=From:To:Cc:Subject:Date:From;
	b=KjPz31YubS5PnM5BM6TyXHjn6+lt+74c7VyGOdGC/8CCYc7VyGGzXDrPZ5oplSwJp
	 8sL6UMI+uGxVc2pxA0qdLp7al1BcLJQsuiwm+T0E+Sx3Nrbeb7lCQuzYDIH1IoJfaC
	 DVR4JDoTPoJC8RS2wuThq0CydBB2sfR4WGNk2FFn8Nf/AX0Wm8vCj2RsIOUiMX5+W6
	 WKvYWhefDqpb1XsK7V9r4ox3OHnsNoXdP3nXJveb8LMYdyZF6KYZkEt/fvBzyoRnjq
	 B0CwPA8zXcjpui0HJPKNkGZRZYgp+OTOBReyQcnRgKCz76S91VZHR6SeITYdci8V+g
	 mL78kpY7Tpz0A==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Zecheng Li <zli94@ncsu.edu>,
	Dmitry Dolgov <9erthalion6@gmail.com>
Subject: [PATCH] perf annotate: Fix register usage in data type profiling
Date: Thu,  5 Feb 2026 17:27:43 -0800
Message-ID: <20260206012743.2617945-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On data type profiling, it tried to match register name with a partial
string.  For example, it allowed to match with "%rbp)" or "%rdi,8)".
But with recent change in the area, it doesn't match anymore and break
the data type profiling.

Let's pass the correct register name by removing the unwanted part.  Add
arch__dwarf_regnum() to handle it in a single place.

Reported-by: Dmitry Dolgov <9erthalion6@gmail.com>
Closes: 7d3n23li6drroxrdlpxn7ixehdeszkjdftah3zyngjl2qs22ef@yelcjv53v42o
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 61 +++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 880b1bd300c21e67..2e3522905046c1ec 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2447,6 +2447,29 @@ int annotate_check_args(void)
 	return 0;
 }
 
+static int arch__dwarf_regnum(const struct arch *arch, const char *str)
+{
+	const char *p;
+	char *regname, *q;
+	int reg;
+
+	p = strchr(str, arch->objdump.register_char);
+	if (p == NULL)
+		return -1;
+
+	regname = strdup(p);
+	if (regname == NULL)
+		return -1;
+
+	q = strpbrk(regname, ",) ");
+	if (q)
+		*q = '\0';
+
+	reg = get_dwarf_regnum(regname, arch->id.e_machine, arch->id.e_flags);
+	free(regname);
+	return reg;
+}
+
 /*
  * Get register number and access offset from the given instruction.
  * It assumes AT&T x86 asm format like OFFSET(REG).  Maybe it needs
@@ -2457,7 +2480,6 @@ static int extract_reg_offset(const struct arch *arch, const char *str,
 			      struct annotated_op_loc *op_loc)
 {
 	char *p;
-	char *regname;
 
 	if (arch->objdump.register_char == 0)
 		return -1;
@@ -2482,31 +2504,14 @@ static int extract_reg_offset(const struct arch *arch, const char *str,
 	}
 
 	op_loc->offset = strtol(str, &p, 0);
-
-	p = strchr(p, arch->objdump.register_char);
-	if (p == NULL)
+	op_loc->reg1 = arch__dwarf_regnum(arch, p);
+	if (op_loc->reg1 == -1)
 		return -1;
 
-	regname = strdup(p);
-	if (regname == NULL)
-		return -1;
-
-	op_loc->reg1 = get_dwarf_regnum(regname, arch->id.e_machine, arch->id.e_flags);
-	free(regname);
-
 	/* Get the second register */
-	if (op_loc->multi_regs) {
-		p = strchr(p + 1, arch->objdump.register_char);
-		if (p == NULL)
-			return -1;
-
-		regname = strdup(p);
-		if (regname == NULL)
-			return -1;
+	if (op_loc->multi_regs)
+		op_loc->reg2 = arch__dwarf_regnum(arch, p + 1);
 
-		op_loc->reg2 = get_dwarf_regnum(regname, arch->id.e_machine, arch->id.e_flags);
-		free(regname);
-	}
 	return 0;
 }
 
@@ -2585,7 +2590,8 @@ int annotate_get_insn_location(const struct arch *arch, struct disasm_line *dl,
 			op_loc->multi_regs = multi_regs;
 			extract_reg_offset(arch, insn_str, op_loc);
 		} else {
-			char *s, *p = NULL;
+			const char *s = insn_str;
+			char *p = NULL;
 
 			if (arch__is_x86(arch)) {
 				/* FIXME: Handle other segment registers */
@@ -2599,21 +2605,14 @@ int annotate_get_insn_location(const struct arch *arch, struct disasm_line *dl,
 				}
 			}
 
-			s = strdup(insn_str);
-			if (s == NULL)
-				return -1;
-
 			if (*s == arch->objdump.register_char) {
-				op_loc->reg1 = get_dwarf_regnum(s,
-								arch->id.e_machine,
-								arch->id.e_flags);
+				op_loc->reg1 = arch__dwarf_regnum(arch, s);
 			}
 			else if (*s == arch->objdump.imm_char) {
 				op_loc->offset = strtol(s + 1, &p, 0);
 				if (p && p != s + 1)
 					op_loc->imm = true;
 			}
-			free(s);
 		}
 	}
 
-- 
2.53.0.rc2.204.g2597b5adb4-goog

