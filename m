Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFA7C636C9
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 20:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEA6C613D4
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 20:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhGOUfU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 16:35:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231397AbhGOUfU (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 16:35:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E013B613D2;
        Thu, 15 Jul 2021 20:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626381146;
        bh=Zpn1XMUEVhwEW6EqfhkrxX8vH43xiXgmKI68iCHQDf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ev1Pg9JIRzTFZWqP+oNkruYsW1FsqyMlDmWubZB8k0HIJeo8Dx8xmErHCTUVOmlBb
         2a6eGHy7bFT+5DG24UzZ1484wGTaQGH4k/9ZEXN/paWQeq3t++YyUptAXSaPdt1vWk
         pvDDh1NuY/JG+7dF97pgAJsxS1KNrl62gseHojBpoAJ/bbc014oBZvMW64CPeUcLVz
         LludzO6yUOfws5ByKL4R6XBnopV7uDotZwqhglIt/honV+SadL01H+gpAq30G3vjUO
         E/2YJ8yBgRxgpJepPk8iaaThBX23xAYiUqr68RDoEMEEHaYbpSvkW+0r+rRuK0Y4KE
         Vt6TxNl2Pt6fQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 99D16403F2; Thu, 15 Jul 2021 17:32:23 -0300 (-03)
Date:   Thu, 15 Jul 2021 17:32:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 15/20] perf trace: free malloc'd trace fields on exit
Message-ID: <YPCbV92iVme1WdFs@kernel.org>
References: <cover.1626343282.git.rickyman7@gmail.com>
 <de5945ed5c0cb882cbfa3268567d0bff460ff016.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de5945ed5c0cb882cbfa3268567d0bff460ff016.1626343282.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jul 15, 2021 at 06:07:20PM +0200, Riccardo Mancini escreveu:
> ASan reports several memory leaks running the perf test
> "88: Check open filename arg using perf trace + vfs_getname".
> The first of these leaks is related to struct trace fields never being
> deallocated.
> 
> This patch adds the function trace__exit, which is called at the end of
> cmd_trace, replacing the existing deallocation, which is now moved
> inside the new function.
> This function deallocates:
>  - ev_qualifier
>  - ev_qualifier_ids.entries
>  - syscalls.table
>  - sctbl
>  - perfconfig_events
> 
> In order to prevent errors in case any of this field is never
> initialized, this patch also adds initialization to NULL to these
> fields.
> 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/builtin-trace.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 7ec18ff57fc4ae35..fe26d87ca8ccc14d 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4701,6 +4701,15 @@ static int trace__config(const char *var, const char *value, void *arg)
>  	return err;
>  }
>  
> +static void trace__exit(struct trace *trace)
> +{
> +	strlist__delete(trace->ev_qualifier);
> +	free(trace->ev_qualifier_ids.entries);
> +	free(trace->syscalls.table);
> +	syscalltbl__delete(trace->sctbl);
> +	zfree(&trace->perfconfig_events);
> +}
> +
>  int cmd_trace(int argc, const char **argv)
>  {
>  	const char *trace_usage[] = {
> @@ -4731,6 +4740,12 @@ int cmd_trace(int argc, const char **argv)
>  		.kernel_syscallchains = false,
>  		.max_stack = UINT_MAX,
>  		.max_events = ULONG_MAX,
> +		.ev_qualifier = NULL,
> +		.sctbl = NULL,
> +		.ev_qualifier_ids = {
> +			.entries = NULL,
> +			.nr = 0,
> +		},
>  	};
>  	const char *map_dump_str = NULL;
>  	const char *output_name = NULL;

The above hunk is not needed, as all non explicitely initialized members
will be zeroed, so to reduce patch size I'm dropping it.

Thanks, applied.

- Arnaldo


> @@ -5135,6 +5150,6 @@ int cmd_trace(int argc, const char **argv)
>  	if (output_name != NULL)
>  		fclose(trace.output);
>  out:
> -	zfree(&trace.perfconfig_events);
> +	trace__exit(&trace);
>  	return err;
>  }
> -- 
> 2.31.1
> 

-- 

- Arnaldo
