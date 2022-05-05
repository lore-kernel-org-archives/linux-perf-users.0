Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886FBC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  5 May 2022 09:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237764AbiEEKA1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 5 May 2022 06:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiEEKA0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 5 May 2022 06:00:26 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B57C49920
        for <linux-perf-users@vger.kernel.org>; Thu,  5 May 2022 02:56:47 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id m23so4900132ljb.8
        for <linux-perf-users@vger.kernel.org>; Thu, 05 May 2022 02:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n4DEU3H+LT7BYKo9sox1btQzO0smkBlR+Qye4B8ebu0=;
        b=Ks4SKxTnUKVKUwVXv/z6D06GzDmx2q3+rx//xHOeMzoAOuewAqwVt9ua6bENTrVz+R
         0JIegRcTRyiASQxRg0+uyHbQOiDNfULwFvH5tPA0VKRGpsfe5tecjoOb/Y6oILbVoBH3
         NrvWEGkrpZd2fxj68loUCGXxDwOZH0prJs4nv5Q3n623HV9JjnMcueFPUeRwP2SXkMqg
         tlD0SwMM3+X2vkQCFV2KcsjrC74qdHjgIViwO734yBdWzOzRoIzDAGpUu/iTUfkCW4QW
         eZC2sx543Goog7czQmR5IfMxfUWCki+7tIS2k+bxHfFA6L/4h7BthEETlGL9VaIMUUG0
         o1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4DEU3H+LT7BYKo9sox1btQzO0smkBlR+Qye4B8ebu0=;
        b=BT4XKqPDwc0O86GNvwQ3+2W5nLUcENP5ivkeyNU7Z0GyptFF1uz9vv1PRE3hiV64zB
         19AQnPiOiisXXuJ7bcrb7jC8YX00dtYhKkjt/H6sLbQhuOvtijBygsjgI+cQ66gGwd3Z
         9fw568PCmdoRH5nCk/LD4EtdDrVlwGFtIql2ebS4capyaV6JPu/iOqwM4vW43PMzMAYZ
         0uLExFUWQ26gntnII/xPCkmZa6axdb3DL/Jt5+yd9NuSYVJ44+tq1wSQ9i6bWjbSqlpt
         zyn4lmH2i+YJFk2A+s6gldtBEO33rMf+NLesYLN5iZFbbDz6ZlDO0mEy4WDQ8vdR92dG
         7hog==
X-Gm-Message-State: AOAM531cT7T5HSjz/Qit4m/buM2iD2x0g/iaDpesVHSKboN8gFjZFiNg
        5YrD3XsNXS5EcqG3biWZCyagmn0qUi2CgYlrCc4t0A==
X-Google-Smtp-Source: ABdhPJyppKvZANHxf8tddUkLILvHRxFY8BNe6nPqZN5wceuCAun9Tn1bbcKNTCAmougN0uypJjJfA0e0pqPz5vjCgWg=
X-Received: by 2002:a2e:93d0:0:b0:24f:255d:4bb1 with SMTP id
 p16-20020a2e93d0000000b0024f255d4bb1mr15515548ljh.525.1651744605509; Thu, 05
 May 2022 02:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220504150216.581281-1-german.gomez@arm.com>
In-Reply-To: <20220504150216.581281-1-german.gomez@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 5 May 2022 10:56:38 +0100
Message-ID: <CAJ9a7Vhrm2=1H_LLkh+j0uK8yRc7vi2yLmtDMJvVekfhvHUdPQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] perf cs_etm: Basic support for virtual/kernel timestamps
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi German,

On Wed, 4 May 2022 at 16:02, German Gomez <german.gomez@arm.com> wrote:
>
> Hi,
>
> This change has a soft dependency on [1], but assuming the name/location
> of the new sysfs interface (ts_source) doesn't change, it should be safe
> to apply.
>
> The new 'ts_source' interface allows perf to detect if the timestamps in
> the trace correspond to the value of CNTVCT_EL0, which we can convert to
> a perf timestamp and store it in the instruction and branch samples.
>
> Due to the way the trace is compressed and decoded by OpenCSD, we only
> know the precise time of the first instruction in a range, but I think
> for now this is better than not having timestamps at all...
>

The output of OpenCSD is reflective of the architecture of the trace hardware.

Timestamps in the trace are always associated with waypoint elements -
primarily branches.
Hardware trace compression results in only these elements being
output, i.e. E / N atoms representing branches taken or not taken.
Instructions between branches have no explicit element appearing in
the trace.
The decode process implies all the instructions between these elements
to form a range of executed instructions, hence the timestamp being
associated with the first instruction in a range.
Moreover, even though we may request a high timestamp rate, output of
other trace is prioritised over timestamp trace, so there is never any
guarantee that we can force timestamps to appear at the start of every
range.

Any attempt to increase number of timestamps in a trace range would
have to be done by some software interpolation mechanism

Regards

Mike


> Thanks,
> German
>
> [1] https://lore.kernel.org/all/20220503123537.1003035-1-german.gomez@arm.com/
>
> German Gomez (4):
>   perf pmu: Add function to check if a pmu file exists
>   perf cs_etm: Keep separate symbols for ETMv4 and ETE parameters
>   perf cs_etm: Record ts_source in AUXTRACE_INFO for ETMv4 and ETE
>   perf cs_etm: Set the time field in the synthetic samples
>
>  tools/perf/arch/arm/util/cs-etm.c |  89 +++++++++++++++++++--
>  tools/perf/util/cs-etm.c          | 126 +++++++++++++++++++++++++-----
>  tools/perf/util/cs-etm.h          |  13 ++-
>  tools/perf/util/pmu.c             |  17 ++++
>  tools/perf/util/pmu.h             |   2 +
>  5 files changed, 221 insertions(+), 26 deletions(-)
>
> --
> 2.25.1
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
