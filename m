From: Andi Kleen <andi@firstfloor.org>
Subject: Support sample context in perf report
Date: Fri,  8 Mar 2019 21:56:13 -0800
Message-ID: <20190309055628.21617-1-andi@firstfloor.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

[Changes: 
v5:
Address review comments.
Fix perf script --cpu filtering
Use _NSEC defines.
Fix DEBUG=0 build again
Make sample context size configurable.
Some minor improvements.
]

We currently have two ways to look at sample data in perf:
either use perf report to aggregate everything, or use
perf script to look at all individual samples.

Both ways are useful. Of course aggregation is useful
to quickly find the most expensive part of the code.

But sometimes a single sample is not good enough to
determine the problem and we need to look at context, either
through branch contexts, or other previous samples (e.g. for
correlating different micro architecture events or computing
metrics)

This can be done through perf script today, but it can
be rather cumbersome to find the right samples to look
at.

Another problem with perf report is that it aggregates
the whole measurement period. But many real workloads
have phases where they behave quite differently, and it is
often not useful to combine them into a single histogram.

While this can be worked around with the --time option
to report, it can be quite cumbersome.

This patch kit attempts to address some of these
problems in perf report by making it time aware.

- It adds a new time sort key that allows perf report
to separate samples from different regions. The time
regions can be defined with a new --time-quantum option.

- Then it extends the perf script support in the
tui record browser to allow browsing samples for 
different time regions from within a perf report
session.

- Extends the report browser script display
to automatically select sensible defaults
based on what was recorded. For example it will
automatically show branch contexts with -b.

- Support browsing the context of individual samples.
perf report can save a limited number of random samples
per histogram entry with the new --samples option.
Then the browser allows directly jumping to any
of the saved samples and browsing the context on the current
thread or CPU.

There could be probably be done more to make
perf report even better for such use cases (e.g. a real
time line display), but this basic support is good
enough for many useful usages.

Also available in
git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc.git perf/streams-5
