Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C10C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 May 2022 16:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245636AbiEJQx7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 10 May 2022 12:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244384AbiEJQx6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 10 May 2022 12:53:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A11E2A3758;
        Tue, 10 May 2022 09:50:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9618961804;
        Tue, 10 May 2022 16:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5F6C385C2;
        Tue, 10 May 2022 16:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652201400;
        bh=M5QlxoH55WD/dwJ1iirbL6SNOGHKFz/MZjqGMi+xavk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EOKP1K6rfZvBHmsOOwXh7XNzawOps+q79FTJopyppI3vp1RQ6CGtNAhQFRPH72XbZ
         DVLZyV6B5KRwmvC0B/ZshHEufxFm1DOA1s2v1rQtuL3hsMUxDK5oIlTlGpNzJZBk/r
         80uBtr/+idUwwRhfOrD8nJ5ckI1KDBdFhwPmEHI1NX3hMh51zBpHlJLIA/VQd+CzRI
         7V+mWaIgqkoMzfYrPHohEmY/pS0wNK+uWaFI90mUV89hzfs41KrhdgJPklUNM0y5pZ
         3QjLkLe4wN6QpC4Xr7UoyABNw5UOFnk+SocVY4EN2QuM3e83gRsPbzXG/CbuTWVqno
         h5gSJcl414+hQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 993EF400B1; Tue, 10 May 2022 13:49:57 -0300 (-03)
Date:   Tue, 10 May 2022 13:49:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Milian Wolff <milian.wolff@kdab.com>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Blake Jones <blakejones@google.com>
Subject: Re: [PATCH 1/4] perf report: Do not extend sample type of bpf-output
 event
Message-ID: <YnqXtRqW1phdtc7a@kernel.org>
References: <20220506201627.85598-1-namhyung@kernel.org>
 <20220506201627.85598-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506201627.85598-2-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, May 06, 2022 at 01:16:24PM -0700, Namhyung Kim escreveu:
> Currently evsel__new_idx() sets more sample_type bits when it finds a
> BPF-output event.  But it should honor what's recorded in the perf
> data file rather than blindly sets the bits.  Otherwise it could lead
> to a parse error when it recorded with a modified sample_type.

Can you please try to provide a Fixes: tag for this? This way reviewing
gets simpler by looking at who introduced this, if there was some reason
or if it was a plain oversight.

It also helps to get this fix propabated to the stable trees.

- Arnaldo
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/evsel.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d38722560e80..63a8b832b822 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -269,8 +269,8 @@ struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx)
>  		return NULL;
>  	evsel__init(evsel, attr, idx);
>  
> -	if (evsel__is_bpf_output(evsel)) {
> -		evsel->core.attr.sample_type |= (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME |
> +	if (evsel__is_bpf_output(evsel) && !attr->sample_type) {
> +		evsel->core.attr.sample_type = (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME |
>  					    PERF_SAMPLE_CPU | PERF_SAMPLE_PERIOD),
>  		evsel->core.attr.sample_period = 1;
>  	}
> -- 
> 2.36.0.512.ge40c2bad7a-goog

-- 

- Arnaldo
