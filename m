From: ahmadkhorrami <ahmadkhorrami@ut.ac.ir>
Subject: Re: Perf Reports Jump Instructions as Memory Access Instructions
Date: Wed, 03 Jun 2020 08:19:34 +0430
Message-ID: <1113a5891fcccce6cfe59e6da59eee95@ut.ac.ir>
References: <20200526133817.GA23187@redhat.com>
 <20200526164159.dsnboewwdyczr5j6@two.firstfloor.org>
 <3043c6c2f878ad3419e350867903cb0a@ut.ac.ir>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <3043c6c2f878ad3419e350867903cb0a@ut.ac.ir>
Sender: linux-trace-users-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Jin Yao <yao.jin@linux.intel.com>, Linux-trace Users <linux-trace-users@vger.kernel.org>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-trace-users-owner@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Thanks everybody, specially, Steven, Arnaldo and Andi.

On 2020-05-27 00:25, ahmadkhorrami wrote:

> Thanks! This seems reasonable. But as Arnaldo says, why is there a skid 
> in the access address while PEBS is used? Both RIP and Access Address 
> should match, Right?
> Regards.
> 
> On 2020-05-26 21:12, Andi Kleen wrote:
> 
>> The access point is at offset 0 of the following disassembly:
>> Dump of assembler code for function 
>> cairo_surface_get_device_scale@plt:
> 
> 0x000000000002a310 <+0>:     jmpq   *0x2c8b3a(%rip)        # 0x2f2e50
> 0x000000000002a316 <+6>:     pushq  $0x1c7
> 0x000000000002a31b <+11>:    jmpq   0x28690
> 
> This is an unconditional jump which will not lead to macrofusion.

But that will access memory, no? The instruction at offset 0.
Instruction fetches are not sampled by the MEM_INST_RETIRED event.

This is an indirect jump through memory, so it accesses the memory at
0x2c8b3a(%rip). These kind of accesses are sampled by the event.

Other memory accesses as part of other instructions may be sampled too.

-Andi
