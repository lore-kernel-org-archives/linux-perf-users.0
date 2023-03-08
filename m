Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D216AC64EC4
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Mar 2023 11:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCHLrD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 8 Mar 2023 06:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjCHLrA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Mar 2023 06:47:00 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C140B9C89
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Mar 2023 03:46:53 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id u5so17369321plq.7
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Mar 2023 03:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678276013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VOKINkye3tuYPwZB/WM78Qa+Qktd4CzqAu8Jgly0MS0=;
        b=RpnNvdOOWeSEZyeZO4itdh5QjH/ue0UOwTkXiE0G6XszWBmCCw104DAeJFhBPFrANT
         Z2Ueb0BCBXvRMFIvL07gTbqEtLLrRh/Hl61uzHyef9DMNMkIoPbkYo4MV+kLCc7TJPGR
         pAqp6R/IhTCdblHScXu9qNsV2NqrAb7fpnwWDSprKqm2kRxavpATJ6VMm4si37RHMM6P
         GIq5NZ6jAR/8Jqdxox4tBBuV9tIQiALVmZZCvrvfLnyX7JyqTMZLy63dFw30SCVumfRd
         ctd30cgLb1dZxuCYk9p/VOoUGvzsX0VIh/WxGt9lS3DggvVS9SH84uQMQxdOcImAtgFc
         /TPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678276013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOKINkye3tuYPwZB/WM78Qa+Qktd4CzqAu8Jgly0MS0=;
        b=NdTmS7o0DpW5unHgNGR3xHCBmnEVrCeYbDuoG0Rn6c6l0p3P3wS+wyGwPAutiS/4Nm
         0YYJWBTiEaMQ1UCw5JHC6pMEUUNeSPw7mI7vYUqux5ZoXQ3CFL9QOZ/lfptZCy/LdUBL
         McRxfT6zhHaHdiBeSu5tSlAWQl2Gfev/+ZDKRUmu+iNtZrMlaij/kGplv3T/+GFLqkcF
         Gpsbb6DUBhuy0S+I7iyWE7DqFuPaSJzPoGgKv0S7oHJ8IJ3hRRChLQUvQ4q53+LHHkQr
         pKAgeX0JyjqoxEpQWeuAZbWiGWT9l/n2r3P8nFZQ5kTmKlmi5UR9qNwmK4WXdlvwMYVl
         DyHw==
X-Gm-Message-State: AO0yUKUaSgL+lxt6K5737tj+0EtOxB94Ju22NrzMBQxHNloMNAu2sBbY
        CLm7uDyigzDWgUiKRfSAEg2K5Q==
X-Google-Smtp-Source: AK7set+fIh/cq5RGx3k8dHKcUQa4MqtJzpA2lxY2RAenNKh+wh1dNlCpr5vg9bdByCHCvi2JxyYDrA==
X-Received: by 2002:a05:6a20:8e28:b0:c6:6fef:545c with SMTP id y40-20020a056a208e2800b000c66fef545cmr19887853pzj.21.1678276013010;
        Wed, 08 Mar 2023 03:46:53 -0800 (PST)
Received: from leoy-yangtze.lan (211-75-219-203.hinet-ip.hinet.net. [211.75.219.203])
        by smtp.gmail.com with ESMTPSA id j7-20020a62e907000000b005aa60d8545esm9342740pfh.61.2023.03.08.03.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 03:46:52 -0800 (PST)
Date:   Wed, 8 Mar 2023 19:46:44 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        linux-kernel@vger.kernel.org, al.grant@arm.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] perf cs-etm: Reduce verbosity of ts_source warning
Message-ID: <20230308114644.GC19253@leoy-yangtze.lan>
References: <20230308094843.287093-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308094843.287093-1-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Mar 08, 2023 at 09:48:42AM +0000, James Clark wrote:
> This is printed as a warning but it is normal behavior that users
> shouldn't be expected to do anything about. Reduce the warning level to
> debug3 so it's only seen in verbose mode to avoid confusion.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org
