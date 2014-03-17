From: William Cohen <wcohen@redhat.com>
Subject: Perf supporting function reordering?
Date: Mon, 17 Mar 2014 12:22:52 -0400
Message-ID: <5327215C.7010005@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:15004 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754429AbaCQQWz (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 17 Mar 2014 12:22:55 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s2HGMrhD032267
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2014 12:22:54 -0400
Received: from [10.13.129.12] (dhcp129-12.rdu.redhat.com [10.13.129.12])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s2HGMqXt006468
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2014 12:22:52 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Has there been any thought about perf supporting function reordering?  The
kernel had a function reorder option that was available in Linux
2.6.17 to 2.6.21?  The kernel code has poor performance when compared
to the user-space code. For a simple experiment compiling the kernel
code the kernel was getting a L1 icache miss every 60 instructions
versus the userspace getting an L1 icache miss every 260 instructions.
The difference in IPC was also significant. The kernel code had 0.55
IPC while userspace had 1.59 IPC.

The arguments for removal of the function reorder code for Linux 2.6.22 were:

-linker was slowed too much by many sections
-manual generation of the ordering list got out of date
-too diverse worksloads

With perf it is easy to collect information about the operation
runtime characteristics.  Over the weekend I was able to collect call
graph information of kernel build on the system with perf, then
render the data with gprof2dot and dot:

  export training=training/make_a_g_branch_k
  sudo perf record -a -g -e branches:k -o $training.data su wcohen -c "make -j4"
  sudo chown wcohen $training.data; sudo chgrp wcohen $training.data
  perf script -i $training.data| gprof2dot --format=perf > $training.gv
  dot -Tsvg < $training.gv > $(training).svg

By default gprof2dot prunes nodes and edges. The following provides a
more complete graph:

  perf script -i $training.data| gprof2dot --format=perf -n 0.05 -e 0.01 > training/make_a_g_branch_k_2.gv

The results graphs are at:

  http://people.redhat.com/wcohen/sediment/make_a_g_branch_k.svg
  http://people.redhat.com/wcohen/sediment/make_a_g_branch_k_2.svg

The graphs give some indication of the flow through the kernel
code. Search for "system_call" will show the kernel entry and where
thing branch out from there.  Other place of interest "page_fault" and
"apic_timer_interrupt".

Any thoughts on making it easier for perf make this statistical
callgraph information available and using it to do code reordering?  I
have experimented with code reorder with user space postgres package
and it did help performance about 5% improvement in IPC
(http://people.redhat.com/wcohen/sediment/html/pop.html)

-Will
