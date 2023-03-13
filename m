Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C39DC61DA4
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Mar 2023 15:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjCMPZc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Mar 2023 11:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjCMPZb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Mar 2023 11:25:31 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780681A48B
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 08:25:30 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id e71so3863394ybc.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 08:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678721129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bo7h73vzIvhd7SbAkzHI481mi/jorwfHFJL6Gg0+Zk4=;
        b=YpQnCvH6IT1oj7dWjXcGpWt189Xz3+YmonlcaBE503xewKuPSd+JcTgN9m9mxjeQxS
         KV4k32WazMiK1VZ8EBIEqbQz3gN/0H616pkPSAiGD6FaS1WJnJOnF38V6ph14Rk4kC9G
         hCMTn3lRwJiWGbL5wCmSAJSkdUyQ27YaB4eKB1l6CydxY3sEx8aSunKD/axWuezVbmPj
         HRrlmgmH6qUjnfFfsMhUwn0OUFgu2apnGetEBVRjx4ziKW4AgnF6i7X90BK0OWM+DlOX
         bqB9idP2kXu5qKfihh1JD8X7tP5nO0xEaMJempTxxncK+9nwW91j2WFZ3MgEQbZh/fzc
         R7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678721129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bo7h73vzIvhd7SbAkzHI481mi/jorwfHFJL6Gg0+Zk4=;
        b=wp88vLdcU+krycujph0oL9pefcnwBgnaBorZgkdnKrMouWAWU/I1B03z8nFsPd8YhW
         oBG1vf3akZk/mYc0Ge3TgzhDixjBOsz4pBTEAl8eVAlEb2ewTzmC20U8XNt6nGZUj2sb
         wCcOYPUkm2iIsg5NQXJdMUzHlfP5kHATClUmOuHRZzg589O/bmF7Ty5qW9tzRhJeqblX
         1gUxydzGtZXrhWoO3BTqLb3iF03vEJk0Fuuv/hOFoaovyAhqFa8uHXmwDIpLad8QdL7c
         qUXp0MKfvcnbR2tBz+1LQHdapqYqp5N7uoiA/ucPRcpi8kLAnvnxTJRW6FqR0Twpe/Og
         NaDg==
X-Gm-Message-State: AO0yUKXCEObQKwCZvU1pw1XULJ2CTp00GgggD3IMxWv/krf9z+TUZZiC
        6rzJLIJgtle2eHR/j0IFePlNTaFBYJap6xDhIHU1cg==
X-Google-Smtp-Source: AK7set/OqxR3NSJ6PJqZdEM2FmrqWfBq6tBtvtRAXIWiBp4wmljJAtJQzJlnChVP2OcvXPf4D/2vpjusTwheq9PWKNM=
X-Received: by 2002:a5b:f03:0:b0:a74:87b0:4090 with SMTP id
 x3-20020a5b0f03000000b00a7487b04090mr14325018ybr.3.1678721129488; Mon, 13 Mar
 2023 08:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230313080201.2440201-1-tmricht@linux.ibm.com> <20230313080201.2440201-4-tmricht@linux.ibm.com>
In-Reply-To: <20230313080201.2440201-4-tmricht@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 13 Mar 2023 08:25:18 -0700
Message-ID: <CAP-5=fX0b4833q0z0px=RAh7gi8zoM6VWAxh121Rd5=rr3+hVQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] tools/perf/json: Add cache metrics for s390 z14
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, sumanthk@linux.ibm.com, svens@linux.ibm.com,
        gor@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Mar 13, 2023 at 1:06=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Add metrics for s390 z14
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
>              0      L1I_OFFDRAWER_L4_SOURCED_WRITES  #     0.01 l4rp
>             84      L1D_OFFDRAWER_L4_SOURCED_WRITES
>              0      L1I_OFFDRAWER_L3_SOURCED_WRITES
>     71,535,353      L1I_DIR_WRITES
>            219      L1D_OFFDRAWER_L3_SOURCED_WRITES
>         16,436      L1D_OFFDRAWER_L3_SOURCED_WRITES_IV
>              0      L1I_OFFDRAWER_L3_SOURCED_WRITES_IV
>     46,343,940      L1D_DIR_WRITES
>
>   10.530805537 seconds time elapsed
>
>    0.774396000 seconds user
>    1.602714000 seconds sys
>
>  #
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-By: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
>  .../arch/s390/cf_z14/transaction.json         | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json b/to=
ols/perf/pmu-events/arch/s390/cf_z14/transaction.json
> index 86bf83b4504e..cca237bdb7ba 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json
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

Some comment as patch #3 wrt ScaleUnit of "100%" rather than "* 100".
I can see from the metric above this way is being consistent.

Thanks,
Ian

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
