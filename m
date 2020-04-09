From: Andreas Gerstmayr <agerstmayr@redhat.com>
Subject: Re: [PATCH] perf script: add flamegraph.py script
Date: Thu, 9 Apr 2020 19:14:46 +0200
Message-ID: <2b09f863-beaf-7a00-6754-4334d21fc029@redhat.com>
References: <20200320151355.66302-1-agerstmayr@redhat.com>
 <20200406151118.GC32649@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200406151118.GC32649@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Martin Spier <mspier@netflix.com>, Brendan Gregg <bgregg@netflix.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Hi Arnaldo,

thanks for merging!

On 06.04.20 17:11, Arnaldo Carvalho de Melo wrote:
> It works then, so I'll add a note to that effect. But please consider
> fixing it so that it works with both python2 and python3, if possible,
> or to fail gracefully and state that only python3 is supported and that
> perf should be built with "PYTHON=python3" on the make command line.

Ok, I just sent a patch (based on your perf/core branch) to add Python 2 
support. I hope soon Python 2 support won't be required anymore ;)

> Some RFEs for you to consider:
> 
> 1. make:
> 
>     perf flamegraph -a -F 99 sleep 1
 >
 > be equivalent, should be easy.

`perf flamegraph -a -F 99 sleep 1` should be equivalent to `perf script 
flamegraph -a -F 99 sleep 1`?
Or in other words, flamegraph should be a top-level command of perf, and 
run the flamegraph.py script?

> 2. make the command somehow create a new tab on an existing browser with
> the generated file, and switch the focus to that tab.

As a personal preference I don't like programs interfering with my 
browser session. For example I have a flame graph open in a tab, then I 
generate another one (overwriting the current file), I would not want 
another tab to open with the new flame graph, but instead I want to 
manually refresh the currently open tab.

> 3. get whats in:
> 
> [root@five ~]# perf report --header-only
> # ========
> # captured on    : Mon Apr  6 12:02:52 2020
> # header version : 1
> # data offset    : 336
> # data size      : 1173584
> # feat offset    : 1173920
> # hostname : five
> # os release : 5.5.10-200.fc31.x86_64
> # perf version : 5.6.gb6b7dc6ec0c8
> # arch : x86_64
> # nrcpus online : 12
> # nrcpus avail : 12
> # cpudesc : AMD Ryzen 5 3600X 6-Core Processor
> # cpuid : AuthenticAMD,23,113,0
> # total memory : 32890748 kB
> # cmdline : /home/acme/bin/perf record -a -g -F 99 sleep 1
> # event : name = cycles, , id = { 2918625, 2918626, 2918627, 2918628, 2918629, 2918630, 2918631, 2918632, 2918633, 2918634, 2918635, 2918636 }, size = 120, { sample_period, sample_freq } = 99, sample_type = IP|TID|TIME|CALLCHAIN|CPU|PERIOD, read_format = ID, disabled = 1,>
> # CPU_TOPOLOGY info available, use -I to display
> # NUMA_TOPOLOGY info available, use -I to display
> # pmu mappings: amd_df = 8, software = 1, ibs_op = 11, ibs_fetch = 10, uprobe = 7, cpu = 4, amd_iommu_0 = 12, breakpoint = 5, amd_l3 = 9, tracepoint = 2, kprobe = 6, msr = 13
> # CACHE info available, use -I to display
> # time of first sample : 87600.831767
> # time of last sample : 87601.096829
> # sample duration :    265.062 ms
> # MEM_TOPOLOGY info available, use -I to display
> # bpf_prog_info 40: bpf_prog_6deef7357e7b4530 addr 0xffffffffc030650c size 66
> # bpf_prog_info 41: bpf_prog_6deef7357e7b4530 addr 0xffffffffc03080e8 size 66
> # bpf_prog_info 42: bpf_prog_6deef7357e7b4530 addr 0xffffffffc030a218 size 66
> # bpf_prog_info 43: bpf_prog_6deef7357e7b4530 addr 0xffffffffc036c698 size 66
> # bpf_prog_info 44: bpf_prog_5a2b06eab81b8f51 addr 0xffffffffc036e2c0 size 1132
> # bpf_prog_info 45: bpf_prog_6deef7357e7b4530 addr 0xffffffffc06e7118 size 66
> # bpf_prog_info 46: bpf_prog_6deef7357e7b4530 addr 0xffffffffc06e9cd8 size 66
> # bpf_prog_info 47: bpf_prog_f3b9e166f6c1aaaa addr 0xffffffffc089732c size 1786
> # bpf_prog_info 48: bpf_prog_6deef7357e7b4530 addr 0xffffffffc0dcb64c size 66
> # bpf_prog_info 49: bpf_prog_6deef7357e7b4530 addr 0xffffffffc0dcd0fc size 66
> # bpf_prog_info 50: bpf_prog_6deef7357e7b4530 addr 0xffffffffc0f4d8dc size 66
> # bpf_prog_info 51: bpf_prog_6deef7357e7b4530 addr 0xffffffffc0f4fc7c size 66
> # bpf_prog_info 52: bpf_prog_84efc2eecc454ca6 addr 0xffffffffc0f6e584 size 373
> # missing features: TRACING_DATA BRANCH_STACK GROUP_DESC AUXTRACE STAT CLOCKID DIR_FORMAT COMPRESSED
> # ========
> #
> [root@five ~]#
> 
> And make it available in some UI element.

Good idea!
I'll implement this with the next set of flame graph template changes.


Thanks,
Andreas
