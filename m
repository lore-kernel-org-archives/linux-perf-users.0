Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E50C19F29
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Aug 2022 01:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238936AbiHDBHp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 3 Aug 2022 21:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238934AbiHDBHm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 3 Aug 2022 21:07:42 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9A440BD8
        for <linux-perf-users@vger.kernel.org>; Wed,  3 Aug 2022 18:07:39 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id pm17so12500215pjb.3
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Aug 2022 18:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=erOSKwHABTyiioF2PC9EHt0JfAPJh4hwf/4PvpBCnV8=;
        b=WwVlD25us3ZEA2uO3DeVBjKN1KSKnyonbDDgu4aVy7IfH2TgSutPMDrSSjUKdJNSGF
         H9KGYX8D90rPA/KRzn/Br6rRUIPxpozMiHOgEsjSfCPriQ/Qh6u4bYstQMbAuJTOSvbd
         V0tuHCm7yg9muriJALX13iG+3VzYoW0HAmYQaFtOsD6ni3MrpiQUbKmOsLnczyx1VZmL
         SBXuF3R4U0upMs+Fcw/vonADPk4cb86xQJUJ1cW7RAKnImCzrtuP8JSTD/UUYDdkd/Q8
         Qk/d1V9h4O6i3FviBtm1qq+qgkp8X2uK5mxpjKNuiLn2CKgr2RxUOzFy9DWbklSGcljU
         8MIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=erOSKwHABTyiioF2PC9EHt0JfAPJh4hwf/4PvpBCnV8=;
        b=uKEcHUY6G9fUprpgbC2pSN2/u2yKSFJcwUuzBVUBG6CTMDxdhZLPkuJAD0c/HYz1DK
         V18h8mgKa4I6wj+YmfM438RfZc1/VM3TjV2pKXe9xTVvnUIGRi4x7Qvz7AQVWJcS7YD6
         3gy98/ZDUFBqylNW4Ho/G9Uxp+rfCTyhxOLSYG1wGv8rpQ8bvPxb61i3yCi260hmgLgz
         0TYnRna5tTXxqR97Asd4hZ6Lxf7bId7s5QvoM9bR4j+nSd1TaGfpMmP82Q/FfW/0/R72
         qQRbmpw9fRL6xbMt9v/V5KuiF040ARLxD1iz4MP3plRQlwJx2JcZD/HO7yorQssd69ch
         nTqg==
X-Gm-Message-State: ACgBeo0zY3wuRPXtFijUF9GHqs5ll/MnWPPYTDuseVpGY0vKGiRxsyVH
        sPT2X4OqHBHvj7NJRAm9kP+xbw==
X-Google-Smtp-Source: AA6agR4Bcx8F0bA53mVQ6ntMm3gDcAM7WZ84r8LgFdtEe7KsriaOVhJwcKr5fWh6PLXCpUyfq7QHcA==
X-Received: by 2002:a17:902:e88c:b0:16d:4364:2c37 with SMTP id w12-20020a170902e88c00b0016d43642c37mr28431154plg.69.1659575259192;
        Wed, 03 Aug 2022 18:07:39 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (173.242.113.38.16clouds.com. [173.242.113.38])
        by smtp.gmail.com with ESMTPSA id o19-20020a635d53000000b00411bbcdfbf7sm11684467pgm.87.2022.08.03.18.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 18:07:38 -0700 (PDT)
Date:   Thu, 4 Aug 2022 09:07:34 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1] perf test: Introduce script for data symbol parsing
Message-ID: <20220804010734.GB133193@leoy-ThinkPad-X240s>
References: <20220803150744.133128-1-leo.yan@linaro.org>
 <CAP-5=fWArHKrxu80WKZystkEDFW_jhuU02m89S8tXkqvOChpoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWArHKrxu80WKZystkEDFW_jhuU02m89S8tXkqvOChpoA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Ian,

On Wed, Aug 03, 2022 at 04:06:04PM -0700, Ian Rogers wrote:

[...]

> > +echo "Compiling test program..."
> > +cc $TEST_PROGRAM_SOURCE -o $TEST_PROGRAM || exit 1
> > +
> > +echo "Recording workload..."
> > +perf mem record --all-user -o ${PERF_DATA} -- $TEST_PROGRAM &
> > +PERFPID=$!
> 
> I wonder here you could do:
> TESTPID=$(ps -o pid -h --ppid "$PERFPID")

I tried this command and found "$TESTPID" is empty string.  So the
test command doesn't create child process.

> > +sleep 1
> > +
> > +kill $PERFPID
> > +wait $PERFPID
> > +# test program may leave an orphan process running the workload
> > +killall $(basename $TEST_PROGRAM)
> 
> And then here kill $TESTPID to avoid the killall which worries me a little.

Yeah, I referred the code from another script test_arm_spe_fork.sh,
this script doesn't fork new child process.  So here I get over
complexity, will drop "killall $(basename $TEST_PROGRAM)" in next
version.

Thanks a lot for reviewing!

Leo
