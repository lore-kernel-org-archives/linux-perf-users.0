From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: perf buildid-cache -p <path> question
Date: Thu, 26 Oct 2017 09:05:33 +0200
Message-ID: <b10e060a-2027-5c9e-66e0-15b82cb09394@linux.vnet.ibm.com>
References: <8594e11c-9aa1-f600-3f04-eb80058c9abf@linux.vnet.ibm.com>
 <20171016141222.GC5311@kernel.org>
 <20171021011259.5d6368a7fd1f54004b6ae1da@kernel.org>
 <20171020162056.GH30002@kernel.org>
 <140bd721-4929-22ee-ce77-b7fe575a470c@linux.vnet.ibm.com>
 <20171026020408.053d2985bdd1e4fef824fbcb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750997AbdJZHFi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 Oct 2017 03:05:38 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9Q74rnK099620
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Oct 2017 03:05:38 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2du58pph7t-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Oct 2017 03:05:37 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Thu, 26 Oct 2017 08:05:36 +0100
In-Reply-To: <20171026020408.053d2985bdd1e4fef824fbcb@kernel.org>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

On 10/25/2017 07:04 PM, Masami Hiramatsu wrote:
> On Tue, 24 Oct 2017 09:56:02 +0200
> Thomas-Mich Richter <tmricht@linux.vnet.ibm.com> wrote:

...

>>
>> Ok, I have understood the behavior of commands
>> perf buildid-cache -a
>> and
>> perf buildid-cache -r.
>>
>> Same with command perf buildid-cache -p /usr/bin/tar.
>> It works correctly if you specify a file name and not a directory as I did
>> in my previous append.
>>
>> I was mislead by the man page which says
>> "file list" for option -a
>> "file(s) to remove" for option -r
>> "path(s) to remove (remove old caches too)' for option -p
>>
>> I just find it confusing to explicitly mention files for
>> option -a and -r whereas option -p mentions path.
>>
>> We can drop my patch but I would like to clarify the man page
>> to explicitly mention "file(s)" or "file list" instead of path for option -p.
>>
>> What do you think?
> 
> Indeed. Originally the "file" means existing file but "path" means the path in the
> cache, which can be already removed. However, that can mislead users.
> So I agree that is unified to "file list".
> 
> Thank you,
> 

Ok, do you change the man page or should I submit a patch?


-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
