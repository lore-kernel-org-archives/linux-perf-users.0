Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1109C48BE5
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 18:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EC6261289
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 18:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbhFVSYJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Jun 2021 14:24:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232371AbhFVSYI (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Jun 2021 14:24:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD57A61076;
        Tue, 22 Jun 2021 18:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624386112;
        bh=nqaGJKQEtPIDNmBRv7DTB1VwYps0osDX25ORTNP4V6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qDgiYgtmegu6yOUOujhzEC+ohrUTSFYB7e+861sQkNLfj+ty3zHMQzuFift6YJ4Zd
         7g2pRFOhE9SQHcvZihsMXtTcPeo+H7naHOcQXelGM/reYBYNxNy40Rb4qNgi/UUo/9
         7x4siQbIljWSCuJTuF+9EYZ3RQJjTOkoT41Ml00nx3Whn9yIPbO8nw9TYZwByuj75Z
         TNjtY5kZSnnE/Zjf02vTiVCN1MNfcu8oBlyH66D2pKhQt0PnAhncqWiKR1L8SmEBjr
         QrXPwoTf5Y58E9jO+84iH4GENlb7SwLxpVeybflUpiD3qROKmlDYr2oP/0bHjwvUJ7
         7NuJ1QR552HHw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0C93A40B1A; Tue, 22 Jun 2021 15:21:49 -0300 (-03)
Date:   Tue, 22 Jun 2021 15:21:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 03/11] perf script: Share addr_al between functions
Message-ID: <YNIqPIIKqmWrfl5n@kernel.org>
References: <20210621150514.32159-1-adrian.hunter@intel.com>
 <20210621150514.32159-4-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621150514.32159-4-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Jun 21, 2021 at 06:05:06PM +0300, Adrian Hunter escreveu:
> Share the addr_location of 'addr' so that it need not be resolved more than
> once.

Another nice patch, i.e. don't resolve it unconditionally, let the first
function that needs it under a callchain to do it, then reuse if another
needs it.

Looks ok, applied.

- Arnaldo
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/builtin-script.c | 38 +++++++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index ff7b43899f2e..d2771a997e26 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1337,17 +1337,18 @@ static const char *resolve_branch_sym(struct perf_sample *sample,
>  				      struct evsel *evsel,
>  				      struct thread *thread,
>  				      struct addr_location *al,
> +				      struct addr_location *addr_al,
>  				      u64 *ip)
>  {
> -	struct addr_location addr_al;
>  	struct perf_event_attr *attr = &evsel->core.attr;
>  	const char *name = NULL;
>  
>  	if (sample->flags & (PERF_IP_FLAG_CALL | PERF_IP_FLAG_TRACE_BEGIN)) {
>  		if (sample_addr_correlates_sym(attr)) {
> -			thread__resolve(thread, &addr_al, sample);
> -			if (addr_al.sym)
> -				name = addr_al.sym->name;
> +			if (!addr_al->thread)
> +				thread__resolve(thread, addr_al, sample);
> +			if (addr_al->sym)
> +				name = addr_al->sym->name;
>  			else
>  				*ip = sample->addr;
>  		} else {
> @@ -1365,7 +1366,9 @@ static const char *resolve_branch_sym(struct perf_sample *sample,
>  static int perf_sample__fprintf_callindent(struct perf_sample *sample,
>  					   struct evsel *evsel,
>  					   struct thread *thread,
> -					   struct addr_location *al, FILE *fp)
> +					   struct addr_location *al,
> +					   struct addr_location *addr_al,
> +					   FILE *fp)
>  {
>  	struct perf_event_attr *attr = &evsel->core.attr;
>  	size_t depth = thread_stack__depth(thread, sample->cpu);
> @@ -1382,7 +1385,7 @@ static int perf_sample__fprintf_callindent(struct perf_sample *sample,
>  	if (thread->ts && sample->flags & PERF_IP_FLAG_RETURN)
>  		depth += 1;
>  
> -	name = resolve_branch_sym(sample, evsel, thread, al, &ip);
> +	name = resolve_branch_sym(sample, evsel, thread, al, addr_al, &ip);
>  
>  	if (PRINT_FIELD(DSO) && !(PRINT_FIELD(IP) || PRINT_FIELD(ADDR))) {
>  		dlen += fprintf(fp, "(");
> @@ -1466,6 +1469,7 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
>  				    struct evsel *evsel,
>  				    struct thread *thread,
>  				    struct addr_location *al,
> +				    struct addr_location *addr_al,
>  				    struct machine *machine, FILE *fp)
>  {
>  	struct perf_event_attr *attr = &evsel->core.attr;
> @@ -1474,7 +1478,7 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
>  	int printed = 0;
>  
>  	if (PRINT_FIELD(CALLINDENT))
> -		printed += perf_sample__fprintf_callindent(sample, evsel, thread, al, fp);
> +		printed += perf_sample__fprintf_callindent(sample, evsel, thread, al, addr_al, fp);
>  
>  	/* print branch_from information */
>  	if (PRINT_FIELD(IP)) {
> @@ -1931,7 +1935,8 @@ static void perf_sample__fprint_metric(struct perf_script *script,
>  static bool show_event(struct perf_sample *sample,
>  		       struct evsel *evsel,
>  		       struct thread *thread,
> -		       struct addr_location *al)
> +		       struct addr_location *al,
> +		       struct addr_location *addr_al)
>  {
>  	int depth = thread_stack__depth(thread, sample->cpu);
>  
> @@ -1947,7 +1952,7 @@ static bool show_event(struct perf_sample *sample,
>  	} else {
>  		const char *s = symbol_conf.graph_function;
>  		u64 ip;
> -		const char *name = resolve_branch_sym(sample, evsel, thread, al,
> +		const char *name = resolve_branch_sym(sample, evsel, thread, al, addr_al,
>  				&ip);
>  		unsigned nlen;
>  
> @@ -1972,6 +1977,7 @@ static bool show_event(struct perf_sample *sample,
>  static void process_event(struct perf_script *script,
>  			  struct perf_sample *sample, struct evsel *evsel,
>  			  struct addr_location *al,
> +			  struct addr_location *addr_al,
>  			  struct machine *machine)
>  {
>  	struct thread *thread = al->thread;
> @@ -2005,7 +2011,7 @@ static void process_event(struct perf_script *script,
>  		perf_sample__fprintf_flags(sample->flags, fp);
>  
>  	if (is_bts_event(attr)) {
> -		perf_sample__fprintf_bts(sample, evsel, thread, al, machine, fp);
> +		perf_sample__fprintf_bts(sample, evsel, thread, al, addr_al, machine, fp);
>  		return;
>  	}
>  
> @@ -2168,6 +2174,7 @@ static int process_sample_event(struct perf_tool *tool,
>  {
>  	struct perf_script *scr = container_of(tool, struct perf_script, tool);
>  	struct addr_location al;
> +	struct addr_location addr_al;
>  
>  	if (perf_time__ranges_skip_sample(scr->ptime_range, scr->range_num,
>  					  sample->time)) {
> @@ -2197,7 +2204,10 @@ static int process_sample_event(struct perf_tool *tool,
>  	if (al.filtered)
>  		goto out_put;
>  
> -	if (!show_event(sample, evsel, al.thread, &al))
> +	/* Set thread to NULL to indicate addr_al is not initialized */
> +	addr_al.thread = NULL;
> +
> +	if (!show_event(sample, evsel, al.thread, &al, &addr_al))
>  		goto out_put;
>  
>  	if (evswitch__discard(&scr->evswitch, evsel))
> @@ -2205,16 +2215,16 @@ static int process_sample_event(struct perf_tool *tool,
>  
>  	if (scripting_ops) {
>  		struct addr_location *addr_al_ptr = NULL;
> -		struct addr_location addr_al;
>  
>  		if ((evsel->core.attr.sample_type & PERF_SAMPLE_ADDR) &&
>  		    sample_addr_correlates_sym(&evsel->core.attr)) {
> -			thread__resolve(al.thread, &addr_al, sample);
> +			if (!addr_al.thread)
> +				thread__resolve(al.thread, &addr_al, sample);
>  			addr_al_ptr = &addr_al;
>  		}
>  		scripting_ops->process_event(event, sample, evsel, &al, addr_al_ptr);
>  	} else {
> -		process_event(scr, sample, evsel, &al, machine);
> +		process_event(scr, sample, evsel, &al, &addr_al, machine);
>  	}
>  
>  out_put:
> -- 
> 2.17.1
> 

-- 

- Arnaldo
