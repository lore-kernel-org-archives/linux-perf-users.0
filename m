Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125D9C6FD19
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Mar 2023 00:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjCNA1E (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Mar 2023 20:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCNA1D (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Mar 2023 20:27:03 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDC44C2C
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 17:27:02 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id a9so14826343plh.11
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 17:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678753622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IxHE9Z1fYF3JO3MBVvTg1TSETT4czgValrRGg9ZVOLI=;
        b=SlwI0Wej6j4KkPHhzHJxfO6a/i85VVkDxMqcTGowiU+jYgeEfSyMD/fDdd1cwh3M29
         4jI7gFN3G/e72M8AbM15eaQnjvcHIzTHrICAGFQAtZ50lq6MgOiCdTBEEuA7fwaPukXD
         gC4aAnpHDlaV7PqHmL8nePBd17M3fTRwlj9r778UCBlspI3Tc9ybayhtGkDerIjvEDD1
         o0DJXF9UymGlgCFCb515Dsb9R5aZIsV59mzMrrwKK+wKyOPSWZBtHx9jV05PnJWEbYBw
         FB5SZ2NdkEQ0YJ/shn1BsBHiIndIPKpz3h2QNs0AizREyJNxT8w1xAS2o7qZZmN0WRFC
         8DAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678753622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxHE9Z1fYF3JO3MBVvTg1TSETT4czgValrRGg9ZVOLI=;
        b=2BuvpunLThvYLmsDTwClrMgHgyYrJCuadj3C0pqNrpVJWbHB4ZcmmslYGsq0FTC71g
         Dcg45JKCoD9VrKkvRzg/VskE0t0vo5FLtWs+pE+AmVyMClJN44r+Jp8r5igluKZkW6Dv
         WqaESQONIU82fmEmq2qKZXgZFwVChW0OHDSvDhxsDh+ze3c8PLqm8JnIDJKMapNSRTdB
         wfbLajWBzSTbJMpeMBo3ZkCmaHsPPI/P1tgfxfiMw3dCcgZBe7lV3zgqaQWl294dOKqF
         OaXyqwh05PSPiFs0JmCMvsyn0uKyt2oixaYZhhcao8HzPkCebJfn49SR8LOAPCLD1Wd8
         SD2Q==
X-Gm-Message-State: AO0yUKXux3dYGLYRjhalliN+7QrBG+rDQKHc7mulS/dDTUvcXJzNdZHA
        Uoyf7VsNuIM9/ZQ/m/LfI3n/3w==
X-Google-Smtp-Source: AK7set8f/2vb+YfoFzMLadtwfiX5pSJAQjA6HcKC4VngJswMYfXkYsghM7ajzyPnZ8Yfjbh/MVWmYA==
X-Received: by 2002:a17:902:ecd2:b0:194:5c63:364c with SMTP id a18-20020a170902ecd200b001945c63364cmr46084642plh.62.1678753621870;
        Mon, 13 Mar 2023 17:27:01 -0700 (PDT)
Received: from leoy-yangtze.lan ([156.59.236.112])
        by smtp.gmail.com with ESMTPSA id v8-20020a170902b7c800b0019a70a85e8fsm389562plz.220.2023.03.13.17.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 17:27:01 -0700 (PDT)
Date:   Tue, 14 Mar 2023 08:26:56 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 04/16] perf kvm: Use subtraction for comparison metrics
Message-ID: <20230314002656.GC2426758@leoy-yangtze.lan>
References: <20230313114018.543254-1-leo.yan@linaro.org>
 <20230313114018.543254-5-leo.yan@linaro.org>
 <ZA9kPg7JDzkxAStz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZA9kPg7JDzkxAStz@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Mar 13, 2023 at 02:58:22PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Mar 13, 2023 at 07:40:06PM +0800, Leo Yan escreveu:
> > Currently the metrics comparison uses greater operator (>), it returns
> > the boolean value (0 or 1).
> > 
> > This patch changes to use subtraction as comparison result, which can
> > be used by histograms sorting.  Since the subtraction result is u64
> > type, we change the function return type from int to int64_t to avoid
> > overflow.
> 
> Not building at his point in the series:

Sorry for this!

I can reproduce the building failure, will check patches compilation one
by one and send out new patch set in today's later time.

Thanks,
Leo
