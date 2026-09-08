Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100713D4130;
	Tue,  8 Sep 2026 21:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788901887; cv=none; b=GZN821EQYGynBY7OPRvIv1YcsGuWZq9zLHgCIyG5aYaiSo6zNZAwUJ+PkCWrR9tg6aLHKegc+uInlGOsHqmF7Ft0aNrfqMa46sd2tC3ozySR9uSECPUhIHgeCRkgvjGVDAT3TuWoZ/o3yp/dHLQXZemk2Oca0i9eLKMhdBB5dpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788901887; c=relaxed/simple;
	bh=6D883CD2wr2Py7VW5NdlHvcKz+aEZU7BYevTXwMz6MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCeHX1X9V6e1esXc/O/+8111+SMEvfmv52YOd7aRqn4m9CGXtV45s+HhKJhnOleugNVsYVErrwUbxWSgL4voUlUuV28pveoeQUt0v/XHEPQd6YnEj6OHD0SsAGek7wYQjCYvHqywEIS7G4X/GT+2ASH8tLyoMDEnWVjAMqs35RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hu/Ds/qF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hu/Ds/qF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBEE1F00A3A;
	Tue,  8 Sep 2026 21:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788901885;
	bh=fjERWspeddswXdxXy1/xj9AiaxX9ZM1qQojxWsimpks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hu/Ds/qFR4dDhJVrw9JBMBHI17K0ySQC7+cZZQ/hB7tegfQYsHF1TMq5bqww8tenA
	 VpF+itFwwreFerHB+K9atwOIOfFjAqO7QOgzDKWf2RH5+4IJ6DHsnDcYiKcfGSUlqK
	 WGqTquD8WXcGrX5e8OrDmXwNSk384nnt0/y4UZIKQ78dxIwzt/Il3gyRA9ifRhBSmZ
	 mBdNQYKYjtsOY711AbqxoQlqwxBIerJaUZzHg3KtWty3EwXxA/UZemPTYQhedvSZWl
	 OM7qCzt2gL2ib74cojyhraDMw2r4nqBlrG+iIZY9EtJRneXM2mUfVQceWNCnwqZtqk
	 CCHO4E3+Lc4+g==
Date: Tue, 8 Sep 2026 18:11:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Matt Turner <mattst88@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf annotate: add Alpha instruction support
Message-ID: <aqB5-vP1q7g42Hp0@x2>
References: <20260905-perf-alpha-annotate-v1-0-97380433ccb6@gmail.com>
 <20260905-perf-alpha-annotate-v1-2-97380433ccb6@gmail.com>
 <CAP-5=fW8s5WndkCDEHFhxmBOqRV+3LCz8kKFoiU7ExJHviFFiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW8s5WndkCDEHFhxmBOqRV+3LCz8kKFoiU7ExJHviFFiQ@mail.gmail.com>

On Tue, Sep 08, 2026 at 10:35:57AM -0700, Ian Rogers wrote:
> On Sat, Sep 5, 2026 at 3:54 PM Matt Turner <mattst88@gmail.com> wrote:
> >
> > Teach perf annotate about the Alpha control-transfer instructions, so that
> > an Alpha perf.data gets call and jump arrows and resolved call targets,
> > whether it is read on Alpha or on another host.
> >
> > Add tools/perf/util/annotate-arch/annotate-alpha.c with arch__new_alpha()
> > and an associate_instruction_ops() that classifies:
> >
> >   call:   bsr, plus jsr and jcr as indirect calls
> >   ret:    ret
> >   jump:   br, the conditional branches beq/bne/blt/ble/bgt/bge/blbc/blbs
> >           and fbeq/fbne/fblt/fble/fbgt/fbge, plus jmp as an indirect jump
> >   mov:    mov, fmov (objdump pseudos)
> >
> > That is every mnemonic binutils can print for the branch and JSR formats.
> > jcr rather than jsr_coroutine, because both name the same MBR(0x1a,3)
> > encoding and print_insn_alpha() takes the first match in the table, where
> > the jcr alias has come first since the sources were imported in 1999.
> >
> > bsr needs an Alpha-specific parse routine.  The generic call__parse()
> > expects the operand string to begin with the target address, but a bsr
> > prints its return-address register first:
> >
> >   bsr     t0,fffffc0001031dc0 <cserve_ena>
> >
> > strtoull() then stops on the leading register name, leaving the target
> > address as 0, which makes call__scnprintf() fall back to printing the raw
> > operands and leaves target.sym unresolved so the browser cannot follow the
> > call.  alpha_call__parse() takes the address from after the comma instead,
> > as s390_call__parse() does for the same reason.  The PC-relative branches
> > need no such handling, as jump__parse() already skips up to two operands.
> >
> > jsr and jmp get ins_ops that resolve no target at all.  They transfer
> > control to a register, and their trailing operand is only a branch
> > prediction hint:
> >
> >   jsr     ra,(t12),fffffc0001014ee8 <_printk>
> >
> > binutils extracts that hint as a 14-bit signed field scaled by four and
> > prints it relative to the next instruction (extract_jhint() in alpha-opc.c,
> > print_insn_alpha() in alpha-dis.c), so it can name the callee only when the
> > callee lies within the resulting +-32KB.  It also defaults to zero, which
> > prints as the next instruction.  Of the 213750 jsr in a vmlinux built from
> > this tree, only 23093 hints land on a symbol; 157204 point into the middle
> > of an unrelated function and 33453 are that default.  Parsing the hint
> > would therefore invent a call target for the majority of calls, so these
> > keep their operands, as an indirect call does elsewhere.
> >
> > EM_ALPHA is 0x9026, far too large to index the e_machine-keyed
> > arch_new_fn[] table in arch__find(), so select arch__new_alpha explicitly
> > before the table lookup.  Declare it in disasm.h and add the object to the
> > annotate-arch Build.
> >
> > Disassembly itself comes from objdump/binutils, which already supports
> > Alpha; this provides perf's instruction-class metadata for annotation.
> >
> > Tested on an EV7 Marvel, both natively and by annotating its perf.data on
> > an x86_64 host, over bsr to a local function, jsr through the PLT and
> > kernel-mode jsr; the two hosts produce identical output.
> >
> > Signed-off-by: Matt Turner <mattst88@gmail.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

WOW! EV7 Marvel! :-)

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
 
> Thanks!
> Ian
> 
> > ---
> >  tools/perf/util/annotate-arch/Build            |   1 +
> >  tools/perf/util/annotate-arch/annotate-alpha.c | 185 +++++++++++++++++++++++++
> >  tools/perf/util/disasm.c                       |  15 +-
> >  tools/perf/util/disasm.h                       |   1 +
> >  4 files changed, 200 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/annotate-arch/Build b/tools/perf/util/annotate-arch/Build
> > index 23316743fdc5..0a74e1a9f17b 100644
> > --- a/tools/perf/util/annotate-arch/Build
> > +++ b/tools/perf/util/annotate-arch/Build
> > @@ -1,3 +1,4 @@
> > +perf-util-y += annotate-alpha.o
> >  perf-util-y += annotate-arc.o
> >  perf-util-y += annotate-arm.o
> >  perf-util-y += annotate-arm64.o
> > diff --git a/tools/perf/util/annotate-arch/annotate-alpha.c b/tools/perf/util/annotate-arch/annotate-alpha.c
> > new file mode 100644
> > index 000000000000..ccb13e2338a2
> > --- /dev/null
> > +++ b/tools/perf/util/annotate-arch/annotate-alpha.c
> > @@ -0,0 +1,185 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <linux/compiler.h>
> > +#include <linux/kernel.h>
> > +#include <linux/zalloc.h>
> > +#include "../../util/disasm.h"
> > +#include "../../util/map.h"
> > +#include "../../util/maps.h"
> > +#include "../../util/symbol.h"
> > +#include "../../util/thread.h"
> > +
> > +/*
> > + * Alpha control-transfer instructions, as printed by objdump:
> > + *
> > + *   PC-relative (opcode group 0x30-0x3f), 21-bit displacement:
> > + *     br, bsr                             unconditional / to-subroutine
> > + *     beq bne blt ble bgt bge blbc blbs   integer conditional
> > + *     fbeq fbne fblt fble fbgt fbge       floating conditional
> > + *
> > + *   Register-indirect (JSR group, opcode 0x1a):
> > + *     jmp, jsr, ret, jcr
> > + *
> > + * bsr/jsr (and jcr, the coroutine form, which binutils prints in preference to
> > + * the jsr_coroutine spelling) save a return address, so they are calls; ret
> > + * returns; everything else that transfers control is a jump.
> > + *
> > + * Alpha has no machine "mov"; objdump prints "mov"/"fmov" as pseudos for
> > + * bis/cpys, so map them to mov_ops when present.  The no-ops are deliberately
> > + * left alone: nop_ops would let delete_last_nop() trim the padding gcc leaves
> > + * at the end of a function, but its scnprintf() prints the literal "nop", and
> > + * Alpha pads with unop (ldq_u $31) rather than nop.
> > + */
> > +
> > +/*
> > + * The generic call__parse() expects the target address to be the first thing
> > + * in the operand string, but a bsr prints its return-address register first:
> > + *
> > + *     bsr     t0,fffffc0001031dc0 <cserve_ena>
> > + *
> > + * so take the address from after the comma.  Without this the address comes
> > + * out as 0, and neither the callee symbol nor the annotation browser's
> > + * "go to target" work.
> > + */
> > +static int alpha_call__parse(const struct arch *arch, struct ins_operands *ops,
> > +                            struct map_symbol *ms,
> > +                            struct disasm_line *dl __maybe_unused)
> > +{
> > +       char *endptr, *tok, *name;
> > +       struct map *map = ms->map;
> > +       struct addr_map_symbol target;
> > +
> > +       tok = strchr(ops->raw, ',');
> > +       if (tok == NULL)
> > +               return -1;
> > +
> > +       ops->target.addr = strtoull(tok + 1, &endptr, 16);
> > +       if (endptr == tok + 1)
> > +               return -1;
> > +
> > +       /* A stripped object has no "<symbol>" to name the target with. */
> > +       name = strchr(endptr, '<');
> > +       if (name == NULL)
> > +               goto find_target;
> > +
> > +       name++;
> > +
> > +       if (arch->objdump.skip_functions_char &&
> > +           strchr(name, arch->objdump.skip_functions_char))
> > +               return -1;
> > +
> > +       tok = strchr(name, '>');
> > +       if (tok == NULL)
> > +               return -1;
> > +
> > +       *tok = '\0';
> > +       ops->target.name = strdup(name);
> > +       *tok = '>';
> > +
> > +       if (ops->target.name == NULL)
> > +               return -1;
> > +
> > +find_target:
> > +       target = (struct addr_map_symbol) {
> > +               .ms = { .map = map__get(map), },
> > +               .addr = map__objdump_2mem(map, ops->target.addr),
> > +       };
> > +
> > +       if (maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
> > +           map__rip_2objdump(target.ms.map,
> > +                             map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
> > +               ops->target.sym = target.ms.sym;
> > +
> > +       addr_map_symbol__exit(&target);
> > +       return 0;
> > +}
> > +
> > +static const struct ins_ops alpha_call_ops = {
> > +       .parse     = alpha_call__parse,
> > +       .scnprintf = call__scnprintf,
> > +       .is_call   = true,
> > +};
> > +
> > +/*
> > + * jsr and jmp transfer control to a register, and their trailing operand is
> > + * only a branch prediction hint:
> > + *
> > + *     jsr     ra,(t12),fffffc0001014ee8 <_printk>
> > + *
> > + * binutils extracts that hint as a 14-bit signed field scaled by four and
> > + * prints it relative to the next instruction (extract_jhint() in alpha-opc.c,
> > + * print_insn_alpha() in alpha-dis.c), so it can name the callee only when the
> > + * callee lies within the resulting +-32KB.  It also defaults to zero, which
> > + * prints as the next instruction.  Most hints are therefore not the callee at
> > + * all, and parsing one would invent a call target, so these resolve no target
> > + * and keep their operands, as an indirect call does elsewhere.  The hint on
> > + * jcr is not even an address.
> > + */
> > +static const struct ins_ops alpha_indirect_call_ops = {
> > +       .scnprintf = ins__raw_scnprintf,
> > +       .is_call   = true,
> > +};
> > +
> > +static const struct ins_ops alpha_indirect_jump_ops = {
> > +       .scnprintf = ins__raw_scnprintf,
> > +       .is_jump   = true,
> > +};
> > +
> > +static int is_alpha_cond_branch(const char *name)
> > +{
> > +       static const char *const branches[] = {
> > +               "beq", "bne", "blt", "ble", "bgt", "bge", "blbc", "blbs",
> > +               "fbeq", "fbne", "fblt", "fble", "fbgt", "fbge",
> > +       };
> > +       unsigned int i;
> > +
> > +       for (i = 0; i < ARRAY_SIZE(branches); i++) {
> > +               if (!strcmp(name, branches[i]))
> > +                       return 1;
> > +       }
> > +       return 0;
> > +}
> > +
> > +static const struct ins_ops *alpha__associate_instruction_ops(struct arch *arch, const char *name)
> > +{
> > +       const struct ins_ops *ops = NULL;
> > +
> > +       if (!strcmp(name, "bsr")) {
> > +               ops = &alpha_call_ops;
> > +       } else if (!strcmp(name, "jsr") ||
> > +                  !strcmp(name, "jcr")) {
> > +               ops = &alpha_indirect_call_ops;
> > +       } else if (!strcmp(name, "ret")) {
> > +               ops = &ret_ops;
> > +       } else if (!strcmp(name, "jmp")) {
> > +               ops = &alpha_indirect_jump_ops;
> > +       } else if (!strcmp(name, "br") ||
> > +                  is_alpha_cond_branch(name)) {
> > +               ops = &jump_ops;
> > +       } else if (!strcmp(name, "mov") ||
> > +                  !strcmp(name, "fmov")) {
> > +               ops = &mov_ops;
> > +       }
> > +
> > +       if (ops)
> > +               arch__associate_ins_ops(arch, name, ops);
> > +
> > +       return ops;
> > +}
> > +
> > +const struct arch *arch__new_alpha(const struct e_machine_and_e_flags *id,
> > +                                  const char *cpuid __maybe_unused)
> > +{
> > +       struct arch *arch = zalloc(sizeof(*arch));
> > +
> > +       if (!arch)
> > +               return NULL;
> > +
> > +       arch->name = "alpha";
> > +       arch->id = *id;
> > +       arch->associate_instruction_ops = alpha__associate_instruction_ops;
> > +       /* objdump emits no comments for Alpha; '#' is what the assembler uses. */
> > +       arch->objdump.comment_char = '#';
> > +       return arch;
> > +}
> > diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> > index 6cfdbabbb8c7..49c206a88eec 100644
> > --- a/tools/perf/util/disasm.c
> > +++ b/tools/perf/util/disasm.c
> > @@ -161,6 +161,8 @@ const struct arch *arch__find(uint16_t e_machine, uint32_t e_flags, const char *
> >                 .e_flags = e_flags,
> >         };
> >         const struct arch *result = NULL, **tmp;
> > +       const struct arch *(*new_fn)(const struct e_machine_and_e_flags *id,
> > +                                    const char *cpuid) = NULL;
> >
> >         if (num_archs > 0) {
> >                 tmp = bsearch(&key, archs, num_archs, sizeof(*archs), arch__key_cmp);
> > @@ -171,7 +173,16 @@ const struct arch *arch__find(uint16_t e_machine, uint32_t e_flags, const char *
> >         if (result)
> >                 return result;
> >
> > -       if (e_machine >= ARRAY_SIZE(arch_new_fn) || arch_new_fn[e_machine] == NULL) {
> > +       /*
> > +        * EM_ALPHA (0x9026) is far too large to index arch_new_fn[], so it is
> > +        * selected explicitly; everything else uses the e_machine-indexed table.
> > +        */
> > +       if (e_machine == EM_ALPHA)
> > +               new_fn = arch__new_alpha;
> > +       else if (e_machine < ARRAY_SIZE(arch_new_fn))
> > +               new_fn = arch_new_fn[e_machine];
> > +
> > +       if (new_fn == NULL) {
> >                 errno = ENOTSUP;
> >                 return NULL;
> >         }
> > @@ -182,7 +193,7 @@ const struct arch *arch__find(uint16_t e_machine, uint32_t e_flags, const char *
> >
> >         archs = tmp;
> >
> > -       result = arch_new_fn[e_machine](&key, cpuid);
> > +       result = new_fn(&key, cpuid);
> >         if (!result) {
> >                 pr_err("%s: failed to initialize %u arch priv area\n",
> >                         __func__, e_machine);
> > diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
> > index 25756e3f47e4..adbdbf8f1f35 100644
> > --- a/tools/perf/util/disasm.h
> > +++ b/tools/perf/util/disasm.h
> > @@ -122,6 +122,7 @@ extern const struct ins_ops ret_ops;
> >
> >  int arch__associate_ins_ops(struct arch *arch, const char *name, const struct ins_ops *ops);
> >
> > +const struct arch *arch__new_alpha(const struct e_machine_and_e_flags *id, const char *cpuid);
> >  const struct arch *arch__new_arc(const struct e_machine_and_e_flags *id, const char *cpuid);
> >  const struct arch *arch__new_arm(const struct e_machine_and_e_flags *id, const char *cpuid);
> >  const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id, const char *cpuid);
> >
> > --
> > 2.54.0
> >
