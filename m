From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Perf Reports Jump Instructions as Memory Access Instructions
Date: Tue, 26 May 2020 09:42:00 -0700
Message-ID: <20200526164159.dsnboewwdyczr5j6@two.firstfloor.org>
References: <20200526133817.GA23187@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-trace-users-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200526133817.GA23187@redhat.com>
Sender: linux-trace-users-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andi Kleen <andi@firstfloor.org>, Jin Yao <yao.jin@linux.intel.com>, ahmadkhorrami <ahmadkhorrami@ut.ac.ir>, Linux-trace Users <linux-trace-users@vger.kernel.org>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

> > > The access point is at offset 0 of the following disassembly:
>  > Dump of assembler code for function cairo_surface_get_device_scale@plt:
> > >     0x000000000002a310 <+0>:     jmpq   *0x2c8b3a(%rip)        # 0x2f2e50
> > >     0x000000000002a316 <+6>:     pushq  $0x1c7
> > >     0x000000000002a31b <+11>:    jmpq   0x28690
> > > 
> > > This is an unconditional jump which will not lead to macrofusion.
> 
> But that will access memory, no? The instruction at offset 0.

Instruction fetches are not sampled by the MEM_INST_RETIRED event.

This is an indirect jump through memory, so it accesses the memory at
0x2c8b3a(%rip). These kind of accesses are sampled by the event.

Other memory accesses as part of other instructions may be sampled too.

-Andi
