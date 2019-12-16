From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v2 2/7] perf/core: open access for
 CAP_SYS_PERFMON privileged process
Date: Mon, 16 Dec 2019 19:33:48 +0300
Message-ID: <3f2ac76c-6108-7769-4b99-a7a2da31af3d@linux.intel.com>
References: <26101427-c0a3-db9f-39e9-9e5f4ddd009c@linux.intel.com>
 <fd6ffb43-ed43-14cd-b286-6ab4b199155b@linux.intel.com>
 <9316a1ab21f6441eb2b421acb818a2a1@ustx2ex-dag1mb6.msg.corp.akamai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <9316a1ab21f6441eb2b421acb818a2a1@ustx2ex-dag1mb6.msg.corp.akamai.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: "Lubashev, Igor" <ilubashe@akamai.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>, "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>, Alexei Starovoitov <ast@kernel.org>, "james.bottomley@hansenpartnership.com" <james.bottomley@hansenpartnership.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, Casey Schaufler <casey@schaufler-ca.com>, "serge@hallyn.com" <serge@hallyn.com>, James Morris <jmorris@namei.org>
Cc: Song Liu <songliubraving@fb.com>, Andi Kleen <ak@linux.intel.com>, Kees Cook <keescook@chromium.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, Jann Horn <jannh@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, Stephane Eranian <eranian@google.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "selinux@vger.kernel.org" <selinux@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "bgregg@netflix.com" <bgregg@netflix.com>, Jiri Olsa <jolsa@redhat.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On 16.12.2019 19:12, Lubashev, Igor wrote:
> On Mon, Dec 16, 2019 at 2:15 AM, Alexey Budankov <alexey.budankov@linux.intel.com> wrote:
>>
>> Open access to perf_events monitoring for CAP_SYS_PERFMON privileged
>> processes.
>> For backward compatibility reasons access to perf_events subsystem remains
>> open for CAP_SYS_ADMIN privileged processes but CAP_SYS_ADMIN usage
>> for secure perf_events monitoring is discouraged with respect to
>> CAP_SYS_PERFMON capability.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  include/linux/perf_event.h | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h index
>> 34c7c6910026..52313d2cc343 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -1285,7 +1285,8 @@ static inline int perf_is_paranoid(void)
>>
>>  static inline int perf_allow_kernel(struct perf_event_attr *attr)  {
>> -	if (sysctl_perf_event_paranoid > 1 && !capable(CAP_SYS_ADMIN))
>> +	if (sysctl_perf_event_paranoid > 1 &&
>> +	   !(capable(CAP_SYS_PERFMON) || capable(CAP_SYS_ADMIN)))
>>  		return -EACCES;
>>
>>  	return security_perf_event_open(attr, PERF_SECURITY_KERNEL); @@
>> -1293,7 +1294,8 @@ static inline int perf_allow_kernel(struct
>> perf_event_attr *attr)
>>
>>  static inline int perf_allow_cpu(struct perf_event_attr *attr)  {
>> -	if (sysctl_perf_event_paranoid > 0 && !capable(CAP_SYS_ADMIN))
>> +	if (sysctl_perf_event_paranoid > 0 &&
>> +	    !(capable(CAP_SYS_PERFMON) || capable(CAP_SYS_ADMIN)))
>>  		return -EACCES;
>>
>>  	return security_perf_event_open(attr, PERF_SECURITY_CPU); @@ -
>> 1301,7 +1303,8 @@ static inline int perf_allow_cpu(struct perf_event_attr
>> *attr)
>>
>>  static inline int perf_allow_tracepoint(struct perf_event_attr *attr)  {
>> -	if (sysctl_perf_event_paranoid > -1 && !capable(CAP_SYS_ADMIN))
>> +	if (sysctl_perf_event_paranoid > -1 &&
>> +	    !(capable(CAP_SYS_PERFMON) || capable(CAP_SYS_ADMIN)))
>>  		return -EPERM;
>>
>>  	return security_perf_event_open(attr, PERF_SECURITY_TRACEPOINT);
>> --
>> 2.20.1
> 
> Thanks.  I like the idea of CAP_SYS_PERFMON that does not require CAP_SYS_ADMIN.  It makes granting users ability to run perf a bit safer.
> 
> I see a lot of "(capable(CAP_SYS_PERFMON) || capable(CAP_SYS_ADMIN)" constructs now.  Maybe wrapping it in an " inline bool perfmon_capable()" defined somewhere (like in /include/linux/capability.h)?

Yes, it makes sense.

Thanks,
Alexey

> 
> - Igor
> 
