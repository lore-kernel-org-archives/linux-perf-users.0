Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF18EB64D7
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jun 2023 14:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239339AbjFMOcj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jun 2023 10:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239503AbjFMOcg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jun 2023 10:32:36 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E336910DF
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 07:32:35 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3f9a81da5d7so275601cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 07:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686666755; x=1689258755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgA0U3fcXLO09nUq6Bh7i/uxRkOL4cjX/1rROB80A0w=;
        b=mcGFITAdOp9frxmId5Wo4/B0nkkTQCphpVWWNrB4ZKbz2+sBpeE2qW37KukRzAz/KV
         ez0IVAdS75MXGbaZSdAPHx5sfhzbpX43SfhKsE484sdEwny5His6UbtxaWucvOBeMOr/
         MrIKsk2lTIjBn0fIOYiFZog4+Vj0PwIAa09ong/w857KRAtNc9Dia4MDmba2XIavY8OO
         oK8cikv67fVzXulhDfhnDjw9m09h9B0JeMUPRaAL7fugRqxeRAjq32rRVtTdEFc/rrU8
         WGHubIDA3ge5VDyP2BjGC1Gv2ekGkQZWndZo1FpbT0TAmjyXYi3pql5EKP2v1w2lSsus
         /U4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686666755; x=1689258755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgA0U3fcXLO09nUq6Bh7i/uxRkOL4cjX/1rROB80A0w=;
        b=RKqnSnvNC3+/fULV80QyonLNew9ScH8OGu/HwPhE8GKlZhSk+StfYycmwSdg2hyOxk
         HZP0CddWHRdZoiZJa97zo43EmtMVaPs4/n1RoRbB9QTGO4FH79rXlPyHhEvEo9luGvob
         7dAh35te163ZY3cFsR2cW/hTot51RCrKICXqkFea487CxLz++QMK3WduUxmAwsEwpzeF
         sK6r3F2LFRgufG16g0PALUW3WfH9gTE9uJ8lLiIUu+CwQECWNZdcOK1uYVewwnEVfpBy
         7t3w55TuFOz1gcNH75e8mHjOolznmi0qiSV+UWnIqEJoNvfguHy8ieKmFRGvgS/jQOBY
         VeCg==
X-Gm-Message-State: AC+VfDyjaTETlnPqt1KLBZqkBR9hwH2k9HAnZSabXf+yNOuHnVy5QgFO
        9zZH76ZZpvN5R0i/eJ/jM9f5I507NQWRX4+uKG/iRA==
X-Google-Smtp-Source: ACHHUZ57Ql819/aDmADNqMG9arff48RkJJt6B6vGjlUz8yFSTNj6NiYTrQOX0e4Dl773i3qKHzx9OqOGrJG36DDUgVY=
X-Received: by 2002:a05:622a:46:b0:3f9:b8c2:f2d3 with SMTP id
 y6-20020a05622a004600b003f9b8c2f2d3mr85002qtw.19.1686666754907; Tue, 13 Jun
 2023 07:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <d5319870-7569-c353-1777-31ee090f8da8@linux.ibm.com>
In-Reply-To: <d5319870-7569-c353-1777-31ee090f8da8@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 13 Jun 2023 07:32:23 -0700
Message-ID: <CAP-5=fU+0VXckQiq3E8yqaySNZ+-DDZahEd1OY0uKPWnfFsafg@mail.gmail.com>
Subject: Re: perf test failures in linux-next on s390
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jun 13, 2023 at 5:54=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Hi all,
>
> I have run the perf test suite on the current 6.4rc6 kernel and see just =
one error:
> # ./perf test 2>&1 | fgrep FAILED
> fgrep: warning: fgrep is obsolescent; using grep -F
>  42.3: BPF prologue generation                                       : FA=
ILED!
> #
>
> However when I download the linux-next tree and build kernel and perf
> tool with the same kernel config file, I get a bunch of failing test case=
s,
> many with perf tool dumping core:
>
> # perf test 2>&1 | fgrep FAILED
> fgrep: warning: fgrep is obsolescent; using grep -F
>   6.1: Test event parsing                                            : FA=
ILED!
>  10.3: Parsing of PMU event table metrics                            : FA=
ILED!
>  10.4: Parsing of PMU event table metrics with fake PMUs             : FA=
ILED!
>  17: Setup struct perf_event_attr                                    : FA=
ILED!
>  24: Number of exit events of a simple workload                      : FA=
ILED! core-dump
>  28: Use a dummy software event to keep tracking                     : FA=
ILED!
>  35: Track with sched_switch                                         : FA=
ILED!
>  42.3: BPF prologue generation                                       : FA=
ILED!
>  66: Parse and process metrics                                       : FA=
ILED!
>  68: Event expansion for cgroups                                     : FA=
ILED!
>  69.2: Perf time to TSC                                              : FA=
ILED! core-dump
>  74: build id cache operations                                       : FA=
ILED! core-dump
>  81: kernel lock contention analysis test                            : FA=
ILED!
>  86: Zstd perf.data compression/decompression                        : FA=
ILED! core-dump
>  87: perf record tests                                               : FA=
ILED! core-dump
>  94: perf all metricgroups test                                      : FA=
ILED!
>  95: perf all metrics test                                           : FA=
ILED!
> 106: Test java symbol                                                : FA=
ILED! core-dump
> #
>
> I am afraid this will show up pretty soon in the linux tree.
> I am going to look into each failure in the next few days.
>
> What I already found out is that many test cases now fail due to the
> event/PMU rework, here is one example:
>
> # perf test -Fvvvv 95
> 95: perf all metrics test
> --- start ---
> Testing cpi
> ....
> Metric 'transaction' not printed in:
> Error:
> The TX_NC_TABORT event is not supported.
> ---- end ----
> perf all metrics test: FAILED!
> # ls -l /sys/devices/cpum_cf/events/TX_NC_TABORT
> -r--r--r--. 1 root root 4096 Jun 13 13:49 /sys/devices/cpum_cf/events/TX_=
NC_TABORT
> #
>
> As can be seen, the event is definitely there and supported.
> This same test case succeeds in the linux tree!
>
> Hopefully I can sort out some of the failures before this code show up
> in the linux tree.

Thanks Thomas, to be clear this is what is in
perf-tools-next/linux-next and not 6.4?

Rather than try to do more complicated cases like the metrics tests,
it makes sense to dig into why event parsing is failing. Test 6 first
of all, could you give output?

Thanks,
Ian

> --
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, German=
y
> --
> Vorsitzender des Aufsichtsrats: Gregor Pillen
> Gesch=C3=A4ftsf=C3=BChrung: David Faller
> Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stut=
tgart, HRB 243294
