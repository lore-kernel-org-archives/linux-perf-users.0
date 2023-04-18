Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC41C77B7E
	for <linux-perf-users@archiver.kernel.org>; Tue, 18 Apr 2023 18:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjDRSE4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 18 Apr 2023 14:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbjDRSEz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 18 Apr 2023 14:04:55 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EE740EE
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Apr 2023 11:04:51 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f048b144eeso67575e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Apr 2023 11:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681841090; x=1684433090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVo7ErolbBsB3vbOoqmPHuRczZ4pjL/sGStpYzTmAxM=;
        b=ZU5RGYlhPrrm3RUw1BAJD4ultlC7dOla6Lr/381b9LpQqBWglBq0ppKxwlU9+VwW2M
         msjDDhP3G6FP/MJDlvw9WHNWoycAFQEK1CG2E+AxoRClYltCV0ke/P6Mp/bSZ9tg8sVf
         s7kFlG7VZVRqpnP1CauObtccey3KhAJUwE/IlnQwXPdVJ8Rfwhx2WcvDSo8I7XBf2c+E
         3FDWG6WCqT/xBrYcz57O2Unf215gtdpwlDaCTpY//bSDI82W9wr8KLyVA3XBzdIDYuJC
         AQX0LuH73IcR+OEC9L+kBCdnN2DFePLw18BAbA+0j5sWsfiJiZvQokxB5ziUnLfkEX+f
         Bm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681841090; x=1684433090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVo7ErolbBsB3vbOoqmPHuRczZ4pjL/sGStpYzTmAxM=;
        b=luAwfcGKBKmUHVAw/MLnOD8WZ9AVzXS7l04ovjoUUpQ4DPRDkuDed1wlM3ZYgClqDQ
         02PuT2AZTh4uqvOdjuFBYstph0rhZMaeEGsbG7DHNeWW3E83KNTDLehN5fY27h4fsGPy
         kJOXhHv3AOSVsaq7a0/DVKzsHGPgW8SXkYbY+8rqEQK1INRUHVnSdHfxJ/FDFCiI4pNc
         +1HqpJXUALDhkhrEaCNHk+dc3W9tWMYR07nRvmADGXb55e2EYdddkLOUH6uu4RrGLxLA
         cUDfOkGXjN0GM9FlKF4izcVFA/x2tJ9I840B2a+0mxy0kTENUqrSCnC1O6ur+nBAx9/d
         r9PA==
X-Gm-Message-State: AAQBX9eb3KuMHCX0hTrIO6Klt4gc+whlTM0+XzbcUgR0+gbDpEva4PoO
        AfmXe449w3tf+mLoxAnaMQoKo5ApaXd+OsESz0RZJQ==
X-Google-Smtp-Source: AKy350a2qGvbYaY2rIFNyUnYbU0oiNOCuTWBN2WMAQLltFtgZZpkczBs4IU4AxO4IcKD/c5XRH1zdF6YZte2RTXgYl8=
X-Received: by 2002:a05:600c:3c97:b0:3f1:73b8:b5fe with SMTP id
 bg23-20020a05600c3c9700b003f173b8b5femr7640wmb.3.1681841089846; Tue, 18 Apr
 2023 11:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230417122943.2155502-1-anders.roxell@linaro.org>
 <20230417122943.2155502-2-anders.roxell@linaro.org> <CAP-5=fWUevSnyn5MtVO1p6cEVE8MvBTq4Qgth7RcPYueRERQKA@mail.gmail.com>
 <d940f802-8aab-140d-7a87-9cf0b3a8ac9f@isovalent.com>
In-Reply-To: <d940f802-8aab-140d-7a87-9cf0b3a8ac9f@isovalent.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 18 Apr 2023 11:04:35 -0700
Message-ID: <CAP-5=fVh=zNuwcQM++KFxt6ETv-Z6GpY9pWDQ=RbvnuSGUhT8g@mail.gmail.com>
Subject: Re: [backport PATCH 1/2] tools perf: Fix compilation error with new binutils
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>, stable@vger.kernel.org,
        acme@redhat.com, andres@anarazel.de, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Ben Hutchings <benh@debian.org>, Jiri Olsa <jolsa@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Apr 18, 2023 at 9:43=E2=80=AFAM Quentin Monnet <quentin@isovalent.c=
om> wrote:
>
> 2023-04-17 10:14 UTC-0700 ~ Ian Rogers <irogers@google.com>
> > On Mon, Apr 17, 2023 at 5:30=E2=80=AFAM Anders Roxell <anders.roxell@li=
naro.org> wrote:
> >>
> >> From: Andres Freund <andres@anarazel.de>
> >>
> >> binutils changed the signature of init_disassemble_info(), which now c=
auses
> >> compilation failures for tools/perf/util/annotate.c, e.g. on debian
> >> unstable.
> >
> > Thanks, I believe the compilation issue may well be resolved by:
> > https://lore.kernel.org/lkml/20230311065753.3012826-8-irogers@google.co=
m/
> > where binutils is made opt-in rather than opt-out.
>
> Hi,
> These commits are to make it possible to build against recent binutils,
> without having to leave it out at compile time, so as I understand they
> address a different issue?

Kind of. We don't want the Linux perf build to break. Previously if
binutils were installed then Linux perf would default to linking with
it and break your build were binutils to change its API. That is no
longer the case as we don't default to linking against binutils. This
was motivated by distributions not being able to link Linux perf with
binutils due to the license incompatibilities. I don't see a problem
supporting linking against newer and older binutils if people want to
on non-distributed binaries. We'll probably need more build
tests/containers to cover the possibilities of this. I'm not sure
what's motivating binutils support other than personal experimentation
though.

Thanks,
Ian


> >
> >> Relevant binutils commit:
> >>
> >>   https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommit;h=3D60a3=
da00bd5407f07
> >>
> >> Wire up the feature test and switch to init_disassemble_info_compat(),
> >> which were introduced in prior commits, fixing the compilation failure=
.
> >
> > I was kind of surprised to see no version check ifdef. Is
> > init_disassemble_info_compat is supported in older binutils?
>
> It is not part of binutils, it was introduced in commit a45b3d692623
> ("tools include: add dis-asm-compat.h to handle version differences"),
> which should likely be backported alongside these ones if it hasn't been
> already. Possibly the others from the same series [0], as well?
>
> I think all 5 patches from Andres' series were backported to 5.15 [1].
>
> [0]
> https://lore.kernel.org/all/20220703212551.1114923-1-andres@anarazel.de/t=
/#m999a44663894e235b523ffc41ce87e956019ea72
> [1]
> https://lore.kernel.org/all/e6e2df31-6327-f2ad-3049-0cbfa214ae5c@hauke-m.=
de/t/#u
>
> Best regards,
> Quentin
