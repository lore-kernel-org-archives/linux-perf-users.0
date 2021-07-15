Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EE8C636C9
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 20:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7D46613D4
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 20:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhGOU0M (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 16:26:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229531AbhGOU0L (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 16:26:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF5D0613D3;
        Thu, 15 Jul 2021 20:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626380598;
        bh=NAA3pvCu1mpUmxXH7m15oH4LrJfZEDDX9RdjpZ4Ql6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J6ZWywj6Y87TtNVIvsZqXPqCIjkQXrtmVJfXJNWPNb04arBOYMHZa7C2Ub9RBniyY
         eS3DdAnuBaaiSf+8Z0rt3SYlv13mHnuxLN2zLCXrsBLJmVsF/9Mbm4e6Wp6IRKptIq
         ay4h1KB1X0/IKVw5Lyfry/vTbZnUyC+n9XCP9vaA1uzsrjJh0lPS8fQ+MeNed/ro3d
         GHkXawmIFM4ORVHHJQAJcMMzwU7LeKZ1rh8OCksowQ2iF08oQrU+af83P1/8bdMkKG
         ydpYnaf9JBhqTmAtqekFTWi9H/mh1Ba5qYFzRz7/OaKh0mwbec4iYA6FIfXmvBU9Rk
         LXWHSU2LAoaDQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 55306403F2; Thu, 15 Jul 2021 17:23:15 -0300 (-03)
Date:   Thu, 15 Jul 2021 17:23:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Milian Wolff <milian.wolff@kdab.com>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 12/20] perf script: release zstd data
Message-ID: <YPCZMzf/X8xlOws3@kernel.org>
References: <cover.1626343282.git.rickyman7@gmail.com>
 <39388e8cc2f85ca219ea18697a17b7bd8f74b693.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39388e8cc2f85ca219ea18697a17b7bd8f74b693.1626343282.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jul 15, 2021 at 06:07:17PM +0200, Riccardo Mancini escreveu:
> ASan reports several memory leak while running the perf test
> "82: Use vfs_getname probe to get syscall args filenames".
> One of the leaks is caused by zstd data not being released on exit in
> perf-script.
> 
> This patch adds the missing zstd_fini.

Fixes: b13b04d9382113f7 ("perf script: Initialize zstd_data")

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/builtin-script.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 8c03a9862872d495..bae0e5b72c0e6050 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -4143,6 +4143,7 @@ int cmd_script(int argc, const char **argv)
>  		zfree(&script.ptime_range);
>  	}
>  
> +	zstd_fini(&(session->zstd_data));
>  	evlist__free_stats(session->evlist);
>  	perf_session__delete(session);
>  
> -- 
> 2.31.1
> 

-- 

- Arnaldo
