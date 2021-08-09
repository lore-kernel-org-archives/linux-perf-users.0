Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9937DC4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 14:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80C956101D
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 14:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbhHIO6Y (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 10:58:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234454AbhHIO6X (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Aug 2021 10:58:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EAEB60E76;
        Mon,  9 Aug 2021 14:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628521083;
        bh=M5Q86Z/POkcqw7e7nUb37b0JJT7XMxwumXh/BqdONkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kcvupFxi3KMowIh3veFm7Wyk2di+Lew8tjp4bppKclq4pKytjMmf1AiBa5xg1lx1Z
         2qanyOOlbSNfn4dYKt4UaaQE7i8EYRvaDckIildbMcJzIeEJqX4/ScV3BaDHRwI1Mc
         /g4azgJQ3R4vUnaLvBaen6M/S6zVAeAbmXtq4zn/AlLWIrQ6zSXKMhQP724uiOfZ/7
         MWqtxp9A5y66w7y9ie5Ij3HNVHGBLyA+CmGrGPhqVX0oylayaksZPyYARSw7mZoZ+6
         sMU1AutjfSeSX+ppg8UZoCw9ytJVKiT2AKh1QU9+xGRj4JU3buksDqkH38kUGMGOTm
         egs3mqqgAOylA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BB989403F2; Mon,  9 Aug 2021 11:58:00 -0300 (-03)
Date:   Mon, 9 Aug 2021 11:58:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 6/7] perf/bench-futex, requeue: Robustify futex_wait()
 handling
Message-ID: <YRFCeLsjuIP321EZ@kernel.org>
References: <20210809043301.66002-1-dave@stgolabs.net>
 <20210809043301.66002-7-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809043301.66002-7-dave@stgolabs.net>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sun, Aug 08, 2021 at 09:33:00PM -0700, Davidlohr Bueso escreveu:
> Do not assume success and account for EAGAIN or any other return value,
> however unlikely.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  tools/perf/bench/futex-requeue.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
> index 80f40ee92b53..e4892ba6864f 100644
> --- a/tools/perf/bench/futex-requeue.c
> +++ b/tools/perf/bench/futex-requeue.c
> @@ -76,6 +76,8 @@ static void print_summary(void)
>  
>  static void *workerfn(void *arg __maybe_unused)
>  {
> +	int ret;
> +
>  	pthread_mutex_lock(&thread_lock);
>  	threads_starting--;
>  	if (!threads_starting)
> @@ -83,7 +85,18 @@ static void *workerfn(void *arg __maybe_unused)
>  	pthread_cond_wait(&thread_worker, &thread_lock);
>  	pthread_mutex_unlock(&thread_lock);
>  
> -	futex_wait(&futex1, 0, NULL, futex_flag);
> +	while (1) {
> +		ret = futex_wait(&futex1, 0, NULL, futex_flag);
> +		if (!ret)
> +			break;
> +
> +		if (ret && errno != EAGAIN) {
> +			if (!params.silent)
> +				warn("futex_wait");
> +			break;
> +		}
> +	}
> +
>  	return NULL;
>  }
>  
> -- 
> 2.26.2
> 

-- 

- Arnaldo
