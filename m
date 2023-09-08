Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735A7EE57CA
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Sep 2023 06:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbjIHGYF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 8 Sep 2023 02:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjIHGYE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Sep 2023 02:24:04 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE67019AE
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Sep 2023 23:23:59 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-414ba610766so208591cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Sep 2023 23:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694154239; x=1694759039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBd0PEKDa0GklZY+3jaMMJ9dni8AGLqK5Rg/U8MR1Nk=;
        b=XxxugHaHyCpPfOdNB7o23Fxr6uih9bGN0jcgHZJqaa54RS8y/mUK3Io1gLnY3nW5cq
         B46nF7iVJs6PlBgXSDfaQYLoKTWGBFo4a2U+AC7eloX9sPQRNZoJ9teDUqVsXylq+wGu
         xftz1j1Jm+h/KzAx12myRQfYRjXiK0TrSFoMm0kdCbXo6rX/8oPlAWzOp/Wb4oU/Mv5y
         rvGnI7FnCq/XMUK30Ln5AfE1mJ5qM2oLtKEJSjIv1R3c/Jl3UD00RZmMZGfjwiGfrS9h
         WRMgA2TXuaM9Y4TuTgIZPhEsGjoALWIxy+UKYHtvHbp6vDP1yUiSG9vYbS+ksMGu7FLE
         ZxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694154239; x=1694759039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBd0PEKDa0GklZY+3jaMMJ9dni8AGLqK5Rg/U8MR1Nk=;
        b=KFgHnUZBUnkMmEDTbTb9j3QI76dhY4DkT6kfs9eEqSyLGkaj110igRw+KmXQJrk68X
         nhb3JhMaILDE31v7gN0NEIGyLmmaXyBzG0iHdjKqZm3eA2FWM8zKz/BYCbpP20viuRIS
         LStqcb12ZuiRqoskLWkSTg5GOvjS462sIWtKTnXoMeAxUGSeki7tg1SSJkf/Cb/PnWry
         knZ+DnUWekeGYvakb7naWe81nbzDlEtvUxFInprUKrrPlV6KbusB43FwjXgepNoXGspV
         GoppbARxNHMncVwaWyzQfJ76xm4XGuz8qw9x5qrdT5fw9RXuPCvZr028KykqQNH5esY2
         SUIg==
X-Gm-Message-State: AOJu0YyJXTfv88CCm4XGGuoRQgHoiVwxv01tWWWioRFDR+AJNc4dSaI6
        sbJ+LcFUSVIWlFcqUb8wBpOPph3cxYb5hNyAPxZJDQ==
X-Google-Smtp-Source: AGHT+IEcYwEKNhzhb/oN2gICOT6FKzcOxeFWdr7HQvla5c8T0wJmYsDcsmPUMvIPR6VVA1RlVpe6FYtCFG1iDW+cXcE=
X-Received: by 2002:a05:622a:1315:b0:3ef:5f97:258f with SMTP id
 v21-20020a05622a131500b003ef5f97258fmr168200qtk.16.1694154238897; Thu, 07 Sep
 2023 23:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230908052216.566148-1-namhyung@kernel.org>
In-Reply-To: <20230908052216.566148-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 7 Sep 2023 23:23:46 -0700
Message-ID: <CAP-5=fUtEvW9h7N=w3vvYBB3vytnTXJsXrHDD6zLA2DzYFOBHQ@mail.gmail.com>
Subject: Re: [PATCH] perf annotate: Add more x86 mov instruction cases
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Sep 7, 2023 at 10:22=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Instructions with sign- and zero- extention like movsbl and movzwq were
> not handled properly.  As it can check different size suffix (-b, -w, -l
> or -q) we can omit that and add the common parts even though some
> combinations are not possible.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/arch/x86/annotate/instructions.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arc=
h/x86/annotate/instructions.c
> index 5f4ac4fc7fcf..5cdf457f5cbe 100644
> --- a/tools/perf/arch/x86/annotate/instructions.c
> +++ b/tools/perf/arch/x86/annotate/instructions.c
> @@ -74,12 +74,15 @@ static struct ins x86__instructions[] =3D {
>         { .name =3D "movdqa",     .ops =3D &mov_ops,  },
>         { .name =3D "movdqu",     .ops =3D &mov_ops,  },
>         { .name =3D "movsd",      .ops =3D &mov_ops,  },
> -       { .name =3D "movslq",     .ops =3D &mov_ops,  },
>         { .name =3D "movss",      .ops =3D &mov_ops,  },
> +       { .name =3D "movsb",      .ops =3D &mov_ops,  },
> +       { .name =3D "movsw",      .ops =3D &mov_ops,  },
> +       { .name =3D "movsl",      .ops =3D &mov_ops,  },

In Intel's manual some of these names are "Move Data From String to
String" operations, movsb and movsw in particular. These instructions
can be used to make simple memcpy loops. Could it be the past omission
was deliberate due to the different way the addressing works in the
instructions?

Thanks,
Ian

>         { .name =3D "movupd",     .ops =3D &mov_ops,  },
>         { .name =3D "movups",     .ops =3D &mov_ops,  },
> -       { .name =3D "movzbl",     .ops =3D &mov_ops,  },
> -       { .name =3D "movzwl",     .ops =3D &mov_ops,  },
> +       { .name =3D "movzb",      .ops =3D &mov_ops,  },
> +       { .name =3D "movzw",      .ops =3D &mov_ops,  },
> +       { .name =3D "movzl",      .ops =3D &mov_ops,  },
>         { .name =3D "mulsd",      .ops =3D &mov_ops,  },
>         { .name =3D "mulss",      .ops =3D &mov_ops,  },
>         { .name =3D "nop",        .ops =3D &nop_ops,  },
> --
> 2.42.0.283.g2d96d420d3-goog
>
