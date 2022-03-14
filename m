Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A696C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Mar 2022 06:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbiCNGfM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Mar 2022 02:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiCNGfM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Mar 2022 02:35:12 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9315A1E3D3
        for <linux-perf-users@vger.kernel.org>; Sun, 13 Mar 2022 23:34:02 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id dr20so31315605ejc.6
        for <linux-perf-users@vger.kernel.org>; Sun, 13 Mar 2022 23:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tMMg4WQQYlz0uot7pHseP3erwI/+QvE1essU4518DNQ=;
        b=gHGaWW+9zdx2nMhyavqLvN3yhv++kdYLXpo/3qlRp6v9TA/jvXDcieX0V6rAEzmFD/
         sdHgZPbpv6nyznR1knnrJ16mS69yajty7YEc1k+MOOHTcVQen1AtRojdZJH3WJkadKKc
         eWDMjp6Z/FWIByWVEqyyBMMLs3uZmrnK2Q19fonFmY7S9MsBeQe+aIn+Mv9jKoaIoP9I
         /Bn8dm/L3ctnb/giKcVeZ38wBYMny4jhyARp0I9nTVs5AVcxoPsCGjRe+IqGenJV2GhG
         r+pL8nZg2klImb67nZDx5VE5K0qOaS+CKqIRv4NlODq0SL1YdcpzoIksjfdtSkwdqiCi
         THgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tMMg4WQQYlz0uot7pHseP3erwI/+QvE1essU4518DNQ=;
        b=QPFpFAJVLGeew+bu+nCWqkUU9RRbez/BXQl3H82hwc/vdYfmYRKsVAFcwwqwxdq4VK
         hsZ3ciSmMxoJ/SixJHOznNu/Zc3VbOVPpRcgFBMvBY1Ktn7VSAV4jQWvhhSzW6y077mf
         AMBuA1coJClQer29jbPvRPsf/Ux1nu+BcsBtq+VJZBZbAKUhBzsfg86UDeyZVsuMbIg3
         pvyGIEDk1lrNd3jYWj9pBCz+LxDsW84AUsZEYYXLHLV8BZ//R6BvVRb2LZ15fov7oUDf
         bg1eedWZpZW+yesOquO0tScHur0LqIYpandGTIfwc/I6aWSTucPw53xtvTwOA0z1Tz60
         9juQ==
X-Gm-Message-State: AOAM5309BjKBBJjYjFxuGk9gwJUuAJaQSr7scFZMvXX+tg7xW38LyW2E
        qQDJk7jQuj+g3rpONZjWSZ6GjQ==
X-Google-Smtp-Source: ABdhPJysJtjJNO/ccMll0pR1WCkbv7gByjW//bPYmXSPWvEeSpDddoRTUmHZzhqpZw9r3SuCmsPdrA==
X-Received: by 2002:a17:907:96a8:b0:6db:4c68:1393 with SMTP id hd40-20020a17090796a800b006db4c681393mr17226489ejc.87.1647239640969;
        Sun, 13 Mar 2022 23:34:00 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id e18-20020a50ec92000000b0041852b30c9esm4286696edr.27.2022.03.13.23.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 23:34:00 -0700 (PDT)
Date:   Mon, 14 Mar 2022 14:33:53 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ali Saidi <alisaidi@amazon.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        andrew.kilroy@arm.com, benh@kernel.crashing.org,
        german.gomez@arm.com, james.clark@arm.com, john.garry@huawei.com,
        jolsa@kernel.org, kjain@linux.ibm.com, lihuafei1@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org, yao.jin@linux.intel.com
Subject: Re: [PATCH v2 2/2] perf mem: Support HITM for when mem_lvl_num is
 used
Message-ID: <20220314063353.GB163961@leoy-ThinkPad-X240s>
References: <20220313124427.GB143848@leoy-ThinkPad-X240s>
 <20220313191933.26621-1-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220313191933.26621-1-alisaidi@amazon.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Mar 13, 2022 at 07:19:33PM +0000, Ali Saidi wrote:

[...]

> > > > +			if (lvl & P(LVL, L3) || lnum == P(LVLNUM, L4)) {
> > >
> > > According to a comment in the previous patch, using L4 is specific to Neoverse, right?
> > > 
> > > Maybe we need to distinguish the Neoverse case from the generic one here as well
> > > 
> > > if (is_neoverse)
> > > // treat L4 as llc
> > > else
> > > // treat L3 as llc
> > 
> > I personally think it's not good idea to distinguish platforms in the decoding code.
> 
> I agree here. The more we talk about this, the more I'm wondering if we're
> spending too much code solving a problem that doesn't exist. I know of no
> Neoverse systems that actually have 4 cache levels, they all actually have three
> even though it's technically possible to have four.  I have some doubts anyone
> will actually build four levels of cache and perhaps the most prudent path here
> is to assume only three levels (and adjust the previous patch) until someone 
> actually produces a system with four levels instead of a lot of code that is
> never actually exercised?

I am not right person to say L4 cache is not implemented in Neoverse
platforms; my guess for a "System cache" data source might be L3 or
L4 and it is a implementation dependent.  Maybe German or Arm mates
could confirm for this.

Thanks,
Leo
