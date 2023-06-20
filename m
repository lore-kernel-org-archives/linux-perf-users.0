Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3E7EB64D7
	for <linux-perf-users@archiver.kernel.org>; Tue, 20 Jun 2023 16:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjFTQpE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 20 Jun 2023 12:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjFTQo6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 20 Jun 2023 12:44:58 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6FF10A
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Jun 2023 09:44:57 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-34292a63a13so239175ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Jun 2023 09:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687279497; x=1689871497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yOwFPB6Y7LmX/wAwvqA1B2iI2lMiw9HjeCkgBlU7oM=;
        b=XkRxC5N34WtbovY9mWICJX+6tCuOm3zTB3/ljYzqfMlJKlx8syvZsC7NB5tvoHzTKz
         8kIIvfKELISknyGYb9FUCqebgoihWqV8GlIYvqIU11iLVSOWdkQ+IQRDKD9OYGSpHXAC
         DR+kp996PY4C6GxqJZ0ANEW+Uuan151PmoxQj4vgX8h7TbvC1GoCPwERfzk7vtUFYaJD
         w8RdF2g/3fTMS7y1Lk03bv1Yf+YR3wOdvTNtiazXnqbWsr7YgQElUxHHzQGuMfVokBR3
         YQQOx3j2/e3Ar05f0T5AvC5WfHjnzbZ1NECgMSBgFFtC7CHn0VbWbgoqTM5G2wLR28hV
         a93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687279497; x=1689871497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yOwFPB6Y7LmX/wAwvqA1B2iI2lMiw9HjeCkgBlU7oM=;
        b=P17l+KN7IwSzSDTokVCoLQnKPGKKdW6cZ4hnmRxPazK0fhmBPpa8z/C+1ABUPnAdzr
         xyfpu3OR6hFO7DBQ1plGnvC5WRU8v3JwQJqQqdYhU3bS2qrELkzIZxkM5SGVK4PYljbl
         EZPQnoWHUJIEi2mvRKbHBuAocqflAYKIzl2uVjWeqpPOway3JGJNte1lE0C2zaaKDha+
         lKxL56ileh1cwHRLevLZdWFDURyYX4MTgw0sfgbMsbL0ALm1BOPWMkXDxS+Bwrtxvldg
         Ydw3I0yzOOHw10I0lzpKx3Jx6YrsBuL4ExMxG/zmKrh3EUja7oZIWoDozCoxYmzZaEeJ
         8VNA==
X-Gm-Message-State: AC+VfDwfBF32sbwot6tCQ1i83NS7CPsrngrNzkFhOlWA5S85qrmhEbw5
        O4lzsQByOKCfeeUCdM4QC/W9pYpuzRz/hi+y0PJ9EQ==
X-Google-Smtp-Source: ACHHUZ527xXn2pYb/IqmwgjxnLJ5837QHWrPBiAp1Yo04hoVHlXMoKPH0jkAbrTl5f7W6zjOLKuSPEzKaamANwY+9YM=
X-Received: by 2002:a05:6e02:1585:b0:33d:8608:7596 with SMTP id
 m5-20020a056e02158500b0033d86087596mr1241845ilu.15.1687279496907; Tue, 20 Jun
 2023 09:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230620091603.269-1-ravi.bangoria@amd.com>
In-Reply-To: <20230620091603.269-1-ravi.bangoria@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 20 Jun 2023 09:44:45 -0700
Message-ID: <CAP-5=fXS726wY1taYEYXDz3YZ4ZwxcL+nhh_yNM7rwamMd8mWg@mail.gmail.com>
Subject: Re: [PATCH] perf/amd: Prevent grouping of IBS events
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     peterz@infradead.org, acme@kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, bp@alien8.de, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jun 20, 2023 at 2:16=E2=80=AFAM Ravi Bangoria <ravi.bangoria@amd.co=
m> wrote:
>
> IBS PMUs can have only one event active at any point in time. Restrict
> grouping of multiple IBS events.

Thanks Ravi,

can you provide an example/test for this? Should this be a weak group issue=
?

Thanks,
Ian

> Reported-by: Sandipan Das <sandipan.das@amd.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  arch/x86/events/amd/ibs.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 371014802191..74e664266753 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -247,11 +247,33 @@ int forward_event_to_ibs(struct perf_event *event)
>         return -ENOENT;
>  }
>
> +/*
> + * Grouping of IBS events is not possible since IBS can have only
> + * one event active at any point in time.
> + */
> +static int validate_group(struct perf_event *event)
> +{
> +       struct perf_event *sibling;
> +
> +       if (event->group_leader =3D=3D event)
> +               return 0;
> +
> +       if (event->group_leader->pmu =3D=3D event->pmu)
> +               return -EINVAL;
> +
> +       for_each_sibling_event(sibling, event->group_leader) {
> +               if (sibling->pmu =3D=3D event->pmu)
> +                       return -EINVAL;
> +       }
> +       return 0;
> +}
> +
>  static int perf_ibs_init(struct perf_event *event)
>  {
>         struct hw_perf_event *hwc =3D &event->hw;
>         struct perf_ibs *perf_ibs;
>         u64 max_cnt, config;
> +       int ret;
>
>         perf_ibs =3D get_ibs_pmu(event->attr.type);
>         if (!perf_ibs)
> @@ -265,6 +287,10 @@ static int perf_ibs_init(struct perf_event *event)
>         if (config & ~perf_ibs->config_mask)
>                 return -EINVAL;
>
> +       ret =3D validate_group(event);
> +       if (ret)
> +               return ret;
> +
>         if (hwc->sample_period) {
>                 if (config & perf_ibs->cnt_mask)
>                         /* raw max_cnt may not be set */
> --
> 2.41.0
>
