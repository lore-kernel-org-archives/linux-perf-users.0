Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44BEC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Apr 2022 02:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239538AbiDNCkY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Apr 2022 22:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239530AbiDNCkX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Apr 2022 22:40:23 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEAC32EFE
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Apr 2022 19:37:58 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id s18so7555483ejr.0
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Apr 2022 19:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uc7ry7HIsnf2r8nUN2XsM9Cr609Rg9Ev/nf0gRDdVjA=;
        b=J0EA2TPN5DF45RPQJxsxLx9xc2kpvx4GDfs7GmNxtpSy3srw/qZOuOOnaLJe6pfBYu
         nJ/8EahmmrlsMrZxJ/kmV6hFdQWckTo0h2YFcNcLs91EfnKG7MFj7PRJwvOvDAC+Qvt5
         jdt70t/HBqRAc94klhFS82Q1W/wvvCUC9JARqYX130KlM26o7BehHtm056rttE2ManH2
         2qs+554u0U5lgCRra3W/8vKH7jA61mqurSeavoBH4IQE3BSH2mBVDdWKGKH0Ex4wXrr+
         IddfVTGZEU/Ef78FbKae3ynglEcgS+Q13QmkIoi0KIZKOiyE9B/6zeEiBRbZO5PsCWMz
         vQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uc7ry7HIsnf2r8nUN2XsM9Cr609Rg9Ev/nf0gRDdVjA=;
        b=d+noaCy6xvY/9JpCoW6t4VxKCIovjbG0kIPe1JuBCXCp9UUduKybu7Cv9k+f/mibbr
         RiN4lBVRnqh0MChO4Kek/VXyHSC5FTpCu7wgm7qR9Z4c8cVu59aVUlk4yAUtlaPmwNdE
         rRtVIlMlVbKP3yD0TsBSplnGJIhR8LDjw99AU+kxCB/W9OzN+CDAVyDX78n0Y3y7x0Xy
         Ed/Kz0NBrFt9IxyrfcwQGn1T4WEQj8vLAz6jz7kkma+TA4uBjmTFqVwvt+6C+fIj43Wv
         VvH7qaqIFDJzprf+4/twGF1sU5LIiU2dFLc0z/bJ4A6IuPYVln+O9VRsBYhuaQbLo3Zs
         hNKQ==
X-Gm-Message-State: AOAM533TFtcqBN5vu9COOQSeBk8W7B39uZ1DPaBsDC5ph+eVn4S8lquY
        K+fr3b/68Rq1toY3agQwNJ72nw==
X-Google-Smtp-Source: ABdhPJykhBqOYl/1R7/tZiqUw1EGHPtXtHH5Em+FxWU65fkV7sCECnF78Jm7X+6uOY/+qCV0ESpJ6w==
X-Received: by 2002:a17:906:7314:b0:6df:839f:af7 with SMTP id di20-20020a170906731400b006df839f0af7mr497470ejc.65.1649903877223;
        Wed, 13 Apr 2022 19:37:57 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id lg4-20020a170906f88400b006e869103240sm193616ejb.131.2022.04.13.19.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 19:37:56 -0700 (PDT)
Date:   Thu, 14 Apr 2022 10:37:51 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf arm-spe: Test memory samples
Message-ID: <20220414023751.GA539224@leoy-ThinkPad-X240s>
References: <20220413010221.81332-1-leo.yan@linaro.org>
 <21978774-356b-bc08-ba68-80d877e2b6b4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21978774-356b-bc08-ba68-80d877e2b6b4@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Apr 13, 2022 at 06:17:18PM +0100, German Gomez wrote:
> 
> On 13/04/2022 02:02, Leo Yan wrote:
> > Add a new test to verify the Arm SPE synthesized memory samples with
> > 'perf mem report' command.
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> Reviewed-by: German Gomez <german.gomez@arm.com>

Thanks for reviewing.

> Thanks for the patch.
> 
> There are some tests for perf_event_attr fields. We added one for SPE
> recently [1], but it's not checking the sample_type attribute yet.
> 
> We could update it from our side and send another patch, to test the
> DATA_SRC bit is not missing.

Agreed, it's better to update the patch for checking DATA_SRC bit and
resend it.  Thanks!

Leo

> [1] https://lore.kernel.org/all/20220126160710.32983-1-german.gomez@arm.com/
