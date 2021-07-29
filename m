Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B32C4338F
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 13:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6589F6052B
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 13:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237698AbhG2NlE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 29 Jul 2021 09:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237608AbhG2NlD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Jul 2021 09:41:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95FBC061765;
        Thu, 29 Jul 2021 06:40:59 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j2so6988076wrx.9;
        Thu, 29 Jul 2021 06:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=4w68rscaz0+YoNz6qjqRAKpGkBdq7Bv5iW8piRmlRkI=;
        b=oI+fQKNSqEhly+u+/QGKeOk8d6uZ66iEljWZBXVUIcBF9zAG9TEzllAv4x3SuVUVxE
         3UOtBi7c9CT6QKGCAFfy+ThTUp0rQCmWMBhSYCbDW4hugYuKE7SHuKvoEuKZkLkCAt2a
         snkCLGwvc4HJ6/xXEGLVz6bVQGfrFJAslZQVE7sYP0wEK/tSvUHhaOk9GZMceUqaI4EL
         k3dClFaHl+rZVxVxf9c5m+Yd3IKVZiPvoAuANZQT3cJoPQN1jgoAeIc40h511N5bmGuG
         W1W3je76l2AJX2gIjDiWroIyEYNvaZKYUodUVOVX+AStZIRJy1Uu7NC7bdffUo7w8B0f
         eDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=4w68rscaz0+YoNz6qjqRAKpGkBdq7Bv5iW8piRmlRkI=;
        b=IffUVDeVbrjGTkc2asCbSZH+TG5QRGx/snKyAJK89yWzrqTRLJa1ojPj0fyKRBXijh
         Ro4j3nQ6+atPf98ruYcnB5xFPYbxkB8b2YaJMJXttMK2HiiJ3jz5pEsPs8Wl6GtulMyP
         8DyXVHvch/aroL1sp7W3cvt3EfMIgylX6pueVrBO92KJbNJkqJ4l20OlxpiqNzmck2q3
         YIGNeqeo+g4sY/hWNzJsVPk9tHfUy+bF55+Wf5X1aIpa1mu301rL+0AHrePOMVaSiOWw
         Gi2BRqwyFwbpiom/p/wNw2VozJEbiS/mfsiQWeSxuJU1iVoye8DITGfwtqqXRUImIbeX
         4aLQ==
X-Gm-Message-State: AOAM532XZDnN//Bj74RLxjVp+7XTmkwUIdP9cwoorgID+bGhJnWU3xI0
        eNguR+4+mZi0tMSjAm7baV8=
X-Google-Smtp-Source: ABdhPJxhjLM3nWd3D1zfYfg/aITNTg30InX9cJZF62KMdLOk2n1/Hph737MHI3gQ1K4VRR1VxoxVdA==
X-Received: by 2002:a5d:6dac:: with SMTP id u12mr4926273wrs.153.1627566058333;
        Thu, 29 Jul 2021 06:40:58 -0700 (PDT)
Received: from [192.168.1.121] (93-40-209-49.ip40.fastwebnet.it. [93.40.209.49])
        by smtp.gmail.com with ESMTPSA id l23sm3412282wme.22.2021.07.29.06.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 06:40:57 -0700 (PDT)
Message-ID: <cb2ebcbb2ea963169823ad052be8ebf9290cc97b.camel@gmail.com>
Subject: Re: [PATCH 3/3] perf test: Be more consistent in use of TEST_*
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Ian Rogers <irogers@google.com>
Cc:     eranian@google.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 29 Jul 2021 15:39:26 +0200
In-Reply-To: <20210729062451.1349566-4-irogers@google.com>
References: <20210729062451.1349566-1-irogers@google.com>
         <20210729062451.1349566-4-irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Ian,

On Wed, 2021-07-28 at 23:24 -0700, Ian Rogers wrote:
> The TEST_OK, TEST_FAIL and TEST_SKIP enum values are used
> inconsistently. Try to reduce this by swapping constants for enum values
> to try to be more intention revealing.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/x86/tests/rdpmc.c           |   8 +-
>  tools/perf/tests/attr.c                     |   2 +-
>  tools/perf/tests/bitmap.c                   |   2 +-
>  tools/perf/tests/bp_account.c               |   4 +-
>  tools/perf/tests/bp_signal.c                |  51 +++++++--
>  tools/perf/tests/code-reading.c             |  12 +-
>  tools/perf/tests/cpumap.c                   |  10 +-
>  tools/perf/tests/dso-data.c                 |   8 +-
>  tools/perf/tests/dwarf-unwind.c             |  14 ++-
>  tools/perf/tests/event-times.c              |   2 +-
>  tools/perf/tests/evsel-roundtrip-name.c     |  14 +--
>  tools/perf/tests/evsel-tp-sched.c           |  28 ++---
>  tools/perf/tests/expr.c                     |   4 +-
>  tools/perf/tests/fdarray.c                  |   4 +-
>  tools/perf/tests/genelf.c                   |   2 +-
>  tools/perf/tests/hists_cumulate.c           |   2 +-
>  tools/perf/tests/hists_filter.c             |  12 +-
>  tools/perf/tests/hists_link.c               |  33 +++---
>  tools/perf/tests/keep-tracking.c            |   4 +-
>  tools/perf/tests/kmod-path.c                |   6 +-
>  tools/perf/tests/mem.c                      |   4 +-
>  tools/perf/tests/mem2node.c                 |   2 +-
>  tools/perf/tests/mmap-basic.c               |  10 +-
>  tools/perf/tests/mmap-thread-lookup.c       |   2 +-
>  tools/perf/tests/openat-syscall-all-cpus.c  |   4 +-
>  tools/perf/tests/openat-syscall-tp-fields.c |   4 +-
>  tools/perf/tests/openat-syscall.c           |   6 +-
>  tools/perf/tests/parse-events.c             | 118 ++++++++++----------
>  tools/perf/tests/parse-metric.c             |  16 +--
>  tools/perf/tests/parse-no-sample-id-all.c   |   4 +-
>  tools/perf/tests/perf-hooks.c               |   2 +-
>  tools/perf/tests/perf-record.c              |   2 +-
>  tools/perf/tests/perf-time-to-tsc.c         |   4 +-
>  tools/perf/tests/pfm.c                      |   4 +-
>  tools/perf/tests/pmu-events.c               |  36 +++---
>  tools/perf/tests/pmu.c                      |  16 +--
>  tools/perf/tests/python-use.c               |   2 +-
>  tools/perf/tests/sample-parsing.c           |  10 +-
>  tools/perf/tests/stat.c                     |  12 +-
>  tools/perf/tests/sw-clock.c                 |   8 +-
>  tools/perf/tests/switch-tracking.c          |   9 +-
>  tools/perf/tests/task-exit.c                |  12 +-
>  tools/perf/tests/tests.h                    |   4 +-
>  tools/perf/tests/thread-map.c               |   8 +-
>  tools/perf/tests/thread-maps-share.c        |   2 +-
>  tools/perf/tests/time-utils-test.c          |   2 +-
>  tools/perf/tests/topology.c                 |   2 +-
>  tools/perf/tests/vmlinux-kallsyms.c         |   6 +-
>  tools/perf/tests/wp.c                       |  10 +-
>  49 files changed, 292 insertions(+), 251 deletions(-)
> 
<SNIP>
> diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
> index 9866cddebf23..70e92e074dba 100644
> --- a/tools/perf/tests/code-reading.c
> +++ b/tools/perf/tests/code-reading.c
> @@ -725,20 +725,20 @@ int test__code_reading(struct test *test __maybe_unused,
> int subtest __maybe_unu
>  
>         switch (ret) {
>         case TEST_CODE_READING_OK:
> -               return 0;
> +               return TEST_OK;
>         case TEST_CODE_READING_NO_VMLINUX:
>                 pr_debug("no vmlinux\n");
> -               return 0;
> +               return TEST_SKIP;
>         case TEST_CODE_READING_NO_KCORE:
>                 pr_debug("no kcore\n");
> -               return 0;
> +               return TEST_SKIP;
>         case TEST_CODE_READING_NO_ACCESS:
>                 pr_debug("no access\n");
> -               return 0;
> +               return TEST_SKIP;
>         case TEST_CODE_READING_NO_KERNEL_OBJ:
>                 pr_debug("no kernel obj\n");
> -               return 0;
> +               return TEST_SKIP;
>         default:
> -               return -1;
> +               return TEST_FAIL;
>         };
>  }


I think it's better to separate changes that do not change the current behaviour
from these changes (0 -> TEST_SKIP) into different patches.

Riccardo

> diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
> index 0472b110fe65..bfcb85a965bb 100644
> --- a/tools/perf/tests/cpumap.c
> +++ b/tools/perf/tests/cpumap.c
> @@ -42,7 +42,7 @@ static int process_event_mask(struct perf_tool *tool
> __maybe_unused,
>         }
>  
>         perf_cpu_map__put(map);
> -       return 0;
> +       return TEST_OK;
>  }
>  
>  static int process_event_cpus(struct perf_tool *tool __maybe_unused,
> @@ -71,7 +71,7 @@ static int process_event_cpus(struct perf_tool *tool
> __maybe_unused,
>         TEST_ASSERT_VAL("wrong cpu", map->map[1] == 256);
>         TEST_ASSERT_VAL("wrong refcnt", refcount_read(&map->refcnt) == 1);
>         perf_cpu_map__put(map);
> -       return 0;
> +       return TEST_OK;
>  }
>  
>  
> @@ -94,7 +94,7 @@ int test__cpu_map_synthesize(struct test *test
> __maybe_unused, int subtest __may
>                 !perf_event__synthesize_cpu_map(NULL, cpus,
> process_event_cpus, NULL));
>  
>         perf_cpu_map__put(cpus);
> -       return 0;
> +       return TEST_OK;
>  }
>  
>  static int cpu_map_print(const char *str)
> @@ -120,7 +120,7 @@ int test__cpu_map_print(struct test *test __maybe_unused,
> int subtest __maybe_un
>         TEST_ASSERT_VAL("failed to convert map", cpu_map_print("1,3-6,8-
> 10,24,35-37"));
>         TEST_ASSERT_VAL("failed to convert map", cpu_map_print("1,3-6,8-
> 10,24,35-37"));
>         TEST_ASSERT_VAL("failed to convert map", cpu_map_print("1-10,12-20,22-
> 30,32-40"));
> -       return 0;
> +       return TEST_OK;
>  }
>  
>  int test__cpu_map_merge(struct test *test __maybe_unused, int subtest
> __maybe_unused)
> @@ -135,5 +135,5 @@ int test__cpu_map_merge(struct test *test __maybe_unused,
> int subtest __maybe_un
>         TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "1-
> 2,4-5,7"));
>         perf_cpu_map__put(b);
>         perf_cpu_map__put(c);
> -       return 0;
> +       return TEST_OK;
>  }
<SNIP>

