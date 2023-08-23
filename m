Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43341C3DA66
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Aug 2023 23:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238772AbjHWXeQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Aug 2023 19:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238834AbjHWXds (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Aug 2023 19:33:48 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2C510E3
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 16:33:45 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40c72caec5cso140331cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 16:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692833625; x=1693438425;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1HwbLZ/6UV9m41vB7ZrxTzft0HTfsy78CUD/KThJ0A=;
        b=xeuxGL/9dKhoAvf3Mz/shV3SUeCL0DPU8983yQ+TyZcBbh9hio4DVLuI48wY3MMXag
         ztnyAZ0F68Vka1gZozNY3TIQNB7Hgk2lSjUna4ynNwCkgjCPUhYqbQu0k3aQwbwqbAoG
         /rwBYj9OtyzeJj9sQcvtAZhYlZGp6OTBkHpYN1wuvVNugRSg70bh+pA4+N2ACyN6UC60
         sDreUwL+PJwg/b5zEw/ZvbD3/aiRlhpyjLFrKXyCrcJS3FswUrpZnMQJGdiAIAiQJ+6B
         uDd2xKzvyMf8TwNNmTtW7gkeY5LDUueW+SekFqO6FWqLbTNVkLefGpv+ntwZrjDfjA7W
         pVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692833625; x=1693438425;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1HwbLZ/6UV9m41vB7ZrxTzft0HTfsy78CUD/KThJ0A=;
        b=Ln4BaVJ3fIPeREju4pg5OzmOYbTztEsJH7ABVKMouXBPUPkE2CgBed+9KXkTgAt4eo
         YtCKSYO2a6LFbMLt13Wy3k4NmWzGxjkz35AFPc1wjSCaY2f/Zltu4Jx8GglQHZziJal9
         AVMNoxRqh6XjCV/Z4e1vbdfHWo0dOlZ7LMCQN8C3QMWs4cVXFNJbxSWoha3vXWsDFmoM
         zVrNwTRab4XEhCs/THkT5P22DqH8pr+TOO4/eVo3ylLyJV40b64njZHSqSasvBrnOKNu
         rby5kUdgjAn9O9sYtysnqVnwgeabb7DTETxFwoP56tbN3hDDH9U6y+vwpm14xwmDPPG3
         /2Yg==
X-Gm-Message-State: AOJu0YwOT9+F47vPoGKz35ULCRqYUTtKEYYsfoJLimm0TLKxQXEhVRrP
        NufwYpfJ2ehMq7YzUGcHoZ4nqhiCTcfryy57UU8VJg==
X-Google-Smtp-Source: AGHT+IGhV/FfTJmHqD/C1LVCF6/AF9o56MKA5cHfS07QQtJwi6EHjelrKHAQmmucd9xYKxUW7Sj4CFAc2Q4N3gsIkoU=
X-Received: by 2002:a05:622a:1746:b0:410:8ba3:21c7 with SMTP id
 l6-20020a05622a174600b004108ba321c7mr666485qtk.18.1692833624856; Wed, 23 Aug
 2023 16:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230814163757.3077138-1-irogers@google.com>
In-Reply-To: <20230814163757.3077138-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Aug 2023 16:33:33 -0700
Message-ID: <CAP-5=fVCxjQei-Jcg5OmOR2LTN2QwCqmmy=xixCamS0RsBtGOw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] perf list: Remove duplicate PMUs
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Aug 14, 2023 at 9:38=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> When there are multiple PMUs, differing by ordered suffixes, by
> default only display one. This avoids repeated listing of events, in
> particular when there are 10s of uncore PMUs. If "-v" is passed to
> "perf list" then still list all PMUs.
>
> Listing fewer PMU/event combinations helps speed the all PMU event
> tests.
>
> Before:
> ```
> $ perf list
> ...
>   uncore_imc_free_running_0/data_read/               [Kernel PMU event]
>   uncore_imc_free_running_0/data_total/              [Kernel PMU event]
>   uncore_imc_free_running_0/data_write/              [Kernel PMU event]
>   uncore_imc_free_running_1/data_read/               [Kernel PMU event]
>   uncore_imc_free_running_1/data_total/              [Kernel PMU event]
>   uncore_imc_free_running_1/data_write/              [Kernel PMU event]
> ```
>
> After:
> ```
> $ perf list
> ...
>   uncore_imc_free_running/data_read/                 [Kernel PMU event]
>   uncore_imc_free_running/data_total/                [Kernel PMU event]
>   uncore_imc_free_running/data_write/                [Kernel PMU event]
> ...
> $ perf list -v
> ...
>   uncore_imc_free_running_0/data_read/               [Kernel PMU event]
>   uncore_imc_free_running_0/data_total/              [Kernel PMU event]
>   uncore_imc_free_running_0/data_write/              [Kernel PMU event]
>   uncore_imc_free_running_1/data_read/               [Kernel PMU event]
>   uncore_imc_free_running_1/data_total/              [Kernel PMU event]
>   uncore_imc_free_running_1/data_write/              [Kernel PMU event]
> ...
> ```
>
> The PMUs are sorted by name then suffix as a part of this change.
>
> v3: Add detail to patch 1 sorting commit message about the suffix and
>     why sorting is necessary.
> v2: List all PMUs when "-v" is passed as suggested by John Garry
>     <john.g.garry@oracle.com>.
>
> Ian Rogers (3):
>   perf pmus: Sort pmus by name then suffix
>   perf pmus: Add scan that ignores duplicates, use for perf list
>   perf pmus: Don't print duplicate PMU suffix in list by default

Ping. Thanks,
Ian

>  tools/perf/builtin-list.c      |   8 +++
>  tools/perf/util/pmus.c         | 120 +++++++++++++++++++++++++++++++--
>  tools/perf/util/print-events.h |   1 +
>  3 files changed, 122 insertions(+), 7 deletions(-)
>
> --
> 2.41.0.640.ga95def55d0-goog
>
