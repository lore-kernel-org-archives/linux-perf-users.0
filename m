Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB48C47083
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Jun 2021 12:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E02A3613D3
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Jun 2021 12:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhFBMki (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 2 Jun 2021 08:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhFBMki (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 2 Jun 2021 08:40:38 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AA1C061574
        for <linux-perf-users@vger.kernel.org>; Wed,  2 Jun 2021 05:38:55 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id n12so2093826pgs.13
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Jun 2021 05:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tkfGbFk7RbowFQb2pdJ2DiNSH2Hl1PMpHr94hmyAtqs=;
        b=lxTZN5WbWFKLKZay+tdzygwECcBcBFtb83iQAMQ8lte/ef8eggQE+S6BXoanfnJ/4I
         dEl0mlNV6UDIdqkQHC32HZwJ89hL6aWyh2WgB3pOoIe9D/z8kfIjRpvSZIH8pmiPlNGS
         IpFZWdj+7gWvUjS9SyFwBbBo8H1aSB76NwmjvgtpvFHQToHJ+Kuddzdd+0tm+VMTcgg5
         7H7ew14q/bvkc2Lod182B23azGQ9B9P9FlPuvJk8Dzix8zksKnZ+vJGK2e0WeuzXv25I
         UkIy8wL7PVXNQ9j6HkPq9Undf92t2TZKM4M2WVAfzXaMeScb3NFjSK/mH/UmRz9bdIUs
         v5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tkfGbFk7RbowFQb2pdJ2DiNSH2Hl1PMpHr94hmyAtqs=;
        b=W28dK9PY5XYtFqy/XKYoweIiCtDm1gGRWUwBQaO25Mo0U9LU0KuweesQA9YU5slLpY
         42oKfICxHjezHCq1iketqFavvZEioVXfx25SyrNRzW64sg+y6NhMJyR/b6iijSOUgUUi
         soUXM2l5OSiU+XgIAXbkE7/lHHvgLJl3gOFn5F9bLLIKCjQLK+5WyomQPU7Ma2C5u4+t
         8thNrjVgTgIknoU/1E2PcMfYnpISDbO9/6v5+aDAtQzP7fmpbKTmSGUEMZq3YUzr3tWK
         +yFRXePoDnVmZ59EaWbEkyd9XqzHmCf6txVFsSevW13qzWeneU6kkE4XlGJAPU1e4b5E
         ry7w==
X-Gm-Message-State: AOAM530PmtpW+4MwpqPEI9cW91M97pPEm+fzhI9HsepqHjU67v0TX3yZ
        LefmG0NGnDOgDKgvHG1q3Y6X1w==
X-Google-Smtp-Source: ABdhPJwZLYHDPPn1a+5bpf3u9GEz+y0iz9ZUQ2qJzz1MLRRwbyl6UAlRYCEn1EZr8YCrCxvzgqY3OA==
X-Received: by 2002:a63:5c5d:: with SMTP id n29mr33235732pgm.131.1622637534524;
        Wed, 02 Jun 2021 05:38:54 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id m2sm17340941pgu.85.2021.06.02.05.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 05:38:53 -0700 (PDT)
Date:   Wed, 2 Jun 2021 20:38:47 +0800
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
Message-ID: <20210602123847.GE10272@leoy-ThinkPad-X240s>
References: <20210602103007.184993-1-leo.yan@linaro.org>
 <20210602103007.184993-9-leo.yan@linaro.org>
 <c321e998-6fd2-86e9-7876-7250a9b23c25@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c321e998-6fd2-86e9-7876-7250a9b23c25@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Adrain,

On Wed, Jun 02, 2021 at 02:18:47PM +0300, Adrian Hunter wrote:
> On 2/06/21 1:30 pm, Leo Yan wrote:
> > Since the 64-bit atomicity is not promised in 32-bit perf, directly
> > report the error and bail out for this case.
> > 
> > Now only applies on x86_64 and Arm64 platforms.
> > 
> > Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Maybe we can do better for the compat case.
> 
> We can assume the upper 32-bits change very seldom,
> and always increase. So for the 'read' case:
> 
> 	u64 first, second, last;
> 	u64 mask = (u64)((u32)-1) << 32;
> 
> 	do {
> 		first = READ_ONCE(pc->aux_head);
> 		rmb();
> 		second = READ_ONCE(pc->aux_head);
> 		rmb();
> 		last = READ_ONCE(pc->aux_head);
> 	} while ((first & mask) != (last & mask));
> 	return second;
> 
> For the write case, we can cause a fatal error only if the new
> tail has non-zero upper 32-bits.  That gives up to 4GiB of data
> before aborting:
> 
> 	if (tail & mask)
> 		return -1;
> 	smp_mb();
> 	WRITE_ONCE(pc->aux_tail, tail);

Seems to me, it's pointless to only support aux_head for 64-bit and
support aux_tail for 32-bit.  I understand this can be helpful for the
snapshot mode which only uses aux_head, but it still fails to support
the normal case for AUX ring buffer using 64-bit head/tail.

Thanks,
Leo
