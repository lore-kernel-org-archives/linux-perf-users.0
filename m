From: Arnab <arnabjyotikalita35@gmail.com>
Subject: Modify the output of perf script
Date: Fri, 1 Dec 2017 20:26:40 -0500
Message-ID: <37e8d06f-a1c2-e85f-7ba8-03d0e7f2ae52@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:46779 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbdLBB0q (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 1 Dec 2017 20:26:46 -0500
Received: by mail-qk0-f176.google.com with SMTP id b184so15403639qkc.13
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Dec 2017 17:26:46 -0800 (PST)
Received: from [10.22.20.122] (compas.cs.stonybrook.edu. [130.245.158.1])
        by smtp.gmail.com with ESMTPSA id v89sm5512763qkv.80.2017.12.01.17.26.43
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Dec 2017 17:26:44 -0800 (PST)
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello,

I have been using IntelPT and perf-kvm to collect guest VM generated PT 
packets from the host. I use the below command to record the IntelPT 
traces :-

./perf kvm --guest -guestkallsyms=~/guest-kallsyms 
-guestmodules=~/guest-modules -e intel_pt//

I am using the latest stable Linux kernel version that is 4.14.3 and I 
am using an Ubuntu 17.04 machine running on architecture x86_64.

The above command works fine and is giving me the correct outputs as I 
expect. Now I am trying to see the raw trace dump using perf script -D

./perf script -D -i perf.data.guest

I see all the event records and all their outputs correctly. But what I 
wanted was to make perf script only display me the events corresponding 
to IntelPT trace packets.

This means that I am especially not interested in events like 
PERF_RECORD_COMM and PERF_RECORD_FORK etc and even 
PERF_RECORD_MMAP/PERF_RECORD_MMAP2. I only want perf script to display 
me the raw trace packets under PERF_RECORD_AUXTRACE.

There are obviously two cases here which I have so far considered but 
have not been able to get anywhere :

1. I have tried making perf record stop recording events, which I do not 
want like PERF_RECORD_MMAP, PERF_RECORD_FORK etc. I have been 
unsuccessful and I also think this is not the right approach.

2. The other approach that I have tried is making perf script -D to not 
print the MMAP and FORK events instead but keep recording them. I have 
not been able to do this as I have not been able to trace back in the 
linux-kernel code where the actual print is happening. This looks 
correct and probably easier to achieve.

How can I achieve one of the two goals stated above ? How can I make 
perf script dump me exactly what I want ?

Thanks and Regards,
Arnab
