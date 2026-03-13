Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780A839DBC4;
	Fri, 13 Mar 2026 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773412963; cv=none; b=LLboJWzHxFX+WW/dIM1wqX5Wu5S7Wy88tKOPfePgSLyUMhCJSPx8XOg1UNXaOgaB6Lb+VMj2ZbMpZexb7DNZAooW2/orAFtLfv/oqNdMFhrQOEkoyxAwGmlbI7Pk9HpHnQSnYzypOHXPVVStt1DTAARmePg3KGktBKwkRSCgXmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773412963; c=relaxed/simple;
	bh=Gctqmv8j832HSANwQTR0pbldvumowi8c4lgvpTFGZUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3kkhNMbMp86szsYj+R15nNdofGsLYQ6c6aQr/YLU0L/md6zV9LyDjK4zRejEgY8WcXLBITdwyrhZkeT66xjBvts1Lr1ohgss/2N/37W8/Mj+gDYRGpYN02TLqqazwDteblU4GgGRaHy1OqESzsZko3S9Pey69FnrGOrnmLcHzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDB36165C;
	Fri, 13 Mar 2026 07:42:35 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94FA03F7BD;
	Fri, 13 Mar 2026 07:42:41 -0700 (PDT)
Date: Fri, 13 Mar 2026 14:42:39 +0000
From: Leo Yan <leo.yan@arm.com>
To: Mike Leach <mike.leach@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
	acme@kernel.org, suzuki.poulose@arm.com, leo.yan@linaro.org,
	peterz@infradead.org, mingo@redhat.com, will@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@redhat.com, namhyung@kernel.org
Subject: Re: [PATCH 1/2] perf: tools: cs-etm: Fix print issue for Coresight
 debug in ETE/TRBE trace
Message-ID: <20260313144239.GM4153946@e132581.arm.com>
References: <20260313132129.2743468-1-mike.leach@arm.com>
 <20260313132129.2743468-2-mike.leach@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313132129.2743468-2-mike.leach@arm.com>

On Fri, Mar 13, 2026 at 01:21:28PM +0000, Mike Leach wrote:
> Building perf with CORESIGHT=1 and the optional CSTRACE_RAW=1 enables
> additional debug printing of raw trace data when using command:-
> perf report --dump.
> 
> This raw trace prints the CoreSight formatted trace frames, which may be
> used to investigate suspected issues with trace quality / corruption /
> decode.
> 
> These frames are not present in ETE + TRBE trace.
> This fix removes the unnecessary call to print these frames.
> 
> Due to an addtional fault with the OpenCSD library, this call when ETE/TRBE
> are being decoded will cause a segfault in perf. This fix also prevents
> that problem for perf using older (<= 1.8.0 version) OpenCSD libraries.

Thanks for patches!

> Fixes: 68ffe3902898 ("perf tools: Add decoder mechanic to support dumping trace data")
> 

Redundant empty line.

> Reported-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: Mike Leach <mike.leach@arm.com>
> ---
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 3050fe212666..f7e89693cf16 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -739,7 +739,8 @@ cs_etm_decoder__new(int decoders, struct cs_etm_decoder_params *d_params,
>  		goto err_free_decoder;
>  
>  	/* init raw frame logging if required */
> -	cs_etm_decoder__init_raw_frame_logging(d_params, decoder);
> +	if (format == OCSD_TRC_SRC_FRAME_FORMATTED)
> +		cs_etm_decoder__init_raw_frame_logging(d_params, decoder);

Could we improve a bit to add checking in
cs_etm_decoder__init_raw_frame_logging(), something like:

 cs_etm_decoder__init_raw_frame_logging(struct cs_etm_decoder_params *d_params,
                                       struct cs_etm_decoder *decoder)
 {
+       /* No formatted trace frames */
+       if (!d_params->formatted)
+               return;

Sorry I should have mentioned this early.

>  
>  	for (i = 0; i < decoders; i++) {
>  		ret = cs_etm_decoder__create_etm_decoder(d_params,
> -- 
> 2.43.0
> 
