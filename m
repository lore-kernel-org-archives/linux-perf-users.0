Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454CDC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri,  3 Jun 2022 03:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbiFCDqj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Jun 2022 23:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiFCDqi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Jun 2022 23:46:38 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0A93701A
        for <linux-perf-users@vger.kernel.org>; Thu,  2 Jun 2022 20:46:36 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id z17so6292046pff.7
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Jun 2022 20:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XwoY0X65ErGegBJPGHjN6OI94flPB7b8Qeyfzlqg8dg=;
        b=JyIrNSNEFRGPi8vjynDMfC852xoXp9o1wH0G6pelCnsc8huy5jz/wYGptktPjbc69u
         3iOl8AiTRPOm8xSKk1HG7YAcToPily7UbJt+gSbz+MW1Q/qVRFD/KotFiKI8Wc+5Ausn
         BqhNep0+rO1Bq/6IrmQgP2s0mwilYP0TZQOGgGGKcqiEPi6rj8YwNad8bf88NMYY+Hqb
         zyxqmEHvJ6UgzeeZ1LlQJRpp+uBwGTEkmo3QkgfvqeVmQNszzQzIqxl4I2K47h1j+xUL
         zLEzPqTktXxHjZDbOXtnBvWADXAkELtyFvO+52K9VL9ONo+FrTSuLWFLnsnCPWaEFoo4
         coIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XwoY0X65ErGegBJPGHjN6OI94flPB7b8Qeyfzlqg8dg=;
        b=OcvqrhtA8Q5x07I3WNiGs4Yq4dUKsykY3MWTY21SaMaJqb+ALXVKm5EoysWJtfzIvl
         6PnGxPcHnEDp8IKIeV72g2Z8NGhwpz4VsvNoaCn0ejISx2NPdGxMEBGzO/rEw74vywga
         GDEKJ41Bjn1a9NMmwWwF+RNWBAqiw6AZ1EDyVNPLJdc4J3VZ3GwCO41FvXqVGCWCPkXp
         wxJOjj0gPW+VcOlrFidWBBBRxzOWp1ytzx0GK549BwDBL9zyC+Pxu9220ivwK3fwdEI2
         +bzGx5Uv7EQXHRqK1VuGE8uWCNPOQwEj4ejOrPd4WhwAnIr1Gn7zRhkxNkiIqOjixfMX
         ZnWg==
X-Gm-Message-State: AOAM530NjUG+wG7eOI5tLN/pq0tIbxq+c1576HSymYZE9L5e1d7GHDsV
        yXLkNScj3fib260R7RKXbKEIaQ==
X-Google-Smtp-Source: ABdhPJxK8GGATroKcLec9/S2CEAkzNR0b5Lt2Lp//hkRe8j0T0uhFRdlDQH6KMqrenkO/go0Mo0SzQ==
X-Received: by 2002:a63:d446:0:b0:3fc:1370:798a with SMTP id i6-20020a63d446000000b003fc1370798amr7285682pgj.190.1654227995356;
        Thu, 02 Jun 2022 20:46:35 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-54-67-95-58.us-west-1.compute.amazonaws.com. [54.67.95.58])
        by smtp.gmail.com with ESMTPSA id w24-20020a1709027b9800b00163d4c3ffabsm4231067pll.304.2022.06.02.20.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 20:46:34 -0700 (PDT)
Date:   Fri, 3 Jun 2022 11:46:27 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ali Saidi <alisaidi@amazon.com>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, hi@alyssa.is,
        irogers@google.com, likexu@tencent.com, kjain@linux.ibm.com,
        lihuafei1@huawei.com, adam.li@amperecomputing.com,
        german.gomez@arm.com, james.clark@arm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/12] perf c2c: Support display for Arm64
Message-ID: <20220603034627.GB41034@leoy-ThinkPad-X240s>
References: <20220601102505.GA408721@leoy-ThinkPad-X240s>
 <20220602171120.31166-1-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602171120.31166-1-alisaidi@amazon.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 02, 2022 at 05:11:20PM +0000, Ali Saidi wrote:

[...]

> > You are welcome!  And very appreicate your helping to mature the code.
> 
> Seconding that, thanks for progressing this so much Leo. 

You are very welcome, Ali!

> > > I'll assume someone else is reviewing your code changes.
> > 
> > Yeah, let's give a bit more time for reviewing.
> 
> I've tested and given each patch a close look. I haven't found anything that
> looks to change other architectures and the output on my Graviton systems looks
> great. I pulled in your patch to add physical addresses to the spe records and
> as expected I saw the Node properly populated and PA cnt is no longer zero.  One
> nit is the documentation still says that "Total HITMs (tot) as default," while
> the code now defaults to "peer" on arm64.  Other than that:
> 
> Tested-by: Ali Saidi <alisaidi@amazon.com>
> Reviewed-by: Ali Saidi <alisaidi@amazon.com>

Thanks a lot for the testing.  Will respin a new patch set for
correcting the documentation:

  "Total HITMs (tot) as default, except Arm64 uses peer mode as default".

And will add your test and review tags.

Thanks,
Leo
