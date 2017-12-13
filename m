From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v3] perf evsel: Enable ignore_missing_thread for pid
 option
Date: Wed, 13 Dec 2017 14:56:56 +0100
Message-ID: <20171213135656.GC14376@krava>
References: <1513148513-6974-1-git-send-email-zhangmengting@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752175AbdLMN47 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Dec 2017 08:56:59 -0500
Content-Disposition: inline
In-Reply-To: <1513148513-6974-1-git-send-email-zhangmengting@huawei.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Mengting Zhang <zhangmengting@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@redhat.com, huawei.libin@huawei.com, wangnan0@huawei.com, cj.chengjian@huawei.com

On Wed, Dec 13, 2017 at 03:01:53PM +0800, Mengting Zhang wrote:
> While monitoring a multithread process with pid option, perf sometimes
> may return sys_perf_event_open failure with 3(No such process) if any
> of the process's threads die before we open the event. However, we want
> perf continue monitoring the remaining threads and do not exit with error.
> 
> Here, the patch enables perf_evsel::ignore_missing_thread for -p option
> to ignore complete failure if any of threads die before we open the event.
> But it may still return sys_perf_event_open failure with 22(Invalid) if we
> monitors several event groups.
> 
>         sys_perf_event_open: pid 28960  cpu 40  group_fd 118202  flags 0x8
>         sys_perf_event_open: pid 28961  cpu 40  group_fd 118203  flags 0x8
>         WARNING: Ignored open failure for pid 28962
>         sys_perf_event_open: pid 28962  cpu 40  group_fd [118203]  flags 0x8
>         sys_perf_event_open failed, error -22
> 
> That is because when we ignore a missing thread, we change the thread_idx
> without dealing with its fds, FD(evsel, cpu, thread). Then get_group_fd()
> may return a wrong group_fd for the next thread and sys_perf_event_open()
> return with 22.
> 
>         sys_perf_event_open(){
>            ...
>            if (group_fd != -1)
>                perf_fget_light()//to get corresponding group_leader by group_fd
>            ...
>            if (group_leader)
>               if (group_leader->ctx->task != ctx->task)//should on the same task
>                    goto err_context
>            ...
>         }
> 
> This patch also fixes this bug by introducing perf_evsel__remove_fd() and
> update_fds to allow removing fds for the missing thread.
> 
> Changes since v1:
> - Change group_fd__remove() into a more genetic way without changing code logic
> - Remove redundant condition
> 
> Changes since v2:
> - Use a proper function name and add some comment.
> - Multiline comment style fixes.

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
