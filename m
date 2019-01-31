From: Andi Kleen <ak@linux.intel.com>
Subject: Re: System crash with perf_fuzzer (kernel: 5.0.0-rc3)
Date: Thu, 31 Jan 2019 05:00:30 -0800
Message-ID: <20190131130030.GW6118@tassilo.jf.intel.com>
References: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com>
 <20190125160056.GG6118@tassilo.jf.intel.com>
 <33d300b5-f8b0-4987-4d4c-b5175b6b6c60@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <33d300b5-f8b0-4987-4d4c-b5175b6b6c60@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, eranian@google.com, vincent.weaver@maine.edu, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

On Thu, Jan 31, 2019 at 01:28:34PM +0530, Ravi Bangoria wrote:
> Hi Andi,
> 
> On 1/25/19 9:30 PM, Andi Kleen wrote:
> >> [Fri Jan 25 10:28:53 2019] perf: interrupt took too long (2501 > 2500), lowering kernel.perf_event_max_sample_rate to 79750
> >> [Fri Jan 25 10:29:08 2019] perf: interrupt took too long (3136 > 3126), lowering kernel.perf_event_max_sample_rate to 63750
> >> [Fri Jan 25 10:29:11 2019] perf: interrupt took too long (4140 > 3920), lowering kernel.perf_event_max_sample_rate to 48250
> >> [Fri Jan 25 10:29:11 2019] perf: interrupt took too long (5231 > 5175), lowering kernel.perf_event_max_sample_rate to 38000
> >> [Fri Jan 25 10:29:11 2019] perf: interrupt took too long (6736 > 6538), lowering kernel.perf_event_max_sample_rate to 29500
> > 
> > These are fairly normal.
> 
> I understand that throttling mechanism is designed exactly to do this.
> But I've observed that, everytime I run the fuzzer, max_sample_rates is
> been throttled down to 250 (which is CONFIG_HZ I guess). Doesn't this
> mean the interrupt time is somehow increasing gradually? Is that fine?

It's more like the throttling mechanism is an controller
and it takes multiple tries to zoom in on the truely
needed value.

You can measure the PMI time by enabling the nmi:nmi_handler
trace point. It directly reports it. From what I've seen
it's a long tail distribution with regular large outliers.
Most of the PMIs are not that slow, just an occassional
few are.

When I did some investigation on this a couple years back
the outliers were either due to call stack processing,
or due to flushing the perf ring buffer. There were some
fixes on the the call stack case back then, but I'm sure more could
be done.

For the call stack processing there isn't much more we can do I think
(other than switching to call stack LBR only),
but I suspect the buffer flushing problem could be improved more.

It's relatively easy to investigate with a variant of the ftrace
recipe I posted earlier (but you need to fix the Makefile first
to enable ftrace for all of perf) Just add a ftrace trigger on the
nmi_handler trace point to stop tracing when the nmi_handler
time exceeds a threshold and look at the traces.

-Andi
