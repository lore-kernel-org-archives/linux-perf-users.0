Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A26C4332F
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Dec 2022 16:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbiLNQBJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Dec 2022 11:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238798AbiLNQAl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Dec 2022 11:00:41 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115BE28E2D
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Dec 2022 07:59:16 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h12so154385wrv.10
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Dec 2022 07:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l/uy268DIouOlaUX1pmogcq5YSUEqfw9Ux2GHr22Fcw=;
        b=fNyjwLMZXubjgeSgHKjUe6T/UOZYLqSUc7aFegiHxu9AdAE6aO8SxLz8JaPnXUAWvc
         lTwvPjzpnpHjWLz+1DgQl8/iA7YSvRsMWHZS6n1nlE4mB3/KROPxX7p47q970h26G5OE
         KFAtcgt8BH0XaqScv2+J+esfdUdg8P/DWfDJdGhYrZ4niSIXmckAKLdJeBkZGRzd1ZqG
         ACiroJY7RbtJBeWJ/FpWdvjKvfTSb5lLIcWzADUzlfiP87STCY/Xeui3cY6Rjsa/pi64
         5vfzbE0QW+89V8YprvkwM0Nv22o4cATewq6dbm58IeOB8EonoBliK+AS235YjuP89lAV
         SRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l/uy268DIouOlaUX1pmogcq5YSUEqfw9Ux2GHr22Fcw=;
        b=15xv/7rE27Nz25BXNexo+lRzXSxGYJWxG1DwNQMlAwEbKYW4pDtEzmZI8EFj8JWgrH
         8P/ZIdGtHASigz3rmqPs7REc6hdakOBzAfr1hn1yoWT3K9KD5aQ8dBAq6fwAY2tViDSr
         NO2p0ZHMMEISaj6Fp8YUd1D07+S0MpaljWMAgOqbDslATtbSFHOlHr9D/uOXWvKC43tl
         Chn+of6uSswzm5Ph9qLzwwUg1cs7++LV6LvZ42Glx0DTQi2xHHrKfzuqBjJlvRaAA07s
         HE4bHrDilgEjZBOp4pZcbthJn2MWSNLUpfDC6oby6MZz/E708s9hpByjIUgey8XaOYXm
         akEg==
X-Gm-Message-State: ANoB5pnqaSQ0+QvL2/nrjeXF6Ic6oBqedWMGl7Z2ajy++RtsBzKS4LqK
        d76lxYF9eXnuN9dHE1aDKSa99iPaleFLWJYQdk7bWA==
X-Google-Smtp-Source: AA0mqf5SbNc2kGGi/MGIcrhYYti0hAMTqIqgvSk/bgyaHMPsKSew2BOLWDL6zByhzOo1QDXjsoHulglB2tjxjFDV8kY=
X-Received: by 2002:a5d:4acb:0:b0:242:78b7:6bf3 with SMTP id
 y11-20020a5d4acb000000b0024278b76bf3mr6621718wrs.375.1671033554398; Wed, 14
 Dec 2022 07:59:14 -0800 (PST)
MIME-Version: 1.0
References: <20221214082652.419965-1-sandipan.das@amd.com>
In-Reply-To: <20221214082652.419965-1-sandipan.das@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 14 Dec 2022 07:59:01 -0800
Message-ID: <CAP-5=fWm55y6LdZozX=LuLZhk+SWm_yi5tLcKgT_UJt9FETNPQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] perf vendor events amd: Add Zen 4 events and metrics
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com,
        jhladky@redhat.com, ravi.bangoria@amd.com, ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Dec 14, 2022 at 12:27 AM Sandipan Das <sandipan.das@amd.com> wrote:
>
> Add events and metrics taken from the Processor Programming Reference
> (PPR) for AMD Family 19h Model 11h Revision B1 processors which can be
> found at: https://www.amd.com/system/files/TechDocs/55901_0.25.zip
>
> Previous versions can be found at:
> v1: https://lore.kernel.org/all/20221207053007.336806-1-sandipan.das@amd.com/
>
> Changes in v2:
> - Remove "bytes" from the names of data fabric bandwidth metrics which
>   use a scale unit.
> - Use better group names for pipeline utilization metrics.
> - Move patch that adds family-model mapping to the end of the series for
>   avoiding potential build issues.
>
> Sandipan Das (4):
>   perf vendor events amd: Add Zen 4 core events
>   perf vendor events amd: Add Zen 4 uncore events
>   perf vendor events amd: Add Zen 4 metrics
>   perf vendor events amd: Add Zen 4 mapping

Series: Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  .../pmu-events/arch/x86/amdzen4/branch.json   |   82 ++
>  .../pmu-events/arch/x86/amdzen4/cache.json    |  772 ++++++++++++
>  .../pmu-events/arch/x86/amdzen4/core.json     |  122 ++
>  .../arch/x86/amdzen4/data-fabric.json         | 1090 +++++++++++++++++
>  .../arch/x86/amdzen4/floating-point.json      |  818 +++++++++++++
>  .../pmu-events/arch/x86/amdzen4/memory.json   |  174 +++
>  .../pmu-events/arch/x86/amdzen4/other.json    |  138 +++
>  .../pmu-events/arch/x86/amdzen4/pipeline.json |   98 ++
>  .../arch/x86/amdzen4/recommended.json         |  334 +++++
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |    3 +-
>  10 files changed, 3630 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/core.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/data-fabric.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/floating-point.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/other.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/recommended.json
>
> --
> 2.34.1
>
