Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE1FC6FD1D
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Mar 2023 03:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjCPDCS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 15 Mar 2023 23:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCPDCR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Mar 2023 23:02:17 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052D6BBB23
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Mar 2023 20:02:16 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so212326pjg.4
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Mar 2023 20:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678935735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a7EWiKEbOPUDyB/zyzM3aKt/kTkta+HN39sJbR4GK64=;
        b=zda6cwqWDW/ZoGfEs0UKEVqsEmth82V2Op4mAzethVMRg93zU57nyUl68JRhzcpOQv
         YN+splHI4ZJWsS/7IuLDd6eQ6IhqAmExpcMDGFcJH74LsNLvy7nFyJgX8l5XKJPzU29y
         etx3nvUnF9kQc3+2d644rev8b8j42vSrpcNryJtfor1+0OHitsM1CFkBqQUtMOQTjUMW
         Ci73rGO108SF3gs5JFXg0tOcVZDwiwQgpLwLDtZ8TkNv8TjbSiyJbfxg7QmfYjCWfzdl
         xVk2AWAn4INbBEb0vx1Tc4vcGVxouJHGcexIDc6fd6n25NJ45gABMovrDxFO2Pt4S3Oc
         0JNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678935735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7EWiKEbOPUDyB/zyzM3aKt/kTkta+HN39sJbR4GK64=;
        b=FhuTHyHHWF3usevAqdmcfb/SHXxdtpUnR2G2cuBpEaoCUhtCNRbJPPNIG7x/klN8/5
         rN372nHM7jMCzVE+AbqNUiGWV0uGnTi6t2x8Mw5DAS+pHCfHpP0SDgaILmkw/snNWC5I
         bAMj1/QGuVQ5IONqvCN/gB1weMMoxKg8ikxYgeqmBUWC4LWUMKaZdGF2XbvQwRz+erSY
         OEa7iUNaoOE0xc5416X/uMn7OM3Rmvzp5pCdvviSovgiOMjV7ZSfcAqFsxDN51v6ojry
         TPQ0DLHOz+uTuNzvRPYVtS374b3DEMwyuFtibA/hENxLwG6/iZCQzsryMbk9oA70arl6
         bM9w==
X-Gm-Message-State: AO0yUKUGOW+qbe04I8LqyJmqcnr+j4hifypsBBCpyd8HY0f6TNYbF5rN
        96rtYoZ+v1Lkyw63cikB01jWD8H9yepzURwxqqTM0ICh
X-Google-Smtp-Source: AK7set8c5ZrGL+nvSbQvYycqwXtRzHVmOwi5GpQiW2J6MANXBQteRhZRjSlj0F7wF52H79vCfsNpFQ==
X-Received: by 2002:a05:6a20:729c:b0:cc:eb3b:56e9 with SMTP id o28-20020a056a20729c00b000cceb3b56e9mr2856563pzk.1.1678935735350;
        Wed, 15 Mar 2023 20:02:15 -0700 (PDT)
Received: from leoy-yangtze.lan ([107.151.177.133])
        by smtp.gmail.com with ESMTPSA id c20-20020aa78814000000b005907716bf8bsm1729115pfo.60.2023.03.15.20.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 20:02:14 -0700 (PDT)
Date:   Thu, 16 Mar 2023 11:02:06 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 06/16] perf kvm: Introduce histograms data structures
Message-ID: <20230316030206.GB2267252@leoy-yangtze.lan>
References: <20230315145112.186603-1-leo.yan@linaro.org>
 <20230315145112.186603-7-leo.yan@linaro.org>
 <ZBIgcX0TmC0tyFR0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBIgcX0TmC0tyFR0@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

On Wed, Mar 15, 2023 at 04:45:53PM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> Had to add:
> 
> 
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index c4cb34df155fec67..b06c11d306a11cab 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -85,7 +85,6 @@ static struct kvm_event_key keys[] = {
>  	DEF_SORT_NAME_KEY(time, mean),
>  	{ NULL, NULL }
>  };
> -#endif // defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
>  
>  struct kvm_hists {
>  	struct hists		hists;
> @@ -100,6 +99,7 @@ static int kvm_hists__init(void)
>  	perf_hpp_list__init(&kvm_hists.list);
>  	return 0;
>  }
> +#endif // defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)

Thanks for fixing up, this is fine for me.

Seems to me it is not a good practice to use macros (and nested macros) to
mute or unmute big chunk code.  I will try to refine the building
builtin-kvm.c and prepare patches based on current code base.

P.s. I saw this series has been picked up into your branch
acme/tmp.perf-tools-next, if you want me to follow up anything, please
let me know.  Thank you!

Leo
