Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC90CC433DB
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Mar 2021 12:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4D2A6525D
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Mar 2021 12:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhCIMoC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Mar 2021 07:44:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:37788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230035AbhCIMnh (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Mar 2021 07:43:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBBB06525D;
        Tue,  9 Mar 2021 12:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615293817;
        bh=l58iItmZQGJPweaube6PIDqUcgRkuD2TOrah5baM3cU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RdPolfblsqxpLUpZuy2lYBPMklWX0XgB+wYofJi9HjtSiHTpxLXmU2Uz3lqqDDQFP
         brhb0ZO8Thsq3fGMv0UGU91kGMxRNRE7ldCVlBiq23O+fsDL6LnD92o+eBRGIUtJj4
         Lqoo06RK82lhEAmr5KcR4xNCTS9462JgHjIzxTsUg081p01RWAyVFjXB3LxXIPOvSV
         0JqGn6WTpYLDbXDJ20VCAlZiD9HZitQGwhCZ4GpCh5oiKwalrt2SNGDY/rQeRiWiC7
         OjtNrYH40heDP4KLxsS55EQnXcBeSreo9le//5hbVFp4jEd3V2RIblC3JOKCrOpMEb
         CS/V67QXHZrBw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DA44140647; Tue,  9 Mar 2021 09:43:34 -0300 (-03)
Date:   Tue, 9 Mar 2021 09:43:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH] tool/perf: Perf build fails on 5.12.0rc2 on s390
Message-ID: <YEdtdrb5GOaDIUlt@kernel.org>
References: <20210309110447.834292-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210309110447.834292-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Mar 09, 2021 at 12:04:47PM +0100, Thomas Richter escreveu:
> perf build fails on 5.12.0rc2 on s390 with this error message:
> 
> util/synthetic-events.c: In function
> 				‘__event__synthesize_thread.part.0.isra’:
> util/synthetic-events.c:787:19: error: ‘kernel_thread’ may be
>     used uninitialized in this function [-Werror=maybe-uninitialized]
>     787 |   if (_pid == pid && !kernel_thread) {
>         |       ~~~~~~~~~~~~^~~~~~~~~~~~~~~~~
> 
> The build succeeds using command 'make DEBUG=y'.
> 
> The variable kernel_thread is set by this function sequence:
> 
> __event__synthesize_thread()
> |    defines bool kernel_thread; as local variable and calls
> +--> perf_event__prepare_comm(..., &kernel_thread)
>      +--> perf_event__get_comm_ids(..., bool *kernel);
>           On return of this function variable kernel is always
>           set to true of false.

    s/of/or/

But it is only called for the host 'struct machine', if that is not the
case, then the value of 'kernel_thread' is left undefined/uninitialized,
right?

> 
> To prevent this compile error, assign variable kernel_thread
> a value when it is defined.

Applied, and added:

Fixes: c1b907953b2cd9ff ("perf tools: Skip PERF_RECORD_MMAP event synthesis for kernel threads")

Changed the subject to:

perf synthetic-events: Fix uninitialized 'kernel_thread' variable

As this doesn't affect just s/390, it is entirely possible that that
variable gets used with an undefined value.

- Arnaldo
 
> Output after:
> [root@m35lp76 perf]# make  util/synthetic-events.o
> ....
>  CC       util/synthetic-events.o
> [root@m35lp76 perf]#
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/util/synthetic-events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index b698046ec2db..5dd451695f33 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -758,7 +758,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
>  	for (i = 0; i < n; i++) {
>  		char *end;
>  		pid_t _pid;
> -		bool kernel_thread;
> +		bool kernel_thread = false;
>  
>  		_pid = strtol(dirent[i]->d_name, &end, 10);
>  		if (*end)
> -- 
> 2.29.2
> 

-- 

- Arnaldo
