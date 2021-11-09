Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD27C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 01:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0328761105
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 01:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239527AbhKIBvc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 20:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239515AbhKIBvc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 20:51:32 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C66C061766
        for <linux-perf-users@vger.kernel.org>; Mon,  8 Nov 2021 17:48:47 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id u17so17966345plg.9
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 17:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nmjVrpmF2KKGvFEgq/XE5mXulYLRvLz+Yf/tqScYzE8=;
        b=mMeY/rHFIKR0L+1vwdeY62NRpsgzSEud8m2/8toS4e+MsciWJKJ0zPQynYCetxOn09
         eacjvT+rgE7luYUPqaWrlp0U7xAzoRcsHu0bwK9Qzz6FndsEShsKNwfbmD6OpqvuyudT
         FfNIt366DefmcSzIy4qHe6u4zjIaLoiOMjfkkR/8m3Urtm2zddZsvYmyJX59J8h0LdB0
         iqUmc8Cy85crXDAEIEnW6h5YMviL1kCsWzhxAzszuskq8PvFJJa1AUJiaqPFiBshWJ4n
         GZYaT9jkxpJY+6OTJvICK/v7Af8UW4xguyqNeQPYwWxAfwuD40JLxL3MSiHLIMMS4Rkq
         oVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nmjVrpmF2KKGvFEgq/XE5mXulYLRvLz+Yf/tqScYzE8=;
        b=wI9FJ8AAwW4Ndv8AWo8UDytKbkkq5V2nC45Pt0WnNt9INVp0ICsUR2CmVfXEEYP3di
         JplfBvKVACFz+1VILior8j/d4s2FNucWUp1m69EmOVAOml3muumhkE2Mbsb7hkH8K+WL
         UP6o/UDqovnOmCcxwcJBVNFrszcchoRWiSgiHIY/bmJD22JdjnPBe4l1MUGNJhbeBukJ
         u351UrhJpzkBPArTOLtwCfp8UVatzC5a/lotYVP0kuu9sOsqtaBhYcFuDtREzkR2cSWp
         Iy0X7gjPLi8+7vEVuskEvUgUWw7WZAkoEFoHHcuAomwrhwF8sfDCcnpHiOy6gxH0vqqT
         c5gA==
X-Gm-Message-State: AOAM531fPeq01CI25w5A69luQam2lzCpY3WR0mNetoDpyPulsEyeglNr
        Lorj79jMiY/I5Sbb0O97DVG46w==
X-Google-Smtp-Source: ABdhPJwFsNS7oDpQpm8FccCWtvXaUWFfGCkAXKxTipaSdTti1p9fA26jFYpEHR9K/caKCjyGT6Towg==
X-Received: by 2002:a17:90a:c58d:: with SMTP id l13mr3024556pjt.189.1636422526914;
        Mon, 08 Nov 2021 17:48:46 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id k1sm9135177pfu.31.2021.11.08.17.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 17:48:46 -0800 (PST)
Date:   Tue, 9 Nov 2021 09:48:43 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     John Garry <john.garry@huawei.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: Question: SMMUv3 PMU event aliasing
Message-ID: <20211109014843.GD1388819@leoy-ThinkPad-X240s>
References: <20211108121941.GC1267967@leoy-ThinkPad-X240s>
 <8b24f36b-6459-c13c-bf19-b9f588eb6b8e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b24f36b-6459-c13c-bf19-b9f588eb6b8e@huawei.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi John,

On Mon, Nov 08, 2021 at 12:41:33PM +0000, John Garry wrote:

[...]

> > Could you share current status (or plan) for upstreaming SMMUv3 PMU
> > event alias?  Or if there have any block issue to prevent merging the
> > changes in the mainline kernel?
> 
> This feature should be supported in the SMMUv3 PMU kernel driver and perf
> tool.
> 
> However it relies on the SMMU PMU identifier sysfs file to work. This relies
> on SMMU_PMCG_IIDR being set, which is introduced latest spec, which not much
> HW will support yet - see commit 2c255223362e. In theory we don't need that
> for the fixed, non-IMPDEF events, but I did not complicate perf tool with
> that mixed support.
> 
> That's the reason for which I paused smmuv3-pmcg.json upstream in [3]. I
> will revive that for new gen HW when concrete IMPDEF events known and
> shared.

Thanks for info.  When send out the new patch, you are welcome to Cc
to me, I am glad to give a test on D06 board (its IIDR is zero, so
I need to tweak a bit in driver for IIDR :)).

Thanks,
Leo
