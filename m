Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32E1C352A1
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Dec 2022 06:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiLGGHL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Dec 2022 01:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLGGHK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Dec 2022 01:07:10 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CEC578F8
        for <linux-perf-users@vger.kernel.org>; Tue,  6 Dec 2022 22:07:08 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id w15so26583824wrl.9
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Dec 2022 22:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1NNlelo+bGXhdIW+f+uuoPKsjyd+V452C21PX0TjzD4=;
        b=g0Lb24cqACkLATTe+DrUsuaUC7i6XnCefnPMQGxoVYyF5A3kBch4ow7tJNoDtGGdUQ
         WHL2//34SZwyrMOQaM3fxHfpUQ+h4Ln5D1Cb1N3exJ6yHuihEHraULmXJeVhdxPo7OvV
         cIV5xo1JYwjWAG4nKAWH98k1MU66y3JNfOiOOti8NDw3qvmBG9lF8qIYRYPuFveK9Va0
         auZZv3rAd1kpd8d6ZmxRB+at8Yyf9B7kxwInqyZ2nshcCrz4wIJK02lB0YHld6WmsePd
         T/BPiack3QobARw9ZIZS2qBvGc6tcSXuUVCuEFVqiQU2mqKz4mG6z9bV0REHPu3PcL6A
         5RVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1NNlelo+bGXhdIW+f+uuoPKsjyd+V452C21PX0TjzD4=;
        b=WZWHe4GXL2inNEihZd4JGYnApF0rPvk+aQ7cKWyF+4pdlz/N4vyHY3lgqsdQt0sPaH
         GnijCjEitNjght7hNAmXYA1txgm7reRgoLW7z+0+a7G1aoGSb2j7m72ETRM8vtMakbMW
         6v49qjPzIjjCed19CwDZ1qkyUdUfWtFMQnTAkKBMiAJOwXdS5I91SELPsjwT1MRp5t1+
         uA5N2BS70ePnUvPLrI/PPgkYXx/LP3AY9upgXk2P4ZIY57KFaQBeaX68CxnWbK0WsqUA
         H+xUufgL/ItsyGamKPe20KRklBhypWnEHJePdkjEOiAYOyxi6qO62iQQuE2Ka3EADy0D
         Cb0w==
X-Gm-Message-State: ANoB5pnfUAs39sRmGlsr5SPSxX9iddf9KNHlaV9MDnkz9de3UhcaFCLH
        u/N067GyA3Wzm7jEI9fVo0toUErUT2/f10MVFYmkAw==
X-Google-Smtp-Source: AA0mqf66E83vyMRKRbuhDE+5gVUOcjX4AEFyQIhIEchTMD0xax9Wn/YSIBRo9yFk3BUgDpDH8il296pATsihbC75nEU=
X-Received: by 2002:adf:f944:0:b0:236:8f54:f1f4 with SMTP id
 q4-20020adff944000000b002368f54f1f4mr55202872wrr.654.1670393227267; Tue, 06
 Dec 2022 22:07:07 -0800 (PST)
MIME-Version: 1.0
References: <20221207053007.336806-1-sandipan.das@amd.com>
In-Reply-To: <20221207053007.336806-1-sandipan.das@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 6 Dec 2022 22:06:55 -0800
Message-ID: <CAP-5=fWhqWfwTwnh5SWiLamXkuZbMnefASxkLByH6a44kdc5Bg@mail.gmail.com>
Subject: Re: [PATCH 0/4] perf vendor events amd: Add Zen 4 events and metrics
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

On Tue, Dec 6, 2022 at 9:30 PM Sandipan Das <sandipan.das@amd.com> wrote:
>
> Add events and metrics taken from the Processor Programming Reference
> (PPR) for AMD Family 19h Model 11h Revision B1 processors which can be
> found at: https://www.amd.com/system/files/TechDocs/55901_0.25.zip
>
> Sandipan Das (4):
>   perf vendor events amd: Add Zen 4 mapping

Adding the mapping first may break the build until the core events are added.

Thanks,
Ian

>   perf vendor events amd: Add Zen 4 core events
>   perf vendor events amd: Add Zen 4 uncore events
>   perf vendor events amd: Add Zen 4 metrics
>
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
