From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH v6 03/10] perf/core: open access to probes for CAP_PERFMON
 privileged process
Date: Wed, 29 Jan 2020 08:16:40 +1100 (AEDT)
Message-ID: <alpine.LRH.2.21.2001290816290.2204@namei.org>
References: <74d524ab-ac11-a7b8-1052-eba10f117e09@linux.intel.com>
 <6cdc10f2-31e5-6d71-7d71-c6b5250b74f1@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <6cdc10f2-31e5-6d71-7d71-c6b5250b74f1@linux.intel.com>
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
Cc: Song Liu <songliubraving@fb.com>, Peter Zijlstra <peterz@infradead.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, Alexei Starovoitov <ast@kernel.org>, Lionel Landwerlin <lionel.g.landwerlin@intel.com>, "james.bottomley@hansenpartnership.com" <james.bottomley@hansenpartnership.com>, Paul Mackerras <paulus@samba.org>, Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Igor Lubashev <ilubashe@akamai.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, oprofile-list@lists.sf.net, Serge Hallyn <serge@hallyn.com>, Robert Richter <rric@kernel.org>, Will Deacon <will@kernel.org>, "selinux@vger.kernel.org" <selinux@vger.kernel.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Stephane Eranian <eranian@goo>
List-Id: linux-perf-users.vger.kernel.org

On Tue, 28 Jan 2020, Alexey Budankov wrote:

> 
> Open access to monitoring via kprobes and uprobes and eBPF tracing for
> CAP_PERFMON privileged process. Providing the access under CAP_PERFMON
> capability singly, without the rest of CAP_SYS_ADMIN credentials, excludes
> chances to misuse the credentials and makes operation more secure.
> 
> perf kprobes and uprobes are used by ftrace and eBPF. perf probe uses
> ftrace to define new kprobe events, and those events are treated as
> tracepoint events. eBPF defines new probes via perf_event_open interface
> and then the probes are used in eBPF tracing.
> 
> CAP_PERFMON implements the principal of least privilege for performance
> monitoring and observability operations (POSIX IEEE 1003.1e 2.2.2.39 principle
> of least privilege: A security design principle that states that a process or
> program be granted only those privileges (e.g., capabilities) necessary to
> accomplish its legitimate function, and only for the time that such privileges
> are actually required)
> 
> For backward compatibility reasons access to perf_events subsystem remains
> open for CAP_SYS_ADMIN privileged processes but CAP_SYS_ADMIN usage for
> secure perf_events monitoring is discouraged with respect to CAP_PERFMON
> capability.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  kernel/events/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)


Acked-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>
