From: "Hailong Yang" <hailong.yang1115@gmail.com>
Subject: RE: perf stat: how to capture the output when it is running in the backgroud
Date: Mon, 14 May 2012 10:19:36 +0800
Message-ID: <4fb06bbb.4588440a.672d.fffff1d6@mx.google.com>
References: <4fafd79d.6586440a.2edc.ffffb185@mx.google.com> <4FB0069C.7070306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52650 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860Ab2ENCTk (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 13 May 2012 22:19:40 -0400
Received: by dady13 with SMTP id y13so5286602dad.19
        for <linux-perf-users@vger.kernel.org>; Sun, 13 May 2012 19:19:40 -0700 (PDT)
In-Reply-To: <4FB0069C.7070306@gmail.com>
Content-Language: zh-cn
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: 'David Ahern' <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Thanks, David. That works.

Hailong

> -----Original Message-----
> From: David Ahern [mailto:dsahern@gmail.com]
> Sent: Monday, May 14, 2012 3:08 AM
> To: Hailong Yang
> Cc: linux-perf-users@vger.kernel.org
> Subject: Re: perf stat: how to capture the output when it is running in
the
> backgroud
> 
> On 5/13/12 9:47 AM, Hailong Yang wrote:
> > Dear all,
> >
> > I am running perf stat to collect the performance statistics of a
already
> > running process. And I have a shell script to execute the perf stat as a
> > daemon process. But when I use the 'kill' command to stop the perf stat,
> > there is no output redirected to a file.
> >
> > [root@dell06 ~]# (perf stat -p 7473 -x ,) 2>  perftest&
> > [1] 15086
> > [root@dell06 ~]# kill 15086
> > [root@dell06 ~]#
> > [1]+  Terminated              ( perf stat -p 7473 -x , ) 2>  perftest
> > [root@dell06 ~]# cat perftest
> > [root@dell06 ~]#
> 
> Try: kill -INT $pid
> 
> David
