Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24B4C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Dec 2021 17:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbhLHRhB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 8 Dec 2021 12:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235099AbhLHRhA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Dec 2021 12:37:00 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F98C061746
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Dec 2021 09:33:28 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id z26so3588599iod.10
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Dec 2021 09:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zxdzBmou0nMLZSQ2PL0SgOvX3HihWUA9tdvfGZKATKc=;
        b=oGDjeNeX/ROucVuS1Pi3hZRldbTmAltKAYC+CcJD4Kcw5Mbxx/EOtfpOHG7bzx08R7
         1efeuZ50iJ3WKMirDadM/dpavNJBDC8CXIUQ1k63dNtyIuVNoZoYGYRkYQhxdlx7MZQd
         uyU70jRnMsvAnsCS4rsw3x/pQ7eHx/2fDJK0ZxH5nT74u0RkJoYfAwZCWSC4B10p1oNV
         oQRFyRomW8GM3tH7Iq0oFFo5N2uojb3dW1tbbPLfj+UdWjNCqA/dxmC7nGioHTmWLGpm
         gBXdNHwdDb3sNaMRl+NQR1V3p2OW2y2ivta4aUzJX+7E8pxuCp4lWMSup6eX0o6WdPRR
         SWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zxdzBmou0nMLZSQ2PL0SgOvX3HihWUA9tdvfGZKATKc=;
        b=GMZ/XG55tAhRI9iByrs4XIfrpHNtgTIL7zrjuj8LWbpHKhHwyMLg0vlLkuAYELwxsc
         7OsBXDWLqJV8tpks9bMikc3oo375+IFAPLU3f3TwG4S87IsGHQke5DeCu1ds0yQybXc8
         50Hja0rcDF6JCzpfG66EoajHgvaPiS+1pXVnOzNuieFs0yqe30JHAVFx5AqEoSvBeX/0
         ylD/dCflnB5zV8F5xuaT/EuPJTc/+PN2J5DBnCAxF0PdFsrvsdQXXr3+/SH1y9FpDfgI
         nYxiUV4q7wTUF6OlmGIJ5lXpX3schNQF99nIQXpP+VE8zLSycZX34NAfwyrBipX3OmXM
         dydA==
X-Gm-Message-State: AOAM53330Sje1QyJ9EUCvk8TItxudXk8gDHWT5Uk0Ek2/oGDBmPpD72L
        eqy1Snc1XvJBjKZaJ4E0RCqT29cdIxP/tOf+5Fqzag==
X-Google-Smtp-Source: ABdhPJwe0qsnrzEWY99rw92Dl247nO1g2aRfUQwFhLyufv0QQue7HHBTiLV5eGIadgi8buDTppvdOQnr73G4QW/kQOE=
X-Received: by 2002:a6b:b886:: with SMTP id i128mr8802035iof.151.1638984807851;
 Wed, 08 Dec 2021 09:33:27 -0800 (PST)
MIME-Version: 1.0
References: <20211208171113.22089-1-jose.exposito89@gmail.com>
In-Reply-To: <20211208171113.22089-1-jose.exposito89@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 8 Dec 2021 09:33:14 -0800
Message-ID: <CAP-5=fUAR9uSAQGkukqafkoX+jz1fE8f-ziU5WeG59XT53jMWw@mail.gmail.com>
Subject: Re: [PATCH] perf util: Fix use after free in metric__new
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        john.garry@huawei.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Dec 8, 2021 at 9:11 AM Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gma=
il.com> wrote:
>
> Addresses-Coverity-ID: 1494000
> Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>

Acked-by: Ian Rogers <irogers@google,com>

This can only happen in the ENOMEM case, but it is a good fix.

Fixes: b85a4d61d302 (perf metric: Allow modifiers on metrics)

Thanks,
Ian

> ---
>  tools/perf/util/metricgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index fffe02aae3ed..4d2fed3aefd1 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -209,8 +209,8 @@ static struct metric *metric__new(const struct pmu_ev=
ent *pe,
>         m->metric_name =3D pe->metric_name;
>         m->modifier =3D modifier ? strdup(modifier) : NULL;
>         if (modifier && !m->modifier) {
> -               free(m);
>                 expr__ctx_free(m->pctx);
> +               free(m);
>                 return NULL;
>         }
>         m->metric_expr =3D pe->metric_expr;
> --
> 2.25.1
>
