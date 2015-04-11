From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: How to measure VM events using perf-event
Date: Sat, 11 Apr 2015 08:59:20 -0300
Message-ID: <20150411115920.GA3200@kernel.org>
References: <37CC8A17-BF41-41A5-8890-83A792C0BC08@gmail.com>
 <5527EEB3.1060507@codeaurora.org>
 <ABC4B897-7580-4EFC-B424-266D1E556498@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55250 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752657AbbDKL72 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 11 Apr 2015 07:59:28 -0400
Content-Disposition: inline
In-Reply-To: <ABC4B897-7580-4EFC-B424-266D1E556498@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jueyuan Zhu <jueyuan.zhu@gmail.com>
Cc: Christopher Covington <cov@codeaurora.org>, linux-perf-users@vger.kernel.org

Em Fri, Apr 10, 2015 at 12:17:08PM -0400, Jueyuan Zhu escreveu:
> Hi Chris,
> 
> Thanks for your suggestions. Since I am using the perf_event_open in the host OS, not in the guest OS. So does it need the support of PMU virtualization? I used the perf command below to measure the VM, and it can give correct results. So I am wondering how to use perf_event_open to get the same results as the perf user command?
> 
> #perf stat -e instructions -p VM_id sleep 1
 
Try adding -vv to the above perf stat command, it will show you how it
is setting up perf_event_attr, as well as the other arguments to
sys_perf_event_open, for example:

[acme@zoo linux]$ perf stat -vv -e instructions usleep 1
------------------------------------------------------------
perf_event_attr:
  size                             112
  config                           1
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 3530  cpu -1  group_fd -1  flags 0x8
instructions: 632294 767399 767399

 Performance counter stats for 'usleep 1':

           632.294      instructions                                                

       0,001521851 seconds time elapsed

[acme@zoo linux]$

- Arnaldo
