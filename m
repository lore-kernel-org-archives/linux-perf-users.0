From: David Ahern <daahern@cisco.com>
Subject: Re: [PATCH 3/3] perf script: dump software events and samples from
 hardware-based profiling
Date: Thu, 03 Mar 2011 10:30:15 -0700
Message-ID: <4D6FD027.3080704@cisco.com>
References: <1299086960-26964-1-git-send-email-daahern@cisco.com> <1299086960-26964-4-git-send-email-daahern@cisco.com> <20110303030515.GD1946@nowhere> <4D6FA39A.60203@cisco.com> <20110303171940.GC1807@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110303171940.GC1807@nowhere>
Sender: linux-kernel-owner@vger.kernel.org
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, peterz@infradead.org, paulus@samba.org, tglx@linutronix.de
List-Id: linux-perf-users.vger.kernel.org



On 03/03/11 10:19, Frederic Weisbecker wrote:
> On Thu, Mar 03, 2011 at 07:20:10AM -0700, David Ahern wrote:
>> On 03/02/2011 08:05 PM, Frederic Weisbecker wrote:
>>> Hmm, that's a wrong way of walking through callchains. In fact it's not
>>> a classical list. node->next can be a ghost entry from a previous callchain
>>> that we kept cached in order to optimize allocations.
>>>
>>> You need the accessors callchain_cursor_current() and callchain_cursor_advance().
>>
>> Ok. I'll look at perf-report's callchain_append again.
> 
> Yeah callchain_append() is too much a generic name for something actually
> rather specific. In fact callchain_append() adds a callchain, already
> resolved, to a histogram in order to produce that statistical tree in the end
> that you can have with perf report.
> 
> But you don't need those statistical tree of callchains, it's only used
> by perf report for now. Instead you rather need to treat every callchains
> individually and print each of them.
> 
> So you don't even need callchain_append(). All you need in the end is

Right, just using that as an example of how callchains are handled.

> to use perf_session__resolve_callchain() that resolves the raw struct ip_callchain
> (only made of raw ips) into a cursor (list of ips resolved into symbols and so) and
> walk through the cursor with the two accessors.
> 
> Ah I forgot, you first need to use callchain_cursor_commit() in order to initialize
> the position in the cursor.
> 
> So:
> 
> 1) Resolve with perf_session__resolve_callchain()
> 2) commit with callchain_cursor_commit()
> 3) iterate with callchain_cursor_current(), callchain_cursor_advance()

yes, I figured out the missing commit, and I changed the loop to:
while (1) {
    node = callchain_cursor_current(cursor);
    if (!node)
        break;

      ... (print chain)

    callchain_cursor_advance(cursor);
}

Thanks for the comments.

What about the python and perl engines? Right now they are tracepoint
specific. I do not have a sufficient background in either to expand to
other sample types.

David

> 
> Thanks.
