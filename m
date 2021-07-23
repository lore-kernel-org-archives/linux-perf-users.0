Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37468C432BE
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jul 2021 19:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1411D60E97
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jul 2021 19:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhGWSnZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jul 2021 14:43:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230172AbhGWSnY (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jul 2021 14:43:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD75460EAF;
        Fri, 23 Jul 2021 19:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627068237;
        bh=VKU1ujMLPfCXntoRdrEDdnQSHWjHKJdXdRyYBhmU6fE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OcZBEvcpLgBdYKdwVxk4+BOn+ma2Mj6vAhSKDwXmj2kt1Bio6D/prcnno8j/VSTR4
         T9qBXffGho9U8LBZIwKlSvfZ6wf+Gl2ebaYO0lGuFNbuQog6/MXyxjovep0MXJBj34
         PZl02zpy1w0I7tmNACZDSh55Q67guQVmXCqYybqjTNcm1GtVsE0wnkbnBRZSo6lbHH
         j/Ty7wgAnBmXBXZhBzvLiW8jpgqXFWhbenadXF5+UZc9KEfLTOfsmCwRbXB7bUSb/A
         csROLjI4tvwIrujOcMOyMrWqtNq/JSu7gu5ggwNrSe1qbHXFBgP7GV69FWi68QwgHK
         RB2KHBF4G8++A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9AB4C403F2; Fri, 23 Jul 2021 16:23:53 -0300 (-03)
Date:   Fri, 23 Jul 2021 16:23:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mark.rutland@arm.com,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, mliska@suse.cz, irogers@google.com,
        dzhu@wavecomp.com, rickyman7@gmail.com, yao.jin@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangjinhao2@huawei.com
Subject: Re: [PATCH] perf env: Normalize aarch64.* to arm64 in
 normalize_arch()
Message-ID: <YPsXSRi+8z5ozc/U@kernel.org>
References: <20210723014944.214887-1-lihuafei1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723014944.214887-1-lihuafei1@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Jul 23, 2021 at 09:49:44AM +0800, Li Huafei escreveu:
> On my aarch64 big endian machine, the perf annotate does not work.
> 
>  # perf annotate
>   Percent |      Source code & Disassembly of [kernel.kallsyms] for cycles (253 samples, percent: local period)
>  --------------------------------------------------------------------------------------------------------------
>   Percent |      Source code & Disassembly of [kernel.kallsyms] for cycles (1 samples, percent: local period)
>  ------------------------------------------------------------------------------------------------------------
>   Percent |      Source code & Disassembly of [kernel.kallsyms] for cycles (47 samples, percent: local period)
>  -------------------------------------------------------------------------------------------------------------
>  ...
> 
> This is because the arch_find() function uses the normalized architecture
> name provided by normalize_arch(), and my machine's architecture name
> aarch64_be is not normalized to arm64.  Like other architectures such as
> arm and powerpc, we can fuzzy match the architecture names associated with
> aarch64.* and normalize them.

This looks ok modulo fixing the problem and adding that extra pr_err()
in a single patch, please split this into two.

Also I fail to see why c34df25b40c2 introduced this problem :-\

Can some ARM person ack/review this, please?

- Arnaldo
 
> Fixes: c34df25b40c2 ("perf annotate: Add symbol__annotate function")
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> ---
>  tools/perf/util/annotate.c | 4 +++-
>  tools/perf/util/env.c      | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index aa04a3655236..cb280de3369f 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2192,8 +2192,10 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
>  		return errno;
>  
>  	args.arch = arch = arch__find(arch_name);
> -	if (arch == NULL)
> +	if (arch == NULL) {
> +		pr_err("%s: unsupported arch %s\n", __func__, arch_name);
>  		return ENOTSUP;
> +	}
>  
>  	if (parch)
>  		*parch = arch;
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index cec2e6cad8aa..a91da1e9b201 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -349,7 +349,7 @@ static const char *normalize_arch(char *arch)
>  		return "x86";
>  	if (!strcmp(arch, "sun4u") || !strncmp(arch, "sparc", 5))
>  		return "sparc";
> -	if (!strcmp(arch, "aarch64") || !strcmp(arch, "arm64"))
> +	if (!strncmp(arch, "aarch64", 7) || !strcmp(arch, "arm64"))
>  		return "arm64";
>  	if (!strncmp(arch, "arm", 3) || !strcmp(arch, "sa110"))
>  		return "arm";
> -- 
> 2.17.1
> 

-- 

- Arnaldo
