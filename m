From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v4 2/9] perf/core: open access for CAP_SYS_PERFMON
 privileged process
Date: Thu, 9 Jan 2020 14:36:50 +0300
Message-ID: <cc239899-5c52-2fd0-286d-4bff18877937@linux.intel.com>
References: <c0460c78-b1a6-b5f7-7119-d97e5998f308@linux.intel.com>
 <c93309dc-b920-f5fa-f997-e8b2faf47b88@linux.intel.com>
 <20200108160713.GI2844@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-security-module-owner@vger.kernel.org>
In-Reply-To: <20200108160713.GI2844@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>, "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>, Alexei Starovoitov <ast@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "james.bottomley@hansenpartnership.com" <james.bottomley@hansenpartnership.com>, Serge Hallyn <serge@hallyn.com>, James Morris <jmorris@namei.org>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Casey Schaufler <casey@schaufler-ca.com>, Robert Richter <rric@kernel.org>, Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak>
List-Id: linux-perf-users.vger.kernel.org


On 08.01.2020 19:07, Peter Zijlstra wrote:
> On Wed, Dec 18, 2019 at 12:25:35PM +0300, Alexey Budankov wrote:
>>
>> Open access to perf_events monitoring for CAP_SYS_PERFMON privileged
>> processes. For backward compatibility reasons access to perf_events
>> subsystem remains open for CAP_SYS_ADMIN privileged processes but
>> CAP_SYS_ADMIN usage for secure perf_events monitoring is discouraged
>> with respect to CAP_SYS_PERFMON capability.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  include/linux/perf_event.h | 6 +++---
>>  kernel/events/core.c       | 6 +++---
>>  2 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index 34c7c6910026..f46acd69425f 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -1285,7 +1285,7 @@ static inline int perf_is_paranoid(void)
>>  
>>  static inline int perf_allow_kernel(struct perf_event_attr *attr)
>>  {
>> -	if (sysctl_perf_event_paranoid > 1 && !capable(CAP_SYS_ADMIN))
>> +	if (sysctl_perf_event_paranoid > 1 && !perfmon_capable())
>>  		return -EACCES;
>>  
>>  	return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
>> @@ -1293,7 +1293,7 @@ static inline int perf_allow_kernel(struct perf_event_attr *attr)
>>  
>>  static inline int perf_allow_cpu(struct perf_event_attr *attr)
>>  {
>> -	if (sysctl_perf_event_paranoid > 0 && !capable(CAP_SYS_ADMIN))
>> +	if (sysctl_perf_event_paranoid > 0 && !perfmon_capable())
>>  		return -EACCES;
>>  
>>  	return security_perf_event_open(attr, PERF_SECURITY_CPU);
>> @@ -1301,7 +1301,7 @@ static inline int perf_allow_cpu(struct perf_event_attr *attr)
>>  
>>  static inline int perf_allow_tracepoint(struct perf_event_attr *attr)
>>  {
>> -	if (sysctl_perf_event_paranoid > -1 && !capable(CAP_SYS_ADMIN))
>> +	if (sysctl_perf_event_paranoid > -1 && !perfmon_capable())
>>  		return -EPERM;
>>  
>>  	return security_perf_event_open(attr, PERF_SECURITY_TRACEPOINT);
> 
> These are OK I suppose.
> 
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 059ee7116008..d9db414f2197 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -9056,7 +9056,7 @@ static int perf_kprobe_event_init(struct perf_event *event)
>>  	if (event->attr.type != perf_kprobe.type)
>>  		return -ENOENT;
>>  
>> -	if (!capable(CAP_SYS_ADMIN))
>> +	if (!perfmon_capable())
>>  		return -EACCES;
>>  
>>  	/*
> 
> This one only allows attaching to already extant kprobes, right? It does
> not allow creation of kprobes.

This unblocks creation of local trace kprobes and uprobes by CAP_SYS_PERFMON 
privileged process, exactly the same as for CAP_SYS_ADMIN privileged process.

> 
>> @@ -9116,7 +9116,7 @@ static int perf_uprobe_event_init(struct perf_event *event)
>>  	if (event->attr.type != perf_uprobe.type)
>>  		return -ENOENT;
>>  
>> -	if (!capable(CAP_SYS_ADMIN))
>> +	if (!perfmon_capable())
>>  		return -EACCES;
>>  
>>  	/*
> 
> Idem, I presume.
> 
>> @@ -11157,7 +11157,7 @@ SYSCALL_DEFINE5(perf_event_open,
>>  	}
>>  
>>  	if (attr.namespaces) {
>> -		if (!capable(CAP_SYS_ADMIN))
>> +		if (!perfmon_capable())
>>  			return -EACCES;
>>  	}
> 
> And given we basically make the entire kernel observable with this CAP,
> busting namespaces shoulnd't be a problem either.
> 
> So yeah, I suppose that works.
> 
