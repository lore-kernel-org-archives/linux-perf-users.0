Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F164CC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Apr 2022 09:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiDMJSg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Apr 2022 05:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbiDMJSd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Apr 2022 05:18:33 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6214EDEC
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Apr 2022 02:16:11 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lc2so2586712ejb.12
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Apr 2022 02:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hblV92aPuej0p7ID1pULy+QJqaua2alXaevi7dvbrUU=;
        b=WIKXHBwkh+EhYN8jqtAXZe/Tyt8mlkW3bASrYOTKf1/6ge/9WE1nIcoqoLkLWZkPr+
         FuERh7yZiwLbnv26+FajLXbbB75K2YiEWujiEgeWrDPIHmfIk8Ax23RC5q3WlZotvyTH
         ZpUT2qdGpTeLuIP41ve4yDKHzRrKtA2+OmLRM/YD4Ae18UQh0LFx79dI3RociC1gS1MV
         0GWLpcliTgiZZqqLFa3ItfdN0QMJhgbdBPT17kSAQJ3IPDziLjdvBNnmc/KVxUQ0y9T1
         girU0IDsD5jSag+T+B44HWzEzy4TZ6vL8lA/M2EitPrzeX1Kg+Xh/zsoXobUjvPHLE3P
         21ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hblV92aPuej0p7ID1pULy+QJqaua2alXaevi7dvbrUU=;
        b=U9wixnTVjIRNfwCMdr88qoBFkVqp8wViP06ECN0SMcAeQEZckXemRTp4yZACCd7XEJ
         WoepXiEzyB4VZmkz5wotrFrFTutA1PJLKATb5xbbuvG7WloHBlVCSLepQyMQ3sepI0zy
         gWEGNHeaVuMKUAmKPjrkiXRrYXMDOGJ+1nXBI8rw0CE/KqjlQOPiuSb7jPob49PiQY8n
         JXMY90FKTeqJ0OrhHXu3WvzUq0KWtfFS6NtIiM9fWJ7Pc8gC/l4Y7/eRZMbBOYNAbkqk
         WVMx65IGg+taO7UyE4IUwPpAzQ7cr6CD4Mo8WIUc7epmBUX5j2CAX8TfrPxDAxt2uwuK
         9wOg==
X-Gm-Message-State: AOAM533Z7xv+QXb1kyq6+ePYn5cKaMV/1KU1FlyF/ioCiCJVvekvg249
        BiD9eD2Nz+o7e/sAx+FGuhbBmQ==
X-Google-Smtp-Source: ABdhPJzxWtxkUmiepBnlWMtTjViNplCdRi9hB0wNwbQbHSHOc/I9rRLkD4QZgJDJkLGQcI1wZksGyw==
X-Received: by 2002:a17:906:7111:b0:6e8:973a:1515 with SMTP id x17-20020a170906711100b006e8973a1515mr11383665ejj.308.1649841369670;
        Wed, 13 Apr 2022 02:16:09 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id e12-20020a170906c00c00b006e66eff7584sm12637990ejz.102.2022.04.13.02.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:16:09 -0700 (PDT)
Date:   Wed, 13 Apr 2022 17:16:04 +0800
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
Message-ID: <20220413091604.GD521036@leoy-ThinkPad-X240s>
References: <20220413075124.635589-1-leo.yan@linaro.org>
 <c21b3409-a8a0-aae7-7634-5e648f0a49b1@arm.com>
 <20220413084941.GB521036@leoy-ThinkPad-X240s>
 <38078438-dbce-690b-ba79-5c3713f97816@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38078438-dbce-690b-ba79-5c3713f97816@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Apr 13, 2022 at 10:14:00AM +0100, German Gomez wrote:
> 
> On 13/04/2022 09:49, Leo Yan wrote:
> > On Wed, Apr 13, 2022 at 09:15:40AM +0100, German Gomez wrote:
> >
> > [...]
> >
> >>>  	if (sort__mode == SORT_MODE__MEMORY) {
> >>> +		/*
> >>> +		 * FIXUP: prior to kernel 5.18, Arm SPE missed to set
> >>> +		 * PERF_SAMPLE_DATA_SRC bit in sample type.  For backward
> >>> +		 * compatibility, set the bit if it's an old perf data file.
> >>> +		 */
> >>> +		evlist__for_each_entry(session->evlist, evsel) {
> >>> +			if (strstr(evsel->name, "arm_spe_") &&
> >> This didn't work for me when the file recorded "-e arm_spe//" instead of
> >> "-e arm_spe_0//". Could you remove the trailing _? With that:
> > Sure, will change to "arm_spe".  Just curious, if there any local
> > change at your side so we have the different event name?
> 
> No local changes. I've always used "arm_spe//" and it always defaults to
> "arm_spe_0//". But it's still stored as the former in the data file. I
> haven't checked where this default happens though. Isn't it the same for
> you?

Yeah, this is same with me.  Thanks for explanation.

Leo
