Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8582BC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Sep 2021 21:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 633C3610D1
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Sep 2021 21:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhIOVWl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 15 Sep 2021 17:22:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231917AbhIOVWl (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Sep 2021 17:22:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93C5C610D1;
        Wed, 15 Sep 2021 21:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631740881;
        bh=z9hL2MrAtZLKUp7KUmoFzMIAFd6OTjNjbHlZSDPzoKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WdipA72uTNFoEF5gV8GlZyee2R74YI3OpXo6dqqaAoUEJSEvWYtxrB3qcXeUwsfEg
         0T0YbsUXxE7qm38po/5OXePE45gDwr4ey90SS39fcVdZn5IxSVFj2Z81EH5nc87vOr
         z7QWv1DgIMWdDQEf9bNxVrFRw54Hvv54Es2G/e0wFZOmjApDkUOZKlO7/LsmW47Alg
         SBf0btCYmr9ivezbCdMTm0r/aqKSmvV6imB+izCA6+OjqBGo3MwoEFvI1/dLn8NshJ
         8Jc57dLZI31XyjHYNGV1B8L5YSOUC8SzgcNfUMV7DsglyhnXVOl/N2kkmHECF5kjXu
         JdOctJyqKSacg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 93BA44038F; Wed, 15 Sep 2021 18:21:18 -0300 (-03)
Date:   Wed, 15 Sep 2021 18:21:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] perf parse-events: Avoid enum forward declaration.
Message-ID: <YUJjzr8lvelSKET1@kernel.org>
References: <20210915211428.1773567-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915211428.1773567-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Sep 15, 2021 at 02:14:28PM -0700, Ian Rogers escreveu:
> Enum forward declarations aren't allowed as the size can't be implied.
> Switch to just using an int. This fixes a clang warning:
> 
> In file included from tools/perf/bench/evlist-open-close.c:13:
> tools/perf/bench/../util/parse-events.h:185:6: error: redeclaration of already-defined enum 'perf_tool_event' is a GNU extension [-Werror,-Wgnu-redeclared-enum]
> enum perf_tool_event;
>      ^
> tools/perf/bench/../util/evsel.h:28:6: note: previous definition is here
> enum perf_tool_event {
>      ^

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/parse-events.c | 2 +-
>  tools/perf/util/parse-events.h | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 51a2219df601..5d1346aa0627 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1471,7 +1471,7 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
>  
>  int parse_events_add_tool(struct parse_events_state *parse_state,
>  			  struct list_head *list,
> -			  enum perf_tool_event tool_event)
> +			  int tool_event)
>  {
>  	return add_event_tool(list, &parse_state->idx, tool_event);
>  }
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index bf6e41aa9b6a..b32ed3064c49 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -182,10 +182,9 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
>  			     struct list_head *list,
>  			     u32 type, u64 config,
>  			     struct list_head *head_config);
> -enum perf_tool_event;
>  int parse_events_add_tool(struct parse_events_state *parse_state,
>  			  struct list_head *list,
> -			  enum perf_tool_event tool_event);
> +			  int tool_event);
>  int parse_events_add_cache(struct list_head *list, int *idx,
>  			   char *type, char *op_result1, char *op_result2,
>  			   struct parse_events_error *error,
> -- 
> 2.33.0.309.g3052b89438-goog

-- 

- Arnaldo
