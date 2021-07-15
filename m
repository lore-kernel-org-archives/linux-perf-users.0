Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEDCC636C9
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 20:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73FAE613DB
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 20:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237605AbhGOUmb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 16:42:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237504AbhGOUma (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 16:42:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 028D2613D4;
        Thu, 15 Jul 2021 20:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626381577;
        bh=C8fLfilXLg7ljnDMO6+nnt/GtaHy+/e4ktyzhwy3JnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nkPko4q6xInQayyWDXLR+AACOHdEWis5GQZI2ntxdLs1pZofzPOVCGk3zyjOALKBw
         bPV3fVdFZjT2O1IghY3KuFBwpKRFXYajlNVxDp2h+dayGIYcu6BlsxlORoNzRIvPNd
         0OheaT0njs+YTKAqeDbJx8+MbbGdSFd6/Vzl+1thsSy9iXBdgw+EfFE0F8ucQxR7Lx
         y1Khoq5nuppPQoNr53BoLmducAYSZwW5U2GzgAmabZx2NZOGiKtHGQzEiBdQEY7zgA
         q5kGpOmJLuNR1s4k1MDZ/koEitW+pDswHKnp4Un3oL+bFGrJLjiiXVhMDQfMn3E7jj
         a4oloQ8FyL4nw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7898E403F2; Thu, 15 Jul 2021 17:39:34 -0300 (-03)
Date:   Thu, 15 Jul 2021 17:39:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Wang Nan <wangnan0@huawei.com>, Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 19/20] perf test: bpf: free obj_buf
Message-ID: <YPCdBhM7xwhFUl0s@kernel.org>
References: <cover.1626343282.git.rickyman7@gmail.com>
 <60f3ca935fe6672e7e866276ce6264c9e26e4c87.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60f3ca935fe6672e7e866276ce6264c9e26e4c87.1626343282.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jul 15, 2021 at 06:07:24PM +0200, Riccardo Mancini escreveu:
> ASan reports some memory leaks when running the perf test
> "42: BPF filter".
> The first of these leaks is caused by obj_buf never being deallocated in
> __test__bpf.
> 
> This patch adds the missing free.

Fixes: ba1fae431e74bb42 ("perf test: Add 'perf test BPF'")

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/tests/bpf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
> index 33bda9c265423547..2cda4a6297e07967 100644
> --- a/tools/perf/tests/bpf.c
> +++ b/tools/perf/tests/bpf.c
> @@ -276,6 +276,7 @@ static int __test__bpf(int idx)
>  	}
>  
>  out:
> +	free(obj_buf);
>  	bpf__clear();
>  	return ret;
>  }
> -- 
> 2.31.1
> 

-- 

- Arnaldo
