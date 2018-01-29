From: Lin Xiulei <linxiulei@gmail.com>
Subject: Re: [PATCH RESEND] perf/core: Fix installing cgroup event into cpu
Date: Mon, 29 Jan 2018 11:37:06 +0800
Message-ID: <CALPjY3n=RZJ9oNgcTLcNDmECFf-9EbaEBOdO+w76JrTq6GZjXw@mail.gmail.com>
References: <20180123041306.15431-1-linxiulei@gmail.com> <201801260922.ZejWKyP8%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:46141 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750771AbeA2DhI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 28 Jan 2018 22:37:08 -0500
In-Reply-To: <201801260922.ZejWKyP8%fengguang.wu@intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@redhat.com>, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, tglx@linutronix.de, Stephane Eranian <eranian@gmail.com>, torvalds@linux-foundation.org, linux-perf-users@vger.kernel.org, Brendan Gregg <brendan.d.gregg@gmail.com>, yang_oliver@hotmail.com, jinli.zjl@alibaba-inc.com, "leilei.lin" <leilei.lin@alibaba-inc.com>

2018-01-26 10:02 GMT+08:00 kbuild test robot <lkp@intel.com>:
> Hi leilei.lin,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on tip/perf/core]
> [also build test ERROR on v4.15-rc9 next-20180119]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/linxiulei-gmail-com/perf-core-Fix-installing-cgroup-event-into-cpu/20180126-083327
> config: x86_64-randconfig-g0-01260853 (attached as .config)
> compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> All errors (new ones prefixed by >>):
>
>    kernel//events/core.c: In function '__perf_install_in_context':
>    kernel//events/core.c:2315:11: error: 'struct perf_event' has no member named 'cgrp'
>      if (event->cgrp) {
>               ^
>>> kernel//events/core.c:2322:3: error: implicit declaration of function 'perf_cgroup_from_task' [-Werror=implicit-function-declaration]
>       cgrp = perf_cgroup_from_task(current, ctx);
>       ^
>    kernel//events/core.c:2322:8: warning: assignment makes pointer from integer without a cast
>       cgrp = perf_cgroup_from_task(current, ctx);
>            ^
>>> kernel//events/core.c:2323:33: error: dereferencing pointer to incomplete type
>       if (!cgroup_is_descendant(cgrp->css.cgroup,
>                                     ^
>    kernel//events/core.c:2324:11: error: 'struct perf_event' has no member named 'cgrp'
>          event->cgrp->css.cgroup))
>               ^
>    cc1: some warnings being treated as errors
>
> vim +/perf_cgroup_from_task +2322 kernel//events/core.c
>
>   2274
>   2275  /*
>   2276   * Cross CPU call to install and enable a performance event
>   2277   *
>   2278   * Very similar to remote_function() + event_function() but cannot assume that
>   2279   * things like ctx->is_active and cpuctx->task_ctx are set.
>   2280   */
>   2281  static int  __perf_install_in_context(void *info)
>   2282  {
>   2283          struct perf_event *event = info;
>   2284          struct perf_event_context *ctx = event->ctx;
>   2285          struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
>   2286          struct perf_event_context *task_ctx = cpuctx->task_ctx;
>   2287          struct perf_cgroup *cgrp;
>   2288          bool reprogram = true;
>   2289          int ret = 0;
>   2290
>   2291          raw_spin_lock(&cpuctx->ctx.lock);
>   2292          if (ctx->task) {
>   2293                  raw_spin_lock(&ctx->lock);
>   2294                  task_ctx = ctx;
>   2295
>   2296                  reprogram = (ctx->task == current);
>   2297
>   2298                  /*
>   2299                   * If the task is running, it must be running on this CPU,
>   2300                   * otherwise we cannot reprogram things.
>   2301                   *
>   2302                   * If its not running, we don't care, ctx->lock will
>   2303                   * serialize against it becoming runnable.
>   2304                   */
>   2305                  if (task_curr(ctx->task) && !reprogram) {
>   2306                          ret = -ESRCH;
>   2307                          goto unlock;
>   2308                  }
>   2309
>   2310                  WARN_ON_ONCE(reprogram && cpuctx->task_ctx && cpuctx->task_ctx != ctx);
>   2311          } else if (task_ctx) {
>   2312                  raw_spin_lock(&task_ctx->lock);
>   2313          }
>   2314
>> 2315          if (event->cgrp) {
>   2316                  /*
>   2317                   * Only care about cgroup events.
>   2318                   *
>   2319                   * If only the task belongs to cgroup of this event,
>   2320                   * we will continue the installment
>   2321                   */
>> 2322                  cgrp = perf_cgroup_from_task(current, ctx);
>> 2323                  if (!cgroup_is_descendant(cgrp->css.cgroup,
>   2324                                          event->cgrp->css.cgroup))
>   2325                          goto unlock;
>   2326          }
>   2327
>   2328          if (reprogram) {
>   2329                  ctx_sched_out(ctx, cpuctx, EVENT_TIME);
>   2330                  add_event_to_ctx(event, ctx);
>   2331                  ctx_resched(cpuctx, task_ctx, get_event_type(event));
>   2332          } else {
>   2333                  add_event_to_ctx(event, ctx);
>   2334          }
>   2335
>   2336  unlock:
>   2337          perf_ctx_unlock(cpuctx, task_ctx);
>   2338
>   2339          return ret;
>   2340  }
>   2341
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


@peter seems it has trouble in merging v1 patch, in fact it should've
merged the v3 patch. What am I supposed to do to fix it?

thanks
