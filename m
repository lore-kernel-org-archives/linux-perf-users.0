Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C793CC433FE
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Oct 2022 14:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiJFOtn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 Oct 2022 10:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiJFOtU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Oct 2022 10:49:20 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEA0B40E0
        for <linux-perf-users@vger.kernel.org>; Thu,  6 Oct 2022 07:48:49 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id h13so817267pfr.7
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Oct 2022 07:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=tRKC/oAPBVTHlB7GQZJdKnIj+0+vIbganKIV495EK3s=;
        b=EecofMjkbQ5VhheJ+QRBRj7krV9TCOeI6TkhjEl/zntgvx0LqJilN1EgmAjEfFQaHl
         PKyDe+abphT1acrqGFlROjdmFeLCQ1g/Gm0HpqP56oBaMHLO4oWFef0CjR9jOKfr0w0J
         17OMX6lNQm6WlpfevaSADbY3hZVMZuSmEKQFkIAfDsbLl0pzAXF7GwRAYSW/6OrhYXUq
         mSQQzrB/d0RGDvtgILmnmHxb8cGp/vh2BU2+yN75BkE1hvRZEBcScpidzYhtH8qmM+Tq
         PAUoD3M0BuRKe1YaudbTVC592kA60KIWcSUUp5xDUmC1/uilc6X3tnNNF80t3e6IT00b
         LBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=tRKC/oAPBVTHlB7GQZJdKnIj+0+vIbganKIV495EK3s=;
        b=M5GcVqdv9Ki0mG9m9HQ+L5/IJFKfbZqYEwEIeRqikfAdxlYF0SP4qggQO5faTjqh9M
         a1prbaZP/sbKKd4VO5LWHKFU/BKW2TzZlL3UoAexoJVDgilER9TzUvNgenjiGBjnJHY+
         hlIsF94s9p98WVmYLb0e6hKpxe8CWP8aHaWDegSZgh5ghmv/R4KnZBIkP8L7YOOpe69o
         5360+cTT14UriUwebXa3PAX7fR8lzYMJ6+axU/6SnTNRwFQjWli0IvHQokd05YJvNX7H
         b7Z1Wrl65G1aEd/RqViNlddwOGuRGL3ntAy0q1+XjtGo5b+krQ5gXyrB//y30YLR7g8S
         yuDA==
X-Gm-Message-State: ACrzQf2zAF39zi8vX4trR5fm4p25rdkh6wRGVYOqm1qzVFCmFuoLfsut
        Sj6WBz2oNLsBR53GP4gv1xXmMg==
X-Google-Smtp-Source: AMsMyM6zsOpfmlT9czs+6yVwvcK4Okop9Ne5C/iAA0uOmk7ict4k8O8NiNsWp+UGciNkJjmySdJX3w==
X-Received: by 2002:a63:1141:0:b0:454:ae43:14e7 with SMTP id 1-20020a631141000000b00454ae4314e7mr204004pgr.527.1665067729266;
        Thu, 06 Oct 2022 07:48:49 -0700 (PDT)
Received: from leoy-yangtze.lan (211-75-219-202.hinet-ip.hinet.net. [211.75.219.202])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902ea1200b0017d404403b7sm10609923plg.259.2022.10.06.07.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:48:48 -0700 (PDT)
Date:   Thu, 6 Oct 2022 22:48:39 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, acme@kernel.org,
        suzuki.poulose@arm.com, linux-perf-users@vger.kernel.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test: Fix test_arm_coresight.sh failures on Juno
Message-ID: <Yz7qx+4BxNYOCgvL@leoy-yangtze.lan>
References: <20221005140508.1537277-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005140508.1537277-1-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi James,

On Wed, Oct 05, 2022 at 03:05:08PM +0100, James Clark wrote:
> This test commonly fails on Arm Juno because the instruction interval
> is large enough to miss generating any samples for Perf in system-wide
> mode.
>
> Fix this by lowering the interval until a comfortable number of Perf
> instructions are generated. The test is still quick to run because only
> a small amount of trace is gathered.
> 
> Before:
> 
>   sudo ./perf test coresight -vvv
>   ...
>   Recording trace with system wide mode
>   Looking at perf.data file for dumping branch samples:
>   Looking at perf.data file for reporting branch samples:
>   Looking at perf.data file for instruction samples:
>   CoreSight system wide testing: FAIL
>   ...
> 
> After:
> 
>   sudo ./perf test coresight -vvv
>   ...
>   Recording trace with system wide mode
>   Looking at perf.data file for dumping branch samples:
>   Looking at perf.data file for reporting branch samples:
>   Looking at perf.data file for instruction samples:
>   CoreSight system wide testing: PASS
>   ...

Since Arm Juno board has zero timestamp for CoreSight, I don't think
now arm_cs_etm.sh can really work on it.

If we want to pass the test on Juno board, we need to add option
"--itrace=Zi1000i" for "perf report" and "perf script"; but seems
to me "--itrace=Z..." is not a general case for testing ...

> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/tests/shell/test_arm_coresight.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
> index e4cb4f1806ff..daad786cf48d 100755
> --- a/tools/perf/tests/shell/test_arm_coresight.sh
> +++ b/tools/perf/tests/shell/test_arm_coresight.sh
> @@ -70,7 +70,7 @@ perf_report_instruction_samples() {
>  	#   68.12%  touch    libc-2.27.so   [.] _dl_addr
>  	#    5.80%  touch    libc-2.27.so   [.] getenv
>  	#    4.35%  touch    ld-2.27.so     [.] _dl_fixup
> -	perf report --itrace=i1000i --stdio -i ${perfdata} 2>&1 | \
> +	perf report --itrace=i20i --stdio -i ${perfdata} 2>&1 | \
>  		egrep " +[0-9]+\.[0-9]+% +$1" > /dev/null 2>&1

So here I am suspect that changing to "--itrace=i20i" can allow the test
to pass on Juno board.  Could you confirm for this?

Thanks,
Leo
