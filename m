Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479F3C41513
	for <linux-perf-users@archiver.kernel.org>; Wed, 16 Aug 2023 02:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241168AbjHPCH3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Aug 2023 22:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241185AbjHPCH3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Aug 2023 22:07:29 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481D12127
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Aug 2023 19:07:28 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bdbbede5d4so39128415ad.2
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Aug 2023 19:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692151648; x=1692756448;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1cgPRSiv90OT3/SJL8ZMyRGl4jaRnBiBcYOX7OaylDE=;
        b=sQMCdgdwxL3T4OXi4BlV/8FePNPTCIivYKVkWn7lRRSmnv5c9qZy5fs29K/KOgn29Y
         O8HjNk71YBIgx74M3jMGU3NLOjIFS9rRDybcVMBz2bJESPp8ZeMJf139+YR9x/hnzLdK
         D0Gv8oY475Le4AEIkHqSSKHQQo7i5EhKKU06ctzgup9rZYddS9+agRyqLXUdQKd3X3+P
         K3GWm8qR+KCTSWmkUrwFHmWiaduwlS7z6JNuRPhqqDNHTDMq3oYDQ2T7uc9wG8tD2bZV
         IWvkM3M+XBkk+S50u1wastmv7g7ljregVsfk60vECo7OjFjmkfrl3z5hhUIg5CxY2zhR
         0drw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692151648; x=1692756448;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1cgPRSiv90OT3/SJL8ZMyRGl4jaRnBiBcYOX7OaylDE=;
        b=ksP5kumOjctrtpEBnDXt1lUHENSDMIRxarncAOlPyQIQgVZdAXPr1EkW40mi1CVE6s
         QLdDLhyqndyILGaZIuEnDgG2vAG8pbVfhYPJCXtJzo5htastAhjaJLxyy1ylEVVTqf3M
         GvzLc4yY6YCgOLSJmy1JdNYQ3hLap7je6cFc3W8t7qktM+xNS22TQmNKmW6Xcf8T0ePE
         pbb40IBZoVX1wGblZQS85GOWHT2omG2ZaANlRe7B/2g4ArNQUJHgGfo6yQfR9xOqFdTZ
         GhcwdSvrdjfrLvNqhaIWWITSulNALQn9k7hogKmpDnN8vY0GN9FbyqdQEQititRIzK/C
         10bA==
X-Gm-Message-State: AOJu0YwkMzo3yByGo0RumvQvVIcZqBzzcPlPm8tdRh2DW4Ln9ETAVqix
        gCo6sZbh76VNN2s9NIWc22cO/Q==
X-Google-Smtp-Source: AGHT+IFCPpYmyWaib0MQfDL563rBcVuQf0cRysHOx8FVJ+qFoWVHApR2PRs6Is19nR5cTTuzLoiwuw==
X-Received: by 2002:a17:903:2796:b0:1b8:8223:8bdd with SMTP id jw22-20020a170903279600b001b882238bddmr692922plb.59.1692151647664;
        Tue, 15 Aug 2023 19:07:27 -0700 (PDT)
Received: from leoy-huanghe.lan ([150.230.248.162])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902f68200b001b8943b37a5sm11673061plg.24.2023.08.15.19.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 19:07:27 -0700 (PDT)
Date:   Wed, 16 Aug 2023 10:07:15 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ming Wang <wangming01@loongson.cn>,
        Eric Lin <eric.lin@sifive.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/6] perf parse-regs: Refactor architecture functions
Message-ID: <20230816020715.GA135657@leoy-huanghe.lan>
References: <20230606014559.21783-1-leo.yan@linaro.org>
 <CAP-5=fV1m440mKc0R=m5C4N2NtoiixchtnpX2eR3PA_5hXbqEQ@mail.gmail.com>
 <ZNvCxM/ULdUfzHtR@kernel.org>
 <ZNvHx+KxIL6JzEl/@kernel.org>
 <ZNvJdsVmmAWLmfH6@kernel.org>
 <ZNvKjeFkXY8ezf9e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZNvKjeFkXY8ezf9e@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Aug 15, 2023 at 03:57:17PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Aug 15, 2023 at 03:52:38PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Tue, Aug 15, 2023 at 03:45:27PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Agreed, applied to perf-tools-next, sorry for the delay.
> > > 
> > > Had to add this to make 'perf test python' to work. Please run 'perf
> > > test' before sending patches.
> > 
> > One more, please also do a 'make -C tools/perf build-test', with it I
> > caught this:
> > 
> >          make_no_libunwind_O: cd . && make NO_LIBUNWIND=1 FEATURES_DUMP=/var/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.yeEGyQq2HR DESTDIR=/tmp/tmp.ITgoO16jjH
> > cd . && make NO_LIBUNWIND=1 FEATURES_DUMP=/var/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.yeEGyQq2HR DESTDIR=/tmp/tmp.ITgoO16jjH
> 
> +#include "util/env.h"
> 
> As now we need it for perf_env__arch(ui->machine->env)

Sorry for inconvenience.

I saw this patch series has been picked into the branch:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.perf-tools-next

If want me to follow up, let me know.  Thank you!

> >   CC      /tmp/tmp.yeEGyQq2HR/util/expr-flex.o
> > util/unwind-libdw.c: In function ‘memory_read’:
> > util/unwind-libdw.c:173:28: error: implicit declaration of function ‘perf_env__arch’ [-Werror=implicit-function-declaration]
> >   173 |         const char *arch = perf_env__arch(ui->machine->env);
> >       |                            ^~~~~~~~~~~~~~
> > util/unwind-libdw.c:173:28: error: initialization of ‘const char *’ from ‘int’ makes pointer from integer without a cast [-Werror=int-conversion]
> > util/unwind-libdw.c: In function ‘unwind__get_entries’:
> > util/unwind-libdw.c:258:28: error: initialization of ‘const char *’ from ‘int’ makes pointer from integer without a cast [-Werror=int-conversion]
> >   258 |         const char *arch = perf_env__arch(ui_buf.machine->env);
> >       |                            ^~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> > make[6]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:98: /tmp/tmp.yeEGyQq2HR/util/unwind-libdw.o] Error 1
> > make[6]: *** Waiting for unfinished jobs....
> > make[5]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:150: util] Error 2
> > make[4]: *** [Makefile.perf:662: /tmp/tmp.yeEGyQq2HR/perf-in.o] Error 2
> > make[4]: *** Waiting for unfinished jobs....
> >   CC      /tmp/tmp.yeEGyQq2HR/pmu-events/pmu-events.o
> >   LD      /tmp/tmp.yeEGyQq2HR/pmu-events/pmu-events-in.o
> > make[3]: *** [Makefile.perf:238: sub-make] Error 2
> > make[2]: *** [Makefile:70: all] Error 2
> > make[1]: *** [tests/make:337: make_no_libunwind_O] Error 1
> > make: *** [Makefile:103: build-test] Error 2
> > make: Leaving directory '/var/home/acme/git/perf-tools-next/tools/perf'
> > 
> > real	1m29.784s
> > user	10m41.597s
> > sys	2m55.948s
> > ⬢[acme@toolbox perf-tools-next]$
> > 
> > I'm trying to fix
> 
> -- 
> 
> - Arnaldo
