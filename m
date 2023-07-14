Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45E8C001DE
	for <linux-perf-users@archiver.kernel.org>; Fri, 14 Jul 2023 08:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbjGNIvP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 14 Jul 2023 04:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbjGNIvP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 14 Jul 2023 04:51:15 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F36E2701
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Jul 2023 01:51:13 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b703c900e3so24844871fa.1
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Jul 2023 01:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1689324671; x=1691916671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVJFUGPgUiZjejGogHmLzYwwKGbHbhdGEjYSUHSjBfo=;
        b=pYAcX4FPQitZnsDIm6cTcKdm1Ztraq4W2bv6eu94SIYUTBpXculUzJiLK05nDzIZQY
         X+ajUMzJ4+s3GZVMczZKydx+tBqLXWPIIcNeeaSKxDbOIpV+juiQrp9N9A7oMFbOy0ej
         Bev1FExTBu9b0hpfG/pxEJkztwcOKTfi7ojBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689324671; x=1691916671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVJFUGPgUiZjejGogHmLzYwwKGbHbhdGEjYSUHSjBfo=;
        b=XkMzjMJU+8AHti+Kvu3uupJZLasx43vt2C/rnAUjVOlpHmBSQf+ZUXuWTKUIXZg/NJ
         agMF2M1j4XTOFSdq+s0tnhO9vE8YA8IVVtpEYv71t7ofVUrOEKN9JK+mbWAqdFN7lvhU
         JsQh1t/WExz5jHXlF+iwKmqkMmnCWypvEiSt6fDTsrEGOcoyZOO4wZ2Bs+xqfTLAe71E
         xQ2JvLgv3r22GQmBpZl6NZlzP281FThgrLFVOHHc3Gs+kX4aTTPayxd+uanrORqKNc6V
         BiCxCKfsXfWA1StULtr5+JKgCgXaclMoimIfF/0t3QFk0hFXsqDgAzNud5/Uif8dVyCa
         8ryg==
X-Gm-Message-State: ABy/qLbVnjhh4JVrTMxPKn1J8qF1Ze8bQq4OS3UszHdytZxD8s/U1xbF
        bkrAyoWu9fETebEsQJ/tN+RAM6PPeAoMVxSQ1gLL
X-Google-Smtp-Source: APBJJlHjR6JsuaMQbXZar+lmwIZWlDiqDI6I9i3Y4OuSMcqQfvuZ6VyIJunOF1Ue2HAQ0kQfJSL6fyyKFEWspQicjTo=
X-Received: by 2002:a2e:8611:0:b0:2b6:ee1c:216a with SMTP id
 a17-20020a2e8611000000b002b6ee1c216amr3436379lji.34.1689324671023; Fri, 14
 Jul 2023 01:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230703124647.215952-1-alexghiti@rivosinc.com> <20230703124647.215952-9-alexghiti@rivosinc.com>
In-Reply-To: <20230703124647.215952-9-alexghiti@rivosinc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 14 Jul 2023 01:50:59 -0700
Message-ID: <CAOnJCUJGHWicrhGOGPK_aduaD9jXz7THHcbU+i+7tK-ChtQxNg@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] Documentation: admin-guide: Add riscv sysctl_perf_user_access
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jul 3, 2023 at 5:54=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc.=
com> wrote:
>
> riscv now uses this sysctl so document its usage for this architecture.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 27 ++++++++++++++++++---
>  1 file changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/=
admin-guide/sysctl/kernel.rst
> index d85d90f5d000..19b627883313 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -941,16 +941,35 @@ enabled, otherwise writing to this file will return=
 ``-EBUSY``.
>  The default value is 8.
>
>
> -perf_user_access (arm64 only)
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +perf_user_access (arm64 and riscv only)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Controls user space access for reading perf event counters.
>
> -Controls user space access for reading perf event counters. When set to =
1,
> -user space can read performance monitor counter registers directly.
> +arm64
> +=3D=3D=3D=3D=3D
>
>  The default value is 0 (access disabled).
>
> +When set to 1, user space can read performance monitor counter registers
> +directly.
> +

For ARM64, 1 also enables reading performance counters via perf interface o=
nly.
I don't think there is any way to access the counters directly in ARM64.

>  See Documentation/arm64/perf.rst for more information.
>
> +riscv
> +=3D=3D=3D=3D=3D
> +
> +When set to 0, user space access is disabled.
> +
> +The default value is 1, user space can read performance monitor counter
> +registers through perf, any direct access without perf intervention will=
 trigger
> +an illegal instruction.
> +
> +When set to 2, which enables legacy mode (user space has direct access t=
o cycle
> +and insret CSRs only). Note that this legacy value is deprecated and wil=
l be
> +removed once all user space applications are fixed.
> +
> +Note that the time CSR is always directly accessible to all modes.
>
>  pid_max
>  =3D=3D=3D=3D=3D=3D=3D
> --
> 2.39.2
>


--=20
Regards,
Atish
