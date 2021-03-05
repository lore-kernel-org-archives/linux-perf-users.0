Return-Path: <SRS0=HZIH=ID=vger.kernel.org=linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE7BC433DB
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 Mar 2021 17:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38BDE65051
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 Mar 2021 17:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhCERQ2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 5 Mar 2021 12:16:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:47266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229616AbhCERQ1 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 5 Mar 2021 12:16:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38B3F65051;
        Fri,  5 Mar 2021 17:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614964587;
        bh=/ltV4TybMsf7MDvvcwuffVYwQgFEEIM5tPdvWRCYeC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MS3VOelF40Y31R0Y19cdZw9H5NADPXMXD2TJNQX01N8VpEDl+oh0iMbDdKJb3t6NW
         O1roDkbe8y+Gx2hVWECPjFzb/xsYr0NqyTYSbFFRAo7nry1Iwl9qMB0Myu6yRCTf1d
         FH2MdsCq7gCciRRxBrC+o9y8AkPP+3hKkJdKnaRrC0gbjdLNuKOnsb+WXRrJP9RQeG
         JfOX9nFlUzBelbOiYTxKFaAe6MSLsXehRXpZV+nWC68unOJA+bkfyVnd3L79S0KK4D
         B7HPKwj7dZDxuVahhUm1ycaYw0olZ/eaRJ4tFBRzrYMz/y7EHqdk0nG0iV9UQsWLR+
         9lU2SuslGoHyA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DB86640647; Fri,  5 Mar 2021 14:16:24 -0300 (-03)
Date:   Fri, 5 Mar 2021 14:16:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     acme@redhat.com, linux-perf-users@vger.kernel.org,
        jolsa@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf trace: Fix race in signal handling
Message-ID: <YEJnaMzH2ctp3PPx@kernel.org>
References: <20210302144120.17362-1-mpetlan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302144120.17362-1-mpetlan@redhat.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Mar 02, 2021 at 03:41:20PM +0100, Michael Petlan escreveu:
> Since a lot of stuff happens before the SIGINT signal handler is registered
> (scanning /proc/*, etc.), on bigger systems, such as Cavium Sabre CN99xx,
> it may happen that first interrupt signal is lost and perf isn't correctly
> terminated.
> 
> The reproduction code might look like the following:
> 
>     perf trace -a &
>     PERF_PID=$!
>     sleep 4
>     kill -INT $PERF_PID
> 
> The issue has been found on a CN99xx machine with RHEL-8 and the patch fixes
> it by registering the signal handlers earlier in the init stage.

Thanks, applied.

- Arnaldo

 
> Suggested-by: Jiri Olsa <jolsa@redhat.com>
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> Tested-by: Michael Petlan <mpetlan@redhat.com>
> ---
>  tools/perf/builtin-trace.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 85b6a46e85b6..7ec18ff57fc4 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -3964,9 +3964,6 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  
>  	evlist__config(evlist, &trace->opts, &callchain_param);
>  
> -	signal(SIGCHLD, sig_handler);
> -	signal(SIGINT, sig_handler);
> -
>  	if (forks) {
>  		err = evlist__prepare_workload(evlist, &trace->opts.target, argv, false, NULL);
>  		if (err < 0) {
> @@ -4827,6 +4824,8 @@ int cmd_trace(int argc, const char **argv)
>  
>  	signal(SIGSEGV, sighandler_dump_stack);
>  	signal(SIGFPE, sighandler_dump_stack);
> +	signal(SIGCHLD, sig_handler);
> +	signal(SIGINT, sig_handler);
>  
>  	trace.evlist = evlist__new();
>  	trace.sctbl = syscalltbl__new();
> -- 
> 2.18.4
> 

-- 

- Arnaldo
