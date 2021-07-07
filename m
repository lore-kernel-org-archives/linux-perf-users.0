Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C323BC07E95
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jul 2021 18:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB98861C83
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jul 2021 18:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhGGSVJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Jul 2021 14:21:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59492 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232288AbhGGSUP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Jul 2021 14:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625681854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K07StvhPjMjrF6tq3BHilkcqj14o30L2eXhfZJ/lga8=;
        b=en5+16jtVbe+wlikFIoe/We6qL9lUCjcSENxbJKGW+3/eKQzexwuHMjjH09LPxPegBitkm
        8x48u64dlAdOcI8pFmXqpursD2prEj4xAeZix5JG/IFHGwIPj0zamwJ8EYc+sgNwlYT0Ho
        rgKQXQuknD98IVqSlgV/K2Jc1SUyknY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-e2_GK2ycPiKldIJEkG9D9A-1; Wed, 07 Jul 2021 14:17:33 -0400
X-MC-Unique: e2_GK2ycPiKldIJEkG9D9A-1
Received: by mail-wr1-f72.google.com with SMTP id u7-20020a5d46870000b029012786ba1bc9so1054999wrq.21
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Jul 2021 11:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K07StvhPjMjrF6tq3BHilkcqj14o30L2eXhfZJ/lga8=;
        b=FUyXcgb2CjWtCJo7y00N/vynGGIKoD9LlV3yG9cyRpa6z+edkpiuhS0wvlwY+FjcQT
         /H7Fu0GIyPcpuN6gONNfHPt4iNdGqwunior3MU81sS++neWTudd0Bqgq1Ad1DXwIGu/R
         An+28poAzv+yodjnUx2q4t+iy+/PRpcx0temiQVIwsR8Akc50y53WhN5Yq5i3KER19Su
         IP7fxf4MW7Z15D+LSGLh9vslaqgdgDXG8+W7rVOEQtDVevHQySNiiTTUm/xQyItqRQiY
         k3Z/LA466+UfyUnBamxodpj1cXKVOp79ily2X82PzrAsYnpdAEsTy2fNnd7izpMoRCTK
         2Bww==
X-Gm-Message-State: AOAM531rCCTSrBqeQUEfH6yuIxZPkHbIQVYhBcZTTy5mwFYnCfl5CtGz
        dDsBhgSWEHwUHnPJAxjbeibe2r2AzOBc8Z5/nbyIx8KzUaG0KRIqExNQYge28zAJTsLAo41zqSA
        9RwjWkb3depwRLPlMrDAELYwqR80fog==
X-Received: by 2002:a05:600c:4f4d:: with SMTP id m13mr378937wmq.61.1625681852375;
        Wed, 07 Jul 2021 11:17:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXktKMdwGkyALNP+XEtWN1XFXoZVRUNLy7lj0drkF0b2e2ggsV+32bJMo8bS3PGqcu4+7BOQ==
X-Received: by 2002:a05:600c:4f4d:: with SMTP id m13mr378918wmq.61.1625681852262;
        Wed, 07 Jul 2021 11:17:32 -0700 (PDT)
Received: from krava ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id h15sm20463100wrq.88.2021.07.07.11.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 11:17:31 -0700 (PDT)
Date:   Wed, 7 Jul 2021 20:17:27 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>, nakamura.shun@fujitsu.com,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/7] libperf: Move idx to perf_evsel::idx
Message-ID: <YOXvt/8qrKXyomQU@krava>
References: <20210706151704.73662-1-jolsa@kernel.org>
 <20210706151704.73662-3-jolsa@kernel.org>
 <YOW+3yhgNgMOrE99@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOW+3yhgNgMOrE99@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jul 07, 2021 at 11:49:03AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jul 06, 2021 at 05:16:59PM +0200, Jiri Olsa escreveu:
> > Moving evsel::idx to perf_evsel::idx, so we can move
> > the group interface to libperf.
> 
> I fixed up this, that appearead on my tree after you cooked up this
> patch:

great, thanks

jirka

> 
> diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
> index 21261f1a05011d62..89aa5e71db1a9a23 100644
> --- a/tools/perf/util/bpf_counter_cgroup.c
> +++ b/tools/perf/util/bpf_counter_cgroup.c
> @@ -124,7 +124,7 @@ static int bperf_load_program(struct evlist *evlist)
>  			map_fd = bpf_map__fd(skel->maps.events);
>  			for (cpu = 0; cpu < nr_cpus; cpu++) {
>  				int fd = FD(evsel, cpu);
> -				__u32 idx = evsel->idx * total_cpus +
> +				__u32 idx = evsel->core.idx * total_cpus +
>  					evlist->core.all_cpus->map[cpu];
>  
>  				err = bpf_map_update_elem(map_fd, &idx, &fd,
> @@ -221,7 +221,7 @@ static int bperf_cgrp__sync_counters(struct evlist *evlist)
>  
>  static int bperf_cgrp__enable(struct evsel *evsel)
>  {
> -	if (evsel->idx)
> +	if (evsel->core.idx)
>  		return 0;
>  
>  	bperf_cgrp__sync_counters(evsel->evlist);
> @@ -232,7 +232,7 @@ static int bperf_cgrp__enable(struct evsel *evsel)
>  
>  static int bperf_cgrp__disable(struct evsel *evsel)
>  {
> -	if (evsel->idx)
> +	if (evsel->core.idx)
>  		return 0;
>  
>  	bperf_cgrp__sync_counters(evsel->evlist);
> @@ -251,7 +251,7 @@ static int bperf_cgrp__read(struct evsel *evsel)
>  	int reading_map_fd, err = 0;
>  	__u32 idx;
>  
> -	if (evsel->idx)
> +	if (evsel->core.idx)
>  		return 0;
>  
>  	bperf_cgrp__sync_counters(evsel->evlist);
> @@ -263,7 +263,7 @@ static int bperf_cgrp__read(struct evsel *evsel)
>  	reading_map_fd = bpf_map__fd(skel->maps.cgrp_readings);
>  
>  	evlist__for_each_entry(evlist, evsel) {
> -		idx = evsel->idx;
> +		idx = evsel->core.idx;
>  		err = bpf_map_lookup_elem(reading_map_fd, &idx, values);
>  		if (err) {
>  			pr_err("bpf map lookup falied: idx=%u, event=%s, cgrp=%s\n",
> @@ -288,7 +288,7 @@ static int bperf_cgrp__read(struct evsel *evsel)
>  
>  static int bperf_cgrp__destroy(struct evsel *evsel)
>  {
> -	if (evsel->idx)
> +	if (evsel->core.idx)
>  		return 0;
>  
>  	bperf_cgroup_bpf__destroy(skel);
> 

