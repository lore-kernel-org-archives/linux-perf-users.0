From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: System crash with perf_fuzzer (kernel: 5.0.0-rc3)
Date: Sat, 2 Feb 2019 08:54:35 +0530
Message-ID: <a95f952c-ed3b-4838-315b-45f758398894@linux.ibm.com>
References: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com>
 <20190130183648.GA24233@krava> <20190131082711.GC24233@krava>
 <20190201074353.GA8778@krava>
 <4e816b25-1763-ec23-0642-19e6258e6ac5@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4e816b25-1763-ec23-0642-19e6258e6ac5@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Andi Kleen <ak@linux.intel.com>, eranian@google.com, vincent.weaver@maine.edu, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org



On 2/1/19 1:24 PM, Ravi Bangoria wrote:
> I ran fuzzer for couple of hours but I didn't see any crash with
> your previous patch.
> 
> I'll try this newer one as well.

I ran fuzzer for ~8 hrs and no lockup so far.

Thanks.
