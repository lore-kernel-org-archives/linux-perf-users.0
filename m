From: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH v5 01/10] capabilities: introduce CAP_PERFMON to kernel
 and user space
Date: Wed, 22 Jan 2020 09:07:32 -0500
Message-ID: <d7213569-9578-7201-6106-f5ebc95bd6be@tycho.nsa.gov>
References: <0548c832-7f4b-dc4c-8883-3f2b6d351a08@linux.intel.com>
 <9b77124b-675d-5ac7-3741-edec575bd425@linux.intel.com>
 <64cab472-806e-38c4-fb26-0ffbee485367@tycho.nsa.gov>
 <05297eff-8e14-ccdf-55a4-870c64516de8@linux.intel.com>
 <CAADnVQK-JzK-GUk4KOozn4c1xr=7TiCpB9Fi0QDC9nE6iVn8iQ@mail.gmail.com>
 <537bdb28-c9e4-f44f-d665-25250065a6bb@linux.intel.com>
 <63d9700f-231d-7973-5307-3e56a48c54cb@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <63d9700f-231d-7973-5307-3e56a48c54cb@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Budankov <alexey.budankov@linux.intel.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>, "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "james.bottomley@hansenpartnership.com" <james.bottomley@hansenpartnership.com>, Serge Hallyn <serge@hallyn.com>, James Morris <jmorris@namei.org>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robert Richter <rric@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@redhat.com>Andi Kleen <a>
List-Id: linux-perf-users.vger.kernel.org

On 1/22/20 5:45 AM, Alexey Budankov wrote:
> 
> On 21.01.2020 21:27, Alexey Budankov wrote:
>>
>> On 21.01.2020 20:55, Alexei Starovoitov wrote:
>>> On Tue, Jan 21, 2020 at 9:31 AM Alexey Budankov
>>> <alexey.budankov@linux.intel.com> wrote:
>>>>
>>>>
>>>> On 21.01.2020 17:43, Stephen Smalley wrote:
>>>>> On 1/20/20 6:23 AM, Alexey Budankov wrote:
>>>>>>
>>>>>> Introduce CAP_PERFMON capability designed to secure system performance
>>>>>> monitoring and observability operations so that CAP_PERFMON would assist
>>>>>> CAP_SYS_ADMIN capability in its governing role for perf_events, i915_perf
>>>>>> and other performance monitoring and observability subsystems.
>>>>>>
>>>>>> CAP_PERFMON intends to harden system security and integrity during system
>>>>>> performance monitoring and observability operations by decreasing attack
>>>>>> surface that is available to a CAP_SYS_ADMIN privileged process [1].
>>>>>> Providing access to system performance monitoring and observability
>>>>>> operations under CAP_PERFMON capability singly, without the rest of
>>>>>> CAP_SYS_ADMIN credentials, excludes chances to misuse the credentials and
>>>>>> makes operation more secure.
>>>>>>
>>>>>> CAP_PERFMON intends to take over CAP_SYS_ADMIN credentials related to
>>>>>> system performance monitoring and observability operations and balance
>>>>>> amount of CAP_SYS_ADMIN credentials following the recommendations in the
>>>>>> capabilities man page [1] for CAP_SYS_ADMIN: "Note: this capability is
>>>>>> overloaded; see Notes to kernel developers, below."
>>>>>>
>>>>>> Although the software running under CAP_PERFMON can not ensure avoidance
>>>>>> of related hardware issues, the software can still mitigate these issues
>>>>>> following the official embargoed hardware issues mitigation procedure [2].
>>>>>> The bugs in the software itself could be fixed following the standard
>>>>>> kernel development process [3] to maintain and harden security of system
>>>>>> performance monitoring and observability operations.
>>>>>>
>>>>>> [1] http://man7.org/linux/man-pages/man7/capabilities.7.html
>>>>>> [2] https://www.kernel.org/doc/html/latest/process/embargoed-hardware-issues.html
>>>>>> [3] https://www.kernel.org/doc/html/latest/admin-guide/security-bugs.html
>>>>>>
>>>>>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>>>>>> ---
>>>>>>    include/linux/capability.h          | 12 ++++++++++++
>>>>>>    include/uapi/linux/capability.h     |  8 +++++++-
>>>>>>    security/selinux/include/classmap.h |  4 ++--
>>>>>>    3 files changed, 21 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/include/linux/capability.h b/include/linux/capability.h
>>>>>> index ecce0f43c73a..8784969d91e1 100644
>>>>>> --- a/include/linux/capability.h
>>>>>> +++ b/include/linux/capability.h
>>>>>> @@ -251,6 +251,18 @@ extern bool privileged_wrt_inode_uidgid(struct user_namespace *ns, const struct
>>>>>>    extern bool capable_wrt_inode_uidgid(const struct inode *inode, int cap);
>>>>>>    extern bool file_ns_capable(const struct file *file, struct user_namespace *ns, int cap);
>>>>>>    extern bool ptracer_capable(struct task_struct *tsk, struct user_namespace *ns);
>>>>>> +static inline bool perfmon_capable(void)
>>>>>> +{
>>>>>> +    struct user_namespace *ns = &init_user_ns;
>>>>>> +
>>>>>> +    if (ns_capable_noaudit(ns, CAP_PERFMON))
>>>>>> +        return ns_capable(ns, CAP_PERFMON);
>>>>>> +
>>>>>> +    if (ns_capable_noaudit(ns, CAP_SYS_ADMIN))
>>>>>> +        return ns_capable(ns, CAP_SYS_ADMIN);
>>>>>> +
>>>>>> +    return false;
>>>>>> +}
>>>>>
>>>>> Why _noaudit()?  Normally only used when a permission failure is non-fatal to the operation.  Otherwise, we want the audit message.
> 
> So far so good, I suggest using the simplest version for v6:
> 
> static inline bool perfmon_capable(void)
> {
> 	return capable(CAP_PERFMON) || capable(CAP_SYS_ADMIN);
> }
> 
> It keeps the implementation simple and readable. The implementation is more
> performant in the sense of calling the API - one capable() call for CAP_PERFMON
> privileged process.
> 
> Yes, it bloats audit log for CAP_SYS_ADMIN privileged and unprivileged processes,
> but this bloating also advertises and leverages using more secure CAP_PERFMON
> based approach to use perf_event_open system call.

I can live with that.  We just need to document that when you see both a 
CAP_PERFMON and a CAP_SYS_ADMIN audit message for a process, try only 
allowing CAP_PERFMON first and see if that resolves the issue.  We have 
a similar issue with CAP_DAC_READ_SEARCH versus CAP_DAC_OVERRIDE.
