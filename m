From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH V6 0/2] tracing, perf: cpu hotplug trace events
Date: Wed, 2 Mar 2011 20:02:00 +0100
Message-ID: <AANLkTi=dht7+bPrBqmt6shHefBxSB3yOUu4OcSvcd0am@mail.gmail.com>
References: <AANLkTinbYWQxde2jTcAtyYQGvGgt2Lmtnph=voj=haXF@mail.gmail.com>
	<20110302075625.GC15665@elte.hu>
	<201103021157.08260.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201103021157.08260.trenn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-hotplug@vger.kernel.org, fweisbec@gmail.com, rostedt@goodmis.org, amit.kucheria@linaro.org, rusty@rustcorp.com.au, tglx@linutronix.de, Arjan van de Ven <arjan@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Peter Zijlstra <a.p.zijlstra@chello.nl>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On 2 March 2011 11:57, Thomas Renninger <trenn@suse.de> wrote:
> On Wednesday, March 02, 2011 08:56:25 AM Ingo Molnar wrote:
>>
>> * Vincent Guittot <vincent.guittot@linaro.org> wrote:
>>
>> > This patchset adds some tracepoints for tracing cpu state and for
>> > profiling the plug and unplug sequence.
>> >
>> > Some SMP arm platform uses cpu hotplug feature for improving their
>> > power saving because they can go into their deepest idle state onl=
y in
>> > mono core mode. In addition, running into mono core mode makes the
>> > cpuidle job easier and more efficient which also results in the
>> > improvement of power saving of some use cases. As the plug state o=
f a
>> > cpu can impact the cpuidle behavior, it's interesting to trace thi=
s
>> > state and to correlate it with cpuidle traces.
>> > Then, cpu hotplug is known to be an expensive operation which also
>> > takes a variable time depending of other processes' activity (from
>> > hundreds ms up to few seconds). These traces have shown that the a=
rch
>> > part stays almost constant on arm platform whatever the cpu load i=
s,
>> > whereas the plug duration increases.
>> >
>> > ---
>> > =A0include/trace/events/cpu_hotplug.h | =A0103
>> > =A0++++++++++++++++++++++++++++++++++++
>> > =A0kernel/cpu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
18 ++++++
>> > =A02 files changed, 121 insertions(+), 0 deletions(-)
>> > =A0create mode 100644 include/trace/events/cpu_hotplug.h
>>
>> Why not do something much simpler and fit these into the existing
>> power:* events:
>>
>> =A0 =A0 =A0power:cpu_idle
>> =A0 =A0 =A0power:cpu_frequency
>> =A0 =A0 =A0power:machine_suspend
>> =A0 =A0 =A0power:cpu_idle
>> =A0 =A0 =A0power:cpu_frequency
>> =A0 =A0 =A0power:machine_suspend
>>
>> in an intelligent way?
>>
>> CPU hotplug is really a 'soft' form of suspend and tools using power
>> events could
>> thus immediately use CPU hotplug events as well.
>>
>> A suitable new 'state' value could be used to signal CPU hotplug eve=
nts:
>>
>> =A0enum {
>> =A0 =A0 =A0 =A0 POWER_NONE =3D 0,
>> =A0 =A0 =A0 =A0 POWER_CSTATE =3D 1,
>> =A0 =A0 =A0 =A0 POWER_PSTATE =3D 2,
>> =A0};
>>
>> POWER_HSTATE for hotplug-state, or so.
> Be careful, these are obsolete!
> This information is in the name of the event itself:
> PSTATE -> CPU frequency =A0 =A0 -> power:cpu_frequency
> CSTATE -> sleep/idle states -> power:cpu_idle
>
>> This would also express the design arguments that others have pointe=
d
>> out in the prior discussion: that CPU hotplug is really a power
>> management variant, and that in the long run it could be done via
>> regular idle as well. When that happens, the above unified event
>> structure makes it all even simpler - analysis tools will just
>> continue to work fine.
>
> About the patch:
> You create:
> cpu_hotplug:cpu_hotplug_down_start
> cpu_hotplug:cpu_hotplug_down_end
> cpu_hotplug:cpu_hotplug_up_start
> cpu_hotplug:cpu_hotplug_up_end
> cpu_hotplug:cpu_hotplug_disable_start
> cpu_hotplug:cpu_hotplug_disable_end
> cpu_hotplug:cpu_hotplug_die_start
> cpu_hotplug:cpu_hotplug_die_end
> cpu_hotplug:cpu_hotplug_arch_up_start
> cpu_hotplug:cpu_hotplug_arch_up_end
>
> quite some events for cpu hotplugging...
> You mix up two things you want to trace:
> =A01) The cpu hotplugging itself which you might want to compare
> =A0 =A0 with system activity, other idle states, etc. and check wheth=
er
> =A0 =A0 removing/adding CPUs works in respect of your power saving
> =A0 =A0 algorithms
> =A02) You want to trace the time __cpu_down and friends take to
> =A0 =A0 optimize them
>
> For 1. I agree that it would be worth (mostly for arm now as long as
> it's the only arch using this as a power saving feature, but it may s=
how
> up on other archs as well) to create an event which looks like:
>
> power:cpu_hotplug(unsigned int state, unsigned int cpu_id)
>

If it's possible to add such cpu_hotplug event in the power event
class, that's should be fine for me.

> Define a state:
> CPU_HOT_PLUG 1
> CPU_HOT_UNPLUG 2
> This would be consistent with other power:* events. One idea of havin=
g
> one event passing the state is, that it does not make sense to track =
an:
> power:cpu_hotunplug or power:cpu_hotplug
> standalone.
>
> Theoretically this could get enhanced with further states:
> CPU_HOT_PLUG_DISABLE_IRQS 3
> CPU_HOT_PLUG_ENABLE_IRQS =A04
> CPU_HOT_PLUG_ACTIVATE =A0 =A0 5
> CPU_HOT_PLUG_DISABLE =A0 =A0 =A06
> ...
> if it should be possible at some point to only disable IRQs or to
> only disable code processing or to only disable whatever to achieve
> better power savings.
> But as long as there only is the general cpu_hotplug interface
> bringing the cpu totally up or down, above should be enough in
> respect of power saving tracings.
>
>
> For 2. you should use more appropriate tools to optimize the code
> processed in __cpu_{,up,down,enable,disable,die} functions and friend=
s.
> If you simply need the time, system tab or kprobes might work out for=
 you.
> There is preloadtrace.ko based on a system tab script which instrumen=
ts
> functions called at boot up and measures their time.
>
> Or probably better are perf profiling facilities. It should be possib=
le
> to profile __cpu_down and subsequent calls in detail. Like that you
> should get a good picture which functions you have to look at and
> optimize. People in CC should better be able to tell you the exact pe=
rf
> commands and parameters you are looking for.
>

I had tried to get such kind of information with function or
function_graph tracer but some functions like _cpu_down, are not
available in "available_filter_functions". Then, we don't have the
cpuid information with function trace what is not so bad on a dual
core but becomes more important on a quad cores. That's why I have
added some cpu_hotplug traces but I'm not a trace expert and I could
have missed the solution.

>
> Hm, have you tried/thought about registering an extra cpuidle state w=
ith
> long latency doing the cpu_down? For CPU 0 it could call the deepest
> "normal" sleep state, but could decide to shut other cpus down. Like =
that
> you might be able to get rid of some extra code (interfering with cpu=
idle
> driver?) and you get all the statistics, etc. for free.
>

No I haven't  tried such mechanism but are you sure that we could call
cpu_down in cpuidle function ?
I'm still looking for relevant triggers for pluging/unpluging the cpu
: current cpu load and loadavg are some interesting ones.

Thanks

Vincent
>
> =A0 Thomas
>
