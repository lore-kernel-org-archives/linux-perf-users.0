Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4F9C432BE
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 14:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 562286103B
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 14:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbhHIO50 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 10:57:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234913AbhHIO50 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Aug 2021 10:57:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7055D60E97;
        Mon,  9 Aug 2021 14:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628521025;
        bh=FlYSWSwk9z2xhB576f+lFVqDh+ifBHtzsZcknVSLkrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JfmQTg6OvbSwJqW1p8oazLSL0yB3QXHBBRYbx6UklSQY2vQtoaGOGK0NAfo7dqXPM
         goRTREa6JqDzcfAAYEkoIMSXSoYaHigejNFrxpaoGJr1PC2DEPHaM5W3TspYnhZurs
         7K6kehWniyKe9dGvwVi73BdlNLER2DBjyrT98bmx1XEPh6gGTsz3/0B/qfUyJ9fS8c
         lCQIvTcbDX/UH5CudZYgmoU27F0KTDB20/s0hIFVgoB9wwMOm1az5h04n5CluAdYxT
         PHj0fZBxKdAmV79PeAO9mv+yHEvFwcI2SG2lklXbOk91cSm5/jaASryK4xCzNC5CfF
         QZo9IZoJA1r8A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 33F21410A0; Mon,  9 Aug 2021 11:57:03 -0300 (-03)
Date:   Mon, 9 Aug 2021 11:57:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 5/7] perf/bench-futex, requeue: Add --broadcast option
Message-ID: <YRFCP+oNfB+R1HQy@kernel.org>
References: <20210809043301.66002-1-dave@stgolabs.net>
 <20210809043301.66002-6-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809043301.66002-6-dave@stgolabs.net>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sun, Aug 08, 2021 at 09:32:59PM -0700, Davidlohr Bueso escreveu:
> Such that all threads are requeued to uaddr2 in a single
> futex_cmp_requeue(), unlike the default, which is 1.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  tools/perf/bench/futex-requeue.c | 4 ++++
>  tools/perf/bench/futex.h         | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
> index 88cb7e2a6729..80f40ee92b53 100644
> --- a/tools/perf/bench/futex-requeue.c
> +++ b/tools/perf/bench/futex-requeue.c
> @@ -52,6 +52,7 @@ static const struct option options[] = {
>  	OPT_BOOLEAN( 's', "silent",   &params.silent, "Silent mode: do not display data/details"),
>  	OPT_BOOLEAN( 'S', "shared",   &params.fshared, "Use shared futexes instead of private ones"),
>  	OPT_BOOLEAN( 'm', "mlockall", &params.mlockall, "Lock all current and future memory"),
> +	OPT_BOOLEAN( 'B', "broadcast", &params.broadcast, "Requeue all threads at once"),
>  	OPT_END()
>  };
>  
> @@ -153,6 +154,9 @@ int bench_futex_requeue(int argc, const char **argv)
>  	if (params.nrequeue > params.nthreads)
>  		params.nrequeue = params.nthreads;
>  
> +	if (params.broadcast)
> +		params.nrequeue = params.nthreads;
> +
>  	printf("Run summary [PID %d]: Requeuing %d threads (from [%s] %p to %p), "
>  	       "%d at a time.\n\n",  getpid(), params.nthreads,
>  	       params.fshared ? "shared":"private", &futex1, &futex2, params.nrequeue);
> diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
> index 1c8fa469993f..36f158650edf 100644
> --- a/tools/perf/bench/futex.h
> +++ b/tools/perf/bench/futex.h
> @@ -21,6 +21,7 @@ struct bench_futex_parameters {
>  	bool fshared;
>  	bool mlockall;
>  	bool multi; /* lock-pi */
> +	bool broadcast; /* requeue */
>  	unsigned int runtime; /* seconds*/
>  	unsigned int nthreads;
>  	unsigned int nfutexes;
> -- 
> 2.26.2
> 

-- 

- Arnaldo
