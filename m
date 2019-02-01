From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: System crash with perf_fuzzer (kernel: 5.0.0-rc3)
Date: Fri, 1 Feb 2019 18:38:16 +0100
Message-ID: <20190201173816.GA19907@krava>
References: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com>
 <20190130183648.GA24233@krava>
 <20190131082711.GC24233@krava>
 <20190201074353.GA8778@krava>
 <alpine.DEB.2.21.1902011125290.25915@macbook-air>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1902011125290.25915@macbook-air>
Sender: linux-kernel-owner@vger.kernel.org
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Andi Kleen <ak@linux.intel.com>, eranian@google.com, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

On Fri, Feb 01, 2019 at 11:27:28AM -0500, Vince Weaver wrote:
> On Fri, 1 Feb 2019, Jiri Olsa wrote:
> 
> > with attached patch I did not trigger the fuzzer crash
> > for over a day now, could you guys try?
> 
> I've just started fuzzing with the patch applied.  Often it takes a few 
> hours to trigger the bug.

cool, thanks

> 
> Added question about this bug.  It appeared that the crash was triggered 
> by the BTS driver over-writing kernel memory.  The data being written, was 
> this user controllable?  Meaning, is this a security issue being fixed, or 
> just a crashing issue?

yea, I have an example that can trigger it immediately

jirka
