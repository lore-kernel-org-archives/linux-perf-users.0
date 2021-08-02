Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8FCC4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  2 Aug 2021 15:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A30D610FC
	for <linux-perf-users@archiver.kernel.org>; Mon,  2 Aug 2021 15:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbhHBPmD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 2 Aug 2021 11:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbhHBPmC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 2 Aug 2021 11:42:02 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0C6C061760
        for <linux-perf-users@vger.kernel.org>; Mon,  2 Aug 2021 08:41:53 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id i10so20093165pla.3
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Aug 2021 08:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IPGFm1JVt7oI2MPX9jivaw8zoW+8Rnmc7/BPuCII8Jo=;
        b=VwvaXSWrW68WjgLZEPqM4PM0EYl/IOdzxU8FSYgrgd33lc3Q+avni42/Rwj7BFvvDv
         na5Pvihf1rbv4b+OL5zHiFsm702Us8bW25rO4MbeXrGyq+ApYbt3x4DCuhre3sM2jwLC
         lcTOwpVumR221KSN7jnmm2w6B2RXK4GHYKbajgjEoWdzHPShLPGuZwZcBF+dW0yq82S0
         zxkVbmBfvoZ7roUsctuu/8nvpKUhkE6XsmNAqa1xhsqhOiNQT2ENIrNPSghAd5O5rzt/
         N7KpeEY1mItXsfx6LfgTVt61u5dmVqSoQmY69dsiXy48jA9++qzRLFyF17+g6XDmh3JO
         NW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IPGFm1JVt7oI2MPX9jivaw8zoW+8Rnmc7/BPuCII8Jo=;
        b=M+wd1DII5KcFI9j17OKF62R7c/PBRh+shB4vEfZplcZ6QP7uTWiEB3dbEPt4h+Vde5
         g5SjoUG+GpY9igMQQaKC/Fkr+dopedTN1Rxud1wW74y6Wh+ATmvb77TfmRlGUzx5DIL8
         q4KECVhPxss6aDGPZl/yRZyZdXezVyp+neJVo7OzolAbkmVuP+UyMOtYMksrFaDX/FHz
         DaVPDXj5CT/A4YTcaa1p8MWNQNecfUk1ymYVKoiyCYAA6zUlbTuTUKZS6jnNHorOdecU
         JywnVSVtd8gTRB3ZG5QSz9S23fNnvV2aomDPjpO/f7PU7wqcQljSh5KEG4oHWQZrlZkA
         bmsg==
X-Gm-Message-State: AOAM531GwmlGc+Ucgi0mikhPeoT3ObmnDIX3f5l4H8MkGFdNn7ydeSWA
        sRgMeYuGKRgERhqhJp/BQDtkkTdxW7tOwQ==
X-Google-Smtp-Source: ABdhPJyBZmJQKOQ93FLiKAY8bJep5+mWQ1DgLDqoZXSq76z6ETi50YV93BaQjdSZshivJlUEKVS+1g==
X-Received: by 2002:aa7:8d56:0:b029:327:6dc:d254 with SMTP id s22-20020aa78d560000b029032706dcd254mr17568179pfe.69.1627918912777;
        Mon, 02 Aug 2021 08:41:52 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id 198sm9871245pfu.32.2021.08.02.08.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 08:41:51 -0700 (PDT)
Date:   Mon, 2 Aug 2021 23:41:45 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 6/6] perf cs-etm: Add warnings for missing DSOs
Message-ID: <20210802154145.GC148327@leoy-ThinkPad-X240s>
References: <20210729155805.2830-1-james.clark@arm.com>
 <20210729155805.2830-7-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729155805.2830-7-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jul 29, 2021 at 04:58:05PM +0100, James Clark wrote:
> Currently decode will silently fail if no binary data is available for
> the decode. This is made worse if only partial data is available because
> the decode will appear to work, but any trace from that missing DSO will
> silently not be generated.
> 
> Add a UI popup once if there is any data missing, and then warn in the
> bottom left for each individual DSO that's missing.
> 
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

This is very useful.

Just one comment: in particularly if the perf fails to find the kernel
symbols, the user needs to enable config "CONFIG_PROC_KCORE=y" or
specify option "-k /path/to/vmlinux".  In this case, using 'perf
archive' is not helpful.  So I think the UI warning can be imporved
like:

        ui__warning_once("CS ETM Trace: Missing DSO. Use 'perf archive' to export data from the traced system.\n"
                         " Enable CONFIG_PROC_KCORE or use option '-k /path/to/vmlinux' for kernel symbols\n");

With this improvement, the patch looks good to me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

>  		return 0;
> +	}
>  
>  	return len;
>  }
> -- 
> 2.28.0
> 
