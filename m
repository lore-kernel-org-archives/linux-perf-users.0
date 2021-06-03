Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C954C47096
	for <linux-perf-users@archiver.kernel.org>; Thu,  3 Jun 2021 23:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 242C96140A
	for <linux-perf-users@archiver.kernel.org>; Thu,  3 Jun 2021 23:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhFCXR2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 3 Jun 2021 19:17:28 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:35660 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFCXR2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 3 Jun 2021 19:17:28 -0400
Received: by mail-ej1-f51.google.com with SMTP id h24so11694008ejy.2;
        Thu, 03 Jun 2021 16:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=3WuvhbhcEPKsVEJvHh5couLLk1Ycjl6AyEm1dP6XBw4=;
        b=hWyX/JyYjX4rmcpXLAGV6UJR0AePWEd6X9khwir6JWtKxz05P96YHRT9XPopsskz1A
         m8iD2UHQ6xVv7lfsJ8aMFQd7my3tPprbppJx8Ysk/J5kCiZgmoS98l0UvxHEZVPPTmyf
         dxIM1QIpca3VbKxn+76+5jqXoFd78wfNJTzBRiI9yZQWnuU5VIrdmCPBnU1XMA3SvkAH
         SNlvxYcWjVIMb41emfXQ/HTzDBTLN+G1To7pGm82HvKJfYnej+1OsrTyGxptK/JQTC8W
         9aBMVc4v49xB3Uml9iGpKeBSNJ2Ku0gIXSUwh9jMt3FA3xaMTEeuKocJxNj7mCKxUs7p
         ooHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=3WuvhbhcEPKsVEJvHh5couLLk1Ycjl6AyEm1dP6XBw4=;
        b=iSEvpwJHWIBULA00D4s1uFH38BTiYdAd7yTsc812DJWZdbJb9hzWsaCxPK11PclZ1o
         jriOQimfkr/yvFo2DsVF3bO6UM1V7axPOuvHAiFO79JWBKYzcGlaZiarwTjnmVsNJMlj
         xoaxdmGHFkPwNjR/eINFsOpcTS7P2JFbYrrlqK3Dtw1QohkL66aTPiHjqUuy1PN8Fx0R
         tFQ8XMlzuG5R0MgSZvYCtJHVH/65n1mxzgoUX/zGfDYaZ5lCYcBFhH5Yl9o+TK9NoWmL
         HemaJd35cw1IEThcBZ4CVJc/nUQOTCA/1pQndGA2oSv6YsFz0eG5mQHPlX83zgPOjs31
         LnPA==
X-Gm-Message-State: AOAM5315d9u6qPYOfe/pH63cdWpAaZReNxB8kE6ybXce9nJ+sJrFi7Ri
        TeO/n5V78liV5AmkGA9AtyI=
X-Google-Smtp-Source: ABdhPJyRtzEQ0zrB4ssCNF2Lum4eb9CTSkp8QDXZ2epO9ier7+prbvQUra55DFM6RqCaS5GtPOEC2w==
X-Received: by 2002:a17:906:15c2:: with SMTP id l2mr1447853ejd.348.1622762081595;
        Thu, 03 Jun 2021 16:14:41 -0700 (PDT)
Received: from [192.168.1.15] ([151.29.179.73])
        by smtp.gmail.com with ESMTPSA id kb20sm2029419ejc.58.2021.06.03.16.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 16:14:41 -0700 (PDT)
Message-ID: <7685a1c104bfa0c1757d37cb74d95bbc6b5b4de6.camel@gmail.com>
Subject: Re: [PATCH v6 10/20] perf record: Introduce --threads=<spec>
 command line option
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Date:   Fri, 04 Jun 2021 01:14:39 +0200
In-Reply-To: <59a8bd9c18b70150919c44c95c551569a7c58bb0.1622025774.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1622025774.git.alexey.v.bayduraev@linux.intel.com>
         <59a8bd9c18b70150919c44c95c551569a7c58bb0.1622025774.git.alexey.v.bayduraev@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

the parameter provided to --thread is not checked. If an invalid value is
inserted, it will crash.

On Wed, 2021-05-26 at 13:53 +0300, Alexey Bayduraev wrote:
> Provide --threads option in perf record command line interface.
> The option can have a value in the form of masks that specify
> cpus to be monitored with data streaming threads and its layout
> in system topology. The masks can be filtered using cpu mask
> provided via -C option.
> 
> The specification value can be user defined list of masks. Masks
> separated by colon define cpus to be monitored by one thread and
> affinity mask of that thread is separated by slash. For example:
> <cpus mask 1>/<affinity mask 1>:<cpu mask 2>/<affinity mask 2>
> specifies parallel threads layout that consists of two threads
> with corresponding assigned cpus to be monitored.
> 
> The specification value can be a string e.g. "cpu", "core" or
> "socket" meaning creation of data streaming thread for every
> cpu or core or socket to monitor distinct cpus or cpus grouped
> by core or socket.
> 
> The option provided with no or empty value defaults to per-cpu
> parallel threads layout creating data streaming thread for every
> cpu being monitored.
> 
> Feature design and implementation are based on prototypes [1], [2].
> 
> [1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -
> b perf/record_threads
> [2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/
> 
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Acked-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 347 +++++++++++++++++++++++++++++++++++-
>  tools/perf/util/record.h    |   1 +
>  2 files changed, 346 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index e118efe21ba7..a54d72475629 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -51,6 +51,7 @@
>  #include "util/evlist-hybrid.h"
>  #include "asm/bug.h"
>  #include "perf.h"
> +#include "cputopo.h"
>  
>  #include <errno.h>
>  #include <inttypes.h>
> @@ -122,6 +123,20 @@ static const char *thread_msg_tags[THREAD_MSG__MAX] = {
>         "UNDEFINED", "READY"
>  };
>  
> +enum thread_spec {
> +       THREAD_SPEC__UNDEFINED = 0,
> +       THREAD_SPEC__CPU,
> +       THREAD_SPEC__CORE,
> +       THREAD_SPEC__SOCKET,
> +       THREAD_SPEC__NUMA,
> +       THREAD_SPEC__USER,
> +       THREAD_SPEC__MAX,
> +};
> +
> +static const char *thread_spec_tags[THREAD_SPEC__MAX] = {
> +       "undefined", "cpu", "core", "socket", "numa", "user"
> +};
> +
>  struct record {
>         struct perf_tool        tool;
>         struct record_opts      opts;
> @@ -2721,6 +2736,70 @@ static void record__thread_mask_free(struct thread_mask
> *mask)
>         record__mmap_cpu_mask_free(&mask->affinity);
>  }
>  
> +static int record__thread_mask_or(struct thread_mask *dest, struct
> thread_mask *src1,
> +                                  struct thread_mask *src2)
> +{
> +       if (src1->maps.nbits != src2->maps.nbits ||
> +           dest->maps.nbits != src1->maps.nbits ||
> +           src1->affinity.nbits != src2->affinity.nbits ||
> +           dest->affinity.nbits != src1->affinity.nbits)
> +               return -EINVAL;
> +
> +       bitmap_or(dest->maps.bits, src1->maps.bits,
> +                 src2->maps.bits, src1->maps.nbits);
> +       bitmap_or(dest->affinity.bits, src1->affinity.bits,
> +                 src2->affinity.bits, src1->affinity.nbits);
> +
> +       return 0;
> +}
> +
> +static int record__thread_mask_intersects(struct thread_mask *mask_1, struct
> thread_mask *mask_2)
> +{
> +       int res1, res2;
> +
> +       if (mask_1->maps.nbits != mask_2->maps.nbits ||
> +           mask_1->affinity.nbits != mask_2->affinity.nbits)
> +               return -EINVAL;
> +
> +       res1 = bitmap_intersects(mask_1->maps.bits, mask_2->maps.bits,
> +                                mask_1->maps.nbits);
> +       res2 = bitmap_intersects(mask_1->affinity.bits, mask_2->affinity.bits,
> +                                mask_1->affinity.nbits);
> +       if (res1 || res2)
> +               return 1;
> +
> +       return 0;
> +}
> +
> +static int record__parse_threads(const struct option *opt, const char *str,
> int unset)
> +{
> +       int s;
> +       struct record_opts *opts = opt->value;
> +
> +       if (unset || !str || !strlen(str)) {
> +               opts->threads_spec = THREAD_SPEC__CPU;
> +       } else {
> +               for (s = 1; s < THREAD_SPEC__MAX; s++) {
> +                       if (s == THREAD_SPEC__USER) {
> +                               opts->threads_user_spec = strdup(str);
> +                               opts->threads_spec = THREAD_SPEC__USER;
> +                               break;
> +                       }
> +                       if (!strncasecmp(str, thread_spec_tags[s],
> strlen(thread_spec_tags[s]))) {
> +                               opts->threads_spec = s;
> +                               break;
> +                       }
> +               }
> +       }
> +
> +       pr_debug("threads_spec: %s", thread_spec_tags[opts->threads_spec]);
> +       if (opts->threads_spec == THREAD_SPEC__USER)
> +               pr_debug("=[%s]", opts->threads_user_spec);
> +       pr_debug("\n");
> +
> +       return 0;
> +}
> +
>  static int parse_output_max_size(const struct option *opt,
>                                  const char *str, int unset)
>  {
> @@ -3164,6 +3243,9 @@ static struct option __record_options[] = {
>                      "\t\t\t  Optionally send control command completion
> ('ack\\n') to ack-fd descriptor.\n"
>                      "\t\t\t  Alternatively, ctl-fifo / ack-fifo will be
> opened and used as ctl-fd / ack-fd.",
>                       parse_control_option),
> +       OPT_CALLBACK_OPTARG(0, "threads", &record.opts, NULL, "spec",
> +                           "write collected trace data into several data
> files using parallel threads",
> +                           record__parse_threads),
>         OPT_END()
>  };
>  
> @@ -3177,6 +3259,17 @@ static void record__mmap_cpu_mask_init(struct
> mmap_cpu_mask *mask, struct perf_c
>                 set_bit(cpus->map[c], mask->bits);
>  }
>  
> +static void record__mmap_cpu_mask_init_spec(struct mmap_cpu_mask *mask, char
> *mask_spec)
> +{
> +       struct perf_cpu_map *cpus;
> +
> +       cpus = perf_cpu_map__new(mask_spec);
> +       if (cpus) {
> +               record__mmap_cpu_mask_init(mask, cpus);
> +               perf_cpu_map__put(cpus);
> +       }
> +}
> +
>  static int record__alloc_thread_masks(struct record *rec, int nr_threads, int
> nr_bits)
>  {
>         int t, ret;
> @@ -3196,6 +3289,229 @@ static int record__alloc_thread_masks(struct record
> *rec, int nr_threads, int nr
>  
>         return 0;
>  }
> +
> +static int record__init_thread_cpu_masks(struct record *rec, struct
> perf_cpu_map *cpus)
> +{
> +       int t, ret, nr_cpus = perf_cpu_map__nr(cpus);
> +
> +       ret = record__alloc_thread_masks(rec, nr_cpus, cpu__max_cpu());
> +       if (ret)
> +               return ret;
> +
> +       rec->nr_threads = nr_cpus;
> +       pr_debug("threads: nr_threads=%d\n", rec->nr_threads);
> +
> +       for (t = 0; t < rec->nr_threads; t++) {
> +               set_bit(cpus->map[t], rec->thread_masks[t].maps.bits);
> +               pr_debug("thread_masks[%d]: maps mask [%d]\n", t, cpus-
> >map[t]);
> +               set_bit(cpus->map[t], rec->thread_masks[t].affinity.bits);
> +               pr_debug("thread_masks[%d]: affinity mask [%d]\n", t, cpus-
> >map[t]);
> +       }
> +
> +       return 0;
> +}
> +
> +static int record__init_thread_masks_spec(struct record *rec, struct
> perf_cpu_map *cpus,
> +                                         char **maps_spec, char
> **affinity_spec, u32 nr_spec)
> +{
> +       u32 s;
> +       int ret = 0, nr_threads = 0;
> +       struct mmap_cpu_mask cpus_mask;
> +       struct thread_mask thread_mask, full_mask, *prev_masks;
> +
> +       ret = record__mmap_cpu_mask_alloc(&cpus_mask, cpu__max_cpu());
> +       if (ret)
> +               goto out;
> +       record__mmap_cpu_mask_init(&cpus_mask, cpus);
> +       ret = record__thread_mask_alloc(&thread_mask, cpu__max_cpu());
> +       if (ret)
> +               goto out_free_cpu_mask;
> +       ret = record__thread_mask_alloc(&full_mask, cpu__max_cpu());
> +       if (ret)
> +               goto out_free_thread_mask;
> +       record__thread_mask_clear(&full_mask);
> +
> +       for (s = 0; s < nr_spec; s++) {
> +               record__thread_mask_clear(&thread_mask);
> +
> +               record__mmap_cpu_mask_init_spec(&thread_mask.maps,
> maps_spec[s]);
> +               record__mmap_cpu_mask_init_spec(&thread_mask.affinity,
> affinity_spec[s]);
> +
> +               if (!bitmap_and(thread_mask.maps.bits, thread_mask.maps.bits,
> +                               cpus_mask.bits, thread_mask.maps.nbits) ||
> +                   !bitmap_and(thread_mask.affinity.bits,
> thread_mask.affinity.bits,
> +                               cpus_mask.bits, thread_mask.affinity.nbits))
> +                       continue;
> +
> +               ret = record__thread_mask_intersects(&thread_mask,
> &full_mask);
> +               if (ret)
> +                       goto out_free_full_mask;
> +               record__thread_mask_or(&full_mask, &full_mask, &thread_mask);
> +
> +               prev_masks = rec->thread_masks;
> +               rec->thread_masks = realloc(rec->thread_masks,
> +                                           (nr_threads + 1) * sizeof(struct
> thread_mask));
> +               if (!rec->thread_masks) {
> +                       pr_err("Failed to allocate thread masks\n");
> +                       rec->thread_masks = prev_masks;
> +                       ret = -ENOMEM;
> +                       goto out_free_full_mask;
> +               }
> +               rec->thread_masks[nr_threads] = thread_mask;
> +               if (verbose) {
> +                       pr_debug("thread_masks[%d]: addr=", nr_threads);
> +                       mmap_cpu_mask__scnprintf(&rec-
> >thread_masks[nr_threads].maps, "maps");
> +                       pr_debug("thread_masks[%d]: addr=", nr_threads);
> +                       mmap_cpu_mask__scnprintf(&rec-
> >thread_masks[nr_threads].affinity,
> +                                                "affinity");
> +               }
> +               nr_threads++;
> +               ret = record__thread_mask_alloc(&thread_mask, cpu__max_cpu());
> +               if (ret)
> +                       goto out_free_full_mask;
> +       }
> +

Here it can be checked if nr_threads is > 0. Otherwise, print an error message
epxlaining the reason and return an error.
nr_threads can be 0 if the user inserts out-of-range CPUs in the spec, e.g. 
"--threads=15/17" on a 4 CPU machine.

> +       rec->nr_threads = nr_threads;
> +       pr_debug("threads: nr_threads=%d\n", rec->nr_threads);
> +
> +out_free_full_mask:
> +       record__thread_mask_free(&full_mask);
> +out_free_thread_mask:
> +       record__thread_mask_free(&thread_mask);
> +out_free_cpu_mask:
> +       record__mmap_cpu_mask_free(&cpus_mask);
> +out:
> +       return ret;
> +}
> +
> +static int record__init_thread_core_masks(struct record *rec, struct
> perf_cpu_map *cpus)
> +{
> +       int ret;
> +       struct cpu_topology *topo;
> +
> +       topo = cpu_topology__new();
> +       if (!topo)
> +               return -EINVAL;
> +
> +       ret = record__init_thread_masks_spec(rec, cpus, topo->thread_siblings,
> +                                            topo->thread_siblings, topo-
> >thread_sib);
> +       cpu_topology__delete(topo);
> +
> +       return ret;
> +}
> +
> +static int record__init_thread_socket_masks(struct record *rec, struct
> perf_cpu_map *cpus)
> +{
> +       int ret;
> +       struct cpu_topology *topo;
> +
> +       topo = cpu_topology__new();
> +       if (!topo)
> +               return -EINVAL;
> +
> +       ret = record__init_thread_masks_spec(rec, cpus, topo->core_siblings,
> +                                            topo->core_siblings, topo-
> >core_sib);
> +       cpu_topology__delete(topo);
> +
> +       return ret;
> +}
> +
> +static int record__init_thread_numa_masks(struct record *rec, struct
> perf_cpu_map *cpus)
> +{
> +       u32 s;
> +       int ret;
> +       char **spec;
> +       struct numa_topology *topo;
> +
> +       topo = numa_topology__new();
> +       if (!topo)
> +               return -EINVAL;
> +       spec = zalloc(topo->nr * sizeof(char *));
> +       if (!spec) {
> +               ret = -ENOMEM;
> +               goto out_delete_topo;
> +       }
> +       for (s = 0; s < topo->nr; s++)
> +               spec[s] = topo->nodes[s].cpus;
> +
> +       ret = record__init_thread_masks_spec(rec, cpus, spec, spec, topo->nr);
> +
> +       zfree(&spec);
> +
> +out_delete_topo:
> +       numa_topology__delete(topo);
> +
> +       return ret;
> +}
> +
> +static int record__init_thread_user_masks(struct record *rec, struct
> perf_cpu_map *cpus)
> +{
> +       int t, ret;
> +       u32 s, nr_spec = 0;
> +       char **maps_spec = NULL, **affinity_spec = NULL, **prev_spec;
> +       char *spec, *spec_ptr, *user_spec, *mask, *mask_ptr;
> +
> +       for (t = 0, user_spec = (char *)rec->opts.threads_user_spec; ; t++,
> user_spec = NULL) {
> +               spec = strtok_r(user_spec, ":", &spec_ptr);
> +               if (spec == NULL)
> +                       break;
> +               pr_debug(" spec[%d]: %s\n", t, spec);
> +               mask = strtok_r(spec, "/", &mask_ptr);
> +               if (mask == NULL)
> +                       break;
> +               pr_debug("  maps mask: %s\n", mask);
> +               prev_spec = maps_spec;
> +               maps_spec = realloc(maps_spec, (nr_spec + 1) * sizeof(char
> *));
> +               if (!maps_spec) {
> +                       pr_err("Failed to realloc maps_spec\n");
> +                       maps_spec = prev_spec;
> +                       ret = -ENOMEM;
> +                       goto out_free_all_specs;
> +               }
> +               maps_spec[nr_spec] = strdup(mask);
> +               if (!maps_spec[nr_spec]) {
> +                       pr_err("Failed to alloc maps_spec[%d]\n", nr_spec);
> +                       ret = -ENOMEM;
> +                       goto out_free_all_specs;
> +               }
> +               mask = strtok_r(NULL, "/", &mask_ptr);
> +               if (mask == NULL)

I think this should be a parse failure and return an error, not just skip to the
next one. 
Furthermore, maps_spec[nr_spec] should be freed before breaking/exiting.

Thanks,
Riccardo

> +                       break;
> +               pr_debug("  affinity mask: %s\n", mask);
> +               prev_spec = affinity_spec;
> +               affinity_spec = realloc(affinity_spec, (nr_spec + 1) *
> sizeof(char *));
> +               if (!affinity_spec) {
> +                       pr_err("Failed to realloc affinity_spec\n");
> +                       affinity_spec = prev_spec;
> +                       free(maps_spec[nr_spec]);
> +                       ret = -ENOMEM;
> +                       goto out_free_all_specs;
> +               }
> +               affinity_spec[nr_spec] = strdup(mask);
> +               if (!affinity_spec[nr_spec]) {
> +                       pr_err("Failed to alloc affinity_spec[%d]\n",
> nr_spec);
> +                       free(maps_spec[nr_spec]);
> +                       ret = -ENOMEM;
> +                       goto out_free_all_specs;
> +               }
> +               nr_spec++;
> +       }
> +
> +       ret = record__init_thread_masks_spec(rec, cpus, maps_spec,
> affinity_spec, nr_spec);
> +
> +out_free_all_specs:
> +       for (s = 0; s < nr_spec; s++) {
> +               if (maps_spec)
> +                       free(maps_spec[s]);
> +               if (affinity_spec)
> +                       free(affinity_spec[s]);
> +       }
> +       free(affinity_spec);
> +       free(maps_spec);
> +
> +       return ret;
> +}
> +
>  static int record__init_thread_default_masks(struct record *rec, struct
> perf_cpu_map *cpus)
>  {
>         int ret;
> @@ -3213,9 +3529,33 @@ static int record__init_thread_default_masks(struct
> record *rec, struct perf_cpu
>  
>  static int record__init_thread_masks(struct record *rec)
>  {
> +       int ret = 0;
>         struct perf_cpu_map *cpus = rec->evlist->core.cpus;
>  
> -       return record__init_thread_default_masks(rec, cpus);
> +       if (!record__threads_enabled(rec))
> +               return record__init_thread_default_masks(rec, cpus);
> +
> +       switch (rec->opts.threads_spec) {
> +       case THREAD_SPEC__CPU:
> +               ret = record__init_thread_cpu_masks(rec, cpus);
> +               break;
> +       case THREAD_SPEC__CORE:
> +               ret = record__init_thread_core_masks(rec, cpus);
> +               break;
> +       case THREAD_SPEC__SOCKET:
> +               ret = record__init_thread_socket_masks(rec, cpus);
> +               break;
> +       case THREAD_SPEC__NUMA:
> +               ret = record__init_thread_numa_masks(rec, cpus);
> +               break;
> +       case THREAD_SPEC__USER:
> +               ret = record__init_thread_user_masks(rec, cpus);
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return ret;
>  }
>  
>  static int record__fini_thread_masks(struct record *rec)
> @@ -3466,7 +3806,10 @@ int cmd_record(int argc, const char **argv)
>  
>         err = record__init_thread_masks(rec);
>         if (err) {
> -               pr_err("record__init_thread_masks failed, error %d\n", err);
> +               if (err > 0)
> +                       pr_err("ERROR: parallel data streaming masks (--
> threads) intersect.\n");
> +               else
> +                       pr_err("record__init_thread_masks failed, error %d\n",
> err);
>                 goto out;
>         }
>  
> diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
> index 4d68b7e27272..3da156498f47 100644
> --- a/tools/perf/util/record.h
> +++ b/tools/perf/util/record.h
> @@ -78,6 +78,7 @@ struct record_opts {
>         int           ctl_fd_ack;
>         bool          ctl_fd_close;
>         int           threads_spec;
> +       const char    *threads_user_spec;
>  };
>  
>  extern const char * const *record_usage;


