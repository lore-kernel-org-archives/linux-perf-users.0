From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: perf buildild-list -H dumps core
Date: Mon, 16 Oct 2017 09:00:01 +0200
Message-ID: <453dbd4a-a63f-2d12-6f1b-9b9d0d2eba93@linux.vnet.ibm.com>
References: <6ec683e8-f23e-0595-5674-d5ef20ae03f5@linux.vnet.ibm.com>
 <20171013144805.GQ3503@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48090 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750772AbdJPHAI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 16 Oct 2017 03:00:08 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9G6wwMr069242
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Oct 2017 03:00:07 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dmpqnjpvj-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Oct 2017 03:00:07 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Mon, 16 Oct 2017 08:00:05 +0100
In-Reply-To: <20171013144805.GQ3503@kernel.org>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

On 10/13/2017 04:48 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Oct 13, 2017 at 09:33:55AM +0200, Thomas-Mich Richter escreveu:
>> Maybe this has been fixed already, but I hit a core dump when I do this:
>>
>> [root@s35lp76 docker]# uname -a
>> Linux s35lp76 4.14.0-rc3tmr1+ #5 SMP Thu Oct 5 10:05:43 CEST 2017 s390x s390x s390x GNU/Linux
>> [root@s35lp76 docker]# ~/linux/tools/perf/perf buildid-list -i 333.perf.data 
>> 15dd27179a5fe664c0778b7871989c101b1ac506 /lib/modules/4.14.0-rc3tmr1+/build/vmlinux
>> 4d16d00bd6ed5969f2ef3176d3e52801c85ed9d8 [vdso]
>> 0a751d08365dbbca4ac4deb7ed2b8107d42bad80 /lib/libc.so.6
>> 5c0a120336206d0483d3d8112207fbb54ba00a44 /bin/find
>> a70676b1cdcc5575e4c5e34a5b80746dca120f75 /bin/ls
>> [root@s35lp76 docker]# ~/linux/tools/perf/perf buildid-list -H -i 333.perf.data 
>> Segmentation fault (core dumped)
>>
>> [root@s35lp76 docker]# 
>>
>> Shouldn't I specify option -H ?
>>
>> I have not tried this on Intel, maybe it is platform related?
>>
>> Thanks for your help
> 
> Can you please provide a backtrace? I just tried it here and couldn't
> reproduce.
> 

Here is a simple way to reproduce it:

[root@s35lp76 perf]# ./perf record --namespace -a sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.184 MB perf.data (4 samples) ]
[root@s35lp76 perf]# ./perf buildid-list -H
Segmentation fault (core dumped)
[root@s35lp76 perf]# ./perf record  -a sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.147 MB perf.data (5 samples) ]
[root@s35lp76 perf]# ./perf buildid-list -H
15dd27179a5fe664c0778b7871989c101b1ac506 [kernel.kallsyms]
[root@s35lp76 perf]# 

Hope this helps.

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
