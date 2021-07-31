Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B50C4338F
	for <linux-perf-users@archiver.kernel.org>; Sat, 31 Jul 2021 07:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 951E960F3A
	for <linux-perf-users@archiver.kernel.org>; Sat, 31 Jul 2021 07:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhGaHoC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 31 Jul 2021 03:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhGaHoC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 31 Jul 2021 03:44:02 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63038C06175F
        for <linux-perf-users@vger.kernel.org>; Sat, 31 Jul 2021 00:43:56 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id nh14so6733674pjb.2
        for <linux-perf-users@vger.kernel.org>; Sat, 31 Jul 2021 00:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0bXc4+f8J7h+BNDmqSHrABgRPZcrLEP+EUPIPGuZBSg=;
        b=blBn1bdjx0Hf4LXvShmXzIy4bQIUJ9jycI0lDUNppPmirEO7h5mAx0gV7nO5jX346z
         U3p0hj/1qUcV1nsT28DFNsq30tBlCi0Bxl3frbMNVC93xafbGfTVKvpjWcFFOx3BU8yL
         HK0Dh0uDgP4GeRBYtKdLvNR4Fef0nQj28rgnH9lWLo6yNowde7McWWn4IEPghztHOHtk
         o+eultcLoEi8OK/uHZ3IACCj2nQPuOizNNvmwVZcJAR9nKX7cDu5I/UJ7ES6jQvluQHd
         kEaznNnOFuj+O35NscZ6/IjWWLbw0arQTM7WneF+T6T9KU2qHLhugSaUJkRfTbTW8pV1
         Bkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0bXc4+f8J7h+BNDmqSHrABgRPZcrLEP+EUPIPGuZBSg=;
        b=CETV3eMflMCIVBhSFZbRJoE9yuWNRNcAyqwfiiDnmAvDhgkA6Fk0mYmysWV+cmzJkD
         Oea5ZGNN4LVwkQBE+FaulOSbePY5wsKb6yOQxqArlJbtkT9iwxTzK6rJGz3f4tjNF4p5
         C8S75MiqrmmSAv3FmlCucw6di39MrOVKLQGpDiBun2uUK+qeCptF3LbJ+4TCK+X1rdEL
         djwcxVr3whCL3982OLNlgiJCJDJjLOFKQz7ImYvSkeXXnj0WWfr1/jifiPbFL1f8pIU0
         LKt6P9K4+UqUmnS0GNCEJKTg9uPbJZrdZ+tvurh/IioXkQQGDQoyBqAoSt0zvlEYd9gk
         ix0Q==
X-Gm-Message-State: AOAM533OSzY+9UcS9KZCpon9KN/A93kZXb1YJFYXRUmOihdSYfLudYVm
        ULVOUUx3kDPjj9jvXt/o8hAFiw==
X-Google-Smtp-Source: ABdhPJwlRPY/8pm/IxhL59d2iJ856M16SNNYrqVK93bnXOKLeJqia0voU1lxF64lbFo8TO0S73or2w==
X-Received: by 2002:a17:902:8a98:b029:12c:3177:c3ef with SMTP id p24-20020a1709028a98b029012c3177c3efmr5902070plo.21.1627717435852;
        Sat, 31 Jul 2021 00:43:55 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([204.124.181.43])
        by smtp.gmail.com with ESMTPSA id j3sm4663125pfc.10.2021.07.31.00.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 00:43:55 -0700 (PDT)
Date:   Sat, 31 Jul 2021 15:43:43 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, al.grant@arm.com,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        mike.leach@linaro.org, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/6] perf cs-etm: Save TRCDEVARCH register
Message-ID: <20210731074343.GG7437@leoy-ThinkPad-X240s>
References: <20210721090706.21523-1-james.clark@arm.com>
 <20210721090706.21523-4-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721090706.21523-4-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jul 21, 2021 at 10:07:02AM +0100, James Clark wrote:
> Now that the metadata has a length field we can add extra registers
> without breaking any previous versions of perf.
> 
> Save the TRCDEVARCH register so that it can be used to configure the ETE
> decoder in the next commit. If the sysfs file doesn't exist then 0 will
> be saved which is an impossible register value and can also be used to
> signify that the file couldn't be read.

After reviewed the whole patch set, come back to highlight one thing:
seems to me ETE is only a feature introduced by new ETMv4 revisions; in
other words, if we support ETMv4.5 or any later revisions, it will
support ETE feature.

Here I think the right thing to do is to support newer revisions for
ETMv4, and then based on the revision it creates a decoder with
supporting ETE feature.  For a more neat solution, if the perf tool
passes the "correct" revision number to the OpenCSD decoder, it should
can decode trace data with ETE packets.  In this way, the ETE decoding
can be transparent for perf cs-etm code.

How about you think for this?  Sorry if I introduce noise due to my
lack knowledge (and platform) for ETE.

Thanks,
Leo
