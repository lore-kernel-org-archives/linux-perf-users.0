Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC02C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 27 May 2022 06:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241854AbiE0Gib (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 27 May 2022 02:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiE0Gib (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 27 May 2022 02:38:31 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F24E277A
        for <linux-perf-users@vger.kernel.org>; Thu, 26 May 2022 23:38:27 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id x12so3165332pgj.7
        for <linux-perf-users@vger.kernel.org>; Thu, 26 May 2022 23:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xNO87R/X/d1Qe/nRsB/dim8tX8ZL4WufoTOu5cyuOLU=;
        b=lJ/mfvsOzOUWYJ9ZynEattJvk88vSDphJsOwWXz8R7g+nzXguFfbpxWv6Tl06d51zS
         kAlRbiWt3fqTRRpiJ3G7JVeqoNxshv+DmCOn0K3yiJr9J2EolwUgwXkS8fINllRLK6HV
         sEffYKJqVt8U8n+pR0D79bVj6+iI2p49adtutzTOH7wXXSJ5ni7Puqa2I214KRnTwBrn
         ewi9al7E59ARfQ8OxRqZFU4wzWil0apn2g5SLwi8F8kewa795cNfsqa8zbYL33LqV9Z7
         mP6DLFIye3xLzdWXT4Q3A4WSFZUkeJKGsQz2rUTdO1dUM2hSZjd4MYibPEt4d3Aa7ZaT
         XlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xNO87R/X/d1Qe/nRsB/dim8tX8ZL4WufoTOu5cyuOLU=;
        b=Mk9grUwRdxtyDJsSCUHPyCe7tw+sHmjo+C/Nudzt4cjwWsyJPXZ+7TCDImu535Bejk
         y65LU8oP+gPm1zIYm/6XIRyDllk7BeI+nDDNtncKKFkw+l7UK0pW4witlijPCc4DcEYp
         zrkShW+2Ol5yiawAK4+Hy0JY7UzCU7TOk5LxEoRSoKwvJw2daMKvob/vW/4ex0MtFDrk
         dL/SD0F7Fq0qJeC74JVjiPgQr5GgJ4DHXLTrnOB2BpTh7TFxGfOXEpyZ0MpqCEgjFnEE
         vXSJngcdS1M/V/Sk2KQ4s6KqiqsPVhnOk3qnGB9/yEXhjUUq/wo+NexOz0QtZCOXHCyJ
         a/Rg==
X-Gm-Message-State: AOAM5333cPMzh0wRPF7c2KBg3ylMlZ2PYCkaOQ+ddo2TnK7lZ2bdzdzC
        f//JtJxNOS+kXE72JpRJ+0/lBw==
X-Google-Smtp-Source: ABdhPJzJ39IUYHF1G2Lbp7RevnHGuQ+O/gkk+bzGl2T9fQVkWQAAiD1mbZS/i6n2eNKPfygDXKAbwA==
X-Received: by 2002:a63:2bd8:0:b0:3fa:faf9:e6d5 with SMTP id r207-20020a632bd8000000b003fafaf9e6d5mr7845959pgr.247.1653633506414;
        Thu, 26 May 2022 23:38:26 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (n058152048195.netvigator.com. [58.152.48.195])
        by smtp.gmail.com with ESMTPSA id s187-20020a625ec4000000b0050dc7628155sm2632585pfb.47.2022.05.26.23.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 23:38:26 -0700 (PDT)
Date:   Fri, 27 May 2022 14:38:21 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     German Gomez <german.gomez@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf test arm-spe: Check if perf-record hangs when
 recording workload with forks
Message-ID: <20220527063821.GB829807@leoy-ThinkPad-X240s>
References: <20220228165655.3920-1-german.gomez@arm.com>
 <95ede14c-8dc2-d285-9f5b-8d6ee6797f00@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95ede14c-8dc2-d285-9f5b-8d6ee6797f00@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, May 13, 2022 at 02:03:52PM +0100, James Clark wrote:
> 
> 
> On 28/02/2022 16:56, German Gomez wrote:
> > Add shell test to check if perf-record hangs when recording an arm_spe
> > event with forks.
> > 
> > The test FAILS if the Kernel is not patched with Commit 961c391217 ("perf:
> > Always wake the parent event").
> > 
> > Unpatched Kernel:
> > 
> >   $ perf test -v 90
> >   90: Check Arm SPE doesn't hang when there are forks
> >   --- start ---
> >   test child forked, pid 14232
> >   Recording workload with fork
> >   Log lines = 90 /tmp/__perf_test.stderr.0Nu0U
> >   Log lines after 1 second = 90 /tmp/__perf_test.stderr.0Nu0U
> >   SPE hang test: FAIL
> >   test child finished with -1
> >   ---- end ----
> >   Check Arm SPE trace data in workload with forks: FAILED!
> > 
> > Patched Kernel:
> > 
> >   $ perf test -v 90
> >   90: Check Arm SPE doesn't hang when there are forks
> >   --- start ---
> >   test child forked, pid 2930
> >   Compiling test program...
> >   Recording workload...
> >   Log lines = 478 /tmp/__perf_test.log.026AI
> >   Log lines after 1 second = 557 /tmp/__perf_test.log.026AI
> >   SPE hang test: PASS
> >   Cleaning up files...
> >   test child finished with 0
> >   ---- end ----
> >   Check Arm SPE trace data in workload with forks: Ok
> > 
> > Signed-off-by: German Gomez <german.gomez@arm.com>
> 
> Reviewed-by: James Clark <james.clark@arm.com>

Thanks for review and popping up this patch, James.  LGTM:

Reviewed-by: Leo Yan <leo.yan@linaro.org>
