From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: perf report feature request: folded stack output
Date: Fri, 9 Oct 2015 14:24:17 -0700
Message-ID: <CAE40pddHkm_SB4mpOBeSfTe8BcfU1js5fiEK96xA95gbjPa1bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:34955 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755564AbbJIVYh (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 9 Oct 2015 17:24:37 -0400
Received: by iofl186 with SMTP id l186so22512918iof.2
        for <linux-perf-users@vger.kernel.org>; Fri, 09 Oct 2015 14:24:36 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>

G'Day,

Maybe someone would like to code this (if not I hope to find the
time); perf report already has the capability to print captured stacks
as a call tree. I'd like a new output mode: folded.

Flame graphs[1] consume folded stacks. Eg:

# git clone https://github.com/brendangregg/FlameGraph
# cd FlameGraph
# perf record -F 99 -a -g -- sleep 60
# perf script | ./stackcollapse-perf.pl | ./flamegraph.pl
out.perf-folded > flame.svg

The last line is inefficient, and should really be something like:

# perf report --folded | ./flamegraph.pl out.perf-folded > flame.svg

The folded format is function names separated by semicolons, a space,
then the count of occurrences. Eg:

iperf;__libc_recv;entry_SYSCALL_64_fastpath;sys_recvfrom;SYSC_recvfrom;sock_recvmsg;inet_recvmsg;tcp_recvmsg;tcp_release_cb
1
iperf;__libc_recv;entry_SYSCALL_64_fastpath;sys_recvfrom;SYSC_recvfrom;sock_recvmsg;inet_recvmsg;tcp_recvmsg;tcp_v4_do_rcv
1
iperf;__libc_recv;entry_SYSCALL_64_fastpath;sys_recvfrom;SYSC_recvfrom;sock_recvmsg;security_socket_recvmsg
2
iperf;__libc_recv;entry_SYSCALL_64_fastpath;sys_recvfrom;SYSC_recvfrom;sock_recvmsg;tcp_recvmsg
2
iperf;__libc_recv;entry_SYSCALL_64_fastpath;sys_recvfrom;SYSC_recvfrom;sockfd_lookup_light;__fdget;__fget_light;__fget
9
iperf;__libc_recv;entry_SYSCALL_64_fastpath;sys_recvfrom;SYSC_recvfrom;sockfd_lookup_light;__fget_light
4
iperf;__libc_recv;entry_SYSCALL_64_fastpath;sys_recvfrom;fput 2
iperf;__libc_recv;entry_SYSCALL_64_fastpath;sys_recvfrom;sockfd_lookup_light 1
iperf;__libc_recv;sys_recvfrom 3
iperf;__pthread_disable_asynccancel 11
iperf;check_events;xen_hypercall_xen_version 37

etc.

It should just be a different way of printing "perf report -n
--stdio", so I hope most of the logic is already there. :)

Folded output would be great. An optional additional output could be
JSON. I'm helping build an open source GUI that consumes profiles, and
it's consuming similar aggregated stacks but as JSON. Eg:
https://github.com/spiermar/d3-flame-graph/blob/master/example/stacks.json

Brendan

[1] http://www.brendangregg.com/FlameGraphs/cpuflamegraphs.html
