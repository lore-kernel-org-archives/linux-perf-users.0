Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2073C77B61
	for <linux-perf-users@archiver.kernel.org>; Sat, 29 Apr 2023 01:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjD2Bxa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Apr 2023 21:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347165AbjD2Bxa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Apr 2023 21:53:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CD730D2;
        Fri, 28 Apr 2023 18:53:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 133586381A;
        Sat, 29 Apr 2023 01:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3083EC433D2;
        Sat, 29 Apr 2023 01:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682733206;
        bh=+TDrBsUXK9LBvhOasneN/5DL8bhxJi2WMFP1alFlGkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A9ccRJOKhL7e2akp0Rr2Eze0E8c+Ri/8FA7e0jMaqJc73od3XtN8SJ2dGs9gcUAav
         nEX1AlYK/gVLRT/5TMjFIUogWeEZ+NrxHVuUXd8IBdLDOd5unO8WW5dY0ThcIevPvo
         ynR0NVOFUer687MJY2T6X+ssSlZ4wNIFvyWumCX+ERJsBFovKM1vgkgQL73TwtIsvG
         qfVOnWeefZBm5hM/s99MfwltR4tEVCbm+esOOMPlIKfvzZqJ2Rib7uuQh6SiMm1Z61
         RR/L5rVtXguREOmBgJBRm6XQbywdimMfRiqDuGRFr0mdIcf8s4gETFmkiVolOWg56/
         +DoxoZ6ZAhWNg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7A476403B5; Fri, 28 Apr 2023 22:53:23 -0300 (-03)
Date:   Fri, 28 Apr 2023 22:53:23 -0300
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hui Wang <hw.huiwang@huawei.com>
Subject: Re: [PATCH] perf: unwind: suppress massive unsupported target
 platform errors
Message-ID: <ZEx4k+tl6HPH3fsx@kernel.org>
References: <20230426032246.3608596-1-changbin.du@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426032246.3608596-1-changbin.du@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Apr 26, 2023 at 11:22:46AM +0800, Changbin Du escreveu:
> When cross-analyzing perf data recorded on an another platform, massive
> unsupported target platform errors are printed. So let's show this message
> as warning and only once.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> ---
>  tools/perf/util/unwind-libunwind.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
> index 509c287ee762..e95adbedf6ed 100644
> --- a/tools/perf/util/unwind-libunwind.c
> +++ b/tools/perf/util/unwind-libunwind.c
> @@ -54,7 +54,7 @@ int unwind__prepare_access(struct maps *maps, struct map *map, bool *initialized
>  	}
>  
>  	if (!ops) {
> -		pr_err("unwind: target platform=%s is not supported\n", arch);
> +		pr_warning_once("unwind: target platform=%s is not supported\n", arch);
>  		return 0;
>  	}
>  out_register:
> -- 
> 2.25.1
> 

-- 

- Arnaldo
