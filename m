From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v2]: perf/x86: store user space frame-pointer value on a
 sample
Date: Tue, 15 May 2018 11:08:59 +0300
Message-ID: <eb83a97a-2e62-9c18-b738-a92b2f4dee23@linux.intel.com>
References: <31205dc8-b756-e12b-0249-2ed06c2db9c9@linux.intel.com>
 <20180509145436.GV12217@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180509145436.GV12217@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org


Hi Andy,

On 09.05.2018 17:54, Peter Zijlstra wrote:
> On Tue, May 08, 2018 at 06:21:36PM +0300, Alexey Budankov wrote:
>>
>> Store user space frame-pointer value (BP register) into Perf trace 
>> on a sample for a process so the value becomes available when 
>> unwinding call stacks for functions gaining event samples.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  arch/x86/kernel/perf_regs.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
>> index e47b2dbbdef3..8d68658eff7f 100644
>> --- a/arch/x86/kernel/perf_regs.c
>> +++ b/arch/x86/kernel/perf_regs.c
>> @@ -156,7 +156,13 @@ void perf_get_regs_user(struct perf_regs *regs_user,
> 
> 
>>  	 * Most system calls don't save these registers, don't report them.
> 
> ^^^ that worries me and is the reason for the '-1's below. However I
> think with all the PTI rework this might no longer be true.
> 
> The Changelog needs to state that user_regs->bp is in fact valid and
> ideally point to the commits that makes it so. Also this patch should
> update that comment.
> 
> Cc Andy who keeps better track of all that than me.

Are there any thoughts so far? Feedback on the matter above is highly appreciated.

Thanks,
Alexey

> 
>>  	 */
>>  	regs_user_copy->bx = -1;
>> -	regs_user_copy->bp = -1;
>> +	/*
>> +	 * Store user space frame-pointer value on sample
>> +	 * to facilitate stack unwinding for cases when
>> +	 * user space executable code has such support
>> +	 * enabled at compile time;
>> +	 */
>> +	regs_user_copy->bp = user_regs->bp;
>>  	regs_user_copy->r12 = -1;
>>  	regs_user_copy->r13 = -1;
>>  	regs_user_copy->r14 = -1;
> 
