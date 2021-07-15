Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1276C636CA
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 19:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A0B96128C
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 19:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245266AbhGOUBC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 16:01:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345027AbhGOT5D (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 15:57:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68B95613DA;
        Thu, 15 Jul 2021 19:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626378848;
        bh=b/cM3lLGocyFqH187slOjN0KGM0gpqViLiQYCWp1ApI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BXD7yHsy7w/D8omyhmAVccFSgutn3bQ5jP8T4Lh35P6Z/BlKI3u+xEUGhl0fyXcDX
         fvP3IKc8zHmcvFq6MBeb38w2NiZw+bCv0VeKjCtic0i54t+qVQwIVBipuFZmbUuTqH
         lehn//fSJEnrLP8VTmPYJ/u4vTXn6rNthrraY6tKF6x9lwI5DxTJ+AecK/mlP3XVrI
         DwFjj9TxZFSdJlJUVXglSEE6Gpdxu3hrqUx+NdMSca6nzma0dZk15oaB/j8/euKmbb
         8x2pwqnc7S/IEVhz5RxNvCeox9W7guaiLZKXulWasfjRSnYpZ/g5v20cu0gLxIZRIa
         Se1xHXcocPrOw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ABA82403F2; Thu, 15 Jul 2021 16:54:05 -0300 (-03)
Date:   Thu, 15 Jul 2021 16:54:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 04/20] perf test: event_update: fix memory leak of evlist
Message-ID: <YPCSXRiyAxAFxFzc@kernel.org>
References: <cover.1626343282.git.rickyman7@gmail.com>
 <f7994ad63d248f7645f901132d208fadf9f2b7e4.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7994ad63d248f7645f901132d208fadf9f2b7e4.1626343282.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jul 15, 2021 at 06:07:09PM +0200, Riccardo Mancini escreveu:
> ASan reports a memory leak when running the perf test
> "49: Synthesize attr update" caused by evlist not being deleted.
> 
> This patch adds the missing evlist__delete and removes the
> perf_cpu_map__put since it's already being deleted by evlist__delete.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/tests/event_update.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
> index 656218179222cc58..932ab0740d11ced6 100644
> --- a/tools/perf/tests/event_update.c
> +++ b/tools/perf/tests/event_update.c
> @@ -118,6 +118,6 @@ int test__event_update(struct test *test __maybe_unused, int subtest __maybe_unu
>  	TEST_ASSERT_VAL("failed to synthesize attr update cpus",
>  			!perf_event__synthesize_event_update_cpus(&tmp.tool, evsel, process_event_cpus));
>  
> -	perf_cpu_map__put(evsel->core.own_cpus);
> +	evlist__delete(evlist);
>  	return 0;
>  }
> -- 
> 2.31.1
> 

-- 

- Arnaldo
