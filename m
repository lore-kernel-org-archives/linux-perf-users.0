Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00860C83F11
	for <linux-perf-users@archiver.kernel.org>; Sat, 26 Aug 2023 09:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjHZJnQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 26 Aug 2023 05:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbjHZJnM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 26 Aug 2023 05:43:12 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE662705
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Aug 2023 02:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1693042936;
        bh=uVhL8v8S6E2rp54FFN4oVfC9LZPfdMBrMIGDNzCpdmw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Y8DWeQxtr1pnoC0RYYma+xath1yx7G0CUWyeVOpMtZk6LXybE/q2XjN0AiBoHs6jl
         4fsE8118FMmaLHLS7u7ImjRvoxhMpVcjmMZPLbk66TYwQ9UrfEx4MirZVcsVHGwF+u
         TPsD59do7gZNbNkZVa1SkOXtFwCYtg76olNpu7tM=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 4DC40659AC;
        Sat, 26 Aug 2023 05:42:13 -0400 (EDT)
Message-ID: <cfee4c63333de790d7042ecd95cac67f3b79e3ee.camel@xry111.site>
Subject: Re: [PATCH v2 3/3] perf/tools: Use "test -f" instead of "[-f FILE]"
From:   Xi Ruoyao <xry111@xry111.site>
To:     Yanteng Si <siyanteng@loongson.cn>, acme@kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        chenhuacai@kernel.org, linux-perf-users@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn, loongarch@lists.linux.dev
Date:   Sat, 26 Aug 2023 17:42:11 +0800
In-Reply-To: <c50bc0a92dce0ff0fa6504c1a52fb53e2ac007bf.1692962043.git.siyanteng@loongson.cn>
References: <cover.1692962043.git.siyanteng@loongson.cn>
         <c50bc0a92dce0ff0fa6504c1a52fb53e2ac007bf.1692962043.git.siyanteng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, 2023-08-25 at 19:28 +0800, Yanteng Si wrote:
> It will be simpler without that extra subshell, so
> let's use "test -f".

I don't understand this sentence.  I'm pretty sure [ ... ] does not
start any subshell.

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
