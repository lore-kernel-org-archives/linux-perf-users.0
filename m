From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf test shell: Fix check open filename arg using 'perf
 trace'
Date: Thu, 30 Nov 2017 11:28:33 +0100
Message-ID: <84d4a40a-dfbf-6d9b-9eb2-6912dc6f57e4@linux.vnet.ibm.com>
References: <alpine.LRH.2.20.1711291656270.9416@Diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750948AbdK3K3E (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Nov 2017 05:29:04 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAUASu8O144695
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Nov 2017 05:29:04 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ejf9e3agn-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Nov 2017 05:29:02 -0500
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Thu, 30 Nov 2017 10:28:36 -0000
In-Reply-To: <alpine.LRH.2.20.1711291656270.9416@Diego>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Michael Petlan <mpetlan@redhat.com>, linux-perf-users@vger.kernel.org
Cc: Jiri Olsa <jolsa@redhat.com>, Arnaldo de Melo <acme@redhat.com>

On 11/29/2017 06:27 PM, Michael Petlan wrote:
> Hi Arnaldo, Jiri and others!
> 
> Posting a fix for perf test "Check open filename arg using perf trace + vfs_getname".
> 
> The commit f231af789b11a2f1a3795acc3228a3e178a80c21 adds an exception for s390x to
> use openat() syscall instead of open(). This exception is not s390x-only, thus I
> adjusted the test to accept both open and openat syscalls, no matter which arch it
> runs on. Does it sound reasonable to you?
> 
> 
> When testing on 4.15.0-rc1, I also hit the following issue:
> 
> # perf probe "vfs_getname=getname_flags:72 pathname=result->name:string"
> Failed to find 'result' in this function.
>   Error: Failed to add events.
> 
> # perf probe -L getname_flags 
> [...]
>      72         result->uptr = filename;
>      73         result->aname = NULL;
> [...]
> 
> # perf probe "vfs_getname=getname_flags:72 pathname=result->uptr:string"
> Failed to find 'result' in this function.
>   Error: Failed to add events.
> 
> ... When the probed var is changed to "filename", it seems to work:
> 
> # perf probe "vfs_getname=getname_flags:72 pathname=filename:string"
> Added new event:
>   probe:vfs_getname    (on getname_flags:72 with pathname=filename:string)
> 
> You can now use it in all perf tools, such as:
> 
> 	perf record -e probe:vfs_getname -aR sleep 1
> 
> 
> So maybe the second attached patch is necessary too, not sure. Just thinking
> that "filename" might be less change-prone, as a func. arg... ?
> 
> Thank you.
> 
> Cheers,
> Michael
> 

Maybe I have done something wrong when I tried your patch. I have download
latest 4.15.0rc1 but your patch does not work for me.
My perf tool does not handle wild cards on events:

root@s35lp76 shell]# /root/linux/tools/perf/perf  trace -e 'open' touch /tmp/xxx
     0.000 ( 0.013 ms): touch/28615 open(filename: 0xbc990692, flags: CLOEXEC                             ) = 3
[root@s35lp76 shell]# /root/linux/tools/perf/perf  trace -e 'openat' touch /tmp/xxx
     0.000 ( 0.011 ms): touch/28617 openat(dfd: CWD, filename: 0xa7324328, flags: CLOEXEC                 ) = 3
     0.037 ( 0.009 ms): touch/28617 openat(dfd: CWD, filename: 0xa737de60, flags: CLOEXEC                 ) = 3
     0.454 ( 0.015 ms): touch/28617 openat(dfd: CWD, filename: 0xeebff57c, flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: IRUGO|IWUGO) = 3
[root@s35lp76 shell]# /root/linux/tools/perf/perf  trace -e 'open*' touch /tmp/xxx
event syntax error: 'open*'
                     \___ Cannot find PMU `open*'. Missing kernel support?
Run 'perf list' for a list of valid events

 Usage: perf trace [<options>] [<command>]
    or: perf trace [<options>] -- <command> [<options>]
    or: perf trace record [<options>] [<command>]
    or: perf trace record [<options>] -- <command> [<options>]

    -e, --event <event>   event/syscall selector. use 'perf list' to list available events
[root@s35lp76 shell]# 

Is this a configuration error on my side?
-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
