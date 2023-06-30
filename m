Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52F8EB64DA
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jun 2023 16:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjF3QEO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jun 2023 12:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjF3QEM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jun 2023 12:04:12 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BF73C0A
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 09:04:11 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-401f4408955so266051cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 09:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688141050; x=1690733050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72aZQhoXa0Ea0UAlKIsGIZ+Gu11zrKiWVCMDasipILY=;
        b=Pf6lIriWxgTkJGWPPDZ2wR05EJ+WqqHCHIHLDQFM+hMo7jmbD13uhPF73BaApquSY0
         /u7JE4VJk/tZhlgi/x4c/lrVlF7y5jE1vq8fA1VMMHZu1pHnRVHJUyT36qEzIEEedwiH
         gyqF8bk9JxLcAU/RT/2lFotT/Vl5yKxll+Ifys4srfAeks6xWiZH0KzPzSrKPJ+cRpxb
         FOO4zwaB3LM27IB/pRm185jzh43+TodqYeWoUtvBZCQ2ZtoNEipY8kx6YC9UJVkp2RQs
         79i9io3k+pyZ9gFm6MGC/dHXaA3o63CFHb64W9ZdOLbbevxz57Wtj1Bl15vZAXw+B+ld
         vCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688141050; x=1690733050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72aZQhoXa0Ea0UAlKIsGIZ+Gu11zrKiWVCMDasipILY=;
        b=gToWUnx5u9oCoREwUI8pm+7jscklZLO8bESbfubhOHmPgBJwAnKFOAnh4jm1jOIKFp
         U0/2jOTJF2RQ5jFJ5EcGUMp9TukXCzxZ9b+smx1+9jnKs9tVVygMsqI2y9ZJb4Az5Big
         zexZ2/qBBMLGqRx7oV4wyNGbGd6lDOvvHTndnGCJK/W6e6+QoZUfzKoRNqLXzzcjOr2t
         PFmWbGSEKDyn4TXgY+l5cZGqMJ+ugWeFwElIVWrrY15LPhvOBMKqJnJl0QRSrMCzWcDE
         XAKE97b8LFcxYCSBN5JJz9TVm2cZTmwgL/VFdIdU85FNAsXNixMQawqfEW11quoqJYPk
         yjmQ==
X-Gm-Message-State: AC+VfDw027jGO6srP7+il9GC1GjSlCoqqwdm1iAnsujKprqxUXJ5nEzw
        myWTF3UhJrpdtqKlcdnma+7bDL6SbMcYsNptgzPpJQ==
X-Google-Smtp-Source: ACHHUZ77csaA2FJyIaaxmbTlQnC2Qg88NjTlVxNKtDv38LdjGU/QpfVG03pPSI/QsBH1SobPqZksNWcOqRhBEwEpA54=
X-Received: by 2002:a05:622a:9:b0:3f8:1db6:201c with SMTP id
 x9-20020a05622a000900b003f81db6201cmr697347qtw.13.1688141050301; Fri, 30 Jun
 2023 09:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230628200141.2739587-1-namhyung@kernel.org> <20230628200141.2739587-2-namhyung@kernel.org>
In-Reply-To: <20230628200141.2739587-2-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 30 Jun 2023 09:03:59 -0700
Message-ID: <CAP-5=fWvmR0dXftqRpZC3cZXV84rHuW0iz2yzOZmCn5iR11Wyw@mail.gmail.com>
Subject: Re: [PATCH 1/4] perf lock: Remove stale comments
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 28, 2023 at 1:01=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The comment was for symbol_conf.sort_by_name which was deleted already.
> Let's get rid of the stale comments as well.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-lock.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index da36ace66d68..187efb651436 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -1773,7 +1773,6 @@ static int __cmd_report(bool display_info)
>                 return PTR_ERR(session);
>         }
>
> -       /* for lock function check */
>         symbol_conf.allow_aliases =3D true;
>         symbol__init(&session->header.env);
>
> @@ -1902,7 +1901,6 @@ static int __cmd_contention(int argc, const char **=
argv)
>         if (con.aggr_mode =3D=3D LOCK_AGGR_CALLER)
>                 con.save_callstack =3D true;
>
> -       /* for lock function check */
>         symbol_conf.allow_aliases =3D true;
>         symbol__init(&session->header.env);
>
> --
> 2.41.0.255.g8b1d071c50-goog
>
