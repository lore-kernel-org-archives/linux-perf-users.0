From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: System crash with perf_fuzzer (kernel: 5.0.0-rc3)
Date: Sat, 2 Feb 2019 12:58:07 -0500 (EST)
Message-ID: <alpine.DEB.2.21.1902021255370.5674@macbook-air>
References: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com> <20190130183648.GA24233@krava> <20190131082711.GC24233@krava> <20190201074353.GA8778@krava> <alpine.DEB.2.21.1902011125290.25915@macbook-air> <20190201173816.GA19907@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190201173816.GA19907@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Vince Weaver <vincent.weaver@maine.edu>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Andi Kleen <ak@linux.intel.com>, eranian@google.com, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

On Fri, 1 Feb 2019, Jiri Olsa wrote:

> > 
> > I've just started fuzzing with the patch applied.  Often it takes a few 
> > hours to trigger the bug.
> 
> cool, thanks

I let it run overnight and no crash.

> > Added question about this bug.  It appeared that the crash was triggered 
> > by the BTS driver over-writing kernel memory.  The data being written, was 
> > this user controllable?  Meaning, is this a security issue being fixed, or 
> > just a crashing issue?
> 
> yea, I have an example that can trigger it immediately

I mean: the crash is happening because data structures are getting 
over-written by the BTS driver.  Depending who and what is doing this, 
this could be a security issue (i.e. if it was raw BTS data that was 
partially userspace controlled values).  Though even if this were the case 
it would probably be hard to exploit.

Vince
