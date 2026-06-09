Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA42A4C6EF0
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029281; cv=none; b=EcDGX1rJh0XlDI4HoJ++h4NOlVwrUBK64dN9ACf55DLVi4NJcFvXVY49rQhnxHe53aLYscBpLRoJLvHl3qqqMgq0HajFfx5LAZEIJaTHusCnx/8H3r5J6L1h/HsQ6rqWAmIpnu+xUfl+vGL7qqRSmQdKcV50Cti48+IKHkCKTyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029281; c=relaxed/simple;
	bh=dSyIgjT2bJ44og1ElHsBaG00Z+CdRzqDlJznSTF9A9A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YcQ22YPzilE19mgF4TtiVif1jYck0mlZCzGDxTuGRxfCvg/YFXPjPh5E3JEe8C+9d1j/CyeClQcOA07wb+bK+Q+qjsbxfi0nGWwnh4iTg7SWKdVcHmyKuPT+w7ZL4vdn80WJg7XgBi39I3ztzQEXDWFC8FXMwWR11Mwsuu5PXP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IYlK/Bcl; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IYlK/Bcl"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304ec73b015so10898463eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 11:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781029279; x=1781634079; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HmizuxN+Z6y+cWDUSblQcEadcSDhQGs2qPF68vHWSOk=;
        b=IYlK/BclGvReVufFPliMyb00FZCaJdbaqgkE7uDO1wnTAeyrV52AgayFh+ARK5QWMl
         +YWePpCM8pOCIth4aq9uRluXLYjY0P/7NWgIrE9UUrVSQbHdGakiITHuX/QPugDPJ+OW
         bchyp8F/4xE/5KvywK0GKllCBps/Ff9PIo35tFA7bD+sQvyWcaL14J19yvW3J1DDsr9P
         D8PpUDtqLRGCDjvJXjWbivosQqd9nfYl8FI0+ksJCZVNNgInNsYa4lts/3/RVKoZ2Rst
         peOOIs8hbpsTR4D3XmhLuZ0t5mxlJGZT8a4vswNmUzqlyut4DN/ULQp/6QWMIa+DOHNO
         qvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781029279; x=1781634079;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HmizuxN+Z6y+cWDUSblQcEadcSDhQGs2qPF68vHWSOk=;
        b=frz1b1q8gHocKGDBlEzDx/UDvKLTZcZlDraqT/p0J3fsdxowtTOGliSNk+vZhudjCE
         R+YiQG2gg+fgehSe4OntTkXRlksKO4tChfDqvCi8Df6GJobcRXxE49sS/gMTR3A2hbXV
         wYr2o6fSId1iBf8g2vNcKNyqlInMErnhuF+uxZpAezxnCnQQBhbJQutgPtJ7LfrQsts7
         7hk602pX0aMlSoxC0FQeB1m+THPfkNI/DI5+KmYcBNfm6ukQ6OpiT78KLOhPo/NJdhgm
         yyMcB098bfIh5ZfzCCy+BM4rdBas68uPALuvCgJBbqqzIeE9mFd81JQRip05ZSWBenyX
         zuPg==
X-Forwarded-Encrypted: i=1; AFNElJ+5cb0uC3XjJeXAP3VkqMdaEE2cnd9P5WF/E4KwpDHw13bx6k8Pnw7lXNpwmCtkyBopFf1bgKrSoHSj3MHPgOS1@vger.kernel.org
X-Gm-Message-State: AOJu0YyFSR7mAmLQjeaiAEvmRBMdmVSGf09nr4YnCwKkQIMSVP6Fkslz
	cdosAV5cIwbGDRtn3PpSKs2LCnS6yrMkYQyCtahvqkkK1B1oRbouOqFqjz3gOwZcnWeDPPsi2kF
	nWLxIQhjgPQ==
X-Received: from dycc13.prod.google.com ([2002:a05:693c:60cd:b0:304:5761:e0e7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:80c5:b0:2d9:6373:ad22
 with SMTP id 5a478bee46e88-307d5fed6d7mr3603424eec.12.1781029278675; Tue, 09
 Jun 2026 11:21:18 -0700 (PDT)
Date: Tue,  9 Jun 2026 11:21:04 -0700
In-Reply-To: <20260609182108.975586-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609070732.545416-1-irogers@google.com> <20260609182108.975586-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260609182108.975586-4-irogers@google.com>
Subject: [PATCH v3 3/7] perf annotate: Implement elfutils libasm disassembler backend
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, 
	alexandre.chartre@oracle.com, blakejones@google.com, bpf@vger.kernel.org, 
	costa.shul@redhat.com, dsterba@suse.com, james.clark@linaro.org, 
	jolsa@kernel.org, leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark@klomp.org, mingo@redhat.com, 
	mjeanson@efficios.com, nathan@kernel.org, peterz@infradead.org, 
	rong.bao@csmantle.top, serhei@serhei.io, terrelln@fb.com, tglozar@redhat.com, 
	tianyou.li@intel.com, yuzhuo@google.com, zecheng@google.com
Content-Type: text/plain; charset="UTF-8"

Implement the core disassembler backend in libasm.c utilizing elfutils'
libasm API. Hook the backend into perf annotate disassembler routing.
Configure libasm as the first-choice disassembler backend by default
(ahead of LLVM/capstone) when available.
Also, expose annotation_options__add_disassemblers_str to allow
custom disassembler selection.

Assisted-by: Antigravity:Google Gemini 3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build      |   1 +
 tools/perf/util/annotate.c |   8 +-
 tools/perf/util/annotate.h |   3 +
 tools/perf/util/disasm.c   |   5 +
 tools/perf/util/libasm.c   | 184 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/libasm.h   |  27 ++++++
 6 files changed, 226 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/util/libasm.c
 create mode 100644 tools/perf/util/libasm.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index b22cdc24082a..f1d5ebb2edfa 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -12,6 +12,7 @@ perf-util-y += block-range.o
 perf-util-y += build-id.o
 perf-util-y += cacheline.o
 perf-util-$(CONFIG_LIBCAPSTONE) += capstone.o
+perf-util-$(CONFIG_LIBASM) += libasm.o
 perf-util-y += config.o
 perf-util-y += copyfile.o
 perf-util-y += ctype.o
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 02505222d8c2..2259ac2c2cd6 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2233,6 +2233,7 @@ const char * const perf_disassembler__strs[] = {
 	[PERF_DISASM_UNKNOWN]  = "unknown",
 	[PERF_DISASM_LLVM]     = "llvm",
 	[PERF_DISASM_CAPSTONE] = "capstone",
+	[PERF_DISASM_LIBASM]   = "libasm",
 	[PERF_DISASM_OBJDUMP]  = "objdump",
 };
 
@@ -2254,8 +2255,8 @@ static void annotation_options__add_disassembler(struct annotation_options *opti
 	pr_err("Failed to add disassembler %d\n", dis);
 }
 
-static int annotation_options__add_disassemblers_str(struct annotation_options *options,
-						const char *str)
+int annotation_options__add_disassemblers_str(struct annotation_options *options,
+					     const char *str)
 {
 	while (str && *str != '\0') {
 		const char *comma = strchr(str, ',');
@@ -2372,6 +2373,9 @@ static void annotation_options__default_init_disassemblers(struct annotation_opt
 		/* Already initialized. */
 		return;
 	}
+#ifdef HAVE_LIBASM_SUPPORT
+	annotation_options__add_disassembler(options, PERF_DISASM_LIBASM);
+#endif
 #ifdef HAVE_LIBLLVM_SUPPORT
 	annotation_options__add_disassembler(options, PERF_DISASM_LLVM);
 #endif
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 1aa6df7d1618..21ac2b6472c1 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -38,6 +38,7 @@ enum perf_disassembler {
 	PERF_DISASM_UNKNOWN = 0,
 	PERF_DISASM_LLVM,
 	PERF_DISASM_CAPSTONE,
+	PERF_DISASM_LIBASM,
 	PERF_DISASM_OBJDUMP,
 };
 #define MAX_DISASSEMBLERS (PERF_DISASM_OBJDUMP + 1)
@@ -484,6 +485,8 @@ int hist_entry__tty_annotate2(struct hist_entry *he, struct evsel *evsel);
 
 void annotation_options__init(void);
 void annotation_options__exit(void);
+int annotation_options__add_disassemblers_str(struct annotation_options *options,
+					      const char *str);
 
 void annotation_config__init(void);
 
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 59ba88e1f744..42af3603fdff 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -22,6 +22,7 @@
 #include "capstone.h"
 #include "debug.h"
 #include "disasm.h"
+#include "libasm.h"
 #include "dso.h"
 #include "dwarf-regs.h"
 #include "env.h"
@@ -1622,6 +1623,10 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 			args->options->disassembler_used = PERF_DISASM_CAPSTONE;
 			err = symbol__disassemble_capstone(symfs_filename, sym, args);
 			break;
+		case PERF_DISASM_LIBASM:
+			args->options->disassembler_used = PERF_DISASM_LIBASM;
+			err = symbol__disassemble_libasm(symfs_filename, sym, args);
+			break;
 		case PERF_DISASM_OBJDUMP:
 			args->options->disassembler_used = PERF_DISASM_OBJDUMP;
 			err = symbol__disassemble_objdump(symfs_filename, sym, args);
diff --git a/tools/perf/util/libasm.c b/tools/perf/util/libasm.c
new file mode 100644
index 000000000000..2f0a65733522
--- /dev/null
+++ b/tools/perf/util/libasm.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "libasm.h"
+
+#include <errno.h>
+#include <fcntl.h>
+#include <inttypes.h>
+#include <string.h>
+#include <unistd.h>
+#include <elfutils/libasm.h>
+#include <gelf.h>
+
+#include "annotate.h"
+#include "debug.h"
+#include "disasm.h"
+#include "dso.h"
+#include "map.h"
+#include "namespaces.h"
+#include "symbol.h"
+
+struct ebl;
+extern struct ebl *ebl_openbackend(Elf *elf);
+extern void ebl_closebackend(struct ebl *ebl);
+
+struct disasm_output_arg {
+	char *buf;
+	size_t size;
+};
+
+static int disasm_output_cb(char *str, size_t len, void *arg)
+{
+	struct disasm_output_arg *oa = arg;
+	size_t to_copy = len < oa->size - 1 ? len : oa->size - 1;
+
+	memcpy(oa->buf, str, to_copy);
+	oa->buf += to_copy;
+	oa->size -= to_copy;
+	*oa->buf = '\0';
+	return 1;
+}
+
+int symbol__disassemble_libasm(const char *filename, struct symbol *sym,
+			       struct annotate_args *args)
+{
+	struct annotation *notes = symbol__annotation(sym);
+	struct map *map = args->ms->map;
+	struct dso *dso = map__dso(map);
+	u64 start = map__rip_2objdump(map, sym->start);
+	u64 offset;
+	bool is_64bit = false;
+	u8 *code_buf = NULL;
+	const u8 *buf;
+	u64 buf_len;
+	Elf *elf = NULL;
+	struct ebl *ebl = NULL;
+	DisasmCtx_t *handle = NULL;
+	char disasm_buf[512];
+	struct disasm_line *dl;
+	struct nscookie nsc;
+	const uint8_t *pc;
+	const uint8_t *end;
+	u64 addr;
+	size_t insn_len;
+	int ret;
+	int fd = -1;
+	int count = 0;
+
+	if (args->options->objdump_path)
+		return -1;
+
+	buf = dso__read_symbol(dso, filename, map, sym,
+			       &code_buf, &buf_len, &is_64bit);
+	if (buf == NULL)
+		return errno;
+
+	/* add the function address and name */
+	scnprintf(disasm_buf, sizeof(disasm_buf), "%#"PRIx64" <%s>:",
+		  start, sym->name);
+
+	args->offset = -1;
+	args->line = disasm_buf;
+	args->line_nr = 0;
+	args->fileloc = NULL;
+	args->ms->sym = sym;
+
+	dl = disasm_line__new(args);
+	if (dl == NULL)
+		goto err;
+
+	annotation_line__add(&dl->al, &notes->src->source);
+
+	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
+	fd = open(filename, O_RDONLY);
+	nsinfo__mountns_exit(&nsc);
+	if (fd < 0)
+		goto err;
+
+	elf = elf_begin(fd, ELF_C_READ, NULL);
+	if (!elf)
+		goto err;
+
+	ebl = ebl_openbackend(elf);
+	if (!ebl)
+		goto err;
+
+	handle = disasm_begin(ebl, elf, NULL);
+	if (!handle)
+		goto err;
+
+	pc = buf;
+	end = buf + buf_len;
+	addr = start;
+
+	offset = 0;
+	while (pc < end) {
+		struct disasm_output_arg oa = {
+			.buf = disasm_buf,
+			.size = sizeof(disasm_buf),
+		};
+		const uint8_t *prev_pc = pc;
+
+		ret = disasm_cb(handle, &pc, end, addr, "%7m %.1o,%.2o,%.3o,%.4o,%.5o",
+				    disasm_output_cb, &oa, NULL);
+		if (ret != 1 || pc == prev_pc) {
+			/* Disassembly failed or got stuck */
+			break;
+		}
+
+		args->offset = offset;
+		args->line = disasm_buf;
+
+		dl = disasm_line__new(args);
+		if (dl == NULL)
+			goto err;
+
+		annotation_line__add(&dl->al, &notes->src->source);
+
+		insn_len = pc - prev_pc;
+		offset += insn_len;
+		addr += insn_len;
+		count++;
+	}
+
+	if (offset != buf_len) {
+		struct list_head *list = &notes->src->source;
+
+		/* Discard all lines and fallback to objdump */
+		while (!list_empty(list)) {
+			dl = list_first_entry(list, struct disasm_line, al.node);
+
+			list_del_init(&dl->al.node);
+			disasm_line__free(dl);
+		}
+		count = -1;
+	}
+
+out:
+	if (handle)
+		disasm_end(handle);
+	if (ebl)
+		ebl_closebackend(ebl);
+	if (elf)
+		elf_end(elf);
+	if (fd >= 0)
+		close(fd);
+	free(code_buf);
+	return count < 0 ? count : 0;
+
+err:
+	{
+		struct disasm_line *tmp;
+
+		/*
+		 * It probably failed in the middle of the above loop.
+		 * Release any resources it might add.
+		 */
+		list_for_each_entry_safe(dl, tmp, &notes->src->source, al.node) {
+			list_del(&dl->al.node);
+			disasm_line__free(dl);
+		}
+	}
+
+	count = -1;
+	goto out;
+}
diff --git a/tools/perf/util/libasm.h b/tools/perf/util/libasm.h
new file mode 100644
index 000000000000..d4324edf059e
--- /dev/null
+++ b/tools/perf/util/libasm.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_LIBASM_H
+#define __PERF_LIBASM_H
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+struct annotate_args;
+struct symbol;
+
+#ifdef HAVE_LIBASM_SUPPORT
+int symbol__disassemble_libasm(const char *filename, struct symbol *sym,
+				 struct annotate_args *args);
+#else /* !HAVE_LIBASM_SUPPORT */
+static inline int symbol__disassemble_libasm(const char *filename __maybe_unused,
+					       struct symbol *sym __maybe_unused,
+					       struct annotate_args *args __maybe_unused)
+{
+	return -1;
+}
+#endif /* HAVE_LIBASM_SUPPORT */
+
+#endif /* __PERF_LIBASM_H */
-- 
2.54.0.1099.g489fc7bff1-goog

