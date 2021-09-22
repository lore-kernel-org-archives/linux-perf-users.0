Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E91C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 14:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1165461168
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 14:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhIVOKJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 10:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbhIVOKI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Sep 2021 10:10:08 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B729BC061574
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Sep 2021 07:08:38 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id u18so2849861pgf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Sep 2021 07:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B7MYilobLJ9/fVvIcDpd3si1fqKsE8CAaE+Ml5M1LvQ=;
        b=c//OHKVOQmJ1HZzkXV5GbadAP9AJQFLyjKfvLmQLei6r2Zsfy8YaSoVMIvHGZGn/FV
         cxzl3Xt2tLJlzRp285x8Ym9ExAGCIDysxAWDm7Qv5xwYV3kmHCcEa8T0Mb8XGx0ffQcu
         uK2/PSEx32Og/NkxxU+r2dPrrQ2p+GS33sWetxVVRaF/kKjqD2PAZ2Til2mNQ70N7PIQ
         c+K+ZdbHRnTQXHTSb0EYkb0IaJD1mvFXv7StpC5aqvLsATwR69phAzJYQ8T9hk0kG/JL
         qpk5UV8Ck4T6Y8gHqNW8Aa06yEBgeBsKa7cfdWZom7nHbd3mdfJs6GHhNqkvjU+EoAki
         OPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B7MYilobLJ9/fVvIcDpd3si1fqKsE8CAaE+Ml5M1LvQ=;
        b=pa/5cqZlhfifJTfjgch4M4IO5QEQ6zrppd27CCBeAKS2h05W47jvv8wZEmh6lZDKtJ
         z1Twr5nSV3ZqpDlBVnWb3n2uTxVyAPurnDVsEoxj1S5miGGWi1tl6qBnG3NJoH+H/F5A
         mxNhzRuC8jQwenfV+gjCwvdhggrhZcDYrHf3khh57QrHUZ0FFebz6Jsqc2zSjTzRp9yB
         95STaSih4Txp/3bqUVOfVWGuEtmMuE2UHMqNATIPLGx9Q00hOU1Ngk1ufpEz2Agyq4la
         ZKoeRL1nZiMZaTaCOrfa60B88QYYWKPgxfSIUCa5S7qgrorxuYJyjilVXV1xnLPbF9T0
         xhRQ==
X-Gm-Message-State: AOAM530t12P+2s8hV7k46UG2kTZYXPIJ26L95FGkgQw87OQA7380Zq87
        gN534oosQVOfKLkSNzBcPZfQtA==
X-Google-Smtp-Source: ABdhPJzz+TCmkeaQJ9CRl0W1HLdTxjajPly4yw0g4PdUX6Ds1gCSe6JiJC/Go4PAMSYUpoxB0AeZXQ==
X-Received: by 2002:a63:e756:: with SMTP id j22mr32627295pgk.362.1632319718013;
        Wed, 22 Sep 2021 07:08:38 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([213.173.35.225])
        by smtp.gmail.com with ESMTPSA id l24sm3221029pgc.93.2021.09.22.07.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 07:08:37 -0700 (PDT)
Date:   Wed, 22 Sep 2021 22:08:32 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, leo.yan@linaro.com,
        linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] perf tests: Improve temp file cleanup in
 test_arm_coresight.sh
Message-ID: <20210922140832.GB400258@leoy-ThinkPad-X240s>
References: <20210921131009.390810-1-james.clark@arm.com>
 <20210921131009.390810-3-james.clark@arm.com>
 <20210922110012.GA400258@leoy-ThinkPad-X240s>
 <5a1c5eab-d9b7-5623-2d7d-c6b1921b3628@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a1c5eab-d9b7-5623-2d7d-c6b1921b3628@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi James,

On Wed, Sep 22, 2021 at 02:40:54PM +0100, James Clark wrote:

[...]

> >>  cleanup_files()
> >>  {
> >>  	rm -f ${perfdata}
> >>  	rm -f ${file}
> >> +	rm -f "${perfdata}.old"
> >> +	trap - exit term int
> >> +	kill -2 $$
> > 
> > Here it always sends signal SIGINT to current PID with $$, another
> > choice is to send signal based on the incoming signal type, like below:
> > 
> >   [[ "$1" = "int" ]] || kill -SIGINT $$
> >   [[ "$1" = "term" ]] || kill -SIGTERM $$
> 
> Yes I thought that this might be an issue, but I tested it in a few different
> scenarios. Especially when running it under the normal ./perf test command and
> it didn't seem to cause an issue whether it passed or failed. So I'm not sure
> if it's worth changing or not. Maybe it is in case it gets copy pasted into
> another shell test?

I think it's not very necessary to send signal again with command
"kill -2 $$" at here.

"kill -2 $$" sends the signal to the shell process itself rather than
propagating signal to its parent process.  And the up level's script
should can detect an error with the returned exit code.

So below change should be sufficient?

cleanup_files()
{
	rm -f ${perfdata}
	rm -f ${file}
+       rm -f "${perfdata}.old"
+       exit $glb_err
}

Sorry if I miss anything at here and cause noise.

Thanks,
Leo
