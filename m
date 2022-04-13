Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C80C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Apr 2022 09:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiDMJP5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Apr 2022 05:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiDMJP4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Apr 2022 05:15:56 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E2D1EC63
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Apr 2022 02:13:35 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id v15so1543394edb.12
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Apr 2022 02:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A6HjxEs9rpj/RCezhjuC+/JyeFmy0zQ3DUyU3NxIzRk=;
        b=YBZIIcr+RyzRPqywHaCL+NsxvKXHOMq3vhIP31VtwaR075dDIzYs3Qxk5xJMgaj/6Z
         Dp2/mxKYeEgQFgueu7NW3TQPPfE8KFqrpMI3DNybOTlPIuZlqBSouKOw9e4Hax5h7t3N
         Os8CgIrVI7khM8+q3xhMAR6CVgUr7heK+QzIFGri3G/UyvSZlAwBBxUI4gehw8jzX4MT
         SFS6ruQ1vKqZkcNE8I+keDuZUjeAHTe265JkO9GjrcRgHnHl56pU2TLISjnQke8qLp7f
         e/ppnNcXB8W0o/x4t+R+Ei2k5XNpIhbYneQRyG+fyMFGUaYsumniVcbxXIdc0QtXSN41
         JKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A6HjxEs9rpj/RCezhjuC+/JyeFmy0zQ3DUyU3NxIzRk=;
        b=HeiQvwtI/slGnIgfmqNs7vKubsi/vxJ0eDOgf3E++FOWmrVILHm8CyBYa4Jq/jnkTW
         cbmwDKEemuudQRD2AqyccU9kwh0d3/38M/eHyr2k1P2Wp+yG7cxQezouxeZC1V/ZTv2k
         cIYAu+FTt+FxGPCzmJo5n2fQoMKty2JNdSc2shLwVBmtswhsmjmKX51MFliZ9E22YP0k
         S1qO61dgymgwTogr1VHm7FwBuv0lGKVeJw8HmnEGOiEfhpBtUeCBkR63wnLBrNwD3Usk
         HbT+YrF50gII3a337IsfMVeW+sHnDXpXkrDBV2bnvdsPrMexFehO0EXhc7iwvl+Lhys1
         gLNQ==
X-Gm-Message-State: AOAM531tj+Jxosph4HZCI0Zkkbh2Ak1Ahxcqu2TH/BdkOdaeOyZWQxy0
        zIJ5yadkc1R/aR1lqHrQshvk90MW+i6HYyXnBlOfaA==
X-Google-Smtp-Source: ABdhPJywFNs8Pk/V9Pd4WdH1qY02jHRTKwXrYl7/fffog1DLPnFCScj6xyXnI1fkJNoBupCMRkKwQw==
X-Received: by 2002:a05:6402:28b6:b0:41d:8c2e:c97e with SMTP id eg54-20020a05640228b600b0041d8c2ec97emr9222466edb.45.1649841214041;
        Wed, 13 Apr 2022 02:13:34 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id k7-20020a17090666c700b006e8688d5fcbsm5290477ejp.135.2022.04.13.02.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:13:33 -0700 (PDT)
Date:   Wed, 13 Apr 2022 17:13:27 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf report: Set PERF_SAMPLE_DATA_SRC bit for Arm SPE
 event
Message-ID: <20220413091327.GC521036@leoy-ThinkPad-X240s>
References: <20220413075124.635589-1-leo.yan@linaro.org>
 <c21b3409-a8a0-aae7-7634-5e648f0a49b1@arm.com>
 <20220413084941.GB521036@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413084941.GB521036@leoy-ThinkPad-X240s>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Apr 13, 2022 at 04:49:41PM +0800, Leo Yan wrote:
> On Wed, Apr 13, 2022 at 09:15:40AM +0100, German Gomez wrote:
> 
> [...]
> 
> > >  	if (sort__mode == SORT_MODE__MEMORY) {
> > > +		/*
> > > +		 * FIXUP: prior to kernel 5.18, Arm SPE missed to set
> > > +		 * PERF_SAMPLE_DATA_SRC bit in sample type.  For backward
> > > +		 * compatibility, set the bit if it's an old perf data file.
> > > +		 */
> > > +		evlist__for_each_entry(session->evlist, evsel) {
> > > +			if (strstr(evsel->name, "arm_spe_") &&
> > 
> > This didn't work for me when the file recorded "-e arm_spe//" instead of
> > "-e arm_spe_0//". Could you remove the trailing _? With that:
> 
> Sure, will change to "arm_spe".  Just curious, if there any local
> change at your side so we have the different event name?

I think I know the reason now, though the PMU event is 'arm_spe_0',
but we could use '-e arm_spe//' to record, so finally the event name
is 'arm_spe'.

Thanks,
Leo
