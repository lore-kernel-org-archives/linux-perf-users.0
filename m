From: Arnaldo de Melo <acme@redhat.com>
Subject: Re: [PATCH] perf test shell: Fix check open filename arg using 'perf
 trace'
Date: Thu, 30 Nov 2017 13:56:42 -0200
Message-ID: <20171130155642.GA2893@redhat.com>
References: <alpine.LRH.2.20.1711291656270.9416@Diego>
 <84d4a40a-dfbf-6d9b-9eb2-6912dc6f57e4@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752403AbdK3P4p (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Nov 2017 10:56:45 -0500
Content-Disposition: inline
In-Reply-To: <84d4a40a-dfbf-6d9b-9eb2-6912dc6f57e4@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: Michael Petlan <mpetlan@redhat.com>, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>

Em Thu, Nov 30, 2017 at 11:28:33AM +0100, Thomas-Mich Richter escreveu:
> On 11/29/2017 06:27 PM, Michael Petlan wrote:
> > Hi Arnaldo, Jiri and others!
> > 
> > Posting a fix for perf test "Check open filename arg using perf trace + vfs_getname".
> > 
> > The commit f231af789b11a2f1a3795acc3228a3e178a80c21 adds an exception for s390x to
> > use openat() syscall instead of open(). This exception is not s390x-only, thus I
> > adjusted the test to accept both open and openat syscalls, no matter which arch it
> > runs on. Does it sound reasonable to you?
> > 
> > 
> > When testing on 4.15.0-rc1, I also hit the following issue:
> > 
> > # perf probe "vfs_getname=getname_flags:72 pathname=result->name:string"
> > Failed to find 'result' in this function.
> >   Error: Failed to add events.
> > 
> > # perf probe -L getname_flags 
> > [...]
> >      72         result->uptr = filename;
> >      73         result->aname = NULL;
> > [...]
> > 
> > # perf probe "vfs_getname=getname_flags:72 pathname=result->uptr:string"
> > Failed to find 'result' in this function.
> >   Error: Failed to add events.
> > 
> > ... When the probed var is changed to "filename", it seems to work:
> > 
> > # perf probe "vfs_getname=getname_flags:72 pathname=filename:string"
> > Added new event:
> >   probe:vfs_getname    (on getname_flags:72 with pathname=filename:string)
> > 
> > You can now use it in all perf tools, such as:
> > 
> > 	perf record -e probe:vfs_getname -aR sleep 1
> > 
> > 
> > So maybe the second attached patch is necessary too, not sure. Just thinking
> > that "filename" might be less change-prone, as a func. arg... ?
> > 
> > Thank you.
> > 
> > Cheers,
> > Michael
> > 
> 
> Maybe I have done something wrong when I tried your patch. I have download
> latest 4.15.0rc1 but your patch does not work for me.
> My perf tool does not handle wild cards on events:
> 
> root@s35lp76 shell]# /root/linux/tools/perf/perf  trace -e 'open' touch /tmp/xxx
>      0.000 ( 0.013 ms): touch/28615 open(filename: 0xbc990692, flags: CLOEXEC                             ) = 3
> [root@s35lp76 shell]# /root/linux/tools/perf/perf  trace -e 'openat' touch /tmp/xxx
>      0.000 ( 0.011 ms): touch/28617 openat(dfd: CWD, filename: 0xa7324328, flags: CLOEXEC                 ) = 3
>      0.037 ( 0.009 ms): touch/28617 openat(dfd: CWD, filename: 0xa737de60, flags: CLOEXEC                 ) = 3
>      0.454 ( 0.015 ms): touch/28617 openat(dfd: CWD, filename: 0xeebff57c, flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: IRUGO|IWUGO) = 3
> [root@s35lp76 shell]# /root/linux/tools/perf/perf  trace -e 'open*' touch /tmp/xxx
> event syntax error: 'open*'
>                      \___ Cannot find PMU `open*'. Missing kernel support?
> Run 'perf list' for a list of valid events
> 
>  Usage: perf trace [<options>] [<command>]
>     or: perf trace [<options>] -- <command> [<options>]
>     or: perf trace record [<options>] [<command>]
>     or: perf trace record [<options>] -- <command> [<options>]
> 
>     -e, --event <event>   event/syscall selector. use 'perf list' to list available events
> [root@s35lp76 shell]# 
> 
> Is this a configuration error on my side?

[acme@jouet linux]$ git log -1 27702bcfe8a125a1feeeb5f07526d63b20cac47f --oneline
27702bcfe8a1 perf trace: Support syscall name globbing
[acme@jouet linux]$

Is in v4.14 final.

Testing with/without those quotes:

[root@jouet ~]# perf trace -e open* touch /etc/passwd
     0.000 ( 0.007 ms): touch/17246 open(filename: 0x99747e37, flags: CLOEXEC                             ) = 3
     0.022 ( 0.004 ms): touch/17246 open(filename: 0x9994b640, flags: CLOEXEC                             ) = 3
     0.189 ( 0.004 ms): touch/17246 open(filename: 0x994f1c70, flags: CLOEXEC                             ) = 3
     0.224 ( 0.056 ms): touch/17246 open(filename: 0xaa80a32a, flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: IRUGO|IWUGO) = 3
[root@jouet ~]# perf trace -e 'open*' touch /etc/passwd
     0.000 ( 0.039 ms): touch/17250 open(filename: 0xf1445e37, flags: CLOEXEC                             ) = 3
     0.107 ( 0.030 ms): touch/17250 open(filename: 0xf1649640, flags: CLOEXEC                             ) = 3
     0.976 ( 0.009 ms): touch/17250 open(filename: 0xf11efc70, flags: CLOEXEC                             ) = 3
     1.032 ( 0.008 ms): touch/17250 open(filename: 0x9357432a, flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: IRUGO|IWUGO) = 3
[root@jouet ~]#

What differs from x86 to others is that x86 uses syscalltbl, not requiring
audit-libs to map syscall numbers to names, so perhaps it is something in there...

- Arnaldo
