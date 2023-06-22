Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EAFEB64DA
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Jun 2023 20:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjFVUQM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Jun 2023 16:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjFVUQJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Jun 2023 16:16:09 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877AC1BD8
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 13:16:08 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-34226590ee3so7545ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 13:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687464968; x=1690056968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ndSESnZMFYkYPDEn66wgCGr7IXAPY2WvDwHzTYhmrs=;
        b=4u4yphPMiVvS5/NimTTl1rMnVS+aGEmJHP/hM3xvWBmkU5/26RJ2V3uhNfRXq4BIJe
         em89zVtHOvSRI6I9q2PnzPLb5mHtsU6gUfJgBAtZ9fV91IR7FWGU56IWktlwL75+KJQI
         vnekLdvpDNsIZlqAWC4UfrSMwGIIOuytfkGFvYoDUSb2j6eaC2FrDYFwMxYCq7a7CXHc
         Q4nO7fLI4UmaiW0kKkksqveIpRDKk/bbi6X2lBXV37uFZLPbDieg2aXBnUM90bjVFWGM
         NxDE73UUadeFZJqsO5qfqzASDBzp5DtvFg6dH9YORHtDmjPWuQe6b+u++zi8/biAcQPP
         n12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687464968; x=1690056968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ndSESnZMFYkYPDEn66wgCGr7IXAPY2WvDwHzTYhmrs=;
        b=P5nRpNXvufb4Da4sz1MU6a9y8jYvSMLSotvJCNXO9OEDqoxY2i0TOfhjAz3BXfLq7l
         xZ4Xwu1D/UbWsoNwU5WKWOq5p+TLqGE3n7J9jTRCV92AtPljqR5rDwTIE7ifYhTs+V4f
         2H/x0YZRHJCpOUgZaXOG8cp8jhB254nwOGYVzcuSCZE4ZRyUTNGSI7JPuHjhsM8nQG0T
         EMeiy9LP+ayn1WhhlWsYnqLuCdheAlCmNfXN/LSzqgN6FZnMgvIyA9u89OIfljQy0yf3
         SUxTqqoB9OdovYyPQ+Aqhnk/kCcL1lM3sgZG8R+3Obh4c6vC4Q48GtgbDofN+0C5c/Qo
         8OQw==
X-Gm-Message-State: AC+VfDwA2nVNcZUxRNNJXu3VMcTpUPjmJW1FMNVQAAX/+gF8dHKVq/YK
        c/QVjwo6zGi/xLxC7gg2vlyaQEdwgcES0yFtQ81a3Q==
X-Google-Smtp-Source: ACHHUZ4W1uxazXdHpuaM6rYloWnm0IMXN3slT639cb6qSDX9+8ht1I4wfyE/AyA5TndXhReH3GpB5oOyvpE7VhOfXjk=
X-Received: by 2002:a05:6e02:174a:b0:335:e50d:9b11 with SMTP id
 y10-20020a056e02174a00b00335e50d9b11mr2157242ill.7.1687464967796; Thu, 22 Jun
 2023 13:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAM9d7cgmHuhv1U6yAB-2qUr8SuFjUd-Lqw0kew9MaBVeD8xxGw@mail.gmail.com>
In-Reply-To: <CAM9d7cgmHuhv1U6yAB-2qUr8SuFjUd-Lqw0kew9MaBVeD8xxGw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 22 Jun 2023 13:15:56 -0700
Message-ID: <CAP-5=fXFBpaN+ajF+u6GAL-3bb9LPR=dwevB_-7N7uUh-c3SPw@mail.gmail.com>
Subject: Re: perf-tools-next: Request for testing hybrid changes
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>, Mike Leach <mike.leach@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Namhyung Kim <namhyung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 22, 2023 at 11:57=E2=80=AFAM Namhyung Kim <namhyung@gmail.com> =
wrote:
>
> Hello,
>
> In this development cycle, we've got a big change in how to handle
> heterogeneous core PMUs. It's mostly tested on Intel hybrid machines
> but caused some troubles on others.  So I'd like to confirm it works
> on major platforms without problems.  Especially on ARM64 as it has
> the big.LITTLE CPUs.


Thanks Namhyung. I believe there is a change on ARM64 that makes a
problem of one type into a slightly different problem. The perf parse
events logic handles events certain known hardware events using known
numeric encodings, for example, the cycles event has a type of 0
(PERF_TYPE_HARDWARE) and a config of 0 (PERF_COUNT_HW_CPU_CYCLES):
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/parse-events.l?h=3Dperf-tools-next#n286

The perf_event_open syscall can specify a CPU number of -1 for any. My
understanding is that -1 on ARM translates into choose the PMU of the
current running thread, this means that if a thread migrates from
between core/PMU types it won't be recorded on the alternate PMU type.

The extended type capability (PERF_PMU_CAP_EXTENDED_HW_TYPE) solves
this, but appears not to be set on ARM's PMU:
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/drivers/pe=
rf/arm-cmn.c#n2291
Could an ARM64 related person fix this?

The perf tool is expecting it to be supported and so it tries to open
the event for each core PMU, so the cycles event will open for each of
a BIG.little PMU, however, as the extended type isn't supported the
same event will be opened twice and the migration problem still
exists. This problem exists for all PERF_TYPE_HARDWARE events (10) and
all PERF_TYPE_HW_CACHE events (42).

Assuming the capability issue is fixed, there is still an open issue
about how to properly support these 52 events on older kernels. It
would be possible to use the architecture standard events, so cycles
can map to cpu_cycles, instructions to sw_incr, cache-references to
l1d_cache (probably), etc. I'm not sure this will work for all 52
events and the plumbing in the perf tool isn't straightforward.
There's also the question of whether such a change of events should
happen when we know the perf_event_open will be given a CPU, should
that case not wildcard PMUs?

I'm happy to provide more context/details.

Thanks,
Ian

> Also we are transitioning from Arnaldo's tree to new repositories in
> git.kernel.org:
>
>  * kernel/git/perf/perf-tools (for the fixes on the current dev cycle)
>  * kernel/git/perf/perf-tools-next (for new features for the next cycle)
>
> There is a branch with the same name.  Please check out
> perf-tools-next and play with it.
>
> Thanks,
> Namhyung
