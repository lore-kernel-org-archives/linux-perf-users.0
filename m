From: Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH v4 2/9] perf/core: open access for CAP_SYS_PERFMON
 privileged process
Date: Sat, 11 Jan 2020 00:23:27 +0000
Message-ID: <2B79131A-3F76-47F5-AAB4-08BCA820473F@fb.com>
References: <c0460c78-b1a6-b5f7-7119-d97e5998f308@linux.intel.com>
 <c93309dc-b920-f5fa-f997-e8b2faf47b88@linux.intel.com>
 <20200108160713.GI2844@hirez.programming.kicks-ass.net>
 <cc239899-5c52-2fd0-286d-4bff18877937@linux.intel.com>
 <20200110140234.GO2844@hirez.programming.kicks-ass.net>
 <20200111005213.6dfd98fb36ace098004bde0e@kernel.org>
 <20200110164531.GA2598@kernel.org>
 <20200111084735.0ff01c758bfbfd0ae2e1f24e@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200111084735.0ff01c758bfbfd0ae2e1f24e@kernel.org>
Content-Language: en-US
Content-ID: <6D7DCD8DAB103C4E8BCB814507E2858A@namprd15.prod.outlook.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, Alexei Starovoitov <ast@kernel.org>, Stephane Eranian <eranian@google.com>, "james.bottomley@hansenpartnership.com" <james.bottomley@hansenpartnership.com>, Paul Mackerras <paulus@samba.org>, Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Alexey Budankov <alexey.budankov@linux.intel.com>, Igor Lubashev <ilubashe@akamai.com>, James Morris <jmorris@namei.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, "oprofile-list@lists.sf.net" <oprofile-list@lists.sf.net>, Serge Hallyn <serge@hallyn.com>, Robert Richter <rric@kernel.org>, Kees Cook <keescoo>
List-Id: linux-perf-users.vger.kernel.org



> On Jan 10, 2020, at 3:47 PM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> On Fri, 10 Jan 2020 13:45:31 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
>> Em Sat, Jan 11, 2020 at 12:52:13AM +0900, Masami Hiramatsu escreveu:
>>> On Fri, 10 Jan 2020 15:02:34 +0100 Peter Zijlstra <peterz@infradead.org> wrote:
>>>> Again, this only allows attaching to previously created kprobes, it does
>>>> not allow creating kprobes, right?
>> 
>>>> That is; I don't think CAP_SYS_PERFMON should be allowed to create
>>>> kprobes.
>> 
>>>> As might be clear; I don't actually know what the user-ABI is for
>>>> creating kprobes.
>> 
>>> There are 2 ABIs nowadays, ftrace and ebpf. perf-probe uses ftrace interface to
>>> define new kprobe events, and those events are treated as completely same as
>>> tracepoint events. On the other hand, ebpf tries to define new probe event
>>> via perf_event interface. Above one is that interface. IOW, it creates new kprobe.
>> 
>> Masami, any plans to make 'perf probe' use the perf_event_open()
>> interface for creating kprobes/uprobes?
> 
> Would you mean perf probe to switch to perf_event_open()?
> No, perf probe is for setting up the ftrace probe events. I think we can add an
> option to use perf_event_open(). But current kprobe creation from perf_event_open()
> is separated from ftrace by design.

I guess we can extend event parser to understand kprobe directly. Instead of

	perf probe kernel_func
	perf stat/record -e probe:kernel_func ...

We can just do 

	perf stat/record -e kprobe:kernel_func ...

Thanks,
Song
