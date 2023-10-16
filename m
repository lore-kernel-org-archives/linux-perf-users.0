Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D47B28DD2
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Oct 2023 12:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDD0EB
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Oct 2023 05:01:03 -0700 (PDT)
Date: Mon, 16 Oct 2023 14:00:58 +0200
From: Guilherme Amadio <amadio@gentoo.org>
To: acme@kernel.org
Cc: linux-perf-users@vger.kernel.org
Subject: NMI received for unknown reason when running perf with IBS on AMD
Message-ID: <ZS0l-k1MASK3547Q@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Arnaldo,

I've been having a strange problem with perf when using IBS on an AMD
3950X processor. Whenever I use perf top or perf record with the default
event, which corresponds to cycles:P, I get these messages in dmesg output:

[443324.266243] Uhhuh. NMI received for unknown reason 3c on CPU 1.
[443324.266246] Dazed and confused, but trying to continue
[443324.290039] Uhhuh. NMI received for unknown reason 2c on CPU 9.
[443324.290042] Dazed and confused, but trying to continue
[443324.307334] Uhhuh. NMI received for unknown reason 3c on CPU 9.
[443324.307336] Dazed and confused, but trying to continue
[443324.404938] Uhhuh. NMI received for unknown reason 2c on CPU 9.
[443324.404940] Dazed and confused, but trying to continue

If I decrease the frequency I use for sampling, the messages also
decrease in frequency, but even with a low sampling frequency,
eventually they start to appear. Interestingly, if I use simply cycles
as the event, the problem does not happen. However, if I use cycles:pp
and a single CPU, it is less frequent, but does happen. Only CPUs used
for measurement show up in the error messages as well (i.e. if I
restrict to CPU 0, only CPU 0 shows in the messages above), and the more
CPUs I use, the more frequent the messages.

Please let me know how I could help to debug this problem further. The
output of perf record then perf report --header-only follows below,
along with perf version --build-options.

Best regards,
-Guilherme



$ perf report --header-only
# ========
# captured on    : Mon Oct 16 13:57:34 2023
# header version : 1
# data offset    : 664
# data size      : 884904
# feat offset    : 885568
# hostname : gentoo.cern.ch
# os release : 6.5.5-gentoo
# perf version : 6.5
# arch : x86_64
# nrcpus online : 16
# nrcpus avail : 16
# cpudesc : AMD Ryzen 9 3950X 16-Core Processor
# cpuid : AuthenticAMD,23,113,0
# total memory : 32748648 kB
# cmdline : /usr/bin/perf record -a -e cycles:pp -- sleep 1 
# event : name = cycles:pp, , id = { 809, 810, 811, 812, 813, 814, 815, 816, 817, 818, 819, 820, 821, 822, 823, 824 }, type = 0 (PERF_TYPE_HARDWARE), size = 136, config = 0 (PERF_COUNT_HW_CPU_CYCLES), { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|ID|CPU|PERIOD, read_format = ID, disabled = 1, inherit = 1, freq = 1, precise_ip = 2, sample_id_all = 1
# event : name = dummy:HG, , id = { 825, 826, 827, 828, 829, 830, 831, 832, 833, 834, 835, 836, 837, 838, 839, 840 }, type = 1 (PERF_TYPE_SOFTWARE), size = 136, config = 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|ID|CPU|PERIOD, read_format = ID, inherit = 1, mmap = 1, comm = 1, freq = 1, task = 1, sample_id_all = 1, mmap2 = 1, comm_exec = 1, ksymbol = 1, bpf_event = 1
# CPU_TOPOLOGY info available, use -I to display
# NUMA_TOPOLOGY info available, use -I to display
# pmu mappings: cpu = 4, amd_df = 13, software = 1, ibs_op = 12, power = 10, ibs_fetch = 11, uprobe = 9, amd_iommu_0 = 15, breakpoint = 5, amd_l3 = 14, tracepoint = 2, kprobe = 8, msr = 16
# CACHE info available, use -I to display
# time of first sample : 444374.952454
# time of last sample : 444375.960893
# sample duration :   1008.439 ms
# cpu pmu capabilities: max_precise=0
# missing features: TRACING_DATA BRANCH_STACK GROUP_DESC AUXTRACE STAT MEM_TOPOLOGY CLOCKID DIR_FORMAT COMPRESSED CLOCK_DATA HYBRID_TOPOLOGY 
# ========
#

$ perf version --build-options
perf version 6.5
                 dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
    dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
         syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
            debuginfod: [ OFF ]  # HAVE_DEBUGINFOD_SUPPORT
                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
               libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
             libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
    libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
             get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                   aio: [ on  ]  # HAVE_AIO_SUPPORT
                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
               libpfm4: [ on  ]  # HAVE_LIBPFM
         libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
