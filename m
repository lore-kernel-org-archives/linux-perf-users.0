Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314DDC76196
	for <linux-perf-users@archiver.kernel.org>; Mon,  3 Apr 2023 17:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjDCR2p (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 3 Apr 2023 13:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbjDCR2n (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 3 Apr 2023 13:28:43 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6DA2139
        for <linux-perf-users@vger.kernel.org>; Mon,  3 Apr 2023 10:28:42 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3e632769c5eso827821cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Apr 2023 10:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680542921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kpn/KhpcP085eDxsf1VEIL2CtSKS0wIReF1Y4W2z19c=;
        b=XgJ794ouvra+MVbtDLpmz4jtm+tMYqwW2TkPDR8PKHTT9bEJ3/wRIinznK7/OzP3FV
         AvV9vUfk8ZDAccFM0CznBH32GyrNOElTkjLU2waU3JF+bRR9xGduqeacTjEkfUgf6ol1
         nNq7zhy7D/+ID4L9vy+LHwXIxrFib1M1QsDd8uTZeUcSlMrFcQJBGmCCfVlu39bmzdaU
         422fXqMxcZ/TP/oksICpVJa6gkQrVdi3FLiWZs3UP2+KhgsrRxib6c2GqyfgAXbyRoOf
         9yQSJOCLzhA74esY+LF1K0g4TzDVhDXQ4fp4pqwl1b/dUPq+OzWDKQRE21P8mrWneBmV
         iiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680542921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kpn/KhpcP085eDxsf1VEIL2CtSKS0wIReF1Y4W2z19c=;
        b=ag+6AZhckQb2UQeYWaJ/71hnaWEwLKjS8W1ruL+3sfeaKmQ7KZsnySNJn5+aRmsOZb
         rrkngtPGkpGTaciyZBJJuX0foaXkE55wzL8yjxaZkk/CaIH6lpEEQblyHSHp69XEtgtK
         jO0aDLkmY6ctc0V30g4tKnQg99rpNM/+l8me37JRT4hTqSNSrLF1nmODS3Xk6234KLrG
         BqGQwfE4li3TTrWmmC2LWPLZioejeEXcmxp1soUfjmWkVzrRFAezAo0of9dvJNV5OMeT
         gs+sYDLBmvAtIuApymAMxFtX5dolGs4/FwB0+IA6nmwmzrg4rs9x/LH75bYMBsPU+aM+
         cGhA==
X-Gm-Message-State: AAQBX9cysGljASKxxCvA73ehox4NGP4KXHvt+pgh12rHcKzYMSkxPZZZ
        67qQ4swNOTfO40m7chN+A8bz/0vXVdqd9nP127qUlQ==
X-Google-Smtp-Source: AKy350bniYi5ynkqBSd9hBEWXjYTcJaAliiQRAyJOa7hZawpnpmnboOy31c1b1qsKam08fr/5HXcNydQ9Xt3VtLO+H0=
X-Received: by 2002:a05:622a:1813:b0:3b3:20d8:a84 with SMTP id
 t19-20020a05622a181300b003b320d80a84mr9710qtc.2.1680542921010; Mon, 03 Apr
 2023 10:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230331202949.810326-1-namhyung@kernel.org>
In-Reply-To: <20230331202949.810326-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 3 Apr 2023 10:28:28 -0700
Message-ID: <CAP-5=fWC1v+vsi-qmYXy8VMKXOsscYobucwS3GZw=gycdnAc3w@mail.gmail.com>
Subject: Re: [PATCHSET 0/9] perf tools: Update pmu scan using openat() (v1)
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Mar 31, 2023 at 1:29=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> This patchset changes PMU info scanning on sysfs using openat()
> basically.  I got reports of occasional contention on the
> opening files in sysfs.  While the root cause was a separate
> issue, I discovered some inefficiencies in the perf code.
>
> To scan PMUs, it roughly does something like below:
>
>   dir =3D opendir("/sys/bus/event_source/devices");
>   while (dentry =3D readdir(dir)) {
>     char buf[PATH_MAX];
>
>     snprintf(buf, sizeof(buf), "%s/%s",
>              "/sys/bus/event_source/devices", dentry->d_name);
>     fd =3D open(buf, O_RDONLY);
>     ...
>   }
>
> But this is not good since it needs to copy the string to build the
> absolute pathname, and it makes redundant pathname walk (from the /sys)
> in the kernel unnecessarily.  We can use openat(2) to open the file in
> the given directory.
>
> Add a couple of new helper to return the file descriptor of PMU
> directory so that it can use it with relative paths.
>
>  * perf_pmu__event_source_devices_fd()
>    - returns a fd for the PMU root ("/sys/bus/event_source/devices")
>
>  * perf_pmu__pathname_fd()
>    - returns a fd for "<pmu>/<file>" under the PMU root
>
> Now the above code can be converted something like below:
>
>   dirfd =3D perf_pmu__event_source_devices_fd();
>   dir =3D fdopendir(dirfd);
>   while (dentry =3D readdir(dir)) {
>     fd =3D openat(dirfd, dentry->d_name, O_RDONLY);
>     ...
>   }
>
> I added a benchmark for pmu-scan and it showed a slight speedup
> in the normal case too.
>
>   $ ./perf.old bench internals pmu-scan
>   # Running 'internals/pmu-scan' benchmark:
>   Computing performance of sysfs PMU event scan for 100 times
>     Average PMU scanning took: 6670.970 usec (+- 13.022 usec)
>
>   $ ./perf.new bench internals pmu-scan
>   # Running 'internals/pmu-scan' benchmark:
>   Computing performance of sysfs PMU event scan for 100 times
>     Average PMU scanning took: 6296.980 usec (+- 14.891 usec)
>
> The 5~6% of improvement might be small but it may have bigger impact
> when the system is contended.
>
> You can get the code from 'perf/pmu-scan-v1' branch in
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>
> Thanks,
> Namhyung

Some nice stack size savings too. The reentrant fix was pre-existing. Serie=
s:
Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Namhyung Kim (9):
>   perf list: Use relative path for tracepoint scan
>   perf tools: Fix a asan issue in parse_events_multi_pmu_add()
>   perf pmu: Add perf_pmu__destroy() function
>   perf bench: Add pmu-scan benchmark
>   perf pmu: Use relative path for sysfs scan
>   perf pmu: Use relative path in perf_pmu__caps_parse()
>   perf pmu: Use relative path in setup_pmu_alias_list()
>   perf pmu: Add perf_pmu__{open,scan}_file_at()
>   perf intel-pt: Use perf_pmu__scan_file_at() if possible
>
>  tools/perf/arch/x86/util/intel-pt.c |  52 ++++--
>  tools/perf/arch/x86/util/pmu.c      |  13 +-
>  tools/perf/bench/Build              |   1 +
>  tools/perf/bench/bench.h            |   1 +
>  tools/perf/bench/pmu-scan.c         | 184 ++++++++++++++++++
>  tools/perf/builtin-bench.c          |   1 +
>  tools/perf/tests/pmu.c              |   9 +-
>  tools/perf/util/parse-events.c      |   2 +-
>  tools/perf/util/pmu.c               | 278 ++++++++++++++++++++--------
>  tools/perf/util/pmu.h               |  12 +-
>  tools/perf/util/print-events.c      |  26 ++-
>  11 files changed, 466 insertions(+), 113 deletions(-)
>  create mode 100644 tools/perf/bench/pmu-scan.c
>
>
> base-commit: 417c6adfb155f906f0441cc1034827f6e2b3c372
> --
> 2.40.0.348.gf938b09366-goog
>
