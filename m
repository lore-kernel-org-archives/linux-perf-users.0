Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12AAB640;
	Wed, 30 Apr 2025 02:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745978434; cv=none; b=e7WbYLE7OXW890LDfe7ekpbufQDXMgpYhX6DCcZdLZPAGarD3D75xjH6PdWFny2Kw+RpwA7Z0r3vT0xYL8aqVFCAhiCGfXqOBGeIFa+zTbFN2BeSgP9UyXcDQEoCjbCHQVMu9XJfMKNJ9Ir71JmY1IQIe5oQwetYJRMIE7CLXu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745978434; c=relaxed/simple;
	bh=w0w5lvrWyI2uESxm0saMYz1L0A7srJ9/pf0tn1Fa33s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGlsmGjiZ54wKLgflQDj/QAWPuEyc5UaRDpRICP9sIQCCB5R7RTZJxjUPKrvKSD8aItsdrrOHaBLGYEzbZbhlLJrNI1dr0eMCjlePbYxvNhx+eHWWhGCEVU1XffkZ3LVy1yDuLyqcO+aWf13I2X2UzWxOdjX7CH8BG3PtRbcRF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iI2aDARX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iI2aDARX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC40DC4CEE3;
	Wed, 30 Apr 2025 02:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745978433;
	bh=w0w5lvrWyI2uESxm0saMYz1L0A7srJ9/pf0tn1Fa33s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iI2aDARX5ZQkEr37KubOYVvroK3MzhXJZhArCsHHtnh/wmg4PLsD6dOS7SYW6/tFs
	 lDe0mm+BxkAOp73TFmiAYLutg28MhiOTwq4/5bBGSklJkJyVLeHGrYhvGWGZzK7ncn
	 cuRopzYUtplz0M6/GjoeQ5AVRi6UiD2tQ1B7eAasDNS8WVGSnJTBEeBovi7m0MuysN
	 3V/NQLermErVGhMNZEkgO/1XaB4tsu9ozHTCK1qtPhWf88zMuL248jCeeHawWLgYwd
	 iBajmazst/Bl8tWaXi905l2WKuWyxuEOL25bgY0EsbGKXjpON9TEbr7wzNd81z00By
	 u9JTxSJPgXyZA==
Date: Tue, 29 Apr 2025 23:00:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Mario <jmario@redhat.com>,
	Stephane Eranian <eranian@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: Re: [PATCH v4 0/4] perf/amd/ibs: Add Zen5 support (tools changes)
Message-ID: <aBGEPnB5B4NTaOg9@x1>
References: <20250429035938.1301-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250429035938.1301-1-ravi.bangoria@amd.com>

On Tue, Apr 29, 2025 at 03:59:34AM +0000, Ravi Bangoria wrote:
> IBS on Zen5:
> - Introduced Load Latency filtering capability.
> - Shows DTLB and page size information differently from prior generations.
> 
> Kernel changes for these enhancements are already upstream. So, resending
> tools changes separately.
> 
> Patches are prepared on perf-tools-next/perf-tools-next (85447f68a1e3).
> 
> v3: https://lore.kernel.org/r/20250205060547.1337-1-ravi.bangoria@amd.com
> v3->v4:
> - Remove kernel changes.
> - Improve IBS sample period unit test

Preliminary tests with what is in tmp.perf-tools-next:

root@number:~# perf mem record find / > /dev/null
[ perf record: Woken up 5 times to write data ]
[ perf record: Captured and wrote 1.992 MB perf.data (31824 samples) ]
root@number:~# perf mem report -s mem --stdio
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 31K of event 'ibs_op//'
# Total weight : 66561
# Sort order   : mem
#
# Overhead       Samples  Memory access                          
# ........  ............  .......................................
#
    36.51%           456  L2 hit                                 
    30.26%         20141  N/A                                    
    16.75%         11149  L1 hit                                 
    10.08%            18  RAM hit                                
     6.39%            52  L3 hit                                 
     0.01%             8  LFB/MAB hit                            
#
# (Tip: To collect Processor Trace with samples use perf record -e '{intel_pt//,cycles}' ; perf script --call-trace or --insn-trace --xed -F +ipc (remove --xed if no xed))
#
root@number:~#

root@number:~# perf evlist -v
ibs_op//: type: 11 (ibs_op), size: 136, config: 0, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|PERIOD|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, mmap_data: 1, sample_id_all: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
root@number:~# 

root@number:~# perf report --header-only | head -25
# ========
# captured on    : Tue Apr 29 22:54:04 2025
# header version : 1
# data offset    : 512
# data size      : 668520
# feat offset    : 669032
# hostname : number
# os release : 6.15.0-rc4+
# perf version : 6.15.rc2.g3e8278077117
# arch : x86_64
# nrcpus online : 32
# nrcpus avail : 32
# cpudesc : AMD Ryzen 9 9950X3D 16-Core Processor
# cpuid : AuthenticAMD,26,68,0
# total memory : 31928240 kB
# cmdline : /home/acme/bin/perf mem record find / 
# event : name = ibs_op//, , id = { 304, 305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335 }, type = 11 (ibs_op), size = 136, config = 0, { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|ADDR|PERIOD|DATA_SRC|WEIGHT_STRUCT, read_format = ID|LOST, disabled = 1, inherit = 1, mmap = 1, comm = 1, freq = 1, enable_on_exec = 1, task = 1, mmap_data = 1, sample_id_all = 1, mmap2 = 1, comm_exec = 1, ksymbol = 1, bpf_event = 1
# CPU_TOPOLOGY info available, use -I to display
# NUMA_TOPOLOGY info available, use -I to display
# pmu mappings: cpu = 4, amd_df = 12, amd_iommu_0 = 15, amd_l3 = 13, amd_umc_0 = 14, breakpoint = 5, hwmon_amdgpu = 4294901761, hwmon_k10temp = 4294901762, hwmon_nvme = 4294901760, hwmon_r8169_0_e00_00 = 4294901763, ibs_fetch = 10, ibs_op = 11, kprobe = 8, msr = 16, power = 17, power_core = 18, software = 1, tool = 4294967294, tracepoint = 2, uprobe = 9
# CACHE info available, use -I to display
# time of first sample : 244.312475
# time of last sample : 246.801803
# sample duration :   2489.328 ms
# MEM_TOPOLOGY info available, use -I to display
root@number:~#

root@number:~# perf report | head
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 9K of event 'ibs_op//'
# Event count (approx.): 12948758501
#
# Overhead  Command  Shared Object              Symbol                                  
# ........  .......  .........................  ........................................
root@number:~# perf report | head -20
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 9K of event 'ibs_op//'
# Event count (approx.): 12948758501
#
# Overhead  Command  Shared Object              Symbol                                  
# ........  .......  .........................  ........................................
#
     6.11%  find     [kernel.kallsyms]          [k] btrfs_bin_search
     4.91%  find     [kernel.kallsyms]          [k] filldir64
     4.77%  find     find                       [.] consider_visiting
     3.95%  find     [kernel.kallsyms]          [k] memcpy
     2.76%  find     [kernel.kallsyms]          [k] entry_SYSCALL_64
     2.59%  find     libc.so.6                  [.] __printf_buffer
     2.52%  find     [kernel.kallsyms]          [k] btrfs_getattr
     2.09%  find     [kernel.kallsyms]          [k] pid_delete_dentry
     1.88%  find     libc.so.6                  [.] msort_with_tmp.part.0
root@number:~#

root@number:~# perf annotate -v --stdio2 btrfs_bin_search
build id event received for [vdso]: 6dc5707510cc7434be3d6cb4dc6bae12881efda3 [20]
build id event received for /usr/bin/find: 3804e1e1214a39a975e093a79ec04961743ef5c5 [20]
build id event received for /usr/lib64/libc.so.6: 2b3c02fe7e4d3811767175b6f323692a10a4e116 [20]
build id event received for [kernel.kallsyms]: d391f0e79126801bc8a8f907e763de7979941712 [20]
Looking at the vmlinux_path (8 entries long)
Using /lib/modules/6.15.0-rc4+/build/vmlinux for symbols
read_gnu_debugdata: using .gnu_debugdata of /usr/bin/find
symbol__disassemble: filename=/lib/modules/6.15.0-rc4+/build/vmlinux, sym=btrfs_bin_search, start=0xffffffffac97e890, end=0xffffffffac97ead9
annotating [0x2e87fbf0] /lib/modules/6.15.0-rc4+/build/vmlinux : [0x2fa7f070]               btrfs_bin_search
Disassembled with llvm
Samples: 585  of event 'ibs_op//', 4000 Hz, Event count (approx.): 790819874, [percent: local period]
btrfs_bin_search() /lib/modules/6.15.0-rc4+/build/vmlinux
Percent       0xffffffff8197e890 <btrfs_bin_search>:
   0.17         endbr64         
              → callq   __fentry__
   0.16         pushq   %r15    
   0.18         movq    %rdx,%r15
                pushq   %r14    
                pushq   %r13    
   0.18         pushq   %r12    
   0.34         pushq   %rbp    
                movl    %esi,%ebp
                pushq   %rbx    
   0.35         movq    %rdi,%rbx
                subq    $0x48,%rsp
                movq    (%rdi),%r9
                movq    %rcx,(%rsp)
   0.34         movq    %r9,%rdx
                andl    $0xfff,%edx
                movq    __stack_chk_guard,%r14
   0.18         movq    %r14,0x40(%rsp)
   0.33         movl    %esi,%r14d
   0.17         movq    0x70(%rdi),%rsi
                movq    %rsi,%rax
                subq    vmemmap_base,%rax
                sarq    $0x6, %rax
   0.17         shlq    $0xc, %rax
   0.15         addq    page_offset_base,%rax
   0.17         addq    %rdx,%rax
                movl    0x60(%rax),%r13d
   0.17         cmpl    %ebp,%r13d
              → jb      btrfs_bin_search.cold
                cmpb    $0x1,0x64(%rax)
                sbbl    %r12d,%r12d
                andl    $-0x8,%r12d
   0.18         addl    $0x21,%r12d
                cmpl    %r13d,%r14d
              ↓ jae     20f     
   1.04   84:   leal    (%r14,%r13),%ebp
   0.81         movb    $0x0,0x3f(%rsp)
   1.20         movslq  0xc(%rbx),%r10
   0.66         movl    $0xfff,%r11d
   1.06         movq    $0x0,0x2f(%rsp)
   0.85         shrl    %ebp    
   1.35         movq    $0x0,0x37(%rsp)
   1.93         movl    %ebp,%eax
   1.04         movq    (%rsi),%rdx
   2.20         imull   %r12d,%eax
  10.77         cltq            
  10.26         addq    $0x65,%rax
   3.11         addq    %rax,%r9
   0.68         andl    $0x40,%edx
              ↓ je      e3      
                movq    0x40(%rsi),%rsi
                movl    $0x1000,%r11d
                movzbl  %sil,%ecx
                shlq    %cl, %r11
                subq    $0x1,%r11
root@number:~# 


I'll do more tests tomorrow and try some of the workloads that Joe uses.



Thanks a lot!

- Arnaldo
