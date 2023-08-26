Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03414C83F11
	for <linux-perf-users@archiver.kernel.org>; Sat, 26 Aug 2023 09:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjHZJvt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 26 Aug 2023 05:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjHZJv2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 26 Aug 2023 05:51:28 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2341D272B
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Aug 2023 02:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1693043373;
        bh=p3YpqU+EAKVPZiCc8ygp7fZ6DxDfOkZsVuvVpGeDsb0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lo8WrC0yj0N2oePNH4BGfV6tGeikDFvWDHnki5gqibp9/ss5c3p9izU32AxoT/Do6
         BXafWg0MwW3H43/W9Yw0rcrN5ppDK7KKFQWyTQTI1GIEObNUJCnrLl4DalNLObT319
         NWM/b4xXkb0CFTqejgBjJhD1BdR4X85ft35lgf+A=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 12E4F659C7;
        Sat, 26 Aug 2023 05:49:30 -0400 (EDT)
Message-ID: <ef11874aca952984d67ad5fb65b7fc1e265e2ef2.camel@xry111.site>
Subject: Re: [PATCH v3 3/3] perf/trace: Use "test -f" instead of "[-f FILE]"
From:   Xi Ruoyao <xry111@xry111.site>
To:     Yanteng Si <siyanteng@loongson.cn>, acme@kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        chenhuacai@kernel.org, linux-perf-users@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn, loongarch@lists.linux.dev
Date:   Sat, 26 Aug 2023 17:49:29 +0800
In-Reply-To: <b9fc1affbca15cbf18cc23905f823047b4e2f1b6.1693040967.git.siyanteng@loongson.cn>
References: <cover.1693040967.git.siyanteng@loongson.cn>
         <b9fc1affbca15cbf18cc23905f823047b4e2f1b6.1693040967.git.siyanteng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, 2023-08-26 at 17:40 +0800, Yanteng Si wrote:
> It will be simpler without that extra subshell, so
> let's use "test -f".

Sorry for duplicated reply (I replied to v2 minutes ago), but I cannot
understand this sentence.  [ ... ] has nothing to do with subshell, it's
just a syntax variant of "test".

> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
> =C2=A0tools/perf/trace/beauty/mmap_flags.sh | 9 ++++++---
> =C2=A0tools/perf/trace/beauty/mmap_prot.sh=C2=A0 | 5 +++--
> =C2=A02 files changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/tools/perf/trace/beauty/mmap_flags.sh
> b/tools/perf/trace/beauty/mmap_flags.sh
> index d035b29fc5ec..6ecdb3c5a99e 100755
> --- a/tools/perf/trace/beauty/mmap_flags.sh
> +++ b/tools/perf/trace/beauty/mmap_flags.sh
> @@ -19,7 +19,8 @@ arch_mman=3D${arch_header_dir}/mman.h
> =C2=A0
> =C2=A0printf "static const char *mmap_flags[] =3D {\n"
> =C2=A0regex=3D'^[[:space:]]*#[[:space:]]*define[[:space:]]+MAP_([[:alnum:=
]_]+
> )[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
> -([ -f ${arch_mman} ] && grep -E -q $regex ${arch_mman}) && \
> +test -f ${arch_mman} && \
> +grep -E -q $regex ${arch_mman} && \
> =C2=A0(grep -E $regex ${arch_mman} | \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sed -r "s/$regex/\2 \1 \1=
 \1 \2/g"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0xargs printf "\t[ilog2(%s=
) + 1] =3D \"%s\",\n#ifndef
> MAP_%s\n#define MAP_%s %s\n#endif\n")
> @@ -28,12 +29,14 @@ grep -E -q $regex ${linux_mman} && \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0grep -E -vw 'MAP_(UNINITI=
ALIZED|TYPE|SHARED_VALIDATE)' | \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sed -r "s/$regex/\2 \1 \1=
 \1 \2/g" | \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0xargs printf "\t[ilog2(%s=
) + 1] =3D \"%s\",\n#ifndef
> MAP_%s\n#define MAP_%s %s\n#endif\n")
> -([ ! -f ${arch_mman} ] || grep -E -q
> '#[[:space:]]*include[[:space:]]+.*uapi/asm-generic/mman.*'
> ${arch_mman}) &&
> +( ! test -f ${arch_mman} || \
> +grep -E -q '#[[:space:]]*include[[:space:]]+.*uapi/asm-
> generic/mman.*' ${arch_mman}) &&
> =C2=A0(grep -E $regex ${header_dir}/mman-common.h | \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0grep -E -vw 'MAP_(UNINITI=
ALIZED|TYPE|SHARED_VALIDATE)' | \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sed -r "s/$regex/\2 \1 \1=
 \1 \2/g"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0xargs printf "\t[ilog2(%s=
) + 1] =3D \"%s\",\n#ifndef
> MAP_%s\n#define MAP_%s %s\n#endif\n")
> -([ ! -f ${arch_mman} ] || grep -E -q
> '#[[:space:]]*include[[:space:]]+.*uapi/asm-generic/mman.h>.*'
> ${arch_mman}) &&
> +( ! test -f ${arch_mman} || \
> +grep -E -q '#[[:space:]]*include[[:space:]]+.*uapi/asm-
> generic/mman.h>.*' ${arch_mman}) &&
> =C2=A0(grep -E $regex ${header_dir}/mman.h | \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sed -r "s/$regex/\2 \1 \1=
 \1 \2/g"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0xargs printf "\t[ilog2(%s=
) + 1] =3D \"%s\",\n#ifndef
> MAP_%s\n#define MAP_%s %s\n#endif\n")
> diff --git a/tools/perf/trace/beauty/mmap_prot.sh
> b/tools/perf/trace/beauty/mmap_prot.sh
> index 49e8c865214b..4436fcd6e861 100755
> --- a/tools/perf/trace/beauty/mmap_prot.sh
> +++ b/tools/perf/trace/beauty/mmap_prot.sh
> @@ -17,12 +17,13 @@ prefix=3D"PROT"
> =C2=A0
> =C2=A0printf "static const char *mmap_prot[] =3D {\n"
> =C2=A0regex=3D`printf
> '^[[:space:]]*#[[:space:]]*define[[:space:]]+%s_([[:alnum:]_]+)[[:spac
> e:]]+(0x[[:xdigit:]]+)[[:space:]]*.*' ${prefix}`
> -([ ! -f ${arch_mman} ] || grep -E -q
> '#[[:space:]]*include[[:space:]]+.*uapi/asm-generic/mman.*'
> ${arch_mman}) &&
> +( ! test -f ${arch_mman} \
> +|| grep -E -q '#[[:space:]]*include[[:space:]]+.*uapi/asm-
> generic/mman.*' ${arch_mman}) &&
> =C2=A0(grep -E $regex ${common_mman} | \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0grep -E -vw PROT_NONE | \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sed -r "s/$regex/\2 \1 \1=
 \1 \2/g"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0xargs printf "\t[ilog2(%s=
) + 1] =3D \"%s\",\n#ifndef
> ${prefix}_%s\n#define ${prefix}_%s %s\n#endif\n")
> -[ -f ${arch_mman} ] && grep -E -q $regex ${arch_mman} &&
> +test -f ${arch_mman} && grep -E -q $regex ${arch_mman} &&
> =C2=A0(grep -E $regex ${arch_mman} | \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0grep -E -vw PROT_NONE | \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sed -r "s/$regex/\2 \1 \1=
 \1 \2/g"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| \

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
