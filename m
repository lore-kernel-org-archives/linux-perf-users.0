Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FC0C636CC
	for <linux-perf-users@archiver.kernel.org>; Tue,  7 Feb 2023 15:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjBGPC5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 7 Feb 2023 10:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjBGPC4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 7 Feb 2023 10:02:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5254413D6E;
        Tue,  7 Feb 2023 07:02:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0313EB81731;
        Tue,  7 Feb 2023 15:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A6DC433D2;
        Tue,  7 Feb 2023 15:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675782172;
        bh=gFhz6N/QXgpKWP/OIB46yNAfnLfTBHDO9kB6/EXsqCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ql3LnbGcBu7cfI3HspBCgumvkqxPiv8J7eS5gEjR1xJl9vIs+gXLWevqBgJz3PMxU
         I5n0lQMTXovShIpCAX0k/PMdqOEYGHZbcm8Ear3Dd1Cazfyn/usPemoLaGoL4G4mfH
         BiWGjhoTK2cdTTnK/rMP620EPrUNfMV0sn5LFBJrafm78EaHE0Fnp1iRB1w5ZOgmt1
         5ip6vIEawmf5oueBDOQFDh2XIU8/Wl3wI1UgFmBoWi3RyJi5lDHGXeXisQxta57yR5
         llzOnLzbBR+feKTVOUDUTAIOzWQvkVLie6IL15WUFHIXWBCW/a8F+n09HQbQk4cZvj
         YwrfalqJm3L/w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 005E9405BE; Tue,  7 Feb 2023 12:02:49 -0300 (-03)
Date:   Tue, 7 Feb 2023 12:02:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel-next@vger.kernel.org,
        linux-perf-users@vger.kernel.org, hca@linux.ibm.com,
        egorenar@linux.ibm.com, gor@linux.ibm.com, svens@linux.ibm.com,
        sumanthk@linux.ibm.com
Subject: Re: [PATCH] tools/perf: Fix perf tool build error in util/pfm.c
Message-ID: <Y+JoGRdML/Ckkwvb@kernel.org>
References: <20230207140447.1827741-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230207140447.1827741-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Feb 07, 2023 at 03:04:47PM +0100, Thomas Richter escreveu:
> I have downloaded linux-next and build the perf tool using
> 
>  # make LIBPFM4=1
> 
> to have libpfm4 support built into perf. The build fails:
> 
>  # make LIBPFM4=1

Ian,

	Can you please take a look? Should we go this way or have some
feature test to check how that function signature should look?

- Arnaldo

> ....
> INSTALL libbpf_headers
>   CC      util/pfm.o
> util/pfm.c: In function ‘print_libpfm_event’:
> util/pfm.c:189:9: error: too many arguments to function ‘print_cb->print_event’
>   189 |         print_cb->print_event(print_state,
>       |         ^~~~~~~~
> util/pfm.c:220:25: error: too many arguments to function ‘print_cb->print_event’
>   220 |                         print_cb->print_event(print_state,
> 
> The build error is caused by
> commit d9dc8874d6ce ("perf pmu-events: Remove now unused event and metric variables")
> which changes the function prototype of
>   struct print_callbacks {
>       ...
>       void (*print_event)(...);  --> last two parameters removed.
>   };
> 
> but does not adjust the usage of this function prototype in util/pfm.c.
> In file util/pfm.c function print_event() is still invoked with 13 parameters
> instead of 11. The compile fails.
> 
> When I adjust the file util/pfm.c as in this patch, the build works file.
> Please check this patch for correctness, I have just fixed the compile
> issue.
> 
> Fixes d9dc8874d6ce ("perf pmu-events: Remove now unused event and metric variables")
> Cc: irogers@google.com
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/util/pfm.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
> index ac3227ba769c..b59ba825ddc9 100644
> --- a/tools/perf/util/pfm.c
> +++ b/tools/perf/util/pfm.c
> @@ -193,8 +193,7 @@ print_libpfm_event(const struct print_callbacks *print_cb, void *print_state,
>  			/*scale_unit=*/NULL,
>  			/*deprecated=*/NULL, "PFM event",
>  			info->desc, /*long_desc=*/NULL,
> -			/*encoding_desc=*/buf->buf,
> -			/*metric_name=*/NULL, /*metric_expr=*/NULL);
> +			/*encoding_desc=*/buf->buf);
>  
>  	pfm_for_each_event_attr(j, info) {
>  		pfm_event_attr_info_t ainfo;
> @@ -224,8 +223,7 @@ print_libpfm_event(const struct print_callbacks *print_cb, void *print_state,
>  					/*scale_unit=*/NULL,
>  					/*deprecated=*/NULL, "PFM event",
>  					ainfo.desc, /*long_desc=*/NULL,
> -					/*encoding_desc=*/buf->buf,
> -					/*metric_name=*/NULL, /*metric_expr=*/NULL);
> +					/*encoding_desc=*/buf->buf);
>  		}
>  	}
>  }
> -- 
> 2.39.1
> 

-- 

- Arnaldo
