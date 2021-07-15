Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B7EC636C9
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 20:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FDF8613D9
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 20:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbhGOUeD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 16:34:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235562AbhGOUeB (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 16:34:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16E6D613D9;
        Thu, 15 Jul 2021 20:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626381068;
        bh=D8iIjq9U2XEFr/hbdrVDkVdZ7qoyKY+1QmdzD+wWDeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nKd4Vn3EySbupuKBcpLik0cbPh+D0tFpaPyXYJT2Vlq2iB0sGK+7FP8tXNvIIfeEs
         gbWtm3l83sRuMxkpKkxE7eErs7wH/77Lo9Dy3KHHYLWAlkye+4g1/98sseH7dURa0T
         qiNP39w/QuEdohn4MRBiK+oxo+BG6kJif1jJn+71LDEKKbOs1qMzsJxWjdYkzBgF2y
         sjvg3URy8RrDI8lMqNSCOpSCE5iC2/RhFxevLVeD6vjedHBumc2LVy1pgYPISFF8Jt
         RnrpzvjTiKy0rRp72YjomjNf8qdpBkJVMX5y0v6cEYTIGCVpju9SqXwDMoOm3vaVw8
         jrgGIwuqb20/A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B0313403F2; Thu, 15 Jul 2021 17:31:05 -0300 (-03)
Date:   Thu, 15 Jul 2021 17:31:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 14/20] perf util/lzma: close lzma stream
Message-ID: <YPCbCfXujLOiEDkz@kernel.org>
References: <cover.1626343282.git.rickyman7@gmail.com>
 <aaf50bdce7afe996cfc06e1bbb36e4a2a9b9db93.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaf50bdce7afe996cfc06e1bbb36e4a2a9b9db93.1626343282.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jul 15, 2021 at 06:07:19PM +0200, Riccardo Mancini escreveu:
> ASan reports memory leaks when running the perf test
> "88: Check open filename arg using perf trace + vfs_getname".
> One of these is caused by the lzma stream never being closed inside
> lzma_decompress_to_file.
> 
> This patch adds the missing lzma_end.

Fixes: 80a32e5b498a7547 ("perf tools: Add lzma decompression support for kernel module")

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/util/lzma.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/lzma.c b/tools/perf/util/lzma.c
> index 39062df0262915bd..51424cdc3b682c64 100644
> --- a/tools/perf/util/lzma.c
> +++ b/tools/perf/util/lzma.c
> @@ -69,7 +69,7 @@ int lzma_decompress_to_file(const char *input, int output_fd)
>  
>  			if (ferror(infile)) {
>  				pr_err("lzma: read error: %s\n", strerror(errno));
> -				goto err_fclose;
> +				goto err_lzma_end;
>  			}
>  
>  			if (feof(infile))
> @@ -83,7 +83,7 @@ int lzma_decompress_to_file(const char *input, int output_fd)
>  
>  			if (writen(output_fd, buf_out, write_size) != write_size) {
>  				pr_err("lzma: write error: %s\n", strerror(errno));
> -				goto err_fclose;
> +				goto err_lzma_end;
>  			}
>  
>  			strm.next_out  = buf_out;
> @@ -95,11 +95,13 @@ int lzma_decompress_to_file(const char *input, int output_fd)
>  				break;
>  
>  			pr_err("lzma: failed %s\n", lzma_strerror(ret));
> -			goto err_fclose;
> +			goto err_lzma_end;
>  		}
>  	}
>  
>  	err = 0;
> +err_lzma_end:
> +	lzma_end(&strm);
>  err_fclose:
>  	fclose(infile);
>  	return err;
> -- 
> 2.31.1
> 

-- 

- Arnaldo
