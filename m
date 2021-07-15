Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2814BC636CA
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 20:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0723D613BB
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 20:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243964AbhGOUFF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 16:05:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346517AbhGOUEy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 16:04:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3D466128C;
        Thu, 15 Jul 2021 20:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626379320;
        bh=IummxTc4JRlXQtiz0o5C7rVL+MKKmoxVNrkyDkv/s/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F54UFW1vnLmr+UE5jzbfibNxLGg17oUC428MMDgos6h2er6f3oOwD8x7la5zNI7NF
         TywcjNLfBO2RBVeu6DO1Xk7bQzPnHiQKBVCf14S5AbsdJwWeCreAmtSIC3g8mKcz9J
         0G/m420uhr0ugvUxISi8lAMu/C+IkPrAJq86xutNLgcdWDRdq6kUsNQKZcxVRPEBsv
         wVvfqkf79iz2mu4zuti7u/Ksz8jjQGZR8t8zrbgJ7AbKPyO3lRQBx7cdA7WrYRg6Z1
         aeGSZ1Oh2cyEWBRV3nxZbXAQWyeJPj0Eava3QAAMn//rGgXtVId50p4hq2pWR8fbol
         PiuiTwAX+qZzQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6AC05403F2; Thu, 15 Jul 2021 17:01:57 -0300 (-03)
Date:   Thu, 15 Jul 2021 17:01:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 06/20] perf dso: fix memory leak in dso__new_map
Message-ID: <YPCUNe2VGAsL+OCg@kernel.org>
References: <cover.1626343282.git.rickyman7@gmail.com>
 <60bfe0cd06e89e2ca33646eb8468d7f5de2ee597.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60bfe0cd06e89e2ca33646eb8468d7f5de2ee597.1626343282.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jul 15, 2021 at 06:07:11PM +0200, Riccardo Mancini escreveu:
> ASan reports a memory leak when running the perf test
> "65: maps__merge_in". The causes of the leaks are two, this patch
> addresses only the first one, which is related to dso__new_map.
> The bug is that dso__new_map creates a new dso but never decreases
> the refcount it gets from creating it.
> 
> This patch adds the missing dso__put.

Thanks, applied.

This needs some extra thinking for some unrelated issue, namely that
this dso isn't linked in the machine dso list, I think this is only used
by 'perf probe' :-\

I guess this won't be a problem since using the machine dso list is
important just for other tools, like when traversing to get the
build-ids, etc.

- Arnaldo
 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/util/dso.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index d786cf6b0cfa65f2..ee15db2be2f43403 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -1154,8 +1154,10 @@ struct map *dso__new_map(const char *name)
>  	struct map *map = NULL;
>  	struct dso *dso = dso__new(name);
>  
> -	if (dso)
> +	if (dso) {
>  		map = map__new2(0, dso);
> +		dso__put(dso);
> +	}
>  
>  	return map;
>  }
> -- 
> 2.31.1
> 

-- 

- Arnaldo
