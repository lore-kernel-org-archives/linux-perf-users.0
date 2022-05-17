Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB59CC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 May 2022 11:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343559AbiEQLDh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 May 2022 07:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244215AbiEQLDd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 May 2022 07:03:33 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE375167F3
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 04:03:31 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y41so16536065pfw.12
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 04:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PjHTBfrAvfYwUJ31KQJIFgiibplD85RYkwP/rJccONE=;
        b=HdRX54HJiXnCxR1xsL8soi2Ob1QbMm+BEwNXSWrF/bBRQLDYy+tBIkEDTwQfrgn2+K
         sfApkdKQvdUqQC+89PadTZ3z8ExzT3fFQiGrCE4qZTc3tUIYk6LeNUuNoXPcAPaBEMr7
         8eeu0ZIIlwnwwg709xOh6EdcEqrmaIrNtcfiVZrOf1JLK3oH8j50ipb26Gd4UNgMWwCP
         MqnqHFA+9PNNbWqfLdpGBodbuW3oxe2obNj94sAtZFeCqCnqfkUByUBtZe7jOBQ0TDjF
         sfVGlfBiZA0V+DKOBaYiA+feepDzDGhRwVPYpQCeda1XY+fdSl96+YBhV6FmHXvoVH+8
         oRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PjHTBfrAvfYwUJ31KQJIFgiibplD85RYkwP/rJccONE=;
        b=zwNQhj2mp5agwG+lX2avglA6kVJPio5YLTFQGTKPMrN8BHuByuHLX+YNeSdmfYUrn0
         6BWGoXktmmaPfcctLe0WGVIOtAUWkdEoWFuU3ghK7VSJNFUr7J+f1Kh6EnedvmXSENE0
         m//wUfYjf+b5YSwa9BAKvdoOoHoyJpJ21ORsh+ELISmt+svDtRtr79vIwtcVmHa6s6Q4
         9DAtREFJJPZSSAa7Pz7UfIHjXRfj3MjUNbOOhI3PoJYsOm+gxuPoMzydOtMONO1FgjH+
         FXhUAfxUFUxaFQDlmK0wAuKpk4gJDKqyagUanY3eZuj1JnK169fI8MUTwmLSHJfwmiHe
         3NDg==
X-Gm-Message-State: AOAM530D6xV45NokFlU2iZWmXqSwF3GLd0NnR9/lYcA/7bd3VTtnhDz/
        oJfoJaFM0xCsyaEUleqbKkpOxg==
X-Google-Smtp-Source: ABdhPJzTOF6Tfl/amP70At7Vqtv/u46P4Fmt0pgzrECol0LhB40mtHBWn9tL4P2c6H6fAq5clNwhIQ==
X-Received: by 2002:a65:6e88:0:b0:382:3851:50c8 with SMTP id bm8-20020a656e88000000b00382385150c8mr19442523pgb.270.1652785411251;
        Tue, 17 May 2022 04:03:31 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([46.249.98.195])
        by smtp.gmail.com with ESMTPSA id 21-20020aa79155000000b0050dc76281e3sm8473071pfi.189.2022.05.17.04.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 04:03:30 -0700 (PDT)
Date:   Tue, 17 May 2022 19:03:22 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        broonie@kernel.org, acme@kernel.org, german.gomez@arm.com,
        mathieu.poirier@linaro.org, john.garry@huawei.com,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/4] perf tools: Use dynamic register set for Dwarf
 unwind
Message-ID: <20220517110322.GC153558@leoy-ThinkPad-X240s>
References: <20220517102005.3022017-1-james.clark@arm.com>
 <20220517102005.3022017-3-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517102005.3022017-3-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, May 17, 2022 at 11:20:03AM +0100, James Clark wrote:
> Architectures can detect availability of extra registers at
> runtime so use this more complete set for unwinding. This
> will include the VG register on arm64 in a later commit.
> 
> If the function isn't implemented then PERF_REGS_MASK is
> returned and there is no change.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

This patch looks good to me:
Reviewed-by: Leo Yan <leo.yan@linaro.org>

Just curious, do you think should update the test (e.g.
arch/arm64/tests/dwarf-unwind.c) to use arch__user_reg_mask()?

Thanks,
Leo

> ---
>  tools/perf/util/evsel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 5fd7924f8eb3..787bbcbcd2ae 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -896,7 +896,7 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
>  					   "specifying a subset with --user-regs may render DWARF unwinding unreliable, "
>  					   "so the minimal registers set (IP, SP) is explicitly forced.\n");
>  			} else {
> -				attr->sample_regs_user |= PERF_REGS_MASK;
> +				attr->sample_regs_user |= arch__user_reg_mask();
>  			}
>  			attr->sample_stack_user = param->dump_size;
>  			attr->exclude_callchain_user = 1;
> -- 
> 2.28.0
> 
