Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A920C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Feb 2022 22:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiBNWSf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Feb 2022 17:18:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiBNWSf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Feb 2022 17:18:35 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7994813FAE6
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Feb 2022 14:18:26 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 124so22342189ybn.11
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Feb 2022 14:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ClXABgC0XWLNKY1J8ZiwwxDjdnPc1Xxiwc8rtd4SZjg=;
        b=BNKrURhk9Oi9U06kpXCeuv8gARHKNT331GodV/9vaVTTy7d50VmNe9Se4YBgSc7B12
         38z1/bk36x9Nx38O0i3Z3mCUec+axtWC0NBbwiLZ/A3LJzFgufwGLFnQ0GtJyzig2yeK
         aRwqQAQbZ/36ssMYJPxPn/10s+VvZn8aBkcfNi5ydzmQhcThgVpWzJuzu8EkoQLCtfYS
         oCU4tXTsIr3ToNxK1P1FoAjpARjWfEAs88IdooGYqPgyDhnGZ9lHNPB1seFnljK8NOol
         9IcKTLqdSDO2cI/f6f7nbyV5moRNPeZPNZrHqFJ3YZRa+BqkBvlYWvLSoIjybjL6UXKn
         0h2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ClXABgC0XWLNKY1J8ZiwwxDjdnPc1Xxiwc8rtd4SZjg=;
        b=gliaBIYKf3hAxRnWuHuXqFmxWEE8boV92DtG7VhzU2gDhgR/mB0zXXI9AeImUh/ZPN
         mBiAnx2kZuAN0wkaBlBgvTZaNzCNTLm0KJ58OCzgxH70eaf6UVwvFQdRYV6Gn14yfPth
         h1cT/fN9nOmUhdlUKjzLR34O+VnRV4M1ZwOrBSZLs2b04brcQ5wCMzL8CiNJ5Z/VCh9v
         5tT59byJdhzKMB2f+KVw+TJjMG7hRAMUqPiJkfLQOznmlse+HsWqQA2HDzvdF5+PHAQ0
         BRxmhBTI57qlGPxG5gFX8UmLe36/hmkN5vvZmKtbq4rK/d/plqXcFwOxUYyZ0ouaMBQ9
         Ka+Q==
X-Gm-Message-State: AOAM533v1gt9fCtL3kFto+IfnwlWbXJdqQAuRGGA0cT0AiYlYZHfItrp
        ZsnA3d30nJmjMmjhKQiwoP9k4blb0XgbD5YIq80hlw==
X-Google-Smtp-Source: ABdhPJzSjscOjEkn8P+9yXYLiPTxaGOPHAVo0dYyZBj8Mwjuwz9unV/rzlgibV8WvPTI5fSxRwg8Zc5DdpBPmhy0PSo=
X-Received: by 2002:a81:334d:: with SMTP id z74mr955906ywz.194.1644877105368;
 Mon, 14 Feb 2022 14:18:25 -0800 (PST)
MIME-Version: 1.0
References: <CAPpZLN6+BPu=Y_iCXBV_Uqg_mcY2LEBtg+_7r+oJqWkG8pNSGA@mail.gmail.com>
 <YgrIId0p9KoE9zPI@krava>
In-Reply-To: <YgrIId0p9KoE9zPI@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 14 Feb 2022 14:18:13 -0800
Message-ID: <CAP-5=fXNfvttL6VungRvqHX8dqD5tmUHwrVbs+n=4j2KhV5Usw@mail.gmail.com>
Subject: Re: libperf: CPU map question
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Feb 14, 2022 at 1:22 PM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Mon, Feb 14, 2022 at 06:54:38PM +0200, Tzvetomir Stoyanov wrote:
> > Hello,
> > I'm trying to use libperf as an interface to perf from an application,
> > but I face some difficulties.  I cannot understand how perf_cpu_map_
> > APIs should be used. My use case is:
> >  I want to iterate over the CPUs from the map. I'm using
> > perf_evsel__cpus() API to get the map and perf_cpu_map__for_each_cpu()
> > macros to iterate over the map. However, using that logic I get a
> > struct perf_cpu for each CPU from the map. That structure seems to be
> > private and I cannot access the actual .cpu id. Am I missing something
> > ?
> > Will be glad for any help and clarification.
>
> yea it's a bug ;-) there was a change recently that wrapped cpu
> in struct perf_cpu to distinguish it from cpu indexes
>
>   6d18804b963b perf cpumap: Give CPUs their own type
>
> not sure there's workaround for that.. but I think change below should fix it
>
> Ian, would this be ok? we need to add some test for this

This looks good to me, thanks! Agreed on the test.

Thanks,
Ian

> jirka
>
>
> ---
> diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
> index 581f9ffb4237..1973a18c096b 100644
> --- a/tools/lib/perf/include/internal/cpumap.h
> +++ b/tools/lib/perf/include/internal/cpumap.h
> @@ -3,11 +3,7 @@
>  #define __LIBPERF_INTERNAL_CPUMAP_H
>
>  #include <linux/refcount.h>
> -
> -/** A wrapper around a CPU to avoid confusion with the perf_cpu_map's map's indices. */
> -struct perf_cpu {
> -       int cpu;
> -};
> +#include <perf/cpumap.h>
>
>  /**
>   * A sized, reference counted, sorted array of integers representing CPU
> diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
> index 15b8faafd615..4a2edbdb5e2b 100644
> --- a/tools/lib/perf/include/perf/cpumap.h
> +++ b/tools/lib/perf/include/perf/cpumap.h
> @@ -7,6 +7,11 @@
>  #include <stdio.h>
>  #include <stdbool.h>
>
> +/** A wrapper around a CPU to avoid confusion with the perf_cpu_map's map's indices. */
> +struct perf_cpu {
> +       int cpu;
> +};
> +
>  LIBPERF_API struct perf_cpu_map *perf_cpu_map__dummy_new(void);
>  LIBPERF_API struct perf_cpu_map *perf_cpu_map__default_new(void);
>  LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
