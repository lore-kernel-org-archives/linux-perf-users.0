Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB16EB64DA
	for <linux-perf-users@archiver.kernel.org>; Thu, 20 Jul 2023 04:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjGTEdL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 20 Jul 2023 00:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGTEdK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 20 Jul 2023 00:33:10 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A201985
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Jul 2023 21:33:09 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-401d1d967beso184021cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Jul 2023 21:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689827589; x=1692419589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2Wv2sXy6dPs6y1IoEF3FQ9f1Jy0jfZNRNNhi4fWntI=;
        b=JMMTrSfiyjx7CON1Qej5uXP27SMvtJ0VVcu7XUROw4D3rwADg2hKHrftk0wLx082Vu
         1TXTFGZoTaBb5lW09UjKdU+FRddJ2qboVf1kv3D959FKiUHIQ4ia4mIDaym+bNclOiVt
         TVIEx6UUJNvJ3sG8tBxev2Cgsi79ym0GxYCB3CYYWoKVIrrp9jHDIdc7OUFZu/qk/WKp
         3qlp8+x7EEkjmPdNpd4gPjO18z8OBeUc2O3xdmS2Me6/0a/gu9VYX0Dy689Cz3g0baLw
         pBxsHZZA9BFpRwIg12BJRCJe15vmKmmde0xgDNCPtE1G/Ju47OzBDPDoioJHWzxzYA/i
         duYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689827589; x=1692419589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2Wv2sXy6dPs6y1IoEF3FQ9f1Jy0jfZNRNNhi4fWntI=;
        b=XvyxibE0s/fWHDEbvmwaksps2I+pZBsXYoCyTfL2Rwq+Khmaa64ZAmwxTvecsyBr5a
         yWxKi2qTOUfpetgqiLkswJ8IOWw+XAayCx9gdL3NUzabPpzgxzmOivpnH0XyBkumEbsz
         spt9NOkMcvdjQlsaBtzj3nkQyoFJ5PDvcLzJL5UDsNmdX3ZA1eCJLpclsM03nFOu4ZbO
         6tpBHMFvsj792BTfyy6X8qKv3ALVLb1opXxI6D/rRoFYg/HVRw05YrU8QXqsJ0DTYME/
         o3o1Hlf2PFrX8Btmrf7Cg3uWIxkj85GTq0z86tBkiOOxN4HwN4h5B87R+VtjXr0LCgAh
         fuSQ==
X-Gm-Message-State: ABy/qLYigC41l8BfmxYjlbYtwQh/n2KpB49XuCb/GMvTUmDr5FZnfubU
        FCllDnvgusrZjmThvX9uzo7Pr3ZWZeuq/p/x9C51d7RfvsoVElh1mY894eCB
X-Google-Smtp-Source: APBJJlEhNIa45NPT4/vzKTu/RdxY3ac7TLMhTaAs3LseOWlIwAIyrb+96NnNlFgFJplZMkHXZ4JNWCz25Rdd8N2Jh10=
X-Received: by 2002:a05:622a:120c:b0:3f8:5b2:aef0 with SMTP id
 y12-20020a05622a120c00b003f805b2aef0mr162550qtx.24.1689827588632; Wed, 19 Jul
 2023 21:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230720034022.31937-1-rongqianfeng@vivo.com>
In-Reply-To: <20230720034022.31937-1-rongqianfeng@vivo.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 19 Jul 2023 21:32:57 -0700
Message-ID: <CAP-5=fXQY1T2VQxs2ZBX_9ksuVfYvvzA6xSeOUpSQ8Sz1eJv_Q@mail.gmail.com>
Subject: Re: [PATCH] tools: perf: Two typos have been corrected
To:     Rong Qianfeng <rongqianfeng@vivo.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jul 19, 2023 at 8:40=E2=80=AFPM Rong Qianfeng <rongqianfeng@vivo.co=
m> wrote:
>
> When wrapping code, use ';' better than using ',' which is more
> in line with the coding habits of most engineers.
>
> Signed-off-by: Rong Qianfeng <rongqianfeng@vivo.com>

Snap: https://lore.kernel.org/lkml/20230706094635.1553-1-luhongfei@vivo.com=
/

Thanks,
Ian

> ---
>  tools/perf/builtin-diff.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> index e8a1b16aa5f8..57d300d8e570
> --- a/tools/perf/builtin-diff.c
> +++ b/tools/perf/builtin-diff.c
> @@ -1915,8 +1915,8 @@ static int data_init(int argc, const char **argv)
>                 struct perf_data *data =3D &d->data;
>
>                 data->path  =3D use_default ? defaults[i] : argv[i];
> -               data->mode  =3D PERF_DATA_MODE_READ,
> -               data->force =3D force,
> +               data->mode  =3D PERF_DATA_MODE_READ;
> +               data->force =3D force;
>
>                 d->idx  =3D i;
>         }
> --
> 2.39.0
>
