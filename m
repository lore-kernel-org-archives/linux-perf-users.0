Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D861D4746A5;
	Fri,  4 Sep 2026 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532878; cv=none; b=u2OSfJAI/skqkmg/DF0SAKsF6XFGDfWuWUTq9IfXMrZPVxaPyz2/qzaIV16oEzDNIPkG3JeN9ErlOzKrtkZR0KE4H+WvAyDqPLecYdbNhD5W6Sipn14+oWk5e3Er/hrwMnnBhnyspiNBKZYP3vr+vvY8IfXkiGJcD0Op7OytmLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532878; c=relaxed/simple;
	bh=KWNQw2IQ/2CL24U6l4KTkjBiISA1RV3mmnp2TkI7qTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AC/hMr6hkXLHip7CSnlETHWpcYbvh/fAgoi6ILHMPq0csbnAgXW+8TybmIvRpArO5Z/RU8ztUIPw7opgJI+SCIgdcFNV/bwWX7CEMF6uieqKKdgTQSMl9iiu1tXMYOwweMqlCPESpQ4HR+zlMkblWorZu161k6scdtqUMH/irak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6N0JG4y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6N0JG4y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3690A1F00A3D;
	Fri,  4 Sep 2026 14:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788532876;
	bh=btJOcrj4wsYapHm+mAfsBpBmkL8dxGs1yHtXcd4dJzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X6N0JG4ymWkL/NEGRmCMUIvOYHK/aNrLD5FsYTOJ1mowgWV9fHUd4t90u/fxsp7/6
	 zN1BXutXbofNCB0I0IKKfOUTCrv4V9nZZGZKN3ZYe3t4/EQiBL85umOdrP/TMyy3PL
	 MLCsNoZ8LfbFRnGBSArY7QHwhrzdhduUZUdJXir7mBW0LnX4BvTNNAJcidnVjkxnph
	 AuZarGts5ZV7q/gkmqyVTYw3+B1ydCdZiTsxoSlRkTMD8ruc5RZXCwHemVRLwIzaiA
	 A1JRFNysuuoC80CnFN+jyhi6hm6pG6qjIY/hQcaPrKKxnCBn6bQEPjq9qTA8S12jkL
	 hu0wQDmv6i6Dg==
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
Date: Fri,  4 Sep 2026 11:40:54 -0300
Message-ID: <20260904144058.3341-3-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260904144058.3341-1-acme@kernel.org>
References: <20260904144058.3341-1-acme@kernel.org>
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

struct debug_entry.lineno is signed and emit_advance_lineno() takes a
long line delta that relies on sign extension, so the field is read
into an int: reading it into an unsigned int would turn a backward
line jump into a huge forward one and corrupt the line number program.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/genelf_debug.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/genelf_debug.c b/tools/perf/util/genelf_debug.c
index 8588b3e35e008396..7d9ef43aa6ac4ab6 100644
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
+	int lineno = get_unaligned(&ent->lineno);
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
@@ -362,6 +366,8 @@ static void emit_lineno_info(struct buffer_ext *be,
 	for (i = 0; i < nr_entry; i++, ent = debug_entry_next(ent)) {
 		int need_copy = 0;
 		ubyte special_opcode;
+		int lineno = get_unaligned(&ent->lineno);
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

