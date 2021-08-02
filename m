Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB6BC4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  2 Aug 2021 14:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6739560FC1
	for <linux-perf-users@archiver.kernel.org>; Mon,  2 Aug 2021 14:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbhHBOwL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 2 Aug 2021 10:52:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233925AbhHBOwK (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 2 Aug 2021 10:52:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B45E60F70;
        Mon,  2 Aug 2021 14:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627915921;
        bh=6t51VO9yCjRtkFGlvwCg/xuFX5HR4ZRg5q15g2jcCKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jmhwzY2WNEivRJ2JEN0fyJxqDv4j+d2EC8B19QZN6u1vj/o5cL1KVY+/HS5LSB3fd
         wugLh1HC71glvGjuOume0HoTAuLyjVY7NdXuGdF9j9QwQ/nv1AN6VCcOYVbyJA8XVj
         obDBnCoxyjunn6wW4x8hF46W1nCKS24P7slC+tWX2KIs4Ipb28wNo1n5ekta+kqKeR
         Fd9Si5v+IfIhfEdFeexGYx6WjPIDvhgZt1BIxb33mBo1c/knqyOG4CmeGkuyQ8h3Ij
         nKmIupR9JD7kDUOve/1Tg8f0zmu4heC4rpzDhkyv6VPr56tcFvQOyxrnNISkuup51J
         +GnbaITXO1IIQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 80BA1403F2; Mon,  2 Aug 2021 11:51:58 -0300 (-03)
Date:   Mon, 2 Aug 2021 11:51:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 6/6] perf cs-etm: Add warnings for missing DSOs
Message-ID: <YQgGjlWtbaNApkp6@kernel.org>
References: <20210729155805.2830-1-james.clark@arm.com>
 <20210729155805.2830-7-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729155805.2830-7-james.clark@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jul 29, 2021 at 04:58:05PM +0100, James Clark escreveu:
> Currently decode will silently fail if no binary data is available for
> the decode. This is made worse if only partial data is available because
> the decode will appear to work, but any trace from that missing DSO will
> silently not be generated.
> 
> Add a UI popup once if there is any data missing, and then warn in the
> bottom left for each individual DSO that's missing.

Looks ok to me (the last 3 patches in this series, the rest I applied
already), can I get some Acked-by/Reviewed-by from the CoreSight people?

Thanks,

- Arnaldo
 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/cs-etm.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 32ad92d3e454..e6851260d059 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -746,8 +746,16 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
>  
>  	len = dso__data_read_offset(al.map->dso, machine, offset, buffer, size);
>  
> -	if (len <= 0)
> +	if (len <= 0) {
> +		ui__warning_once("CS ETM Trace: Missing DSO. Use 'perf archive' to export data from the traced system.\n");
> +		if (!al.map->dso->auxtrace_warned) {
> +			pr_err("CS ETM Trace: Debug data not found for address %#"PRIx64" in %s\n",
> +				    address,
> +				    al.map->dso->long_name ? al.map->dso->long_name : "Unknown");
> +			al.map->dso->auxtrace_warned = true;
> +		}
>  		return 0;
> +	}
>  
>  	return len;
>  }
> -- 
> 2.28.0
> 

-- 

- Arnaldo
