From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: System crash with perf_fuzzer (kernel: 5.0.0-rc3)
Date: Fri, 1 Feb 2019 11:27:28 -0500 (EST)
Message-ID: <alpine.DEB.2.21.1902011125290.25915@macbook-air>
References: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com> <20190130183648.GA24233@krava> <20190131082711.GC24233@krava> <20190201074353.GA8778@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190201074353.GA8778@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Andi Kleen <ak@linux.intel.com>, eranian@google.com, vincent.weaver@maine.edu, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

On Fri, 1 Feb 2019, Jiri Olsa wrote:

> with attached patch I did not trigger the fuzzer crash
> for over a day now, could you guys try?

I've just started fuzzing with the patch applied.  Often it takes a few 
hours to trigger the bug.

Added question about this bug.  It appeared that the crash was triggered 
by the BTS driver over-writing kernel memory.  The data being written, was 
this user controllable?  Meaning, is this a security issue being fixed, or 
just a crashing issue?

Vince Weaver
vincent.weaver@maine.edu
