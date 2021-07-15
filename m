Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93130C636CD
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 19:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E9CD61374
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 19:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbhGOTwv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 15:52:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347358AbhGOTwX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 15:52:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 107D061073;
        Thu, 15 Jul 2021 19:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626378570;
        bh=KXCm1A076DPrtlFUA5qZsd5SDqWL2dBoIWTzb3neksE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xx6cGAYxVKkd8Nn8Y1gjAtKqpfTnEOxrL/iST7NHGMwQ6rM7m+YBVu5jJotgkCpPi
         CvjU0i7bJDkVGa+qHkfjoof92pw7W69LoWmmHjF4H9D+x8JaCoA2nsBctn3/EJxoPS
         dRdZvG65hmylmAb8mbwyM6HyezY56b/spuTll7lgnSEECs5r1X+S5sXgz1RjkrW6dT
         abMVWfyggRQEA7m/1bymNPQ64NKZOEBJx4kpWnztsNCAoHCoYNM7H1MyVJLPPtzRHz
         VqUZNpu8ZdxFcT7CJ4sUgqHORxdmctBAwmoz15LLIKw3XuWzLAFP1+VAPiKvo0wHVN
         Gj+yi3Vfn49aQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9E6CC403F2; Thu, 15 Jul 2021 16:49:27 -0300 (-03)
Date:   Thu, 15 Jul 2021 16:49:27 -0300
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
Subject: Re: [PATCH 02/20] perf env: fix sibling_dies memory leak
Message-ID: <YPCRR8jv47kHG/xC@kernel.org>
References: <cover.1626343282.git.rickyman7@gmail.com>
 <2140d0b57656e4eb9021ca9772250c24c032924b.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2140d0b57656e4eb9021ca9772250c24c032924b.1626343282.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jul 15, 2021 at 06:07:07PM +0200, Riccardo Mancini escreveu:
> ASan reports a memory leak in perf_env while running the perf test
> "41: Session topology", caused by sibling_dies not being freed.
> 
> This patch adds the required free.
 
> Fixes: acae8b36cded0ee6 ("perf header: Add die information in CPU topology")

So, I CC the author of the patch and its committer, using this shell
script:

  $ cat ~/bin/fixes
  #!/bin/bash
  
  cset=$1
  if [ $# -eq 0 ] ; then
  	read cset
  fi
  git show --pretty=fuller $cset | grep '^\(Author\|Commit\): ' | sed -r 's/.*: +/Cc: /g' | grep -v "Arnaldo Carvalho de Melo" | sort -u
  echo Fixes: `git one $cset`
  $
  $ grep one -B1 ~/.gitconfig
  [alias]
	one = show -s --pretty='format:%h (\"%s\")'
  $
  $ fixes acae8b36cded0ee6
  Cc: Kan Liang <kan.liang@linux.intel.com>
  Fixes: acae8b36cded0ee6 ("perf header: Add die information in CPU topology")
  $

Normally I copy the cset SHA and, in vim, select it and run !fixes, i.e.

:'<,'>!fixes

Thanks, applied.

- Arnaldo

> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/util/env.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index ebc5e9ad35db21d1..6c765946ef6f591c 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -186,6 +186,7 @@ void perf_env__exit(struct perf_env *env)
>  	zfree(&env->cpuid);
>  	zfree(&env->cmdline);
>  	zfree(&env->cmdline_argv);
> +	zfree(&env->sibling_dies);
>  	zfree(&env->sibling_cores);
>  	zfree(&env->sibling_threads);
>  	zfree(&env->pmu_mappings);
> -- 
> 2.31.1
> 

-- 

- Arnaldo
