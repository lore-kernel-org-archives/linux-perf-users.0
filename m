From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf test: Fix test trace+probe_libc_inet_pton.sh for
 s390x
Date: Tue, 6 Feb 2018 10:51:31 -0300
Message-ID: <20180206135131.GA3451@kernel.org>
References: <20180117083831.101001-1-tmricht@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751544AbeBFNvf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Feb 2018 08:51:35 -0500
Content-Disposition: inline
In-Reply-To: <20180117083831.101001-1-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com

Em Wed, Jan 17, 2018 at 09:38:31AM +0100, Thomas Richter escreveu:
> On Intel test case trace+probe_libc_inet_pton.sh succeeds and the
> output is:
> [root@f27 perf]# ./perf trace --no-syscalls
>                   -e probe_libc:inet_pton/max-stack=3/ ping -6 -c 1 ::1
> PING ::1(::1) 56 data bytes
> 64 bytes from ::1: icmp_seq=1 ttl=64 time=0.037 ms
> 
>  --- ::1 ping statistics ---
> 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> rtt min/avg/max/mdev = 0.037/0.037/0.037/0.000 ms
>      0.000 probe_libc:inet_pton:(7fa40ac618a0))
>               __GI___inet_pton (/usr/lib64/libc-2.26.so)
>               getaddrinfo (/usr/lib64/libc-2.26.so)
>               main (/usr/bin/ping)
> 
> The kernel stack unwinder is used, it is specified implicitly
> as call-graph=fp (frame pointer).
> 
> On s390x only dwarf is available for stack unwinding. It is also
> done in user space. This requires different parameter setup
> and result checking for s390x and Intel.

Thanks, looks sane, tested on x86_64, applied.

Do you have some other patches outstanding that I should look? I
travelled a bit, so trying to catch up on patches submitted.

Thanks again,

- Arnaldo
