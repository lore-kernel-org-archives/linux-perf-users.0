Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4828C636C8
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 20:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96819613DA
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 20:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhGOUiD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 16:38:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231250AbhGOUiD (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 16:38:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36740613D2;
        Thu, 15 Jul 2021 20:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626381309;
        bh=YpW1keL3OrSQeRx/gtZAk34UZN7GkG+ye28MoYCRNC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=avyb2/CqPbZvgoqyc6w4jmkHwaZdwE9bxW2XD1y70T0ueKMOkyky0kCH9NDcCgn/W
         vX+GgAbSJiR5bKOnqohDOwWQ2eI4KmDgi4EuMdXgO00XeEpCQArpokOWdpbgdfD8wk
         9QK9fDKFv0UnvxrXlD3vZdhZJib+oc9MpASooMmOEHjSeibB/XyC4uAdyCdMYiLgUu
         RHILyumz25QjTzj7v0bo/VD/UT6uCyKF9eVb9ccmWB0oZfsIgLqysgIfb0IskOmTCb
         yZgJanWKjjfhZQBiQ/zX4FwuRYx0QGJ+Yggtb5yGb9KX4SB6yK7VKRHIhaMIwM1Fxa
         aNc1V0rTifNHg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 894F6403F2; Thu, 15 Jul 2021 17:35:06 -0300 (-03)
Date:   Thu, 15 Jul 2021 17:35:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 16/20] perf trace: free syscall->arg_fmt
Message-ID: <YPCb+vj5xibpXvbq@kernel.org>
References: <cover.1626343282.git.rickyman7@gmail.com>
 <d68f25c043d30464ac9fa79c3399e18f429bca82.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d68f25c043d30464ac9fa79c3399e18f429bca82.1626343282.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jul 15, 2021 at 06:07:21PM +0200, Riccardo Mancini escreveu:
> ASan reports several memory leaks running the perf test
> "88: Check open filename arg using perf trace + vfs_getname".
> The second of these leaks is caused by the arg_fmt field of syscall not
> being deallocated.
> 
> This patch adds a new function syscall__exit which is called on all
> syscalls.table entries in trace__exit, which will free the arg_fmt
> field.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/builtin-trace.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index fe26d87ca8ccc14d..d67f02d237eb0c7e 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2266,6 +2266,14 @@ static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sam
>  	return augmented_args;
>  }
>  
> +static void syscall__exit(struct syscall *sc)
> +{
> +	if (!sc)
> +		return;
> +
> +	free(sc->arg_fmt);
> +}
> +
>  static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
>  			    union perf_event *event __maybe_unused,
>  			    struct perf_sample *sample)
> @@ -4703,9 +4711,15 @@ static int trace__config(const char *var, const char *value, void *arg)
>  
>  static void trace__exit(struct trace *trace)
>  {
> +	int i;
> +
>  	strlist__delete(trace->ev_qualifier);
>  	free(trace->ev_qualifier_ids.entries);
> -	free(trace->syscalls.table);
> +	if (trace->syscalls.table) {
> +		for (i = 0; i <= trace->sctbl->syscalls.max_id; i++)
> +			syscall__exit(&trace->syscalls.table[i]);
> +		free(trace->syscalls.table);
> +	}
>  	syscalltbl__delete(trace->sctbl);
>  	zfree(&trace->perfconfig_events);
>  }
> -- 
> 2.31.1
> 

-- 

- Arnaldo
