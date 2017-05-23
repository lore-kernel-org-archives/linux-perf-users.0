From: Andi Kleen <andi@firstfloor.org>
Subject: Re: perf/x86/intel: Collecting CPU-local performance counters from all cores in parallel
Date: Tue, 23 May 2017 13:53:32 -0700
Message-ID: <87o9uj47n7.fsf@firstfloor.org>
References: <CACFdaOz-ox4XSu-q8S-Op8xPTDwoT6FAN-yhi0988NJiazpm0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACFdaOz-ox4XSu-q8S-Op8xPTDwoT6FAN-yhi0988NJiazpm0Q@mail.gmail.com>
        (Michael Edwards's message of "Mon, 22 May 2017 22:42:29 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Edwards <michael@tensyr.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Michael Edwards <michael@tensyr.com> writes:
>
> Am I going about this wrong?

It seems like a reasonable optimization, but it's likely a lot of work.

> Is there some better way to pursue the
> high-level goal of gathering PMC-based statistics frequently and
> efficiently from all cores, without breaking everything else that uses
> perf_events?

If you can drive the collection from a performance counter
(e.g. reference cycles) you could use leader sampling, and let the
PMIs log the values to the mmap'ed ring buffer. This should
be vastly more efficient than pulling everything. This works today,
however there are some scaling problems with many groups still.

perf record -F frequency -e '{cpu/ref-cycles/,<three other
events to collect>}:S,... more groups like this ... -a ...

-Andi
