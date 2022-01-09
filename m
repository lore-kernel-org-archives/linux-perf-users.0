Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704DBC433F5
	for <linux-perf-users@archiver.kernel.org>; Sun,  9 Jan 2022 18:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbiAISao (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 9 Jan 2022 13:30:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59543 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236457AbiAISao (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 9 Jan 2022 13:30:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641753043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=An+oxkp/d/zOEov/Qf6h7tx0CIo4kpBYV+ftCCkPi8U=;
        b=ProDkiM+i4yojQpi6l2l+XgChDRdMDPXC7dlMzQZ5cOh0dmd5I8BWB29M6TygImzr4LXTi
        tw9AHf1AJhKrMSmBtkuI9xkOjkV3zmjMIKjtRb0AgkuH/1VSXbHHW/+BqX6GXUNGQJXzy/
        wlSBKlfxAeNCPCFcr7jZ3sEQCdnuuEE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-365-8YqxMl63Nky0yXRy04c79Q-1; Sun, 09 Jan 2022 13:30:42 -0500
X-MC-Unique: 8YqxMl63Nky0yXRy04c79Q-1
Received: by mail-ed1-f72.google.com with SMTP id z8-20020a056402274800b003f8580bfb99so8482533edd.11
        for <linux-perf-users@vger.kernel.org>; Sun, 09 Jan 2022 10:30:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=An+oxkp/d/zOEov/Qf6h7tx0CIo4kpBYV+ftCCkPi8U=;
        b=vXA7QQMfluapSXJTQ+j8Hk4vgaRzcB/afrbktaydTN8Ys4rYOBi00zhaummMJeivmW
         i+CO7ivq5gAEGtA7rYSDwJ8VolSQ/oQo6jw2lN7mqhzfDt4EdJHVRzXkbuxgdL6qcFQu
         3BNxtRRQIZVTG6gjpqcP9RU5jwWneU7RCxAKJWIvdJj/bOjkEDENTug+Y6uP/7SFj55T
         1sMjJRz8BjTQfyE1BDS7BNcFbxqFbt0cl7xTO51ZBWan1c6uiwY5qTGiGHVFtv9Vv4Bm
         f0z5SGHGCiNc79c1y07iF7ltI/fRgaF5BAcnInmUzRXmD5HJcilKitA3v8hEuYcxqeBv
         ANMg==
X-Gm-Message-State: AOAM533dthzPTSmC9IBHfLrBSVj9t6p+Clg3BBorsdOGS90kWzLvpHrm
        wrP1Xk4VQJhMWq1Lwf5Qrwt6PvIp2ZAjCklTnlaIIDCkDfFZANby8s3MKOZPZI+MrTlCeeGXEOi
        dTMtwQQVQWZctmYndWGzm1/L3QkZx+Q==
X-Received: by 2002:a17:906:f8c7:: with SMTP id lh7mr11009462ejb.485.1641753040956;
        Sun, 09 Jan 2022 10:30:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxLGNR4PxiE5GS9/dvOtlC6tJp2UO68Q4ykPGmDNa8TUmfmcksFWKtROYgf/hsNP7D7u+ABLQ==
X-Received: by 2002:a17:906:f8c7:: with SMTP id lh7mr11009453ejb.485.1641753040720;
        Sun, 09 Jan 2022 10:30:40 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id i22sm1597840ejw.75.2022.01.09.10.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 10:30:40 -0800 (PST)
Date:   Sun, 9 Jan 2022 19:30:38 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com,
        eranian@google.com
Subject: Re: [PATCH v4 48/48] perf cpumap: Give CPUs their own type.
Message-ID: <Ydspzl2aWpufl/yR@krava>
References: <20220105061351.120843-1-irogers@google.com>
 <20220105061351.120843-49-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105061351.120843-49-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jan 04, 2022 at 10:13:51PM -0800, Ian Rogers wrote:
> A common problem is confusing CPU map indices with the CPU, by wrapping
> the CPU with a struct then this is avoided. This approach is similar to
> atomic_t.
> 
> Suggested-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

SNIP

>  tools/perf/util/stat.h                        |   2 +-
>  tools/perf/util/svghelper.c                   |   6 +-
>  tools/perf/util/synthetic-events.c            |  12 +-
>  tools/perf/util/synthetic-events.h            |   3 +-
>  tools/perf/util/util.h                        |   5 +-
>  59 files changed, 408 insertions(+), 347 deletions(-)

that's massive ;-) did it find any mis-use of the index/value?

how about the same for threads?

> diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
> index 71a31ed738c9..581f9ffb4237 100644
> --- a/tools/lib/perf/include/internal/cpumap.h
> +++ b/tools/lib/perf/include/internal/cpumap.h
> @@ -4,6 +4,11 @@
>  
>  #include <linux/refcount.h>
>  
> +/** A wrapper around a CPU to avoid confusion with the perf_cpu_map's map's indices. */
> +struct perf_cpu {
> +	int cpu;
> +};

should we use 'int val' or 'int v' instead, so we don't have cpu.cpu ?

jirka

SNIP

