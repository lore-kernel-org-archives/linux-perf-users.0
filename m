From: Thomas Renninger <trenn@suse.de>
Subject: Re: Perf ABI versioning
Date: Mon, 24 Jan 2011 22:02:22 +0100
Message-ID: <201101242202.23068.trenn@suse.de>
References: <201101241704.01021.trenn@suse.de> <20110124201225.GA14635@Krystal>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <20110124201225.GA14635@Krystal>
Sender: linux-trace-users-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: tardyp@gmail.com, jean.pihet@newoldbits.com, acme@ghostprotocols.net, fweisbec@gmail.com, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

Hi,

Pierre may correct me if I am wrong, even pytimechart is not big,
I realized that I am not that good in python code reading...

On Monday 24 January 2011 21:12:25 Mathieu Desnoyers wrote:
> [ added Ingo, Steven, Thomas and Peter to CC list ]
> 
> I would agree, though, about the need for a version number on the way
> /sys/kernel/debug/tracing/events exports the binary event type and text-output
> formatting information: in order to cope with changes to the way this metadata
> is exported, we'd need such a versioning number.
pytimechart simply works on reading /sys/kernel/debug/trace
The big advantage is that you can copy things away to another machine.
I expect the same concept is with perf record and perf.data.
Theoretically you can attach perf.data to a bug report and everybody (considering
the userspace tool is new and maintained enough) can process the data.

I do not know the binary format of this file, but a version number would be
an easy way for userspace tools to figure out which events are supported
and in which format.

> But again, trying to version every tiny change to the fields per se won't scale
> with the development process given that we pull instrumentation changes from
> many different repository concurrently. The field layout information is there to
> deal with this problem, pytimechart should perhaps start using it.
I see that there are quite some changes, but why wouldn't it scale?
Even if every git commit automatically would increases the version, a userspace
tool would only pick out very specific versions it cares about:

if (version > 2000) {
    /* event x got introduced, try to catch it as well */
}
if (version < 3000) {
   /* event y did not have field z */
}
...

I would not introduce a major.minor just for the sake of it.

About Frederic's comment:
> Also, tracking the changes in the Documentation is going to be a
> nightmare. I suggest developers who want to dig into details of
> an ABI change to check the code or the format themselves.
If you want an ABI and userspace tools being able to cope with
it across kernel versions , there should be some documentation as well.
Let it only be one sentence containing the event to grep for. You can then
catch the details from the git commit id.

       Thomas
