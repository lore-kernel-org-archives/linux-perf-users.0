Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486B8C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 May 2022 16:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355927AbiEMQpA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 13 May 2022 12:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380668AbiEMQo7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 May 2022 12:44:59 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5551C129
        for <linux-perf-users@vger.kernel.org>; Fri, 13 May 2022 09:44:58 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i5so12142502wrc.13
        for <linux-perf-users@vger.kernel.org>; Fri, 13 May 2022 09:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vLl1Ai3+5yqqnQbitkLo268aeXr5rmYysO1HcDqU5yM=;
        b=S4GhaWhcyUpPoJ5lggTeuTH0MjQoxEYbnpHH9bwHXFmP7yjd6FAMpuEGclAfW+/Gkt
         XxM6yNJ9bvNehnB9Nr6qTBPUG2LX5HR3K6auzP96vRl3UjEfT2dOoCFzVX17sLwfKqx6
         wOcOGPREC3UGRpBFAXgpMsf5fwysR86uk/b1ZgTV9QvB9Q9BhU3tFKxD6byK4fi26rLr
         YYe3YWxZNQf8e9QcGqgotoegXPMgnIlLtgpggRN93018KVVwX4O14/ucIm7Y6kj0aeY7
         QbFHP6WBKiT5Ku+66kH9lQ/p3iIGKDgn0djyYLmFpDWyFbyFD4KBXOxYaVzmlS4+YBVv
         W2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vLl1Ai3+5yqqnQbitkLo268aeXr5rmYysO1HcDqU5yM=;
        b=8Nv0oeupFBCGf6hTagvhiklpzcE7mEb+7A7B79gc3NGilSgTvN31xlR6m58uKGw7Ih
         +U3Cy+ArZPn7uEz0fCM3JTTQ+Jg6IruH1jmCtj9Uhp2+t1uPRGjrYEl8eOiy4OnlOczB
         T3CkJ1ukv/78PB6MNGFYu5KolwFQKdNVwp+qMCNj89+tq4McUQloA7G1QB0gBdhypjxK
         FM0yvjrOyyqzsdWPjLBbbP6Kqg4bakBewVYD8jzgLPnmaV4+qOOzO5MiVGrt5tFFUTMF
         astzb3yCXFsrQPM7MLRkZZTc2MajQ29Bf+qM4yMfZ/6gyaywb2tJRlJ9jeWowkSXHvBw
         XJYA==
X-Gm-Message-State: AOAM531KhwTIlSsmarTp2UVOF3a1qHTDYTNr5eA4AX2eVKv/bOB8Hn/R
        QsZYK2LdBYovChl6CkezdLS8svfHCuKKyq0QL1U9Og==
X-Google-Smtp-Source: ABdhPJz3/T3d4FtiHrGsUXeBLuV07r5YHYGCEKw//rIIAyFq5BclWYeJRZcUcOuDyIQ0HNnXxz52OsDUFz/ZbwSfom4=
X-Received: by 2002:adf:f30a:0:b0:20a:e193:6836 with SMTP id
 i10-20020adff30a000000b0020ae1936836mr4799895wro.654.1652460297267; Fri, 13
 May 2022 09:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220513151554.1054452-1-kan.liang@linux.intel.com> <20220513151554.1054452-4-kan.liang@linux.intel.com>
In-Reply-To: <20220513151554.1054452-4-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 13 May 2022 09:44:44 -0700
Message-ID: <CAP-5=fXL3f_CQrq=q31BiikthTkUjuDohNp8eiowqOeo28FANw@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf parse-events: Support different format of the
 topdown event name
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        zhengjun.xing@linux.intel.com, adrian.hunter@intel.com,
        ak@linux.intel.com, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, May 13, 2022 at 8:16 AM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The evsel->name may have a different format for a topdown event, a pure
> topdown name (e.g., topdown-fe-bound), or a PMU name + a topdown name
> (e.g., cpu/topdown-fe-bound/). The cpu/topdown-fe-bound/ kind format
> isn't supported by the arch_evlist__leader(). This format is a very
> common format for a hybrid platform, which requires specifying the PMU
> name for each event.
>
> Without the patch,
>
> $perf stat -e '{instructions,slots,cpu/topdown-fe-bound/}' -a sleep 1
>
>  Performance counter stats for 'system wide':
>
>      <not counted>      instructions
>      <not counted>      slots
>    <not supported>      cpu/topdown-fe-bound/
>
>        1.003482041 seconds time elapsed
>
> Some events weren't counted. Try disabling the NMI watchdog:
>         echo 0 > /proc/sys/kernel/nmi_watchdog
>         perf stat ...
>         echo 1 > /proc/sys/kernel/nmi_watchdog
> The events in group usually have to be from the same PMU. Try reorganizing the group.
>
>
> With the patch,
>
> perf stat -e '{instructions,slots,cpu/topdown-fe-bound/}' -a sleep 1
>
>  Performance counter stats for 'system wide':
>
>        157,383,996      slots
>         25,011,711      instructions
>         27,441,686      cpu/topdown-fe-bound/
>
>        1.003530890 seconds time elapsed
>
> Fixes: bc355822f0d9 ("perf parse-events: Move slots only with topdown")
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/arch/x86/util/evlist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
> index cfc208d71f00..75564a7df15b 100644
> --- a/tools/perf/arch/x86/util/evlist.c
> +++ b/tools/perf/arch/x86/util/evlist.c
> @@ -36,7 +36,7 @@ struct evsel *arch_evlist__leader(struct list_head *list)
>                                 if (slots == first)
>                                         return first;
>                         }
> -                       if (!strncasecmp(evsel->name, "topdown", 7))
> +                       if (strcasestr(evsel->name, "topdown"))
>                                 has_topdown = true;
>                         if (slots && has_topdown)
>                                 return slots;
> --
> 2.35.1
>
