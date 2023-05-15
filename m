Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5911EC77B7D
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 May 2023 21:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245364AbjEOVaY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 15 May 2023 17:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245587AbjEOVaX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 May 2023 17:30:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9D440E4;
        Mon, 15 May 2023 14:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D793C614CB;
        Mon, 15 May 2023 21:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FEEC433D2;
        Mon, 15 May 2023 21:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684186220;
        bh=PrSt0VkkDgvVp93ERiJnCl7qNmkpl0JS4c8ZrbTuJgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZA6wtW41N2r0S4jWDxUdN0IXtwdlAHsPr/WFyKWb8y36ou9CxQ5DxNdo87wuZiAxy
         18d4AYbPru/KwTULzBq8nEdMer0Iq/6sAPFoGFfeZaFuS/8vdwemNR04Gm+71h7w9l
         M1nTzvOFw88hC7wgkOqp8V9Od4EgQgcIMGaMVGWfQp1I4EO7RGUgPIWCA+86zaxYkw
         SBZMCv1ED+iVc5zRKEmjDwSS7zX6LYCmaP506FyPxKy246geO/m6lhrppVghokqtYO
         jejKHj+BZ55TTFIkDBDbxMQDELXhNqvSvxZjeEBvi65EyktVRPPJ7HggHuLeTChmaq
         KpNTTQ3/dOKnQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B3D7A403B5; Mon, 15 May 2023 18:30:17 -0300 (-03)
Date:   Mon, 15 May 2023 18:30:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: ftrace: flush output after each writing
Message-ID: <ZGKkaROtXT9Wq2ai@kernel.org>
References: <20230513074000.733550-1-changbin.du@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230513074000.733550-1-changbin.du@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sat, May 13, 2023 at 03:40:00PM +0800, Changbin Du escreveu:
> The pager will result stdout in full buffering mode instead of line
> buffering. We need to make the trace visible timely.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> ---
>  tools/perf/builtin-ftrace.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 810e3376c7d6..ad2a9ae041f6 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -650,6 +650,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>  				break;
>  			if (fwrite(buf, n, 1, stdout) != 1)
>  				break;
> +			/* flush output since stdout is in full buffering mode due to pager */
> +			fflush(stdout);
>  		}
>  	}
>  
> -- 
> 2.25.1
> 

-- 

- Arnaldo
