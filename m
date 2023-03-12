Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C53FC6FA99
	for <linux-perf-users@archiver.kernel.org>; Sun, 12 Mar 2023 06:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjCLG17 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 12 Mar 2023 01:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCLG16 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 12 Mar 2023 01:27:58 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F092697
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Mar 2023 22:27:54 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t15so8560216wrz.7
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Mar 2023 22:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678602473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtv29KZX+XREe9cWzAMxT6V39t/L1NQeIC8ivHVuqS4=;
        b=o0/NYospeBO1+8cuP+NfwBHbLPcnYfw49cgYl3XTC5Ix9P6eV9x6V1BRXB92AePhzQ
         Xda0Eq54Oegsxn//6fhRY9YjbX9yCJ7g6vef56+Zl7ua5XAV+e3b/aWVTtgZZik5bBEc
         MXON0IdN9LwL9sevao0AitDnR2cTNtRkdOqYwR42RhK1GZiqOF4ZqSL01Mv42QaWl0P0
         1ypy2zSoVNkALt0IXZOgIVRVklSOQxbgNlaVpqIypfh9HkMv2mz8gxas5DaNrXMPgmnR
         QpeCZRPN9apuoktC8SI4zqi4UO15X+smd7H9PBd23iPa9w4keLmPvSImc9cB4t5DJDVs
         UU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678602473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtv29KZX+XREe9cWzAMxT6V39t/L1NQeIC8ivHVuqS4=;
        b=S0DQMDrCy4WE7qUH/9aPxqllOFdoFd2KLOdby609znoWqqN/+h5vxuohbb/Qkna2NN
         EWvy3O3SiuB2pB9oNAARGacUKoDSjtiA8FREB3P0+1Pmvew4FQvJ5sN2ItOTHvgZEi2m
         wCyhN050DvZCul0LJpVR2MRqwFFJsfRpV5fPUZv7Dw4sYTwmDnjLrEj2LbrmwZt7G3Du
         cjqs4xibRnHsgruBceExnhvY5SRYhlCWwX1+LbLbUoteVL0Ix98VeykchNukKnHzICdX
         UWjAy3qhWv5csDCnFELkcQ9dKEhX4hCpffUGR5uurCVW87qvCB0V0eERLVnZFSXlYCck
         Fy0w==
X-Gm-Message-State: AO0yUKXU0EhI47WiG1p1Q2gBceIRU+0E2D3649ZI3M5UzWfQf9zP+G9z
        A/i1bDox1Nnv8S+tJphByXvQ7zECyaqwMK4wHfgWuA==
X-Google-Smtp-Source: AK7set/W089nZRtqvQkaqo5MGXF43OWcIyaszLy3QrT1jn4BQxabvW3adNuV27z4WnO5yFKbt6/MdgsapvUuEkuPeEM=
X-Received: by 2002:adf:f189:0:b0:2ce:aaff:2a8c with SMTP id
 h9-20020adff189000000b002ceaaff2a8cmr151156wro.14.1678602473299; Sat, 11 Mar
 2023 22:27:53 -0800 (PST)
MIME-Version: 1.0
References: <20230311112122.28894-1-p4ranlee@gmail.com>
In-Reply-To: <20230311112122.28894-1-p4ranlee@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 11 Mar 2023 22:27:41 -0800
Message-ID: <CAP-5=fWkAqX+Uy_XhXHjEx6sj-wpOJ+WQf=vMtRzRBS-0Kj32Q@mail.gmail.com>
Subject: Re: [PATCH] perf tools riscv: Add support for riscv lookup_binutils_path
To:     paranlee <p4ranlee@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Daniel Axtens <dja@axtens.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Mar 11, 2023 at 3:22=E2=80=AFAM paranlee <p4ranlee@gmail.com> wrote=
:
>
> Add to know RISC-V binutils path.
> Secondarily, edit the code block with alphabetical order.
>
> Signed-off-by: Paran Lee <p4ranlee@gmail.com>
> ---
>  tools/perf/arch/common.c | 51 +++++++++++++++++++++++++++-------------
>  1 file changed, 35 insertions(+), 16 deletions(-)
>
> diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
> index 59dd875fd5e4..058527ededdd 100644
> --- a/tools/perf/arch/common.c
> +++ b/tools/perf/arch/common.c
> @@ -29,11 +29,23 @@ const char *const arm_triplets[] =3D {
>  };
>
>  const char *const arm64_triplets[] =3D {
> +       "aarch64-unknown-linux-",

Modifying ARM64 behavior should be a separate change.

>         "aarch64-linux-android-",
>         "aarch64-linux-gnu-",
>         NULL
>  };
>
> +const char *const mips_triplets[] =3D {
> +       "mips-unknown-linux-gnu-",
> +       "mipsel-linux-android-",
> +       "mips-linux-gnu-",
> +       "mips64-linux-gnu-",
> +       "mips64el-linux-gnuabi64-",
> +       "mips64-linux-gnuabi64-",
> +       "mipsel-linux-gnu-",
> +       NULL
> +};
> +

This will affect the blame history. It should probably be its own change to=
o.

>  const char *const powerpc_triplets[] =3D {
>         "powerpc-unknown-linux-gnu-",
>         "powerpc-linux-gnu-",
> @@ -43,6 +55,20 @@ const char *const powerpc_triplets[] =3D {
>         NULL
>  };
>
> +const char *const riscv32_triplets[] =3D {
> +       "riscv32-unknown-linux-gnu-",
> +       "riscv32-linux-android-",
> +       "riscv32-linux-gnu-",
> +       NULL
> +};
> +
> +const char *const riscv64_triplets[] =3D {
> +       "riscv64-unknown-linux-gnu-",
> +       "riscv64-linux-android-",
> +       "riscv64-linux-gnu-",
> +       NULL
> +};
> +
>  const char *const s390_triplets[] =3D {
>         "s390-ibm-linux-",
>         "s390x-linux-gnu-",
> @@ -78,17 +104,6 @@ const char *const x86_triplets[] =3D {
>         NULL
>  };
>
> -const char *const mips_triplets[] =3D {
> -       "mips-unknown-linux-gnu-",
> -       "mipsel-linux-android-",
> -       "mips-linux-gnu-",
> -       "mips64-linux-gnu-",
> -       "mips64el-linux-gnuabi64-",
> -       "mips64-linux-gnuabi64-",
> -       "mipsel-linux-gnu-",
> -       NULL
> -};
> -
>  static bool lookup_path(char *name)
>  {
>         bool found =3D false;
> @@ -164,18 +179,22 @@ static int perf_env__lookup_binutils_path(struct pe=
rf_env *env,
>                 path_list =3D arm_triplets;
>         else if (!strcmp(arch, "arm64"))
>                 path_list =3D arm64_triplets;
> +       else if (!strcmp(arch, "mips"))
> +               path_list =3D mips_triplets;
>         else if (!strcmp(arch, "powerpc"))
>                 path_list =3D powerpc_triplets;
> -       else if (!strcmp(arch, "sh"))
> -               path_list =3D sh_triplets;
> +       else if (!strcmp(arch, "riscv32"))
> +               path_list =3D riscv32_triplets;
> +       else if (!strcmp(arch, "riscv64"))
> +               path_list =3D riscv64_triplets;
>         else if (!strcmp(arch, "s390"))
> -               path_list =3D s390_triplets;
> +               path_list =3D s390_triplets;

whitespace issue?

> +       else if (!strcmp(arch, "sh"))
> +               path_list =3D sh_triplets;
>         else if (!strcmp(arch, "sparc"))
>                 path_list =3D sparc_triplets;
>         else if (!strcmp(arch, "x86"))
>                 path_list =3D x86_triplets;
> -       else if (!strcmp(arch, "mips"))
> -               path_list =3D mips_triplets;
>         else {
>                 ui__error("binutils for %s not supported.\n", arch);
>                 goto out_error;

I think in general we need to revamp this code. Two things that I see
that are missing are (1) support for perf config and (2) addr2line
should be configurable, you may want llvm-addr2line. Adding RISC-V is
of course important too :-)

Thanks,
Ian

> --
> 2.34.1
>
