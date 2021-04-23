Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CE7C433ED
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Apr 2021 13:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F90961458
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Apr 2021 13:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhDWNlO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Apr 2021 09:41:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhDWNlM (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Apr 2021 09:41:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B76D361352;
        Fri, 23 Apr 2021 13:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619185236;
        bh=wO7XEt5yo8xj6mXlT5bhC3QSmJWtxF0ejIkJ/7vvnHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b9IApsIprIJfDv3jCRT0S7MopYzRdhARsJQJmd1w4sRz0u63G/GBHGyHDIiEQHkr4
         J0txO/rYYArxeig1yG6Z1m0pVRmhgkYlpEi1TB1HY+q30+D+vojyd95he57RkLacxd
         qQtoadS6uvQCAUyAEG0g5+kl8fhzegpkMmf2ypKrAEMbBN3PxL0QLfBfR46iEHAtHJ
         3Vdr17tdzTvPQJGa44K40dXAn44Nvd/YCb4rZGhvhemMyt/z0lRSvZbGgz7Kb5OyeH
         1FGl9FwY2318dDoQOJabmTVrKGQ7J6wic5STp6fcVKM34Wlxe34jhtYtb6WU9hcClD
         eWRSCHJ4cfE9Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3D53C40647; Fri, 23 Apr 2021 10:40:32 -0300 (-03)
Date:   Fri, 23 Apr 2021 10:40:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Alexander Schmidt <alexschm@de.ibm.com>
Subject: Re: [PATCH] [PING] perf ftrace: Command fails on s390
Message-ID: <YILOUOd2bHxuopJv@kernel.org>
References: <20210421120400.2126433-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421120400.2126433-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Apr 21, 2021 at 02:04:00PM +0200, Thomas Richter escreveu:
> Command 'perf ftrace -v -- ls' fails in s390 (at least 5.12.0rc6).
> 
> The root cause is a missing pointer dereference which causes an
> array element address to be used as PID.
> 
> Fix this by extracting the PID.

Thanks, applied.

- Arnaldo

 
> Output before:
>   # ./perf ftrace -v -- ls
>   function_graph tracer is used
>   write '-263732416' to tracing/set_ftrace_pid failed: Invalid argument
>   failed to set ftrace pid
>   #
> 
> Output after:
>    ./perf ftrace -v -- ls
>    function_graph tracer is used
>    # tracer: function_graph
>    #
>    # CPU  DURATION                  FUNCTION CALLS
>    # |     |   |                     |   |   |   |
>    4)               |  rcu_read_lock_sched_held() {
>    4)   0.552 us    |    rcu_lockdep_current_cpu_online();
>    4)   6.124 us    |  }
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Reported-by: Alexander Schmidt <alexschm@de.ibm.com>
> ---
>  tools/perf/builtin-ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index d49448a1060c..87cb11a7a3ee 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -289,7 +289,7 @@ static int set_tracing_pid(struct perf_ftrace *ftrace)
>  
>  	for (i = 0; i < perf_thread_map__nr(ftrace->evlist->core.threads); i++) {
>  		scnprintf(buf, sizeof(buf), "%d",
> -			  ftrace->evlist->core.threads->map[i]);
> +			  perf_thread_map__pid(ftrace->evlist->core.threads, i));
>  		if (append_tracing_file("set_ftrace_pid", buf) < 0)
>  			return -1;
>  	}
> -- 
> 2.30.2
> 

-- 

- Arnaldo
