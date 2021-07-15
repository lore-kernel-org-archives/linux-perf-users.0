Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00311C636C8
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 20:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D48B8613D4
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 20:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbhGOUik (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 16:38:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231250AbhGOUik (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 16:38:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4839F610F9;
        Thu, 15 Jul 2021 20:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626381346;
        bh=jSywJFUGv28bSC1SyA7MX/A+sCbDcwufywbhz7aGI6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UoKV6sb1dUOOP5rOH5Oufmoe9SMRExgXC4P4G5beqmlKaDuz8TgiPfOv0ul+O9Iwb
         nf5ZoQXtWTwE2HFroLff7O/Oq1KfZ1388KV0XKHudtl3FELPvh4VRIAaiM8Lene8sN
         g2Gn+ByaJt6miZ83cr3fqR50owwDPklywlwANOvWCpAIbjXSYTH8AcvYAqVpCdwIGy
         QvWBJoQAKxSm1/+fIpUZRiIuQDsUa03035vm5b8uOlcjyHhx+T/3IBzHhfJZBAOMTV
         KqlWDG2QlN6cUZGbjLza34gVICpiLqr6umbYWQFvMqJyj95RXoA+qXFnGcWQtOJIPr
         0ntu6H628sQ+Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6FA4E410A0; Thu, 15 Jul 2021 17:35:44 -0300 (-03)
Date:   Thu, 15 Jul 2021 17:35:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 17/20] perf trace: free syscall tp fields in evsel->priv
Message-ID: <YPCcIIT4CvbmPen+@kernel.org>
References: <cover.1626343282.git.rickyman7@gmail.com>
 <46526611904ec5ff2768b59014e3afce8e0197d1.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46526611904ec5ff2768b59014e3afce8e0197d1.1626343282.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jul 15, 2021 at 06:07:22PM +0200, Riccardo Mancini escreveu:
> ASan reports several memory leaks running the perf test
> "88: Check open filename arg using perf trace + vfs_getname".
> The third of these leaks is related to evsel->priv fields of sycalls never
> being deallocated.
> 
> This patch adds the function evlist__free_syscall_tp_fields which
> iterates over all evsels in evlist, matching syscalls, and calling the
> missing frees.
> This new function is called at the end of trace__run, right before
> calling evlist__delete.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/builtin-trace.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index d67f02d237eb0c7e..d9c65d55a9ae7526 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -3103,6 +3103,21 @@ static struct evsel *evsel__new_pgfault(u64 config)
>  	return evsel;
>  }
>  
> +static void evlist__free_syscall_tp_fields(struct evlist *evlist)
> +{
> +	struct evsel *evsel;
> +
> +	evlist__for_each_entry(evlist, evsel) {
> +		struct evsel_trace *et = evsel->priv;
> +
> +		if (!et || !evsel->tp_format || strcmp(evsel->tp_format->system, "syscalls"))
> +			continue;
> +
> +		free(et->fmt);
> +		free(et);
> +	}
> +}
> +
>  static void trace__handle_event(struct trace *trace, union perf_event *event, struct perf_sample *sample)
>  {
>  	const u32 type = event->header.type;
> @@ -4138,7 +4153,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  
>  out_delete_evlist:
>  	trace__symbols__exit(trace);
> -
> +	evlist__free_syscall_tp_fields(evlist);
>  	evlist__delete(evlist);
>  	cgroup__put(trace->cgroup);
>  	trace->evlist = NULL;
> -- 
> 2.31.1
> 

-- 

- Arnaldo
