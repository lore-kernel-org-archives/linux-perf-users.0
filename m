Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD67C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 May 2022 04:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbiESEIr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 May 2022 00:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbiESEIq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 May 2022 00:08:46 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC58AFB1B
        for <linux-perf-users@vger.kernel.org>; Wed, 18 May 2022 21:08:45 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id f9so7599589ejc.0
        for <linux-perf-users@vger.kernel.org>; Wed, 18 May 2022 21:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5NuTN6+F3TBVlFzEcXPbTfTSxJJpUOQDs3Y2ry8Jne0=;
        b=mH2llISZenMBvGXANBcqE5aANz8QcBamzb+hFox7K8HGfGN/weV2lCOdRhy/dPSPCO
         3z3OXGaMdfYxtwPSOduMuc2kYwvHrLSKBpcUhlgW/stCQzC8NPyYNDO4cyA5T+OKPuZJ
         CNaR8UiojwlJ2MMZAzLARljH+2A8OblwDbaYp1A9Wx9X4vKuojYxUiIRq8DFS304i8vY
         OIWojYSH/2ofFVTbXBTf4UCB/WSc2ZBN0ChjfqUviwzjZQ8mgrXmc90Moy/N/t+I4OVq
         uhQY3n4xH35mgxMEGit9nVTDO3hZxN4FBSJeyOlKz9iguRPkWU2X9KiTd2YgCn0aNvKt
         1ZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5NuTN6+F3TBVlFzEcXPbTfTSxJJpUOQDs3Y2ry8Jne0=;
        b=E+vs0AR9Xj5lMeQb4XIoPRSJVYC00HTYnagVpcJ/45Ml1I6YWf0syEsgsdEsXYVvs7
         gij9xODSP3IAci9SLS+PDJyHzLKpuPxLgfc146h6XtzAHWWPKPFpeBHJ/g7u5gykrYKd
         N3hbxgd67Y2q3qTE0ZiLqSXfYN3jER8oCYn/VMLkgj0CwQQwZeMHuzgXa19Bfmg8Uj1y
         4J6kUxR5E/8JSiF54/drVV+xIBqOGhchKdTx6jj0l0JtmJD6KOkXOk68hKntgR2hnve1
         /QAHuHOEcyUdE90aJfZCbEhD3R+qh1jUlC3aqF84WN0S1WyM938zJ98zrrzwcAgG7qnc
         Np/g==
X-Gm-Message-State: AOAM531x9A5TlW9mUL2vmjUCrNcR2aJ34QWZmWcPkspIebtDNAxEJt03
        GULBDHBxcwatY4eL6XsKSm2Clf2XtZcqtihKlxWhxx1AoFQub42X
X-Google-Smtp-Source: ABdhPJxWnZ/+po2yuf7QTqvUbRYgFyJlL22dsPnz5xfr+cYG0iUXYo+9qOcpeEbzVPemTgXOZyJ3sflpJUuYqb9FRPk=
X-Received: by 2002:a05:6000:78b:b0:20d:101b:2854 with SMTP id
 bu11-20020a056000078b00b0020d101b2854mr2119695wrb.300.1652933313841; Wed, 18
 May 2022 21:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220518224725.742882-1-namhyung@kernel.org> <20220518224725.742882-7-namhyung@kernel.org>
In-Reply-To: <20220518224725.742882-7-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 18 May 2022 21:08:21 -0700
Message-ID: <CAP-5=fWyH=-XDdOsCjLTOHO09vCHnUcnijvVT0mw0zp6Ft57zA@mail.gmail.com>
Subject: Re: [PATCH 6/6] perf test: Add a basic offcpu profiling test
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Milian Wolff <milian.wolff@kdab.com>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, May 18, 2022 at 3:47 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
>   $ sudo ./perf test -v offcpu
>    88: perf record offcpu profiling tests                              :
>   --- start ---
>   test child forked, pid 685966
>   Basic off-cpu test
>   Basic off-cpu test [Success]
>   test child finished with 0
>   ---- end ----
>   perf record offcpu profiling tests: Ok
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/record_offcpu.sh | 60 +++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100755 tools/perf/tests/shell/record_offcpu.sh
>
> diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
> new file mode 100755
> index 000000000000..96e0739f7478
> --- /dev/null
> +++ b/tools/perf/tests/shell/record_offcpu.sh
> @@ -0,0 +1,60 @@
> +#!/bin/sh
> +# perf record offcpu profiling tests
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +err=0
> +perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +
> +cleanup() {
> +  rm -f ${perfdata}
> +  rm -f ${perfdata}.old
> +  trap - exit term int
> +}
> +
> +trap_cleanup() {
> +  cleanup
> +  exit 1
> +}
> +trap trap_cleanup exit term int
> +
> +test_offcpu() {
> +  echo "Basic off-cpu test"
> +  if [ `id -u` != 0 ]
> +  then
> +    echo "Basic off-cpu test [Skipped permission]"
> +    err=2
> +    return
> +  fi
> +  if perf record --off-cpu -o ${perfdata} --quiet true 2>&1 | grep BUILD_BPF_SKEL
> +  then
> +    echo "Basic off-cpu test [Skipped missing BPF support]"
> +    err=2
> +    return
> +  fi
> +  if ! perf record --off-cpu -e dummy -o ${perfdata} sleep 1 2> /dev/null
> +  then
> +    echo "Basic off-cpu test [Failed record]"
> +    err=1
> +    return
> +  fi
> +  if ! perf evlist -i ${perfdata} | grep -q "offcpu-time"
> +  then
> +    echo "Basic off-cpu test [Failed record]"
> +    err=1
> +    return
> +  fi
> +  if ! perf report -i ${perfdata} -q --percent-limit=90 | egrep -q sleep
> +  then
> +    echo "Basic off-cpu test [Failed missing output]"
> +    err=1
> +    return
> +  fi
> +  echo "Basic off-cpu test [Success]"
> +}
> +
> +test_offcpu
> +
> +cleanup
> +exit $err
> --
> 2.36.1.124.g0e6072fb45-goog
>
