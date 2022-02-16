Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42212C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 16 Feb 2022 13:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiBPNy5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 16 Feb 2022 08:54:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbiBPNy4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Feb 2022 08:54:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D4B1F1B7A;
        Wed, 16 Feb 2022 05:54:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3861CB81EE6;
        Wed, 16 Feb 2022 13:54:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9EEEC004E1;
        Wed, 16 Feb 2022 13:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645019681;
        bh=2B8S6YHpBySf2hlnpABtSvzJucO6p4JkCrOONDOXBKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k65VbYj/zzOZyoCtMWTbOoLD/Jle4LYsluqjYQ93WllBLh0upRTIzBTe7bH31dNZW
         LkpEOqe4y4gaSDaSnfh4sTjPM+zmFdChnqmPyY0c8Rp1IO+J5sb4S2FtcFw1/ntvSD
         wje7UHNpyL54RLHsHNY0hMLAnlvtVQfjILUynNuDQNyNnyN5Up+puPXHZ/03DnulZR
         FTfarCuzNdQw0dmQ5ZmQVSGM+NhYS4yikzHbxSP4KsNmUW0yw+cU61mEmFOS89cv76
         pirAW+cb5ao551C7CavnQRwzr5wFPG7I8zdMutwifyrSrxxgVpnEcL5FzdbDG995MG
         tn8JP9X3UfsIw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 52947400FE; Wed, 16 Feb 2022 10:54:39 -0300 (-03)
Date:   Wed, 16 Feb 2022 10:54:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] perf tools: Fix spelling mistake "commpressor" ->
 "compressor"
Message-ID: <Yg0CHxw1iy2Y+F69@kernel.org>
References: <20220214093547.44590-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214093547.44590-1-colin.i.king@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Feb 14, 2022 at 09:35:47AM +0000, Colin Ian King escreveu:
> There is a spelling mistake in a debug message. Fix it.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  tools/perf/util/mmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index 4cb5f2f159cc..50502b4a7ca4 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -298,7 +298,7 @@ int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, struct perf_cpu
>  	map->comp_level = mp->comp_level;
>  #ifndef PYTHON_PERF
>  	if (zstd_init(&map->zstd_data, map->comp_level)) {
> -		pr_debug2("failed to init mmap commpressor, error %d\n", errno);
> +		pr_debug2("failed to init mmap compressor, error %d\n", errno);
>  		return -1;
>  	}
>  #endif
> -- 
> 2.34.1

-- 

- Arnaldo
