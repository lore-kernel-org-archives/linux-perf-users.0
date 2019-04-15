From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: perf tools:Is there any tools to found out the max latency by
 irq or cpu idle
Date: Mon, 15 Apr 2019 14:59:07 -0300
Message-ID: <20190415175907.GC11294@kernel.org>
References: <4099DE2E54AFAD489356C6C9161D53339591D64A@DGGEML502-MBX.china.huawei.com>
 <8ce8c596-123e-1342-5ccc-06a5fd8a60ec@redhat.com>
 <4099DE2E54AFAD489356C6C9161D53339591DE6D@DGGEML502-MBX.china.huawei.com>
 <6e6a98a4-a442-1e10-cf5a-56b6792d42ba@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6e6a98a4-a442-1e10-cf5a-56b6792d42ba@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Clarke <pc@us.ibm.com>
Cc: Linhaifeng <haifeng.lin@huawei.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Apr 15, 2019 at 07:52:59AM -0500, Paul Clarke escreveu:
> On 4/13/19 1:01 AM, Linhaifeng wrote:
> > Sorry, the value 131081408 is just for example. Actually the result is like this:
> >  sqrt 2019-04-10 23:53:50: 43968
> >  sqrt 2019-04-10 23:53:51: 44060
> >  sqrt 2019-04-10 23:53:52: 49012
> >  sqrt 2019-04-10 23:53:53: 38172
> >  sqrt 2019-04-10 23:53:54: 131081408
> >  sqrt 2019-04-10 23:53:55: 43600
> >  sqrt 2019-04-10 23:53:56: 46704
> >  sqrt 2019-04-10 23:53:57: 46880
> >  sqrt 2019-04-10 23:53:58: 44332
> >  ……
> >  sqrt 2019-04-10 02:17:15: 136345876
> >  ……
> >  sqrt 2019-04-10 04:40:35: 136335644
> >  ……
> 
> Given the periodicity, I'm wondering if it could be System Management Interrupts (SMIs)?
> 
> If so, some BIOSes have settings to mitigate, otherwise, there's not much that can be done, per my understanding.

[root@quaco perf]# perf list smi

List of pre-defined events (to be used in -e):

  msr/smi/                                           [Kernel PMU event]

  sunrpc:xprt_transmit                               [Tracepoint event]
  tcp:tcp_retransmit_skb                             [Tracepoint event]
  tcp:tcp_retransmit_synack                          [Tracepoint event]

  sdt_qemu:qmp_block_job_dismiss                     [SDT event]
  sdt_qemu:qmp_job_dismiss                           [SDT event]

Metric Groups:

[root@quaco perf]#

Here, using it:

[root@quaco perf]# perf stat -I 1000 -e msr/smi/
#           time             counts unit events
     1.000919819                  0      msr/smi/                 
     2.001689950                  0      msr/smi/                 
     3.002266988                  0      msr/smi/                 
     4.003049439                 16      msr/smi/                 
     5.003676064                  0      msr/smi/                 
     6.004420613                 16      msr/smi/                 
^C     6.609405666                  0      msr/smi/                 

[root@quaco perf]# 


In this Lenovo T480s I generate SMIs by pressing the mute button :-)

- Arnaldo
