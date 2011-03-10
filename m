From: Sam Liao <phyomh@gmail.com>
Subject: Re: [PATCH] Add inverted call graph report support to perf tool
Date: Thu, 10 Mar 2011 22:32:43 +0800
Message-ID: <AANLkTikZxDyL-SW7FFbEd4skMNTVWeh7mGDTXfWkvEMR@mail.gmail.com>
References: <AANLkTi=vxgHe=dqz+xEPcZ9oBexM1jBxFz3sXA2DJEZA@mail.gmail.com>
	<20110307180619.GG1873@nowhere>
	<AANLkTi=rabeXE6m0wRo029jgqHLBaUGQcXYJriLewZeJ@mail.gmail.com>
	<20110310024355.GG2533@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43273 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435Ab1CJOcp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 10 Mar 2011 09:32:45 -0500
In-Reply-To: <20110310024355.GG2533@nowhere>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>

On Thu, Mar 10, 2011 at 10:43 AM, Frederic Weisbecker
<fweisbec@gmail.com> wrote:
> On Tue, Mar 08, 2011 at 04:59:30PM +0800, Sam Liao wrote:
>> On Tue, Mar 8, 2011 at 2:06 AM, Frederic Weisbecker <fweisbec@gmail.=
com> wrote:
>> > So, instead of having such temporary copy, could you rather feed t=
he callchain
>> > into the cursor in reverse from perf_session__resolve_callchain() =
?
>> >
>> > You can keep the common part inside the loop into a seperate helpe=
r
>> > but have two different kinds of loops.
>>
>> In perf_session__resolve_callchain, only the callchain itself can be=
 reversed,
>> which means the root of report will still be the ip of the event wit=
h a reversed
>> call chain sub tree. But what is more impressive to user is to make =
"main" like
>> function to be the root of the report, and this means that both the =
ip
>> and call chain is
>> involved to the reversion process.
>>
>> Since the ip of event is resolved in event__preprocess_sample, so it=
 is kind
>> hard to do such reversion in a better way.
>
> You are making an interesting point.
>
> My view of this feature was limited to the current per hist area: hav=
ing
> the callchains on top of hists that can be sorted per ip, dso, pid, e=
tc...
> like we have today basically. So my view was for this reverse callcha=
in
> to show us one callers profiling for each hist entry.
>
> But your idea of turning the callee into the caller would show us a v=
ery global
> profiling. With reverse callchains it can be a very nice overview of =
the big picture.
>
> IMO both workflow can be interesting:
>
> 1) Have a big reversed callchain overview, with one root per entrypoi=
nt. This
> what you wanted.
> 2) Have a per hist 1) =A0which means a per hist per entrypoint callch=
ain
>
> 1) involves reverting both callchains and ip <->caller whereas 2) onl=
y involves
> reverting the callchain.

Having both workflow included would be more helpful.
>
> In order to get both features with a maximum flexibility and keep tha=
t extendable, I
> would suggest to decouple that in two independant parts:
>
> =A0 =A0 =A0 =A0- an option to get reversed callchains. Using the -g o=
ption and caller/callee
> =A0 =A0 =A0 =A0as a third argument.
>

This could be easily extended by reversing the callchain symbols as
you mentioned.

> =A0 =A0 =A0 =A0- a new "caller" sort entry. What defines a hist entry=
 is a set of sort
> =A0 =A0 =A0 =A0entries: dso, symbol, pid, comm, ... That we use with =
the -s option in perf report.
> =A0 =A0 =A0 =A0If you want one hist per entrypoint, we could add a ne=
w "caller" sort entry.
> =A0 =A0 =A0 =A0Then perf report -s caller will (roughly) produce one =
hist for main(), one hist
> =A0 =A0 =A0 =A0for kernel_thread(), etc...
>

I'm not sure adding a "caller" sort entry can get things done. As for
my limited understanding,
"sort" is kind way to group events, after we group all the events
under "main" or "kernel_thread",
the sub-trees will still rooted as ip entry points with a reversed
call-chain sub-trees which seems
just the same as the previous workflow. Am I right? If so, here we
still have to revert the ip and
callchain.

> Hence, someone running "perf report -g fractal,0.5,reversed -s dso" i=
s going to have a
> per dso caller-callchain profiling.
>
> Someone running "perf report -g fractal,0.5,reversed -s caller" is go=
ing to have that
> global caller profiling you wanted. You'll have one hist per entrypoi=
nt.
>
> The caller sorting mode may sound a bit limited currently, but think =
about what happens
> when you push forward the entrypoint, if one day we bring a feature t=
o filter the callchains
> on some dso address space , we could do a caller callchain profile st=
arting on a shared library
> and pinpoint which functions are mostly called on it, so that can be =
coupled with dso sorting mode,
> etc... So that looks like a right way to go.

This is interesting, we might choose different caller based on dso
instead of the process/thread entry
point. This also remind me one thing, at present, though with
different sort orders, the event trees still
root in the ip of the event. For an event with call chain like:
main->func1->func2->lib_func3->ip, what
about we expand this event to following events:

- a direct event with ip called, with full call chain.
- a indirect event with libfunc3 called, with lib_func3->ip call chain
- a indirect event with func2 called ...
- a indirect event with main called,

With these indirect event added(we may also need to add direct count
and indirect count), we are
able to check any routine in any dso which functions are mostly
called. Actually, it much seems like
 the sysprof that Ingo mentioned.

>
> Ah and that shouldn't require to overwrite the real ip of an event wi=
th the caller.
> Better create a new "caller" field on struct hist_entry for that.
>
> Hm?
>

Thanks,
-Sam
