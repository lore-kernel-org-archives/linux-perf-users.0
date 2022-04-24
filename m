Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13151C433F5
	for <linux-perf-users@archiver.kernel.org>; Sun, 24 Apr 2022 11:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239297AbiDXLqM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 24 Apr 2022 07:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbiDXLqL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 24 Apr 2022 07:46:11 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97AED17C2
        for <linux-perf-users@vger.kernel.org>; Sun, 24 Apr 2022 04:43:10 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z99so15394841ede.5
        for <linux-perf-users@vger.kernel.org>; Sun, 24 Apr 2022 04:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vR6QyTXKzjneeimQgI3lYac2uhU+48R8rf60k+wC+NM=;
        b=K+eVy8LHU3Vs4eoXT0+qrRxAlQ6jVP2PJ/1UCE45qSIvmR9J0w19LAWrPbrfpkKaP0
         a+mfTOLAdPdmq8mtU1R407jZrmLBptYOTWYKm4bBBYVSCtMn7OkfZIC2UAev6uqZ/UZB
         H7jus/W4yKHDqFintBj9nBAgEPyEzumxjlQ60xsqq+ZlAy6LQUA4sqBIHkaNsdvJDmx3
         vq0hGl6iG3XztLrb9msBBk6+uHXoYQozfpjFsck/0mSWryAPPYzXSbPVGMopHvxPxQ51
         sdV5GgJgA9Az7I4ciBT6YXFRMfraH2vZz5dEWsWdOiFW7IhTLhB7MtUoZies6/Gudw4a
         6Ypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vR6QyTXKzjneeimQgI3lYac2uhU+48R8rf60k+wC+NM=;
        b=6HBwD0zjJpodHh+hSkJhTxfl52k50l4Yi1eI8iwY44TemLnjfjxwQp2deGlBZkk30M
         eUcbqY96LqZJ87qHLxphhQF5Ir4shKmRLALSSg85nWzS7cXuETvh1Mh+888pn/JvhY1Z
         wNVokUBUM759m5lXfti4nobLcwFVDu29AboFgb3xl14Jo7ekxTzvWKM44ulJKNVaN6ld
         EKRA5nuopOarQ2wvVvcnpEEefSDsbcyy42gP6ip8gmIGWUfKqdQfhvUTnaOSD5BpNUjY
         2Vk9nhDm6NIaXRBSgLemqVoJvCw2OA9TdrEg7oYWH1uHzmPxHCGRri3wXnYxsahu9yAt
         DxcQ==
X-Gm-Message-State: AOAM530Ij7cbL0W3wYy6sd6U/EHz2jItMDK1uAJG9bzyu8H0srGWp1x6
        VSds5LIe1Byfd6O9f9FnInRLCA==
X-Google-Smtp-Source: ABdhPJxy5Rbwg1eY20BNgqRD5xxDnNA3PThlSvyPpivCD2BUoRplRnX1hWPmo7UhMrbaXgw37YMxHA==
X-Received: by 2002:a50:baa8:0:b0:415:b0bc:6353 with SMTP id x37-20020a50baa8000000b00415b0bc6353mr13999510ede.220.1650800589299;
        Sun, 24 Apr 2022 04:43:09 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id o3-20020aa7c7c3000000b0042237eda622sm3189324eds.83.2022.04.24.04.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 04:43:08 -0700 (PDT)
Date:   Sun, 24 Apr 2022 19:43:02 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Ali Saidi <alisaidi@amazon.com>, kan.liang@linux.intel.com,
        Nick.Forrington@arm.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        benh@kernel.crashing.org, german.gomez@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v5 2/5] perf: Add SNOOP_PEER flag to perf mem data struct
Message-ID: <20220424114302.GB978927@leoy-ThinkPad-X240s>
References: <c17dedde-6ba8-db9b-4827-32477f039764@linux.intel.com>
 <20220422212249.22463-1-alisaidi@amazon.com>
 <20220423063805.GA559531@leoy-ThinkPad-X240s>
 <8e09af67-a416-4ead-b406-6c8b998de344@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e09af67-a416-4ead-b406-6c8b998de344@linux.intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Apr 23, 2022 at 05:53:28AM -0700, Andi Kleen wrote:
> 
> > Except SNOOPX_FWD means a no modified cache snooping, it also means it's
> > a cache conherency from *remote* socket.  This is quite different from we
> > define SNOOPX_PEER, which only snoop from peer CPU or clusters.
> > 
> > If no objection, I prefer we could keep the new snoop type SNOOPX_PEER,
> > this would be easier for us to distinguish the semantics and support the
> > statistics for SNOOPX_FWD and SNOOPX_PEER separately.
> > 
> > I overlooked the flag SNOOPX_FWD, thanks a lot for Kan's reminding.
> 
> Yes seems better to keep using a separate flag if they don't exactly match.
> 
> It's not that we're short on flags anyways.

Thanks for confirmation.

Leo
