Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8859CC43334
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Jun 2022 19:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350445AbiFOTRj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 15 Jun 2022 15:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346668AbiFOTRh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Jun 2022 15:17:37 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58FD1110
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jun 2022 12:17:29 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r123-20020a1c2b81000000b0039c1439c33cso1624183wmr.5
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jun 2022 12:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WokeiGFGpeZIK2Bw3DWQuKUULhCXjqLrynqg7U/lT60=;
        b=SR8MV78tyhTMqw+44nI1gbqZe6tkNSi0Rj7xc12dy+aizdKo3M5SAdht6mLxut5shN
         yx4N0cCwcXfCJ2W9DeH4ssJk+4gaeSzqg4GjzBg3eBikbvCDLQip6xFEb1q6wpps5oyC
         pvJw/tFvV2byPErT+TjA0SB3wbN0HTwTMhaOjSO9kQurO/JeIaUTCHr6cyzVMttjW4+a
         0WOci7LewHadYExXZp28c0T0MmPQnP6YXMEY9iuTf6QF8eCzETrwZ//jWdwItKsHGMLI
         sFAc3eMHO1whjw6ocS6rCUqlbWo6hGqBCcmfSXAO97qKq2V+nDC+bfioo46K+clSCKL8
         QuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WokeiGFGpeZIK2Bw3DWQuKUULhCXjqLrynqg7U/lT60=;
        b=hGhRf7Xfzd0BDsDXeuRS8neHjzKToNYV6w38CDCCCeEDTojkpLRRnD0bpXIDg3OfCB
         /l9wVGewXrmbw9nDFvTuHvmB7NZDI0der034V4rBt9xeJBGyXEYGOMWGrO8Ee3jpFKKj
         KTW7jKVgBeBmVTH7aG9xu5Bl68teDeaaSHUMcPS0EdGH3NDeQ9VpnxJBtVmS7RiVkHmZ
         ipWkG5NwJyO61za0GvYtB8i2SJ7Nq9D1ilMGXGB2YAqEN3eJW3wnzCttmWOfXQRthskq
         TvpT7fUaOFkXyCsU44n+Cwk9Y2kRZmMEDLzXwNg4KpfJw8nYIFhT80vy1/O1ciTJME19
         zzAw==
X-Gm-Message-State: AOAM533bOdmZVeDq0D4hwt85siSc7EZLCLmzpbQs/aG4APAolapVds5B
        0WzAErLw1fcCGWuiSGIHbH0POIrmI7EPnVuullpkTA==
X-Google-Smtp-Source: ABdhPJworp9viXk/WHpCD25DR2nT7xNLuW+tVK3iCexh5gH5SOr+pUYNSn3Nx4OlVezubrtNQXnSxfYBfOgGsx/+yZQ=
X-Received: by 2002:a05:600c:19cb:b0:397:51db:446f with SMTP id
 u11-20020a05600c19cb00b0039751db446fmr11655881wmq.182.1655320647665; Wed, 15
 Jun 2022 12:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220615060354.1763693-1-irogers@google.com> <11db049c-c288-71c2-de37-545fd695d486@linux.intel.com>
In-Reply-To: <11db049c-c288-71c2-de37-545fd695d486@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 15 Jun 2022 12:17:15 -0700
Message-ID: <CAP-5=fVAUGMENJhD9d7VA9TbO1JOLJhisDPymJZgW0zr7WDXNA@mail.gmail.com>
Subject: Re: [PATCH] perf io: Make open and read calls more robust
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Song Liu <songliubraving@fb.com>, Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Kan Liang <kan.liang@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        German Gomez <german.gomez@arm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Denis Nikitin <denik@chromium.org>,
        Lexi Shao <shaolexi@huawei.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 15, 2022 at 11:47 AM Andi Kleen <ak@linux.intel.com> wrote:
>
>
> On 6/14/2022 11:03 PM, Ian Rogers wrote:
> > Wrap open and read calls with TEMP_FAILURE_RETRY in case a signal
> > causes the syscall to need to restart.
>
>
> Why not just use SA_RESTART on the signals?

As explained to Adrian, existing code is EINTR tolerant, some of the
code is in libraries and for portability shouldn't assume SA_RESTART.

Thanks,
Ian

>
> -Andi
>
