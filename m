Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2437C636C8
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 20:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A8A1613D3
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 20:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240347AbhGOUPg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 16:15:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229700AbhGOUPg (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 16:15:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B0FA613C4;
        Thu, 15 Jul 2021 20:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626379962;
        bh=r6C0Mt7szLsEmJYWUx/QjykST9P+Liwu7CI1rc81z0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lEjied8bBLvPrPlYDVr1VTtjn89Lx4aoVSl71Zs9wcxq0IM0FPQgTPzediUGe2g4/
         clP3zSHga73Uuyuq/is5+fVEt4ypVYBo42OCnnlpSsJAQdCDeLGohsjyMEBUrNjb0j
         elGhKH+TFVOiZWT7L9vEurlGLcycwKEW3Uzz8uwjOswMxy/JunsOP2om4irvmqHhp5
         m18Ko4+b8cmV4l/xsPwkNKWEN7stDhb0ICZ77/WYJ3+4OhJuRny+M7uORAcE8LCx7f
         h9IBWxhjOo1R7miI7nYbmxZy4YZLFqKUpb+9CZe4Ho10yLrJcPSmLPCmmZ+mdHcWOI
         vFUrdmdk/dfPA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 26FD1403F2; Thu, 15 Jul 2021 17:12:40 -0300 (-03)
Date:   Thu, 15 Jul 2021 17:12:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 08/20] perf env: fix memory leak of cpu_pmu_caps
Message-ID: <YPCWuEZJdaq9Om/l@kernel.org>
References: <cover.1626343282.git.rickyman7@gmail.com>
 <6ba036a8220156ec1f3d6be3e5d25920f6145028.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ba036a8220156ec1f3d6be3e5d25920f6145028.1626343282.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jul 15, 2021 at 06:07:13PM +0200, Riccardo Mancini escreveu:
> ASan reports memory leaks while running the perf test
> "83: Zstd perf.data compression/decompression".
> The first of the leaks is caused by env->cpu_pmu_caps not being freed.
> 
> This patch adds the missing (z)free inside perf_env__exit.

Fixes: 6f91ea283a1ed23e ("perf header: Support CPU PMU capabilities")

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/util/env.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 6c765946ef6f591c..cec2e6cad8aabfe7 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -191,6 +191,7 @@ void perf_env__exit(struct perf_env *env)
>  	zfree(&env->sibling_threads);
>  	zfree(&env->pmu_mappings);
>  	zfree(&env->cpu);
> +	zfree(&env->cpu_pmu_caps);
>  	zfree(&env->numa_map);
>  
>  	for (i = 0; i < env->nr_numa_nodes; i++)
> -- 
> 2.31.1
> 

-- 

- Arnaldo
