From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: perf buildid-cache -p <path> question
Date: Tue, 24 Oct 2017 09:56:02 +0200
Message-ID: <140bd721-4929-22ee-ce77-b7fe575a470c@linux.vnet.ibm.com>
References: <8594e11c-9aa1-f600-3f04-eb80058c9abf@linux.vnet.ibm.com>
 <20171016141222.GC5311@kernel.org>
 <20171021011259.5d6368a7fd1f54004b6ae1da@kernel.org>
 <20171020162056.GH30002@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53900 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751674AbdJXH4J (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 24 Oct 2017 03:56:09 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9O7sJLb003742
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2017 03:56:08 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dt0dhcktw-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2017 03:56:08 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Tue, 24 Oct 2017 08:56:06 +0100
In-Reply-To: <20171020162056.GH30002@kernel.org>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

On 10/20/2017 06:20 PM, Arnaldo Carvalho de Melo wrote:
> Em Sat, Oct 21, 2017 at 01:12:59AM +0900, Masami Hiramatsu escreveu:
>> On Mon, 16 Oct 2017 11:12:22 -0300
>> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>
>>
>> For example, you have a /usr/bin/tar (this is old tar) and its buildid-cache
>> in cache directory by perf buildid-cache -a /usr/bin/tar.
>> And at some point, you will update the /usr/bin/tar (this is new tar).
>> This new tar binary is not same as old one, so if you also do
>> perf buildid-cache -a /usr/bin/tar, it creates another version of buildid
>> cache in cache directory.
>>
>> At this moment,
>> $ perf buildid-cache -r /usr/bin/tar
>> will remove only new tar's buildid cache, but old one remains.
>>
>> On the other hand,
>> $ perf buildid-cache -p /usr/bin/tar
>> will remove all the caches related to /usr/bin/tar from buildid cache.
>>
>> And since the -p is supposed to be used for cleanup, it doesn't return
>> error even if there is no buildid cache remaining.
>>
>>
>> Should it work for a directory instead of a file too?
>> I need to investigate it too.
> 
> Isn't that implemented by I patch by Thomas?
> 
> - Arnaldo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Ok, I have understood the behavior of commands
perf buildid-cache -a
and
perf buildid-cache -r.

Same with command perf buildid-cache -p /usr/bin/tar.
It works correctly if you specify a file name and not a directory as I did
in my previous append.

I was mislead by the man page which says
"file list" for option -a
"file(s) to remove" for option -r
"path(s) to remove (remove old caches too)' for option -p

I just find it confusing to explicitly mention files for
option -a and -r whereas option -p mentions path.

We can drop my patch but I would like to clarify the man page
to explicitly mention "file(s)" or "file list" instead of path for option -p.

What do you think?                                                                             

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
