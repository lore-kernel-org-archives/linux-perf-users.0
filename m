Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FCB2B2CF;
	Wed, 29 May 2024 04:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716955598; cv=none; b=s9mP2UGVh/Wkj5WYLMj/nEDF5DdYkGsWyxr/OyQqiScL34J58bk4F1Xgq1QzNFl0RwAYuxK9FzFcYlOzpFW4/XwQLAedLy7El89Yygc1SfRDo+xtEnUDUsvNggPBT1YRzlOMvYx9apnrcQa2H2605F3D5OjqOwCFEi1dxnbP6AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716955598; c=relaxed/simple;
	bh=eHvQGWB/jeGxlC6h3v+PGXLjrRKEMAB3d82rMVto+WU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eA7sXyu/Id6JthM4HPYTa6nopasqFXXBhWyTBRl/ca9KspO8rzr3poomX6yAI1ROGLwkuCnY6eE69zkESYogI/KVn3tGGPxK+aGTslfDmmFKyQ0FMVGXi8PF1me2fsYSWzdht7v9No/ODC1oJJwFZrLqvY13W/azOI8xui9QWLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70109d34a16so1319489b3a.2;
        Tue, 28 May 2024 21:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716955596; x=1717560396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+LnaSGthifIw7Ac95d0mNAQzX3PHK9zOzakDFYP2aA=;
        b=l7kDeiTMkh/xqQj3SSJB2S0xsR+78Bz3nhR41SwKAK1Um/SX8qgDD3i6HrGCfXmZxc
         m280KafGAIw4nFS7LUv8LCcHebDLKBT/4FDmNN6/JA2sL6yfYQZF3ZU+s4VOXPUJ84/Q
         w7a+EH9KoIwaqhhHIcuhWNL99Zy7pPUIJCAHN0ut/0o5vJyx44eTIw6KWOz5zoAxjxYn
         GOd1TM3pe0xygtHcJ+ltbT8xZEAWzLswuTiGzQcA+NYKIMTQvJiCVyTleQAEjO+P7dmw
         sanlrutI3ZgCZfP2mcAVQosG0+HX5KYHQMRXVcBqLeSweLAeo22wTVb616c4BAQi3oBi
         WJkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIkCXl2r95YtMHddGnQjEvAD0zj5Qbo1JPKGTKALw8FYFUAH4QOvYjc1elqfJ12CUtvpbkiqQAMsEmMjsc8P+3Cq8pWg0Ug7XHKxRfYT8ipQylrlHm9HR7/GqRMhmgMy2jfQ23oOSHxL6OwIdsbg==
X-Gm-Message-State: AOJu0Yyx3HIvMzYuE1+1shhQ/jc0F0hlSAMWu4KkmTtq7Yv5FyIPUkT8
	FE2UtrNQS83TAFMQTFySUx89WtVe8n1KcvPTMpGHMmMwpOt1KHA7zQg+lxsV0OQdrJGlZW1KbHp
	4e4bNLrsTBsSCcEMjp/zDRy594uQ=
X-Google-Smtp-Source: AGHT+IGDSiHlMt9fVcXrNLvzBRQPLbdM9sqdtYobkp2CFW3rMmVo/7fUwe8eK/9AJo62GHDo+m8zp3PDV5H8lXCkkwA=
X-Received: by 2002:a05:6a21:3a94:b0:1b2:1de2:7dfa with SMTP id
 adf61e73a8af0-1b21de27eb4mr16574261637.22.1716955595662; Tue, 28 May 2024
 21:06:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240526182212.544525-1-sesse@google.com> <20240526182212.544525-3-sesse@google.com>
In-Reply-To: <20240526182212.544525-3-sesse@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 28 May 2024 21:06:24 -0700
Message-ID: <CAM9d7cgyBGPc-HCC9nk_xNiVi3LZGM1-dE5OR4FxRvNWoFZFDA@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] perf annotate: LLVM-based disassembler
To: "Steinar H. Gunderson" <sesse@google.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, irogers@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 26, 2024 at 11:22=E2=80=AFAM Steinar H. Gunderson <sesse@google=
.com> wrote:
>
> Support using LLVM as a disassembler method, allowing helperless
> annotation in non-distro builds. (It is also much faster than
> using libbfd or bfd objdump on binaries with a lot of debug
> information.)
>
> This is nearly identical to the output of llvm-objdump; there are
> some very rare whitespace differences, some minor changes to demangling
> (since we use perf's regular demangling and not LLVM's own) and
> the occasional case where llvm-objdump makes a different choice
> when multiple symbols share the same address. It should work across
> all of LLVM's supported architectures, although I've only tested 64-bit
> x86, and finding the right triple from perf's idea of machine
> architecture can sometimes be a bit tricky. Ideally, we should have
> some way of finding the triplet just from the file itself.
>
> Signed-off-by: Steinar H. Gunderson <sesse@google.com>
> ---
>  tools/perf/util/disasm.c           | 195 +++++++++++++++++++++++++++++
>  tools/perf/util/llvm-c-helpers.cpp |  62 +++++++++
>  tools/perf/util/llvm-c-helpers.h   |  11 ++
>  3 files changed, 268 insertions(+)
>
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index c0dbb955e61a..ee7c2365d066 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -43,6 +43,7 @@ static int call__scnprintf(struct ins *ins, char *bf, s=
ize_t size,
>
>  static void ins__sort(struct arch *arch);
>  static int disasm_line__parse(char *line, const char **namep, char **raw=
p);
> +static char *expand_tabs(char *line, char **storage, size_t *storage_len=
);
>
>  static __attribute__((constructor)) void symbol__init_regexpr(void)
>  {
> @@ -1378,7 +1379,9 @@ static int open_capstone_handle(struct annotate_arg=
s *args, bool is_64bit,
>
>         return 0;
>  }
> +#endif
>
> +#if defined(HAVE_LIBCAPSTONE_SUPPORT) || defined(HAVE_LIBLLVM_SUPPORT)
>  struct find_file_offset_data {
>         u64 ip;
>         u64 offset;
> @@ -1442,7 +1445,9 @@ read_symbol(const char *filename, struct map *map, =
struct symbol *sym,
>         free(buf);
>         return NULL;
>  }
> +#endif
>
> +#ifdef HAVE_LIBCAPSTONE_SUPPORT
>  static void print_capstone_detail(cs_insn *insn, char *buf, size_t len,
>                                   struct annotate_args *args, u64 addr)
>  {
> @@ -1606,6 +1611,191 @@ static int symbol__disassemble_capstone(char *fil=
ename, struct symbol *sym,
>  }
>  #endif
>
> +#ifdef HAVE_LIBLLVM_SUPPORT
> +#include <llvm-c/Disassembler.h>
> +#include <llvm-c/Target.h>
> +#include "util/llvm-c-helpers.h"
> +
> +struct symbol_lookup_storage {
> +       u64 branch_addr;
> +       u64 pcrel_load_addr;
> +};
> +
> +/*
> + * Whenever LLVM wants to resolve an address into a symbol, it calls thi=
s
> + * callback. We don't ever actually _return_ anything (in particular, be=
cause
> + * it puts quotation marks around what we return), but we use this as a =
hint
> + * that there is a branch or PC-relative address in the expression that =
we
> + * should add some textual annotation for after the instruction. The cal=
ler
> + * will use this information to add the actual annotation.
> + */
> +static const char *
> +symbol_lookup_callback(void *disinfo, uint64_t value,
> +                      uint64_t *ref_type,
> +                      uint64_t address __maybe_unused,
> +                      const char **ref __maybe_unused)
> +{
> +       struct symbol_lookup_storage *storage =3D
> +               (struct symbol_lookup_storage *)disinfo;

You don't need this in C. :)  Also we usually put a blank line
after declaration (at least, at the beginning).


> +       if (*ref_type =3D=3D LLVMDisassembler_ReferenceType_In_Branch)
> +               storage->branch_addr =3D value;
> +       else if (*ref_type =3D=3D LLVMDisassembler_ReferenceType_In_PCrel=
_Load)
> +               storage->pcrel_load_addr =3D value;
> +       *ref_type =3D LLVMDisassembler_ReferenceType_InOut_None;
> +       return NULL;
> +}
> +
> +static int symbol__disassemble_llvm(char *filename, struct symbol *sym,
> +                                   struct annotate_args *args)
> +{
> +       struct annotation *notes =3D symbol__annotation(sym);
> +       struct map *map =3D args->ms.map;
> +       struct dso *dso =3D map__dso(map);
> +       u64 start =3D map__rip_2objdump(map, sym->start);
> +       u8 *buf;
> +       u64 len;
> +       u64 pc;
> +       bool is_64bit;
> +       char triplet[64];
> +       char disasm_buf[2048];
> +       size_t disasm_len;
> +       struct disasm_line *dl;
> +       LLVMDisasmContextRef disasm =3D NULL;
> +       struct symbol_lookup_storage storage;
> +       char *line_storage =3D NULL;
> +       size_t line_storage_len =3D 0;
> +
> +       if (args->options->objdump_path)
> +               return -1;
> +
> +       LLVMInitializeAllTargetInfos();
> +       LLVMInitializeAllTargetMCs();
> +       LLVMInitializeAllDisassemblers();
> +
> +       buf =3D read_symbol(filename, map, sym, &len, &is_64bit);
> +       if (buf =3D=3D NULL)
> +               return -1;
> +
> +       if (arch__is(args->arch, "x86")) {
> +               if (is_64bit)
> +                       scnprintf(triplet, sizeof(triplet), "x86_64-pc-li=
nux");
> +               else
> +                       scnprintf(triplet, sizeof(triplet), "i686-pc-linu=
x");
> +       } else {
> +               scnprintf(triplet, sizeof(triplet), "%s-linux-gnu",
> +                         args->arch->name);
> +       }
> +
> +       disasm =3D LLVMCreateDisasm(
> +               triplet, &storage, 0, NULL, symbol_lookup_callback);

We put the arguments at the same line and align them.
Please do the same in other places.


> +       if (disasm =3D=3D NULL)
> +               goto err;
> +
> +       if (args->options->disassembler_style &&
> +           !strcmp(args->options->disassembler_style, "intel"))
> +               LLVMSetDisasmOptions(
> +                       disasm, LLVMDisassembler_Option_AsmPrinterVariant=
);
> +
> +       /*
> +        * This needs to be set after AsmPrinterVariant, due to a bug in =
LLVM;
> +        * setting AsmPrinterVariant makes a new instruction printer, mak=
ing it
> +        * forget about the PrintImmHex flag (which is applied before if =
both
> +        * are given to the same call).
> +        */
> +       LLVMSetDisasmOptions(disasm, LLVMDisassembler_Option_PrintImmHex)=
;
> +
> +       /* add the function address and name */
> +       scnprintf(disasm_buf, sizeof(disasm_buf), "%#"PRIx64" <%s>:",
> +                 start, sym->name);
> +
> +       args->offset =3D -1;
> +       args->line =3D disasm_buf;
> +       args->line_nr =3D 0;
> +       args->fileloc =3D NULL;
> +       args->ms.sym =3D sym;
> +
> +       dl =3D disasm_line__new(args);
> +       if (dl =3D=3D NULL)
> +               goto err;
> +
> +       annotation_line__add(&dl->al, &notes->src->source);
> +
> +       pc =3D start;
> +       for (u64 offset =3D 0; offset < len; ) {
> +               unsigned int ins_len;
> +
> +               storage.branch_addr =3D 0;
> +               storage.pcrel_load_addr =3D 0;
> +
> +               ins_len =3D LLVMDisasmInstruction(
> +                       disasm, buf + offset, len - offset, pc,
> +                       disasm_buf, sizeof(disasm_buf));
> +               if (ins_len =3D=3D 0)
> +                       goto err;
> +               disasm_len =3D strlen(disasm_buf);
> +
> +               if (storage.branch_addr !=3D 0) {
> +                       char *name =3D llvm_name_for_code(
> +                               dso, filename, storage.branch_addr);
> +                       if (name !=3D NULL) {
> +                               disasm_len +=3D scnprintf(
> +                                       disasm_buf + disasm_len,
> +                                       sizeof(disasm_buf) - disasm_len,
> +                                       " <%s>", name);
> +                               free(name);
> +                       }
> +               }
> +               if (storage.pcrel_load_addr !=3D 0) {
> +                       char *name =3D llvm_name_for_data(
> +                               dso, filename, storage.pcrel_load_addr);
> +                       disasm_len +=3D scnprintf(disasm_buf + disasm_len=
,
> +                                               sizeof(disasm_buf) - disa=
sm_len,
> +                                               "  # %#"PRIx64,
> +                                               storage.pcrel_load_addr);
> +                       if (name) {
> +                               disasm_len +=3D scnprintf(
> +                                       disasm_buf + disasm_len,
> +                                       sizeof(disasm_buf) - disasm_len,
> +                                       " <%s>", name);
> +                               free(name);
> +                       }
> +               }
> +
> +               args->offset =3D offset;
> +               args->line =3D expand_tabs(
> +                       disasm_buf, &line_storage, &line_storage_len);
> +               args->line_nr =3D 0;
> +               args->fileloc =3D NULL;
> +               args->ms.sym =3D sym;
> +
> +               llvm_addr2line(filename, pc, &args->fileloc,
> +                              (unsigned int *)&args->line_nr, false, NUL=
L);
> +
> +               dl =3D disasm_line__new(args);
> +               if (dl =3D=3D NULL)
> +                       goto err;
> +
> +               annotation_line__add(&dl->al, &notes->src->source);
> +
> +               free(args->fileloc);
> +               pc +=3D ins_len;
> +               offset +=3D ins_len;
> +       }
> +
> +       LLVMDisasmDispose(disasm);
> +       free(buf);
> +       free(line_storage);
> +       return 0;

Often we just set a different return value here and share the
error handling logic at the end.

Thanks,
Namhyung


> +
> +err:
> +       LLVMDisasmDispose(disasm);
> +       free(buf);
> +       free(line_storage);
> +       return -1;
> +}
> +#endif
> +
> +
>  /*
>   * Possibly create a new version of line with tabs expanded. Returns the
>   * existing or new line, storage is updated if a new line is allocated. =
If
> @@ -1730,6 +1920,11 @@ int symbol__disassemble(struct symbol *sym, struct=
 annotate_args *args)
>                 strcpy(symfs_filename, tmp);
>         }
>
> +#ifdef HAVE_LIBLLVM_SUPPORT
> +       err =3D symbol__disassemble_llvm(symfs_filename, sym, args);
> +       if (err =3D=3D 0)
> +               goto out_remove_tmp;
> +#endif
>  #ifdef HAVE_LIBCAPSTONE_SUPPORT
>         err =3D symbol__disassemble_capstone(symfs_filename, sym, args);
>         if (err =3D=3D 0)
> diff --git a/tools/perf/util/llvm-c-helpers.cpp b/tools/perf/util/llvm-c-=
helpers.cpp
> index 3cc967ec6f28..4070e2d5682f 100644
> --- a/tools/perf/util/llvm-c-helpers.cpp
> +++ b/tools/perf/util/llvm-c-helpers.cpp
> @@ -8,6 +8,7 @@
>  #pragma GCC diagnostic push
>  #pragma GCC diagnostic ignored "-Wunused-parameter"  /* Needed for LLVM =
<=3D 15 */
>  #include <llvm/DebugInfo/Symbolize/Symbolize.h>
> +#include <llvm/Support/TargetSelect.h>
>  #pragma GCC diagnostic pop
>
>  #include <stdio.h>
> @@ -19,6 +20,9 @@ extern "C" {
>  #include "symbol_conf.h"
>  #include "llvm-c-helpers.h"
>
> +extern "C"
> +char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_na=
me);
> +
>  using namespace llvm;
>  using llvm::symbolize::LLVMSymbolizer;
>
> @@ -132,3 +136,61 @@ int llvm_addr2line(const char *dso_name, u64 addr,
>                 return extract_file_and_line(*res_or_err, file, line);
>         }
>  }
> +
> +static char *
> +make_symbol_relative_string(struct dso *dso, const char *sym_name,
> +                           u64 addr, u64 base_addr)
> +{
> +       if (!strcmp(sym_name, "<invalid>"))
> +               return NULL;
> +
> +       char *demangled =3D dso__demangle_sym(dso, 0, sym_name);
> +       if (base_addr && base_addr !=3D addr) {
> +               char buf[256];
> +               snprintf(buf, sizeof(buf), "%s+0x%lx",
> +                        demangled ? demangled : sym_name, addr - base_ad=
dr);
> +               free(demangled);
> +               return strdup(buf);
> +       } else {
> +               if (demangled)
> +                       return demangled;
> +               else
> +                       return strdup(sym_name);
> +       }
> +}
> +
> +extern "C"
> +char *llvm_name_for_code(struct dso *dso, const char *dso_name, u64 addr=
)
> +{
> +       LLVMSymbolizer *symbolizer =3D get_symbolizer();
> +       object::SectionedAddress sectioned_addr =3D {
> +               addr,
> +               object::SectionedAddress::UndefSection
> +       };
> +       Expected<DILineInfo> res_or_err =3D
> +               symbolizer->symbolizeCode(dso_name, sectioned_addr);
> +       if (!res_or_err) {
> +               return NULL;
> +       }
> +       return make_symbol_relative_string(
> +               dso, res_or_err->FunctionName.c_str(),
> +               addr, res_or_err->StartAddress ? *res_or_err->StartAddres=
s : 0);
> +}
> +
> +extern "C"
> +char *llvm_name_for_data(struct dso *dso, const char *dso_name, u64 addr=
)
> +{
> +       LLVMSymbolizer *symbolizer =3D get_symbolizer();
> +       object::SectionedAddress sectioned_addr =3D {
> +               addr,
> +               object::SectionedAddress::UndefSection
> +       };
> +       Expected<DIGlobal> res_or_err =3D
> +               symbolizer->symbolizeData(dso_name, sectioned_addr);
> +       if (!res_or_err) {
> +               return NULL;
> +       }
> +       return make_symbol_relative_string(
> +               dso, res_or_err->Name.c_str(),
> +               addr, res_or_err->Start);
> +}
> diff --git a/tools/perf/util/llvm-c-helpers.h b/tools/perf/util/llvm-c-he=
lpers.h
> index 19332dd98e14..d2b99637a28a 100644
> --- a/tools/perf/util/llvm-c-helpers.h
> +++ b/tools/perf/util/llvm-c-helpers.h
> @@ -13,6 +13,8 @@
>  extern "C" {
>  #endif
>
> +struct dso;
> +
>  struct llvm_a2l_frame {
>    char* filename;
>    char* funcname;
> @@ -42,6 +44,15 @@ int llvm_addr2line(const char* dso_name,
>                     bool unwind_inlines,
>                     struct llvm_a2l_frame** inline_frames);
>
> +/*
> + * Simple symbolizers for addresses; will convert something like
> + * 0x12345 to "func+0x123". Will return NULL if no symbol was found.
> + *
> + * The returned value must be freed by the caller, with free().
> + */
> +char *llvm_name_for_code(struct dso *dso, const char *dso_name, u64 addr=
);
> +char *llvm_name_for_data(struct dso *dso, const char *dso_name, u64 addr=
);
> +
>  #ifdef __cplusplus
>  }
>  #endif
> --
> 2.45.1
>
>
