From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: System crash with perf_fuzzer (kernel: 5.0.0-rc3)
Date: Fri, 25 Jan 2019 10:11:28 -0500 (EST)
Message-ID: <alpine.DEB.2.21.1901251008310.32202@macbook-air>
References: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Andi Kleen <ak@linux.intel.com>, eranian@google.com, vincent.weaver@maine.edu, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

On Fri, 25 Jan 2019, Ravi Bangoria wrote:

> I'm seeing a system crash while running perf_fuzzer with upstream kernel
> on an Intel machine. I hit the crash twice (out of which I don't have log
> of first crash so don't know if the reason is same for both the crashes).
> I've attached my .config with the mail.
>                   type = PERF_TYPE_HARDWARE;



>   ========
> 
> And, I'm running fuzzer in a loop with *root*. (Let me know if running
> as root is harmful ;-) ).


There's a known issue related to Intel BTS events that you can trigger 
with the perf_fuzzer, even as a normal user.  I reported it a few months 
ago but I don't think it ever got resolved.  The traces you get look 
similar to some that you posted.

It's hard to track down as it doesn't seem to be a simple issue, but 
rather it looks like the BTS event handling is stomping over memory it 
shouldn't somehow.

Vince
