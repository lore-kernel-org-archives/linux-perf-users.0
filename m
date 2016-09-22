From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: perf event grouping for dummies (was Re: [PATCH] arc: perf:
 Enable generic "cache-references" and "cache-misses" events)
Date: Thu, 22 Sep 2016 10:50:21 -0700
Message-ID: <b15fc87b-c846-fdb5-ef6a-48fc2d797917@synopsys.com>
References: <1472125647-518-1-git-send-email-abrodkin@synopsys.com>
 <6074e252-6e18-bb01-4de1-023bd7e82f03@synopsys.com>
 <5f65fa04-8d33-e525-115d-4e6991a7668e@synopsys.com>
 <20160901083324.GM10153@twins.programming.kicks-ass.net>
 <2a18ae06-3abd-c3a1-e980-f04c511b08e5@synopsys.com>
 <04f6dcd2-35c6-6e28-2dcf-bc5f0bb446dc@us.ibm.com>
 <20160922075603.GW5008@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160922075603.GW5008@twins.programming.kicks-ass.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Peter Zijlstra <peterz@infradead.org>, Paul Clarke <pc@us.ibm.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

On 09/22/2016 12:56 AM, Peter Zijlstra wrote:
> On Wed, Sep 21, 2016 at 07:43:28PM -0500, Paul Clarke wrote:
>> On 09/20/2016 03:56 PM, Vineet Gupta wrote:
>>> On 09/01/2016 01:33 AM, Peter Zijlstra wrote:
>>>>> - is that what perf event grouping is ?
>>>>
>>>> Again, nope. Perf event groups are single counter (so no implicit
>>>> addition) that are co-scheduled on the PMU.
>>>
>>> I'm not sure I understand - does this require specific PMU/arch support - as in
>>> multiple conditions feeding to same counter.
>>
>> My read is that is that what Peter meant was that each event in the
>> perf event group is a single counter, so all the events in the group
>> are counted simultaneously.  (No multiplexing.)
> 
> Right, sorry for the poor wording.
> 
>>> Again when you say co-scheduled what do you mean - why would anyone use the event
>>> grouping - is it when they only have 1 counter and they want to count 2
>>> conditions/events at the same time - isn't this same as event multiplexing ?
>>
>> I'd say it's the converse of multiplexing.  Instead of mapping
>> multiple events to a single counter, perf event groups map a set of
>> events each to their own counter, and they are active simultaneously.
>> I suppose it's possible for the _groups_ to be multiplexed with other
>> events or groups, but the group as a whole will be scheduled together,
>> as a group.
> 
> Correct.
> 
> Each events get their own hardware counter. Grouped events are
> co-scheduled on the hardware.

And if we don't group them, then they _may_ not be co-scheduled (active/counting
at the same time) ? But how can this be possible.
Say we have 2 counters, both the cmds below

     perf -e cycles,instructions hackbench
     perf -e {cycles,instructions} hackbench

would assign 2 counters to the 2 conditions which keep counting until perf asks
them to stop (because the profiled application ended)

I don't understand the "scheduling" of counter - once we set them to count, there
is no real intervention/scheduling form software in terms of disabling/enabling
(assuming no multiplexing etc)

> You can multiplex groups. But if one event in a group is schedule, they
> all must be.
