Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E36AC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jul 2022 15:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239156AbiGSPvf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Jul 2022 11:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239551AbiGSPvV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Jul 2022 11:51:21 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C933F4BD38
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Jul 2022 08:51:12 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so9431253wmb.5
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Jul 2022 08:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XoVzJzZRO2y2NIpJ766MD/mBAH/yX0TDvkG6svd94H8=;
        b=r7/qvOLD4VMPI1/y+e3jZe7mpTVXnfXEtZka1ARUROPywL+L3qAZpySajxhueO1Kpu
         M7LsNaKR+S+4F5s0cDTymszobA3uFp12ks1aKXQ49KtpSDMLuNp86Q1b3UI8gYiksYb/
         +j4aiW30BmREsworgTPfcWB8eOopqbH+/ZF9qjwRxUSRKifTga/oj/u/rOanzox8I8y0
         3zsRcz9S43J6uQFsapP49nN+dzokDvraNQApllT5bNpeZIS3l6DHsAyPT5lIJ04IzIge
         mSv6K/6mtLxlPD4gI5PVQUUHv2ew4bjL8+6887595fE2dYVOodygIIA0E5cgs++PVPGc
         XmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XoVzJzZRO2y2NIpJ766MD/mBAH/yX0TDvkG6svd94H8=;
        b=OeRFGEgQQgTR18OrJkcqJoF//BUCWQoLBc4/9gpUeo9fe7UZfKrVTJGsZfFNBhFREN
         Fa56P7PcN1P4rShzB/QNX6r2WMHaFSAIF4sYS2HuEZerfz/5tKKboKaKdeVWBSyU4AVo
         hQdsmwMpkrw99mS+k1mo3JhQOH4Dv0bYXDX+ICIYa6C3RHGfYFdB1mDQJ82ysvmcUOaB
         aqsI2DcS/bsqErfVcwF2x6N6l9lM0eFd7WDmsli0rLBmUqhbLnF2r2T/LbaUGK1o3Vzz
         SYn077xKELfLjtdvIllQ5vZfn9YJm8Isirw6TFVvcrzHfnAF0H1Zyz0sHFuXm4vAboqn
         Fzbg==
X-Gm-Message-State: AJIora86Ur28UNcB/NU6UXsUN76PgHA5o0nta3tR/LYIjnNUJuHoq6yk
        5tK7bQu/cp26PLHqt4JxNYkZlqj1eonq28kg9p7MpQ==
X-Google-Smtp-Source: AGRyM1vceqSoNSc5YhdoQQw9Db4vgKyVJ8WZr6dQmfvbPDtzwHI1k/kK9O+lz30Q6CLWDxnlVfpFjU7WmshvGLcKpf4=
X-Received: by 2002:a05:600c:2854:b0:3a3:1551:d7d with SMTP id
 r20-20020a05600c285400b003a315510d7dmr13856861wmb.174.1658245867928; Tue, 19
 Jul 2022 08:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220609052355.1300162-1-irogers@google.com>
In-Reply-To: <20220609052355.1300162-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 19 Jul 2022 08:50:55 -0700
Message-ID: <CAP-5=fXJOB6aVcZdQ8cdejt5Jc_k_5jYGEGU7MJ++5qoxSsVpg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Tidy user rdpmc documentation and testing
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 8, 2022 at 10:24 PM Ian Rogers <irogers@google.com> wrote:
>
> libperf's perf_mmap__read_self and the addition of arm64 support mean
> that the perf_event.h and the rdpmc perf test have become
> stale. Refresh the documentation in perf_event.h, remove the x86 rdpmc
> test and port the libperf test as a non-architecture specific test.
>
> Address sanitizer testing showed libperf leaking fds when the
> perf_event_open failed, add error paths to handle this.
>
> A comment is added to perf_event.h to avoid a divide by zero when
> scaling counts if the running time is 0. This was previously discussed
> in this thread:
> https://lore.kernel.org/lkml/CAP-5=fVRdqvswtyQMg5cB+ntTGda+SAYskjTQednEH-AeZo13g@mail.gmail.com/
>
> v2. Alters the skip in test_stat_user_read for open to always be a
>     skip as perf_event_open may fail with EACCES (permissions), ENOSYS
>     (not supported) and ENOENT (hypervisor). Adds Rob Herring's
>     acked-by on patch 3.
>
> Ian Rogers (4):
>   libperf evsel: Open shouldn't leak fd on failure
>   perf: Align user space counter reading with code
>   perf test: Remove x86 rdpmc test
>   perf test: Add user space counter reading tests

Ping. Would be nice to get this cleaned up in the next release, plus
better testing.

Thanks,
Ian

>  include/uapi/linux/perf_event.h        |  32 +++--
>  tools/include/uapi/linux/perf_event.h  |  32 +++--
>  tools/lib/perf/evsel.c                 |  17 ++-
>  tools/perf/arch/x86/tests/Build        |   1 -
>  tools/perf/arch/x86/tests/arch-tests.c |   2 -
>  tools/perf/arch/x86/tests/rdpmc.c      | 182 -------------------------
>  tools/perf/tests/mmap-basic.c          | 127 ++++++++++++++++-
>  7 files changed, 176 insertions(+), 217 deletions(-)
>  delete mode 100644 tools/perf/arch/x86/tests/rdpmc.c
>
> --
> 2.36.1.255.ge46751e96f-goog
>
