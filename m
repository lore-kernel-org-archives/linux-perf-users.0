Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09422C636C8
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 19:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E39986128C
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 19:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243600AbhGOUCa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 16:02:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343898AbhGOUB2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 16:01:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 515376128C;
        Thu, 15 Jul 2021 19:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626379114;
        bh=aoi7XZmj8no9CT6naQ+6mLUyIcUgFcxd+SEJ6DJAbLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ktltr2plr2AcUOIFrFolI662QOgpsL8cQfZEudO6S8qo1NIVGBJ/73KyMPbD1Mtg0
         X1rOuLUEzxTZUbJiUoyXunQzuEIroOwLXOoIXMPggk1uCJ7FV+ZTE2BDYW04zE32NS
         cmcsqD7y3haN1E/EGMGRw8td7EF7/Y4psiPOkvD0vceHR9SF2JLS6T1oRjg/tzHHDz
         +XmNhmWLEKzke/bkkMasakRR4M9GQtiy+KaYsgI9J7+M0uqLLztTN5GHjM0gyesCT6
         Fyrk4GFpj9Q8S+ZJPAzRlo9/cXgEZ5Nm0lHmgP9+S58ePvYRXLpJs1iU69oWjLDWCK
         7/ydRTDcWemvQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DA96E403F2; Thu, 15 Jul 2021 16:58:31 -0300 (-03)
Date:   Thu, 15 Jul 2021 16:58:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 05/20] perf test: event_update: fix memory leak of unit
Message-ID: <YPCTZy/11b+amxBg@kernel.org>
References: <cover.1626343282.git.rickyman7@gmail.com>
 <1fbc8158663fb0d4d5392e36bae564f6ad60be3c.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fbc8158663fb0d4d5392e36bae564f6ad60be3c.1626343282.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jul 15, 2021 at 06:07:10PM +0200, Riccardo Mancini escreveu:
> ASan reports a memory leak while running the perf test
> "49: Synthesize attr update" caused by a string being duplicated but
> never freed.
> 
> This patch adds the missing free().
> 
> Note that evsel->unit is not deallocated together with evsel since it
> is supposed to be a constant string.

Thanks, applied and added the Fixes tag, which I'm doing to all the
patches in the series.

- Arnaldo

 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/tests/event_update.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
> index 932ab0740d11ced6..44a50527f9d95170 100644
> --- a/tools/perf/tests/event_update.c
> +++ b/tools/perf/tests/event_update.c
> @@ -88,6 +88,7 @@ int test__event_update(struct test *test __maybe_unused, int subtest __maybe_unu
>  	struct evsel *evsel;
>  	struct event_name tmp;
>  	struct evlist *evlist = evlist__new_default();
> +	char *unit = strdup("KRAVA");
>  
>  	TEST_ASSERT_VAL("failed to get evlist", evlist);
>  
> @@ -98,7 +99,7 @@ int test__event_update(struct test *test __maybe_unused, int subtest __maybe_unu
>  
>  	perf_evlist__id_add(&evlist->core, &evsel->core, 0, 0, 123);
>  
> -	evsel->unit = strdup("KRAVA");
> +	evsel->unit = unit;
>  
>  	TEST_ASSERT_VAL("failed to synthesize attr update unit",
>  			!perf_event__synthesize_event_update_unit(NULL, evsel, process_event_unit));
> @@ -118,6 +119,7 @@ int test__event_update(struct test *test __maybe_unused, int subtest __maybe_unu
>  	TEST_ASSERT_VAL("failed to synthesize attr update cpus",
>  			!perf_event__synthesize_event_update_cpus(&tmp.tool, evsel, process_event_cpus));
>  
> +	free(unit);
>  	evlist__delete(evlist);
>  	return 0;
>  }
> -- 
> 2.31.1
> 

-- 

- Arnaldo
