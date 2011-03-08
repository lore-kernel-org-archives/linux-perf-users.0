From: Sam Liao <phyomh@gmail.com>
Subject: Re: [PATCH] Add inverted call graph report support to perf tool
Date: Tue, 8 Mar 2011 16:59:30 +0800
Message-ID: <AANLkTi=rabeXE6m0wRo029jgqHLBaUGQcXYJriLewZeJ@mail.gmail.com>
References: <AANLkTi=vxgHe=dqz+xEPcZ9oBexM1jBxFz3sXA2DJEZA@mail.gmail.com>
	<20110307180619.GG1873@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36487 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab1CHI7c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 8 Mar 2011 03:59:32 -0500
In-Reply-To: <20110307180619.GG1873@nowhere>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>

On Tue, Mar 8, 2011 at 2:06 AM, Frederic Weisbecker <fweisbec@gmail.com=
> wrote:
> On Mon, Mar 07, 2011 at 09:43:27PM +0800, Sam Liao wrote:
>> Add "-r" option to support inverted butterfly report, in the
>> inverted report, the call graph start from the callee's ancestor,
>> like main->func1->func2 style. users can use such view to catch
>> system's performance bottleneck, find the software's design
>> problem not just some function's poor performance.
>
> Yeah, that can be interesting.
>
>>
>> Current pref implementation is not easy to add such inversion, so th=
is
>> fix just invert the ip and callchain in an ugly style. But I do thin=
k
>> this invert
>> view help developer to find performance root cause for complex
>> software.
>> ---
>> =A0tools/perf/builtin-report.c | =A0 43 ++++++++++++++++++++++++++++=
+++++++++++++++
>> =A01 files changed, 43 insertions(+), 0 deletions(-)
>>
>> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report=
=2Ec
>> index c27e31f..ac2ec0e 100644
>> --- a/tools/perf/builtin-report.c
>> +++ b/tools/perf/builtin-report.c
>> @@ -33,6 +33,7 @@
>> =A0static char =A0 =A0 =A0 =A0 =A0const *input_name =3D "perf.data";
>>
>> =A0static bool =A0 =A0 =A0 =A0 =A0force, use_tui, use_stdio;
>> +static bool =A0 =A0 =A0 =A0 =A0reverse_call;
>> =A0static bool =A0 =A0 =A0 =A0 =A0hide_unresolved;
>> =A0static bool =A0 =A0 =A0 =A0 =A0dont_use_callchains;
>>
>> @@ -155,6 +156,41 @@ static int process_sample_event(event_t *event,
>> struct sample_data *sample,
>> =A0{
>> =A0 =A0 =A0 struct addr_location al;
>> =A0 =A0 =A0 struct perf_event_attr *attr;
>> +
>> + =A0 =A0 /* reverse call chain data */
>> + =A0 =A0 if (reverse_call && symbol_conf.use_callchain && sample->c=
allchain) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct ip_callchain *chain;
>> + =A0 =A0 =A0 =A0 =A0 =A0 int i, j;
>> + =A0 =A0 =A0 =A0 =A0 =A0 u64 tmp_ip;
>> + =A0 =A0 =A0 =A0 =A0 =A0 event_t *reverse_event;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 chain =3D malloc(sizeof(u64) * (sample->ca=
llchain->nr + 1));
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!chain) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("malloc failed\n"=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 reverse_event =3D malloc(sizeof(event_t));
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!reverse_event) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("malloc failed\n"=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 memcpy(reverse_event, event, sizeof(event_=
t));
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 chain->nr =3D sample->callchain->nr;
>> + =A0 =A0 =A0 =A0 =A0 =A0 j =3D sample->callchain->nr;
>> + =A0 =A0 =A0 =A0 =A0 =A0 tmp_ip =3D event->ip.ip;
>> + =A0 =A0 =A0 =A0 =A0 =A0 reverse_event->ip.ip =3D sample->callchain=
->ips[j-1];
>> + =A0 =A0 =A0 =A0 =A0 =A0 chain->ips[j-1] =3D tmp_ip;
>> + =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0, j =3D sample->callchain->nr =
- 2; i < j; i++, j--) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chain->ips[i] =3D sample->=
callchain->ips[j];
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chain->ips[j] =3D sample->=
callchain->ips[i];
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 sample->callchain =3D chain;
>> + =A0 =A0 =A0 =A0 =A0 =A0 call_chain_reversed =3D true;
>> + =A0 =A0 =A0 =A0 =A0 =A0 event =3D reverse_event;
>> + =A0 =A0 }
>
> So, instead of having such temporary copy, could you rather feed the =
callchain
> into the cursor in reverse from perf_session__resolve_callchain() ?
>
> You can keep the common part inside the loop into a seperate helper
> but have two different kinds of loops.

In perf_session__resolve_callchain, only the callchain itself can be re=
versed,
which means the root of report will still be the ip of the event with a=
 reversed
call chain sub tree. But what is more impressive to user is to make "ma=
in" like
function to be the root of the report, and this means that both the ip
and call chain is
involved to the reversion process.

Since the ip of event is resolved in event__preprocess_sample, so it is=
 kind
hard to do such reversion in a better way.

>
>>
>> =A0 =A0 =A0 if (event__preprocess_sample(event, session, &al, sample=
, NULL) < 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf(stderr, "problem processing %d e=
vent, skipping it.\n",
>> @@ -177,6 +213,11 @@ static int process_sample_event(event_t *event,
>> struct sample_data *sample,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 if (reverse_call && call_chain_reversed) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 free(sample->callchain);
>> + =A0 =A0 =A0 =A0 =A0 =A0 free(event);
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> @@ -469,6 +510,8 @@ static const struct option options[] =3D {
>> =A0 =A0 =A0 OPT_CALLBACK_DEFAULT('g', "call-graph", NULL, "output_ty=
pe,min_percent",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Display callchains using out=
put_type (graph, flat, fractal,
>> or none) and min percent threshold. "
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Default: fractal,0.5", &pars=
e_callchain_opt, callchain_default_opt),
>> + =A0 =A0 OPT_BOOLEAN('r', "reverse-call", &reverse_call,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "reverse call chain report=
 (butterfly view)"),
>
> What about making it an argument to the exisiting -g option, somethin=
g
> that defines the base of the callchain like "caller" and "callee"
>
> Like "-g graph,0.5,caller".
>
> caller would be what we call here reverse and callee the current and =
future default.
>
> Does that look sensible?
>
This option looks better.

Thanks,
-Sam
