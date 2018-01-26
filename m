From: weiping zhang <zwp10758@gmail.com>
Subject: Re: [PATCH] perf cgroup: fix cgroup for multiple events
Date: Fri, 26 Jan 2018 08:10:30 +0800
Message-ID: <CAA70yB416r4+t1S4cXR-Oy=qJfQe13ktgWipypv_0HOd+VdVqw@mail.gmail.com>
References: <20180125150017.GA15771@localhost.didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:46603 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbeAZAKc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 25 Jan 2018 19:10:32 -0500
In-Reply-To: <20180125150017.GA15771@localhost.didichuxing.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org

please discard this patch, may the right way to use cgroup with multiple events
like following:

perf stat -e cycles -e cache-misses  -a -I 1000 -G test,test

2018-01-25 23:00 GMT+08:00 weiping zhang <zhangweiping@didichuxing.com>:
> if use -G and with multiple events, only the first event has
> correct cgroup setting, all other events have a wroung setting.
>
> reproduce:
> mkdir -p /sys/fs/cgroup/perf_event/test
> perf stat -e cycles -e cache-misses  -a -I 1000 -G test
>
> before:
>      1.001007226      <not counted>      cycles                    test
>      1.001007226              7,506      cache-misses
>
> after:
>      1.000834097      <not counted>      cycles                    test
>      1.000834097      <not counted>      cache-misses              test
>
> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> ---
>  tools/perf/util/cgroup.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> index d9ffc1e..b50bfd1 100644
> --- a/tools/perf/util/cgroup.c
> +++ b/tools/perf/util/cgroup.c
> @@ -137,7 +137,8 @@ static int add_cgroup(struct perf_evlist *evlist, char *str)
>
>         return -1;
>  found:
> -       counter->cgrp = cgrp;
> +       evlist__for_each_entry(evlist, counter)
> +               counter->cgrp = cgrp;
>         return 0;
>  }
>
> --
> 2.9.4
>
