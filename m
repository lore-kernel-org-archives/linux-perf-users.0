From: sahil aggarwal <sahil.agg15@gmail.com>
Subject: Re: Sampling on sched:sched_switch
Date: Wed, 15 Apr 2015 11:47:46 +0530
Message-ID: <CAGAANTV=nhS8H=1aot1VybjjNykkMkJv9dJgejaY4=FRgzvtTw@mail.gmail.com>
References: <CAGAANTU3HMoZCNsN=PAWCb8Pqx89ZyO3aQcibXKN+ZxMx1MAOA@mail.gmail.com>
	<20150413151148.GI3200@kernel.org>
	<CAGAANTXY8UiP2yRUg5tVBB+PQdH8=X27MKUj=nSHvWHk-x5MJQ@mail.gmail.com>
	<20150414121559.GD16027@kernel.org>
	<CAGAANTUAJJmBBSRijursj2VxCg=1kbEP90BRMW2-J0S83tzRug@mail.gmail.com>
	<20150414125921.GJ16027@kernel.org>
	<CAGAANTV1gQFd0_WZbGTG_+ASZZdDmfAecr_ddchnWGB+dMyVDA@mail.gmail.com>
	<20150414142226.GL16027@kernel.org>
	<CAGAANTWdzGu=NKrViUm9-e_9r0jVzRdS4+72VjqgOKOURnqKKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-vn0-f43.google.com ([209.85.216.43]:35792 "EHLO
	mail-vn0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964804AbbDOGRr (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 15 Apr 2015 02:17:47 -0400
Received: by vnbg1 with SMTP id g1so11517793vnb.2
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2015 23:17:46 -0700 (PDT)
In-Reply-To: <CAGAANTWdzGu=NKrViUm9-e_9r0jVzRdS4+72VjqgOKOURnqKKA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Update to kernel 4.0.0. Working fine now.

Thank you Arnaldo.

On 14 April 2015 at 20:25, sahil aggarwal <sahil.agg15@gmail.com> wrote:
>> My question stands: "Are you monitoring a specific thread? Or all
>> threads in the system"?
> I am monitoring a specific thread not systemwide.
>
>> Above, we are not asking the kernel for cpu == -1 and thread == -1, that will
>> result in that -EINVAL, that is there for scalability reasons.
>
> Yes, this condition will give EINVAL according to the documentation,
> but i pass the pid of thread i want to monitor so i definitely dont
> ask kernel for cpu == -1 and pid == -1.
>
> sys_perf_event_open(__NR_perf_event_open,2588,0,-1,0)
> sys_perf_event_open(__NR_perf_event_open,2588,1,-1,0)
>
> But, my actual problem still persist. Still not getting any counts on
> sched:sched_switch for particular thread. But it works for systemwide
>
> bash-4.1# perf stat -ae "sched:*" sleep 1
>
>  Performance counter stats for 'sleep 1':
>
>                  0 sched:sched_kthread_stop
>          [100.00%]
>                  0 sched:sched_kthread_stop_ret
>             [100.00%]
>                 90 sched:sched_wakeup
>          [100.00%]
>                  8 sched:sched_wakeup_new
>          [100.00%]
>                210 sched:sched_switch
>          [100.00%]
>                 31 sched:sched_migrate_task
>          [100.00%]
>                  6 sched:sched_process_free
>          [100.00%]
>                  5 sched:sched_process_exit
>          [100.00%]
>                  0 sched:sched_wait_task
>          [100.00%]
>                  7 sched:sched_process_wait
>          [100.00%]
>                 10 sched:sched_process_fork
>          [100.00%]
>                  0 sched:sched_stat_wait
>          [100.00%]
>                  0 sched:sched_stat_sleep
>          [100.00%]
>                  0 sched:sched_stat_iowait
>          [100.00%]
>           81156012 sched:sched_stat_runtime
>          [100.00%]
>                  0 sched:sched_pi_setprio
>
>        1.004944414 seconds time elapsed
