From: Paul Clarke <pc@us.ibm.com>
Subject: Re: uprobes enable condition (user space) - sysfs interface
Date: Mon, 4 Dec 2017 09:23:16 -0600
Message-ID: <5246be84-1fb5-c1d7-130f-b990b3bac471@us.ibm.com>
References: <CA+bpL9+McSzeKW+eXHfMJMFRm-EenC9_0pGZkGpSdFzOVozKiw@mail.gmail.com>
 <20171201164039.GC3298@kernel.org>
 <20171204213619.973d74567a7de0af15876aac@kernel.org>
 <20171204145558.GA27554@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35452 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751283AbdLDPXW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 4 Dec 2017 10:23:22 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB4FNGGo014180
        for <linux-perf-users@vger.kernel.org>; Mon, 4 Dec 2017 10:23:22 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2en8b6adnc-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Dec 2017 10:23:21 -0500
Received: from localhost
        by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <pc@us.ibm.com>;
        Mon, 4 Dec 2017 08:23:21 -0700
In-Reply-To: <20171204145558.GA27554@kernel.org>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: bhargavb <bhargavaramudu@gmail.com>, linux-rt-users@vger.kernel.org, linux-perf-users@vger.kernel.org

On 12/04/2017 08:55 AM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Dec 04, 2017 at 09:36:19PM +0900, Masami Hiramatsu escreveu:
>> On Fri, 1 Dec 2017 13:40:39 -0300
>> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>
>>> Adding Masami to the CC list, to see if he can come up with a fix for
>>> the 'perf probe' failure below, improving the message or ignoring
>>> versioned symbols (with a warning perhaps).
>>
>> Thanks. Should we ignore the versioned symbols? or can we put a probe
>> on that? If we have symbol address, we can put a probe on it, even
>> if it is versioned.
> 
> Lemme try...
> 
> [root@jouet ~]# perf probe -x /usr/lib64/libc-2.25.so malloc_get_state_225=malloc_get_state@GLIBC_2.2.5
> The /usr/lib64/libc-2.25.so file has no debug information.
> Rebuild with -g, or install an appropriate debuginfo package.
>   Error: Failed to add events.
> [root@jouet ~]# perf probe -x /usr/lib64/libc-2.25.so malloc_get_state@GLIBC_2.2.5
> The /usr/lib64/libc-2.25.so file has no debug information.
> Rebuild with -g, or install an appropriate debuginfo package.
>   Error: Failed to add events.

commit d80406453ad4a69932dc17a617d5b7bc7ae80b8f should have allowed adding probes on versioned symbols if you omit the versioning part of the symbol.  So, in the above example, this should work:

# perf probe -x /usr/lib64/libc-2.25.so malloc_get_state

PC
