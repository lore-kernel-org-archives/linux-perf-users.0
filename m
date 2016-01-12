From: "Wangnan (F)" <wangnan0@huawei.com>
Subject: Re: linux 4.4, perf & BPF, and bpf_perf_event_output
Date: Tue, 12 Jan 2016 10:36:41 +0800
Message-ID: <569466B9.2040702@huawei.com>
References: <CAE40pde1XCYDCRXgThopk_wiDN_yw26BWLGgL4iaFnkWCkpW-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:20735 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933349AbcALChS (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 11 Jan 2016 21:37:18 -0500
In-Reply-To: <CAE40pde1XCYDCRXgThopk_wiDN_yw26BWLGgL4iaFnkWCkpW-Q@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Brendan Gregg <brendan.d.gregg@gmail.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>, Alexei Starovoitov <ast@plumgrid.com>



On 2016/1/12 8:07, Brendan Gregg wrote:
> G'Day,
>
> Congrats Wang Nan on the new perf bpf features in 4.4! I just
> revisited where I was at with them now that it's official, and have a
> couple of questions.
>
> So I can run something like this:
>
> ---syncsnoop.c---
> /* perf.data: default event record only; trace_pipe:
> bpf_trace_printk() output */
> #include <uapi/linux/bpf.h>
> #include "bpf_helpers.h"
>
> SEC("func=sys_sync")
> int bpf_func__sys_sync(void *ctx)
> {
>      char fmt[] = "sync()\n";
>      bpf_trace_printk(fmt, sizeof (fmt));
>      return 1;
> };
>
> char _license[] SEC("license") = "GPL";
> int _version SEC("version") = LINUX_VERSION_CODE;
> ------
>
> With: perf record -a --clang-opt "-DLINUX_VERSION_CODE=0x40400"
> --event syncsnoop.c sleep 5
>
> And it works. I get PERF_RECORD_SAMPLE entries in perf.data, and my
> custom strings in /sys/kernel/debug/tracing/trace_pipe.
>
> Q1. Given bpf_trace_printk() & trace_pipe is a hack, is there a way
> yet to print my custom strings to perf.data? Eg, something like
> bpf_perf_event_output() to change the format string of the event.
> Currently I just get:
>
> # perf script
>              sync 30207 [002]  2509.576984: perf_bpf_probe:func:
> (ffffffff81221b20)
>              sync 30209 [003]  2509.766632: perf_bpf_probe:func:
> (ffffffff81221b20)
>              sync 30229 [003]  2509.936299: perf_bpf_probe:func:
> (ffffffff81221b20)
>              sync 30230 [004]  2510.099059: perf_bpf_probe:func:
> (ffffffff81221b20)
>              sync 30231 [004]  2510.289351: perf_bpf_probe:func:
> (ffffffff81221b20)
Yes. I have implemented this feature. Patch has posted, but not
in 4.4. I hope you will be able to use this feature in v4.5.
It depends on Arnaldo.

There is a small example at commit message of [1]. The basic workflow is:

  1. Create a bpf-output map in your BPF file
  2. Output data to it by bpf_perf_event_output in BPF source
  3. Create bpf-output event in perf cmdline
  4. Use perf-CTF conversion
  5. User babeltrace to see your output in raw format
  6. Use python script for decoding

Currently you are unable to see string in normal 'perf script' output.
I sent a mail for suggestion about perf script output format in [2]
at Oct. 28. Please check your mailbox.

At the end of this mail I provide some detail description.

[1] 
http://lkml.kernel.org/g/1452520124-2073-26-git-send-email-wangnan0@huawei.com
[2] http://lkml.kernel.org/g/5630AC2A.7030308@huawei.com

> Q2. Apart from per-event strings, is there a way to emit the maps?
> bpf-script-example.c populates a map, but I don't think it ends up in
> perf.data. I think a common case would be to emit it once for the run.
> Another common case would be to emit it once per second. Any way we
> can do this? I did try bpf_perf_event_output(), but I don't think it
> ended up in perf.data (at least, I don't see it using "perf script
> -D").

Not support yet. Map data don't go to 'perf.data' at all. But I have
another idea.

I'm thinking about linking user-mode BPF into perf, then we can put all
things together into one BPF source, including:

data sampling, filtering, accumulation, pretty-printing

makes it similar to dtrace.

Here's an example. In this example we dump a perf.data output when
we found a write system call takes longer than expected (in my recent
patch series perf can act as a flight recorder), then print the
map data we collected during recording.

/* Define message passed between BPF script and perf */
enum perf_cmd {
   DUMP,
}
enum perf_cmd cmd;

/* define histogram map */
SEC("map")
struct bpf_map_def hist_map = { ... };

SEC("func=sys_write")
int sys_write_enter(...) {  }

SEC("func=sys_write%return")
int sys_write_exit(...) {
   enum perf_cmd cmd;

   /* check how long this syscall takes */
   /* maintain histogram */
   if (syscall_too_long) {
     cmd = DUMP;
     bpf_perf_event_output(..., &cmd, ...);   <-- trigger a dump
   }
}

/* Following are user mode BPF scripts which are run in perf context */

SEC("mode=perf;action=recv_bpf_msg")
int perf_recv_bpf_msg(void *pcmd)
{
    ...
    switch (*pcmd) {
      ...
      case DUMP:
        /* make perf dump a perf.data. */
        perf_hist_output(&hist_map);  /* let perf output histogram */
        ...
    }
}

SEC("mode=perf;action=perf_end")
int perf_end(...)
{
   print_the_final_result(&hist_map);
   ...
}

Thank you.

> thanks,
>
> Brendan

Ddetail description about perf event output:

First, you need create a bpf-output map in your BPF file:

  struct bpf_map_def SEC("maps") channel = {
      .type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
      .key_size = sizeof(int),
      .value_size = sizeof(u32),
      .max_entries = __NR_CPUS__,
  };

Then you output data to it by bpf_perf_event_output (this is its name in 
samples/bpf/bpf_helper.h. In my
commit message it is perf_event_output):

  SEC("func=sys_write")
  int bpf_func__sys_write(void *ctx)
  {
      char fmt[] = "write()\n";
      bpf_perf_event_output(ctx, &channel,
                            bpf_get_smp_processor_id(),
                            fmt, sizeof (fmt));
      return 1;
  };

When running perf you need create the channel for it by opening a 
bpf-output event and connect it with
'channel' map you defined in your BPF source file:

# perf record -e evt=bpf-output/no-inherit/ -e 
./test.c/maps:channel.event=evt/ ls

Then in perf.data you will see two samples, one is the function you 
probe in (sys_write), another is the
BPF output.

# perf script
               ls 32115 1009664.006228: evt=bpf-output/no-inherit/: 
ffffffff811fcac1 sys_write ([kernel.kallsyms])
               ls 32115 [002] 1009664.006229: perf_bpf_probe:func: 
(ffffffff811fcac0)

You can't see the string you output now, because perf script doesn't support
decoding data you passed through bpf-output event. Now you can see your
string by perf script by 'perf script -D' like this:

  . ... raw event: size 56 bytes
  .  0000:  09 00 00 00 01 00 38 00 01 16 00 00 00 00 00 00 ......8.........
  .  0010:  c1 ca 1f 81 ff ff ff ff 73 7d 00 00 73 7d 00 00 ........s}..s}..
  .  0020:  bb 09 6f b8 48 96 03 00 0c 00 00 00 77 72 69 74 
..o.H.......writ      <--- *HERE*
  .  0030:  65 28 29 0a 00 00 00 00                          e().....
  .
  4294967295 1009664006228411 0x2ed0 [0x38]: PERF_RECORD_SAMPLE(IP, 
0x1): 32115/32115: 0xffffffff811fcac1 period: 1 addr: 0
   ... thread: ls:32115
   ...... dso: 
/home/wangnan/.debug/.build-id/fb/0f83d011364583af77e563a390dfc1b78cce8d
                ls 32115 1009664.006228: evt=bpf-output/no-inherit/: 
ffffffff811fcac1 sys_write ([kernel.kallsyms])

For me, I prefer CTF conversion:

  # ~/perf data convert --to-ctf ./out.ctf
  [ perf data convert: Converted 'perf.data' into CTF data './out.ctf' ]
  [ perf data convert: Converted and wrote 0.000 MB (2 samples) ]
  # babeltrace ./out.ctf/
  [16:27:44.006228411] (+?.?????????) evt=bpf-output/no-inherit/: { 
cpu_id = 0 }, { perf_ip = 0xFFFFFFFF811FCAC1, perf_tid = 32115, perf_pid 
= 32115, perf_id = 5633,  raw_len = 3, raw_data = [ [0] = 0x74697277, 
[1] = 0xA292865, [2] = 0x0 ] }
  [16:27:44.006229678] (+0.000001267) perf_bpf_probe:func: { cpu_id = 2 
}, { perf_ip = 0xFFFFFFFF811FCAC1, perf_tid = 32115, perf_pid = 32115, 
perf_id = 5641, perf_period = 1, common_type = 1177, common_flags = 1, 
common_preempt_count = 0, common_pid = 32115, _probe_ip = 
0xFFFFFFFF811FCAC0 }

Your string is there:

  raw_data = [ [0] = 0x74697277, [1] = 0xA292865, [2] = 0x0 ] }

Still not good, but don't forget we have babeltrace python binding. A
simple python script can decode it for you.
