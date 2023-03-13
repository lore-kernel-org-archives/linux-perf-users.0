Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8195C6FD19
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Mar 2023 16:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjCMQ2V (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Mar 2023 12:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjCMQ2S (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Mar 2023 12:28:18 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A8379B19
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 09:27:49 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id b5so5253767iow.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 09:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678724869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uThRQ+LYc3DxfsAWXC/vPY+ugCmlfaobHQqFrI5rVyg=;
        b=NFGoQpB+8ib1in+s3af9+VB5yHzj2lDnrovQryBfGVP20pUWWtnKKxx44SWm1H9AKa
         fEDpW3umOBDmokjGyYFPMY5BCFp92bfWs9M5XPbAkjg3dQMYeebXkgWZ4YZOwzZU34Uq
         ok+LIfx2YxHbOVRr4Lg5ISUDFzCc58eW8u4G7UuO5J6aNofv8fx1XC+J51YUq1TbQIvX
         E1mhWadnuPOyqhspB8PwpTnW8oqazvPkAH8Mx59d17OBalBwPA9slh5bIKSSLe6IsrwJ
         +d80Q1hJFaYV6W4g97QxWuUh/86LlP+XbWsBmme0M3UXaMvB3abypA4/PHpV6eShNfV6
         aCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678724869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uThRQ+LYc3DxfsAWXC/vPY+ugCmlfaobHQqFrI5rVyg=;
        b=nOt0NwjBU21ivdLNdhINMY3ue+8hs+VHBfpWWO/i++XJv8GF9TpEnL7NStQJumrzl0
         XpK6qtjZY+QT7PlIKISW6685tPe2JmFncUEc4CrRIZJloFbyATDKHcujqWQjMpp/PoOp
         Mi9U1C5sNgnVAvOJho4MRXI+5I24/jBtlgABUKQPgEKkWIA5JvxkfLCo/8hhM+8+vs7U
         Ry+iqExJMcmsObhTcWJXuDMj5JUfgp7k+o2xoaC9i/w14gM33PoqO937G458roZgVgMc
         bd/LfHfURQr4N6vj3KQ1TSm43z8DeWJ0+mMtvPhEQwQLijGJZg65eU23UJRJNWKmZvY2
         aevg==
X-Gm-Message-State: AO0yUKVs3bS3o7AcXIc+zEHqJaoM1tHkoxUoZftIKbfnDNyEveeZipKG
        Ja0jk+L8eRJGXo44zOD2S6UjuiIS9ELngeWvb/p8cw7C2GDn7aKCzsUXOg==
X-Google-Smtp-Source: AK7set+7EtFwe6HXEKJ1Gf+hvJUXct2FYTqYMvd+TWTbl75XQSf6BtdH8inJGp4bsSLQOwWWrvIZaQr2rvAzxm9CdDw=
X-Received: by 2002:a5d:8b47:0:b0:745:c41a:8f0f with SMTP id
 c7-20020a5d8b47000000b00745c41a8f0fmr16695129iot.2.1678724867424; Mon, 13 Mar
 2023 09:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230311112122.28894-1-p4ranlee@gmail.com> <CAP-5=fWkAqX+Uy_XhXHjEx6sj-wpOJ+WQf=vMtRzRBS-0Kj32Q@mail.gmail.com>
 <09d44d74-f3c9-cf99-8d14-74499485e956@gmail.com>
In-Reply-To: <09d44d74-f3c9-cf99-8d14-74499485e956@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 13 Mar 2023 09:27:35 -0700
Message-ID: <CAP-5=fUqLdCD_Ks2WQxjyRoNO53PxzDv_P7GJuY320+gKF=vEw@mail.gmail.com>
Subject: Re: [PATCH] perf tools riscv: Add support for riscv lookup_binutils_path
To:     Paran Lee <p4ranlee@gmail.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Mar 12, 2023 at 5:53=E2=80=AFAM Paran Lee <p4ranlee@gmail.com> wrot=
e:
>
>
>
> 23. 3. 12. 15:27=EC=97=90 Ian Rogers =EC=9D=B4(=EA=B0=80) =EC=93=B4 =EA=
=B8=80:
> > On Sat, Mar 11, 2023 at 3:22=E2=80=AFAM paranlee <p4ranlee@gmail.com> w=
rote:
> >>
> >> Add to know RISC-V binutils path.
> >> Secondarily, edit the code block with alphabetical order.
> >>
> >> Signed-off-by: Paran Lee <p4ranlee@gmail.com>
> >> ---
> >>  tools/perf/arch/common.c | 51 +++++++++++++++++++++++++++------------=
-
> >>  1 file changed, 35 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
> >> index 59dd875fd5e4..058527ededdd 100644
> >> --- a/tools/perf/arch/common.c
> >> +++ b/tools/perf/arch/common.c
> >> @@ -29,11 +29,23 @@ const char *const arm_triplets[] =3D {
> >>  };
> >>
> >>  const char *const arm64_triplets[] =3D {
> >> +       "aarch64-unknown-linux-",
> >
> > Modifying ARM64 behavior should be a separate change.
> >
> >>         "aarch64-linux-android-",
> >>         "aarch64-linux-gnu-",
> >>         NULL
> >>  };
> >>
> >> +const char *const mips_triplets[] =3D {
> >> +       "mips-unknown-linux-gnu-",
> >> +       "mipsel-linux-android-",
> >> +       "mips-linux-gnu-",
> >> +       "mips64-linux-gnu-",
> >> +       "mips64el-linux-gnuabi64-",
> >> +       "mips64-linux-gnuabi64-",
> >> +       "mipsel-linux-gnu-",
> >> +       NULL
> >> +};
> >> +
> >
> > This will affect the blame history. It should probably be its own chang=
e too.
>
> Thank you for review! I agree. So I would split the patch.
>
> >> -
> >>  static bool lookup_path(char *name)
> >>  {
> >>         bool found =3D false;
> >> @@ -164,18 +179,22 @@ static int perf_env__lookup_binutils_path(struct=
 perf_env *env,
> >>                 path_list =3D arm_triplets;
> >>         else if (!strcmp(arch, "arm64"))
> >>                 path_list =3D arm64_triplets;
> >> +       else if (!strcmp(arch, "mips"))
> >> +               path_list =3D mips_triplets;
> >>         else if (!strcmp(arch, "powerpc"))
> >>                 path_list =3D powerpc_triplets;
> >> -       else if (!strcmp(arch, "sh"))
> >> -               path_list =3D sh_triplets;
> >> +       else if (!strcmp(arch, "riscv32"))
> >> +               path_list =3D riscv32_triplets;
> >> +       else if (!strcmp(arch, "riscv64"))
> >> +               path_list =3D riscv64_triplets;
> >>         else if (!strcmp(arch, "s390"))
> >> -               path_list =3D s390_triplets;
> >> +               path_list =3D s390_triplets;
> >
> > whitespace issue?
>
> I tried to correct the alphabetical order because it was vaguely sorted.
> And I'll try to work on blame history on each arch code block as well.
>
> >> +       else if (!strcmp(arch, "sh"))
> >> +               path_list =3D sh_triplets;
> >>         else if (!strcmp(arch, "sparc"))
> >>                 path_list =3D sparc_triplets;
> >>         else if (!strcmp(arch, "x86"))
> >>                 path_list =3D x86_triplets;
> >> -       else if (!strcmp(arch, "mips"))
> >> -               path_list =3D mips_triplets;
> >>         else {
> >>                 ui__error("binutils for %s not supported.\n", arch);
> >>                 goto out_error;
> >
> > I think in general we need to revamp this code. Two things that I see
> > that are missing are (1) support for perf config and (2) addr2line
> > should be configurable, you may want llvm-addr2line. Adding RISC-V is
> > of course important too :-)
> >
> > Thanks,
> > Ian
>
> May I ask documentation or hint that I can help work with?
>
> P.S.
>
> I'm interested in the Google Summer Of code perf category this year,
> especially the part about risc-v architecture, I recently purchased a
> development board and would like to be able to test perf on a Sifive U74
> CPU based environment.
> But I've only used perf with command tool and don't know much about the
> internals, so if there is a roadmap for perf development or
> contribution, I have interest in perf internals both kernel and user side=
.
> May I ask information to apply?
> I am developing Linux Security Driver drivers for a security company.
>
> BR
> Paran Lee

Hi Paran,

Thanks for being interested in GSoC with Linux perf. Here is what I
posted on the mailing list:
https://lore.kernel.org/linux-perf-users/CAP-5=3DfWxF6in4vQyGuh=3D0kpAYEXAY=
ZN_KobXCY=3DTX2oxssZ+HQ@mail.gmail.com/
Applications are ultimately sent to:
https://summerofcode.withgoogle.com/
and the entry requirements are there. I believe they are less strict
than previously.

Wrt the patch, could you reply to Conor's response.

Thanks,
Ian
