From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: Question to perf annotate handling mov ...(%rip) instructions
Date: Wed, 29 Nov 2017 10:14:37 +0100
Message-ID: <64422ec4-d081-0f0e-9b0c-c5b7d566da85@linux.vnet.ibm.com>
References: <f241fe0b-7a3f-cb6a-51ee-4833bce81e70@linux.vnet.ibm.com>
 <20171128145030.GG3298@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171128145030.GG3298@kernel.org>
Content-Language: en-IE
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On 11/28/2017 03:50 PM, Arnaldo Carvalho de Melo wrote:

.....

>> .... 
>> 60b4:       48 8b 05 35 cd 22 00    mov 0x22cd35(%rip),%rax   # 232df0 <__gmon_start__>     
>>
>> Commit 6de783b6f50f7f1db18a3fda0aa34b2e84b5771d ("perf annotate: Resolve symbols 
>> using objdump comment") added this support.
>>
>> Special code for Intel platform handles the mov  at address 60b4: 
>> This is dynamic linkage against the PLT. Function mov__parse() is always called 
>> to parse the objdump comment following the '#' character. 
>> However the function mov__scnprintf() to replace the text '0x22cd35(%rip)' by the 
>> target function name __gmon_start__ is only called in tui mode and not in stdio mode.
>>
>> Now to the confusion:
>> Function mov__parse() calls comment__symbol() which contains:
>>
>>    static int comment__symbol(char *raw, char *comment, u64 *addrp, char **namep)
>>    {
>>         char *endptr, *name, *t;
>>
>>         if (strstr(raw, "(%rip)") == NULL)
>>                 return 0;
>>
>> This is architecture specific and does not work for non-Intel platforms.
>>
>> I would like to fix perf annotate for s390x and above move instruction on s390x
>> is
>>      
>>     655a:       c0 10 00 01 9c eb       larl    %r1,39f30 <__gmon_start__>
>>
>> There is a need to handle PLT resolution in an architecture independent way.
>>
>> Ideas and suggestions?
> 
> Some historical background there, busy now, but you seem to be on the
> right track and IIRC you already sent a patch for this, right? I'll try
> to look at it.

The two patches I sent are unrelated to this issue.

> Jiri may as well, since he worked a lot recently in this codebase, to
> refactor it some more to make it useful for annotating python code, perl
> next, other scripted languages should follow too.

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
