From: Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH v4 5/9] trace/bpf_trace: open access for CAP_SYS_PERFMON
 privileged process
Date: Mon, 13 Jan 2020 20:47:04 +0000
Message-ID: <D11073C5-BF5D-4FAB-AC38-D640152DA0A4@fb.com>
References: <c0460c78-b1a6-b5f7-7119-d97e5998f308@linux.intel.com>
 <1d46cc07-ced7-9a29-a9a3-3cba6ef2df21@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <1d46cc07-ced7-9a29-a9a3-3cba6ef2df21@linux.intel.com>
Content-Language: en-US
Content-ID: <FBC847D4989C734FB55244B44843C7AE@namprd15.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, Alexei Starovoitov <ast@kernel.org>, Stephane Eranian <eranian@google.com>, "james.bottomley@hansenpartnership.com" <james.bottomley@hansenpartnership.com>, Paul Mackerras <paulus@samba.org>, Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Igor Lubashev <ilubashe@akamai.com>, James Morris <jmorris@namei.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, "oprofile-list@lists.sf.net" <oprofile-list@lists.sf.net>, Serge Hallyn <serge@hallyn.com>, Robert Richter <rric@kernel.org>, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, seli
List-Id: linux-perf-users.vger.kernel.org



> On Dec 18, 2019, at 1:28 AM, Alexey Budankov <alexey.budankov@linux.intel.com> wrote:
> 
> 
> Open access to bpf_trace monitoring for CAP_SYS_PERFMON privileged
> processes. For backward compatibility reasons access to bpf_trace
> monitoring remains open for CAP_SYS_ADMIN privileged processes but
> CAP_SYS_ADMIN usage for secure bpf_trace monitoring is discouraged
> with respect to CAP_SYS_PERFMON capability.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
> kernel/trace/bpf_trace.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 44bd08f2443b..bafe21ac6d92 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1272,7 +1272,7 @@ int perf_event_query_prog_array(struct perf_event *event, void __user *info)
> 	u32 *ids, prog_cnt, ids_len;
> 	int ret;
> 
> -	if (!capable(CAP_SYS_ADMIN))
> +	if (!perfmon_capable())
> 		return -EPERM;
> 	if (event->attr.type != PERF_TYPE_TRACEPOINT)
> 		return -EINVAL;

I guess we need to fix this check for kprobe/uprobe created with 
perf_event_open()...

Thanks,
Song
