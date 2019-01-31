From: Andi Kleen <ak@linux.intel.com>
Subject: Re: System crash with perf_fuzzer (kernel: 5.0.0-rc3)
Date: Thu, 31 Jan 2019 12:39:27 -0800
Message-ID: <20190131203927.GY6118@tassilo.jf.intel.com>
References: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com>
 <20190125160056.GG6118@tassilo.jf.intel.com>
 <CAM_iQpVtyCR=BTBkpDtbEFJ8REczpvYRTGPQnBsV=8rznXn6fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAM_iQpVtyCR=BTBkpDtbEFJ8REczpvYRTGPQnBsV=8rznXn6fg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, eranian@google.com, vincent.weaver@maine.edu, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

> Yeah, a loop stuck looks really scary inside an NMI handler.
> Should I just go ahead to send a patch to remove this warning?
> Or probably turn it into a pr_info()?

Not at this point. Would need to fix the PMU reset first to be
more selective. 

-Andi
