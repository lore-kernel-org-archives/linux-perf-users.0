From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf parse events: Fix invalid precise_ip handling
Date: Fri, 10 Nov 2017 11:39:00 +0100
Message-ID: <20171110103900.GA10233@krava>
References: <1510302517-33383-1-git-send-email-zhangmengting@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59338 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751683AbdKJKjD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Nov 2017 05:39:03 -0500
Content-Disposition: inline
In-Reply-To: <1510302517-33383-1-git-send-email-zhangmengting@huawei.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Mengting Zhang <zhangmengting@huawei.com>
Cc: namhyung@kernel.org, alexander.shishkin@linux.intel.com, acme@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, huawei.libin@huawei.com, wangnan0@huawei.com

On Fri, Nov 10, 2017 at 04:28:37PM +0800, Mengting Zhang wrote:

SNIP

> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 39b1596..25225f4 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1369,6 +1369,32 @@ struct event_modifier {
>  	int pinned;
>  };
>  
> +static int perf_get_max_precise_ip(void)
> +{
> +       int max_precise_ip = 0;
> +       struct perf_event_attr attr = {
> +               .type   = PERF_TYPE_HARDWARE,
> +               .config = PERF_COUNT_HW_CPU_CYCLES,
> +       };
> +
> +       event_attr_init(&attr);
> +       
> +       attr.precise_ip = 3;
> +       attr.sample_period = 1;
> +
> +       while (attr.precise_ip != 0) {
> +               int fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
> +               if (fd != -1){
> +                       close(fd);
> +                       break;
> +               }
> +               --attr.precise_ip;
> +       }
> +       max_precise_ip = attr.precise_ip;
> +
> +       return max_precise_ip;
> +}

we already have a function for that, please check perf_event_attr__set_max_precise_ip

also I think the precise level is not generic for all the events,
so you should check it for specific perf_event_attr later, when
the attr is ready, not in modifier parsing

thanks,
jirka
