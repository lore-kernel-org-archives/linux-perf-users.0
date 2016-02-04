From: "Wangnan (F)" <wangnan0@huawei.com>
Subject: Re: eBPF counters for 'perf stat' e.g.: Re: User defined metrics for
 perf stat?
Date: Thu, 4 Feb 2016 17:46:17 +0800
Message-ID: <56B31DE9.8040107@huawei.com>
References: <CAGz0_-1EMt=mBSyrJPSQ_rg4f0tEf+PasAH-4A8sPWDnSm_JPw@mail.gmail.com>
 <CAGz0_-0k93OvSNgtnDMMTwYWxQuVnABqjfKC-KdmhGqv5H=C3A@mail.gmail.com>
 <20160202085802.GA4257@krava.brq.redhat.com>
 <17343448.BlG9640ky3@milian-kdab2>
 <20160203141157.GB31974@krava.brq.redhat.com>
 <20160203141818.GA8193@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:27213 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933618AbcBDJrC (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 4 Feb 2016 04:47:02 -0500
In-Reply-To: <20160203141818.GA8193@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>, Jiri Olsa <jolsa@redhat.com>, Andreas Hollmann <hollmann@in.tum.de>, Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org



On 2016/2/3 22:18, Arnaldo Carvalho de Melo wrote:
> Em Wed, Feb 03, 2016 at 03:11:57PM +0100, Jiri Olsa escreveu:
>> On Wed, Feb 03, 2016 at 01:39:20PM +0100, Milian Wolff wrote:
>>> How does this compare to the ongoing eBPF effort? Will we be able to do eBPF
>>> based in-kernel aggregation for perf stat in the future?
>   
>> hum, not sure what you mean by that, however this is
>> all user level scripting support to allow user defined
>> metrics/ratios from perf counters, more info ine here:
>>    http://marc.info/?l=linux-kernel&m=145207742329050&w=2
> I would have to check, Wang may help here, but perf has been getting
> more and more integrated with the eBPF facilities in place in the
> kernel.
>
> To the point that yeah, I think that loading a C program that would hook
> somewhere in the kernel and would then create a counter that could be
> named and used with perf stat is something I think should even already
> be possible if you use what is in Wang's tree, being reviewed to get
> upstream, Wang?

Still not support 'perf stat'. I focus on 'perf record' now.

Here I provide an example shows how to compute IPC for a particular
kernel function. Usage:

# perf record -e output=bpf-output/no-inherit/ \
               -e cyc=cycles/no-inherit,period=0x7fffffffffffffff/ \
               -e insn=instructions/no-inherit,period=0x7fffffffffffffff/ \
               -e 
./test.c/maps:cycles_pmu.event=cyc,maps:insn_pmu.event=insn,maps:output_channel.event=output/ 
\
               cat /etc/passwd
...
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.012 MB perf.data (1 samples) ]

# perf data convert --to-ctf ./out.ctf
[ perf data convert: Converted 'perf.data' into CTF data './out.ctf' ]
[ perf data convert: Converted and wrote 0.000 MB (1 samples) ]
# babeltrace ./out.ctf/
[20:30:39.714787237] (+?.?????????) output=bpf-output/no-inherit/: { 
cpu_id = 0 }, { perf_ip = 0xFFFFFFFF8107CB81, perf_tid = 30718, perf_pid 
= 30718, perf_id = 3171, raw_len = 5, raw_data = [ [0] = 0x4B5C, [1] = 
0x0, [2] = 0x2CDE, [3] = 0x0, [4] = 0x0 ] }

So we know 'cat /etc/passwd' consumes 0x4b5c cycles and 0x2cde instructions
in sys_read(), so IPC for this kernel function is 0.595.

The example shows data aggregation BPF scripts can do. In the script
we can sum up cycles and instructions of each execution of the function
but filter other part of the program out.

I'm unable to compute IPC in kernel directly because LLVM doesn't support
compiling '/' operation into BPF code. We can bring raw data out through
bpf-output event and calculate them using other helpers.
The program is long and not very easy to read because we don't have enough
scaffold for building BPF script, so have to write them by hand. However,
at present the basic perf event and bpf output support have not been merged
into mainline (availible on my tree only), so I'm still working on this 
part.

-------------- test.c ---------------------

#include <uapi/linux/bpf.h>

#define SEC(NAME) __attribute__((section(NAME), used))

static void (*bpf_trace_printk)(const char *fmt, int fmt_size, ...) = 
(void *)BPF_FUNC_trace_printk;
static void *(*map_lookup_elem)(void *map, void *key) = (void 
*)BPF_FUNC_map_lookup_elem;
static int (*bpf_get_current_comm)(char *map, int size_of_buf) = (void 
*)BPF_FUNC_get_current_comm;
static u64 (*bpf_perf_event_read)(void *map, int index) = (void 
*)BPF_FUNC_perf_event_read;
static u32 (*get_smp_processor_id)(void)= (void 
*)BPF_FUNC_get_smp_processor_id;
static void (*bpf_perf_event_output)(void *ctx, void *map, int index, 
void *data, int size) =
                         (void *)BPF_FUNC_perf_event_output;

char _license[] SEC("license") = "GPL";
int _version SEC("version") = LINUX_VERSION_CODE;

struct bpf_map_def {
         unsigned int type;
         unsigned int key_size;
         unsigned int value_size;
         unsigned int max_entries;
};

struct bpf_map_def SEC("maps") cycles_pmu = {
         .type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
         .key_size = sizeof(int),
         .max_entries = __NR_CPUS__,
};

struct bpf_map_def SEC("maps") insn_pmu = {
         .type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
         .key_size = sizeof(int),
         .value_size = sizeof(u32),
         .max_entries = __NR_CPUS__,
};

struct bpf_map_def SEC("maps") output_channel = {
         .type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
         .key_size = sizeof(int),
         .value_size = sizeof(u32),
         .max_entries = __NR_CPUS__,
};

struct bpf_map_def SEC("maps") vals = {
         .type = BPF_MAP_TYPE_ARRAY,
         .key_size = sizeof(int),
         .value_size = sizeof(u64),
         .max_entries = __NR_CPUS__ * 2 + 2,
};

static inline bool basic_filter(void)
{
         char comm[24] = "";
         char name[4] = "cat";

         if (bpf_get_current_comm(comm, 24))
                 return false;
         if (__builtin_memcmp(comm, name, sizeof(name)))
                 return false;
         return true;
}

static inline bool read_pmu(void *map, u64 *val, u64 **p_val, int cpu, 
int key)
{
         *val = bpf_perf_event_read(map, cpu);
         if (*val >= 0xffffffff00000000)
                 return false;
         *p_val = map_lookup_elem(&vals, &key);
         if (!*p_val)
                 return false;
         return true;
}

static inline bool read_pmus(u64 *cycles, u64 **p_cycles,
                                u64 *insns, u64 **p_insns)
{
         int cpu = get_smp_processor_id();
         int key = cpu;

         if (!basic_filter())
                 return false;

         if (!read_pmu(&cycles_pmu, cycles, p_cycles, cpu, key))
                 return false;

         key += __NR_CPUS__;
         if (!read_pmu(&insn_pmu, insns, p_insns, cpu, key))
                 return false;
         return true;
}

SEC("bpf__sys_read=sys_read")
int bpf__sys_read(void *ctx)
{
         u64 cycles, *p_cycles, insns, *p_insns;

         if (read_pmus(&cycles, &p_cycles, &insns, &p_insns)) {
                 *p_cycles = cycles;
                 *p_insns = insns;
         }
         return 0;
}

SEC("bpf__sys_read_ret=sys_read%return")
int bpf__sys_read_ret(void *ctx)
{
         u64 cycles, *p_cycles, insns, *p_insns;
         u64 *total;
         int key;

         if (read_pmus(&cycles, &p_cycles, &insns, &p_insns)) {
                 cycles = cycles - *p_cycles;
                 insns = insns - *p_insns;

                 key = __NR_CPUS__ * 2;
                 total = map_lookup_elem(&vals, &key);
                 if (!total)
                         return 0;
                 __sync_fetch_and_add(total, cycles);

                 key = __NR_CPUS__ * 2 + 1;
                 total = map_lookup_elem(&vals, &key);
                 if (!total)
                         return 0;
                 __sync_fetch_and_add(total, insns);
         }
         return 0;
}

SEC("bpf__do_exit=do_exit")
int bpf__do_exit(void *ctx)
{
         int cpu = get_smp_processor_id();
         int key = __NR_CPUS__ * 2;
         u64 *p_total, total;

         struct {
                 u64 cycles;
                 u64 insns;
         } output;

         if (!basic_filter())
                 return 0;

         p_total = map_lookup_elem(&vals, &key);
         if (!p_total)
                 return 0;
         output.cycles = *p_total;

         key = __NR_CPUS__ * 2 + 1;
         p_total = map_lookup_elem(&vals, &key);
         if (!p_total)
                 return 0;
         output.insns = *p_total;

         bpf_perf_event_output(ctx, &output_channel, cpu, &output, 
sizeof(output));
         return 0;
}
