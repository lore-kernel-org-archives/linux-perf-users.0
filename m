Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465A56AB8;
	Wed, 29 May 2024 04:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716955912; cv=none; b=GIZqoK/2aNI9S2pHhWaQoF5RiHpHoE/MN5p30bCA0FJlVRkdbdP+TREZWyNTU+VwD/GZcE6y8ILaQAkdiDauI+SthpYWxJLVkIpZOkh7+/XLNBuhQaQqFzL+XDjEsXdCwoy5tTjVLYobtjLcQ6ehDNB4AxBlSZeC7wxvB99U794=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716955912; c=relaxed/simple;
	bh=iSc8+vk1DU7CPhWjzAlHmVqHknKMgB6CZ9SbfPIwQSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KpKNBnmCYxMGwe14Lk1IXZSbk98nsvJkH7ifWqsRuAdlSbdQVax0OnfNAUTh3T7R02m9xfzvs9r7CCU8hjhBciv4dzMzZYbCKiWHTwf5Kc77ycHHSNltrJ8vne8ywjVC9P6NrsiUytauwY5EM/gttBvf86nYpkYtYLSB0REH5os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6fcbd812b33so1418318b3a.3;
        Tue, 28 May 2024 21:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716955909; x=1717560709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLmGxhXpkiks8NJ9+hFXWHSsOCY0zKQLp/YEenzXNX4=;
        b=m+yRdbKsE6fpxJ5Fl0PgPQ4xo4h7Xc5mWjV9bmBPMfZtxfmj4ER087piWdCNdFmJCt
         onsReWiMmSaLYSkTU0zEMfeN0cTQ8LRvCmEyKPKgLiJflRGURZ6nW3q8v9t6Pv4Q75zb
         WYhqnt4MUBsesY1M7popWQWm7KM1Nsj08aAoZr+51rKB9HiJCF40W+OlBWVJ+LCxpq5S
         CCpcjwpafKuvcEsuntDpmiQh/ybx9E38LhMkt+6JX3+vagMxV5v+68+U44PMlxIo5lNk
         Z3rszd5oe+daEXJNlAqBOJ6F+l9kt2dSjS6XMlc9KNLBgwKMznSKbai8XWzfV8d0Ge7d
         4x0w==
X-Forwarded-Encrypted: i=1; AJvYcCXf6k+0ytAlKs3ddQYI+QrRav+7gdfeUAHVYkUmxzjeJ8sYPtaL+y7x15883zf+yyWA4AFc43CaRCVnBd+bDSedtpr9AeAw/zjKB8X0dIUv6CUxsUcRQrfPKPrBoDEcfxXeKLCaRAKVLh6yhHK+Ig==
X-Gm-Message-State: AOJu0Yz/b6BhIxEKUs8OBdxUb+4HUMS4xi+gEztDq4IfZ9CkYAjsBaOk
	ux8Fi7M/P3eiYdJ67A1WLEo/aAmJ15SQxLyYfqpKmETRiccT6w8zGGtSFoheqYZc0IwqIR6LpCX
	s4gTnYpwqRUSG4kGtZ5n2L1hFwPI=
X-Google-Smtp-Source: AGHT+IGcSzpcTcf2054LOzasnz8JT41tf4CoL7KXt/oG0dkk785ZH/9m+wRlS+oatMjZvBo9Bc3QdSeqSMQsU6OpQWA=
X-Received: by 2002:a05:6a21:9207:b0:1af:952f:f6fb with SMTP id
 adf61e73a8af0-1b212cc507emr16966789637.3.1716955909302; Tue, 28 May 2024
 21:11:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240526182212.544525-1-sesse@google.com> <20240526182212.544525-4-sesse@google.com>
In-Reply-To: <20240526182212.544525-4-sesse@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 28 May 2024 21:11:38 -0700
Message-ID: <CAM9d7ciYykAsZVdMXACPu8mynCKcCRpVHzGC4rZUBrgi6BDfEA@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] perf report: LLVM-based symbol listing
To: "Steinar H. Gunderson" <sesse@google.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, irogers@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 26, 2024 at 11:23=E2=80=AFAM Steinar H. Gunderson <sesse@google=
.com> wrote:
>
> Similar to the previous LLVM patches, this allows symbol enumeration
> using LLVM instead of libbfd or libelf. This allows distro builds to
> reliably enumerate symbols in e.g. PE binaries as profiled with WINE.
>
> A lot of the logic for e.g. length detection has been carried over
> from the libbfd code.
>
> Signed-off-by: Steinar H. Gunderson <sesse@google.com>
> ---
>  tools/perf/util/llvm-c-helpers.cpp | 124 +++++++++++++++++++++++++++++
>  tools/perf/util/llvm-c-helpers.h   |  49 ++++++++++++
>  tools/perf/util/symbol.c           |  54 ++++++++++++-
>  tools/perf/util/symbol.h           |   3 +
>  4 files changed, 228 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/llvm-c-helpers.cpp b/tools/perf/util/llvm-c-=
helpers.cpp
> index 4070e2d5682f..87caf98cc8f6 100644
> --- a/tools/perf/util/llvm-c-helpers.cpp
> +++ b/tools/perf/util/llvm-c-helpers.cpp
> @@ -9,6 +9,7 @@
>  #pragma GCC diagnostic ignored "-Wunused-parameter"  /* Needed for LLVM =
<=3D 15 */
>  #include <llvm/DebugInfo/Symbolize/Symbolize.h>
>  #include <llvm/Support/TargetSelect.h>
> +#include <llvm/Object/Binary.h>
>  #pragma GCC diagnostic pop
>
>  #include <stdio.h>
> @@ -17,6 +18,8 @@
>  extern "C" {
>  #include <linux/zalloc.h>
>  }
> +#include <vector>
> +#include <algorithm>
>  #include "symbol_conf.h"
>  #include "llvm-c-helpers.h"
>
> @@ -24,6 +27,7 @@ extern "C"
>  char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_na=
me);
>
>  using namespace llvm;
> +using namespace llvm::object;
>  using llvm::symbolize::LLVMSymbolizer;
>
>  /*
> @@ -194,3 +198,123 @@ char *llvm_name_for_data(struct dso *dso, const cha=
r *dso_name, u64 addr)
>                 dso, res_or_err->Name.c_str(),
>                 addr, res_or_err->Start);
>  }
> +
> +int llvm_load_symbols(const char *debugfile, struct llvm_symbol_list *sy=
mbols)
> +{
> +       /* NOTE: This nominally does an mmap, despite the scary name. */
> +       ErrorOr<std::unique_ptr<MemoryBuffer>> mem_buf_or_err =3D
> +               MemoryBuffer::getFile(debugfile);
> +       if (mem_buf_or_err.getError())
> +               return -1;
> +
> +       Expected<std::unique_ptr<Binary>> binary_or_err(
> +               createBinary(mem_buf_or_err.get()->getMemBufferRef(), nul=
lptr));
> +       if (!binary_or_err)
> +               return -1;
> +
> +       /* Find the .text section. */
> +       SectionRef text_section;
> +       uint64_t text_filepos, image_base;
> +       for (SectionRef section :
> +            cast<ObjectFile>(*binary_or_err.get()).sections()) {
> +               Expected<StringRef> name =3D section.getName();
> +               if (name && *name =3D=3D ".text") {
> +                       text_section =3D section;
> +
> +                       /*
> +                        * If we don't find an image base below, we infer=
 the
> +                        * image base * from the address and file offset =
of the
> +                        * .text section.
> +                        */
> +                       text_filepos =3D reinterpret_cast<const char *>(
> +                               text_section.getContents()->bytes_begin()=
) -
> +                               mem_buf_or_err.get()->getBufferStart();
> +                       image_base =3D text_section.getAddress() - text_f=
ilepos;
> +                       break;
> +               }
> +       }
> +       if (text_section =3D=3D SectionRef())
> +               /* No .text section, so no symbols (but also not a failur=
e). */
> +               return 0;
> +
> +       /*
> +        * See if we can find an explicit image base pseudosymbol. If so,=
 get
> +        * the image base directly from it, then infer the file position =
of
> +        * .text from that (i.e., the opposite inference of the fallback =
above).
> +        */

If it's PE-specific, can we skip this based on the target type or
something?


> +       for (SymbolRef symbol :
> +            cast<ObjectFile>(*binary_or_err.get()).symbols())
> +               if (symbol.getName() &&
> +                   symbol.getAddress() &&
> +                   (*symbol.getName() =3D=3D "__ImageBase" ||
> +                    *symbol.getName() =3D=3D "__image_base__")) {
> +                       image_base =3D *symbol.getAddress();
> +                       if (image_base < 0x100000000ULL)
> +                               /*
> +                                * PE symbols can only have 4 bytes, so u=
se
> +                                * .text high bits (if any).
> +                                */
> +                               image_base |=3D text_section.getAddress()=
 &
> +                                       ~0xFFFFFFFFULL;
> +                       text_filepos =3D text_section.getAddress() - imag=
e_base;
> +                       break;
> +               }
> +
> +       symbols->image_base =3D image_base;
> +       symbols->text_end =3D text_filepos + text_section.getSize();
> +
> +       /* Collect all valid symbols. */
> +       std::vector<SymbolRef> all_symbols;
> +       for (SymbolRef symbol :
> +            cast<ObjectFile>(*binary_or_err.get()).symbols())
> +               if (symbol.getName() && symbol.getFlags() &&
> +                   symbol.getAddress() && symbol.getSection())
> +                       all_symbols.push_back(symbol);
> +       symbols->num_symbols =3D all_symbols.size();
> +       symbols->symbols =3D (struct llvm_symbol *)calloc(
> +               all_symbols.size(), sizeof(struct llvm_symbol));
> +       if (symbols->symbols =3D=3D nullptr)
> +               return -1;

I'm not sure if it's compatible with what we do in the
dso__load_sym_internal().  Probably ARM and PPC folks
should check if it works well.

Thanks,
Namhyung


> +
> +       /*
> +        * Symbols don't normally come with lengths, so we'll infer them
> +        * from what comes after the symbol address-wise. There is some
> +        * extra logic around zero-length symbols and deduplication,
> +        * which the caller will do for us (it's shared with other backen=
ds).
> +        */
> +       std::sort(all_symbols.begin(), all_symbols.end(),
> +                 [](const SymbolRef &a, const SymbolRef &b) {
> +                         if (*a.getAddress() !=3D *b.getAddress())
> +                                 return *a.getAddress() < *b.getAddress(=
);
> +                         return *a.getName() < *b.getName();
> +                 });
> +       for (size_t i =3D 0; i < all_symbols.size(); ++i) {
> +               const SymbolRef &sym =3D all_symbols[i];
> +               llvm_symbol &out_sym =3D symbols->symbols[i];
> +               out_sym.start =3D *sym.getAddress() - image_base;
> +               out_sym.name =3D (char *)calloc(1, sym.getName()->size() =
+ 1);
> +               if (out_sym.name =3D=3D nullptr) {
> +                       for (size_t i =3D 0; i < all_symbols.size(); ++i)=
 {
> +                               zfree(&symbols->symbols[i].name);
> +                       }
> +                       zfree(&symbols->symbols);
> +                       return -1;
> +               }
> +               memcpy(out_sym.name, sym.getName()->bytes_begin(),
> +                      sym.getName()->size());
> +               out_sym.global =3D *sym.getFlags() & SymbolRef::SF_Global=
;
> +               out_sym.weak =3D *sym.getFlags() & SymbolRef::SF_Weak;
> +
> +               SectionRef section =3D **sym.getSection();
> +               uint64_t next_addr;
> +               if (i + 1 < all_symbols.size() &&
> +                   section =3D=3D **all_symbols[i + 1].getSection())
> +                       next_addr =3D *all_symbols[i + 1].getAddress();
> +               else
> +                       next_addr =3D section.getAddress() + section.getS=
ize();
> +
> +               out_sym.len =3D next_addr - *sym.getAddress();
> +       }
> +
> +       return 1;
> +}
> diff --git a/tools/perf/util/llvm-c-helpers.h b/tools/perf/util/llvm-c-he=
lpers.h
> index d2b99637a28a..1abbc9ef3dab 100644
> --- a/tools/perf/util/llvm-c-helpers.h
> +++ b/tools/perf/util/llvm-c-helpers.h
> @@ -8,6 +8,7 @@
>   */
>
>  #include <linux/compiler.h>
> +#include <stddef.h>
>
>  #ifdef __cplusplus
>  extern "C" {
> @@ -53,6 +54,54 @@ int llvm_addr2line(const char* dso_name,
>  char *llvm_name_for_code(struct dso *dso, const char *dso_name, u64 addr=
);
>  char *llvm_name_for_data(struct dso *dso, const char *dso_name, u64 addr=
);
>
> +struct llvm_symbol {
> +       u64 start, len;
> +       bool weak, global;
> +
> +       /* Must be freed by the caller. */
> +       char *name;
> +};
> +
> +struct llvm_symbol_list {
> +       /*
> +        * The address this dso is loaded at in memory; adding this to
> +        * the file position of any symbol will give the address that
> +        * symbol is loaded at.
> +        */
> +       u64 image_base;
> +
> +       /*
> +        * The byte offset of the end of the .text segment (one-past-the-=
end)
> +        * in the file.
> +        */
> +       u64 text_end;
> +
> +       /*
> +        * The actual symbols. Must be freed by the caller, with free().
> +        * The string inside each llvm_symbol must also be freed.
> +        */
> +       size_t num_symbols;
> +       struct llvm_symbol *symbols;
> +};
> +
> +/*
> + * Get a list of all symbols in the given file using LLVM. Similarly to
> + * addr2line(), we need to implement this using a helper structure;
> + * LLVM actually has a C API for this, but we can't use it (it doesn't
> + * have an equivalent of getFlags()). So we do the meat of the LLVM-faci=
ng
> + * logic here and let the caller make perf symbols out of it.
> + *
> + * Possible return values and their meaning:
> + *
> + * -1: An error occurred.
> + *  0: The file loaded fine, but there were no .text section.
> + *  1: The file loaded successfully.
> + *
> + * For -1 and 0, "symbols" does not contain any meaningful information,
> + * and nothing needs to be freed.
> + */
> +int llvm_load_symbols(const char *debugfile, struct llvm_symbol_list *sy=
mbols);
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 9e5940b5bc59..69b8c0a280c7 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -22,6 +22,7 @@
>  #include "util.h" // lsdir()
>  #include "debug.h"
>  #include "event.h"
> +#include "llvm-c-helpers.h"
>  #include "machine.h"
>  #include "map.h"
>  #include "symbol.h"
> @@ -1566,6 +1567,50 @@ static int dso__load_perf_map(const char *map_path=
, struct dso *dso)
>         return -1;
>  }
>
> +#ifdef HAVE_LIBLLVM_SUPPORT
> +int dso__load_llvm_symbols(struct dso *dso, const char *debugfile)
> +{
> +       struct llvm_symbol_list symbols;
> +       struct symbol *symbol;
> +       int err =3D llvm_load_symbols(debugfile, &symbols);
> +       int ret =3D -1;
> +
> +       if (err =3D=3D -1)
> +               return -1;
> +       else if (err =3D=3D 0)
> +               return 0;
> +
> +       for (size_t i =3D 0; i < symbols.num_symbols; ++i) {
> +               const struct llvm_symbol *sym =3D &symbols.symbols[i];
> +               int elf_binding;
> +
> +               if (sym->weak)
> +                       elf_binding =3D STB_WEAK;
> +               else if (sym->global)
> +                       elf_binding =3D STB_GLOBAL;
> +               else
> +                       elf_binding =3D STB_LOCAL;
> +               symbol =3D symbol__new(sym->start, sym->len, elf_binding,=
 STT_FUNC,
> +                                    sym->name);
> +               if (!symbol)
> +                       goto out_free;
> +
> +               symbols__insert(dso__symbols(dso), symbol);
> +       }
> +
> +       symbols__fixup_end(dso__symbols(dso), false);
> +       symbols__fixup_duplicate(dso__symbols(dso));
> +       dso__set_adjust_symbols(dso, true);
> +       ret =3D 0;
> +
> +out_free:
> +       for (size_t i =3D 0; i < symbols.num_symbols; ++i)
> +               zfree(&symbols.symbols[i].name);
> +       zfree(&symbols.symbols);
> +       return ret;
> +}
> +#endif
> +
>  #ifdef HAVE_LIBBFD_SUPPORT
>  #define PACKAGE 'perf'
>  #include <bfd.h>
> @@ -1871,6 +1916,7 @@ int dso__load(struct dso *dso, struct map *map)
>                 bool next_slot =3D false;
>                 bool is_reg;
>                 bool nsexit;
> +               int llvmrc =3D -1;
>                 int bfdrc =3D -1;
>                 int sirc =3D -1;
>
> @@ -1899,11 +1945,15 @@ int dso__load(struct dso *dso, struct map *map)
>                         }
>                 }
>
> -#ifdef HAVE_LIBBFD_SUPPORT
> +#ifdef HAVE_LIBLLVM_SUPPORT
>                 if (is_reg)
> +                       llvmrc =3D dso__load_llvm_symbols(dso, name);
> +#endif
> +#ifdef HAVE_LIBBFD_SUPPORT
> +               if (is_reg && llvmrc < 0)
>                         bfdrc =3D dso__load_bfd_symbols(dso, name);
>  #endif
> -               if (is_reg && bfdrc < 0)
> +               if (is_reg && llvmrc < 0 && bfdrc < 0)
>                         sirc =3D symsrc__init(ss, dso, name, symtab_type)=
;
>
>                 if (nsexit)
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index 3fb5d146d9b1..01256c41467a 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -174,6 +174,9 @@ int symbol__config_symfs(const struct option *opt __m=
aybe_unused,
>
>  struct symsrc;
>
> +#ifdef HAVE_LIBLLVM_SUPPORT
> +int dso__load_llvm_symbols(struct dso *dso, const char *debugfile);
> +#endif
>  #ifdef HAVE_LIBBFD_SUPPORT
>  int dso__load_bfd_symbols(struct dso *dso, const char *debugfile);
>  #endif
> --
> 2.45.1
>
>
