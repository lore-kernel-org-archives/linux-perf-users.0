From: Thomas Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH] perf test: Test case 66 broken on s390 (lib/traceevent
 issue)
Date: Mon, 27 Jan 2020 08:34:23 +0100
Message-ID: <659928a1-95b3-ed0d-7988-745d92b495d6@linux.ibm.com>
References: <20200124073941.39119-1-tmricht@linux.ibm.com>
 <20200124100742.4050c15e@gandalf.local.home>
 <20200125013153.46f05fc1f617fcd341e7060b@kernel.org>
 <20200124113610.662f4afb@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200124113610.662f4afb@gandalf.local.home>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, borntraeger@de.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On 1/24/20 5:36 PM, Steven Rostedt wrote:
> On Sat, 25 Jan 2020 01:31:53 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
>> Hi Steven and Thomas,
>>
>> On Fri, 24 Jan 2020 10:07:42 -0500
>> Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>>> This looks like a kernel bug, not a libtraceevent parsing bug.  
>>
>> Totally agreed. It was my fault to update the print format.
>> Even if still there is a problem on s390, this patch must be
>> applied.
> 
> Thanks Masami for looking into it.
> 
> Thomas,
> 
> Please still test this patch. If it works, I'd like to add a
> Reported-by and Tested-by tag from you.
> 
> -- Steve
> 
>>
>> Fixes: 88903c464321 ("tracing/probe: Add ustring type for user-space string")
>> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
>>

Steven and Masami,

thanks for the patch, it fixes this issue!

PS: I should have sent this description earlier, would have saved a week of debugging
on my side....

-- 
Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
