Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721D2EB64DD
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Aug 2023 20:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjHNUYa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Aug 2023 16:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjHNUYU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Aug 2023 16:24:20 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EA5E5B
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Aug 2023 13:24:19 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-407db3e9669so19541cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Aug 2023 13:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692044658; x=1692649458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSSLEw5F2RpsSJDXkksvbuFJhQZkRzBBaxJy2HARoBc=;
        b=JzzdtEv9iAZ4/IZ+utw2v2/StJoFVZ3duBCJDZ0+foUzYbm++/xzGveSIJFsuHFNXO
         ENdyEPuLgT4PpMyls1pK58e1FNpmnNvDfMRCmETsngjqHd3Zq7ktSY3r9eK45ioORHZ/
         EBU4EX7vxeyOPdeFgS+utQkc+fvNXhLt1gXRsXgHNJf5QggEWyQ6BiSR6Lfq7CO0EZR8
         c/Zgp2q9rhB9CjFdY6UUV6cdyKN5Mt55ABXOpaG9uhAtPM1z+Nmbz+849wa2iWBFUjQH
         car9PfNoEegDX14lw6GjJ4sCT6iAI7UAOLEbLzEQ2UTI91oXgnA+ihIP7qEP3kU0YIcl
         q6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692044658; x=1692649458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSSLEw5F2RpsSJDXkksvbuFJhQZkRzBBaxJy2HARoBc=;
        b=JCDdXb/EX4CTyr27YIO/ALvZvJscyGRVHvqHFJo3OFYI58AHB+Jm4yxyGREg09Fujz
         oRl9qbEvisH3hL5qNGk6+YR/pMNJzVA/X5Vv6TpoFFkqskgL4HiI6l7lGZkXLPA1237V
         BVer5+8q8FZAOZkaZYgF99e2cBKKHgcx+Q8fVqmsfH4JD+r992+m5CfKu4sxg5IlMVeI
         Un/F2JTSVVvfe5rnvVzz3DVw2lq6hb2juCXLfwmQDbIWvCCyVV9DW7hMOtnDo7GA5bAe
         KhTu3vI9pdJj8Tx3ADmkPKZ+leDsP/CkKse+gHgNjeo+05KdnxwN4oe2qXo0oK9SY4ws
         VWzg==
X-Gm-Message-State: AOJu0YwQWRCXG0w+hUX8KDuUH+V63ayRkTQQbse1qoh/1DOVoEqruO8w
        UEJLF0At6yNL/KFJvGzQXVwBQ1xsJwWzT53FITB8Bg==
X-Google-Smtp-Source: AGHT+IFIeHMMVToGLSS2KTQjtpjyqYWhYjqljbMdFdJAi+CuCc10Vra7FA5ljFCRHw5PEtjHZKUVoV7mrGjALMJhrk0=
X-Received: by 2002:ac8:7c50:0:b0:40f:db89:5246 with SMTP id
 o16-20020ac87c50000000b0040fdb895246mr698165qtv.21.1692044658618; Mon, 14 Aug
 2023 13:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <01CA7674B690CA24+20230804020907.144562-2-ye@kaige.org>
In-Reply-To: <01CA7674B690CA24+20230804020907.144562-2-ye@kaige.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 14 Aug 2023 13:24:06 -0700
Message-ID: <CAP-5=fWxxaL7xqTFmButfVUEBCXB9PQOVovooMq+Z7NqP=10HA@mail.gmail.com>
Subject: Re: [PATCH v2] perf stat-display: Check if snprintf()'s fmt argument
 is NULL
To:     Kaige Ye <ye@kaige.org>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Aug 3, 2023 at 7:10=E2=80=AFPM Kaige Ye <ye@kaige.org> wrote:
>
> It is undefined behavior to pass NULL as snprintf()'s fmt argument.
> Here is an example to trigger the problem:
>
>   $ perf stat --metric-only -x, -e instructions -- sleep 1
>   insn per cycle,
>   Segmentation fault (core dumped)
>
> With this patch:
>
>   $ perf stat --metric-only -x, -e instructions -- sleep 1
>   insn per cycle,
>   ,
>
> Signed-off-by: Kaige Ye <ye@kaige.org>

Thanks Kaige!

Reviewed-by: Ian Rogers <irogers@google.com>

> ---
> V1 -> V2: Addressed Ian's comments (Ian Rogers)
> ---
>  tools/perf/util/stat-display.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index 7329b3340..031888545 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -578,7 +578,7 @@ static void print_metric_only_csv(struct perf_stat_co=
nfig *config __maybe_unused
>         if (!valid_only_metric(unit))
>                 return;
>         unit =3D fixunit(tbuf, os->evsel, unit);
> -       snprintf(buf, sizeof buf, fmt, val);
> +       snprintf(buf, sizeof(buf), fmt ?: "", val);
>         ends =3D vals =3D skip_spaces(buf);
>         while (isdigit(*ends) || *ends =3D=3D '.')
>                 ends++;
> @@ -600,7 +600,7 @@ static void print_metric_only_json(struct perf_stat_c=
onfig *config __maybe_unuse
>         if (!valid_only_metric(unit))
>                 return;
>         unit =3D fixunit(tbuf, os->evsel, unit);
> -       snprintf(buf, sizeof(buf), fmt, val);
> +       snprintf(buf, sizeof(buf), fmt ?: "", val);
>         ends =3D vals =3D skip_spaces(buf);
>         while (isdigit(*ends) || *ends =3D=3D '.')
>                 ends++;
>
> base-commit: f6b8436bede3e80226e8b2100279c4450c73806a
> --
> 2.41.0
>
