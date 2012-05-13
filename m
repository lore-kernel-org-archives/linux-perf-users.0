From: David Ahern <dsahern@gmail.com>
Subject: Re: perf stat: how to capture the output when it is running in the
 backgroud
Date: Sun, 13 May 2012 13:08:12 -0600
Message-ID: <4FB0069C.7070306@gmail.com>
References: <4fafd79d.6586440a.2edc.ffffb185@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48114 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457Ab2EMTIR (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 13 May 2012 15:08:17 -0400
Received: by pbbrp8 with SMTP id rp8so5248362pbb.19
        for <linux-perf-users@vger.kernel.org>; Sun, 13 May 2012 12:08:16 -0700 (PDT)
In-Reply-To: <4fafd79d.6586440a.2edc.ffffb185@mx.google.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Hailong Yang <hailong.yang1115@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On 5/13/12 9:47 AM, Hailong Yang wrote:
> Dear all,
>
> I am running perf stat to collect the performance statistics of a already
> running process. And I have a shell script to execute the perf stat as a
> daemon process. But when I use the 'kill' command to stop the perf stat,
> there is no output redirected to a file.
>
> [root@dell06 ~]# (perf stat -p 7473 -x ,) 2>  perftest&
> [1] 15086
> [root@dell06 ~]# kill 15086
> [root@dell06 ~]#
> [1]+  Terminated              ( perf stat -p 7473 -x , ) 2>  perftest
> [root@dell06 ~]# cat perftest
> [root@dell06 ~]#

Try: kill -INT $pid

David
