From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: Mixed group of sw/hw counters are not started if sw counter is
 group leader
Date: Tue, 29 Jan 2013 13:39:08 +0100
Message-ID: <20130129123908.GC8339@krava.brq.redhat.com>
References: <CAGz0_-0ti+_3cXQhYUAb_-zKqHBcPVYjFtQ86ZGr8utXF13Rag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:62428 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756738Ab3A2MjM (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 29 Jan 2013 07:39:12 -0500
Content-Disposition: inline
In-Reply-To: <CAGz0_-0ti+_3cXQhYUAb_-zKqHBcPVYjFtQ86ZGr8utXF13Rag@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andreas Hollmann <hollmann@in.tum.de>
Cc: linux-perf-users@vger.kernel.org

On Tue, Jan 29, 2013 at 12:25:31PM +0100, Andreas Hollmann wrote:
> Hi,
> 
> I've noticed an odd behavior of the perf event subsystem.
> 
> If the flag "disabled" in struct perf_event_attr is set to 0, the
> counter should be automatically started after the perf_event_open
> system call (perf/design.txt).
> 
> This is only working if the first perf counter is of type hw or all
> counters in the group are sw counters. If a sw counter comes first
> and the group also contains hw counters, the read call shows that the
> first counter is started, but not counting. All other counters are neither
> started nor counting.
> 
> Value: 0 Enabled: 7599 Running: 6706
> Value: 0 Enabled: 0 Running: 0
> Value: 0 Enabled: 0 Running: 0

hm, I'm getting following stats when running perf stat in similar scenario:

[jolsa@dhcp-26-214 perf]$ ./perf stat -e '{task-clock,cpu-clock,instructions}' kill
usage: kill [ -s signal | -p ] [ -a ] pid ...
       kill -l [ signal ]

 Performance counter stats for 'kill':

          1.039561 task-clock                #    0.479 CPUs utilized          
     <not counted> cpu-clock               
         2,281,726 instructions              #    0.00  insns per cycle        

       0.002168502 seconds time elapsed
...

seems wrong ;-) will check

thanks,
jirka
