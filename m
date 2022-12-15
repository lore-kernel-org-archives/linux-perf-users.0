Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD909C4332F
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Dec 2022 07:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiLOH3E (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Dec 2022 02:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiLOH2w (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Dec 2022 02:28:52 -0500
Received: from cczrelay02.in2p3.fr (cczrelay02.in2p3.fr [134.158.66.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469A52A42C
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Dec 2022 23:28:42 -0800 (PST)
Received: from [192.168.0.12] (alb91-1-78-192-88-225.fbxo.proxad.net [78.192.88.225] (may be forged))
        (authenticated bits=0)
        by cczrelay02.in2p3.fr (8.14.4/8.14.4) with ESMTP id 2BF7SdfR031639
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Dec 2022 08:28:40 +0100
Message-ID: <071405f9-5a51-4e44-251a-c431883d9e0d@ijclab.in2p3.fr>
Date:   Thu, 15 Dec 2022 08:28:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: A few questions from writing a perf tutorial
From:   Hadrien Grasland <hadrien.grasland@ijclab.in2p3.fr>
To:     linux-perf-users@vger.kernel.org
References: <58f34e62-81d7-fc71-dec2-03e88ee36392@ijclab.in2p3.fr>
 <CAP-5=fU1TuqCzjF7k=5q2zfh_5Qz0iH1mmXKc9_MjqJGb04rNQ@mail.gmail.com>
 <98207a43-2952-30c0-7b13-a89f65a7aa9d@ijclab.in2p3.fr>
Content-Language: fr
In-Reply-To: <98207a43-2952-30c0-7b13-a89f65a7aa9d@ijclab.in2p3.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Whoops, forgot to keep the list in CC...

Le 14/12/2022 à 22:10, Hadrien Grasland a écrit :
> Hi Ian,
>
>
>>> I recently ran a perf tutorial for my colleagues (which I hope to 
>>> eventually
>>> translate to English so it's of more general use), and noted a 
>>> number of
>>> surprising things in the process.
>> Sounds great! Perhaps you can land it or a link to it on the perf wiki:
>> https://perf.wiki.kernel.org/index.php/Main_Page
>> More languages than English is a plus!
>
> Good idea. Although the fact that the tutorial is designed to be run 
> on a particular server means that people will need to adapt the 
> commands a bit, I think that's actually not that hard and it could be 
> of general use to French speakers already that way.
>
> Given the size of the material ( 
> https://grasland.pages.in2p3.fr/tp-perf/html/ ), linking will be more 
> practical than translating it to the wiki format :)
>
> I tried to create an account on that wiki, but it seems human approval 
> is required, so I'll edit in a link in once that's taken care of.
>
>
>>
>>> ===
>>>
>>> The second mystery is that perf trace run as a regular user does not
>>> correctly
>>> report thread names for all multi-threaded executables. It just reports
>>> the thread
>>> numerical ID, which makes the output hard to read unless 
>>> supplemented with a
>>> little `ps aux -L`. This may not be feasible when the threads being
>>> monitored
>>> are short-lived.
>>>
>>> When perf trace is run as root, it has no such issue, which suggests
>>> that this
>>> is a permission problem. Would you happen to know what the missing
>>> permission
>>> is and whether/how I can give it to non-root users?
>> I find the behavior a little mysterious too. Arnaldo likely can speak
>> more that something to be aware of is that the system call
>> augmentation (getting things like file names for openat calls) needs a
>> BPF program to be loaded. The logic for this predates newer BPF things
>> like skeletons, where we could build the BPF program into the perf
>> executable, and so you must specify the BPF program as an event:
>>
>> $ sudo perf trace -eopenat sleep 1
>>      0.000 ( 0.006 ms): sleep/1453070 openat(dfd: CWD, filename:
>> 0x28e12165, flags: RDONLY|CLOEXEC) = 3
>>      0.018 ( 0.002 ms): sleep/1453070 openat(dfd: CWD, filename:
>> 0x28de63e0, flags: RDONLY|CLOEXEC) = 3
>>      0.132 ( 0.004 ms): sleep/1453070 openat(dfd: CWD, filename:
>> 0x28bbc160, flags: RDONLY|CLOEXEC) = 3
>>
>> $ sudo perf trace
>> -e/usr/share/doc/linux-perf/examples/bpf/augmented_raw_syscalls.c,openat
>> sleep 1
>>      0.000 ( 0.005 ms): sleep/1452904 openat(dfd: CWD, filename:
>> "/etc/ld.so.cache", flags: RDONLY|CLOEXEC) = 3
>>      0.016 ( 0.003 ms): sleep/1452904 openat(dfd: CWD, filename:
>> "/lib/x86_64-linux-gnu/libc.so.6",flags: RDONLY|CLOEXEC) = 3
>>      0.131 ( 0.003 ms): sleep/1452904 openat(dfd: CWD, filename:
>> "/usr/lib/locale/locale-archive", flags: RDONLY|CLOEXEC) = 3
>
> Could have been a BPF issue indeed, as I have not enabled unprivileged 
> BPF on my systems. But a little "sysctl 
> kernel.unprivileged_bpf_disabled=0" permission sledgehammer does not 
> solve the problem, so that does not seem to be it ?
>
> Just to be clear, this is not about perf trace displaying syscall 
> parameters (something I actually wished it did for a while, glad to 
> know it's in there if a bit hidden !), but about it giving a 
> human-readable name to the thread that initiates the syscall.
>
> To use my tutorial server as an example, when perf trace is run as 
> non-root, slurmctld worker threads are named ":2301" and ":2303" by 
> perf trace which is not very helpful.
>
> ===
>
> $  perf trace -s -a -- sleep 1 Summary of events:
>
>  sleep (17672), 196 events, 78.4%
>
>    syscall            calls  errors  total       min avg max       stddev
>                                      (msec)    (msec)    (msec) 
> (msec)        (%)
>    --------------- --------  ------ -------- --------- --------- 
> ---------     ------
>    clock_nanosleep        1      0  1000.193  1000.193  1000.193 
> 1000.193      0.00%
>    execve                10      9     1.127     0.030 0.113 0.806     
> 68.39%
>    openat                18      1     0.114     0.006 0.006 
> 0.008      2.52%
>    mmap                  19      0     0.101     0.004 0.005 
> 0.011      6.23%
>    fstat                 17      0     0.053     0.003 0.003 
> 0.004      2.65%
>    close                 19      0     0.050     0.002 0.003 
> 0.004      3.24%
>    mprotect               4      0     0.032     0.006 0.008 0.011     
> 13.21%
>    munmap                 1      0     0.016     0.016 0.016 
> 0.016      0.00%
>    read                   4      0     0.012     0.000 0.003 0.004     
> 34.27%
>    brk                    3      0     0.011     0.003 0.004 0.004     
> 10.02%
>    access                 1      1     0.007     0.007 0.007 
> 0.007      0.00%
>    arch_prctl             1      0     0.002     0.002 0.002 
> 0.002      0.00%
>
>
>  lighttpd (2088), 2 events, 0.8%
>
>    syscall            calls  errors  total       min avg max       stddev
>                                      (msec)    (msec)    (msec) 
> (msec)        (%)
>    --------------- --------  ------ -------- --------- --------- 
> ---------     ------
>    epoll_wait             1      0     0.000     0.000 0.000 
> 0.000      0.00%
>
>
>  tmux: server (16851), 16 events, 6.4%
>
>    syscall            calls  errors  total       min avg max       stddev
>                                      (msec)    (msec)    (msec) 
> (msec)        (%)
>    --------------- --------  ------ -------- --------- --------- 
> ---------     ------
>    poll                   3      0     2.369     0.000 0.790 1.200     
> 50.01%
>    stat                   4      0     0.039     0.006 0.010 0.018     
> 30.30%
>    uname                  1      0     0.003     0.003 0.003 
> 0.003      0.00%
>
>
>  slurmctld (2280), 22 events, 8.8%
>
>    syscall            calls  errors  total       min avg max       stddev
>                                      (msec)    (msec)    (msec) 
> (msec)        (%)
>    --------------- --------  ------ -------- --------- --------- 
> ---------     ------
>    clock_nanosleep       10      0   901.706     0.000    90.171 
> 100.212     11.11%
>    futex                  1      0     0.006     0.006 0.006 
> 0.006      0.00%
>
>
>  :2301 (2301), 4 events, 1.6%
>
>    syscall            calls  errors  total       min avg max       stddev
>                                      (msec)    (msec)    (msec) 
> (msec)        (%)
>    --------------- --------  ------ -------- --------- --------- 
> ---------     ------
>    futex                  2      0     0.003     0.000 0.002 0.003    
> 100.00%
>
>
>  :2303 (2303), 4 events, 1.6%
>
>    syscall            calls  errors  total       min avg max       stddev
>                                      (msec)    (msec)    (msec) 
> (msec)        (%)
>    --------------- --------  ------ -------- --------- --------- 
> ---------     ------
>    futex                  2      1     0.003     0.000 0.001 0.003    
> 100.00%
>
> ===
>
> When perf trace is run as root, these threads are called "slurmctld" 
> and "bckfl" instead, which is a lot more in line with what I would 
> expect.
>
> ===
>
> $ sudo perf trace -s -a -- sleep 1
>
>  Summary of events:
>
>  sleep (17675), 182 events, 74.0%
>
>    syscall            calls  errors  total       min avg       max stddev
>                                      (msec)    (msec)    (msec) (msec) 
> (%)
>    --------------- --------  ------ -------- --------- --------- 
> --------- ------
>    clock_nanosleep        1      0  1000.203  1000.203  1000.203 
> 1000.203 0.00%
>    execve                 3      2     0.929     0.020 0.310 0.859 88.74%
>    openat                18      1     0.050     0.002 0.003 0.006 6.70%
>    mmap                  19      0     0.049     0.002 0.003 0.005 6.16%
>    mprotect               4      0     0.025     0.003 0.006 0.014 40.88%
>    close                 19      0     0.023     0.001 0.001 0.004 14.76%
>    fstat                 17      0     0.022     0.001 0.001 
> 0.002      3.45%
>    munmap                 1      0     0.008     0.008 0.008 
> 0.008      0.00%
>    read                   4      0     0.005     0.000 0.001 0.002     
> 38.96%
>    brk                    3      0     0.005     0.001 0.002 0.002     
> 20.26%
>    access                 1      1     0.003     0.003 0.003 
> 0.003      0.00%
>    arch_prctl             1      0     0.001     0.001 0.001 
> 0.001      0.00%
>
>  lighttpd (2088), 2 events, 0.8%
>
>    syscall            calls  errors  total       min       avg 
> max       stddev
>                                      (msec)    (msec)    (msec) 
> (msec)        (%)
>    --------------- --------  ------ -------- --------- --------- 
> ---------     ------
>    epoll_wait             1      0     0.000     0.000     0.000 
> 0.000      0.00%
>
>
>  systemd-journal (920), 10 events, 4.1%
>
>    syscall            calls  errors  total       min       avg 
> max       stddev
>                                      (msec)    (msec)    (msec) 
> (msec)        (%)
>    --------------- --------  ------ -------- --------- --------- 
> ---------     ------
>    ftruncate              1      0     0.008     0.008     0.008 
> 0.008      0.00%
>    read                   1      0     0.005     0.005     0.005 
> 0.005      0.00%
>    timerfd_settime        1      0     0.004     0.004     0.004 
> 0.004      0.00%
>    gettid                 1      0     0.003     0.003     0.003 
> 0.003      0.00%
>    epoll_wait             1      0     0.000     0.000     0.000 
> 0.000      0.00%
>
>
>  tmux: server (16851), 16 events, 6.5%
>
>    syscall            calls  errors  total       min       avg 
> max       stddev
>                                      (msec)    (msec)    (msec) 
> (msec)        (%)
>    --------------- --------  ------ -------- --------- --------- 
> ---------     ------
>    poll                   3      0     2.262     0.000     0.754 
> 1.195     50.24%
>    openat                 1      0     0.015     0.015     0.015 
> 0.015      0.00%
>    read                   1      0     0.010     0.010     0.010 
> 0.010      0.00%
>    ioctl                  1      0     0.005     0.005     0.005 
> 0.005      0.00%
>    fstat                  1      0     0.003     0.003     0.003 
> 0.003      0.00%
>    close                  1      0     0.003     0.003     0.003 
> 0.003      0.00%
>
>
>  slurmctld (2280), 22 events, 8.9%
>
>    syscall            calls  errors  total       min       avg 
> max       stddev
>                                      (msec)    (msec)    (msec) 
> (msec)        (%)
>    --------------- --------  ------ -------- --------- --------- 
> ---------     ------
>    clock_nanosleep       10      0   901.748     0.000    90.175 
> 100.217     11.11%
>    futex                  1      0     0.006     0.006     0.006 
> 0.006      0.00%
>
>
>  slurmctld (2301), 4 events, 1.6%
>
>    syscall            calls  errors  total       min       avg 
> max       stddev
>                                      (msec)    (msec)    (msec) 
> (msec)        (%)
>    --------------- --------  ------ -------- --------- --------- 
> ---------     ------
>    futex                  2      0     0.003     0.000     0.002 
> 0.003    100.00%
>
>
>  bckfl (2303), 4 events, 1.6%
>
>    syscall            calls  errors  total       min       avg 
> max       stddev
>                                      (msec)    (msec)    (msec) 
> (msec)        (%)
>    --------------- --------  ------ -------- --------- --------- 
> ---------     ------
>    futex                  2      1     0.003     0.000     0.001 
> 0.003    100.00%
>
> ===
>
> (Also, I see systemd-journald activity when I run perf trace as root 
> and not when I do so as a regular user, but I guess that bit is normal 
> permissions at work ?)
>
> This is not specific to slurmctld by the way, I observed similar 
> things with the threads of one Electron app on my local development 
> machine while trying to reproduce on a more current version of perf 
> (the server on which I ran perf trace above runs Linux 5.14, the 
> machine on which I reproduced runs 6.0).
>
> Cheers,
> Hadrien
>
