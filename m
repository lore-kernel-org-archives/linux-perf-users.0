From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [Question] About '(*idx)++' of perf_evsel__new_idx
Date: Mon, 30 Jan 2017 16:03:06 -0300
Message-ID: <20170130190306.GC4546@kernel.org>
References: <1f6c94c2-1e9d-a85d-b4b6-ad47510d4d3f@kosslab.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753848AbdA3TJb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 30 Jan 2017 14:09:31 -0500
Content-Disposition: inline
In-Reply-To: <1f6c94c2-1e9d-a85d-b4b6-ad47510d4d3f@kosslab.kr>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Taeung Song <taeung@kosslab.kr>
Cc: perf group <linux-perf-users@vger.kernel.org>, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Namhyung Kim <namhyung@kernel.org>

Em Mon, Jan 30, 2017 at 11:53:18AM +0900, Taeung Song escreveu:
> Hi, :)
> 
> Can I ask you one thing ?
> 
> I'm reading source code util/parse-event.c
> Along the way, I wonder why increase idx before checking
> whether 'evsel' is NULL or not ? (at 310,311 line number)
> 
> 
> 300 static struct perf_evsel *
> 301 __add_event(struct list_head *list, int *idx,
> 302             struct perf_event_attr *attr,
> 303             char *name, struct cpu_map *cpus,
> 304             struct list_head *config_terms)
> 305 {
> 306         struct perf_evsel *evsel;
> 307
> 308         event_attr_init(attr);
> 309
> 310         evsel = perf_evsel__new_idx(attr, (*idx)++);
> 311         if (!evsel)
> 312                 return NULL;
> 313
> 314         evsel->cpus     = cpu_map__get(cpus);
> 315         evsel->own_cpus = cpu_map__get(cpus);
> 316
> 
> IMHO, if 'evsel' isn't NULL, we can increase idx like below.
> 
>             evsel = perf_evsel__new_idx(attr, *idx);
>             if (!evsel)
>                     return NULL;
>             else
>                (*idx)++;
> 
> Is it wrong ? or is there other reason about increasing idx
> before check 'evsel'?

I think you're right and we should increment idx only if we manage to
create the evsel instance, no need for the else clause tho.

- Arnaldo
