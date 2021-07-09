Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30B1C07E99
	for <linux-perf-users@archiver.kernel.org>; Fri,  9 Jul 2021 18:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 877D9613CF
	for <linux-perf-users@archiver.kernel.org>; Fri,  9 Jul 2021 18:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhGISYe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 9 Jul 2021 14:24:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhGISYe (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 9 Jul 2021 14:24:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44A0061361;
        Fri,  9 Jul 2021 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625854910;
        bh=eKI2MKP/0FuOgp2lSQADbh4/n7CDz5nAGAOBVI4TIjo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N/HLJC2qL9tBRINagovny6irxRVUrUF93KF4dCITFUitVY/jhT/JVsjNuAarTWWst
         dElW6tywW5jWecoyYIPhIHM+Ok8n60VlMkOV+JbMcfrJja3A5iktp3xNb1ZmMxJWeY
         dW14BVXdmyWY682mZb1gAGCVUQGu8vOeUmmQbPEYoUXdv21LF9qRV5S/qWMYRAq+f1
         3yp0U9ADUMQNcgZGCEOtZNYeuDlXC+9vLlux8tp1JrTvUMsyqjl2k8je8pY6YC7Ot5
         vy8IzwAV2c1JeXqSDGovhzofv3vUkOeZrB/xKr+6mPsEIJuxxzNUd1HGZwd7MgVXZP
         O0tFc62E6XTbw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0512940B1A; Fri,  9 Jul 2021 15:21:46 -0300 (-03)
Date:   Fri, 9 Jul 2021 15:21:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Remi Bernon <rbernon@codeweavers.com>,
        Fabian Hemmer <copy@copy.sh>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test: add missing free for scandir-returned dirent
 entities
Message-ID: <YOiTuvHKc5I9TzJe@kernel.org>
References: <20210709163454.672082-1-rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709163454.672082-1-rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Jul 09, 2021 at 06:34:53PM +0200, Riccardo Mancini escreveu:
> ASan reported a memory leak for items of the entlist returned from scandir.
> In fact, scandir returns a malloc'd array of malloc'd dirents.
> This patch adds the missing (z)frees.

Hey, I thought you were pluging old leaks, this one was introduced
recently ;-) :-)

Thanks, applied!

- Arnaldo
 
> Fixes: da963834fe6975a1 ("perf test: Iterate over shell tests in alphabetical order")
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/tests/builtin-test.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 41e3cf6bb66c68e8..5e6242576236325c 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -26,6 +26,7 @@
>  #include <linux/kernel.h>
>  #include <linux/string.h>
>  #include <subcmd/exec-cmd.h>
> +#include <linux/zalloc.h>
>  
>  static bool dont_fork;
>  
> @@ -540,7 +541,7 @@ static int shell_tests__max_desc_width(void)
>  {
>  	struct dirent **entlist;
>  	struct dirent *ent;
> -	int n_dirs;
> +	int n_dirs, e;
>  	char path_dir[PATH_MAX];
>  	const char *path = shell_tests__dir(path_dir, sizeof(path_dir));
>  	int width = 0;
> @@ -564,8 +565,9 @@ static int shell_tests__max_desc_width(void)
>  		}
>  	}
>  
> +	for (e = 0; e < n_dirs; e++)
> +		zfree(&entlist[e]);
>  	free(entlist);
> -
>  	return width;
>  }
>  
> @@ -596,7 +598,7 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width)
>  {
>  	struct dirent **entlist;
>  	struct dirent *ent;
> -	int n_dirs;
> +	int n_dirs, e;
>  	char path_dir[PATH_MAX];
>  	struct shell_test st = {
>  		.dir = shell_tests__dir(path_dir, sizeof(path_dir)),
> @@ -629,6 +631,8 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width)
>  		test_and_print(&test, false, -1);
>  	}
>  
> +	for (e = 0; e < n_dirs; e++)
> +		zfree(&entlist[e]);
>  	free(entlist);
>  	return 0;
>  }
> @@ -730,7 +734,7 @@ static int perf_test__list_shell(int argc, const char **argv, int i)
>  {
>  	struct dirent **entlist;
>  	struct dirent *ent;
> -	int n_dirs;
> +	int n_dirs, e;
>  	char path_dir[PATH_MAX];
>  	const char *path = shell_tests__dir(path_dir, sizeof(path_dir));
>  
> @@ -752,8 +756,11 @@ static int perf_test__list_shell(int argc, const char **argv, int i)
>  			continue;
>  
>  		pr_info("%2d: %s\n", i, t.desc);
> +
>  	}
>  
> +	for (e = 0; e < n_dirs; e++)
> +		zfree(&entlist[e]);
>  	free(entlist);
>  	return 0;
>  }
> -- 
> 2.23.0
> 

-- 

- Arnaldo
