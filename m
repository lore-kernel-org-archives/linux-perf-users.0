From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: measuring system wide CPU usage ignoring idle process
Date: Mon, 20 Nov 2017 15:29:08 +0100
Message-ID: <20171120142908.GA22876@krava>
References: <3344812.IFj9h2T05j@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46229 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751124AbdKTO3J (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 20 Nov 2017 09:29:09 -0500
Content-Disposition: inline
In-Reply-To: <3344812.IFj9h2T05j@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org

On Mon, Nov 20, 2017 at 03:00:46PM +0100, Milian Wolff wrote:
> Hey all,
> 
> colleagues of mine just brought this inconvenient perf stat behavior to my 
> attention:
> 
> $ perf stat -a -e cpu-clock,task-clock,cycles,instructions sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>        4004.501439      cpu-clock (msec)          #    4.000 CPUs utilized          
>        4004.526474      task-clock (msec)         #    4.000 CPUs utilized          
>        945,906,029      cycles                    #    0.236 GHz                    
>        461,861,241      instructions              #    0.49  insn per cycle         
> 
>        1.001247082 seconds time elapsed
> 
> This shows that cpu-clock and task-clock are incremented also for the idle 
> processes. Is there some trick to exclude that time, such that the CPU 
> utilization drops below 100% when doing `perf stat -a`?

I dont think it's the idle process you see, I think it's the managing
overhead before the 'sleep 1' task goes actualy to sleep

there's some user space code before it gets into the sleep syscall,
and there's some possible kernel scheduling/syscall/irq code with
events already enabled and counting

in following 3 sessions you can see the counts are pretty much
the same regardless the sleeping time:

	[jolsa@krava perf]$ sudo ./perf stat -e cycles:u,cycles:k sleep 1

	 Performance counter stats for 'sleep 1':

		   316,478      cycles:u                                                    
		   594,468      cycles:k                                                    

	       1.000813330 seconds time elapsed

	[jolsa@krava perf]$ sudo ./perf stat -e cycles:u,cycles:k sleep 5

	 Performance counter stats for 'sleep 5':

		   339,287      cycles:u                                                    
		   665,888      cycles:k                                                    

	       5.001004575 seconds time elapsed

	[jolsa@krava perf]$ sudo ./perf stat -e cycles:u,cycles:k sleep 10

	 Performance counter stats for 'sleep 10':

		   314,507      cycles:u                                                    
		   658,764      cycles:k                                                    

	      10.001117596 seconds time elapsed

jirka
