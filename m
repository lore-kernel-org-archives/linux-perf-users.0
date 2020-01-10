From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v4 2/9] perf/core: open access for CAP_SYS_PERFMON
 privileged process
Date: Fri, 10 Jan 2020 13:45:31 -0300
Message-ID: <20200110164531.GA2598@kernel.org>
References: <c0460c78-b1a6-b5f7-7119-d97e5998f308@linux.intel.com>
 <c93309dc-b920-f5fa-f997-e8b2faf47b88@linux.intel.com>
 <20200108160713.GI2844@hirez.programming.kicks-ass.net>
 <cc239899-5c52-2fd0-286d-4bff18877937@linux.intel.com>
 <20200110140234.GO2844@hirez.programming.kicks-ass.net>
 <20200111005213.6dfd98fb36ace098004bde0e@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200111005213.6dfd98fb36ace098004bde0e@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Song Liu <songliubraving@fb.com>, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, Alexei Starovoitov <ast@kernel.org>, Stephane Eranian <eranian@google.com>, "james.bottomley@hansenpartnership.com" <james.bottomley@hansenpartnership.com>, Paul Mackerras <paulus@samba.org>, Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Alexey Budankov <alexey.budankov@linux.intel.com>, Igor Lubashev <ilubashe@akamai.com>, James Morris <jmorris@namei.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, oprofile-list@lists.sf.net, Serge Hallyn <serge@hallyn.com>, Robert Richter <rric@kernel.org>, Kees Cook <keesc>
List-Id: linux-perf-users.vger.kernel.org

Em Sat, Jan 11, 2020 at 12:52:13AM +0900, Masami Hiramatsu escreveu:
> On Fri, 10 Jan 2020 15:02:34 +0100 Peter Zijlstra <peterz@infradead.org> wrote:
> > Again, this only allows attaching to previously created kprobes, it does
> > not allow creating kprobes, right?

> > That is; I don't think CAP_SYS_PERFMON should be allowed to create
> > kprobes.

> > As might be clear; I don't actually know what the user-ABI is for
> > creating kprobes.

> There are 2 ABIs nowadays, ftrace and ebpf. perf-probe uses ftrace interface to
> define new kprobe events, and those events are treated as completely same as
> tracepoint events. On the other hand, ebpf tries to define new probe event
> via perf_event interface. Above one is that interface. IOW, it creates new kprobe.

Masami, any plans to make 'perf probe' use the perf_event_open()
interface for creating kprobes/uprobes?

- Arnaldo
