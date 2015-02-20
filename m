From: David Ahern <dsahern@gmail.com>
Subject: Re: uprobe symbols with @GLIBC...
Date: Fri, 20 Feb 2015 10:20:28 -0700
Message-ID: <54E76CDC.2090904@gmail.com>
References: <54E752BF.50309@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:41376 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753863AbbBTRUa (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 20 Feb 2015 12:20:30 -0500
Received: by iecrd18 with SMTP id rd18so9382025iec.8
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Feb 2015 09:20:29 -0800 (PST)
In-Reply-To: <54E752BF.50309@us.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Paul Clarke <pc@us.ibm.com>, linux-perf-users@vger.kernel.org

On 2/20/15 8:29 AM, Paul Clarke wrote:
> Greetings,
>
> (New user for perf probe -x...)
>
> How does one set a dynamic tracepoint for user-mode symbols with "@"
> qualifiers?
>
> # perf probe -F -x /lib/libpthread.so.0 --filter='pthread_create*'
> pthread_create@@GLIBC_2.1
> pthread_create@GLIBC_2.0

one of many reasons I proposed an option to let users specify an address.


https://lkml.org/lkml/2013/12/1/126
https://lkml.org/lkml/2013/12/2/324

It was not picked up.

David

>
> # perf probe -v -x /lib/libpthread.so.0 pthread_create@GLIBC_2.0
> probe-definition(0): pthread_create@GLIBC_2.0
> symbol:pthread_create file:GLIBC_2.0 line:0 offset:0 return:0 lazy:(null)
> 0 arguments
> Failed to open debuginfo file.
>    Error: Failed to add events. (-2)
>
> # perf probe -v -x /lib/libpthread.so.0 pthread_create
> probe-definition(0): pthread_create
> symbol:pthread_create file:(null) line:0 offset:0 return:0 lazy:(null)
> 0 arguments
> Could not open debuginfo. Try to use symbols.
> no symbols found in /usr/lib/libpthread-2.18.so, maybe install a debug
> package?
> Failed to find symbol pthread_create in /usr/lib/libpthread-2.18.so
>    Error: Failed to add events. (-2)
>
> Symbols without such qualifiers work fine:
>
> # perf probe -F -x /lib/libpthread.so.0 --filter='pthread_detach*'
> pthread_detach
>
> # perf probe -v -x /lib/libpthread.so.0 pthread_detach
> probe-definition(0): pthread_detach
> symbol:pthread_detach file:(null) line:0 offset:0 return:0 lazy:(null)
> 0 arguments
> Could not open debuginfo. Try to use symbols.
> Opening /sys/kernel/debug/tracing/uprobe_events write=1
> Added new event:
> Writing event: p:probe_libpthread/pthread_detach
> /usr/lib/libpthread-2.18.so:0x8b30
>    probe_libpthread:pthread_detach (on pthread_detach in
> /usr/lib/libpthread-2.18.so)
>
> You can now use it in all perf tools, such as:
>
>          perf record -e probe_libpthread:pthread_detach -aR sleep 1
>
> --
> Regards,
> Paul Clarke, IBM
>
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
