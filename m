Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793375771;
	b=ZlZ4L3QHZsF5PcsFMIh04AfTt9ZEdoKFzVthwLBXjndIK2UwFcZ1r+UCbqXrw9WI/mGY
	 Iti00wm4Kizz53DpZIY/3AekMhJBi7DedZjeATY7egrTdF6kFV8Fa/9vxqf8cmnqtauKg
	 i2QkSJz77sc0a7NC3J9yRXdr4PqE0NnFa47k3ZRQsdgie7Rs0btUjyK6y0ULSh0TkGkfQ
	 8e36pUl6B2csMJW9jElxPUj0b4Viu5JF+tR7aJoJOqHTqK4oX48wif84MDgansL5yZZlR
	 PYu6Uv8gdf5zNXFPY0mPe75/wgGYay7v22ltzAnIYb/miPnmm4bce3atvJJ0sa75IKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793375771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=gOvmtnZ3CG9aJvTYXKivi0NH1SbZPoxAQe1MLnOcMA0=;
	b=aGKezEq1icG54mNUP8B1TBXmej4pQk/AJwSfipWNJ0ztkEJTh7CIt1bmRLjZJ/7NOYxn
	 re7KiqR76conuN6YqF4/eDIfzagWk4PrrEZpUHfTFqYr4gYr5Sghl+7v9JqGfl6t9D2IN
	 P76eV3UWvDAQ4n5aQAYaJhQV5RBZSAoGv2m/oErxB5Tv84NEGrPPJPL5dcsmCUpnphGvy
	 rR5stWM6by0QE0Fmi0bsS9FHpMq06n7muTKTC6ZHYL37efd/O5H9OuBiW4zmBsiXRPcZG
	 cgRFlpUsuUqFr9/SQxTDwgwpq8crnaNIEPpIuX7McsD10sRtF7dSfqt7x4C6wmCaj+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="cAdFhe/Y";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31901606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 15:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31901606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cAdFhe/Y
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5383c97c8cfso300341cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 08:56:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793375769; cv=none;
        d=google.com; s=arc-20260327;
        b=ay92odWKvPSQzQnJegIX+uAF3+q3DUkaL8HqRyjFG1azNHykPPD1UsFimLNC8xH/DK
         j4tGsU4TafhHHdfc3hibd3L9kQNbcNWZ6+4gJNxEz8eg5bhV6yv/8ECwDC4zdvReRp70
         Tm0i2vD3WsUbjMrn2MGOLnbKGIrp6QcwwZH1TLVJNdKIBgKWSNT9I/V6vsplm7bWWx8B
         q15urbfVPW4WsnYavSIDeJolh6EBcv1CUiBIXrxajTQYFsQdvrLVZMzB4beMmOw5M8iT
         X4ZmgopEBJHfmTTYrmWNH/aP3CtWEd2YPbog19T0m11/bzyQuLNAgUQwIY1QzbjizSUH
         wQQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gOvmtnZ3CG9aJvTYXKivi0NH1SbZPoxAQe1MLnOcMA0=;
        fh=vu9pXuUkovTd3bfK5ww2bmPC7aoPeJxN+3HCSQ/pkGQ=;
        b=i2MAIpLfocGetaasnPWgRy2r4BvdSRE571uq20DuMZ+8nG/qFXNzFiHDlBQD4awrNk
         aqZAs89zTFWgZeKDZQ1Cc0i5v/nIcaBOO6XsGQobES1M0BsCJj+sM4OxKO83r5fGShdq
         ZldMQcIA2ILFNTgm/QmDa26uwQHcfmi2c/oj5kltSq0ICU2iFzk3Kr2KQLRqJMqhMVhO
         WRudSwM34/gbuTnTw5FukwGuW5PlQP/IlW5TGMak4BkdVTP/fVQcfrht9ZEbljTQF7t6
         oZRI6n12Rr5Emdhgh8lnvyUHlwO4BEE1bwjPlilzbS9zfHMntCNCQvbrDGqsoOztnKfv
         MUdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793375769; x=1793980569; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gOvmtnZ3CG9aJvTYXKivi0NH1SbZPoxAQe1MLnOcMA0=;
        b=cAdFhe/Yc3i0tFrIzjaTd4iQNNB8juR2fQbn9wUntjgUl0mKSrAqUtR9lXa+AQb+es
         mVR+X3oWa78oYa2I7h+Td3JCjU33bGKvMt75TQXilJUv2H2pAlaBmG5JoUV4giZ20Z4E
         elFF4hOJRIpJbIv07rjCWn1hCwoHsbBJZMec24Eo5GJkRZqHYiE3HATeqHdPTzKF95wc
         t93oBT5BztpkWqr6POcJhVYpVGzs5BXBhKclufRMTZ/LIb6Boad16O58lG+K0TVEn4I6
         NS+gfPwCOqnGNZ/nKI8QmTljfIGekDqdVG7m8O2s7cmUBmwA3n5J747TItcjlDgd8BRN
         2wvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793375769; x=1793980569;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gOvmtnZ3CG9aJvTYXKivi0NH1SbZPoxAQe1MLnOcMA0=;
        b=bMns1znI0Biptete8rpEkhNWwwCXPq4RVTXO181VNz8+tGPPhi9Rf23hMU6j4UAM4u
         QXdWHaL6HQXIMFyc24RxCvqPhNzCMIl4/8AIZ24yfR/amhZ5KprMS+mgAVqe6xGk6ARO
         o66r5bGESsXVjruad9ruwjuLWZam/22Z2c+h+Was0fchqpG4hpe30EZmtQUclQ3oZhUI
         0GhbQY3UbuKDKVoiLcZIY1K1l9jUhMdt7HCggqhOxHMMa3UK8Y8TeP2GIjhqBS5SmvML
         3y2pMMmeahN/gil55qVTadX9hm3TOXLuQxZgv6fOLRPqbCXcKg95QUyhpEa1aI9e+pMN
         WSww==
X-Forwarded-Encrypted: i=1; AKwUvBzh/xQYFJ7UqVVXa2M/7baqe5N2ZarmE8CflF4pF5Ok7qHfi/GEvvfpaHV5EnDbeMl0tbJ+qAu/Q3j/wrZe3Smv@vger.kernel.org
X-Gm-Message-State: AFq9FYL6SFZBTHkWcr6vGqB3NdI+1+X202T6H9sPH7vtl/vQo6ZJJz/z
	OhHwXRsd7ZyiFBlY2QQGS9CB+7SmyYNVrQKB5dCn4vkmIhKRLCS0FD93szQ/3q13iS6YPIdFyo0
	8AC/fS7jaqqDTRuen+9G+b583Iu+7o6EjQDBIymJD
X-Gm-Gg: AYBFou0AveAoBz2sWXz+r6jugy+SIYnP6aX11Mjy1Uu/fmf3eYrLpLyzqCKTNUOfY+T
	uuaqosaIujpj4lOJCOI2DFQilriMgp8ZhMh1XRwZ7LMUthLg6xzrLFYfc05c3H8XHPGMec5LSM2
	febDxTpFTl/iLhDJsqsrostIIJm5urzNEHLV1EsGWnT6MerQ1OnQ+UvVjMbjv3taEQ1xq8LzZWI
	vuA1OxzigWGor8E9c4hNFAylAJMRtrCxM6miv5gXBoLYnk302QurR622amDmhuASX3+Q61Idg7y
	2/MpuX2OaD+0ISjRSv4ejZv1ue38+W3R/cHaqAeBad4DJ5e+YoSY1GxUFXuJvBs2hmS/PZ/x6SH
	SHeVE2Z4SyMxRf/rZJhanur3m9JoTacsXPILCiBbgppJzBv7evkPrPdNGlSZPOxRwgYSaOgPWvT
	5vDH1kqkfj6uzb
X-Received: by 2002:a05:622a:8849:b0:532:9220:a9ae with SMTP id
 d75a77b69052e-5412eff03fbmr47745381cf.6.1793375767948; Fri, 30 Oct 2026
 08:56:07 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028-perf-symbol-memory-send-v6-0-7e90415f0101@uber.com> <20261028-perf-symbol-memory-send-v6-4-7e90415f0101@uber.com>
In-Reply-To: <20261028-perf-symbol-memory-send-v6-4-7e90415f0101@uber.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 30 Oct 2026 08:55:55 -0700
X-Gm-Features: AclHuK909oVujaP1s-TkaXQdgKqgRQbMbDNZPjKHtZtruUCty5D4DraepuweAIo
Message-ID: <CAP-5=fU9Du9cCge2aTm10ejtwBKX1THQpm=h7EMR=WVQLww6DA@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] perf script: Add --lazy-load-symbols to load
 symbol names lazily
To: haghdoost@uber.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andriin@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 4:42=E2=80=AFPM Alireza Haghdoost via B4 Relay
<devnull+haghdoost.uber.com@kernel.org> wrote:
>
> From: Alireza Haghdoost <haghdoost@uber.com>
>
> This patch adds the --lazy-load-symbols option to perf script. With this
> option, perf reads the name of a userspace ELF symbol only when a lookup
> returns the symbol. Eager loading remains the default.
>
> perf script loads the ELF symbol table of every DSO that appears in a
> sample and keeps each symbol, with its demangled name, until exit. Most
> of those symbols are never sampled, and their names take most of the
> memory. On a large profile this makes symbol loading the main memory
> cost of perf script, and in a memory-constrained cgroup an OOM kill.
>
> With the option, the loader still creates every symbol, so end fixup,
> duplicate selection, PLT synthesis and IFUNC marking work as before. But
> it keeps the file offset of each name instead of copying and demangling
> the name.
>
> The name pointer and the offset share a union in struct symbol, and
> SYMBOL_FLAG_LAZY_NAME says which one it holds. The dso__find_symbol*()
> functions, dso__first_symbol() and dso__last_symbol() load the name of
> the symbol they return, and code that walks the symbols of a DSO gets
> them with dso__named_symbols(), which loads every name. So does
> dso__sort_by_name() before it builds the name-sorted array. A symbol
> whose name cannot be read is named "[unknown]" instead of being deleted,
> since address lookups search the symbol tree without the DSO lock. Addres=
s
> lookups return NULL for it, so perf script prints it as an address
> without a symbol.
>
> During loading, perf reads only the names that it needs:
>
> - the names of aliases that duplicate selection can tell apart only by
>   name,
> - the names of IFUNC symbols, which PLT synthesis uses to name the
>   IRELATIVE slots.
>
> The loader also skips a .dynsym entry that copies a lazy .symtab symbol.
> Duplicate selection would drop the entry, but only after it reads both
> names, and most exported symbols are such copies.
>
> Other names are read with pread() from the file that dso__get_filename()
> returns for dso__symtab_type(). The file is open only while perf reads
> the names, so no descriptor stays open per DSO.
>
> The kernel, modules, PPC64 .opd and .gnu_debugdata, whose symbol table
> is a temporary file, still load names eagerly.
>
> On a perf script run over a 45,073-sample callchain profile of a large
> C++ service, where eager loading creates about 1M symbols, lazy loading
> reduces max RSS from 341 MiB to 154 MiB and time from 3.2 to 1.5
> seconds, with identical output.
>
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>
> ---
>  tools/perf/Documentation/perf-script.txt |   7 +
>  tools/perf/builtin-script.c              |   2 +
>  tools/perf/ui/browsers/map.c             |   2 +-
>  tools/perf/util/dso.c                    |   2 +-
>  tools/perf/util/dso.h                    |   3 +-
>  tools/perf/util/symbol-elf.c             | 251 +++++++++++++++++++++++++=
++++--
>  tools/perf/util/symbol-minimal.c         |   6 +
>  tools/perf/util/symbol.c                 | 113 +++++++++++++-
>  tools/perf/util/symbol.h                 |  29 +++-
>  tools/perf/util/symbol_conf.h            |   1 +
>  10 files changed, 393 insertions(+), 23 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Docume=
ntation/perf-script.txt
> index f0228e784ced..57b3533e6c2a 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -343,6 +343,13 @@ include::itrace.txt[]
>
>          Default: 127
>
> +--lazy-load-symbols::
> +       Read and demangle userspace ELF symbol names only when perf needs
> +       them. By default, perf reads every symbol name from each binary
> +       referenced by a sample. This option reduces memory use and usuall=
y
> +       improves performance when samples reference only a small fraction
> +       of a large binary's symbols.
> +

Won't it also improve performance if you say link against a library
but then only use a portion of that library's contents? I'm thinking
this option should really be the default, requiring people to opt out.
I may even be tempted to hide this flag so that we have the option
later of just always using lazy loading. Since the flag isn't a huge
cost in the code, and non-lazy loading is needed in other contexts,
perhaps we can make the lazy loading the default behavior and have the
flag here be say, "--eager-loading" ?

>  --ns::
>         Use 9 decimal places when displaying time (i.e. show the nanoseco=
nds)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index b6691ebb1b4e..88aaf9cfd132 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -4287,6 +4287,8 @@ int cmd_script(int argc, const char **argv)
>                      "Set the maximum stack depth when parsing the callch=
ain, "
>                      "anything beyond the specified depth will be ignored=
. "
>                      "Default: kernel.perf_event_max_stack or " __stringi=
fy(PERF_MAX_STACK_DEPTH)),
> +       OPT_BOOLEAN(0, "lazy-load-symbols", &symbol_conf.lazy_load_symbol=
s,
> +                   "Read symbol names only when they are needed"),
>         OPT_BOOLEAN(0, "reltime", &reltime, "Show time stamps relative to=
 start"),
>         OPT_BOOLEAN(0, "deltatime", &deltatime, "Show time stamps relativ=
e to previous event"),
>         OPT_BOOLEAN('I', "show-info", &show_full_info,
> diff --git a/tools/perf/ui/browsers/map.c b/tools/perf/ui/browsers/map.c
> index 075a575cdc5d..ef8f75699a07 100644
> --- a/tools/perf/ui/browsers/map.c
> +++ b/tools/perf/ui/browsers/map.c
> @@ -108,7 +108,7 @@ int map__browse(struct map *map)
>  {
>         struct map_browser mb =3D {
>                 .b =3D {
> -                       .entries =3D dso__symbols(map__dso(map)),
> +                       .entries =3D dso__named_symbols(map__dso(map)),
>                         .refresh =3D ui_browser__rb_tree_refresh,
>                         .seek    =3D ui_browser__rb_tree_seek,
>                         .write   =3D map_browser__write,
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index ce98613868e7..f41abf442476 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -2013,7 +2013,7 @@ size_t dso__fprintf(struct dso *dso, FILE *fp)
>         ret +=3D fprintf(fp, "%sloaded, ", dso__loaded(dso) ? "" : "NOT "=
);
>         ret +=3D dso__fprintf_buildid(dso, fp);
>         ret +=3D fprintf(fp, ")\n");
> -       for (nd =3D rb_first_cached(dso__symbols(dso)); nd; nd =3D rb_nex=
t(nd)) {
> +       for (nd =3D rb_first_cached(dso__named_symbols(dso)); nd; nd =3D =
rb_next(nd)) {
>                 struct symbol *pos =3D rb_entry(nd, struct symbol, rb_nod=
e);
>                 ret +=3D symbol__fprintf(pos, fp);
>         }
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index 3329f417810c..4a60c883cc37 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -369,7 +369,7 @@ int dso_id__cmp(const struct dso_id *a, const struct =
dso_id *b);
>   * @n: the 'struct rb_node *' to use as a temporary storage
>   */
>  #define dso__for_each_symbol(dso, pos, n)      \
> -       symbols__for_each_entry(dso__symbols(dso), pos, n)
> +       symbols__for_each_entry(dso__named_symbols(dso), pos, n)
>
>  static inline void *dso__a2l(const struct dso *dso)
>  {
> @@ -831,6 +831,7 @@ char *dso__filename_with_chroot(const struct dso *dso=
, const char *filename);
>  bool dso__sorted_by_name(const struct dso *dso);
>  void dso__set_sorted_by_name(struct dso *dso);
>  void dso__sort_by_name(struct dso *dso);
> +struct rb_root_cached *dso__named_symbols(struct dso *dso);
>
>  int dso__swap_init(struct dso *dso, unsigned char eidata);
>
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 1e2716c6af45..bce6c6aef20c 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -17,6 +17,7 @@
>  #include "machine.h"
>  #include "vdso.h"
>  #include "debug.h"
> +#include "namespaces.h"
>  #include "util/copyfile.h"
>  #include <linux/ctype.h>
>  #include <linux/kernel.h>
> @@ -348,7 +349,7 @@ static bool get_ifunc_name(Elf *elf, struct dso *dso,=
 GElf_Ehdr *ehdr,
>
>         addr -=3D phdr.p_vaddr - phdr.p_offset;
>
> -       sym =3D dso__find_symbol_nocache(dso, addr);
> +       sym =3D symbols__find(dso__symbols(dso), addr);
>
>         /* Expecting the address to be an IFUNC or IFUNC alias */
>         if (!sym || sym->start !=3D addr ||
> @@ -629,7 +630,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, stru=
ct symsrc *ss)
>          * by symbols__fixup_end() to overlap .plt. Truncate it before ad=
ding
>          * a symbol for .plt header.
>          */
> -       f =3D dso__find_symbol_nocache(dso, shdr_plt.sh_offset);
> +       f =3D symbols__find(dso__symbols(dso), shdr_plt.sh_offset);
>         if (f && f->start < shdr_plt.sh_offset && f->end > shdr_plt.sh_of=
fset)
>                 f->end =3D shdr_plt.sh_offset;
>
> @@ -1516,6 +1517,190 @@ static int dso__process_kernel_symbol(struct dso =
*dso, struct map *map,
>         return 0;
>  }
>
> +static DEFINE_MUTEX(lazy_names_lock);

I'm curious if this is global just to avoid the expense of a mutex per
symbol or it needs to be global? We have
tools/perf/util/sharded_mutex.h as a way of doing a cheaper per object
mutex, but perhaps the dso__lock works?

Thanks,
Ian

> +
> +static char *read_name_at(int fd, u64 off)
> +{
> +       char small[256], *buf =3D NULL, *tmp;
> +       size_t size =3D sizeof(small);
> +       ssize_t n =3D pread(fd, small, size, off);
> +
> +       if (n > 0 && memchr(small, '\0', n))
> +               return strdup(small);
> +
> +       while (n =3D=3D (ssize_t)size) {
> +               size *=3D 2;
> +               tmp =3D realloc(buf, size);
> +               if (!tmp)
> +                       break;
> +               buf =3D tmp;
> +               n =3D pread(fd, buf, size, off);
> +               if (n > 0 && memchr(buf, '\0', n))
> +                       return buf;
> +       }
> +       free(buf);
> +       return NULL;
> +}
> +
> +static int load_symbol_names(struct dso *dso, int fd, struct symbol **sy=
ms, size_t nr)
> +{
> +       int err =3D 0;
> +
> +       for (size_t i =3D 0; i < nr; i++) {
> +               char *name, *demangled;
> +
> +               if (!symbol__has_lazy_name(syms[i]))
> +                       continue;
> +               name =3D read_name_at(fd, syms[i]->name_off);
> +               if (!name) {
> +                       pr_debug("%s: cannot read the symbol name at %#" =
PRIx64 "\n",
> +                                dso__long_name(dso), syms[i]->name_off);
> +                       err =3D -1;
> +                       continue;
> +               }
> +               demangled =3D dso__demangle_sym(dso, /*kmodule=3D*/0, nam=
e);
> +               if (demangled) {
> +                       free(name);
> +                       name =3D demangled;
> +               }
> +               symbol__set_lazy_name(syms[i], name);
> +       }
> +       return err;
> +}
> +
> +/*
> + * Load the lazy names in @syms, which are symbols of @dso, from the fil=
e of
> + * dso__symtab_type(). A name that cannot be read becomes "[unknown]".
> + */
> +void dso__load_symbol_names(struct dso *dso, struct symbol **syms, size_=
t nr)
> +{
> +       enum dso_binary_type type =3D dso__symtab_type(dso);
> +       /* As in dso__load(), the build-id cache is in perf's mount names=
pace. */
> +       bool own_ns =3D type =3D=3D DSO_BINARY_TYPE__BUILD_ID_CACHE ||
> +                     type =3D=3D DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGIN=
FO;
> +       struct nscookie nsc;
> +       bool decomp;
> +       char *name;
> +       int fd =3D -1;
> +
> +       mutex_lock(&lazy_names_lock);
> +       if (!own_ns)
> +               nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
> +       name =3D dso__get_filename(dso, "", &decomp, type);
> +       if (name)
> +               fd =3D open(name, O_RDONLY | O_CLOEXEC);
> +       if (!own_ns)
> +               nsinfo__mountns_exit(&nsc);
> +
> +       if (fd >=3D 0) {
> +               load_symbol_names(dso, fd, syms, nr);
> +               close(fd);
> +       } else {
> +               pr_debug("%s: cannot open the symbol table file\n", dso__=
long_name(dso));
> +       }
> +       if (name)
> +               dso__put_filename(dso, name, decomp);
> +       for (size_t i =3D 0; i < nr; i++) {
> +               if (symbol__has_lazy_name(syms[i]))
> +                       symbol__set_unknown_name(syms[i]);
> +       }
> +       mutex_unlock(&lazy_names_lock);
> +}
> +
> +/*
> + * Return the lazy symbol in @symbols that the .dynsym entry @sym named
> + * @name copies, with the same address, size, binding, type and name.
> + * symbols__fixup_duplicate() would keep that symbol and drop the copy.
> + */
> +static struct symbol *lazy_dynsym_copy(struct rb_root_cached *symbols, E=
lf *elf,
> +                                      const GElf_Sym *sym, const char *n=
ame)
> +{
> +       struct rb_node *nd =3D symbols->rb_root.rb_node, *prev;
> +       const char *image;
> +       struct symbol *s;
> +       size_t size;
> +
> +       if (!sym->st_size)
> +               return NULL;
> +       image =3D elf_rawfile(elf, &size);
> +       if (!image)
> +               return NULL;
> +
> +       while (nd) {
> +               s =3D rb_entry(nd, struct symbol, rb_node);
> +               if (sym->st_value < s->start)
> +                       nd =3D nd->rb_left;
> +               else if (sym->st_value > s->start)
> +                       nd =3D nd->rb_right;
> +               else
> +                       break;
> +       }
> +       if (!nd)
> +               return NULL;
> +       while ((prev =3D rb_prev(nd)) &&
> +              rb_entry(prev, struct symbol, rb_node)->start =3D=3D sym->=
st_value)
> +               nd =3D prev;
> +
> +       for (; nd; nd =3D rb_next(nd)) {
> +               s =3D rb_entry(nd, struct symbol, rb_node);
> +               if (s->start !=3D sym->st_value)
> +                       break;
> +               if (s->end =3D=3D s->start + sym->st_size &&
> +                   symbol__binding(s) =3D=3D GELF_ST_BIND(sym->st_info) =
&&
> +                   symbol__type(s) =3D=3D GELF_ST_TYPE(sym->st_info) &&
> +                   symbol__has_lazy_name(s) && s->name_off < size &&
> +                   !strncmp(image + s->name_off, name, size - s->name_of=
f))
> +                       return s;
> +       }
> +       return NULL;
> +}
> +
> +/*
> + * symbols__fixup_duplicate() compares the names of symbols at the same
> + * address only when their size, type and binding tie. Load those names.
> + */
> +static int dso__load_alias_names(struct dso *dso, int fd)
> +{
> +       struct rb_node *nd =3D rb_first_cached(dso__symbols(dso));
> +
> +       while (nd) {
> +               struct symbol *first =3D rb_entry(nd, struct symbol, rb_n=
ode);
> +               struct rb_node *end =3D rb_next(nd), *a, *b;
> +
> +               while (end && rb_entry(end, struct symbol, rb_node)->star=
t =3D=3D first->start)
> +                       end =3D rb_next(end);
> +
> +               for (a =3D nd; a !=3D end; a =3D rb_next(a)) {
> +                       for (b =3D rb_next(a); b !=3D end; b =3D rb_next(=
b)) {
> +                               struct symbol *pair[2] =3D {
> +                                       rb_entry(a, struct symbol, rb_nod=
e),
> +                                       rb_entry(b, struct symbol, rb_nod=
e),
> +                               };
> +
> +                               if (symbol__choice_needs_names(pair[0], p=
air[1]) &&
> +                                   load_symbol_names(dso, fd, pair, 2))
> +                                       return -1;
> +                       }
> +               }
> +               nd =3D end;
> +       }
> +       return 0;
> +}
> +
> +/* PLT synthesis names IRELATIVE slots after IFUNC symbols. Load those n=
ames. */
> +static int dso__load_ifunc_names(struct dso *dso, int fd)
> +{
> +       struct symbol *pos;
> +       struct rb_node *nd;
> +
> +       symbols__for_each_entry(dso__symbols(dso), pos, nd) {
> +               if ((symbol__type(pos) =3D=3D STT_GNU_IFUNC || symbol__if=
unc_alias(pos)) &&
> +                   load_symbol_names(dso, fd, &pos, 1))
> +                       return -1;
> +       }
> +       return 0;
> +}
> +
>  static int
>  dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *=
syms_ss,
>                        struct symsrc *runtime_ss, int kmodule, int dynsym=
)
> @@ -1533,9 +1718,19 @@ dso__load_sym_internal(struct dso *dso, struct map=
 *map, struct symsrc *syms_ss,
>         GElf_Sym sym;
>         Elf_Scn *sec, *sec_strndx;
>         Elf *elf;
> -       int nr =3D 0;
> +       int nr =3D 0, nr_lazy =3D 0;
>         bool remap_kernel =3D false, adjust_kernel_syms =3D false;
>         u64 max_text_sh_offset =3D 0;
> +       /*
> +        * Names are read later from the file of dso__symtab_type(). The
> +        * .gnu_debugdata symbol table is a temporary file.
> +        */
> +       bool lazy_allowed =3D symbol_conf.lazy_load_symbols && !dso__kern=
el(dso) &&
> +                         !kmodule && syms_ss->type =3D=3D dso__symtab_ty=
pe(dso) &&
> +                         syms_ss->type !=3D DSO_BINARY_TYPE__GNU_DEBUGDA=
TA &&
> +                         !runtime_ss->opdsec;
> +       bool lazy_names =3D false;
> +       GElf_Shdr strshdr;
>
>         if (kmap && !kmaps)
>                 return -1;
> @@ -1571,6 +1766,11 @@ dso__load_sym_internal(struct dso *dso, struct map=
 *map, struct symsrc *syms_ss,
>         if (symstrs =3D=3D NULL)
>                 goto out_elf_end;
>
> +       /* Names are read with pread(), so the string table must be store=
d as is. */
> +       if (lazy_allowed && gelf_getshdr(sec, &strshdr) &&
> +           strshdr.sh_type =3D=3D SHT_STRTAB && !(strshdr.sh_flags & SHF=
_COMPRESSED))
> +               lazy_names =3D true;
> +
>         sec_strndx =3D elf_getscn(runtime_ss->elf, runtime_ss->ehdr.e_shs=
trndx);
>         if (sec_strndx =3D=3D NULL)
>                 goto out_elf_end;
> @@ -1772,14 +1972,36 @@ dso__load_sym_internal(struct dso *dso, struct ma=
p *map, struct symsrc *syms_ss,
>                         }
>                 }
>
> -               demangled =3D dso__demangle_sym(dso, kmodule, elf_name);
> -               if (demangled !=3D NULL)
> -                       elf_name =3D demangled;
> +               /*
> +                * Most .dynsym entries are copies of .symtab symbols, wh=
ich
> +                * duplicate selection would drop anyway. Skip them here,=
 so
> +                * that perf does not read both names just to choose one.
> +                */
> +               if (lazy_names && dynsym && !symbol_conf.allow_aliases) {
> +                       f =3D lazy_dynsym_copy(dso__symbols(curr_dso), el=
f, &sym, elf_name);
> +                       if (f) {
> +                               if (GELF_ST_TYPE(sym.st_info) =3D=3D STT_=
GNU_IFUNC)
> +                                       symbol__set_ifunc_alias(f, true);
> +                               continue;
> +                       }
> +               }
>
> -               f =3D symbol__new(sym.st_value, sym.st_size,
> -                               GELF_ST_BIND(sym.st_info),
> -                               GELF_ST_TYPE(sym.st_info), elf_name);
> -               free(demangled);
> +               if (lazy_names && sym.st_name < strshdr.sh_size) {
> +                       f =3D symbol__new_lazy(sym.st_value, sym.st_size,
> +                                            GELF_ST_BIND(sym.st_info),
> +                                            GELF_ST_TYPE(sym.st_info),
> +                                            strshdr.sh_offset + sym.st_n=
ame);
> +                       nr_lazy++;
> +               } else {
> +                       demangled =3D dso__demangle_sym(dso, kmodule, elf=
_name);
> +                       if (demangled !=3D NULL)
> +                               elf_name =3D demangled;
> +
> +                       f =3D symbol__new(sym.st_value, sym.st_size,
> +                                       GELF_ST_BIND(sym.st_info),
> +                                       GELF_ST_TYPE(sym.st_info), elf_na=
me);
> +                       free(demangled);
> +               }
>                 if (!f)
>                         goto out_elf_end;
>
> @@ -1790,12 +2012,21 @@ dso__load_sym_internal(struct dso *dso, struct ma=
p *map, struct symsrc *syms_ss,
>         }
>         dso__put(curr_dso);
>
> +       if (lazy_names)
> +               pr_debug("%s: %d %s symbols with lazy names\n", dso__long=
_name(dso),
> +                        nr_lazy, dynsym ? ".dynsym" : ".symtab");
> +
>         /*
>          * For misannotated, zeroed, ASM function sizes.
>          */
>         if (nr > 0) {
>                 symbols__fixup_end(dso__symbols(dso), false);
> +               if (lazy_allowed && !symbol_conf.allow_aliases &&
> +                   dso__load_alias_names(dso, syms_ss->fd))
> +                       return -1;
>                 symbols__fixup_duplicate(dso__symbols(dso));
> +               if (lazy_allowed && dso__load_ifunc_names(dso, syms_ss->f=
d))
> +                       return -1;
>                 if (kmap) {
>                         /*
>                          * We need to fixup this here too because we crea=
te new
> diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-mi=
nimal.c
> index 0a71d1463952..fa87c2d9de2a 100644
> --- a/tools/perf/util/symbol-minimal.c
> +++ b/tools/perf/util/symbol-minimal.c
> @@ -330,6 +330,12 @@ enum dso_type dso__type_fd(int fd)
>         return DSO__TYPE_32BIT;
>  }
>
> +void dso__load_symbol_names(struct dso *dso __maybe_unused,
> +                           struct symbol **syms __maybe_unused,
> +                           size_t nr __maybe_unused)
> +{
> +}
> +
>  int dso__load_sym(struct dso *dso, struct map *map __maybe_unused,
>                   struct symsrc *ss,
>                   struct symsrc *runtime_ss __maybe_unused,
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 02c077d7e2a6..4b5cde4d13be 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -338,9 +338,9 @@ void symbols__fixup_end(struct rb_root_cached *symbol=
s, bool is_kallsyms)
>                 curr->end =3D roundup(curr->start, 4096) + 4096;
>  }
>
> -struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, cons=
t char *name)
> +static struct symbol *symbol__alloc(u64 start, u64 len, u8 binding, u8 t=
ype,
> +                                   u16 flags, size_t namelen)
>  {
> -       size_t namelen =3D strlen(name) + 1;
>         struct symbol *sym =3D calloc(1, (symbol_conf.priv_size +
>                                         sizeof(*sym) + namelen));
>         if (sym =3D=3D NULL)
> @@ -357,7 +357,18 @@ struct symbol *symbol__new(u64 start, u64 len, u8 bi=
nding, u8 type, const char *
>         sym->start   =3D start;
>         sym->end     =3D len ? start + len : start;
>         atomic_init(&sym->flags, (type << SYMBOL_FLAG_TYPE_SHIFT) |
> -                                (binding << SYMBOL_FLAG_BINDING_SHIFT));
> +                                (binding << SYMBOL_FLAG_BINDING_SHIFT) |=
 flags);
> +       return sym;
> +}
> +
> +struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, cons=
t char *name)
> +{
> +       size_t namelen =3D strlen(name) + 1;
> +       struct symbol *sym =3D symbol__alloc(start, len, binding, type, 0=
, namelen);
> +
> +       if (sym =3D=3D NULL)
> +               return NULL;
> +
>         sym->namelen =3D namelen - 1;
>
>         pr_debug4("%s: %s %#" PRIx64 "-%#" PRIx64 "\n",
> @@ -368,8 +379,38 @@ struct symbol *symbol__new(u64 start, u64 len, u8 bi=
nding, u8 type, const char *
>         return sym;
>  }
>
> +struct symbol *symbol__new_lazy(u64 start, u64 len, u8 binding, u8 type,=
 u64 name_off)
> +{
> +       struct symbol *sym =3D symbol__alloc(start, len, binding, type,
> +                                          SYMBOL_FLAG_LAZY_NAME, 0);
> +
> +       if (sym)
> +               sym->name_off =3D name_off;
> +       return sym;
> +}
> +
> +/* @sym takes ownership of @name. */
> +void symbol__set_lazy_name(struct symbol *sym, char *name)
> +{
> +       sym->namelen =3D strlen(name);
> +       sym->name =3D name;
> +       atomic_fetch_and(&sym->flags, ~SYMBOL_FLAG_LAZY_NAME);
> +}
> +
> +/* The name of the symbols whose lazy name cannot be read. */
> +static const char unknown_name[] =3D "[unknown]";
> +
> +void symbol__set_unknown_name(struct symbol *sym)
> +{
> +       symbol__set_lazy_name(sym, (char *)unknown_name);
> +}
> +
>  void symbol__delete(struct symbol *sym)
>  {
> +       /* A loaded lazy name is allocated apart from the symbol. */
> +       if (!symbol__has_lazy_name(sym) && sym->name !=3D (char *)(sym + =
1) &&
> +           sym->name !=3D unknown_name)
> +               free(sym->name);
>         if (symbol_conf.priv_size) {
>                 if (symbol_conf.init_annotation) {
>                         struct annotation *notes =3D symbol__annotation(s=
ym);
> @@ -463,7 +504,7 @@ void symbols__insert(struct rb_root_cached *symbols, =
struct symbol *sym)
>         __symbols__insert(symbols, sym);
>  }
>
> -static struct symbol *symbols__find(struct rb_root_cached *symbols, u64 =
ip)
> +struct symbol *symbols__find(struct rb_root_cached *symbols, u64 ip)
>  {
>         struct rb_node *n;
>
> @@ -638,6 +679,16 @@ void dso__delete_symbol(struct dso *dso, struct symb=
ol *sym)
>         dso__reset_find_symbol_cache(dso);
>  }
>
> +/* Return @sym with its name loaded, or NULL if the name cannot be read.=
 */
> +static struct symbol *dso__named_symbol(struct dso *dso, struct symbol *=
sym)
> +{
> +       if (sym && symbol__has_lazy_name(sym))
> +               dso__load_symbol_names(dso, &sym, 1);
> +       if (sym && sym->name =3D=3D unknown_name)
> +               return NULL;
> +       return sym;
> +}
> +
>  struct symbol *dso__find_symbol(struct dso *dso, u64 addr)
>  {
>         if (dso__last_find_result_addr(dso) !=3D addr || dso__last_find_r=
esult_symbol(dso) =3D=3D NULL) {
> @@ -645,22 +696,22 @@ struct symbol *dso__find_symbol(struct dso *dso, u6=
4 addr)
>                 dso__set_last_find_result_symbol(dso, symbols__find(dso__=
symbols(dso), addr));
>         }
>
> -       return dso__last_find_result_symbol(dso);
> +       return dso__named_symbol(dso, dso__last_find_result_symbol(dso));
>  }
>
>  struct symbol *dso__find_symbol_nocache(struct dso *dso, u64 addr)
>  {
> -       return symbols__find(dso__symbols(dso), addr);
> +       return dso__named_symbol(dso, symbols__find(dso__symbols(dso), ad=
dr));
>  }
>
>  struct symbol *dso__first_symbol(struct dso *dso)
>  {
> -       return symbols__first(dso__symbols(dso));
> +       return symbols__first(dso__named_symbols(dso));
>  }
>
>  struct symbol *dso__last_symbol(struct dso *dso)
>  {
> -       return symbols__last(dso__symbols(dso));
> +       return symbols__last(dso__named_symbols(dso));
>  }
>
>  struct symbol *dso__next_symbol(struct symbol *sym)
> @@ -692,12 +743,58 @@ struct symbol *dso__find_symbol_by_name(struct dso =
*dso, const char *name, size_
>         return s;
>  }
>
> +/*
> + * Load every lazy name. Do not delete the symbols whose name cannot be
> + * read, since address lookups search the tree without the DSO lock.
> + */
> +static void __dso__load_all_symbol_names(struct dso *dso)
> +{
> +       struct rb_node *nd =3D rb_first_cached(dso__symbols(dso));
> +       struct symbol *batch[512];
> +
> +       while (nd) {
> +               size_t nr =3D 0;
> +
> +               for (; nd && nr < ARRAY_SIZE(batch); nd =3D rb_next(nd)) =
{
> +                       struct symbol *pos =3D rb_entry(nd, struct symbol=
, rb_node);
> +
> +                       if (symbol__has_lazy_name(pos))
> +                               batch[nr++] =3D pos;
> +               }
> +               if (nr)
> +                       dso__load_symbol_names(dso, batch, nr);
> +       }
> +}
> +
> +/*
> + * Lazy names exist only in userspace DSOs, and are all loaded once the =
DSO
> + * is sorted by name. Checking that first avoids taking the DSO lock, wh=
ich
> + * the callers that walk kernel symbols may hold.
> + */
> +static bool dso__may_have_lazy_names(struct dso *dso)
> +{
> +       return symbol_conf.lazy_load_symbols && !dso__kernel(dso) &&
> +              !dso__sorted_by_name(dso);
> +}
> +
> +struct rb_root_cached *dso__named_symbols(struct dso *dso)
> +{
> +       if (dso__may_have_lazy_names(dso)) {
> +               mutex_lock(dso__lock(dso));
> +               __dso__load_all_symbol_names(dso);
> +               mutex_unlock(dso__lock(dso));
> +       }
> +       return dso__symbols(dso);
> +}
> +
>  void dso__sort_by_name(struct dso *dso)
>  {
>         mutex_lock(dso__lock(dso));
>         if (!dso__sorted_by_name(dso)) {
>                 size_t len =3D 0;
>
> +               if (dso__may_have_lazy_names(dso))
> +                       __dso__load_all_symbol_names(dso);
>                 dso__set_symbol_names(dso, symbols__sort_by_name(dso__sym=
bols(dso), &len));
>                 if (dso__symbol_names(dso)) {
>                         dso__set_symbol_names_len(dso, len);
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index c231d8e4427c..5ab222b0655b 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -80,9 +80,18 @@ enum symbol_idle_kind {
>  #define SYMBOL_FLAG_INLINED         (1 << 11)
>  #define SYMBOL_FLAG_ANNOTATE2       (1 << 12)
>  #define SYMBOL_FLAG_IFUNC_ALIAS     (1 << 13)
> +#define SYMBOL_FLAG_LAZY_NAME       (1 << 14)
>  /**
>   * A symtab entry. When allocated this may be preceded by an annotation =
(see
>   * symbol__annotation) and/or a browser_index (see symbol__browser_index=
).
> + *
> + * With symbol_conf.lazy_load_symbols, the ELF loader may create symbols
> + * with SYMBOL_FLAG_LAZY_NAME, whose name is still in the symbol table f=
ile.
> + * The functions that return a symbol of a DSO, such as dso__find_symbol=
(),
> + * load its name first, and dso__named_symbols() loads them all for code
> + * that walks the symbols. A symbol whose name cannot be read is named
> + * "[unknown]", and address lookups return NULL for it. Code that walks
> + * dso__symbols() directly must not read the name of a lazy symbol.
>   */
>  struct symbol {
>         struct rb_node  rb_node;
> @@ -94,13 +103,24 @@ struct symbol {
>         _Atomic uint16_t flags;
>         /** Architecture specific. Unused except on PPC where it holds st=
_other. */
>         u8              arch_sym;
> -       /** The name of length namelen associated with the symbol. */
> -       char            *name;
> +       union {
> +               /** The name of length namelen associated with the symbol=
. */
> +               char    *name;
> +               /** File offset of the name while SYMBOL_FLAG_LAZY_NAME i=
s set. */
> +               u64     name_off;
> +       };
>  };
>
>  void symbol__delete(struct symbol *sym);
>  void symbols__delete(struct rb_root_cached *symbols);
>
> +/* Pairs with the release in symbol__set_lazy_name(). */
> +static inline bool symbol__has_lazy_name(const struct symbol *sym)
> +{
> +       return (atomic_load_explicit(&sym->flags, memory_order_acquire) &
> +               SYMBOL_FLAG_LAZY_NAME) !=3D 0;
> +}
> +
>  static inline u8 symbol__type(const struct symbol *sym)
>  {
>         return (atomic_load_explicit(&sym->flags, memory_order_relaxed) &
> @@ -227,6 +247,9 @@ void symbol__elf_init(void);
>  int symbol__annotation_init(void);
>
>  struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, cons=
t char *name);
> +struct symbol *symbol__new_lazy(u64 start, u64 len, u8 binding, u8 type,=
 u64 name_off);
> +void symbol__set_lazy_name(struct symbol *sym, char *name);
> +void symbol__set_unknown_name(struct symbol *sym);
>  size_t __symbol__fprintf_symname_offs(const struct symbol *sym,
>                                       const struct addr_location *al,
>                                       bool unknown_as_addr,
> @@ -257,11 +280,13 @@ int dso__load_bfd_symbols(struct dso *dso, const ch=
ar *debugfile);
>  int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_=
ss,
>                   struct symsrc *runtime_ss, int kmodule);
>  int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss);
> +void dso__load_symbol_names(struct dso *dso, struct symbol **syms, size_=
t nr);
>
>  char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_na=
me);
>
>  void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sy=
m);
>  void symbols__insert(struct rb_root_cached *symbols, struct symbol *sym)=
;
> +struct symbol *symbols__find(struct rb_root_cached *symbols, u64 ip);
>  void symbols__fixup_duplicate(struct rb_root_cached *symbols);
>  void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms=
);
>
> diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.=
h
> index 37d35f42dcc1..434b6c51288b 100644
> --- a/tools/perf/util/symbol_conf.h
> +++ b/tools/perf/util/symbol_conf.h
> @@ -77,6 +77,7 @@ struct symbol_conf {
>                         no_buildid_mmap2,
>                         guest_code,
>                         lazy_load_kernel_maps,
> +                       lazy_load_symbols,
>                         keep_exited_threads,
>                         annotate_data_member,
>                         annotate_data_sample,
>
> --
> Git-157)
>
>
