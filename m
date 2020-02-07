From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v5 01/10] capabilities: introduce CAP_PERFMON to kernel
 and user space
Date: Fri, 7 Feb 2020 16:39:12 +0300
Message-ID: <7d6f4210-423f-e454-3910-9f8e17dff1aa@linux.intel.com>
References: <875zgizkyk.fsf@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <875zgizkyk.fsf@nanos.tec.linutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Stephen Smalley <sds@tycho.nsa.gov>, Serge Hallyn <serge@hallyn.com>, James Morris <jmorris@namei.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>, "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robert Richter <rric@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>, Igor Lubashev <ilubashe@akamai.com>Al
List-Id: linux-perf-users.vger.kernel.org


On 07.02.2020 14:38, Thomas Gleixner wrote:
> Alexey Budankov <alexey.budankov@linux.intel.com> writes:
>> On 22.01.2020 17:25, Alexey Budankov wrote:
>>> On 22.01.2020 17:07, Stephen Smalley wrote:
>>>>> It keeps the implementation simple and readable. The implementation is more
>>>>> performant in the sense of calling the API - one capable() call for CAP_PERFMON
>>>>> privileged process.
>>>>>
>>>>> Yes, it bloats audit log for CAP_SYS_ADMIN privileged and unprivileged processes,
>>>>> but this bloating also advertises and leverages using more secure CAP_PERFMON
>>>>> based approach to use perf_event_open system call.
>>>>
>>>> I can live with that.  We just need to document that when you see
>>>> both a CAP_PERFMON and a CAP_SYS_ADMIN audit message for a process,
>>>> try only allowing CAP_PERFMON first and see if that resolves the
>>>> issue.  We have a similar issue with CAP_DAC_READ_SEARCH versus
>>>> CAP_DAC_OVERRIDE.
>>>
>>> perf security [1] document can be updated, at least, to align and document 
>>> this audit logging specifics.
>>
>> And I plan to update the document right after this patch set is accepted.
>> Feel free to let me know of the places in the kernel docs that also
>> require update w.r.t CAP_PERFMON extension.
> 
> The documentation update wants be part of the patch set and not planned
> to be done _after_ the patch set is merged.

Well, accepted. It is going to make patches #11 and beyond.

Thanks,
Alexey

> 
> Thanks,
> 
>         tglx
> 
