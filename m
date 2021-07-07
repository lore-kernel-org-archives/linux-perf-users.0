Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4572FC07E95
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jul 2021 18:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2281C61CB0
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jul 2021 18:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhGGSQx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Jul 2021 14:16:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48861 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229519AbhGGSQx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Jul 2021 14:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625681650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6rJ11vEGolL0CsQ0bW2KSCPOtjG7fcFPdao2YCIE2kg=;
        b=IKvJNgVdp1enmBVpq6+ucQmO2STLNIkyLyTq+muotmFrhZZ7YwihMwjz8iNsiqAkkrH59r
        colWsCN082t/GMPT9YEJ1efZ7B5iGI8rGYdUPCICCehXnEQ7KCKPS6QIbyqdUSqx3mDKGf
        r2YiFMXhzQ7qZ0xdNGB9R6y5zBzJgJw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-ruwWK39XNLCiizWAS-3_Hg-1; Wed, 07 Jul 2021 14:14:09 -0400
X-MC-Unique: ruwWK39XNLCiizWAS-3_Hg-1
Received: by mail-wm1-f70.google.com with SMTP id a13-20020a7bc1cd0000b02902104c012aa3so2508881wmj.9
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Jul 2021 11:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6rJ11vEGolL0CsQ0bW2KSCPOtjG7fcFPdao2YCIE2kg=;
        b=o8N58WT8OvtI335/AdlYo3HZE6VvNDuHcv6NtEUZhPhwZB6TGnWTtiWqncGJRrQbuU
         nOak7G7xkyfzMU6e9AvM+JnNT/UT55uMEQaakA278qqCmZ6yMnxf014+1sNtEiBx36wR
         c3qpZFqvXXjK7qdVY3XrGXYH+feUvTNmPiMJwd0rD6I5ksqioUHjc/Ht/t3Q2A8GGW3c
         djuujA+CXLuXUrNVz6RvQX+ewbsWvYarez8ObsyArmzdV1q63phdY/7kdum+a95Til5c
         cseEWK8smm3EnmqgG5Y2PtHmifRqsXswkW20I1jErN/Pn4FlBnMPsHiIq9juF76u5saL
         vLzQ==
X-Gm-Message-State: AOAM5317KsRJLHwygASTLXyHKnP31v4/KO/eoo2BLjxOyvZB+A9PnUe6
        n693STWcLXfskyEqhAOwUN1/QVHkItD806MJeGGvm2BALOre3kxn74sZ4R3yQ99YdjAFunUd4Wo
        WmEOH9VtB8qCvIMO5LihEcUU4B6br+A==
X-Received: by 2002:a5d:4e4e:: with SMTP id r14mr26491515wrt.251.1625681648346;
        Wed, 07 Jul 2021 11:14:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpk+uUcfOJdRYj06sTwADzln4PNWPCzs2W9QGRHenPJa1Gwn70Dlib1jqaBcWcgPKSPZy2kw==
X-Received: by 2002:a5d:4e4e:: with SMTP id r14mr26491488wrt.251.1625681648168;
        Wed, 07 Jul 2021 11:14:08 -0700 (PDT)
Received: from krava ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id p9sm20681891wrx.59.2021.07.07.11.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 11:14:07 -0700 (PDT)
Date:   Wed, 7 Jul 2021 20:14:04 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>, nakamura.shun@fujitsu.com,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/7] libperf: Move leader to perf_evsel::leader
Message-ID: <YOXu7PPoaJ0cpeQI@krava>
References: <20210706151704.73662-1-jolsa@kernel.org>
 <20210706151704.73662-4-jolsa@kernel.org>
 <YOW/5+Ep7JpL4qLL@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOW/5+Ep7JpL4qLL@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jul 07, 2021 at 11:53:27AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jul 06, 2021 at 05:17:00PM +0200, Jiri Olsa escreveu:
> > Moving evsel::leader to perf_evsel::leader, so we can move
> > the group interface to libperf.
> 
> I also had to apply this, because you didn't build with
> BUILD_BPF_SKEL=1, right?

ah right.. I also plan to build in arm/s390/ppc,
so I'll take what you have in tmp.perf/core

thanks,
jirka

> 
> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> index 1d0b9742f7271966..8150e03367bbafad 100644
> --- a/tools/perf/util/bpf_counter.c
> +++ b/tools/perf/util/bpf_counter.c
> @@ -353,7 +353,7 @@ static int bperf_check_target(struct evsel *evsel,
>  			      enum bperf_filter_type *filter_type,
>  			      __u32 *filter_entry_cnt)
>  {
> -	if (evsel->leader->core.nr_members > 1) {
> +	if (evsel->core.leader->nr_members > 1) {
>  		pr_err("bpf managed perf events do not yet support groups.\n");
>  		return -1;
>  	}
> 

