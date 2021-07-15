Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562CBC636CB
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 19:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45BC1613E4
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 19:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242354AbhGOTGx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 15:06:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241738AbhGOTFv (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 15:05:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3596E613F8;
        Thu, 15 Jul 2021 19:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626375739;
        bh=n2XZJyZBIm6enyikoJCT42Xvt6qjE7EzdCfC71Yt4AA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cQagM3RJLZVZLHygmSWPy1TDr+T/gXWDrLq5uVgwQd3UvioXizA06K7o05LSnw+nd
         RKKZywBOeij2NbGsb+Xept6EGu7Qmr8tz4T3a/zdyAsJP/4UZED3KM+dBG9QYb9Rzf
         oTKtQSXdDeE+pI1Gb4mkY1bjoiyGcQHYhbpX5ijfjcSMED4nhcFMysk/Tvy+kEwbna
         L03rzsBXVZClzZQ5qnVim9YtoDp0joInrAsinAZQGyNAnYyKjaciVxLQ5ufpusp8DN
         4r1Q0JDT6hpIK8a9CkLsMeNVMxkuW28lM0BKybKJa9pO/LKUZD8ZlZ5Rgf10eeV0Fd
         lcAImxPfpfqxA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 11192403F2; Thu, 15 Jul 2021 16:02:16 -0300 (-03)
Date:   Thu, 15 Jul 2021 16:02:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 01/20] perf nsinfo: fix refcounting
Message-ID: <YPCGONcQx5SxEKdY@kernel.org>
References: <cover.1626343282.git.rickyman7@gmail.com>
 <55223bc8821b34ccb01f92ef1401c02b6a32e61f.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55223bc8821b34ccb01f92ef1401c02b6a32e61f.1626343282.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jul 15, 2021 at 06:07:06PM +0200, Riccardo Mancini escreveu:
> ASan reports a memory leak of nsinfo during the execution of the perf
> test "31: Lookup mmap thread".
> The leak is caused by a refcounted variable being replaced without
> dropping the refcount.
> 
> This patch makes sure that the refcnt of nsinfo is decreased whenever
> a refcounted variable is replaced with a new value.

So, there are multiple fixes in just one patch, I'll split it into
three, no need to resend.

I'll try and check if finding Fixes: for the three is easy, that way
stable@vger.kernel.org will figure out which of the supported releases
need each of them.

- Arnaldo
 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/builtin-inject.c   | 5 +++--
>  tools/perf/util/map.c         | 2 ++
>  tools/perf/util/probe-event.c | 4 +++-
>  3 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 5d6f583e2cd35be0..ffd2b25039e36e1d 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -361,9 +361,10 @@ static struct dso *findnew_dso(int pid, int tid, const char *filename,
>  		dso = machine__findnew_dso_id(machine, filename, id);
>  	}
>  
> -	if (dso)
> +	if (dso) {
> +		nsinfo__put(dso->nsinfo);
>  		dso->nsinfo = nsi;
> -	else
> +	} else
>  		nsinfo__put(nsi);
>  
>  	thread__put(thread);
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 8af693d9678cefe0..72e7f3616157ead4 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -192,6 +192,8 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
>  			if (!(prot & PROT_EXEC))
>  				dso__set_loaded(dso);
>  		}
> +
> +		nsinfo__put(dso->nsinfo);
>  		dso->nsinfo = nsi;
>  
>  		if (build_id__is_defined(bid))
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index c14e1d228e56b1c6..e05750cea34c3a95 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -179,8 +179,10 @@ struct map *get_target_map(const char *target, struct nsinfo *nsi, bool user)
>  		struct map *map;
>  
>  		map = dso__new_map(target);
> -		if (map && map->dso)
> +		if (map && map->dso) {
> +			nsinfo__put(map->dso->nsinfo);
>  			map->dso->nsinfo = nsinfo__get(nsi);
> +		}
>  		return map;
>  	} else {
>  		return kernel_get_module_map(target);
> -- 
> 2.31.1
> 

-- 

- Arnaldo
