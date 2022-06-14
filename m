Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493E1C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Jun 2022 13:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244166AbiFNNRK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 14 Jun 2022 09:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237111AbiFNNRJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Jun 2022 09:17:09 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375E3369FA
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jun 2022 06:17:09 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 3-20020a17090a174300b001e426a02ac5so11755319pjm.2
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jun 2022 06:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MMo5ycw9fsXGBtd6u4S+9VnthcYrmxBhfzklb6NM/k4=;
        b=Du9R7H8xGzbITqGJTl+aBcrqT6mzGQJAvIVPDEh2EYjJgHNQBMYW7DUbWXJaRNLlDP
         K0ueW6CO6u65oXc0Ba1stiI6o7SrHhX2yERVWUXCMd3i6/N+NDffQuv28zEL3es9h+aF
         HF4B6lTUhXt4I4aA86ZDwd5fKE9KLOlEICbclOiweY3QI40s3Jtu3XocChbUJvxPSbZi
         UtLCezLwOWtbz9rTHK+N98W00/HGjfCMbMkeN17sPGWWxLcJpth8Iae1tQ1Mx+FZjHVE
         9uOJf89U80ryMDq3WjbPU3mLhSKnVsxifwrE0yy9H6y8K4BPaGITSIU+ylfRiKFGa7ZW
         heYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MMo5ycw9fsXGBtd6u4S+9VnthcYrmxBhfzklb6NM/k4=;
        b=bGOzzlx2G/XexdtoGQ7ApUkloxxYcBA+8Y+l+QoZ2/R86JurnPhWjJvvutFxDHC9na
         MzioBePakhC622EQ++qCg3w19yWpip+KA8K5zCGP/AuVxE9mBvc1BcbV+UajoAeJxI4W
         E28NV9kmeMBMSGky9s8BIXJI3WBJmDm5ldzbfcIKr0CV4TYUT+X3TNoxF39dAipFOub7
         v9VMaZYCs5iPU/OuRkvihrucF9pC5bA/rW/+x+gYPIyTlpxkcAr9aBaZbah0OrGdi1EW
         8jw8SKLVIR/IFb3QwD9akp/cyH5jlO2Ey841tRdNI0cwU6fpuI02xaAGYAez9rxzfscy
         rJzg==
X-Gm-Message-State: AJIora8CjKycdXNGx8gQ6C+m0hikxfqBUSTGx7delu+m2We3qoz29yFv
        Fs/K1wz+/Kdu52dg9dW7WxQZyw==
X-Google-Smtp-Source: AGRyM1t1mOOIzLWMWUljDNJNTCBWrTSZsjvdQJ7sE1b2JDr2SDhIvv5RgELudLWBUtAK4sMee9o+ag==
X-Received: by 2002:a17:90a:408f:b0:1d1:d1ba:2abb with SMTP id l15-20020a17090a408f00b001d1d1ba2abbmr4552403pjg.152.1655212628560;
        Tue, 14 Jun 2022 06:17:08 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id h65-20020a62de44000000b0050dc762813csm7603863pfg.22.2022.06.14.06.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 06:17:08 -0700 (PDT)
Date:   Tue, 14 Jun 2022 21:17:04 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com,
        jolsa@kernel.org, german.gomez@arm.com
Subject: Re: [PATCH] perf test: Record only user callchains
Message-ID: <20220614131704.GA237086@leoy-ThinkPad-X240s>
References: <20220614105207.26223-1-mpetlan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614105207.26223-1-mpetlan@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jun 14, 2022 at 12:52:07PM +0200, Michael Petlan wrote:
> The testcase 'Check Arm64 callgraphs are complete in fp mode' wants to
> see the following output:
> 
>     610 leaf
>     62f parent
>     648 main
> 
> However, without excluding user callchains, the output might look like:
> 	ffffc2ff40ef1b5c arch_local_irq_enable
> 	ffffc2ff419d032c __schedule
> 	ffffc2ff419d06c0 schedule
> 	ffffc2ff40e4da30 do_notify_resume
> 	ffffc2ff40e421b0 work_pending
> 	             610 leaf
> 	             62f parent
> 	             648 main
> 
> Adding '--user-callchains' leaves only the wanted symbols in the chain.
> 
> Suggested-by: German Gomez <german.gomez@arm.com>
> Tested-by: Michael Petlan <mpetlan@redhat.com>

Since you are the patch's author, it's not necessary to add your
tested tag.

> Signed-off-by: Michael Petlan <mpetlan@redhat.com>

With addressing German's comment for "excluding kernel callchains":

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  tools/perf/tests/shell/test_arm_callgraph_fp.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/test_arm_callgraph_fp.sh b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> index 6ffbb27afaba..ec108d45d3c6 100755
> --- a/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> +++ b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> @@ -43,7 +43,7 @@ CFLAGS="-g -O0 -fno-inline -fno-omit-frame-pointer"
>  cc $CFLAGS $TEST_PROGRAM_SOURCE -o $TEST_PROGRAM || exit 1
>  
>  # Add a 1 second delay to skip samples that are not in the leaf() function
> -perf record -o $PERF_DATA --call-graph fp -e cycles//u -D 1000 -- $TEST_PROGRAM 2> /dev/null &
> +perf record -o $PERF_DATA --call-graph fp -e cycles//u -D 1000 --user-callchains -- $TEST_PROGRAM 2> /dev/null &
>  PID=$!
>  
>  echo " + Recording (PID=$PID)..."
> -- 
> 2.18.4
> 
