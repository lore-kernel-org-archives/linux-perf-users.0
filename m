Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A894C77B6C
	for <linux-perf-users@archiver.kernel.org>; Fri,  7 Apr 2023 00:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjDGAfS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 Apr 2023 20:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjDGAfQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Apr 2023 20:35:16 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F7076AB
        for <linux-perf-users@vger.kernel.org>; Thu,  6 Apr 2023 17:35:15 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f04275b2bdso117835e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Apr 2023 17:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680827713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8Q2jvhhsq0jTISohZsQPBv5EsX8yPMuWu0983f4Bdg=;
        b=ZDpIIiEL3/ETi2ZAQ7vAHpfapUibPpC/YOPyHnreZsruz/1m1StFrYlWX4Xsm1RKBB
         faI9zwVXvjuksZS8NoglrMd1A++NF1I6DEv2Lcik0VSpqeQzHtQvlkSNYAyqgXGmPSQI
         jdpe/0Ws/rb4ilD513+ZsfB6e2nroBYwMoa2lk6TSR51SNebLhqJX57+be3Rt4lBwnz7
         r6c4qqSUxcHY1xALy189Yc5OlZmqaIISq67dAtk496DSN+MqkW76QzFHssD+O82VHBr4
         DP3j5V3JZ0vA8OJrXt8Kr+gFIBcYQGsx3lw1kAUgq41lW8dT/5bwLtWHz/Q+h+/o/v8K
         AarA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680827713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8Q2jvhhsq0jTISohZsQPBv5EsX8yPMuWu0983f4Bdg=;
        b=V3OwRVOWQAZr7gqvRdaJ7T4JkO8KpI6mvKFEA6uKkPjyQ6w12iR/ZUkLJjQYQK9nuu
         u/jEUMY+PbKCAilGhNW/H9Pgo9zAH/VyA65Sy8VDgwjG6JX7iR4jcOmmSLwh0VlgXop2
         IPaPdo52ukjmF4zulZDOYsJidwdFgTSRcxJ90HGN8VBZoXhDBJQ9KP/kQT5d6QV4M/HQ
         sFNnHgaELDHiZ+9MUcqM2VtrgVouZNAhSx0P+ILYe6Vm4Ec4Dgq1/Isdff0j1Ii1dDC8
         b45Aw9p4VVcGeqie44XAuBx1emTtSo7/dVxs9hOSs+jcqJXvt7craUYF26VzTL50cu1l
         vN6g==
X-Gm-Message-State: AAQBX9flYvnMgnM4RZeGUeehzPisWER1lsNs/OY7yq7PvVintqeLgA/H
        ArHM9l79zmDH5xcfFPBuV3yTTh0oiN4zQxygpXQLmA==
X-Google-Smtp-Source: AKy350b7pyyOm45TmcbEF+/wGNY/fyI3Lb4eliC3gIc3C4Mitjnc649DF+kImyNn/GlA9iJ/8bLLbuN3L0ue+Jr73uw=
X-Received: by 2002:a05:600c:5491:b0:3f0:679e:5b5f with SMTP id
 iv17-20020a05600c549100b003f0679e5b5fmr29667wmb.5.1680827713446; Thu, 06 Apr
 2023 17:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230406210611.1622492-1-namhyung@kernel.org>
In-Reply-To: <20230406210611.1622492-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 6 Apr 2023 17:35:00 -0700
Message-ID: <CAP-5=fXQg_=mv5fJWWQAQ5iBDJHw2TgdPbqawjR2Jx8_EogHkA@mail.gmail.com>
Subject: Re: [PATCHSET 0/7] perf lock contention: Improve performance if map
 is full (v1)
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Apr 6, 2023 at 2:06=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hello,
>
> I got a report that the overhead of perf lock contention is too big in
> some cases.  It was running the task aggregation mode (-t) at the moment
> and there were lots of tasks contending each other.
>
> It turned out that the hash map update is a problem.  The result is saved
> in the lock_stat hash map which is pre-allocated.  The BPF program never
> deletes data in the map, but just adds.  But if the map is full, (try to)
> update the map becomes a very heavy operation - since it needs to check
> every CPU's freelist to get a new node to save the result.  But we know
> it'd fail when the map is full.  No need to update then.
>
> I've checked it on my 64 CPU machine with this.
>
>     $ perf bench sched messaging -g 1000
>     # Running 'sched/messaging' benchmark:
>     # 20 sender and receiver processes per group
>     # 1000 groups =3D=3D 40000 processes run
>
>          Total time: 2.825 [sec]
>
> And I used the task mode, so that it can guarantee the map is full.
> The default map entry size is 16K and this workload has 40K tasks.
>
> Before:
>     $ sudo ./perf lock con -abt -E3 -- perf bench sched messaging -g 1000
>     # Running 'sched/messaging' benchmark:
>     # 20 sender and receiver processes per group
>     # 1000 groups =3D=3D 40000 processes run
>
>          Total time: 11.299 [sec]
>      contended   total wait     max wait     avg wait          pid   comm
>
>          19284      3.51 s       3.70 ms    181.91 us      1305863   sche=
d-messaging
>            243     84.09 ms    466.67 us    346.04 us      1336608   sche=
d-messaging
>            177     66.35 ms     12.08 ms    374.88 us      1220416   node
>
> After:
>     $ sudo ./perf lock con -abt -E3 -- perf bench sched messaging -g 1000
>     # Running 'sched/messaging' benchmark:
>     # 20 sender and receiver processes per group
>     # 1000 groups =3D=3D 40000 processes run
>
>          Total time: 3.044 [sec]
>      contended   total wait     max wait     avg wait          pid   comm
>
>          18743    591.92 ms    442.96 us     31.58 us      1431454   sche=
d-messaging
>             51    210.64 ms    207.45 ms      4.13 ms      1468724   sche=
d-messaging
>             81     68.61 ms     65.79 ms    847.07 us      1463183   sche=
d-messaging
>
>     =3D=3D=3D output for debug =3D=3D=3D
>
>     bad: 1164137, total: 2253341
>     bad rate: 51.66 %
>     histogram of failure reasons
>            task: 0
>           stack: 0
>            time: 0
>            data: 1164137
>
> The first few patches are small cleanups and fixes.  You can get the code
> from 'perf/lock-map-v1' branch in
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>
> Thanks,
> Namhyung
>
> Namhyung Kim (7):
>   perf lock contention: Simplify parse_lock_type()
>   perf lock contention: Use -M for --map-nr-entries
>   perf lock contention: Update default map size to 16384
>   perf lock contention: Add data failure stat
>   perf lock contention: Update total/bad stats for hidden entries
>   perf lock contention: Revise needs_callstack() condition
>   perf lock contention: Do not try to update if hash map is full

Series:
Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  tools/perf/Documentation/perf-lock.txt        |  4 +-
>  tools/perf/builtin-lock.c                     | 64 ++++++++-----------
>  tools/perf/util/bpf_lock_contention.c         |  7 +-
>  .../perf/util/bpf_skel/lock_contention.bpf.c  | 29 +++++++--
>  tools/perf/util/bpf_skel/lock_data.h          |  3 +
>  tools/perf/util/lock-contention.h             |  2 +
>  6 files changed, 60 insertions(+), 49 deletions(-)
>
>
> base-commit: e5116f46d44b72ede59a6923829f68a8b8f84e76
> --
> 2.40.0.577.gac1e443424-goog
>
