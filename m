Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471249;
	b=uki+TzwXU8mKRzDnywPXltiYajutvMWcSBQe6vkWVv0HBJ2Wbr2ZN/IU5xksITyL7e1E
	 jiX7beWBTlhfPKC35v1lG8+neksSHqRgxfHDKRnUkMmVotbJKEYrOhJxsuI6HLyS8l8xs
	 PrRK/GWo6RYRSHU9TcGFFkWFTkOcfjrq+PqHJB0icsgjIoaWiV/JAZ5lOA/vcMxYmECPI
	 sh4lg7f1M7H39JRluQlxZZllRgS8FXKtNTpAV/7zWyAtEdMpqsJcC4gL/VhjJzw85ib3E
	 d+DjnC9LME1lN9wHMFna9xFZk/IjEW7RnZDMK+9xUzGTdMCgFhfBKmMCtPZXVD4Ld5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471249;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Azkx36zjbxqJYLpSaoVLe2nz1AlSWqVWOKME4todCY0=;
	b=D6qlb53NC7ZlYqMd9FcjySykOymPmEOcxSKaDo5pjzzpTutt5BjYy50h3tfc3OO0Z6i4
	 CTttVJoJT6LMRnvbNA60iu24lhCPOwZfNVYRnBeS1r5Xi65U999TyCbo4QH3Jmq226hm0
	 rphJMGX5ygre2hqmGL+4jA4/HK2jKHE2UknG8m5xWf1rtoluTbTxPHzH4fWJ2iDBCZsEc
	 e6Go/J+BrKnnwqpDtSblaBgwq/03c44r2bY0CuD1zUaefXUq41+pmJmhC0W9YqPKSgM/O
	 aG96Dz8ZcU7lC5trS7vsUlQjL8F3N8w5hBRX6BQqe/1Le/JHtVuzBJHsCEm/sDtFviA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AjIBHUrx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6357F606A321;
	Mon, 23 Nov 2026 22:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AjIBHUrx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353DA1F000CA;
	Mon, 23 Nov 2026 22:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795471248;
	bh=Azkx36zjbxqJYLpSaoVLe2nz1AlSWqVWOKME4todCY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AjIBHUrxGKcooL2En/XoFmXkrTBcvf6UXw8UNJSwgGiin4ujbZ0ctbUrzptu9Zaqj
	 cLKxZZyNpFJSaM7vIjVW6HAIONFbp79WGdHxWmvpMvam+RvwaaP4MHG9n7mhsKYZBC
	 bWRrmzemiobHlgPiNqBbq1EvT8ZLV8ewLKjI6dXa2PhMCGyetjqSJLT15e2abza9E1
	 llwnJf7bXaiEmnNhmvYz34mIsPIs1N5jDLqT4F+putAnJYwEa9WdbSv0tIsb3T9FOo
	 ppKZKVETTdQt6V18RqJiYr33mLdYpNxBeYK8l8vRJeSh8xbYWVls9MI67ZSzro9CBC
	 +Dem97TlqlB9g==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v12 05/19] perf annotate-x86: Record immediates in a 64-bit field
Date: Mon, 23 Nov 2026 19:00:10 -0300
Message-ID: <20261123220024.14891-6-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123220024.14891-1-acme@kernel.org>
References: <20261123220024.14891-1-acme@kernel.org>
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

From: Arnaldo Carvalho de Melo <acme@redhat.com>

An x86 immediate is parsed into the int offset shared with
displacements, so a constant wider than 32 bits is truncated to garbage
that the register tracking then records as its value.

Add a s64 imm_value to struct annotated_op_loc, fill it in
extract_op_location_x86() with strtoull() and read it in the three
places of update_insn_state_x86() that take an immediate as a constant.
The displacement and the ARM64 and x86 %gs: immediates, which fit in
32 bits, stay in offset, and pointer offset tracking is unchanged.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate-arch/annotate-x86.c | 13 ++++++++-----
 tools/perf/util/annotate.h                   |  6 ++++--
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
index a975c39c3d6ce008..94c45806029ee670 100644
--- a/tools/perf/util/annotate-arch/annotate-x86.c
+++ b/tools/perf/util/annotate-arch/annotate-x86.c
@@ -341,7 +341,7 @@ static void update_insn_state_x86(struct type_state *state,
 		tsr->lifetime_end = 0;
 
 		if (src->imm)
-			imm_value = src->offset;
+			imm_value = src->imm_value;
 		else if (has_reg_type(state, src->reg1) &&
 			 state->regs[src->reg1].kind == TSR_KIND_CONST)
 			imm_value = state->regs[src->reg1].imm_value;
@@ -408,7 +408,7 @@ static void update_insn_state_x86(struct type_state *state,
 		tsr->lifetime_end = 0;
 
 		if (src->imm)
-			imm_value = src->offset;
+			imm_value = src->imm_value;
 		else if (has_reg_type(state, src->reg1) &&
 			 state->regs[src->reg1].kind == TSR_KIND_CONST)
 			imm_value = state->regs[src->reg1].imm_value;
@@ -589,7 +589,7 @@ static void update_insn_state_x86(struct type_state *state,
 
 		if (src->imm) {
 			tsr->kind = TSR_KIND_CONST;
-			tsr->imm_value = (s64)src->offset;
+			tsr->imm_value = src->imm_value;
 			tsr->offset = 0;
 			tsr->ok = true;
 
@@ -967,8 +967,11 @@ static void extract_op_location_x86(const struct arch *arch,
 		if (*s == arch->objdump.register_char) {
 			op_loc->reg1 = arch__dwarf_regnum(arch, s);
 		} else if (*s == arch->objdump.imm_char) {
-			op_loc->offset = strtol(s + 1, &p, 0);
-			if (p && p != s + 1)
+			const char *start = s + 1;
+			u64 imm = strtoull(start, &p, 0);
+
+			op_loc->imm_value = imm;
+			if (p && p != start)
 				op_loc->imm = true;
 		} else if (*s == '-' || strstarts(s, "0x")) {
 			u64 offset = strtoull(s, NULL, 0);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 58adf7f84146be5f..71a616b5ed1e1358 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -530,7 +530,8 @@ int arch__dwarf_regnum(const struct arch *arch, const char *str);
  * struct annotated_op_loc - Location info of instruction operand
  * @reg1: First register in the operand
  * @reg2: Second register in the operand
- * @offset: Memory access offset in the operand
+ * @imm_value: Immediate value of an x86 operand
+ * @offset: Memory access offset, or an ARM64 or x86 %gs: immediate
  * @segment: Segment selector register
  * @addr_mode: Addressing mode, only valid if @mem_ref is true
  * @extend_type: Operand extension type (enum annotated_ext_type)
@@ -538,11 +539,12 @@ int arch__dwarf_regnum(const struct arch *arch, const char *str);
  * @amount: Number of bits to shift
  * @mem_ref: Whether the operand accesses memory
  * @multi_regs: Whether the second register is used
- * @imm: Whether the operand is an immediate value (in offset)
+ * @imm: Whether the operand is an immediate value
  */
 struct annotated_op_loc {
 	int reg1;
 	int reg2;
+	s64 imm_value;
 	int offset;
 	u8 segment;
 	u8 addr_mode;
-- 
2.56.0

