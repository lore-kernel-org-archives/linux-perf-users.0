Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97490C432BE
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 20:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 747F161090
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 20:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbhHaUHJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:07:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhHaUHI (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Aug 2021 16:07:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 256316108B;
        Tue, 31 Aug 2021 20:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630440373;
        bh=xrvKiHXhYI03XkknWcnBRe0wu5iG2lTHButTzM1ZtwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FQcjRDlduBYIPHCwtbtquYUWQAwyz1mnXHv1m813KLjFpOv3EAYfIEB01ZMzWLPAA
         vnga06UIcMK7xldwTnWdGSVXwFDXBmy21Nmo2CJsAKCegkmOIFh22CwWwLea4JL5X0
         1RhgjEWQRcOtRU7mL2Jv8gK0+Q1zbzu0o7GAMpw93RY2z2gaTzOsQDHLcnmd6wi2uP
         ltm4EgHsDc8WUY7QsmjuLeF7dJYUIAgESL4lRJ2D0VFGO7J+D5q/snaWuIYUwVb+vJ
         ia/TV/6Spg/6/flpaZIqCxG5sMrQVkqX83uzQ9mU3L0DeNQlug9rNz08j0jHSTwWDy
         WQYf2r2h1Hovg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 03F884007E; Tue, 31 Aug 2021 17:06:09 -0300 (-03)
Date:   Tue, 31 Aug 2021 17:06:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v1 27/37] perf evlist: add
 evlist__for_each_entry_from macro
Message-ID: <YS6LsW1bYZpRyhY4@kernel.org>
References: <cover.1629490974.git.rickyman7@gmail.com>
 <2386505f8b598adf0dbcd04ec21804c6bcf00826.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2386505f8b598adf0dbcd04ec21804c6bcf00826.1629490974.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sat, Aug 21, 2021 at 11:19:33AM +0200, Riccardo Mancini escreveu:
> This patch adds a new iteration macro for evlist that resumes iteration
> from a given evsel in the evlist.
> 
> This macro will be used in the next patch

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/util/evlist.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 5f24a45d4e3cf30a..b0c2da0f9755b2d1 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -275,6 +275,22 @@ void evlist__to_front(struct evlist *evlist, struct evsel *move_evsel);
>  #define evlist__for_each_entry_continue(evlist, evsel) \
>  	__evlist__for_each_entry_continue(&(evlist)->core.entries, evsel)
>  
> +/**
> + * __evlist__for_each_entry_from - continue iteration from @evsel (included)
> + * @list: list_head instance to iterate
> + * @evsel: struct evsel iterator
> + */
> +#define __evlist__for_each_entry_from(list, evsel) \
> +	list_for_each_entry_from(evsel, list, core.node)
> +
> +/**
> + * evlist__for_each_entry_from - continue iteration from @evsel (included)
> + * @evlist: evlist instance to iterate
> + * @evsel: struct evsel iterator
> + */
> +#define evlist__for_each_entry_from(evlist, evsel) \
> +	__evlist__for_each_entry_from(&(evlist)->core.entries, evsel)
> +
>  /**
>   * __evlist__for_each_entry_reverse - iterate thru all the evsels in reverse order
>   * @list: list_head instance to iterate
> -- 
> 2.31.1

-- 

- Arnaldo
