From: David Ahern <dsahern@gmail.com>
Subject: Re: stack trace of threads that wake up a specific target userspace
 thread blocking in epoll_wait
Date: Fri, 25 Apr 2014 11:01:20 -0600
Message-ID: <535A94E0.2040008@gmail.com>
References: <CANHDG4anUmNmAxwx99fFTLCSFGNkENg6mZFun7N6dPZLGmSkqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:63879 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220AbaDYRBY (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 25 Apr 2014 13:01:24 -0400
Received: by mail-pb0-f43.google.com with SMTP id um1so3414658pbc.30
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Apr 2014 10:01:24 -0700 (PDT)
In-Reply-To: <CANHDG4anUmNmAxwx99fFTLCSFGNkENg6mZFun7N6dPZLGmSkqQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jun Wang <junwang123@gmail.com>, linux-perf-users@vger.kernel.org

On 4/25/14, 10:33 AM, Jun Wang wrote:
> I wonder whether there is a way to dump out the stack trace of
> threads, or some other kernel entities, that wake up that thread. The
> idea is to figure out why there is a huge delay by looking at how the
> delayed is ended, and by whom/what.

perf record -e sched:sched_wakeup* -e sched:sched_switch -ag
perf script
