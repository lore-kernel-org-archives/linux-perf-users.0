Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70D1C4332F
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Nov 2022 03:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiK0D3I (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 26 Nov 2022 22:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiK0D3H (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 26 Nov 2022 22:29:07 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C9211A2C
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Nov 2022 19:29:05 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id b12so11930826wrn.2
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Nov 2022 19:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vOHgtUos/OWv/67WuwdQ5Bn7s3r1/TwlVmZZj7phXpA=;
        b=K0IkhdoRtjO+ZyQmpDeVLjMrk6DneVCkRzWUZOXjyMYBiEBD3hSLz+138q0MA42+G6
         O36BS5zglgsovhWmCU07YukJ3CE4FWlWY80ExtTZM5Mlr6Q208bVH588li696xwkohOO
         rQPIIVZ8EVik2d1gqv9hFjEQmyXErvezfhI4kDLHMlZBS+F91Sil77LxNPjyDkfKWWxr
         uk9uRRni4deunp3AgxQFA83J7BlzJPIjNnUaTyLur88oQCyMYQbNaxeobqlq/SSsXqce
         IxEdG7XRlyM3hUwNSseEmdYdgv+zGW/p44XRrHg07bnfEEWzXZzlP00eON7nO+3I62/1
         1XFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vOHgtUos/OWv/67WuwdQ5Bn7s3r1/TwlVmZZj7phXpA=;
        b=kD568AKqB6mAGvw6Eh/qx2dgJiPAlhDBN7ghN1fn4lhUkwktXkvc0vfWru34CSAEWr
         A1CBIfVYoxZVdVtel4gaFWBAvTKUUnCn04IdFjiR9dsKB1/xzN7GWKwFm16J4mmpghKM
         o9IPhH5KmkAoLYYXk3e9q4yFIsE8PXEz8bApzqb2PZFHnDm4T9LK+ljDfaDUqKJ+pxMd
         Prs+r/l1wHz0fMeulhiT5BYoK0aVexrP/Ju5q2AZQwVCkLXV7UMbqG+88mUuTnXLys9s
         eU0O56CP+ACWDXwJeUIuQHejjBnSAE/ecse+KJYm0HaaxrYKUyBkWHo9Ja9cz3/2H7ys
         NE1w==
X-Gm-Message-State: ANoB5pl7fzfRzWMyplUX7d0NdVMh3n4zFKaFAOiUyVinRHO9yht72OCe
        guXD+KCsfkLFkOWUZ1OPwe8w0nL1sTX6ZiYGhhAUiA==
X-Google-Smtp-Source: AA0mqf41FYo8wWzOeH0XSJrQ2TDdoV9GGN6kokYBxxeR7O4i1nMTxmkne3lKQN1LnBOhOLyTxYvHVFftnig2FdpOz7E=
X-Received: by 2002:adf:e2c9:0:b0:241:db86:176d with SMTP id
 d9-20020adfe2c9000000b00241db86176dmr17882344wrj.40.1669519744242; Sat, 26
 Nov 2022 19:29:04 -0800 (PST)
MIME-Version: 1.0
References: <20221125032018.962-1-ravi.bangoria@amd.com>
In-Reply-To: <20221125032018.962-1-ravi.bangoria@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 26 Nov 2022 19:28:52 -0800
Message-ID: <CAP-5=fVtFLuFzYY8x72ib1=G8n-aFYjqRmttxsu7t-oFGnCWEw@mail.gmail.com>
Subject: Re: [PATCH] perf test: Add event group test
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, jolsa@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, mark.rutland@arm.com,
        kan.liang@linux.intel.com, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, carsten.haitzler@arm.com,
        leo.yan@linaro.org, maddy@linux.ibm.com, kjain@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, tmricht@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Nov 24, 2022 at 7:21 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> Multiple events in a group can belong to one or more pmus, however
> there are some limitations to it. Basically, perf doesn't allow
> creating a group of events from different hw pmus. Write a simple
> test to create various combinations of hw, sw and uncore pmu events
> and verify group creation succeeds or fails as expected.

Awesome, thanks! Some comments below.

> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
> Note: Uncore pmu event detail for Intel, Arm, PowerPC and s390 needs
> to be verified/fixed. These are marked as XXX in the patch.
>
>  tools/perf/tests/Build          |   1 +
>  tools/perf/tests/builtin-test.c |   1 +
>  tools/perf/tests/event_groups.c | 126 ++++++++++++++++++++++++++++++++
>  tools/perf/tests/tests.h        |   1 +
>  4 files changed, 129 insertions(+)
>  create mode 100644 tools/perf/tests/event_groups.c
>
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 2064a640facb..9a59d451ca44 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -67,6 +67,7 @@ perf-y += expand-cgroup.o
>  perf-y += perf-time-to-tsc.o
>  perf-y += dlfilter-test.o
>  perf-y += sigtrap.o
> +perf-y += event_groups.o
>
>  $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
>         $(call rule_mkdir)
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 7122eae1d98d..48cd0c809cb1 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -110,6 +110,7 @@ static struct test_suite *generic_tests[] = {
>         &suite__perf_time_to_tsc,
>         &suite__dlfilter,
>         &suite__sigtrap,
> +       &suite__event_groups,
>         NULL,
>  };
>
> diff --git a/tools/perf/tests/event_groups.c b/tools/perf/tests/event_groups.c
> new file mode 100644
> index 000000000000..92486b68cadb
> --- /dev/null
> +++ b/tools/perf/tests/event_groups.c
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <string.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +#include "linux/perf_event.h"
> +#include "tests.h"
> +#include "debug.h"
> +#include "pmu.h"
> +#include "header.h"
> +#include "../perf-sys.h"
> +
> +static int event_open(int type, unsigned long config, int g_fd)
> +{
> +       struct perf_event_attr attr;
> +
> +       memset(&attr, 0, sizeof(struct perf_event_attr));
> +       attr.type = type;
> +       attr.size = sizeof(struct perf_event_attr);
> +       attr.config = config;

Could you add a comment for the line below?

> +       attr.disabled = g_fd == -1 ? 1 : 0;
> +
> +       return sys_perf_event_open(&attr, -1, 0, g_fd, 0);
> +}
> +
> +/* hw: cycles, sw: context-switch, uncore: [arch dependent] */

static?

> +int type[] = {0, 1, -1};
> +unsigned long config[] = {0, 3, -1};
> +
> +static int setup_uncore_event(void)
> +{
> +       char pmu_name[25] = {0};
> +       struct perf_pmu *pmu;
> +

I think the below finding of an uncore PMU is clunky. On my tigerlake
Intel laptop, for example, I don't have an uncore_imc_0 but do have
uncore_imc_free_running_0. I think the real fix here is that we should
start a new "pmus.h" and "pmus.c", moving the pmus static variable
from pmu.c to pmus.c. In pmus.h we should have an every PMU iterator,
like we do with perf_pmu__for_each_hybrid_pmu. I'd like to go further
with a pmus.h, as the computation of the perf_pmu struct should be
done a lot more lazily than it is now. But for now you can just
iterate the pmus looking for one saying beginning with "uncore_" as a
name.

> +#if defined(__x86_64__) || defined(__i386__)
> +{
> +       char buf[128] = {0};
> +
> +       if (get_cpuid(buf, sizeof(buf)))
> +               return -1;
> +       if (strstr(buf, "Intel")) {
> +               strcpy(pmu_name, "uncore_imc_0"); /* XXX */
> +               config[2] = 0xff04;
> +       } else {
> +               strcpy(pmu_name, "amd_l3");
> +               config[2] = 0xff04; /* l3_cache_accesses */
> +       }
> +}
> +#elif defined(__arm__) || defined(__aarch64__)
> +       strcpy(pmu_name, "l2c_220"); /* XXX */
> +       config[2] = 0x0;
> +#elif defined(__powerpc__)
> +       strcpy(pmu_name, "hv_24x7"); /* XXX */
> +       config[2] = 0x0;
> +#elif defined(__s390x__)
> +       strcpy(pmu_name, "pai_crypto"); /* XXX */
> +       config[2] = 0x0;
> +#else
> +       pr_debug("No uncore pmu event found\n");
> +       return -1;
> +#endif
> +
> +       pmu = perf_pmu__find(pmu_name);
> +       if (!pmu) {
> +               pr_debug("Can not find uncore pmu\n");
> +               return -1;
> +       }
> +       type[2] = pmu->type;
> +       return 0;
> +}
> +
> +static int run_test(int i, int j, int k)
> +{
> +       int erroneous = ((((1 << i) | (1 << j) | (1 << k)) & 5) == 5);
> +       int fd1, fd2, fd3;
> +
> +       fd1 = event_open(type[i], config[i], -1);

nit: a name like "event_group_leader_fd" would be more intention
revealing than fd1.

Thanks!
Ian

> +       if (fd1 == -1)
> +               return -1;
> +
> +       fd2 = event_open(type[j], config[j], fd1);
> +       if (fd2 == -1) {
> +               close(fd1);
> +               return erroneous ? 0 : -1;
> +       }
> +
> +       fd3 = event_open(type[k], config[k], fd1);
> +       if (fd3 == -1) {
> +               close(fd1);
> +               close(fd2);
> +               return erroneous ? 0 : -1;
> +       }
> +
> +       close(fd1);
> +       close(fd2);
> +       close(fd3);
> +       return erroneous ? -1 : 0;
> +}
> +
> +static int test__event_groups(struct test_suite *text __maybe_unused, int subtest __maybe_unused)
> +{
> +       int i, j, k;
> +       int ret;
> +       int r;
> +
> +       ret = setup_uncore_event();
> +       if (ret || type[2] == -1)
> +               return TEST_SKIP;
> +
> +       ret = TEST_OK;
> +       for (i = 0; i < 3; i++) {
> +               for (j = 0; j < 3; j++) {
> +                       for (k = 0; k < 3; k++) {
> +                               r = run_test(i, j, k);
> +                               if (r)
> +                                       ret = TEST_FAIL;
> +
> +                               pr_debug("0x%x 0x%lx, 0x%x 0x%lx, 0x%x 0x%lx: %s\n",
> +                                        type[i], config[i], type[j], config[j],
> +                                        type[k], config[k], r ? "Fail" : "Pass");
> +                       }
> +               }
> +       }
> +       return ret;
> +}
> +
> +DEFINE_SUITE("Event groups", event_groups);
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index 5bbb8f6a48fc..08570b5505d7 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -147,6 +147,7 @@ DECLARE_SUITE(expand_cgroup_events);
>  DECLARE_SUITE(perf_time_to_tsc);
>  DECLARE_SUITE(dlfilter);
>  DECLARE_SUITE(sigtrap);
> +DECLARE_SUITE(event_groups);
>
>  /*
>   * PowerPC and S390 do not support creation of instruction breakpoints using the
> --
> 2.38.1
>
