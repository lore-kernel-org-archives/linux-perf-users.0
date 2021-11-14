Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F96FC433F5
	for <linux-perf-users@archiver.kernel.org>; Sun, 14 Nov 2021 17:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6518160EBC
	for <linux-perf-users@archiver.kernel.org>; Sun, 14 Nov 2021 17:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbhKNRFK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 14 Nov 2021 12:05:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21291 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234137AbhKNRFJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 14 Nov 2021 12:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636909331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pdzvmRxzWAJAKI2bnZiBldjj4kRy/zRG6nAZE9MeWk4=;
        b=fZYrC1EejgxXYad0lTKvXM+TIygjVxDp8bfuWGXPdL6mnd0lpRwS783Ek/DlGEFKEvSQDL
        c3yAbdtJO8/u7lwjWvvDMuh1kUTbH/hY4RDDBRDHyWPyUq4DpjqN/dmr1xK7MkzXaDA3dQ
        Vj6TLwtz4Hvheuv5JkynGiEP9+3mpaw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-DXVQDukeOmCgNcQgrMIS2Q-1; Sun, 14 Nov 2021 12:02:10 -0500
X-MC-Unique: DXVQDukeOmCgNcQgrMIS2Q-1
Received: by mail-qv1-f70.google.com with SMTP id jz2-20020a0562140e6200b003bd6c62be47so13747114qvb.11
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Nov 2021 09:02:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pdzvmRxzWAJAKI2bnZiBldjj4kRy/zRG6nAZE9MeWk4=;
        b=55wkRWQG6tpCFSW+XQqpe3GgVTn2AyXulbdWUWpT0S7XgXZFnErO9FnLd59Tda55Au
         SgFOXPcuRC93E9YaIWQAj4luN0uxa6M4rr4sat+H9jAlAp6hAESEyZDWJL2IR0Zd8VSJ
         u3kRAnG5kERt8r6rB9KhYQGNilPFwoVrT9/zsRdxUhtE84DuOzvOm9YDhRcE9s5Bj9Su
         g7pm7ZEGTNHl1Wgl2N4UhcmKroQgK/xzSPQzSguFhe1bTgLCFNPW0iZWeEy3ZSYRGHg8
         Vufj1sVBVYfLWhkdqUFX5OJa7jhN7WTFzlPqLpuWBawHntG2Z98TN2hDb6/wE0YBTj1r
         2rGw==
X-Gm-Message-State: AOAM530AUc3Us76aWhADWpHFzQd+6+S0J0MEgPjOXN4dXFpTON0vqfj+
        qQW2JqzURZ7BjXcUWlSrz23iWeKKlv+ePKgj0FSNpGn/Mwin556phCCPp1dTR/h9VW/fCyw87hV
        r5FZgxydMgRkqdO/YuuDFoS1jKWlXqg==
X-Received: by 2002:a05:620a:1aa0:: with SMTP id bl32mr25781572qkb.140.1636909329887;
        Sun, 14 Nov 2021 09:02:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy3fsX0amBg4KTKwAHXzq/1xbMBf+qUOnM2ajFU/qgxaFvHPrBXqfnJ+OC0Ym2EN8YEGm8e1g==
X-Received: by 2002:a05:620a:1aa0:: with SMTP id bl32mr25781536qkb.140.1636909329631;
        Sun, 14 Nov 2021 09:02:09 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id o5sm5403526qkl.50.2021.11.14.09.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 09:02:09 -0800 (PST)
Date:   Sun, 14 Nov 2021 18:02:04 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH 2/2] perf parse-events: Architecture specific leader
 override
Message-ID: <YZFBDI6oPMidX0KO@krava>
References: <20211113071548.372572-1-irogers@google.com>
 <20211113071548.372572-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211113071548.372572-2-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Nov 12, 2021 at 11:15:48PM -0800, Ian Rogers wrote:
> Currently topdown events must appear after a slots event:
> 
> $ perf stat -e '{slots,topdown-fe-bound}' /bin/true
> 
>  Performance counter stats for '/bin/true':
> 
>          3,183,090      slots
>            986,133      topdown-fe-bound
> 
> Reversing the events yields:
> 
> $ perf stat -e '{topdown-fe-bound,slots}' /bin/true
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (topdown-fe-bound).

why is this actually failing?

> 
> For metrics the order of events is determined by iterating over a
> hashmap, and so slots isn't guaranteed to be first which can yield this
> error.
> 
> Change the set_leader in parse-events, called when a group is closed, so
> that rather than always making the first event the leader, if the slots
> event exists then it is made the leader. It is then moved to the head of
> the evlist otherwise it won't be opened in the correct order.
> 
> The result is:
> 
> $ perf stat -e '{topdown-fe-bound,slots}' /bin/true
> 
>  Performance counter stats for '/bin/true':
> 
>          3,274,795      slots
>          1,001,702      topdown-fe-bound
> 
> A problem with this approach is the slots event is identified by name,
> names can be overwritten like 'cpu/slots,name=foo/' and this causes the
> leader change to fail.

would it be better then to move this shuffle to the metric code directly,
and make sure it only spits 'good' order of events?

and keep "-e '{topdown-fe-bound,slots}'" to fail if user specifies that on
the command line

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/x86/util/evlist.c | 17 +++++++++++++++++
>  tools/perf/util/evlist.h          |  1 +
>  tools/perf/util/parse-events.c    | 16 +++++++++++-----
>  tools/perf/util/parse-events.h    |  4 ++--
>  tools/perf/util/parse-events.y    | 12 ++++++++----
>  5 files changed, 39 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
> index 0b0951030a2f..1624372b2da2 100644
> --- a/tools/perf/arch/x86/util/evlist.c
> +++ b/tools/perf/arch/x86/util/evlist.c
> @@ -17,3 +17,20 @@ int arch_evlist__add_default_attrs(struct evlist *evlist)
>  	else
>  		return parse_events(evlist, TOPDOWN_L1_EVENTS, NULL);
>  }
> +
> +struct evsel *arch_evlist__leader(struct list_head *list)
> +{
> +	struct evsel *evsel, *first;
> +
> +	first = list_entry(list->next, struct evsel, core.node);
> +
> +	if (!pmu_have_event("cpu", "slots"))
> +		return first;
> +
> +	__evlist__for_each_entry(list, evsel) {
> +		if (evsel->pmu_name && !strcmp(evsel->pmu_name, "cpu") &&
> +			evsel->name && strstr(evsel->name, "slots"))
> +			return evsel;
> +	}
> +	return first;
> +}
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 97bfb8d0be4f..993437ffe429 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -110,6 +110,7 @@ int __evlist__add_default_attrs(struct evlist *evlist,
>  	__evlist__add_default_attrs(evlist, array, ARRAY_SIZE(array))
>  
>  int arch_evlist__add_default_attrs(struct evlist *evlist);
> +struct evsel *arch_evlist__leader(struct list_head *list);
>  
>  int evlist__add_dummy(struct evlist *evlist);
>  
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 6308ba739d19..a2f4c086986f 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1821,22 +1821,28 @@ parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
>  	return ret;
>  }
>  
> -void parse_events__set_leader(char *name, struct list_head *list,
> -			      struct parse_events_state *parse_state)
> +__weak struct evsel *arch_evlist__leader(struct list_head *list)
> +{
> +	return list_entry(list->next, struct evsel, core.node);
> +}
> +
> +struct list_head *parse_events__set_leader(char *name, struct list_head *list,
> +					struct parse_events_state *parse_state)
>  {
>  	struct evsel *leader;
>  
>  	if (list_empty(list)) {
>  		WARN_ONCE(true, "WARNING: failed to set leader: empty list");
> -		return;
> +		return NULL;
>  	}
>  
>  	if (parse_events__set_leader_for_uncore_aliase(name, list, parse_state))
> -		return;
> +		return NULL;
>  
> -	leader = list_entry(list->next, struct evsel, core.node);
> +	leader = arch_evlist__leader(list);
>  	__perf_evlist__set_leader(list, &leader->core);
>  	leader->group_name = name ? strdup(name) : NULL;
> +	return &leader->core.node;
>  }
>  
>  /* list_event is assumed to point to malloc'ed memory */
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index c7fc93f54577..8a6e6b4d5cbe 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -211,8 +211,8 @@ int parse_events_copy_term_list(struct list_head *old,
>  
>  enum perf_pmu_event_symbol_type
>  perf_pmu__parse_check(const char *name);
> -void parse_events__set_leader(char *name, struct list_head *list,
> -			      struct parse_events_state *parse_state);
> +struct list_head *parse_events__set_leader(char *name, struct list_head *list,
> +					struct parse_events_state *parse_state);
>  void parse_events_update_lists(struct list_head *list_event,
>  			       struct list_head *list_all);
>  void parse_events_evlist_error(struct parse_events_state *parse_state,
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index 174158982fae..5358c400f938 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -199,20 +199,24 @@ group_def
>  group_def:
>  PE_NAME '{' events '}'
>  {
> -	struct list_head *list = $3;
> +	struct list_head *new_head, *list = $3;
>  
>  	inc_group_count(list, _parse_state);
> -	parse_events__set_leader($1, list, _parse_state);
> +	new_head = parse_events__set_leader($1, list, _parse_state);
> +	if (new_head)
> +		list_move(new_head, list);

why not put these last 2 lines to parse_events__set_leader as well?

>  	free($1);
>  	$$ = list;
>  }
>  |
>  '{' events '}'
>  {
> -	struct list_head *list = $2;
> +	struct list_head *new_head, *list = $2;
>  
>  	inc_group_count(list, _parse_state);
> -	parse_events__set_leader(NULL, list, _parse_state);
> +	new_head = parse_events__set_leader(NULL, list, _parse_state);
> +	if (new_head)
> +		list_move(new_head, list);

same

thanks,
jirka

