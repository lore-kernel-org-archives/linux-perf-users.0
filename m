Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A308AC6FD1D
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Mar 2023 00:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjCPAL6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 15 Mar 2023 20:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbjCPAL4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Mar 2023 20:11:56 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6706B32CE7
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Mar 2023 17:11:55 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id r4so125887ila.2
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Mar 2023 17:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678925515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6A4+6WNZrg0XE9F8HhNkuyqp/9CoWfXobBlodcYCH9M=;
        b=ap8M5WVhaHadtY35pgDPiuTL1iT97fh3CCDvrGknj7w0ooU+SFohasJWs6qoRpYo+E
         9U4ShDKBucbUUoAXtNnCPBor6lifNAt9z+kLGBba4yVhJridSKPdnPIpWUekDG869P9e
         aJeBnzY1UkLPkeLdH53Ei5iwwfFhpmALvitV7GojqE5l4aELOpVpVRil9Z32C1gipBAY
         9WBMyIK1eEawYEG5sa6eLvBtF0feZC+2qdLd7SNOqlcs7sb732ls4d2KvBMd7KpFYq0N
         dLMdJpDYI53rgwJH/0mM9+iTrpFZQqo8Lgkcvdoihw5NfOPaZvYJnGwLG1GgVYcdwa1r
         ETOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678925515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6A4+6WNZrg0XE9F8HhNkuyqp/9CoWfXobBlodcYCH9M=;
        b=MrNB/RnBXW9zPPK4c6uzuKrrEmnzPA/9wAm6aXdUOswTBR1j7HNGl4RHgdJNw9hktK
         DGDqH2DKKGc1XKefG3QRWusdkpzvTbBXwMC0kFb9GTvWQmQk+GSRQfmteJvRxKd6xoeA
         u3CplHhgiiWd+hKNrxf6AZGNSm6+DMyLviDF6DmHF1DHkH7kzuE1k5KGOYWfYSN+NpvB
         2DfJM2xm/Fy6ONdQZtiFpgthOszsWUEMCLRr/WzeJDI8QbzfetNvLR+lO/UYwzcNCfS7
         DwYb5mkTx0NQ4ugJkyvm9ikPaNC57bsdJkkvzmpSi4vGK/esDhnJtSbk9yPwKhgn5Vjt
         qacQ==
X-Gm-Message-State: AO0yUKUGyv5fdFb7G0tOpIqzbZ+d8U1BFYmpmfJVL5oOD/TykFPeeJj+
        RBCyGgxLoJclZbw7kVHLr5QcQbexg3xCsDKfYXOVyQ==
X-Google-Smtp-Source: AK7set+A7BBRiTsFnL6nlX8eXSdT6HCEPYPWdoxP1z5nNV20cC7pviZfNP1E0fjsqMumMBseGhZMTD0Gi3RNQSq18Hs=
X-Received: by 2002:a05:6e02:1c89:b0:322:f3fb:6c45 with SMTP id
 w9-20020a056e021c8900b00322f3fb6c45mr71590ill.16.1678925514522; Wed, 15 Mar
 2023 17:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230315051500.13064-1-p4ranlee@gmail.com>
In-Reply-To: <20230315051500.13064-1-p4ranlee@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 15 Mar 2023 17:11:41 -0700
Message-ID: <CAP-5=fUsgxM5H0T9kDyLra=0UMHXRqvYNeYcLeKr7ruc74vq-A@mail.gmail.com>
Subject: Re: [PATCH v2] perf tools riscv: Add support for riscv lookup_binutils_path
To:     Paran Lee <p4ranlee@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
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

On Tue, Mar 14, 2023 at 10:15=E2=80=AFPM Paran Lee <p4ranlee@gmail.com> wro=
te:
>
> Add RISC-V binutils path on lookup triplets.
>
> Signed-off-by: Paran Lee <p4ranlee@gmail.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/arch/common.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
> index 59dd875fd5e4..e80d4d22cabf 100644
> --- a/tools/perf/arch/common.c
> +++ b/tools/perf/arch/common.c
> @@ -43,6 +43,20 @@ const char *const powerpc_triplets[] =3D {
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
> @@ -166,6 +180,10 @@ static int perf_env__lookup_binutils_path(struct per=
f_env *env,
>                 path_list =3D arm64_triplets;
>         else if (!strcmp(arch, "powerpc"))
>                 path_list =3D powerpc_triplets;
> +       else if (!strcmp(arch, "riscv32"))
> +               path_list =3D riscv32_triplets;
> +       else if (!strcmp(arch, "riscv64"))
> +               path_list =3D riscv64_triplets;
>         else if (!strcmp(arch, "sh"))
>                 path_list =3D sh_triplets;
>         else if (!strcmp(arch, "s390"))
> --
> 2.34.1
>
