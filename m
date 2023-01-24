Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517C5C54E94
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Jan 2023 04:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbjAXEtj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 23 Jan 2023 23:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjAXEti (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 Jan 2023 23:49:38 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670743756C
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Jan 2023 20:49:37 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q5so8043630wrv.0
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Jan 2023 20:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DK6xaXE5oASyoDQtrld9FdvxBPYhIcRWULm9bEl36oc=;
        b=TwUkV4fDTn80NzdblDeqyIin7jJkGsyJZv9xSAjsM0BiUikLoxf1xGH8bY9R2rjHPk
         a4+Z3X4imr2ZpgYOMcxQWc0tsIhOYrT/y9aPK2Kzln2qjuB7zdGgCJMZQVTAbp00F+5V
         cAUDa1iXdcq13wWfbGtPGluLFs0fxCsTkvDpqJsYQAOD+zLvQZifMxj9JAKYIDbYetGC
         v4mKhvfMnTL3WsdDqv0tvPZyF9ePAUTW567psXo1g2Sk/ZyGTbaxsNA+GQoTzB+fmZgj
         vZPjxPitfgtSYrthW9g4vF67tPEG+JQdG6XsutwsBFSgKY9U+L5ACvzJLIZ9GYkh4Rss
         LU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DK6xaXE5oASyoDQtrld9FdvxBPYhIcRWULm9bEl36oc=;
        b=IOV5mGyBJXQCq8Bu7apdSoxuagJOwEqjzGdmDWleuW7O7oEqtwUO9pTl9IigjgtCMb
         Fp8RSQoYAsmKG4l8ERXWQfXE3gtyCBP58iFohLC5q6RCHTTuWrlixk/3Wfd74uS+Z/q+
         Q4RPFMJKb++ISB4ALoOfHkdOZGCBqBWir9xQvWx7SDNW0fTXhhL3IySvdTQpaM14AZso
         1dYvumaNoho/PxPyVTcI+hRW6ac3PGlqNnhstC/U3anz3wrNxetWbEcix6gAb+5xTVQk
         7c6MqIQD5QYdNKALMjtL4f70vobccOLaKdUZxPCYdJ9kgTfLFlQQw4QOXO9PPbHWz4WQ
         nhxA==
X-Gm-Message-State: AFqh2koOZaC1equ97ig8bTtYNMcgTx/U0cT/z1BqE0WzGmjzM9YMbz08
        PYg9Ph+PENppWCNKWx3ttDP6py4ezLDDAPsk3oB2hQ==
X-Google-Smtp-Source: AMrXdXunWqevhFj8/tiwX31/k0NTL79Bsn3aXdolVljl3gNlXwKl2/xgYzhiUMRWVNro/K9uQqDGitK/0NB1Ie/+DpM=
X-Received: by 2002:a05:6000:1d9b:b0:2bc:aa47:bf7a with SMTP id
 bk27-20020a0560001d9b00b002bcaa47bf7amr674533wrb.343.1674535775796; Mon, 23
 Jan 2023 20:49:35 -0800 (PST)
MIME-Version: 1.0
References: <20221221223420.2157113-1-irogers@google.com> <20221221223420.2157113-9-irogers@google.com>
 <f5d0e9f0-7076-07f5-483b-57eaee26ff3f@oracle.com>
In-Reply-To: <f5d0e9f0-7076-07f5-483b-57eaee26ff3f@oracle.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 23 Jan 2023 20:49:23 -0800
Message-ID: <CAP-5=fUmvgL77itaxQo15ptUo78s8yW39=rwq80ESsqVm5bG1A@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] perf jevents: Generate metrics and events as
 separate tables
To:     John Garry <john.g.garry@oracle.com>
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Kajol Jain <kjain@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jan 23, 2023 at 7:18 AM John Garry <john.g.garry@oracle.com> wrote:
>
> On 21/12/2022 22:34, Ian Rogers wrote:
> > Turn a perf json event into an event, metric or both. This reduces the
> > number of events needed to scan to find an event or metric. As events
> > no longer need the relatively seldom used metric fields, 4 bytes is
> > saved per event. This reduces the big C string's size by 335kb (14.8%)
> > on x86.
> >
> > Signed-off-by: Ian Rogers<irogers@google.com>
>
> It would have been good to show an example of how the output changes. I
> could not apply the series (see cover), and knowing what to expect makes
> reviewing the code easier...
>
> Thanks,
> John

Thanks, will add in v3.

Ian
