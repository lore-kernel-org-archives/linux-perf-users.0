From: Hemant Kumar <hemant@linux.vnet.ibm.com>
Subject: Re: perf user SDT markers
Date: Mon, 13 Apr 2015 14:57:54 +0530
Message-ID: <552B8C1A.8030606@linux.vnet.ibm.com>
References: <CAE40pdf1Y3mQMnVi7jSBMg8ovg7x3L17jCf_yGemM_PLLG_k1g@mail.gmail.com> <CAE40pdcCMaO6Lih7enhkxLFdwsbSyDuPjoRbBJLa6arPEz5qYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:38278 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236AbbDMJ2v (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 13 Apr 2015 05:28:51 -0400
Received: from /spool/local
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-perf-users@vger.kernel.org> from <hemant@linux.vnet.ibm.com>;
	Mon, 13 Apr 2015 19:28:49 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 625512CE8050
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2015 19:28:46 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t3D9SbKE50528460
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2015 19:28:46 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t3D9SCth024243
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2015 19:28:12 +1000
In-Reply-To: <CAE40pdcCMaO6Lih7enhkxLFdwsbSyDuPjoRbBJLa6arPEz5qYQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>

Hi Brendan,

On 04/13/2015 01:35 AM, Brendan Gregg wrote:
> On Sat, Apr 11, 2015 at 7:13 PM, Brendan Gregg
> <brendan.d.gregg@gmail.com> wrote:
>> G'Day,
>>
>> I was just trying Hemant Kumar's user SDT patch
>> (http://lwn.net/Articles/618956/); anyone else tried it recently? I
>> applied it to 4.0.0-rc6, and it creates instrumentation, but doesn't
>> record the probes.
>>
>> This works (it finds the Node.js probes):
>>
>> # ./perf sdt-cache --dump
>> /home/bgregg-testtest/node-standard/out/Release/node:
>>     %node:net__server__connection
>>     %node:net__stream__end
>>     %node:net__socket__read
>>     %node:net__socket__write
>>     %node:http__server__request
>>     %node:http__server__response
>>     %node:http__client__request
>>     %node:http__client__response
>>     %node:gc__done
>>     %node:gc__start
>>
>> But I can't "perf list" or record them:
>>
>> # ./perf record -e '%node:http__server__request' -aR
>> invalid or unsupported event: '%node:http__server__request'
>> Run 'perf list' for a list of valid events
>> [...]
>>
>> stap works:
>>
>> # /root/systemtap-2.8/bin/stap -e 'probe
>> process("/home/bgregg-testtest/node-standard/out/Release/node").mark("http__server__request")
>> { println("hit"); }'
>> hit
>> hit
>>
>> Brendan
> Some more digging... So a simple C program with a DTRACE_PROBE1()
> works, where the marker ends up being "%tick:loop":
>
> # ./perf record -e '%tick:loop' -a -g
> [...]
> ^C
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.334 MB perf.data (2 samples) ]
>
> But the %node markers don't work (eg, "%node:gc__start"). Maybe the
> presence of underscores is breaking it? By adding some debug
> statements, I dug this message out of yyparse(), which was failing:
>
> yyparse() yymsgbuf: syntax error, unexpected PE_NAME, expecting $end

I rebased and tried the patches with perf for the latest tip:

# ./perf sdt-cache --add /lib64/libc.so.6
    8 events added for /lib64/libc.so.6

# ./perf sdt-cache --dump
/usr/lib64/libc-2.16.so:
    %libc:setjmp
    %libc:longjmp
    %libc:longjmp_target
    %libc:lll_futex_wake
    %libc:lll_lock_wait_private
    %libc:longjmp
    %libc:longjmp_target
    %libc:lll_futex_wake


# ./perf record -e %libc:longjmp_target -aR sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.286 MB perf.data ]

Its able to probe and record on %libc:longjmp_target with an underscore.

Also, can you please point me to the node.js with SDT markers you are 
using and can you dump me the readelf -n /path/to/node.js o/p?

-- 
Thanks,
Hemant Kumar
