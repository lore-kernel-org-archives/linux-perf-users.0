From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC 0/5] per-event settings fixes
Date: Tue, 16 Jan 2018 12:38:05 -0300
Message-ID: <20180116153805.GD16107@kernel.org>
References: <20180116142438.19520-1-acme@kernel.org>
 <5e418aa0-d966-59d4-f024-a5fc61500f8d@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750764AbeAPPiI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 16 Jan 2018 10:38:08 -0500
Content-Disposition: inline
In-Reply-To: <5e418aa0-d966-59d4-f024-a5fc61500f8d@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Hendrick Brueckner <brueckner@linux.vnet.ibm.com>, Namhyung Kim <namhyung@kernel.org>, Noel Grandin <noelgrandin@gmail.com>, Wang Nan <wangnan0@huawei.com>

Em Tue, Jan 16, 2018 at 04:27:52PM +0100, Thomas-Mich Richter escreveu:
>  --- ::1 ping statistics ---
> 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> rtt min/avg/max/mdev = 0.047/0.047/0.047/0.000 ms
>      0.000 probe_libc:inet_pton:(3ffb4bc2060))
> [root@s8360047 perf]#
> 
> Test fails, I would have expected some callchain output.
> 
> [root@s8360047 perf]# ./perf trace --no-syscalls --call-graph dwarf --max-stack 4
>         -e probe_libc:inet_pton/max-stack=3/ ping -6 -c 1 ::1
> PING ::1(::1) 56 data bytes
> 64 bytes from ::1: icmp_seq=1 ttl=64 time=0.055 ms
> 
>  --- ::1 ping statistics ---
> 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> rtt min/avg/max/mdev = 0.055/0.055/0.055/0.000 ms
>      0.000 probe_libc:inet_pton:(3ff7e6c2060))
> [root@s8360047 perf]#
> 
> Test fails, I would have expected some callchain output.
> 
> It looks like /max-stack=3/ without ,call-graph=dwarf
> does not trigger the stack unwinding.

Ok, will work on those, then redo all the tests you did, grr, tricky
stuff.

- Arnaldo
