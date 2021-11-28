Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB2FC433EF
	for <linux-perf-users@archiver.kernel.org>; Sun, 28 Nov 2021 17:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbhK1RDW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 28 Nov 2021 12:03:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34273 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345975AbhK1RBS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 28 Nov 2021 12:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638118681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tpGHUKYpaVNMq1Y1Pd0vJp6cIrA5ck5KtEzHZ7z/FWA=;
        b=P8mePlWWEXaQlSemS+fCDHX1I6HZsgq35W9gVdmU6N0MMaAGIO8HEJszCiG9nX+pJPbfU7
        OyUXiAo4TGV1fwXULa60SJnmynaYvmZIdHfcoMBo7pLxjS119lYOTOXjPfag+P8WKPHu0/
        JWpueewJDyhdwUBvyZM9/ZinhR7uO4Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-ZSlTY1lwNR-q99Aad59FCw-1; Sun, 28 Nov 2021 11:58:00 -0500
X-MC-Unique: ZSlTY1lwNR-q99Aad59FCw-1
Received: by mail-wm1-f71.google.com with SMTP id p12-20020a05600c1d8c00b0033a22e48203so9075649wms.6
        for <linux-perf-users@vger.kernel.org>; Sun, 28 Nov 2021 08:58:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tpGHUKYpaVNMq1Y1Pd0vJp6cIrA5ck5KtEzHZ7z/FWA=;
        b=pOnFhfzMq42poMXcg4NVHic6JYEzgStxaBcwALRtzUZPlUqg+iG7QLinyAImLUz9yi
         B5iOfV2k6S6T7OnQBxqKfNVD/K3OrTBqJXxz72SeOsqCrkszMPVoRJegvc8HoOR9G2W0
         zaadsZotBI+efMzZziybFITq5PV+r19XIl63o41B7FZ20AW2kfVVzlv3fLYsUf9VXpkC
         Bl6sYfp/5UQebgulhBx/ngySaNBV1Ab0Q1jQC2COH9UQ5Jba03gk5F17gibpHFdsPkmr
         uMg/57BgNJLVsjRbeyJgOTLKuZHi+514oVnlWS7jfk7aBVtMG7yw+q0t63L/8RDG0dGc
         1gbQ==
X-Gm-Message-State: AOAM533hrk5IAZEv2u7Ub4CiRkFtkfMGEZZ/0MDVMULSnl3C/DIbonYu
        AUVs6n2cSEgyCBHQiWOqPA3FeCxB0rAClM1Fmx6eOLii8krG6sbGMw++8KMG+JNn1npFPI6gYFv
        rqt2TTXgKKR5vfndn1BlS6Al/gbSsQA==
X-Received: by 2002:a5d:6da2:: with SMTP id u2mr27679714wrs.273.1638118678999;
        Sun, 28 Nov 2021 08:57:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzO+Uv4zcLBq6km16KM6CRY+H9R0szixLWE7fiDK/EVPKzwCJ9aJCnO1p7uvI44PAyiOCGEjA==
X-Received: by 2002:a5d:6da2:: with SMTP id u2mr27679699wrs.273.1638118678861;
        Sun, 28 Nov 2021 08:57:58 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id g18sm20503404wmq.4.2021.11.28.08.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 08:57:58 -0800 (PST)
Date:   Sun, 28 Nov 2021 17:57:56 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH 2/2] perf evsel: Improve error message for uncore events
Message-ID: <YaO1FIOYpF/Y5BDK@krava>
References: <20211123020341.3073673-1-irogers@google.com>
 <20211123020341.3073673-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123020341.3073673-2-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Nov 22, 2021 at 06:03:41PM -0800, Ian Rogers wrote:
> When a group has multiple events and the leader fails it can yield
> errors like:
> 
> $ perf stat -e '{uncore_imc/cas_count_read/},instructions' /bin/true
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (uncore_imc/cas_count_read/).
> /bin/dmesg | grep -i perf may provide additional information.
> 
> However, when not the group leader <not supported> is given:
> 
> $ perf stat -e '{instructions,uncore_imc/cas_count_read/}' /bin/true
> ...
>          1,619,057      instructions
>    <not supported> MiB  uncore_imc/cas_count_read/
> 
> This is necessary because get_group_fd will fail if the leader fails and
> is the direct result of the check on line 750 of builtin-stat.c in
> stat_handle_error that returns COUNTER_SKIP for the latter case.
> 
> This patch improves the error message to:
> 
> $ perf stat -e '{uncore_imc/cas_count_read/},instructions' /bin/true
> Error:
> Invalid event (uncore_imc/cas_count_read/) in per-thread mode, enable system wide with '-a'.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/evsel.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index a59fb2ecb84e..48696ff4bddb 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2950,6 +2950,11 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
>  			return scnprintf(msg, size, "wrong clockid (%d).", clockid);
>  		if (perf_missing_features.aux_output)
>  			return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
> +		if ((evsel__leader(evsel) == evsel) &&
> +		    (evsel->core.leader->nr_members > 1))
> +			return scnprintf(msg, size,
> +	"Invalid event (%s) in per-thread mode, enable system wide with '-a'.",
> +					evsel__name(evsel));

should we rather check 'target' pointer for the per-thread mode?
I'm not sure that per-thread mode will always be the case for the failure

jirka

>  		break;
>  	case ENODATA:
>  		return scnprintf(msg, size, "Cannot collect data source with the load latency event alone. "
> -- 
> 2.34.0.rc2.393.gf8c9666880-goog
> 

