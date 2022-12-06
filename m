Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2E2C352A1
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Dec 2022 05:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiLFFDA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Dec 2022 00:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiLFFC6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Dec 2022 00:02:58 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E30C755
        for <linux-perf-users@vger.kernel.org>; Mon,  5 Dec 2022 21:02:57 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id m19so10340394wms.5
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Dec 2022 21:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IsrGD/2+yn6YnOXfEO+xg404RVi2s4a4zlidgWfmgVk=;
        b=UiZHzgZXSObfsSVre4wJAPxgA5vSbx5ZmCST8nXSr9pmIvr51K8JFqrKXJOo6qLoZg
         gDY1xqAIa1KF5nLPH4it+F70g36bmSoHcEk+xtZmnwJpdlHp4nE9mjFDLf5CTRJoAQdF
         Gna0Pp6EH9D0m4Tahg93LOiTy2rgXAXhfz/5hZ3ZA29YbLulXVFguZYJY2OSDHy2y1XI
         CJuT8i9RTfDIzSdgoXO0G5YUtpBe51K9Kh0g1DSOKJP16ZtW1C3Ng/Hvgx+pJGhxbuqp
         82GIR1p6v2lOUnfxNbnnuvcx45LkgIgSuQFDHMeSPu0DXnGm/7xt057CQw4G58mI5rFZ
         /4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IsrGD/2+yn6YnOXfEO+xg404RVi2s4a4zlidgWfmgVk=;
        b=giPQNzEfcFwGimrW8Qjhq+1KEJ6ZrVYWOAYmpgM1aTpWN9EWLTq9J+oj3zrBRgT/4k
         yVBvSgDw9U1iyQcf7Rv/uwl6eJrfUeQ/lEUcFKkzQnoCpJOUCoI++1LZCxUr2rG8dNf6
         t/iqY0X5FNODuM65poz3l8mgzAAouFrru6O+0UgJW+rACqRlWpYOvekm/rrNLN12YDwp
         zgv9RiyEGYhUTlM8WkYS+phk6R7dsbQCJyGA7m2fZohyTwhZLJtCKyJCc6m8r08+U49t
         DEAxX8zXNw110Ki/Col1o6RymgezAzQRPWR6AZd1QmvzvkISxs0T1Y+vu8hfqb1vuxi5
         S+5g==
X-Gm-Message-State: ANoB5plesg9iWkPUhGl3rc7cApt5U7oAsgXtHriPUwnAR1xnM/X2HgDI
        zLdLmBHlH53upk4s36KJRKsTmqCFhLvdtycYYGoaag==
X-Google-Smtp-Source: AA0mqf7utYozEKl0LYpUjOycw2vxoqkx+1UE8c8193GTqSi0P8ofsHRJcD31Vzb+xkbU07d0uajCZDc8MLjCUBS5/Tg=
X-Received: by 2002:a1c:7318:0:b0:3cf:cb16:f24a with SMTP id
 d24-20020a1c7318000000b003cfcb16f24amr64550760wmb.182.1670302976080; Mon, 05
 Dec 2022 21:02:56 -0800 (PST)
MIME-Version: 1.0
References: <20221206043237.12159-1-ravi.bangoria@amd.com>
In-Reply-To: <20221206043237.12159-1-ravi.bangoria@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 5 Dec 2022 21:02:43 -0800
Message-ID: <CAP-5=fXdx8aKyyw8wGA-xpOTqRFakaWYyGES3nq12of-xgM=AA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] perf test: Add event group test
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, kan.liang@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
        carsten.haitzler@arm.com, leo.yan@linaro.org, maddy@linux.ibm.com,
        kjain@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        tmricht@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Dec 5, 2022 at 8:33 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> Multiple events in a group can belong to one or more pmus, however
> there are some limitations to it. One of the limitation is, perf
> doesn't allow creating a group of events from different hw pmus.
> Write a simple test to create various combinations of hw, sw and
> uncore pmu events and verify group creation succeeds or fails as
> expected.
>
> v2: https://lore.kernel.org/r/20221129111946.409-1-ravi.bangoria@amd.com
> v2->v3:
>  - Define a set of uncore pmus that supports more than 3 events. This
>    will prevent false negative results by not picking random uncore
>    pmu. Test will be skipped if no uncore pmu found.

Acked-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> Ravi Bangoria (2):
>   perf tool: Move pmus list variable to new a file
>   perf test: Add event group test
>
>  tools/perf/tests/Build          |   1 +
>  tools/perf/tests/builtin-test.c |   1 +
>  tools/perf/tests/event_groups.c | 127 ++++++++++++++++++++++++++++++++
>  tools/perf/tests/tests.h        |   1 +
>  tools/perf/util/Build           |   1 +
>  tools/perf/util/pmu.c           |   2 +-
>  tools/perf/util/pmus.c          |   5 ++
>  tools/perf/util/pmus.h          |   9 +++
>  8 files changed, 146 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/tests/event_groups.c
>  create mode 100644 tools/perf/util/pmus.c
>  create mode 100644 tools/perf/util/pmus.h
>
> --
> 2.38.1
>
