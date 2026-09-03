Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C3A4AF689;
	Thu,  3 Sep 2026 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441810; cv=none; b=ZbK60XsmnDpTZM6ilOkLvjqZPkzB3fuanDP0RMlgvnEVHRrGxsEF0CzXnIfxgmFnMewOQAQ9ZgJbwm0h8xJSZZ06r+K+zG4i3lIQpCxiZWqo+lMYoBeF3hgOYS1wf1gxRMoDbv9ja5gUqkMz72Y/8rtebnoe61SsNYxONqdH1Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441810; c=relaxed/simple;
	bh=WFKa63Oye/qzhW5yXboZ0JcjgEMNPlheCI6NJqbhZPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxxsBHduu6W0W3DiJsxeSal8rKxWGGF3rRHjIL5iEWy90WR3By7wcZhUo2oFsHOWmo2mboza7dK3L9qnT9peq46WsZT6WoVQnOaRdS+9T9adICFVblLMgjuUrs7AG4hCgg9Vq4pFO/QRs+kZrE3QxR6quF/Mr4EgAxiHifwvA3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Af1cZmvU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Af1cZmvU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C061F00A3F;
	Thu,  3 Sep 2026 13:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788441783;
	bh=mAt1qOAED3Xw3rcZh2N4iU/Xy6Foh+T0CCopd5eDx7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Af1cZmvUMAs7AQlH+uRuj7JUuDgsM2knQwabc5NubnzpQybtUdYQDrvNTP7K/sFyX
	 uGuPiRDdZeuXqR/TipfLhn/aLV2l5/TBp5iqLCVT1YZgzQV4i94JZcaxFQ5eek1SqB
	 OSBIkmdjeGkZC9ETO6oJJw21q7yLslOGvV7+75268wDqpHqNR7wPG7S3tSLVWINGYB
	 Uu0GP2/wSJiGpj9MgKyuffR4Iht4ecadkiqn6toxYDzyXvzgQZTewq4p32A/eo+TmH
	 19EiPk7b02RkY1pXpWJqHUHZRTY5cpf8iMoPi1qMf3hLJ1Pyyip8VvXNbml/LK7OBZ
	 CtYpmKZqCQn4w==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	Stephane Eranian <eranian@google.com>
Subject: [PATCH 2/5] perf genelf: Use unaligned-safe accessors for debug entries
Date: Thu,  3 Sep 2026 10:22:48 -0300
Message-ID: <20260903132251.237029-3-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903132251.237029-1-acme@kernel.org>
References: <20260903132251.237029-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

debug_entry records are packed with a variable-length name[] field, so
entries after the first may start at addresses that are not naturally
aligned.  jit_process_debug_info(), get_special_opcode() and
emit_lineno_info() read and write the u64 addr and int lineno fields
through struct member access, which is undefined behavior on
strict-alignment architectures.

Use get_unaligned()/put_unaligned() to read and update each field,
matching the layout the jitdump writers (LLVM, JVM agents) emit, which
packs entries without padding.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/genelf_debug.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/genelf_debug.c b/tools/perf/util/genelf_debug.c
index 8588b3e35e008396..8244d3c64103b6be 100644
--- a/tools/perf/util/genelf_debug.c
+++ b/tools/perf/util/genelf_debug.c
@@ -12,6 +12,8 @@
  */
 #include <linux/compiler.h>
 #include <linux/zalloc.h>
+#include <linux/kernel.h>
+#include <linux/unaligned.h>
 #include <sys/types.h>
 #include <stdio.h>
 #include <getopt.h>
@@ -303,11 +305,13 @@ static ubyte get_special_opcode(struct debug_entry *ent,
 {
 	unsigned int temp;
 	unsigned long delta_addr;
+	unsigned int lineno = get_unaligned(&ent->lineno);
+	uint64_t addr = get_unaligned(&ent->addr);
 
 	/*
 	 * delta from line_base
 	 */
-	temp = (ent->lineno - last_line) - default_debug_line_header.line_base;
+	temp = (lineno - last_line) - default_debug_line_header.line_base;
 
 	if (temp >= default_debug_line_header.line_range)
 		return 0;
@@ -315,7 +319,7 @@ static ubyte get_special_opcode(struct debug_entry *ent,
 	/*
 	 * delta of addresses
 	 */
-	delta_addr = (ent->addr - last_vma) / default_debug_line_header.minimum_instruction_length;
+	delta_addr = (addr - last_vma) / default_debug_line_header.minimum_instruction_length;
 
 	/* This is not sufficient to ensure opcode will be in [0-256] but
 	 * sufficient to ensure when summing with the delta lineno we will
@@ -355,13 +359,15 @@ static void emit_lineno_info(struct buffer_ext *be,
 	unsigned long last_vma = 0;
 	char const  *cur_filename = NULL;
 	unsigned long cur_file_idx = 0;
-	int last_line = 1;
+	unsigned int last_line = 1;
 
 	emit_lne_set_address(be, (void *)code_addr);
 
 	for (i = 0; i < nr_entry; i++, ent = debug_entry_next(ent)) {
 		int need_copy = 0;
 		ubyte special_opcode;
+		unsigned int lineno = get_unaligned(&ent->lineno);
+		uint64_t addr = get_unaligned(&ent->addr);
 
 		/*
 		 * check if filename changed, if so add it
@@ -376,24 +382,24 @@ static void emit_lineno_info(struct buffer_ext *be,
 
 		special_opcode = get_special_opcode(ent, last_line, last_vma);
 		if (special_opcode != 0) {
-			last_line = ent->lineno;
-			last_vma  = ent->addr;
+			last_line = lineno;
+			last_vma  = addr;
 			emit_opcode(be, special_opcode);
 		} else {
 			/*
 			 * lines differ, emit line delta
 			 */
-			if (last_line != ent->lineno) {
-				emit_advance_lineno(be, ent->lineno - last_line);
-				last_line = ent->lineno;
+			if (last_line != lineno) {
+				emit_advance_lineno(be, lineno - last_line);
+				last_line = lineno;
 				need_copy = 1;
 			}
 			/*
 			 * addresses differ, emit address delta
 			 */
-			if (last_vma != ent->addr) {
-				emit_advance_pc(be, ent->addr - last_vma);
-				last_vma = ent->addr;
+			if (last_vma != addr) {
+				emit_advance_pc(be, addr - last_vma);
+				last_vma = addr;
 				need_copy = 1;
 			}
 			/*
@@ -480,7 +486,7 @@ jit_process_debug_info(uint64_t code_addr,
 	int i;
 
 	for (i = 0; i < nr_debug_entries; i++) {
-		ent->addr = ent->addr - code_addr;
+		put_unaligned(get_unaligned(&ent->addr) - code_addr, &ent->addr);
 		ent = debug_entry_next(ent);
 	}
 	add_compilation_unit(di, buffer_ext_size(dl));
-- 
2.55.0

