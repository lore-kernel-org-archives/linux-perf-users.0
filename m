Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FF971B4C;
	Tue,  7 May 2024 04:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715057861; cv=none; b=E6+PQJZaEMS7PLHyawE58uPftmLjf8uxR4geppjrYvA5ZT0famHcx2yKkumPJtYy1R3A5Rmcj7bLMQBAZSBlfIm03kSRfv7ifv6SwoEDzbUcemE53xjE2s/62nBAuOXgw2AVviC8GOX1PTB6crg9WgWmzxn+1SesNH7DpAFGxsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715057861; c=relaxed/simple;
	bh=1ndGqnt0Yucv/TtBDYG6nGnM4UoIraHXey9EMNGl6ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z8w67swiNySsKcOlAHyHGlGnf/NmU3wxzBj5DqwaFkfmT+UGsn7+165sPr6JXofQLbHycyzTcsTfXGNfGLF4vJc7TyTcoAuQ0RzeL5eSVmHFiZ8o0qK9gL8FD2WFWob2XDnYjYvw8lAPz9glh8HdCWjrsgBTFCcAdCvO3XQODCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-60585faa69fso1714115a12.1;
        Mon, 06 May 2024 21:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715057858; x=1715662658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stzd46xkuc3HDoFga9LqxNKWgbIkvsfh9h+FPDMTTcg=;
        b=tdN58cevMhsuZsXKpoASf/BQ+jBNKQaWRHNPwVx6nzgIXVCAJlAEyotSTn11KSWlra
         iZtRz1c5dnwfRwCl7stkn8g7ELFREtpNCDga0L0kMDXMTjyouBNG3hRexZQgNZEeKEDl
         CHYX0+NEa+hp07aBt0diMnvnRsimC7Br1z1hCQpVmTLJY2yjarlVN9B6kKUybzh5c4Xp
         +hW/qqvXBTp7lAytBnR8inKTej8neJKFD/75ylTsgGTdjFPQPHERQcCApkdsPxNXj25K
         88wLmIH62SIm7UunAp1A98D18KZAMo5oGLvMW+FbF5WtzmXvQ8tRMgrq9gBUcyOFD+Jy
         nLOA==
X-Forwarded-Encrypted: i=1; AJvYcCWTTXTHGWxENw+qPZqacNFVlPIcP1w/IWxphkA5lNnSjYHQ2CuYUNAk4G776gtQ9+8RuNovbvZ5OHJxdZ4Kj+TQmNAVuNtfHO0jvHEFGnvPWtsW3TRH32kQAdf1AOjBWx3RPHB91fntSaWs0RbtcQ==
X-Gm-Message-State: AOJu0YxrecfoFz77VohT0/zkzj+gJHzex3PvRvvXW1CiulAIuGocQ6/d
	EcQtnnWKJ4HszCJDWrz07C6Irzt2/ygywHA5A2ry6TU56jNV0LLxwHptVDrC8pr6xHifVeGBAej
	KG9bnTyGGFTX73RXk6fiWNKwkp8E=
X-Google-Smtp-Source: AGHT+IH2NF8/ctvHIcMuqKsanTtAceI5j8zU119ATbhXrxOC2Se2De+unE5jfahH1dbciqnk41/8L3uePUQtYbGiMic=
X-Received: by 2002:a17:90a:b018:b0:2b2:da7:2c83 with SMTP id
 x24-20020a17090ab01800b002b20da72c83mr2473617pjq.4.1715057858240; Mon, 06 May
 2024 21:57:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506121906.76639-1-atrajeev@linux.vnet.ibm.com> <20240506121906.76639-5-atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20240506121906.76639-5-atrajeev@linux.vnet.ibm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 6 May 2024 21:57:27 -0700
Message-ID: <CAM9d7ci1LDa7moT2qDr2qK+DTNLU6ZBkmROnbdozAjuQLQfNog@mail.gmail.com>
Subject: Re: [PATCH V2 4/9] tools/perf: Add support to capture and parse raw
 instruction in objdump
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	irogers@google.com, segher@kernel.crashing.org, christophe.leroy@csgroup.eu, 
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	maddy@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com, 
	linux-kernel@vger.kernel.org, akanksha@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 5:21=E2=80=AFAM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
> Add support to capture and parse raw instruction in objdump.
> Currently, the perf tool infrastructure uses "--no-show-raw-insn" option
> with "objdump" while disassemble. Example from powerpc with this option
> for an instruction address is:
>
> Snippet from:
> objdump  --start-address=3D<address> --stop-address=3D<address>  -d --no-=
show-raw-insn -C <vmlinux>
>
> c0000000010224b4:       lwz     r10,0(r9)
>
> This line "lwz r10,0(r9)" is parsed to extract instruction name,
> registers names and offset. Also to find whether there is a memory
> reference in the operands, "memory_ref_char" field of objdump is used.
> For x86, "(" is used as memory_ref_char to tackle instructions of the
> form "mov  (%rax), %rcx".
>
> In case of powerpc, not all instructions using "(" are the only memory
> instructions. Example, above instruction can also be of extended form (X
> form) "lwzx r10,0,r19". Inorder to easy identify the instruction category
> and extract the source/target registers, patch adds support to use raw
> instruction. With raw instruction, macros are added to extract opcode
> and register fields.
>
> "struct ins_operands" and "struct ins" is updated to carry opcode and
> raw instruction binary code (raw_insn). Function "disasm_line__parse"
> is updated to fill the raw instruction hex value and opcode in newly
> added fields. There is no changes in existing code paths, which parses
> the disassembled code. The architecture using the instruction name and
> present approach is not altered. Since this approach targets powerpc,
> the macro implementation is added for powerpc as of now.
>
> Example:
> representation using --show-raw-insn in objdump gives result:
>
> 38 01 81 e8     ld      r4,312(r1)
>
> Here "38 01 81 e8" is the raw instruction representation. In powerpc,
> this translates to instruction form: "ld RT,DS(RA)" and binary code
> as:
> _____________________________________
> | 58 |  RT  |  RA |      DS       | |
> -------------------------------------
> 0    6     11    16              30 31
>
> Function "disasm_line__parse" is updated to capture:
>
> line:    38 01 81 e8     ld      r4,312(r1)
> opcode and raw instruction "38 01 81 e8"
> Raw instruction is used later to extract the reg/offset fields.
>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/include/linux/string.h              |  2 +
>  tools/lib/string.c                        | 13 +++++++
>  tools/perf/arch/powerpc/util/dwarf-regs.c | 19 ++++++++++
>  tools/perf/util/disasm.c                  | 46 +++++++++++++++++++----
>  tools/perf/util/disasm.h                  |  6 +++
>  tools/perf/util/include/dwarf-regs.h      |  9 +++++
>  6 files changed, 88 insertions(+), 7 deletions(-)
>
> diff --git a/tools/include/linux/string.h b/tools/include/linux/string.h
> index db5c99318c79..0acb1fc14e19 100644
> --- a/tools/include/linux/string.h
> +++ b/tools/include/linux/string.h
> @@ -46,5 +46,7 @@ extern char * __must_check skip_spaces(const char *);
>
>  extern char *strim(char *);
>
> +extern void remove_spaces(char *s);
> +
>  extern void *memchr_inv(const void *start, int c, size_t bytes);
>  #endif /* _TOOLS_LINUX_STRING_H_ */
> diff --git a/tools/lib/string.c b/tools/lib/string.c
> index 8b6892f959ab..21d273e69951 100644
> --- a/tools/lib/string.c
> +++ b/tools/lib/string.c
> @@ -153,6 +153,19 @@ char *strim(char *s)
>         return skip_spaces(s);
>  }
>
> +/*
> + * remove_spaces - Removes whitespaces from @s
> + */
> +void remove_spaces(char *s)
> +{
> +       char *d =3D s;
> +       do {
> +               while (*d =3D=3D ' ') {
> +                       ++d;
> +               }
> +       } while ((*s++ =3D *d++));
> +}
> +
>  /**
>   * strreplace - Replace all occurrences of character in string.
>   * @s: The string to operate on.
> diff --git a/tools/perf/arch/powerpc/util/dwarf-regs.c b/tools/perf/arch/=
powerpc/util/dwarf-regs.c
> index 0c4f4caf53ac..e60a71fd846e 100644
> --- a/tools/perf/arch/powerpc/util/dwarf-regs.c
> +++ b/tools/perf/arch/powerpc/util/dwarf-regs.c
> @@ -98,3 +98,22 @@ int regs_query_register_offset(const char *name)
>                         return roff->ptregs_offset;
>         return -EINVAL;
>  }
> +
> +#define        PPC_OP(op)      (((op) >> 26) & 0x3F)
> +#define PPC_RA(a)      (((a) >> 16) & 0x1f)
> +#define PPC_RT(t)      (((t) >> 21) & 0x1f)
> +
> +int get_opcode_insn(unsigned int raw_insn)
> +{
> +       return PPC_OP(raw_insn);
> +}
> +
> +int get_source_reg(unsigned int raw_insn)
> +{
> +       return PPC_RA(raw_insn);
> +}
> +
> +int get_target_reg(unsigned int raw_insn)
> +{
> +       return PPC_RT(raw_insn);
> +}
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 2de66a092cab..85692f73e78f 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -43,7 +43,7 @@ static int call__scnprintf(struct ins *ins, char *bf, s=
ize_t size,
>                            struct ins_operands *ops, int max_ins_name);
>
>  static void ins__sort(struct arch *arch);
> -static int disasm_line__parse(char *line, const char **namep, char **raw=
p);
> +static int disasm_line__parse(char *line, const char **namep, char **raw=
p, int *opcode, int *rawp_insn);
>
>  static __attribute__((constructor)) void symbol__init_regexpr(void)
>  {
> @@ -512,7 +512,7 @@ static int lock__parse(struct arch *arch, struct ins_=
operands *ops, struct map_s
>         if (ops->locked.ops =3D=3D NULL)
>                 return 0;
>
> -       if (disasm_line__parse(ops->raw, &ops->locked.ins.name, &ops->loc=
ked.ops->raw) < 0)
> +       if (disasm_line__parse(ops->raw, &ops->locked.ins.name, &ops->loc=
ked.ops->raw, &ops->locked.ins.opcode, &ops->locked.ops->raw_insn) < 0)

This line is too long.


>                 goto out_free_ops;
>
>         ops->locked.ins.ops =3D ins__find(arch, ops->locked.ins.name);
> @@ -815,11 +815,38 @@ static void disasm_line__init_ins(struct disasm_lin=
e *dl, struct arch *arch, str
>                 dl->ins.ops =3D NULL;
>  }
>
> -static int disasm_line__parse(char *line, const char **namep, char **raw=
p)
> +int __weak get_opcode_insn(unsigned int raw_insn __maybe_unused)
>  {
> -       char tmp, *name =3D skip_spaces(line);
> +       return -1;
> +}
> +
> +int __weak get_source_reg(unsigned int raw_insn __maybe_unused)
> +{
> +       return -1;
> +}
> +
> +int __weak get_target_reg(unsigned int raw_insn __maybe_unused)
> +{
> +       return -1;
> +}

I prefer having conditional code with #ifdef rather than weak
functions especially if it isn't needed for every arch.

> +
> +/*
> + * Parses the objdump result captured with --show-raw-insn.
> + * Example, objdump line from powerpc:
> + * line:    38 01 81 e8     ld      r4,312(r1)
> + * namep : ld
> + * rawp  : "ld r4,312(r1)"
> + * opcode: fetched from arch specific get_opcode_insn
> + * rawp_insn: e8810138
> + *
> + * rawp_insn is used later to extract the reg/offset fields
> + */
> +static int disasm_line__parse(char *line, const char **namep, char **raw=
p, int *opcode, int *rawp_insn)
> +{
> +       char tmp, *tmp_opcode, *name_opcode =3D skip_spaces(line);
> +       char *name =3D skip_spaces(name_opcode + 11);
>
> -       if (name[0] =3D=3D '\0')
> +       if (name_opcode[0] =3D=3D '\0')
>                 return -1;
>
>         *rawp =3D name + 1;
> @@ -829,13 +856,18 @@ static int disasm_line__parse(char *line, const cha=
r **namep, char **rawp)
>
>         tmp =3D (*rawp)[0];
>         (*rawp)[0] =3D '\0';
> +       tmp_opcode =3D strdup(name_opcode);
> +       tmp_opcode[11] =3D '\0';

Looks like powerpc specific.  Can we move it under arch check?


> +       remove_spaces(tmp_opcode);
>         *namep =3D strdup(name);
> +       *opcode =3D get_opcode_insn(be32_to_cpu(strtol(tmp_opcode, NULL, =
16)));

This as well.  Maybe we could have per-arch disasm_line__parse().

>
>         if (*namep =3D=3D NULL)
>                 goto out;
>
>         (*rawp)[0] =3D tmp;
>         *rawp =3D strim(*rawp);
> +       *rawp_insn =3D be32_to_cpu(strtol(tmp_opcode, NULL, 16));
>
>         return 0;
>
> @@ -896,7 +928,7 @@ struct disasm_line *disasm_line__new(struct annotate_=
args *args)
>                 goto out_delete;
>
>         if (args->offset !=3D -1) {
> -               if (disasm_line__parse(dl->al.line, &dl->ins.name, &dl->o=
ps.raw) < 0)
> +               if (disasm_line__parse(dl->al.line, &dl->ins.name, &dl->o=
ps.raw, &dl->ins.opcode, &dl->ops.raw_insn) < 0)
>                         goto out_free_line;
>
>                 disasm_line__init_ins(dl, args->arch, &args->ms);
> @@ -1726,7 +1758,7 @@ int symbol__disassemble(struct symbol *sym, struct =
annotate_args *args)
>                  map__rip_2objdump(map, sym->start),
>                  map__rip_2objdump(map, sym->end),
>                  opts->show_linenr ? "-l" : "",
> -                opts->show_asm_raw ? "" : "--no-show-raw-insn",
> +                opts->show_asm_raw ? "" : "--show-raw-insn",

This is not what we want.  According to the man page of objdump
the --show-raw-insn should be enabled by default.  So I think the
default value prints nothing.  But if it's not the case on powerpc
(maybe on x86 too?) we could add it in the positive case too and
make powerpc init code reset the option.

Thanks,
Namhyung


>                  opts->annotate_src ? "-S" : "",
>                  opts->prefix ? "--prefix " : "",
>                  opts->prefix ? '"' : ' ',
> diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
> index 718177fa4775..5c1520010ca7 100644
> --- a/tools/perf/util/disasm.h
> +++ b/tools/perf/util/disasm.h
> @@ -43,14 +43,18 @@ struct arch {
>
>  struct ins {
>         const char     *name;
> +       int     opcode;
>         struct ins_ops *ops;
>  };
>
>  struct ins_operands {
>         char    *raw;
> +       int     raw_insn;
>         struct {
>                 char    *raw;
>                 char    *name;
> +               int     opcode;
> +               int     raw_insn;
>                 struct symbol *sym;
>                 u64     addr;
>                 s64     offset;
> @@ -62,6 +66,8 @@ struct ins_operands {
>                 struct {
>                         char    *raw;
>                         char    *name;
> +                       int     opcode;
> +                       int     raw_insn;
>                         u64     addr;
>                         bool    multi_regs;
>                 } source;
> diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/inclu=
de/dwarf-regs.h
> index 01fb25a1150a..2a4e1e16e52c 100644
> --- a/tools/perf/util/include/dwarf-regs.h
> +++ b/tools/perf/util/include/dwarf-regs.h
> @@ -31,6 +31,15 @@ static inline int get_dwarf_regnum(const char *name __=
maybe_unused,
>  }
>  #endif
>
> +/*
> + * get_opcode_insn - Return opcode from raw instruction
> + * get_source_reg - Return source reg from raw instruction
> + * get_target_reg - Return target reg from raw instruction
> + */
> +int get_opcode_insn(unsigned int raw_insn);
> +int get_source_reg(unsigned int raw_insn);
> +int get_target_reg(unsigned int raw_insn);
> +
>  #ifdef HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET
>  /*
>   * Arch should support fetching the offset of a register in pt_regs
> --
> 2.43.0
>
