Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51B5C19F29
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Aug 2022 00:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237123AbiHDA04 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 3 Aug 2022 20:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiHDA0z (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 3 Aug 2022 20:26:55 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D584564E5
        for <linux-perf-users@vger.kernel.org>; Wed,  3 Aug 2022 17:26:53 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q30so18981521wra.11
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Aug 2022 17:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3XlIip8eAQOdRRYZm2gwfWJub8iCn6qxvH/NSy/BVBQ=;
        b=TV8x1mIKYxfKrkMyWCyqQtcnnZMhnACZkFYOtDR0liAlu7PpdDN+x69pIlpIzuCSef
         cmhTT7fbLux4YsIAF1FUFmHW/YU7janlAQx5Kmg6y/lyMEtPMwwC6B3F1F5RbBlbYhFl
         BqkVxFEKxuBXuq0AvlQ3il1X5qamQ6AYJgueosn6Nribp9iGeYLMn70ByU+pkKjCgWfW
         itox365wad4bLvckDua3PJpWPWy/GPT2ihHsXNLRuizcK3Cg6QcfMyuw43Bpv2r3ed6b
         P1/XZbXILNpwOHMWwemK1XAx2TMe/HnmLfsnrAsP9j0Ka+Tj+mm1+tqiW3hDWlvkw0j6
         aUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3XlIip8eAQOdRRYZm2gwfWJub8iCn6qxvH/NSy/BVBQ=;
        b=4cfv+AYTnJDpDO09bNZ3OdR3K6zSDDeR5hiHlx3g9nEugkep7rWvPcy6stJxxNuQJJ
         csSBPUOrlnHkkECxx0A//iD0aC05agHNqX1xGT0JOPylrsISE+fSKUWS718mPkEYx9kp
         l8FjaXnf1DaxLUtPvpjBnFU9Rvr/yff3zcE9tbWB4JLepISDY9500dL4FU0nLR4llTN/
         f6LRSwt8RG2HkAL/jYYxJkYVNEZRJTmqOGjzLk/UsQImhQqaBz1J8QmnkIuw1d2SXc8t
         8Kb+zrwRdedNT6WF9nZzfD7qH0gUdM1QzyX/3cZl0n/M+xZypYzHNGA/rcrQTRJYleFx
         m2Fw==
X-Gm-Message-State: ACgBeo0UVTZTRA1cJ0nlqMrljYiBP9gk/GdFVDH0tqxhiuFZpY36JXih
        +qVNbCs+GUfHNzwYyLrtMpnNqzaR4U4nTef81bD1/A==
X-Google-Smtp-Source: AA6agR4alCws7mn67G1541NoJqhjFza03JbTBZO3aAoyp8bTF6gtHy3PRlpmjAX1rUbnd/IoxEN+8If9pKljJ8zO1JM=
X-Received: by 2002:a05:6000:1ac9:b0:220:7f40:49e3 with SMTP id
 i9-20020a0560001ac900b002207f4049e3mr1948679wry.40.1659572811521; Wed, 03 Aug
 2022 17:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220731164923.691193-1-irogers@google.com> <20220801015259.GA101027@leoy-ThinkPad-X240s>
 <CAP-5=fVSjCQ4jeAeyP5THnQVyXDpKd6Ob33C7PDwFB_6+YSXuw@mail.gmail.com>
 <YufJP5YqeEBM51HL@kernel.org> <20220803152527.GA133193@leoy-ThinkPad-X240s>
In-Reply-To: <20220803152527.GA133193@leoy-ThinkPad-X240s>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 3 Aug 2022 17:26:39 -0700
Message-ID: <CAP-5=fX1B9qv1kPLfRx59kgeEwNOzFVnaNm34YiLFpc3JMTQpA@mail.gmail.com>
Subject: Re: [PATCH] perf symbol: Fail to read phdr workaround
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Aug 3, 2022 at 8:25 AM Leo Yan <leo.yan@linaro.org> wrote:
>
> Hi Arnaldo, Ian,
>
> On Mon, Aug 01, 2022 at 09:38:23AM -0300, Arnaldo Carvalho de Melo wrote:
>
> [...]
>
> > I also think we could have something like a 'perf test' mode where, when
> > asked to, it would enable tests that involve downloading such files to
> > perform tests, such as this dacapo benchmark, and then would test if the
> > output matches expectations.
>
> I am working on testing script for java symbols, one of the steps shared by
> Ian is:
>
>   # /tmp/perf/perf record -k 1 java -agentpath:/tmp/perf/libperf-jvmti.so \
>     -jar dacapo-9.12-MR1-bach.jar -n 10 fop
>
> The question is how we can specify the path for the lib
> libperf-jvmti.so in the testing script?
>
> If we can run the test case from the root folder of Linux kernel
> source code, the lib libperf-jvmti.so can be found in the folder
> $linux/tools/perf, but for the integration testing the lib should be
> placed in an installed folder.  Any suggestion if we have exited
> way to specify the path for libperf-jvmti.so, or need to introduce a
> new shell envorinment variable for the lib path?

There is a hack in 'perf test' where we assume a few paths to tests:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/tests/builtin-test.c?h=perf/core#n308
so in this case we could look in the same directory. There is also a
#define for PERF_EXEC_PATH.

I'd prefer it if the test could be self contained for example:

echo "int fib(int x) { return x > 1 ? fib(x - 2) + fib(x - 1) : 1; }
int q = 0; for(int i=0; i < 10; i++) q += fib(i);
System.out.println(q);" | /tmp/perf/perf record -k 1 jshell
-J-agentpath:/tmp/perf/libperf-jvmti.so

where jshell runs on the JVM and so we should get some jitted execution time.

Thanks,
Ian

> Thanks,
> Leo
