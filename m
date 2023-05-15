Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5499DC77B7D
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 May 2023 17:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243789AbjEORLN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 15 May 2023 13:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243536AbjEORKz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 May 2023 13:10:55 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9269ECF
        for <linux-perf-users@vger.kernel.org>; Mon, 15 May 2023 10:09:04 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3f51ea3a062so274801cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 May 2023 10:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684170544; x=1686762544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPSDCbAJaSJHqp9bvCCU6QEMLH8oL/k1JBrURKr01CE=;
        b=TB4BLtFI1tz91N9s2QNL8l0KaCb+S7VRtlq/WOORzRwH4RuLCH00uqSo1mhrgF3zfF
         8dbtPA3e+3sJlkD/s1KPx644TpVTxY7wEyF7bch8f/kWX8liFN/wUd/kQg7Ehm0egOcQ
         QwVuogBvMd135SPuF/uXDEa26KDaYIWLecbLrj6A2FQsvRdisHMCvVMXwvpcbemYTldg
         dbOYyd2jrAcRU48ZJtK3djZqQqOG9auOxgGVq40DvEOoFYBFJUwxwN9uwDEUjSbCpYx4
         fMY+TWtWPTr/Gw4h+bxqhZHsnpzqf3BqQBE06BmxkTFD9EoPajCPz9u6r5qlYY4Bs4V8
         zz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684170544; x=1686762544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPSDCbAJaSJHqp9bvCCU6QEMLH8oL/k1JBrURKr01CE=;
        b=lckrl81SkTV6bCNygB/glxoHwDUmy/RrKGGiIr63JgueJtDAoQadpkgFEoe2t22wLc
         MVoKAakFnsvw8hkhrt+FBQRYx4W9FDk2+o7rabrZ7AsJM0CFa+3hHKx7NWHQiGOg1fgB
         nayYdRVg2lvLMHYy9zpgA5Ucv9FKxAgZnt8y9axDRnTQrGy2eJL/gQp3oZ7BP5nrm0U/
         xESlNcy7uc1YSgV46Oo3UbIdFWV4SoK3UsWye7Rx7JrGGVHMTwc5rjtQuTYUnwxHFkPa
         VShbybtuvVFA0iwHFZ2gHWgGgZTB4X2MD4fS4LXeBgK8mKZyG2sxHzbrpPG4D9gj+IQ3
         FuSA==
X-Gm-Message-State: AC+VfDz3MKkMVDKrjEidxPB5lMqVLuREzZo41uMkbbNx3kSj5dwPst9m
        4ddt4OapNieYZBOwGurzk3s4QYU0WIesQI9Lv27Whw==
X-Google-Smtp-Source: ACHHUZ491wLC3fgfV4rR8SFXTsdq5f72NtZ8dZpUBE0OXEcvZwv6oasWjNY7EhIhJXtepD4g4dvgqGGijKITxwUXcGw=
X-Received: by 2002:a05:622a:1887:b0:3ed:210b:e698 with SMTP id
 v7-20020a05622a188700b003ed210be698mr1287918qtc.7.1684170543955; Mon, 15 May
 2023 10:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230511062725.514752-1-namhyung@kernel.org> <20230511062725.514752-2-namhyung@kernel.org>
In-Reply-To: <20230511062725.514752-2-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 15 May 2023 10:08:52 -0700
Message-ID: <CAP-5=fX8N4JRseytuACXMZF7Gw8Uu15kBg7dXN2iZZg0_nG-Sg@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf annotate: Parse x86 SIB addressing properly
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, May 10, 2023 at 11:27=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> When the source argument of mov instruction is look like below, it didn't
> parse the whole operand and just stopped at the first comma.
>
>   mov    (%rbx,%rax,1),%rcx
>
> Fix it by checking the parentheses and move it to the closing one.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/annotate.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index ca9f0add68f4..6053ddf9c32d 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -550,6 +550,19 @@ static int mov__parse(struct arch *arch, struct ins_=
operands *ops, struct map_sy
>                 return -1;
>
>         *s =3D '\0';
> +
> +       /*
> +        * x86 SIB addressing has something like 0x8(%rax, %rcx, 1)
> +        * then it needs to have the closing parenthesis.
> +        */
> +       if (strchr(ops->raw, '(')) {
> +               *s =3D ',';
> +               s =3D strchr(ops->raw, ')');
> +               if (s =3D=3D NULL || s[1] !=3D ',')
> +                       return -1;
> +               *++s =3D '\0';
> +       }
> +
>         ops->source.raw =3D strdup(ops->raw);
>         *s =3D ',';
>
> --
> 2.40.1.521.gf1e218fcd8-goog
>
