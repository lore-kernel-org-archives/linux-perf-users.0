Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C2B302775
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Oct 2025 20:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761424204; cv=none; b=L6geHGg8CFxPB+uYOrZ1SBtachY0oQn3f5dZ9p958E8a+nGCAquQN9rk98B/fUsdotkgapWYbO9ghSRTcwuMW0KcLZij1PdFytikLXVBroA/+ccNhO9L6Lzk4opxVYh/c43QtKDLBXzAqmN9Ymrp6UYetY7W1SsH5tonVFWh8IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761424204; c=relaxed/simple;
	bh=UpPBBRo7/X6f1t+CtHQSKjLCXTLpZBse52uCRp1hEZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyPKquXtd2xYAzvZajOQk0bNMnvOeHIDP932IZAt28nv8XvGX4kaLaDpsgsfuUE9LoSo1P23XiJ7dmD6k3s+xjnTF5wMWLrW/0St+JAl4QyZje8UmDI3+PH5uuU75s7Tx0ZPo+xOsOQd35JUvK45Mpfky/1MkuiGqP5e9K/8i4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uYxwuqwH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uYxwuqwH"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-27d67abd215so152405ad.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Oct 2025 13:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761424201; x=1762029001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJhRqlwmiH3f/yG21RCdpA5THgy+qYRFYxl1VtGsxCE=;
        b=uYxwuqwHfRIIyHl5Q67f/axJyCUrgBZG0eBedyOmgrBTAyBJ6NzwerHaJKZzaNi6NJ
         T/TTTKjPUUFwhJheKJhbvJQouS4e1e4slWYyU9M06MfdrOyzqBufn869CHEtpDOiWJkD
         VzwnLNo/JJT1E9DVfybEI5qAU8tXOPASUIRzVw/rOUSpSScuR0VLnCtfWNRGoagWq61r
         BN3YiZZWHaqyc8ReO6xtf7LGex53VqnalwdXMWlqTXPKkcijH6hHDgKhprfv0ePVFefV
         25UJgB9zShW+jxIgs0dKV9s+meMvJixPQVkZG/p8J6oPvsoRXBsSr6Xc4toZtaRafwEO
         DJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761424201; x=1762029001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJhRqlwmiH3f/yG21RCdpA5THgy+qYRFYxl1VtGsxCE=;
        b=edTf0NZL39o+uUG3fpRaYFsscg+IUKfUcxf0BO4Gz1W17e4Dv8z9cyBj2QoQEkD579
         8L18jPW/3+xJIzydXwk0QftT3pQalF9+48kIbkTkVPOS6OU7/JFV025Z+qaiQk1+LlHx
         4yiyMb7N+5cUbM7n3SEwqzXtGvd0DRNXtrqgfcH/bWtY3011Intm9Gh9YimxEzIy9/nz
         CMrbARHJMv8rCQyAUkeB2v8eaq+qBdUPjgVyHMd4ysPyQApB2eZdb1X3YGooQLOu/ybV
         x8VRYoWlnPL4ANLuE+7GY5WUsiyhsCWikOSYmfd/y0ES6qDgkQG9nPi7ce9wCb4FhhpL
         mE+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPjhJmsndtgWuOetFEiCvQQtbowVzdH6M2V79Q/EI6bxb1DY29LLuD862QYS4Drm2JWSH/vYoJxuR9E9cLmKQR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Jjv5XTs2oBgA+P2kl/r4Mq9giJLgCwvX0FyJT8FYK/zq0C9L
	TXXj2trtLLkia/DHxdJiZD7ENrrAn14JbwisvMnyGkGxYJnupi3eVhytKwDDKNkdYv2TMedNlry
	qofldKJ1ttXdKync6k8OJzQk81FkD7bEaBI55GHjV
X-Gm-Gg: ASbGncsTDCpfTuK+DV6VDgyNb9i+ZEY+9aLfmbQ+GTfAGb3xYMTKvVaU1IRdUIXLMGc
	bzvGyX6H/YZsqpTEEMIWPTMjxYzHY+mJxGeXf2fydhviKjELF83w/yHry6DAavPf5XhAkymqh2w
	+NzRzj0nkiTsHlqIOzQSa7QCsxtbvTGyqWYg/5/dUGaqObcSyJBbxLVtZac3LGZQzv4gTS+0NSc
	0Y4BidWiVB5gD4N1bEhAmyA7w0OzXJZqYVmDt9LFzETO/wd26YuYMv5Fp/TRBLPLZAm8hlGaTYw
	M/y1CA==
X-Google-Smtp-Source: AGHT+IHWr2JPxH7y9j+mQC3VSxMbWYJGSiFZO3Di9KI+6bfHTdwSoy+HJYRlE7XL9WajetVQ++MdeVvngfZjrSZjASU=
X-Received: by 2002:a17:903:17cc:b0:290:b527:97ec with SMTP id
 d9443c01a7336-29497cb7435mr3083615ad.5.1761424200944; Sat, 25 Oct 2025
 13:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025165019.1109315-1-irogers@google.com> <aP0KyW5MmTL3yTtu@google.com>
In-Reply-To: <aP0KyW5MmTL3yTtu@google.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 25 Oct 2025 13:29:48 -0700
X-Gm-Features: AWmQ_bkXGEyE04xBQfH-AIAEMMx3xHiHPbiZW3gstjMDXAsKRtB3yxiRyBTHcik
Message-ID: <CAP-5=fWpGm9OhWFjrm9qZL8Ja-uqU76x60gB9MUU++JX6Nuyug@mail.gmail.com>
Subject: Re: [PATCH v2] perf stat: Add/fix bperf cgroup max events workarounds
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 10:37=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi Ian,
>
> On Sat, Oct 25, 2025 at 09:50:19AM -0700, Ian Rogers wrote:
> > Commit b8308511f6e0 bumped the max events to 1024 but this results in
> > BPF verifier issues if the number of command line events is too
> > large. Workaround this by:
> >
> > 1) moving the constants to a header file to share between BPF and perf
> >    C code,
> > 2) testing that the maximum number of events doesn't cause BPF
> >    verifier issues in debug builds,
> > 3) lower the max events from 1024 to 128,
> > 4) in perf stat, if there are more events than the BPF counters can
> >    support then disable BPF counter usage.
> >
> > The rodata setup is factored into its own function to avoid
> > duplicating it in the testing code.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Fixes: b8308511f6e0 ("perf stat bperf cgroup: Increase MAX_EVENTS from =
32 to 1024")
> > ---
> > v2: Add missing header file
> > ---
> >  tools/perf/builtin-stat.c                   | 13 +++-
> >  tools/perf/util/bpf_counter_cgroup.c        | 79 +++++++++++++++------
> >  tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 18 +++--
> >  tools/perf/util/bpf_skel/bperf_cgroup.h     | 15 ++++
> >  4 files changed, 91 insertions(+), 34 deletions(-)
> >  create mode 100644 tools/perf/util/bpf_skel/bperf_cgroup.h
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 3c3188a57016..130515f87ee0 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -96,6 +96,10 @@
> >  #include <perf/evlist.h>
> >  #include <internal/threadmap.h>
> >
> > +#ifdef HAVE_BPF_SKEL
> > +#include "util/bpf_skel/bperf_cgroup.h"
> > +#endif
> > +
> >  #define DEFAULT_SEPARATOR    " "
> >  #define FREEZE_ON_SMI_PATH   "bus/event_source/devices/cpu/freeze_on_s=
mi"
> >
> > @@ -2852,7 +2856,14 @@ int cmd_stat(int argc, const char **argv)
> >                       goto out;
> >               }
> >       }
> > -
> > +#ifdef HAVE_BPF_SKEL
> > +     if (target.use_bpf &&
> > +         (evsel_list->core.nr_entries / nr_cgroups) > BPERF_CGROUP__MA=
X_EVENTS) {
>
> I guess you also need to check if nr_cgroups is not zero.  Otherwise
> looks good to me.

Good catch! Fixed in v3.

Thanks,
Ian

> Thanks,
> Namhyung
>
> > +             pr_warning("Disabling BPF counters due to more events (%d=
) than the max (%d)\n",
> > +                        evsel_list->core.nr_entries / nr_cgroups, BPER=
F_CGROUP__MAX_EVENTS);
> > +             target.use_bpf =3D false;
> > +     }
> > +#endif // HAVE_BPF_SKEL
> >       evlist__warn_user_requested_cpus(evsel_list, target.cpu_list);
> >
> >       evlist__for_each_entry(evsel_list, counter) {
> > diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf=
_counter_cgroup.c
> > index 690be3ce3e11..68bd994c8880 100644
> > --- a/tools/perf/util/bpf_counter_cgroup.c
> > +++ b/tools/perf/util/bpf_counter_cgroup.c
> > @@ -27,6 +27,7 @@
> >  #include "cpumap.h"
> >  #include "thread_map.h"
> >
> > +#include "bpf_skel/bperf_cgroup.h"
> >  #include "bpf_skel/bperf_cgroup.skel.h"
> >
> >  static struct perf_event_attr cgrp_switch_attr =3D {
> > @@ -42,6 +43,55 @@ static struct bperf_cgroup_bpf *skel;
> >
> >  #define FD(evt, cpu) (*(int *)xyarray__entry(evt->core.fd, cpu, 0))
> >
> > +static void setup_rodata(struct bperf_cgroup_bpf *sk, int evlist_size)
> > +{
> > +     int map_size, total_cpus =3D cpu__max_cpu().cpu;
> > +
> > +     sk->rodata->num_cpus =3D total_cpus;
> > +     sk->rodata->num_events =3D evlist_size / nr_cgroups;
> > +
> > +     if (cgroup_is_v2("perf_event") > 0)
> > +             sk->rodata->use_cgroup_v2 =3D 1;
> > +
> > +     BUG_ON(evlist_size % nr_cgroups !=3D 0);
> > +
> > +     /* we need one copy of events per cpu for reading */
> > +     map_size =3D total_cpus * evlist_size / nr_cgroups;
> > +     bpf_map__set_max_entries(sk->maps.events, map_size);
> > +     bpf_map__set_max_entries(sk->maps.cgrp_idx, nr_cgroups);
> > +     /* previous result is saved in a per-cpu array */
> > +     map_size =3D evlist_size / nr_cgroups;
> > +     bpf_map__set_max_entries(sk->maps.prev_readings, map_size);
> > +     /* cgroup result needs all events (per-cpu) */
> > +     map_size =3D evlist_size;
> > +     bpf_map__set_max_entries(sk->maps.cgrp_readings, map_size);
> > +}
> > +
> > +static void test_max_events_program_load(void)
> > +{
> > +#ifndef NDEBUG
> > +     /*
> > +      * Test that the program verifies with the maximum number of even=
ts. If
> > +      * this test fails unfortunately perf needs recompiling with a lo=
wer
> > +      * BPERF_CGROUP__MAX_EVENTS to avoid BPF verifier issues.
> > +      */
> > +     int err, max_events =3D BPERF_CGROUP__MAX_EVENTS * nr_cgroups;
> > +     struct bperf_cgroup_bpf *test_skel =3D bperf_cgroup_bpf__open();
> > +
> > +     if (!test_skel) {
> > +             pr_err("Failed to open cgroup skeleton\n");
> > +             return;
> > +     }
> > +     setup_rodata(test_skel, max_events);
> > +     err =3D bperf_cgroup_bpf__load(test_skel);
> > +     if (err) {
> > +             pr_err("Failed to load cgroup skeleton with max events %d=
.\n",
> > +                     BPERF_CGROUP__MAX_EVENTS);
> > +     }
> > +     bperf_cgroup_bpf__destroy(test_skel);
> > +#endif
> > +}
> > +
> >  static int bperf_load_program(struct evlist *evlist)
> >  {
> >       struct bpf_link *link;
> > @@ -50,35 +100,18 @@ static int bperf_load_program(struct evlist *evlis=
t)
> >       int i, j;
> >       struct perf_cpu cpu;
> >       int total_cpus =3D cpu__max_cpu().cpu;
> > -     int map_size, map_fd;
> > -     int prog_fd, err;
> > +     int map_fd, prog_fd, err;
> > +
> > +     set_max_rlimit();
> > +
> > +     test_max_events_program_load();
> >
> >       skel =3D bperf_cgroup_bpf__open();
> >       if (!skel) {
> >               pr_err("Failed to open cgroup skeleton\n");
> >               return -1;
> >       }
> > -
> > -     skel->rodata->num_cpus =3D total_cpus;
> > -     skel->rodata->num_events =3D evlist->core.nr_entries / nr_cgroups=
;
> > -
> > -     if (cgroup_is_v2("perf_event") > 0)
> > -             skel->rodata->use_cgroup_v2 =3D 1;
> > -
> > -     BUG_ON(evlist->core.nr_entries % nr_cgroups !=3D 0);
> > -
> > -     /* we need one copy of events per cpu for reading */
> > -     map_size =3D total_cpus * evlist->core.nr_entries / nr_cgroups;
> > -     bpf_map__set_max_entries(skel->maps.events, map_size);
> > -     bpf_map__set_max_entries(skel->maps.cgrp_idx, nr_cgroups);
> > -     /* previous result is saved in a per-cpu array */
> > -     map_size =3D evlist->core.nr_entries / nr_cgroups;
> > -     bpf_map__set_max_entries(skel->maps.prev_readings, map_size);
> > -     /* cgroup result needs all events (per-cpu) */
> > -     map_size =3D evlist->core.nr_entries;
> > -     bpf_map__set_max_entries(skel->maps.cgrp_readings, map_size);
> > -
> > -     set_max_rlimit();
> > +     setup_rodata(skel, evlist->core.nr_entries);
> >
> >       err =3D bperf_cgroup_bpf__load(skel);
> >       if (err) {
> > diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/u=
til/bpf_skel/bperf_cgroup.bpf.c
> > index 18ab4d9b49ff..c2298a2decc9 100644
> > --- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > +++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
> > @@ -1,14 +1,12 @@
> >  // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >  // Copyright (c) 2021 Facebook
> >  // Copyright (c) 2021 Google
> > +#include "bperf_cgroup.h"
> >  #include "vmlinux.h"
> >  #include <bpf/bpf_helpers.h>
> >  #include <bpf/bpf_tracing.h>
> >  #include <bpf/bpf_core_read.h>
> >
> > -#define MAX_LEVELS  10  // max cgroup hierarchy level: arbitrary
> > -#define MAX_EVENTS  1024  // max events per cgroup: arbitrary
> > -
> >  // NOTE: many of map and global data will be modified before loading
> >  //       from the userspace (perf tool) using the skeleton helpers.
> >
> > @@ -97,7 +95,7 @@ static inline int get_cgroup_v1_idx(__u32 *cgrps, int=
 size)
> >       cgrp =3D BPF_CORE_READ(p, cgroups, subsys[perf_subsys_id], cgroup=
);
> >       level =3D BPF_CORE_READ(cgrp, level);
> >
> > -     for (cnt =3D 0; i < MAX_LEVELS; i++) {
> > +     for (cnt =3D 0; i < BPERF_CGROUP__MAX_LEVELS; i++) {
> >               __u64 cgrp_id;
> >
> >               if (i > level)
> > @@ -123,7 +121,7 @@ static inline int get_cgroup_v2_idx(__u32 *cgrps, i=
nt size)
> >       __u32 *elem;
> >       int cnt;
> >
> > -     for (cnt =3D 0; i < MAX_LEVELS; i++) {
> > +     for (cnt =3D 0; i < BPERF_CGROUP__MAX_LEVELS; i++) {
> >               __u64 cgrp_id =3D bpf_get_current_ancestor_cgroup_id(i);
> >
> >               if (cgrp_id =3D=3D 0)
> > @@ -148,17 +146,17 @@ static int bperf_cgroup_count(void)
> >       register int c =3D 0;
> >       struct bpf_perf_event_value val, delta, *prev_val, *cgrp_val;
> >       __u32 cpu =3D bpf_get_smp_processor_id();
> > -     __u32 cgrp_idx[MAX_LEVELS];
> > +     __u32 cgrp_idx[BPERF_CGROUP__MAX_LEVELS];
> >       int cgrp_cnt;
> >       __u32 key, cgrp;
> >       long err;
> >
> >       if (use_cgroup_v2)
> > -             cgrp_cnt =3D get_cgroup_v2_idx(cgrp_idx, MAX_LEVELS);
> > +             cgrp_cnt =3D get_cgroup_v2_idx(cgrp_idx, BPERF_CGROUP__MA=
X_LEVELS);
> >       else
> > -             cgrp_cnt =3D get_cgroup_v1_idx(cgrp_idx, MAX_LEVELS);
> > +             cgrp_cnt =3D get_cgroup_v1_idx(cgrp_idx, BPERF_CGROUP__MA=
X_LEVELS);
> >
> > -     for ( ; idx < MAX_EVENTS; idx++) {
> > +     for ( ; idx < BPERF_CGROUP__MAX_EVENTS; idx++) {
> >               if (idx =3D=3D num_events)
> >                       break;
> >
> > @@ -186,7 +184,7 @@ static int bperf_cgroup_count(void)
> >                       delta.enabled =3D val.enabled - prev_val->enabled=
;
> >                       delta.running =3D val.running - prev_val->running=
;
> >
> > -                     for (c =3D 0; c < MAX_LEVELS; c++) {
> > +                     for (c =3D 0; c < BPERF_CGROUP__MAX_LEVELS; c++) =
{
> >                               if (c =3D=3D cgrp_cnt)
> >                                       break;
> >
> > diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.h b/tools/perf/util/=
bpf_skel/bperf_cgroup.h
> > new file mode 100644
> > index 000000000000..3fb84b19d39a
> > --- /dev/null
> > +++ b/tools/perf/util/bpf_skel/bperf_cgroup.h
> > @@ -0,0 +1,15 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > +/* Data structures shared between BPF and tools. */
> > +#ifndef __BPERF_CGROUP_H
> > +#define __BPERF_CGROUP_H
> > +
> > +// These constants impact code size of bperf_cgroup.bpf.c that may res=
ult in BPF
> > +// verifier issues. They are exposed to control the size and also to d=
isable BPF
> > +// counters when the number of user events is too large.
> > +
> > +// max cgroup hierarchy level: arbitrary
> > +#define BPERF_CGROUP__MAX_LEVELS  10
> > +// max events per cgroup: arbitrary
> > +#define BPERF_CGROUP__MAX_EVENTS  128
> > +
> > +#endif /* __BPERF_CGROUP_H */
> > --
> > 2.51.1.821.gb6fe4d2222-goog
> >
