From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf segfault in docker container
Date: Fri, 10 Jun 2016 17:15:19 -0300
Message-ID: <20160610201519.GE3826@kernel.org>
References: <CAE40pdfWpz6rreOCMJCs1P8WXfOXO_B5zZoeOyC_5usYGp8xRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60066 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382AbcFJUPZ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 10 Jun 2016 16:15:25 -0400
Content-Disposition: inline
In-Reply-To: <CAE40pdfWpz6rreOCMJCs1P8WXfOXO_B5zZoeOyC_5usYGp8xRQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Wang Nan <wangnan0@huawei.com>

Em Thu, Jun 09, 2016 at 02:14:11PM -0700, Brendan Gregg escreveu:
> G'Day,
> 
> Default docker container, in Linux 4.7-rc2, with latest perf from perf/core:
> 
> docker# ./perf record -F 99 -a
> Segmentation fault
> 
> The segfault is in perf_event__synthesize_kernel_mmap(). I know
> symbol__read_kptr_restrict() has been updated recently to fix similar
> segfaults, hence getting perf/core.
> 
> I think the problem is this:
> 
> docker# id
> uid=0(root) gid=0(root) groups=0(root)
> docker# cat /proc/sys/kernel/kptr_restrict
> 1
> 
> (I'd previously set "echo -1 > /proc/sys/kernel/perf_event_paranoid")
> 
> The current (May 24) code has, symbol__read_kptr_restrict():
> 
>                 if (fgets(line, sizeof(line), fp) != NULL)
>                         value = (geteuid() != 0) ?
>                                         (atoi(line) != 0) :
>                                         (atoi(line) == 2);
> 
> assumes that if euid is 0 && kptr_restrict isn't 2, then we're aren't
> restricted. But we are. Maybe the code should check for CAP_SYS_ADMIN,
> instead of euid == 0?

Ack, reproduced will work on it. Thanks for the report.

- Arnaldo
