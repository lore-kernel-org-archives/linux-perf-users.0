From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: perf event grouping for dummies (was Re: [PATCH] arc: perf: Enable
 generic "cache-references" and "cache-misses" events)
Date: Tue, 20 Sep 2016 13:56:20 -0700
Message-ID: <2a18ae06-3abd-c3a1-e980-f04c511b08e5@synopsys.com>
References: <1472125647-518-1-git-send-email-abrodkin@synopsys.com>
 <6074e252-6e18-bb01-4de1-023bd7e82f03@synopsys.com>
 <5f65fa04-8d33-e525-115d-4e6991a7668e@synopsys.com>
 <20160901083324.GM10153@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160901083324.GM10153@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

On 09/01/2016 01:33 AM, Peter Zijlstra wrote:
>> - is that what perf event grouping is ?
>
> Again, nope. Perf event groups are single counter (so no implicit
> addition) that are co-scheduled on the PMU.

I'm not sure I understand - does this require specific PMU/arch support - as in
multiple conditions feeding to same counter. How does perf user make use of this
info - I tried googling around but can't seem to find anything which explains the
semantics.

I can see that group events to work on ARC (although in our case a counter can
cont one condition at a time only) and the results seem to be similar whther we
group or not.

------------->8------------
[ARCLinux]# perf stat -e {cycles,instructions} hackbench
Running with 10*40 (== 400) tasks.
Time: 37.430

 Performance counter stats for 'hackbench':

        3487777173    cycles
        1351709784    instructions            #    0.39  insn per cycle

      38.957481536 seconds time elapsed

[ARCLinux]# perf stat -e cycles hackbench
Running with 10*40 (== 400) tasks.
Time: 36.735

 Performance counter stats for 'hackbench':

        3426151391    cycles

      38.247235981 seconds time elapsed

[ARCLinux]#
[ARCLinux]# perf stat -e instructions hackbench
Running with 10*40 (== 400) tasks.
Time: 37.537

 Performance counter stats for 'hackbench':

        1355421559    instructions

      39.061784281 seconds time elapsed
------------->8------------

...
> 
> You can do it like:
> 
> 	perf stat -e '{cycles,instructions}'
> 
> Which will place the cycles event and the instructions event in a group
> and thereby guarantee they're co-scheduled.

Again when you say co-scheduled what do you mean - why would anyone use the event
grouping - is it when they only have 1 counter and they want to count 2
conditions/events at the same time - isn't this same as event multiplexing ?

-Vineet
