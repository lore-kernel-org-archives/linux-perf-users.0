Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23F9C7EE29
	for <linux-perf-users@archiver.kernel.org>; Thu, 25 May 2023 19:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241637AbjEYT17 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 25 May 2023 15:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243670AbjEYT1l (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 25 May 2023 15:27:41 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DBB10E3;
        Thu, 25 May 2023 12:26:33 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-ba8afcc82c0so28122276.2;
        Thu, 25 May 2023 12:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685042691; x=1687634691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ps2nba1CZQSLfcCNY2djZFhOfLDj/kiQp3GO8gySDB4=;
        b=FCxUaapCUGb5NNZDCdsk7mtNpettchXvWswpbcHTbMX/5CEmR2n/XUhxMOuzMVC5mO
         7fw8xQ9lQJe8vng0R4hquINa05vgmh6yocGJVnnMUCFZdI7k05DizuaiAeJI7uxwUwok
         1v4l/yx65FW3Cz94vx7HgeYfb7LduSypZknTp2lrsiFYyV0NCsheW5GrbycZFXzUwD8P
         pK4YmGBerooI+I/w1++uxdwYulxryiixdM7aUz6mmvnZaXWkv/X00GHDjOQVfYAfEmLQ
         kN2tsxsBEW/xvI2R2MaFbrIzUoH4w8zrayLeI9AvoPkjtZ752hiZtQx5TEHbwfWHeeEP
         TnnQ==
X-Gm-Message-State: AC+VfDwy1PoDq6L54wVNvetx4tHQ6jJsM9hF7qSFBwPqEeGlDQhlZpIb
        gg3Qljy4TUrGLZl4UerVWa+P6GD0OOv/xQNGalPk2QfF
X-Google-Smtp-Source: ACHHUZ5S28d+j79LBuLMG6U3SrhLRvE2YDRnaoiCRim0SXQ2+UhdjPmOpLhJFNgTlJVx9MdG29sKhedMxQwNm0A4xVM=
X-Received: by 2002:a67:e205:0:b0:439:31df:f097 with SMTP id
 g5-20020a67e205000000b0043931dff097mr6127786vsa.24.1685042105094; Thu, 25 May
 2023 12:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230525071133.2066610-1-irogers@google.com> <20230525071133.2066610-2-irogers@google.com>
In-Reply-To: <20230525071133.2066610-2-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 25 May 2023 12:14:53 -0700
Message-ID: <CAM9d7cgaSPbnjoA6bv8fwkpoyc6nCdXOOrbmBm_jGbZbm3a_4w@mail.gmail.com>
Subject: Re: [PATCH v1 01/16] perf header: Make nodes dynamic in write_mem_topology
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Ross Zwisler <zwisler@chromium.org>,
        Leo Yan <leo.yan@linaro.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, May 25, 2023 at 12:12 AM Ian Rogers <irogers@google.com> wrote:
>
> Avoid a large static array, dynamically allocate the nodes avoiding a
> hard coded limited as well.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/header.c | 33 +++++++++++++++++++++------------
>  1 file changed, 21 insertions(+), 12 deletions(-)
>
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 2dde3ca20de5..80593ed8c79b 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -24,6 +24,7 @@
>  #include <bpf/libbpf.h>
>  #endif
>  #include <perf/cpumap.h>
> +#include <tools/libc_compat.h> // reallocarray
>
>  #include "dso.h"
>  #include "evlist.h"
> @@ -1396,13 +1397,14 @@ static int memory_node__sort(const void *a, const void *b)
>         return na->node - nb->node;
>  }
>
> -static int build_mem_topology(struct memory_node *nodes, u64 size, u64 *cntp)
> +static int build_mem_topology(struct memory_node **nodesp, u64 *cntp)
>  {
>         char path[PATH_MAX];
>         struct dirent *ent;
>         DIR *dir;
> -       u64 cnt = 0;
>         int ret = 0;
> +       size_t cnt = 0, size = 0;
> +       struct memory_node *nodes = NULL;
>
>         scnprintf(path, PATH_MAX, "%s/devices/system/node/",
>                   sysfs__mountpoint());
> @@ -1426,16 +1428,24 @@ static int build_mem_topology(struct memory_node *nodes, u64 size, u64 *cntp)
>                 if (r != 1)
>                         continue;
>
> -               if (WARN_ONCE(cnt >= size,
> -                       "failed to write MEM_TOPOLOGY, way too many nodes\n")) {
> -                       closedir(dir);
> -                       return -1;
> -               }
> +               if (cnt >= size) {
> +                       struct memory_node *new_nodes =
> +                               reallocarray(nodes, cnt + 4, sizeof(*nodes));
>
> +                       if (!new_nodes) {
> +                               pr_err("Failed to write MEM_TOPOLOGY, size %zd nodes\n", size);
> +                               free(nodes);
> +                               closedir(dir);
> +                               return -ENOMEM;
> +                       }
> +                       nodes = new_nodes;
> +                       size += 4;
> +               }
>                 ret = memory_node__read(&nodes[cnt++], idx);

I think you need to handle error cases here.

Thanks,
Namhyung


>         }
>
>         *cntp = cnt;
> +       *nodesp = nodes;
>         closedir(dir);
>
>         if (!ret)
> @@ -1444,8 +1454,6 @@ static int build_mem_topology(struct memory_node *nodes, u64 size, u64 *cntp)
>         return ret;
>  }
>
> -#define MAX_MEMORY_NODES 2000
> -
>  /*
>   * The MEM_TOPOLOGY holds physical memory map for every
>   * node in system. The format of data is as follows:
> @@ -1464,8 +1472,8 @@ static int build_mem_topology(struct memory_node *nodes, u64 size, u64 *cntp)
>  static int write_mem_topology(struct feat_fd *ff __maybe_unused,
>                               struct evlist *evlist __maybe_unused)
>  {
> -       static struct memory_node nodes[MAX_MEMORY_NODES];
> -       u64 bsize, version = 1, i, nr;
> +       struct memory_node *nodes = NULL;
> +       u64 bsize, version = 1, i, nr = 0;
>         int ret;
>
>         ret = sysfs__read_xll("devices/system/memory/block_size_bytes",
> @@ -1473,7 +1481,7 @@ static int write_mem_topology(struct feat_fd *ff __maybe_unused,
>         if (ret)
>                 return ret;
>
> -       ret = build_mem_topology(&nodes[0], MAX_MEMORY_NODES, &nr);
> +       ret = build_mem_topology(&nodes, &nr);
>         if (ret)
>                 return ret;
>
> @@ -1508,6 +1516,7 @@ static int write_mem_topology(struct feat_fd *ff __maybe_unused,
>         }
>
>  out:
> +       free(nodes);
>         return ret;
>  }
>
> --
> 2.40.1.698.g37aff9b760-goog
>
