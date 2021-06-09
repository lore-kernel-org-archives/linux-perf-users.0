Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83384C47095
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Jun 2021 08:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F2CA61182
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Jun 2021 08:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237752AbhFIJAn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 9 Jun 2021 05:00:43 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:44544 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235888AbhFIJAn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Jun 2021 05:00:43 -0400
Received: by mail-pj1-f50.google.com with SMTP id h12-20020a17090aa88cb029016400fd8ad8so981470pjq.3
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Jun 2021 01:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bVQYTBu0a1Kk4T/+mZeiDj1CUGFrrISY4m2gx4+3p0Y=;
        b=zWLJH9Fpk2rU9on5mQyq6ez7pr8woPsp5xGdYeyxyqpKOW2MwbTx4zpipsZguP8C6e
         kgFol/kYXEtXr4ttFEbd0C22l2C7sTjBwEd+8FLsdNT4nXo+SpkE287hmWSlSD6ftAjB
         YcMEBtfMFEpbWUleniM808BgHP1nB+j4s6C/O8xVMHRurEliFkPO19Xnwq2DXDzg0bIt
         gGy08AN7CX3X26DCPHsS1T168Jx76nSwuNQnxCx0o0xXzRryzrqZCIYBcGcFYqI9O8fZ
         +66QZf6f1YX0qtOZOWP1LHUIT900FJGKwrzKf9O+oCJTeVhs65gvjcmw1IqWtEg5YGz4
         YGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bVQYTBu0a1Kk4T/+mZeiDj1CUGFrrISY4m2gx4+3p0Y=;
        b=mEaQMvOlKnYAe3DuCwmFDJloAVz1noSjbNa0r8sFatYory0n0bH8yxsaGlWZx/Crmp
         smVIcwif0ToCbVLsGLlSGS2VhZgZtsSkglt/ZTVXFtYZW42AFP0pN8/3dK216NACB6Yf
         UfRcfLnprtc/pcLq/e4zCfQ38YZv0Si6imL7U/FL169tChSKjOF1KvqOvw4+IZfnmtHq
         F48eboujcjnlkz8awhwEQVXIMkiTJJSo8UMTZrcjznktuymje1xcBY76DlLvrO+qIlce
         taEhAT4N+dOBUaQeDttdUu5+XaCb2bfH+6wuz5rUfjhYOPaoQQt8G21ZO4TzDHe8w3e2
         4fNw==
X-Gm-Message-State: AOAM531An5qKGQ8UJolbmxl6AOy0RT+QguXQ57O2BUrsWRyWNag7xcMV
        Y0dAjbKFuT7s0CBhOxPyGxD9eA==
X-Google-Smtp-Source: ABdhPJzPFkcMwOFYo5oqKyhE4y8nEnWIB/h6N4itRbJrqLCe+yXMoko7eVGUr2PWg4oJur4fbapZ3A==
X-Received: by 2002:a17:90a:f304:: with SMTP id ca4mr32399766pjb.177.1623229068832;
        Wed, 09 Jun 2021 01:57:48 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id t1sm12394038pfe.61.2021.06.09.01.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 01:57:48 -0700 (PDT)
Date:   Wed, 9 Jun 2021 16:57:41 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 8/8] perf record: Directly bail out for compat case
Message-ID: <20210609085741.GF4640@leoy-ThinkPad-X240s>
References: <20210602103007.184993-1-leo.yan@linaro.org>
 <20210602103007.184993-9-leo.yan@linaro.org>
 <c321e998-6fd2-86e9-7876-7250a9b23c25@intel.com>
 <20210602123847.GE10272@leoy-ThinkPad-X240s>
 <96e5fac6-17a2-ea03-9b15-338b84321ecf@intel.com>
 <20210607150903.GC1071897@leoy-ThinkPad-X240s>
 <d87d8fd8-c6f1-9d9b-5c2e-629588123a9c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d87d8fd8-c6f1-9d9b-5c2e-629588123a9c@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Adrian,

On Wed, Jun 09, 2021 at 11:23:25AM +0300, Adrian Hunter wrote:

[...]

> >> I was thinking we would separate out the compat case:
> >>
> >> #if BITS_PER_LONG == 32
> >> 	if (kernel_is_64_bit)
> >> 		return compat_auxtrace_mmap__[read_head/write_tail]()
> >> #endif
> >>
> >> So the non-compat cases would not be affected.
> > 
> > Because I don't want to introduce the complexity for read/write head
> > and tail, and we also need to handle the same issue for the perf ring
> > buffer.  So how about below change?
> > 
> > The main idea for below change is it allows the perf to run normally
> > on the compat mode and exitly if detects the buffer head is close to
> > the low 32-bit's overflow: when detect the low 32-bit value is bigger
> > than 0xf0000000 (so we have 256MiB margin to the overflow), it reports
> > error and exit.
> > 
> > diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> > index 1b4091a3b508..2a9965bfeab4 100644
> > --- a/tools/perf/util/auxtrace.c
> > +++ b/tools/perf/util/auxtrace.c
> > @@ -1693,6 +1693,14 @@ static int __auxtrace_mmap__read(struct mmap *map,
> >  	pr_debug3("auxtrace idx %d old %#"PRIx64" head %#"PRIx64" diff %#"PRIx64"\n",
> >  		  mm->idx, old, head, head - old);
> >  
> > +#ifdef BITS_PER_LONG == 32
> > +	if (kernel_is_64bit() && head >= 0xf0000000) {
> 
> You are assuming the head never increases by more than 256MiB which
> means you should limit the buffer size to 256MiB maximum.
> 
> To me this seems a bit too far from an ideal solution.
> 
> I would have thought separating out the compat case makes things
> simpler to understand.

Agreed.  I will follow up the suggestions to add compat variants for
accessing AUX head and tail, and will distinguish compat case with
global env variable for 64-bit kernel.

After get ready, will send out for review. Thanks a lot for suggestions!

Leo
