Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B78C43611
	for <linux-perf-users@archiver.kernel.org>; Wed, 12 May 2021 16:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3738E611AC
	for <linux-perf-users@archiver.kernel.org>; Wed, 12 May 2021 16:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237673AbhELQi4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 12 May 2021 12:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239320AbhELQHv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 12 May 2021 12:07:51 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0EAC03542E
        for <linux-perf-users@vger.kernel.org>; Wed, 12 May 2021 08:37:22 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id s22so18441327pgk.6
        for <linux-perf-users@vger.kernel.org>; Wed, 12 May 2021 08:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LkdhH7+c0e5NenvwnpF1EhNTDLZfHKCyQtBoZSCgUv8=;
        b=xnvFRFE5P1SW4ArsaTq+9WNn2bn2wGD9xTssrTIMjyiBm+C2ERsRYlf2SnIFZG+k8K
         Tj1ckCqdvlHIpsfu+BVfIMg02Iy+0ZnfOCfxdi/OwXiR6d4d50UB1022V1tT/hRO3Cr6
         /LMiSeisBQ4e1rjGTr+7nQwuifQFPSi1ttJ8wyzlj3Ccwc6GD6q1CpgWo8Cqt9dTsKPb
         YGXkd3FXSp6uSc1HqkQLZPCJDJjDajT1zYbxISEAW+InbE2gJLw8ehZMfSJCHziE91iW
         7DeqcYp+A9DJG0vs0Zw/8ELzTDnaxJAIv9M2ucyBMvJxwUOBtsy1p/rWffBRuVMzdP2O
         PGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LkdhH7+c0e5NenvwnpF1EhNTDLZfHKCyQtBoZSCgUv8=;
        b=TlSk4hSLfMP14nPtAUE5DFCIwCHlndYIqW5pLYqxM6k/qe07YuJUjJ2J6W92grgGNs
         Mq3pQt+UvnCx6ngJPSAfSiArFw7EVibaU5QEe3+2+tsgpSOkM5ILd5Hp8d+S+3w84qMq
         HHnWDaYJYZ6ACys3faqZhiMXtlCIdnWEId839uQiqoqimbD5C8841yz63FLVQ1xO8D2Y
         7mFmkYtP3uZwKT0CqCYWUxKqhpq9jpxwoUR0MhbZumIHiwT+HAFXFbYWauPsK35zwuUK
         JSbjcNoISYzUNe60EefCWQ+0H/sIm1ME9WqJIy5nk+3MyGAArVXOkC2PGM5FWm3JOqYC
         PhbA==
X-Gm-Message-State: AOAM530M0G4iEpRVNz4+HG9nFGc0pxSs4aOXcCfvOENHZmyuUy8jqwp1
        7s3z9XV3i9jpHRLz0D8k6Y6i0Q==
X-Google-Smtp-Source: ABdhPJzvw/VDOYAkw+NRfNrYJKyNkre0LOhS6gsLFbEQ+4M57hSp6rr3i/18rPTDUXzrIxloxKgJOg==
X-Received: by 2002:a65:6a07:: with SMTP id m7mr36630365pgu.136.1620833841785;
        Wed, 12 May 2021 08:37:21 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li1207-178.members.linode.com. [45.79.108.178])
        by smtp.gmail.com with ESMTPSA id r22sm258836pgr.1.2021.05.12.08.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 08:37:21 -0700 (PDT)
Date:   Wed, 12 May 2021 23:37:14 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Grant <Al.Grant@arm.com>
Subject: Re: [PATCH v1 2/3] perf arm-spe: Correct sample flags for dummy event
Message-ID: <20210512153714.GC121227@leoy-ThinkPad-X240s>
References: <20210429150100.282180-1-leo.yan@linaro.org>
 <20210429150100.282180-3-leo.yan@linaro.org>
 <f4e483ae-acbb-7afa-c215-cb4244c2e820@arm.com>
 <95d93dcb-e930-a1c7-08e1-be8885d19f64@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95d93dcb-e930-a1c7-08e1-be8885d19f64@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi James,

On Wed, May 12, 2021 at 06:17:03PM +0300, James Clark wrote:

[...]

> Apart from this issue above, I've tested the full patchset with various combinations
> of --per-thread, -a and --timestamp and don't see any issues like missing command names
> or decode issues. (Apart from -a where Command is reported as '-1', but this issue is
> present before and after this patchset so is unrelated.)

Good finding!  Will take a look for the failure issue with option '-a'.

> I think it makes sense to unify the behaviour to make it more like Coresight and others
> so this is a good change.
> 
> Reviewed-by: James Clark <james.clark@arm.com>
> Tested-by: James Clark <james.clark@arm.com>

Thanks a lot for the testing,

Leo
