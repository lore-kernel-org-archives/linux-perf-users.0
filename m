From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf bpf: Fix endianness problem when loading parameters
 in prologue
Date: Mon, 14 Aug 2017 11:42:59 +0200
Message-ID: <9ed95973-3eb0-b167-4365-647bc7882904@linux.vnet.ibm.com>
References: <20170812184959.32694-1-wangnan0@huawei.com>
 <0e9620f7-e0d9-e8a4-ee87-3284bc9b8cc2@huawei.com>
 <20170811192344.GA6073@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170811192344.GA6073@kernel.org>
Content-Language: en-IE
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>, "Wangnan (F)" <wangnan0@huawei.com>
Cc: linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On 08/11/2017 09:23 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Aug 11, 2017 at 06:47:56PM +0800, Wangnan (F) escreveu:
>> Hi Thomas,
>>
>> Please try this patch on your machine and give me the result.
> 
> Right, I'm waiting for test results for the last two patches from Wang:
> 
>       (3.0K) [PATCH] perf bpf: Fix endianness problem when loading parameters in prologue

This patch does not solve the issue completely. It solves load of parameter 1 which is
loaded from 132(%r2):x32 from memory via function BPF_FUNC_probe_read.

How another issue is introduced with register r3:
The probe_events: p:perf_bpf_probe/func _text+8769704 f_mode=+132(%r2):x32 
       offset=%r3:s64 orig=%r4:s32
Now r4 does not have any offset at all and is not read from memory via
function BPF_FUNC_probe_read. The value is instead stored in a 8 byte register.

When I look into the generated eBPF bytes code I see

   (1) r3 = *(r6 + 56)  <-- R3 loaded from ctx pointer + 56
                        which is value of register r3 (origin of lseek)
       ....
   (2) *(r10 - 24) = r3  <-- R3 is stored on stack position for function call)
       ...
   (3) r3 = *(r10 - 8)  <-- load f_mode into r3
   (4) r4 = *(r10 - 16) <-- load offset into r4
   (5) r5 = *(r10 - 24) <-- load origin into r5

I have provided a reworked patch to solve this issue. Please review it because
I do not know if it will work in all cases.
See below.


>       (1.2K) [PATCH] perf test llvm: Fix f_mode endianness problem
> 
> Thanks,
> 
> - Arnaldo
> 
>> Thank you.
>>
>> On 2017/8/13 2:49, Wang Nan wrote:
>>> Perf BPF prologue generator unconditionally fetches 8 bytes for function
>>> parameters, which causes problem on big endian machine. Thomas gives a
>>> detail analysis for this problem:
>>>
>>>   http://lkml.kernel.org/r/968ebda5-abe4-8830-8d69-49f62529d151@linux.vnet.ibm.com
>>>
>>> This patch parses the type of each argument and converts data from
>>> memory to expected type.
>>>
>>> Signed-off-by: Wang Nan <wangnan0@huawei.com>
>>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>>> Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
>>> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>>> Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
>>> Cc: Li Zefan <lizefan@huawei.com>
>>> ---
>>>   tools/perf/tests/bpf-script-test-prologue.c |  4 ++-
>>>   tools/perf/util/bpf-prologue.c              | 49 +++++++++++++++++++++++++++--
>>>   2 files changed, 50 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/perf/tests/bpf-script-test-prologue.c b/tools/perf/tests/bpf-script-test-prologue.c
>>> index b4ebc75..43f1e16 100644
>>> --- a/tools/perf/tests/bpf-script-test-prologue.c
>>> +++ b/tools/perf/tests/bpf-script-test-prologue.c
>>> @@ -26,9 +26,11 @@ static void (*bpf_trace_printk)(const char *fmt, int fmt_size, ...) =
>>>   	(void *) 6;
>>>   SEC("func=null_lseek file->f_mode offset orig")
>>> -int bpf_func__null_lseek(void *ctx, int err, unsigned long f_mode,
>>> +int bpf_func__null_lseek(void *ctx, int err, unsigned long _f_mode,
>>>   			 unsigned long offset, unsigned long orig)
>>>   {
>>> +	fmode_t f_mode = (fmode_t)_f_mode;
>>> +
>>>   	if (err)
>>>   		return 0;
>>>   	if (f_mode & FMODE_WRITE)
>>> diff --git a/tools/perf/util/bpf-prologue.c b/tools/perf/util/bpf-prologue.c
>>> index 6cdbee1..ce28993 100644
>>> --- a/tools/perf/util/bpf-prologue.c
>>> +++ b/tools/perf/util/bpf-prologue.c
>>> @@ -57,6 +57,46 @@ check_pos(struct bpf_insn_pos *pos)
>>>   	return 0;
>>>   }
>>> +/*
>>> + * Convert type string (u8/u16/u32/u64/s8/s16/s32/s64 ..., see
>>> + * Documentation/trace/kprobetrace.txt) to size field of BPF_LDX_MEM
>>> + * instruction (BPF_{B,H,W,DW}).
>>> + */
>>> +static int
>>> +argtype_to_ldx_size(const char *type)
>>> +{
>>> +	int arg_size = type ? atoi(&type[1]) : 64;
>>> +
>>> +	switch (arg_size) {
>>> +	case 8:
>>> +		return BPF_B;
>>> +	case 16:
>>> +		return BPF_H;
>>> +	case 32:
>>> +		return BPF_W;
>>> +	case 64:
>>> +	default:
>>> +		return BPF_DW;
>>> +	}
>>> +}
>>> +
>>> +static const char *
>>> +insn_sz_to_str(int insn_sz)
>>> +{
>>> +	switch (insn_sz) {
>>> +	case BPF_B:
>>> +		return "BPF_B";
>>> +	case BPF_H:
>>> +		return "BPF_H";
>>> +	case BPF_W:
>>> +		return "BPF_W";
>>> +	case BPF_DW:
>>> +		return "BPF_DW";
>>> +	default:
>>> +		return "UNKNOWN";
>>> +	}
>>> +}
>>> +
>>>   /* Give it a shorter name */
>>>   #define ins(i, p) append_insn((i), (p))
>>> @@ -257,9 +297,14 @@ gen_prologue_slowpath(struct bpf_insn_pos *pos,
>>>   	}
>>>   	/* Final pass: read to registers */
>>> -	for (i = 0; i < nargs; i++)
>>> -		ins(BPF_LDX_MEM(BPF_DW, BPF_PROLOGUE_START_ARG_REG + i,
>>> +	for (i = 0; i < nargs; i++) {
>>> +		int insn_sz = argtype_to_ldx_size(args[i].type);

                int insn_sz = (args[i].ref) ? argtype_to_ldx_size(args[i].type) : BPF_DW;

>>> +
>>> +		pr_debug("prologue: load arg %d, insn_sz is %s\n",
>>> +			 i, insn_sz_to_str(insn_sz));
>>> +		ins(BPF_LDX_MEM(insn_sz, BPF_PROLOGUE_START_ARG_REG + i,
>>>   				BPF_REG_FP, -BPF_REG_SIZE * (i + 1)), pos);
>>> +	}
>>>   	ins(BPF_JMP_IMM(BPF_JA, BPF_REG_0, 0, JMP_TO_SUCCESS_CODE), pos);
>>
> 


-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
