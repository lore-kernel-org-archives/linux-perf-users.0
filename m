Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393FFC636C8
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 20:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 115DD613D8
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 20:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhGOU2B (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 16:28:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229700AbhGOU2B (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 16:28:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2336613D0;
        Thu, 15 Jul 2021 20:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626380707;
        bh=0KsGtkqOtNJIx0EmoPSRoxO2JdEUeXSwh4aAVfBC7yk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H/DA7RFGacnK0kFiABNN1cJryMJmb6l5fvKqFleiv15Lr3hOr8K9E+sXLvmkoTd26
         EovO0M/hfQyuSTfGh1EWSw5DV79oXqTdmNMH8oBFayG9Jf/d3tiTwz+JmHArA5G/3Z
         XcaU8EsqAM/uLISEOV3hUtosXf/j8ZS7Hf7wo82n7zED4H4qDAVJsjWnP213MWIJrn
         1FOLptjJ8cuDDJVZ6We7K4EOHHS+6e/5UvB0bCbd/Q1RIVHXfHplKnA7kdq7OWm7da
         GDxbusGUiXh8cnPfONy0dk5P2teOLm1B2xKnbm5imnTaYmowilD4mqu2ivpTo0SzV3
         D0yCFBk43c6Qg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4F7CB403F2; Thu, 15 Jul 2021 17:25:05 -0300 (-03)
Date:   Thu, 15 Jul 2021 17:25:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 13/20] perf script: fix memory leaks in perf_script
Message-ID: <YPCZoa/IwENjYPe5@kernel.org>
References: <cover.1626343282.git.rickyman7@gmail.com>
 <5ee73b19791c6fa9d24c4d57f4ac1a23609400d7.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ee73b19791c6fa9d24c4d57f4ac1a23609400d7.1626343282.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jul 15, 2021 at 06:07:18PM +0200, Riccardo Mancini escreveu:
> ASan reports several memory leaks while running the perf test
> "82: Use vfs_getname probe to get syscall args filenames".
> Two of these are caused by some refcounts not being decreased on
> perf-script exit, namely script.threads and script.cpus.
> 
> This patch adds the missing __put calls in a new perf_script__exit
> function, which is called at the end of cmd_script.
> 
> This patch concludes the fixes of all remaining memory leaks in perf
> test "82: Use vfs_getname probe to get syscall args filenames".

Fixes: cfc8874a48599249 ("perf script: Process cpu/threads maps")

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/builtin-script.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index bae0e5b72c0e6050..064da7f3618d39d8 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2601,6 +2601,12 @@ static void perf_script__exit_per_event_dump_stats(struct perf_script *script)
>  	}
>  }
>  
> +static void perf_script__exit(struct perf_script *script)
> +{
> +	perf_thread_map__put(script->threads);
> +	perf_cpu_map__put(script->cpus);
> +}
> +
>  static int __cmd_script(struct perf_script *script)
>  {
>  	int ret;
> @@ -4146,6 +4152,7 @@ int cmd_script(int argc, const char **argv)
>  	zstd_fini(&(session->zstd_data));
>  	evlist__free_stats(session->evlist);
>  	perf_session__delete(session);
> +	perf_script__exit(&script);
>  
>  	if (script_started)
>  		cleanup_scripting();
> -- 
> 2.31.1
> 

-- 

- Arnaldo
