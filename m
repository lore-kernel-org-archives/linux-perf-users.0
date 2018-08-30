From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf annotate: Handle arm64 move instructions
Date: Thu, 30 Aug 2018 15:38:36 -0300
Message-ID: <20180830183836.GF6097@kernel.org>
References: <20180827150807.304110d2e9919a17c832ca48@arm.com>
 <7b5ea377-91a6-d3f3-56a1-a836d5aaa7c5@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7b5ea377-91a6-d3f3-56a1-a836d5aaa7c5@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc: Kim Phillips <kim.phillips@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, perf group <linux-perf-users@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Aug 28, 2018 at 08:22:40AM +0200, Thomas-Mich Richter escreveu:
> On 08/27/2018 10:08 PM, Kim Phillips wrote:
> > Add default handler for non-jump instructions.  This really only has an
> > effect on instructions that compute a PC-relative address, such as 'adrp,'
> > as seen in these couple of examples:
> > 
> > BEFORE: adrp   x0, ffff20000aa11000 <kallsyms_token_index+0xce000>
> > AFTER:  adrp   x0, kallsyms_token_index+0xce000
> > 
> > BEFORE: adrp   x23, ffff20000ae94000 <__per_cpu_load>
> > AFTER:  adrp   x23, __per_cpu_load
> > 
> > The implementation is identical to that of s390, but with a slight
> > adjustment for objdump whitespace propagation (arm64 objdump puts
> > spaces after commas, whereas s390's presumably doesn't).
> > 
> > The mov__scnprintf() declaration is moved from s390's to arm64's
> > instructions.c because arm64's gets included before s390's.
> > 
> 
> Tested-by: Thomas Richter <tmricht@linux.ibm.com>

Thanks, applied.

- Arnaldo
