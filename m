Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F4FC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 17:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7667860E09
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 17:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242066AbhJGRac (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Oct 2021 13:30:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46982 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233695AbhJGRac (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Oct 2021 13:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633627718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ViJ5p8KevpsaUvbYZqn5hx21O6LKPLxzKtvwaPa9zp0=;
        b=HGVI/oH4cJeBdYWreTh/iAB0aWHHKoNANZ2THJcU+XwIL9hla7Ho53WBFmbOVmzXYFe4mI
        aGAGkqDU5gASesZt/isuVkHX9oOKkT8TigX17G2Ulql9pzsB3LAeA3LC6K8Yk/5dYEBP2c
        kdve65Z44KjC0bElhjmMYMhs3VLRa48=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-3_8cGCPwNrGCY9IcyKmsyA-1; Thu, 07 Oct 2021 13:28:37 -0400
X-MC-Unique: 3_8cGCPwNrGCY9IcyKmsyA-1
Received: by mail-wr1-f72.google.com with SMTP id r16-20020adfbb10000000b00160958ed8acso5261779wrg.16
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Oct 2021 10:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ViJ5p8KevpsaUvbYZqn5hx21O6LKPLxzKtvwaPa9zp0=;
        b=1DNS+g/Iau8JLqWdUGbVPMWQqq/0zLzyJqwMm4QiU5lUr3You+8fwGFR9WvaHH5KT3
         7zhpWE7oN0Vnnw/68prCVdC0sWLurY8CDIWxwZEQtnFr30m/3v6bLxEzphdhDdeRvPBM
         rpQwDm1TcUyFFJlnXETbFkEJ7O0zQY3YLG/8Xb0g1MqtArdEFtf0mO7cOj2y0B5IHiRH
         E7Ao0+c7ph6TdsYSYa4ra+F+shRq8v6Y4Ix9oafjzeNfWH8HNIGYeV0qLgCUEo3RnCOI
         2jdI21uSeyEvRIYvyWZmPxNNyKq5q+ZGqxLC1bkYnu11zRqHk2KzcA38PBxgv7Bm5RBd
         iJfA==
X-Gm-Message-State: AOAM5301RnI+UVqfBx9n9WW/ruOrHPj/n/B73xDoOkjOZGw7nOrz9Gea
        Uggr2y/g/+Yx1C/XMgX9JP+za9GHdshR9bmpMvo8wbEp9eqkbIjMJoGLDbueDpX2TzuutUvtHkx
        /ohR0QDJUolNHnpMhNOQ76aUlrYBw3w==
X-Received: by 2002:a5d:47cd:: with SMTP id o13mr7243664wrc.85.1633627715917;
        Thu, 07 Oct 2021 10:28:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+RRNXynVbz5XW8Xfn9IkXFMxSU4suiHkgOksYtnJd77FNW7L2yKAJLyaQpxBlWgPI5lqf8g==
X-Received: by 2002:a5d:47cd:: with SMTP id o13mr7243638wrc.85.1633627715756;
        Thu, 07 Oct 2021 10:28:35 -0700 (PDT)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id k18sm210515wrn.81.2021.10.07.10.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 10:28:35 -0700 (PDT)
Date:   Thu, 7 Oct 2021 19:28:33 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robert Richter <robert.richter@amd.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 2/2] perf tools: Improve IBS error handling
Message-ID: <YV8uQVnMnnMd1Led@krava>
References: <20211004214114.188477-1-kim.phillips@amd.com>
 <20211004214114.188477-2-kim.phillips@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004214114.188477-2-kim.phillips@amd.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Oct 04, 2021 at 04:41:14PM -0500, Kim Phillips wrote:

SNIP

> ---
>  tools/perf/util/evsel.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index b915840690d4..f8a9cbd99314 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2743,9 +2743,22 @@ static bool find_process(const char *name)
>  	return ret ? false : true;
>  }
>  
> +static bool is_amd(const char *arch, const char *cpuid)
> +{
> +	return arch && !strcmp("x86", arch) && cpuid && strstarts(cpuid, "AuthenticAMD");
> +}
> +
> +static bool is_amd_ibs(struct evsel *evsel)
> +{
> +	return evsel->core.attr.precise_ip || !strncmp(evsel->pmu_name, "ibs", 3);
> +}
> +
>  int evsel__open_strerror(struct evsel *evsel, struct target *target,
>  			 int err, char *msg, size_t size)
>  {
> +	struct perf_env *env = evsel__env(evsel);
> +	const char *arch = perf_env__arch(env);
> +	const char *cpuid = perf_env__cpuid(env);
>  	char sbuf[STRERR_BUFSIZE];
>  	int printed = 0, enforced = 0;
>  
> @@ -2841,6 +2854,17 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
>  			return scnprintf(msg, size, "wrong clockid (%d).", clockid);
>  		if (perf_missing_features.aux_output)
>  			return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
> +		if (is_amd(arch, cpuid)) {
> +			if (is_amd_ibs(evsel)) {

would single 'is_amd_ibs' call be better? checking on both amd and ibs

jirka

> +				if (evsel->core.attr.exclude_kernel)
> +					return scnprintf(msg, size, 
> +	"AMD IBS can't exclude kernel events.  Try running at a higher privilege level.");
> +				if (!evsel->core.system_wide)
> +					return scnprintf(msg, size,
> +	"AMD IBS may only be available in system-wide/per-cpu mode.  Try using -a, or -C and workload affinity");
> +			}
> +		}
> +
>  		break;
>  	case ENODATA:
>  		return scnprintf(msg, size, "Cannot collect data source with the load latency event alone. "
> -- 
> 2.31.1
> 

