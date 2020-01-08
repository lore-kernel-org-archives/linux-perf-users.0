From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 2/9] perf/core: open access for CAP_SYS_PERFMON
 privileged process
Date: Wed, 8 Jan 2020 17:07:13 +0100
Message-ID: <20200108160713.GI2844@hirez.programming.kicks-ass.net>
References: <c0460c78-b1a6-b5f7-7119-d97e5998f308@linux.intel.com>
 <c93309dc-b920-f5fa-f997-e8b2faf47b88@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <c93309dc-b920-f5fa-f997-e8b2faf47b88@linux.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Song Liu <songliubraving@fb.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, Alexei Starovoitov <ast@kernel.org>, Stephane Eranian <eranian@google.com>, "james.bottomley@hansenpartnership.com" <james.bottomley@hansenpartnership.com>, Paul Mackerras <paulus@samba.org>, Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Igor Lubashev <ilubashe@akamai.com>, James Morris <jmorris@namei.org>, Ingo Molnar <mingo@redhat.com>, oprofile-list@lists.sf.net, Serge Hallyn <serge@hallyn.com>, Robert Richter <rric@kernel.org>, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, "selinux@vger.kernel.org" <selinux@vger.ke>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Dec 18, 2019 at 12:25:35PM +0300, Alexey Budankov wrote:
> 
> Open access to perf_events monitoring for CAP_SYS_PERFMON privileged
> processes. For backward compatibility reasons access to perf_events
> subsystem remains open for CAP_SYS_ADMIN privileged processes but
> CAP_SYS_ADMIN usage for secure perf_events monitoring is discouraged
> with respect to CAP_SYS_PERFMON capability.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  include/linux/perf_event.h | 6 +++---
>  kernel/events/core.c       | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 34c7c6910026..f46acd69425f 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1285,7 +1285,7 @@ static inline int perf_is_paranoid(void)
>  
>  static inline int perf_allow_kernel(struct perf_event_attr *attr)
>  {
> -	if (sysctl_perf_event_paranoid > 1 && !capable(CAP_SYS_ADMIN))
> +	if (sysctl_perf_event_paranoid > 1 && !perfmon_capable())
>  		return -EACCES;
>  
>  	return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
> @@ -1293,7 +1293,7 @@ static inline int perf_allow_kernel(struct perf_event_attr *attr)
>  
>  static inline int perf_allow_cpu(struct perf_event_attr *attr)
>  {
> -	if (sysctl_perf_event_paranoid > 0 && !capable(CAP_SYS_ADMIN))
> +	if (sysctl_perf_event_paranoid > 0 && !perfmon_capable())
>  		return -EACCES;
>  
>  	return security_perf_event_open(attr, PERF_SECURITY_CPU);
> @@ -1301,7 +1301,7 @@ static inline int perf_allow_cpu(struct perf_event_attr *attr)
>  
>  static inline int perf_allow_tracepoint(struct perf_event_attr *attr)
>  {
> -	if (sysctl_perf_event_paranoid > -1 && !capable(CAP_SYS_ADMIN))
> +	if (sysctl_perf_event_paranoid > -1 && !perfmon_capable())
>  		return -EPERM;
>  
>  	return security_perf_event_open(attr, PERF_SECURITY_TRACEPOINT);

These are OK I suppose.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 059ee7116008..d9db414f2197 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9056,7 +9056,7 @@ static int perf_kprobe_event_init(struct perf_event *event)
>  	if (event->attr.type != perf_kprobe.type)
>  		return -ENOENT;
>  
> -	if (!capable(CAP_SYS_ADMIN))
> +	if (!perfmon_capable())
>  		return -EACCES;
>  
>  	/*

This one only allows attaching to already extant kprobes, right? It does
not allow creation of kprobes.

> @@ -9116,7 +9116,7 @@ static int perf_uprobe_event_init(struct perf_event *event)
>  	if (event->attr.type != perf_uprobe.type)
>  		return -ENOENT;
>  
> -	if (!capable(CAP_SYS_ADMIN))
> +	if (!perfmon_capable())
>  		return -EACCES;
>  
>  	/*

Idem, I presume.

> @@ -11157,7 +11157,7 @@ SYSCALL_DEFINE5(perf_event_open,
>  	}
>  
>  	if (attr.namespaces) {
> -		if (!capable(CAP_SYS_ADMIN))
> +		if (!perfmon_capable())
>  			return -EACCES;
>  	}

And given we basically make the entire kernel observable with this CAP,
busting namespaces shoulnd't be a problem either.

So yeah, I suppose that works.
