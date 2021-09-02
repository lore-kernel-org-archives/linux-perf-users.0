Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54C9C432BE
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Sep 2021 07:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFF0E610C9
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Sep 2021 07:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbhIBHyp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Sep 2021 03:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243381AbhIBHyo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Sep 2021 03:54:44 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574EEC061575
        for <linux-perf-users@vger.kernel.org>; Thu,  2 Sep 2021 00:53:46 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id q21so664492plq.3
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Sep 2021 00:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eDuiHt7SLcgqmkUZhOUaA+olXXf4peHP9OkHl1MTPvg=;
        b=s6c04M6NRZCZcPXh3YvSESmn4z1oHNU/24ZkJgMlQV4ipttA+SnNmrWIhFTjn/LFO0
         KNtJ1k319VCxA9lpVrsYqvQnYp6ay/suJ9RgMq7RxdVmPgYLPN+N+CLsmOAJKsAalVH1
         SBjQWIIm4cR8cDU8G+O4walNw36ODnLz258YAdf6CcYz018ZNNGWS4owYBqIOYYZiiPI
         tgESFaftJD6Dk69XBIe+VO7OMO+6bqCp2S0teGjQz+JlqHfiOuWK/yHAH9Zqv+cCO7KI
         a4IxH6OZh/DaF5VH9trCR3cHEdA1EcexXOkPJLrynLO/SgjL7HnPbapgakp5DEkqcb22
         7AtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eDuiHt7SLcgqmkUZhOUaA+olXXf4peHP9OkHl1MTPvg=;
        b=PPBX24LzLKyKqLCTOEnbznDk57WhxEk3d5C+9DvtPBA20/At79u93+yqz0mL7lV5rT
         3Po7cYfqI/Jti4MIxjia01OlUiqaq3UQg7v0CVNeZ96KPAdEtfIDJKcIyorcLVmaiy1n
         lQCN4pLmahX5T3pk/5S32nbvwREhInhn8qzZCHItsVc+o7mVNtssBXj0nadKGvzHMC9E
         A11O9O3CnwBupi6NLxMn0csp3Wllnr3L39MwlDsGLd+DggBPyHiShcHlXS80SziWV7G8
         MtYrUswWL+eiI586g5Czk9mEUoYnnIZCQ0TCkQUySNFqH3Kt8eg2Z+K3iLF5cSaPvreX
         A3NA==
X-Gm-Message-State: AOAM530zpAk3ZxAKSiyddI2n5IZvYPbYbDiv6iVNZ6bmfTFuqXaK68kJ
        UVR07sBAJOVkpwQ0ENyqLjSG2w==
X-Google-Smtp-Source: ABdhPJzXA70pcOUanWDxO4McVVcGj57YamXwUCkc6FWYK1IRJ2V0Jyo5GvnKBXDGpAK9scy3psru4w==
X-Received: by 2002:a17:90a:bd90:: with SMTP id z16mr2428036pjr.70.1630569225837;
        Thu, 02 Sep 2021 00:53:45 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([213.173.35.225])
        by smtp.gmail.com with ESMTPSA id j2sm1238614pfe.201.2021.09.02.00.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 00:53:45 -0700 (PDT)
Date:   Thu, 2 Sep 2021 15:53:39 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     James Clark <james.clark@arm.com>, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
        mike.leach@linaro.org, suzuki.poulose@arm.com,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 9/9] perf cs-etm: Show a warning for an unknown magic
 number
Message-ID: <20210902075339.GD303522@leoy-ThinkPad-X240s>
References: <20210806134109.1182235-1-james.clark@arm.com>
 <20210806134109.1182235-10-james.clark@arm.com>
 <20210824083615.GF204566@leoy-ThinkPad-X240s>
 <YS+iOrcPTzQfmbqU@kernel.org>
 <YS+lTXyuC+9VTrxd@kernel.org>
 <YS+neCZler56Hs2D@kernel.org>
 <YS+pgZMpFmnRlMuT@kernel.org>
 <YS+vL2SYCCVLAXVp@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS+vL2SYCCVLAXVp@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

On Wed, Sep 01, 2021 at 01:49:51PM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> This doesn't explain that 'make -C tools/perf build-test' error, perhaps
> it is reusing the feature dump (feature detection), done without
> CORESIGHT=1, when building with CORESIGHT=1 :-\
> 
> Anyway, please consider making the build fail when CORESIGHT=1 is passed
> explicitely and that tools/build/feature-libopencsd.c feature test fails
> instead of silently building the tool _without_ the explicitely asked
> for feature.

Sorry for inconvenience.

I have sent a patch to allow the build to report error when detect feature
failure for libopencsd [1].

It's obviously that there have another issue with 'make -C tools/perf
build-test' which should not build with option 'CORESIGHT=1' by
default.  Please let me know if you want me to follow this issue or not.

Thanks,
Leo

[1] https://lists.linaro.org/pipermail/coresight/2021-September/006967.html
    p.s. I didn't use the patch linkage from lore.kernel.org, seems
    the server is down when I try to fetch link from it.
