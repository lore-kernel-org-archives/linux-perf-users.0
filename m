Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB51C5479D
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Jan 2023 15:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjAFPMS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Jan 2023 10:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbjAFPMP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Jan 2023 10:12:15 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BEA77D34
        for <linux-perf-users@vger.kernel.org>; Fri,  6 Jan 2023 07:12:14 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id o21so1788137pjw.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Jan 2023 07:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5xVMjZC40s+T1CFsdFSwBRfl09heYK9MQl9tX7e5Cpw=;
        b=TnK9hT+c/rFv/XIRV/MbbK/llGR0/XIA4/cwX9DG2PO48vLquZcLeL3uV5YykaK2G8
         lloggGj5Xgufw30fVOPPd9UYXWq05tBAmSKisz2YSa3N6zy8XWcqALUdgRomvzXVAhWp
         n3tP1yC3nU+QVFo+3w5Kb0sPrYw1n1kKDj4WpIeYb4EF5iR1wiWqXDn1LK1LqRjAg+eQ
         dt7k7PBQ9iA3OQTSEOB3NDwhph8dftXqYgL+MqA9o/E78+aeUjVfn5acdXIyTuYINQpo
         gF2CirSEipJtCSGvWtQXt5ys252ipdj5e0eCsXjokt/zmlPP+yqBKaPdBqQFuf7HnECk
         iZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xVMjZC40s+T1CFsdFSwBRfl09heYK9MQl9tX7e5Cpw=;
        b=dJ6uwJ4SOlFLwjv6omlbzwuBxasR07wVN8WVTSg41d0Ny7ui4/gDX2CE/1ofc9IGPi
         /7FM798BcnXXuopWU19+nhgrzK4OHRtY+mRaFjFQqPUU9AZk1zsf/8Uy9exqgnrgxjCT
         eicqKV2EHx0leA1e1gHxr7aG7pG1lULhJ5FAbuoEBxsoan95YumJRFXWv3JUE5bFJJmh
         wK5SzYRc1QjcTFsJKvze+RT5QMQr+3ns85iL6wGBMLf93ClgLqp+OpYWvmIGTd4wJroa
         LnTb7OswTKLJDVrz+YIZZ1eppE5T45ndsikX1206J8nazzxQKk9HLkc6cqHHq8JeZmqr
         yYQg==
X-Gm-Message-State: AFqh2koUOowNAZ7+GDVzVsZ/3v7jarQZ0wg093n3xAB16eUYxlJqCE4g
        r+phWFn/+ZGFon0as9mo1DeVd90jYKmk3rNgRnXWKA==
X-Google-Smtp-Source: AMrXdXsKXTWBOy1Q8q1m6Ha+wg1bhsOCIfvQ0YA0iW+v80gcwiY6l/mBDuGj9tuGt8DX/JAMnSFdQ6CJTRaOoM/P7A8=
X-Received: by 2002:a17:902:6b05:b0:18c:5dae:6f2 with SMTP id
 o5-20020a1709026b0500b0018c5dae06f2mr3196653plk.24.1673017933757; Fri, 06 Jan
 2023 07:12:13 -0800 (PST)
MIME-Version: 1.0
References: <20230106142537.607399-1-irogers@google.com> <Y7g2YXNaP0VM+F1o@kernel.org>
In-Reply-To: <Y7g2YXNaP0VM+F1o@kernel.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 6 Jan 2023 15:12:02 +0000
Message-ID: <CAJ9a7Vg5-7c_p=6ga0my7cU2P9=N2N8YNMzUrd3kV18eX+ba2w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf build: Properly guard libbpf includes
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, 6 Jan 2023 at 14:55, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Fri, Jan 06, 2023 at 06:25:36AM -0800, Ian Rogers escreveu:
> > Including libbpf header files should be guarded by
> > HAVE_LIBBPF_SUPPORT. In bpf_counter.h, move the skeleton utilities
> > under HAVE_BPF_SKEL.
> >
> > Fixes: d6a735ef3277 ("perf bpf_counter: Move common functions to bpf_counter.h")
> > Reported-by: Mike Leach <mike.leach@linaro.org>
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Can this be done in a way that reduces patch size?
>
> - Arnaldo
>
> > ---
> >  tools/perf/builtin-trace.c    |  2 +
> >  tools/perf/util/bpf_counter.h | 85 ++++++++++++++++++-----------------
> >  2 files changed, 46 insertions(+), 41 deletions(-)
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 86e06f136f40..d21fe0f32a6d 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -16,7 +16,9 @@
> >
> >  #include "util/record.h"
> >  #include <api/fs/tracing_path.h>
> > +#ifdef HAVE_LIBBPF_SUPPORT
> >  #include <bpf/bpf.h>
> > +#endif
> >  #include "util/bpf_map.h"
> >  #include "util/rlimit.h"
> >  #include "builtin.h"
> > diff --git a/tools/perf/util/bpf_counter.h b/tools/perf/util/bpf_counter.h
> > index 4dbf26408b69..9113c8bf5cb0 100644
> > --- a/tools/perf/util/bpf_counter.h
> > +++ b/tools/perf/util/bpf_counter.h
> > @@ -4,9 +4,12 @@
> >
> >  #include <linux/list.h>
> >  #include <sys/resource.h>
> > +
> > +#ifdef HAVE_LIBBPF_SUPPORT
> >  #include <bpf/bpf.h>
> >  #include <bpf/btf.h>
> >  #include <bpf/libbpf.h>
> > +#endif
> >
> >  struct evsel;
> >  struct target;
> > @@ -42,6 +45,47 @@ int bpf_counter__read(struct evsel *evsel);
> >  void bpf_counter__destroy(struct evsel *evsel);
> >  int bpf_counter__install_pe(struct evsel *evsel, int cpu_map_idx, int fd);
> >
> > +static inline __u32 bpf_link_get_id(int fd)
> > +{
> > +     struct bpf_link_info link_info = { .id = 0, };
> > +     __u32 link_info_len = sizeof(link_info);
> > +
> > +     bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
> > +     return link_info.id;
> > +}
> > +
> > +static inline __u32 bpf_link_get_prog_id(int fd)
> > +{
> > +     struct bpf_link_info link_info = { .id = 0, };
> > +     __u32 link_info_len = sizeof(link_info);
> > +
> > +     bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
> > +     return link_info.prog_id;
> > +}
> > +
> > +static inline __u32 bpf_map_get_id(int fd)
> > +{
> > +     struct bpf_map_info map_info = { .id = 0, };
> > +     __u32 map_info_len = sizeof(map_info);
> > +
> > +     bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
> > +     return map_info.id;
> > +}
> > +
> > +/* trigger the leader program on a cpu */
> > +static inline int bperf_trigger_reading(int prog_fd, int cpu)
> > +{
> > +     DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
> > +                         .ctx_in = NULL,
> > +                         .ctx_size_in = 0,
> > +                         .flags = BPF_F_TEST_RUN_ON_CPU,
> > +                         .cpu = cpu,
> > +                         .retval = 0,
> > +             );
> > +
> > +     return bpf_prog_test_run_opts(prog_fd, &opts);
> > +}
> > +
> >  #else /* HAVE_BPF_SKEL */
> >
> >  #include <linux/err.h>
> > @@ -87,45 +131,4 @@ static inline void set_max_rlimit(void)
> >       setrlimit(RLIMIT_MEMLOCK, &rinf);
> >  }
> >
> > -static inline __u32 bpf_link_get_id(int fd)
> > -{
> > -     struct bpf_link_info link_info = { .id = 0, };
> > -     __u32 link_info_len = sizeof(link_info);
> > -
> > -     bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
> > -     return link_info.id;
> > -}
> > -
> > -static inline __u32 bpf_link_get_prog_id(int fd)
> > -{
> > -     struct bpf_link_info link_info = { .id = 0, };
> > -     __u32 link_info_len = sizeof(link_info);
> > -
> > -     bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
> > -     return link_info.prog_id;
> > -}
> > -
> > -static inline __u32 bpf_map_get_id(int fd)
> > -{
> > -     struct bpf_map_info map_info = { .id = 0, };
> > -     __u32 map_info_len = sizeof(map_info);
> > -
> > -     bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
> > -     return map_info.id;
> > -}
> > -
> > -/* trigger the leader program on a cpu */
> > -static inline int bperf_trigger_reading(int prog_fd, int cpu)
> > -{
> > -     DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
> > -                         .ctx_in = NULL,
> > -                         .ctx_size_in = 0,
> > -                         .flags = BPF_F_TEST_RUN_ON_CPU,
> > -                         .cpu = cpu,
> > -                         .retval = 0,
> > -             );
> > -
> > -     return bpf_prog_test_run_opts(prog_fd, &opts);
> > -}
> > -
> >  #endif /* __PERF_BPF_COUNTER_H */
> > --
> > 2.39.0.314.g84b9a713c41-goog
>

Tested-by: Mike Leach <mike.leach@linaro.org>

> --
>
> - Arnaldo


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
