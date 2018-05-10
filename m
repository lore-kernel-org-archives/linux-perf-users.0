From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v2]: perf/x86: store user space frame-pointer value on a
 sample
Date: Thu, 10 May 2018 12:42:38 +0300
Message-ID: <3ecedd91-1c01-6fc5-4648-89eaf5ff0930@linux.intel.com>
References: <31205dc8-b756-e12b-0249-2ed06c2db9c9@linux.intel.com>
 <20180509145436.GV12217@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180509145436.GV12217@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Hi,

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

Well ok, at the moment I don't see the rationale behind exposure the other 
registers so they still may be reported as -1.

However BP may contain valid frame address not only on syscalls but also 
for samples landing into user space. 

> 
> The Changelog needs to state that user_regs->bp is in fact valid and

That actually was tested on binaries compiled without and with BP exposed 
and in the latter case proved the value of that change.

Test executable for the example below was compiled with frame pointer 
support enabled:

g++ -o futex-fp -fpermissive --no-omit-frame-pointer futex.c

and profiled using:

tools/perf/perf record --user-regs=IP,SP,BP \
	-g --call-graph=dwarf,1024 -e cycles -- ./futex-fp

Output of

tools/perf/perf report -i perf.data --stdio 

demonstrates the effect of the patch change so before saving BP 
value on a sample we have several frames missing above main 
function frame:

# Samples: 138K of event 'cpu-cycles'
# Event count (approx.): 92713835335
#
# Children      Self  Command   Shared Object     Symbol                                        
# ........  ........  ........  ................  ..........................
#
    96.15%     0.72%  futex-fp  futex-fp          [.] main
            |          
            |--95.43%--main
            |          |          
            |          |--71.56%--syscall
            |          |          |          
            |          |          |--57.28%--entry_SYSCALL_64_after_hwframe
            |          |          |          |          
            |          |          |           --56.95%--do_syscall_64
            |          |          |                     |          
            |          |          |                      --55.77%--sys_futex

and after saving BP value on a sample we have expected 

	_start
	__libc_start_main 

frames unwound:

# Samples: 128K of event 'cpu-cycles'
# Event count (approx.): 85349981034
#
# Children      Self  Command   Shared Object     Symbol                                        
# ........  ........  ........  ................  ..................
#
    95.83%     0.00%  futex-fp  futex-fp          [.] _start
            |
==>         ---_start
==>            __libc_start_main
               main
               |          
               |--71.28%--syscall
               |          |          
               |          |--55.67%--entry_SYSCALL_64
               |          |          |          
               |          |           --55.40%--do_syscall_64
               |          |                     |          
               |          |                      --54.21%--sys_futex


> ideally point to the commits that makes it so. Also this patch should
> update that comment.

Accepted.

> 
> Cc Andy who keeps better track of all that than me.

Yes, any comments and feedback would be very welcome.

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
