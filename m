Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27180C6FD19
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Mar 2023 15:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCMPYW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Mar 2023 11:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjCMPYV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Mar 2023 11:24:21 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22976BC07
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 08:24:18 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5416949b35aso122672337b3.13
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 08:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678721058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miD1UL5SmaXU4angX1YOOgTXJKTsZ0bIXYcLaAcdSBs=;
        b=sBBL2nrrHl8OUQTwNxo1hL50DYzng/MctVbkj/JgtWNDA/2ehB4a/4Laz6BGRWq7hI
         ot0b2cO9LzgvRThnNmF5DwKvea1/gdKxXMjwQB0OejwBKxjnSbqOUXaYmoNOM3DZ+JE8
         3SsQWGK54GouUPA3IRoCcoWiBKCVwgkNiTo18/9FTsMgN6guMqR6bAeF3sneCx6axYBr
         L7vS7fC8/1QIRvLjCcgrOU9Gl6Wfls40Kdr2rJYPk92IdN9bE1JB62DKG7XfQC6O4Vw+
         hO/H9LW1WBhMVzo3QvxeeqsPPegyBeBuZZK7C6Z4WwfCd0EdQjGU/fw5O62LqHg26+j9
         fONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678721058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miD1UL5SmaXU4angX1YOOgTXJKTsZ0bIXYcLaAcdSBs=;
        b=xltH95NiMZpPlXAOsJCs+R1seU/zgFaV6/1EhdkB9jXYdKkngk8jLS1XnWqrnJzneX
         kOyiPckSS7hTfYOKajiRkpH1C98KUWf5IWmCjQA1hFuhwvJ79Xk1W2W6bUEzJy1if9ji
         upO4CUeEZ898q456a0kZmNZx2PVg0LOg2C8+Hr9IoCoPVKNMtf4XNsmdtPREs9to1lvl
         KorniQ9x+vGZ5IfFRjNWBGz/ZusMSvsis3AbL1wlfuBPAmAccxRW3pzcBAYKErabdNOT
         Tj1t9UBgKb4MTISvkW7wzOy+rkx6i8Yct1Sdbiw6BagH0R3xzgxZ8r0dQR6p93GWej1M
         CUEw==
X-Gm-Message-State: AO0yUKX1aCgdw8gt414YEvRGuvbs9xt1BJOoGfJzaIKE0Jn82YpbseXv
        CN/cxvhw9IBJIPol8gQ7koko1R0xOOOFqM8ItbUGZw==
X-Google-Smtp-Source: AK7set9rOIwWUcKus6/AOVo/cWIf+3wr/bs1l75PKL7IV1SvIuGBUgFixB+MaM+Xt3efTaF+E8qXMRI+OtH3pPVeROM=
X-Received: by 2002:a81:af5c:0:b0:540:e6c6:31e7 with SMTP id
 x28-20020a81af5c000000b00540e6c631e7mr5878250ywj.2.1678721057682; Mon, 13 Mar
 2023 08:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230313080201.2440201-1-tmricht@linux.ibm.com> <20230313080201.2440201-3-tmricht@linux.ibm.com>
In-Reply-To: <20230313080201.2440201-3-tmricht@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 13 Mar 2023 08:24:06 -0700
Message-ID: <CAP-5=fW6HjLubp381QuAw-Q8N7-D6StTP5maqksRGWvwwv9UgQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] tools/perf/json: Add cache metrics for s390 z15
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, sumanthk@linux.ibm.com, svens@linux.ibm.com,
        gor@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Mar 13, 2023 at 1:31=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Add metrics for s390 z15
> - Percentage sourced from Level 2 cache
> - Percentage sourced from Level 3 on same chip cache
> - Percentage sourced from Level 4 Local cache on same book
> - Percentage sourced from Level 4 Remote cache on different book
> - Percentage sourced from memory
>
> For details about the formulas see this documentation:
> https://www.ibm.com/support/pages/system/files/inline-files/CPU%20MF%20Fo=
rmulas%20including%20z16%20-%20May%202022_1.pdf
>
> Outpuf after:
>  # ./perf stat -M l4rp -- find /
>  .... find output deleted
>
>  Performance counter stats for 'find /':
>
>               5      L1I_OFFDRAWER_L4_SOURCED_WRITES  #     0.01 l4rp
>             187      L1D_OFFDRAWER_L4_SOURCED_WRITES
>               0      L1I_OFFDRAWER_L3_SOURCED_WRITES
>     231,333,165      L1I_DIR_WRITES
>           3,303      L1D_OFFDRAWER_L3_SOURCED_WRITES
>          47,461      L1D_OFFDRAWER_L3_SOURCED_WRITES_IV
>               0      L1I_OFFDRAWER_L3_SOURCED_WRITES_IV
>     126,706,244      L1D_DIR_WRITES
>
>    27.870355461 seconds time elapsed
>
>     0.521562000 seconds user
>    12.494503000 seconds sys
>  #
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-By: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
>  .../arch/s390/cf_z15/transaction.json         | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json b/to=
ols/perf/pmu-events/arch/s390/cf_z15/transaction.json
> index 86bf83b4504e..cca237bdb7ba 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json
> @@ -18,5 +18,30 @@
>      "BriefDescription": "Level One Miss per 100 Instructions",
>      "MetricName": "l1mp",
>      "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * =
100"
> +  },
> +  {
> +    "BriefDescription": "Percentage sourced from Level 2 cache",
> +    "MetricName": "l2p",
> +    "MetricExpr": "((L1D_L2D_SOURCED_WRITES + L1I_L2I_SOURCED_WRITES) / =
(L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
> +  },
> +  {
> +    "BriefDescription": "Percentage sourced from Level 3 on same chip ca=
che",
> +    "MetricName": "l3p",
> +    "MetricExpr": "((L1D_ONCHIP_L3_SOURCED_WRITES + L1D_ONCHIP_L3_SOURCE=
D_WRITES_IV + L1I_ONCHIP_L3_SOURCED_WRITES + L1I_ONCHIP_L3_SOURCED_WRITES_I=
V) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
> +  },
> +  {
> +    "BriefDescription": "Percentage sourced from Level 4 Local cache on =
same book",
> +    "MetricName": "l4lp",
> +    "MetricExpr": "((L1D_ONCLUSTER_L3_SOURCED_WRITES + L1D_ONCLUSTER_L3_=
SOURCED_WRITES_IV + L1D_ONDRAWER_L4_SOURCED_WRITES + L1I_ONCLUSTER_L3_SOURC=
ED_WRITES + L1I_ONCLUSTER_L3_SOURCED_WRITES_IV + L1I_ONDRAWER_L4_SOURCED_WR=
ITES + L1D_OFFCLUSTER_L3_SOURCED_WRITES + L1D_OFFCLUSTER_L3_SOURCED_WRITES_=
IV + L1D_ONCHIP_L3_SOURCED_WRITES_RO + L1I_OFFCLUSTER_L3_SOURCED_WRITES + L=
1I_OFFCLUSTER_L3_SOURCED_WRITES_IV) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * =
100"

It is more typical for percentages to change the ScaleUnit to "100%"
and not to do the "* 100". Otherwise these look good.

Thanks,
Ian

> +  },
> +  {
> +    "BriefDescription": "Percentage sourced from Level 4 Remote cache on=
 different book",
> +    "MetricName": "l4rp",
> +    "MetricExpr": "((L1D_OFFDRAWER_L3_SOURCED_WRITES + L1D_OFFDRAWER_L3_=
SOURCED_WRITES_IV + L1D_OFFDRAWER_L4_SOURCED_WRITES + L1I_OFFDRAWER_L3_SOUR=
CED_WRITES + L1I_OFFDRAWER_L3_SOURCED_WRITES_IV + L1I_OFFDRAWER_L4_SOURCED_=
WRITES) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
> +  },
> +  {
> +    "BriefDescription": "Percentage sourced from memory",
> +    "MetricName": "memp",
> +    "MetricExpr": "((L1D_ONCHIP_MEMORY_SOURCED_WRITES + L1D_ONCLUSTER_ME=
MORY_SOURCED_WRITES + L1D_OFFCLUSTER_MEMORY_SOURCED_WRITES + L1D_OFFDRAWER_=
MEMORY_SOURCED_WRITES + L1I_ONCHIP_MEMORY_SOURCED_WRITES + L1I_ONCLUSTER_ME=
MORY_SOURCED_WRITES + L1I_OFFCLUSTER_MEMORY_SOURCED_WRITES + L1I_OFFDRAWER_=
MEMORY_SOURCED_WRITES) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
>    }
>  ]
> --
> 2.39.1
>
