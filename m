From: Jun Wang <junwang123@gmail.com>
Subject: stack trace of threads that wake up a specific target userspace
 thread blocking in epoll_wait
Date: Fri, 25 Apr 2014 09:33:40 -0700
Message-ID: <CANHDG4anUmNmAxwx99fFTLCSFGNkENg6mZFun7N6dPZLGmSkqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:48776 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753996AbaDYQdl (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 25 Apr 2014 12:33:41 -0400
Received: by mail-we0-f171.google.com with SMTP id t61so3796653wes.2
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Apr 2014 09:33:40 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi Everyone,

I have a profiling tool question that could go beyond perf.

In an application, there are threads blocking on epoll_wait(). The
file descriptors are sockets connecting to other servers in a data
center with less than 1ms network latency. On normal systems, the
delay to wake up epoll_wait is much less than 1ms. It is noticed on a
system that sometimes it takes an unbelievable 30ms delay to wake up
the thread blocking in epoll_wait(). To be exact, the delay of
reference here is between tcp_rcv_established() and epoll_wait.return.

I wonder whether there is a way to dump out the stack trace of
threads, or some other kernel entities, that wake up that thread. The
idea is to figure out why there is a huge delay by looking at how the
delayed is ended, and by whom/what.

epoll wakeup internels in the kernel space can be referred to at
http://www.slideshare.net/llj098/epoll-from-the-kernel-side.

As a reference, there is a dtrace script that does this on Solaris.
https://github.com/brendangregg/dtrace-cloud-tools/blob/master/system/cv_wakeup_slow.d

Would perf/systemTap or other Linux tools be helpful?

Thanks,
Jun
