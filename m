From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: Question to perf annotate handling mov ...(%rip) instructions
Date: Wed, 29 Nov 2017 10:26:59 +0100
Message-ID: <25a6897f-dc5d-f515-aba9-1f44d140b36c@linux.vnet.ibm.com>
References: <f241fe0b-7a3f-cb6a-51ee-4833bce81e70@linux.vnet.ibm.com>
 <20171128145030.GG3298@kernel.org> <20171129082950.GA26610@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44270 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753178AbdK2J1I (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 29 Nov 2017 04:27:08 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAT9NhrD031937
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Nov 2017 04:27:08 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2eht7m84fm-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Nov 2017 04:27:05 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Wed, 29 Nov 2017 09:27:03 -0000
In-Reply-To: <20171129082950.GA26610@krava>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

On 11/29/2017 09:29 AM, Jiri Olsa wrote:
> On Tue, Nov 28, 2017 at 11:50:30AM -0300, Arnaldo Carvalho de Melo wrote:
> 
> SNIP
> 
>>> Function mov__parse() calls comment__symbol() which contains:
>>>
>>>    static int comment__symbol(char *raw, char *comment, u64 *addrp, char **namep)
>>>    {
>>>         char *endptr, *name, *t;
>>>
>>>         if (strstr(raw, "(%rip)") == NULL)
>>>                 return 0;
>>>
>>> This is architecture specific and does not work for non-Intel platforms.
>>>
>>> I would like to fix perf annotate for s390x and above move instruction on s390x
>>> is
>>>      
>>>     655a:       c0 10 00 01 9c eb       larl    %r1,39f30 <__gmon_start__>
>>>
>>> There is a need to handle PLT resolution in an architecture independent way.
>>>
>>> Ideas and suggestions?
>>
>> Some historical background there, busy now, but you seem to be on the
>> right track and IIRC you already sent a patch for this, right? I'll try
>> to look at it.
>>
>> Jiri may as well, since he worked a lot recently in this codebase, to
>> refactor it some more to make it useful for annotating python code, perl
>> next, other scripted languages should follow too.
> 
> so we try to parse each line out of objdump using arch specific
> ops callbacks, check:
> 
> disasm_line__new
>   disasm_line__init_ins
>     dl->ins.ops->parse(...
> 
> the ops stuff are defined in:
> 
> static struct arch architectures[] = { 
> 
>         {
>                 .name = "s390",
>                 .init = s390__annotate_init,
>                 .objdump =  {
>                         .comment_char = '#',
>                 },
>         },
> 
> I'd check s390__annotate_init, there's some mechanism
> of associating ops for arch and try to fit in ;-)
> 
> jirka
> 

Ahhhh, I get it now. The code in util/annotate.c (for example mov__parse())
is in a common code file, but these functions are called via architecture 
depended triggers.

I'll go and try something for s390x to handle PLT resolution.

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
