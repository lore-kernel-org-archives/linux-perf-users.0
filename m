From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 02/11] perf tools script: Support insn output for normal
 samples
Date: Mon, 25 Feb 2019 13:56:00 +0100
Message-ID: <20190225125600.GG19795@krava>
References: <20190224153722.27020-1-andi@firstfloor.org>
 <20190224153722.27020-3-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190224153722.27020-3-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, namhyung@kernel.org, eranian@google.com, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Sun, Feb 24, 2019 at 07:37:13AM -0800, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> perf script -F +insn was only working for PT traces because
> the PT instruction decoder was filling in the insn/insn_len
> sample attributes. Support it for non PT samples too on x86
> using the existing x86 instruction decoder.
> 
> % perf record -a sleep 1
> % perf script -F ip,sym,insn --xed
>  ffffffff811704c9 remote_function               movl  %eax, 0x18(%rbx)
>  ffffffff8100bb50 intel_bts_enable_local                retq
>  ffffffff81048612 native_apic_mem_write                 movl  %esi, -0xa04000(%rdi)
>  ffffffff81048612 native_apic_mem_write                 movl  %esi, -0xa04000(%rdi)
>  ffffffff81048612 native_apic_mem_write                 movl  %esi, -0xa04000(%rdi)
>  ffffffff810f1f79 generic_exec_single           xor %eax, %eax
>  ffffffff811704c9 remote_function               movl  %eax, 0x18(%rbx)
>  ffffffff8100bb34 intel_bts_enable_local                movl  0x2000(%rax), %edx
>  ffffffff81048610 native_apic_mem_write                 mov %edi, %edi

also for samples with empty instruction, where I guess we fail
for some reason to retrieve it, we will show default (0?) mnemonic

[jolsa@krava perf]$ ./perf script -F insn
 insn:
 insn:
 insn:
 insn:
 insn:
 insn:
 insn:
 insn: 76 ea
 insn:
 insn: 0f a2
 insn: 29 c8
 insn: 8b 04 90
 insn: 0f a2

[jolsa@krava perf]$ ./perf script -F insn --xed
                addb  %al, (%rax)
                addb  %al, (%rax)
                addb  %al, (%rax)
                addb  %al, (%rax)
                addb  %al, (%rax)
                addb  %al, (%rax)
                addb  %al, (%rax)
                jbe 0xffffffffffffffec
                addb  %al, (%rax)
                cpuid
                sub %ecx, %eax
                movl  (%rax,%rdx,4), %eax
                cpuid

jirka
