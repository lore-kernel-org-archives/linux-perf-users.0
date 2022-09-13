Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AF4ECAAD8
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Sep 2022 18:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbiIMSZB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Sep 2022 14:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbiIMSYh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Sep 2022 14:24:37 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A824A0633;
        Tue, 13 Sep 2022 10:41:24 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-127dca21a7dso34090676fac.12;
        Tue, 13 Sep 2022 10:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ouMbQCiJ8o7uagqJFfLrjLguYpNwn8+ookhl1rvVBkU=;
        b=m3TbBvhw5tYkNrx24UDW1/AiLPRTCn+blgl++qXVkZn9VSS+p03iEHPASC6pkRH27G
         19cDgXg5OZtqOPlehhS9VWAe79p81N1cXhEMV80YYkkqwGR/101jsyGxtFb0EK0nb8Ha
         QTcV8o3LD60ZhE3/rokiL+yuIrUpzuAPNqbB3hvjZINZ8IT48ayGXKcWg/S9uNA3gRj3
         Xh2I+y+skvskZbRrpVrcL1tSwt+PKs6bwaejflr/RKdyI8I0PXOdaICU+EtgGraNa/X5
         IOrzBOkrYQu4Z6Jf1dhx+euYM3BrcHi86qO/ONtjzWCtmMwPXh8OwvJ1tmYkJIljXQdW
         ttuQ==
X-Gm-Message-State: ACgBeo1ok96PYDbLx6taT52cP732IgwgYfNs9R6PhhWnpiYooTeo5nzq
        C/vqBdGpgx6JYi2JYqPEg65UW23tzz44Nckc/8c=
X-Google-Smtp-Source: AA6agR7YRaEeSxYUvUBoRGMZcDxwAoxcnDXceeGD8w2gnuzPStkZwoqZxTifsgCxvFNLicNfE/PHScxLejxSFjcZuZQ=
X-Received: by 2002:a05:6870:65a3:b0:127:6f4:8b0c with SMTP id
 fp35-20020a05687065a300b0012706f48b0cmr217214oab.271.1663090881116; Tue, 13
 Sep 2022 10:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220912083412.7058-1-adrian.hunter@intel.com>
In-Reply-To: <20220912083412.7058-1-adrian.hunter@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 13 Sep 2022 10:41:09 -0700
Message-ID: <CAM9d7ciRCnpNjOfoEbO27pNk28ddjg1vVdgrZtvWQ-mbD7jg0w@mail.gmail.com>
Subject: Re: [PATCH 00/11] perf test: test_intel_pt.sh: Add per-thread test
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Sep 12, 2022 at 1:34 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Hi
>
> Here is a new per-thread test for the test_intel_pt.sh test script.
>
> The first 9 patches are tidy-ups for the script, mostly based on results
> from the shellcheck utility.
>
> The 10th patch adds debug prints that the script will capture to help
> verify correct operation.
>
> The final patch actually adds the new test.
>
>
> Adrian Hunter (11):
>       perf test: test_intel_pt.sh: Add cleanup function
>       perf test: test_intel_pt.sh: Use a temp directory
>       perf test: test_intel_pt.sh: Fix redirection
>       perf test: test_intel_pt.sh: Stop using expr
>       perf test: test_intel_pt.sh: Stop using backticks
>       perf test: test_intel_pt.sh: Use grep -c instead of grep plus wc -l
>       perf test: test_intel_pt.sh: Use quotes around variable expansion
>       perf test: test_intel_pt.sh: Fix return checking
>       perf test: test_intel_pt.sh: Add more output in preparation for more tests
>       perf tools: Add debug messages and comments for testing
>       perf test: test_intel_pt.sh: Add per-thread test

I don't think I understood all the black magic in patch 11. :)
At least we can move some helper functions to the lib and
reuse them in other tests.  I'll test that later..

So for patch 01-10,

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


>
>  tools/lib/perf/evlist.c                 |   2 +
>  tools/perf/builtin-record.c             |   8 +
>  tools/perf/tests/shell/test_intel_pt.sh | 307 ++++++++++++++++++++++++++++++--
>  tools/perf/util/evsel.c                 |   2 +
>  4 files changed, 304 insertions(+), 15 deletions(-)
>
>
> Regards
> Adrian
