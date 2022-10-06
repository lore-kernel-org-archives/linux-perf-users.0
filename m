Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8F9C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Oct 2022 05:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiJFFpP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 Oct 2022 01:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJFFpN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Oct 2022 01:45:13 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DA932B80
        for <linux-perf-users@vger.kernel.org>; Wed,  5 Oct 2022 22:45:13 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 129so954354pgc.5
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Oct 2022 22:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=zHiKWHLUiEejnPGH1G2wAyZsdKfADMIbnHWjWlmRMao=;
        b=tl8RJsAPTOLZS/YMGLNBH1ch7H4kbv9Y1gZtT9Ull0r5CBiD6eUdSipUWpN81KZD4o
         1B2B7DnDh1UkERW85Kpuwu94+gpahq9tgcUK4bAZ41sM2gdyAWdR2yJhde597K3T5ijb
         YS57MhN2YnsOTLUhB3XmjywOZZt5msHmyPjDnzU59v1fugjfQsSY+YSnS8pav99+URgn
         sYfh2wSV3xu5ZxiuZm1tXH5eiWYCU9Dp85BfZ53BPIeArxaaCU7CqPt/ZeEykdqZnLAj
         E1tdx37CJ8wfwINyGwIOe5cu1NhW9vHO71MVVQqWE5tOQFJ4WS7XTmRL9xuMyzRc13Bk
         Q9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=zHiKWHLUiEejnPGH1G2wAyZsdKfADMIbnHWjWlmRMao=;
        b=w6PjmLJRaR1KY1YsOQ8+DyPs/vcROJWjJ5zxOlYcvnHoQXn7j+VcDIgff4TH06Kszd
         XY2Nb7xaqbANc+W4t9W7km7XUaRocnPdQ45osZ7A8Qud/8rn5NSrniEGFaKFA8Y+Adg+
         pW4QUKBuFmc/t5/RdfbeCzaA/YU26ktbETJw3A97cZkgNq0b+5VrQgYd3kV5fnHa+hAO
         vR3HiWHcYgGBdJe7n9XMWVIgE8l3EV/1Ifjh5qPFbI6DSsP/e2No5csgtQakgegEQMSL
         rZUlM5OpNalPTbcHkp8owPgqSy2/4YnjI8URmD/I7gEobPkCy+uPjJcUAm4hqKAkiGkj
         8UaQ==
X-Gm-Message-State: ACrzQf3eQ5knxEc6kCstzeica/nIcnLCqBZQDD3rlNc4c9jxKNAqNmiN
        NX0pg1uKFiwUV8/fa+skG90rGg==
X-Google-Smtp-Source: AMsMyM5vd8OGf+eWFBFD9UvRzJr7NaLqmbEhXMZTxTI6ty50qCKgo7J7kWQc4x+BqzwP5m3G5NO1pQ==
X-Received: by 2002:a05:6a00:cd6:b0:546:d03:3dd7 with SMTP id b22-20020a056a000cd600b005460d033dd7mr3034708pfv.19.1665035112497;
        Wed, 05 Oct 2022 22:45:12 -0700 (PDT)
Received: from leoy-yangtze.lan (45.78.17.119.16clouds.com. [45.78.17.119])
        by smtp.gmail.com with ESMTPSA id a15-20020a170902710f00b0017f9021ddc6sm584474pll.289.2022.10.05.22.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 22:45:11 -0700 (PDT)
Date:   Thu, 6 Oct 2022 13:45:05 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] perf: Skip and warn on unknown format 'configN'
 attrs
Message-ID: <Yz5rYU/sWtJcRZ7B@leoy-yangtze.lan>
References: <20220914-arm-perf-tool-spe1-2-v2-v3-0-8189fc04dcc6@kernel.org>
 <20220914-arm-perf-tool-spe1-2-v2-v3-1-8189fc04dcc6@kernel.org>
 <YzU/o3kxS/BYpJhn@leoy-yangtze.lan>
 <CAL_Jsq+3pt_yr5LLFNR-DsXQycD-_gd5fum8QbfxUzHPR-zfJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+3pt_yr5LLFNR-DsXQycD-_gd5fum8QbfxUzHPR-zfJw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Oct 04, 2022 at 12:07:30PM -0500, Rob Herring wrote:

[...]

> >     INIT_LIST_HEAD(&perf_pmu__fake.format);
> 
> I ended up fixing this in perf_pmu__warn_invalid_formats() instead as
> the test dealing with internal stuct pmu details didn't seem right:
> 
> +       /* fake pmu doesn't have format list */
> +       if (pmu == &perf_pmu__fake)
> +               return;
> +

Good point.  It would be even better to fix it in the first place
rather than checking fake PMU in perf_pmu__warn_invalid_formats(),
how about below fixing in util/pmu.c?

-struct perf_pmu perf_pmu__fake;
+struct perf_pmu perf_pmu__fake = {
+       .format = LIST_HEAD_INIT(perf_pmu__fake.format),
+};

Thanks,
Leo
