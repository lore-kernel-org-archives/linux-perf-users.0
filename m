Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E53C636C9
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 20:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82E12613C4
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 20:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243448AbhGOUUy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 16:20:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242225AbhGOUUV (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 16:20:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C8A4613C9;
        Thu, 15 Jul 2021 20:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626380246;
        bh=EcIo672ePCXzrxoD9BkCfiytlP2siFNBfXCrLGE/Wic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n/Xmu/I2X2WZjQojiXVYrXCPck6+h8trQdsx9f6SoGFu5t0+1zhFY0SttKCkW5zGG
         6f9iVXh6urOA3+7yx4Gzje9AQJsM75FYLybeCfCVDsjTfj2IfnavkqHqBQjySY3xNK
         BkR5HrG+h8iaTfHx66rU8lbO/ML/dZmdJ6lp6yN8l4mcnHcVDZeQ3m+PYYd3TBd/ra
         rASUQcDaRaq0uD69mdODlWzMrQEyo3r3MUN4FPzd98Vph+LMXebhgqxAeskZm+Qgnc
         ypgk4wqdcI3rBNgK1L19pe2Vyqy69fQqxBKzJVkxclQ19B+rat7+2gneZere6HUqVl
         bKaP9KzvoPNFQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 23AF6403F2; Thu, 15 Jul 2021 17:17:24 -0300 (-03)
Date:   Thu, 15 Jul 2021 17:17:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 10/20] perf inject: close inject.output
Message-ID: <YPCX1OvZomL4NMnq@kernel.org>
References: <cover.1626343282.git.rickyman7@gmail.com>
 <c06f682afa964687367cf6e92a64ceb49aec76a5.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c06f682afa964687367cf6e92a64ceb49aec76a5.1626343282.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jul 15, 2021 at 06:07:15PM +0200, Riccardo Mancini escreveu:
> ASan reports a memory leak when running the perf test
> "83: Zstd perf.data compression/decompression", which happens inside
> perf-inject.
> The bug is caused by inject.output never being closed.
> 
> This patch adds the missing perf_data__close.

Fixes: 6ef81c55a2b6584c ("perf session: Return error code for perf_session__new() function on failure")

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/builtin-inject.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index ffd2b25039e36e1d..c88c61e7f8ccb6a7 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -993,8 +993,10 @@ int cmd_inject(int argc, const char **argv)
>  
>  	data.path = inject.input_name;
>  	inject.session = perf_session__new(&data, inject.output.is_pipe, &inject.tool);
> -	if (IS_ERR(inject.session))
> -		return PTR_ERR(inject.session);
> +	if (IS_ERR(inject.session)) {
> +		ret = PTR_ERR(inject.session);
> +		goto out_close_output;
> +	}
>  
>  	if (zstd_init(&(inject.session->zstd_data), 0) < 0)
>  		pr_warning("Decompression initialization failed.\n");
> @@ -1036,6 +1038,8 @@ int cmd_inject(int argc, const char **argv)
>  out_delete:
>  	zstd_fini(&(inject.session->zstd_data));
>  	perf_session__delete(inject.session);
> +out_close_output:
> +	perf_data__close(&inject.output);
>  	free(inject.itrace_synth_opts.vm_tm_corr_args);
>  	return ret;
>  }
> -- 
> 2.31.1
> 

-- 

- Arnaldo
