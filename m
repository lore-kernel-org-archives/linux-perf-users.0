From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 02/11] perf tools script: Support insn output for normal
 samples
Date: Mon, 25 Feb 2019 13:56:48 +0100
Message-ID: <20190225125648.GN19795@krava>
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
> ...
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/arch/x86/util/Build      |  1 +
>  tools/perf/arch/x86/util/archinsn.c | 41 +++++++++++++++++++++++++++++
>  tools/perf/builtin-script.c         | 10 +++++++
>  tools/perf/util/archinsn.h          | 12 +++++++++
>  4 files changed, 64 insertions(+)
>  create mode 100644 tools/perf/arch/x86/util/archinsn.c
>  create mode 100644 tools/perf/util/archinsn.h
> 
> diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
> index 7aab0be5fc5f..7b8e69bbbdfe 100644
> --- a/tools/perf/arch/x86/util/Build
> +++ b/tools/perf/arch/x86/util/Build
> @@ -6,6 +6,7 @@ perf-y += perf_regs.o
>  perf-y += group.o
>  perf-y += machine.o
>  perf-y += event.o
> +perf-y += archinsn.o
>  
>  perf-$(CONFIG_DWARF) += dwarf-regs.o
>  perf-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
> diff --git a/tools/perf/arch/x86/util/archinsn.c b/tools/perf/arch/x86/util/archinsn.c
> new file mode 100644
> index 000000000000..9e3b0828b018
> --- /dev/null
> +++ b/tools/perf/arch/x86/util/archinsn.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "perf.h"
> +#include "archinsn.h"
> +#include "util/intel-pt-decoder/insn.h"
> +#include "machine.h"
> +#include "thread.h"
> +#include "symbol.h"
> +#include "map.h"
> +
> +void arch_fetch_insn(struct perf_sample *sample,
> +		     struct thread *thread,
> +		     struct machine *machine)
> +{
> +	struct addr_location al;
> +	u8 cpumode;
> +	long offset;
> +	struct insn insn;
> +	int len;
> +
> +	if (!sample->ip)
> +		return;
> +
> +	if (machine__kernel_ip(machine, sample->ip))
> +		cpumode = PERF_RECORD_MISC_KERNEL;
> +	else
> +		cpumode = PERF_RECORD_MISC_USER;
> +	if (!thread__find_map(thread, cpumode, sample->ip, &al) || !al.map->dso)
> +		return;
> +	if (al.map->dso->data.status == DSO_DATA_STATUS_ERROR)
> +		return;
> +	map__load(al.map);
> +	offset = al.map->map_ip(al.map, sample->ip);
> +	len = dso__data_read_offset(al.map->dso, machine, offset, (u8 *)sample->insn,
> +				   sizeof(sample->insn));
> +	if (len <= 0)
> +		return;
> +	insn_init(&insn, sample->insn, len, al.map->dso->is_64_bit);
> +	insn_get_length(&insn);
> +	if (insn_complete(&insn) && insn.length <= len)
> +		sample->insn_len = insn.length;
> +}

I saw this code around multiple times.. I think bts and pt are using
same code to fetch instructions.. could we synchronize and have just
one function to do this?

thanks,
jirka
