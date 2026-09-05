Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A703A0E99
	for <linux-perf-users@vger.kernel.org>; Sat,  5 Sep 2026 22:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788648860; cv=none; b=mfrs42fvV9z36q7PqU8EqinFmo/x6Thd2EnqNZPEJWQLwgoE5MMkY9Ut+6y5UL50prhgD9+83bTpmAzVxtE4tjaaWOvPnaEt43Vrt8AsgUxtqHmXzrUfnQLjH4s4E6tPDfkv5gbZd5gcYQS5jDEtjqR0YQ96vQ42QnK4PnskKDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788648860; c=relaxed/simple;
	bh=/58G8eUDsOzZ2bOuezTjemWkfnT0icE7T2bofe6pu8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oDPGQLJe0LOh+RqYV3V8E6WhADh3jM0A7sKZjaH+viLVomuAHLSxUIw+jusT3WBaweJ3Ei5RHr6YAT6Gn9qrQjoECptvFClAzQVMOoyeIz3YiRybHahkt8KeP+NuIJa290n+TJLSr67XQ7amCqTgghCctUOwnaubm8bwEtbXKVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wq5uwBws; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wq5uwBws"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-836c4474028so23008197b3.0
        for <linux-perf-users@vger.kernel.org>; Sat, 05 Sep 2026 15:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788648858; x=1789253658; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Si/NxKj3MUw1ND7afSQVGNXR4y19pRWNSVZzgFbIzjE=;
        b=Wq5uwBws1LmKxiRRWl71DiqCFKR62+/P5a7AI02hpVbIEQB4GsyPMbQMr6A1Nn04lH
         5zBZhwIJzpsuhWX/YSaE/33L6ZkMEEN29D/fulSJC7KI6UySUzYZiOFp2LxoaZxPgTD+
         pDYF+Eg1SP7m/c0e/DQUTNwaFenlH5i/QtikWG0e4dQPxBnn7UKcGeA4w4W+smmYqSuO
         Y1nAkZXqVVdgcEpFjlarwshIjoeV/K1dSABSqRy4J89+JHUm+gaotWv2fSsgfG6FqZ6N
         aF2TbM6Py55uMyEzZGq6A7VkBcVi4TTyIWeWXfqyCO6K/4lsa4RVfXKUvhxSbeIvf+XD
         ncBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788648858; x=1789253658;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Si/NxKj3MUw1ND7afSQVGNXR4y19pRWNSVZzgFbIzjE=;
        b=Vscku6OQnLT9lRxMZlF75SQJNmE+UcA84dnKBAiD33JT3NdHAMLFK++V7V0ugDndL8
         UA91vArV+HzIBDI6o7fTOyYA2DwcmmmCaArBHcyPTeo7iKcUvY2v+GCzMLSpmZCxyvBF
         czSl8a/xSrE2PbKz5bMUoK1sWXpHgr/+z4p93MIh2HgT81ytzCLXH+H2V43bSDki2Frl
         BLjRj4fpMtC+NgW7k0CFdvNu755xrm6LOFX+eUP1NjplaCClSd/3BB+1juC3B/6LfdCf
         vtz+ekQVjnNPwUk8vp/53fB/N4/aEFWU3Ee7Ujhun2u7xSmtZhw8AIWsmo2H94dk5OP/
         FDtw==
X-Gm-Message-State: AFuF++n9dj/IYEWUAWpfObvKSvBYBZ8O5tcOwaUVEW40Ogpvy0tbzC6o
	qdHc6/0yDtyOB/Dm6RWye3g1WW2d5GD8epXxG3vJpgtwApV2Blt66Uqu
X-Gm-Gg: AYBFou2+zemp0/kNak71jsB/IE32fGN7OsGqNtiSC/Iy9hcE1VM+9Dk3GcGWia3cqQw
	h5Vw7wztnjj+qQfB1hL9Q5peQLdJFX4ljd7Row5wEKPXupz1EpA+hSqY0Xf+bxZxAH069gvLgre
	dalUrxX/mO6dIp0PLCfxo33eoEXIykfa1cTNd+HOe7Ex0cBMFsAfjI6XDhM0+tCEBt50jL8zNiw
	qkvPA240ofHDriOE/bUuw0Gmbl+nwdNXAwAqKjiyMpleZ5JoZd8bSppeViesC5rcwSJmKKN4cjG
	eXV6zrFQK8Gy0D1BKD1lAUqrjlR45KIJJhSuW/m54Oe+qGO2zmBXJsBEV3Z8JZ1P/pYdjmyAXUm
	GouzLokDBwEpzBPiMAxnVl1VjsE5S/zP29O8XPexL4icnrjtIk4QMwmlCntV8O6/86yfWD9YoGF
	eF85ANn1y9tPH17DuSE8UBV+A8XQ9oH/BENavbi8BttLmuxFJOQsBqVEq0Opnw
X-Received: by 2002:a05:690c:e3ea:b0:873:5bb2:6bfa with SMTP id 00721157ae682-8735bb26d93mr25233117b3.36.1788648857604;
        Sat, 05 Sep 2026 15:54:17 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714931516dsm46273517b3.17.2026.09.05.15.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 15:54:16 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Sat, 05 Sep 2026 18:54:12 -0400
Subject: [PATCH 2/2] perf annotate: add Alpha instruction support
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-perf-alpha-annotate-v1-2-97380433ccb6@gmail.com>
References: <20260905-perf-alpha-annotate-v1-0-97380433ccb6@gmail.com>
In-Reply-To: <20260905-perf-alpha-annotate-v1-0-97380433ccb6@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=12016; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=/58G8eUDsOzZ2bOuezTjemWkfnT0icE7T2bofe6pu8I=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLmzJ08U+1f0EfHzc1neffkza0orrszf9+eI87npDik0
 o+9Pycr1fGRhUGMi2GmmCJL3HpFllltO5b6nJb+BTOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GQIZOkbxEDk9Bo3M4uLS1CLdtIIih7z8ksSSzPy8Yr38gtS8gvQCvbTMtJKMjPyi4lSgEXp5qSW
 mro5uRoYGJpaOFmZOFo6mJs7OToZObo6Ozq5ORpbmJgbOlo4mrpbmDFycAjDXSLIx/A9MDf2wkM
 F7WveBhr0Zn2zeOxyK8JSyNtYpyDvq+GfBQUGG/zWX3S4fct2+8GrFD932FT1p63O2dy3X0VqgO
 X3h65V3JvIAAA==
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

Teach perf annotate about the Alpha control-transfer instructions, so that
an Alpha perf.data gets call and jump arrows and resolved call targets,
whether it is read on Alpha or on another host.

Add tools/perf/util/annotate-arch/annotate-alpha.c with arch__new_alpha()
and an associate_instruction_ops() that classifies:

  call:   bsr, plus jsr and jcr as indirect calls
  ret:    ret
  jump:   br, the conditional branches beq/bne/blt/ble/bgt/bge/blbc/blbs
          and fbeq/fbne/fblt/fble/fbgt/fbge, plus jmp as an indirect jump
  mov:    mov, fmov (objdump pseudos)

That is every mnemonic binutils can print for the branch and JSR formats.
jcr rather than jsr_coroutine, because both name the same MBR(0x1a,3)
encoding and print_insn_alpha() takes the first match in the table, where
the jcr alias has come first since the sources were imported in 1999.

bsr needs an Alpha-specific parse routine.  The generic call__parse()
expects the operand string to begin with the target address, but a bsr
prints its return-address register first:

  bsr     t0,fffffc0001031dc0 <cserve_ena>

strtoull() then stops on the leading register name, leaving the target
address as 0, which makes call__scnprintf() fall back to printing the raw
operands and leaves target.sym unresolved so the browser cannot follow the
call.  alpha_call__parse() takes the address from after the comma instead,
as s390_call__parse() does for the same reason.  The PC-relative branches
need no such handling, as jump__parse() already skips up to two operands.

jsr and jmp get ins_ops that resolve no target at all.  They transfer
control to a register, and their trailing operand is only a branch
prediction hint:

  jsr     ra,(t12),fffffc0001014ee8 <_printk>

binutils extracts that hint as a 14-bit signed field scaled by four and
prints it relative to the next instruction (extract_jhint() in alpha-opc.c,
print_insn_alpha() in alpha-dis.c), so it can name the callee only when the
callee lies within the resulting +-32KB.  It also defaults to zero, which
prints as the next instruction.  Of the 213750 jsr in a vmlinux built from
this tree, only 23093 hints land on a symbol; 157204 point into the middle
of an unrelated function and 33453 are that default.  Parsing the hint
would therefore invent a call target for the majority of calls, so these
keep their operands, as an indirect call does elsewhere.

EM_ALPHA is 0x9026, far too large to index the e_machine-keyed
arch_new_fn[] table in arch__find(), so select arch__new_alpha explicitly
before the table lookup.  Declare it in disasm.h and add the object to the
annotate-arch Build.

Disassembly itself comes from objdump/binutils, which already supports
Alpha; this provides perf's instruction-class metadata for annotation.

Tested on an EV7 Marvel, both natively and by annotating its perf.data on
an x86_64 host, over bsr to a local function, jsr through the PLT and
kernel-mode jsr; the two hosts produce identical output.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 tools/perf/util/annotate-arch/Build            |   1 +
 tools/perf/util/annotate-arch/annotate-alpha.c | 185 +++++++++++++++++++++++++
 tools/perf/util/disasm.c                       |  15 +-
 tools/perf/util/disasm.h                       |   1 +
 4 files changed, 200 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate-arch/Build b/tools/perf/util/annotate-arch/Build
index 23316743fdc5..0a74e1a9f17b 100644
--- a/tools/perf/util/annotate-arch/Build
+++ b/tools/perf/util/annotate-arch/Build
@@ -1,3 +1,4 @@
+perf-util-y += annotate-alpha.o
 perf-util-y += annotate-arc.o
 perf-util-y += annotate-arm.o
 perf-util-y += annotate-arm64.o
diff --git a/tools/perf/util/annotate-arch/annotate-alpha.c b/tools/perf/util/annotate-arch/annotate-alpha.c
new file mode 100644
index 000000000000..ccb13e2338a2
--- /dev/null
+++ b/tools/perf/util/annotate-arch/annotate-alpha.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdlib.h>
+#include <string.h>
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/zalloc.h>
+#include "../../util/disasm.h"
+#include "../../util/map.h"
+#include "../../util/maps.h"
+#include "../../util/symbol.h"
+#include "../../util/thread.h"
+
+/*
+ * Alpha control-transfer instructions, as printed by objdump:
+ *
+ *   PC-relative (opcode group 0x30-0x3f), 21-bit displacement:
+ *     br, bsr                             unconditional / to-subroutine
+ *     beq bne blt ble bgt bge blbc blbs   integer conditional
+ *     fbeq fbne fblt fble fbgt fbge       floating conditional
+ *
+ *   Register-indirect (JSR group, opcode 0x1a):
+ *     jmp, jsr, ret, jcr
+ *
+ * bsr/jsr (and jcr, the coroutine form, which binutils prints in preference to
+ * the jsr_coroutine spelling) save a return address, so they are calls; ret
+ * returns; everything else that transfers control is a jump.
+ *
+ * Alpha has no machine "mov"; objdump prints "mov"/"fmov" as pseudos for
+ * bis/cpys, so map them to mov_ops when present.  The no-ops are deliberately
+ * left alone: nop_ops would let delete_last_nop() trim the padding gcc leaves
+ * at the end of a function, but its scnprintf() prints the literal "nop", and
+ * Alpha pads with unop (ldq_u $31) rather than nop.
+ */
+
+/*
+ * The generic call__parse() expects the target address to be the first thing
+ * in the operand string, but a bsr prints its return-address register first:
+ *
+ *	bsr	t0,fffffc0001031dc0 <cserve_ena>
+ *
+ * so take the address from after the comma.  Without this the address comes
+ * out as 0, and neither the callee symbol nor the annotation browser's
+ * "go to target" work.
+ */
+static int alpha_call__parse(const struct arch *arch, struct ins_operands *ops,
+			     struct map_symbol *ms,
+			     struct disasm_line *dl __maybe_unused)
+{
+	char *endptr, *tok, *name;
+	struct map *map = ms->map;
+	struct addr_map_symbol target;
+
+	tok = strchr(ops->raw, ',');
+	if (tok == NULL)
+		return -1;
+
+	ops->target.addr = strtoull(tok + 1, &endptr, 16);
+	if (endptr == tok + 1)
+		return -1;
+
+	/* A stripped object has no "<symbol>" to name the target with. */
+	name = strchr(endptr, '<');
+	if (name == NULL)
+		goto find_target;
+
+	name++;
+
+	if (arch->objdump.skip_functions_char &&
+	    strchr(name, arch->objdump.skip_functions_char))
+		return -1;
+
+	tok = strchr(name, '>');
+	if (tok == NULL)
+		return -1;
+
+	*tok = '\0';
+	ops->target.name = strdup(name);
+	*tok = '>';
+
+	if (ops->target.name == NULL)
+		return -1;
+
+find_target:
+	target = (struct addr_map_symbol) {
+		.ms = { .map = map__get(map), },
+		.addr = map__objdump_2mem(map, ops->target.addr),
+	};
+
+	if (maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
+	    map__rip_2objdump(target.ms.map,
+			      map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
+		ops->target.sym = target.ms.sym;
+
+	addr_map_symbol__exit(&target);
+	return 0;
+}
+
+static const struct ins_ops alpha_call_ops = {
+	.parse	   = alpha_call__parse,
+	.scnprintf = call__scnprintf,
+	.is_call   = true,
+};
+
+/*
+ * jsr and jmp transfer control to a register, and their trailing operand is
+ * only a branch prediction hint:
+ *
+ *	jsr	ra,(t12),fffffc0001014ee8 <_printk>
+ *
+ * binutils extracts that hint as a 14-bit signed field scaled by four and
+ * prints it relative to the next instruction (extract_jhint() in alpha-opc.c,
+ * print_insn_alpha() in alpha-dis.c), so it can name the callee only when the
+ * callee lies within the resulting +-32KB.  It also defaults to zero, which
+ * prints as the next instruction.  Most hints are therefore not the callee at
+ * all, and parsing one would invent a call target, so these resolve no target
+ * and keep their operands, as an indirect call does elsewhere.  The hint on
+ * jcr is not even an address.
+ */
+static const struct ins_ops alpha_indirect_call_ops = {
+	.scnprintf = ins__raw_scnprintf,
+	.is_call   = true,
+};
+
+static const struct ins_ops alpha_indirect_jump_ops = {
+	.scnprintf = ins__raw_scnprintf,
+	.is_jump   = true,
+};
+
+static int is_alpha_cond_branch(const char *name)
+{
+	static const char *const branches[] = {
+		"beq", "bne", "blt", "ble", "bgt", "bge", "blbc", "blbs",
+		"fbeq", "fbne", "fblt", "fble", "fbgt", "fbge",
+	};
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(branches); i++) {
+		if (!strcmp(name, branches[i]))
+			return 1;
+	}
+	return 0;
+}
+
+static const struct ins_ops *alpha__associate_instruction_ops(struct arch *arch, const char *name)
+{
+	const struct ins_ops *ops = NULL;
+
+	if (!strcmp(name, "bsr")) {
+		ops = &alpha_call_ops;
+	} else if (!strcmp(name, "jsr") ||
+		   !strcmp(name, "jcr")) {
+		ops = &alpha_indirect_call_ops;
+	} else if (!strcmp(name, "ret")) {
+		ops = &ret_ops;
+	} else if (!strcmp(name, "jmp")) {
+		ops = &alpha_indirect_jump_ops;
+	} else if (!strcmp(name, "br") ||
+		   is_alpha_cond_branch(name)) {
+		ops = &jump_ops;
+	} else if (!strcmp(name, "mov") ||
+		   !strcmp(name, "fmov")) {
+		ops = &mov_ops;
+	}
+
+	if (ops)
+		arch__associate_ins_ops(arch, name, ops);
+
+	return ops;
+}
+
+const struct arch *arch__new_alpha(const struct e_machine_and_e_flags *id,
+				   const char *cpuid __maybe_unused)
+{
+	struct arch *arch = zalloc(sizeof(*arch));
+
+	if (!arch)
+		return NULL;
+
+	arch->name = "alpha";
+	arch->id = *id;
+	arch->associate_instruction_ops = alpha__associate_instruction_ops;
+	/* objdump emits no comments for Alpha; '#' is what the assembler uses. */
+	arch->objdump.comment_char = '#';
+	return arch;
+}
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 6cfdbabbb8c7..49c206a88eec 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -161,6 +161,8 @@ const struct arch *arch__find(uint16_t e_machine, uint32_t e_flags, const char *
 		.e_flags = e_flags,
 	};
 	const struct arch *result = NULL, **tmp;
+	const struct arch *(*new_fn)(const struct e_machine_and_e_flags *id,
+				     const char *cpuid) = NULL;
 
 	if (num_archs > 0) {
 		tmp = bsearch(&key, archs, num_archs, sizeof(*archs), arch__key_cmp);
@@ -171,7 +173,16 @@ const struct arch *arch__find(uint16_t e_machine, uint32_t e_flags, const char *
 	if (result)
 		return result;
 
-	if (e_machine >= ARRAY_SIZE(arch_new_fn) || arch_new_fn[e_machine] == NULL) {
+	/*
+	 * EM_ALPHA (0x9026) is far too large to index arch_new_fn[], so it is
+	 * selected explicitly; everything else uses the e_machine-indexed table.
+	 */
+	if (e_machine == EM_ALPHA)
+		new_fn = arch__new_alpha;
+	else if (e_machine < ARRAY_SIZE(arch_new_fn))
+		new_fn = arch_new_fn[e_machine];
+
+	if (new_fn == NULL) {
 		errno = ENOTSUP;
 		return NULL;
 	}
@@ -182,7 +193,7 @@ const struct arch *arch__find(uint16_t e_machine, uint32_t e_flags, const char *
 
 	archs = tmp;
 
-	result = arch_new_fn[e_machine](&key, cpuid);
+	result = new_fn(&key, cpuid);
 	if (!result) {
 		pr_err("%s: failed to initialize %u arch priv area\n",
 			__func__, e_machine);
diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index 25756e3f47e4..adbdbf8f1f35 100644
--- a/tools/perf/util/disasm.h
+++ b/tools/perf/util/disasm.h
@@ -122,6 +122,7 @@ extern const struct ins_ops ret_ops;
 
 int arch__associate_ins_ops(struct arch *arch, const char *name, const struct ins_ops *ops);
 
+const struct arch *arch__new_alpha(const struct e_machine_and_e_flags *id, const char *cpuid);
 const struct arch *arch__new_arc(const struct e_machine_and_e_flags *id, const char *cpuid);
 const struct arch *arch__new_arm(const struct e_machine_and_e_flags *id, const char *cpuid);
 const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id, const char *cpuid);

-- 
2.54.0

