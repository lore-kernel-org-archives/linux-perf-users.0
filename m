Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEFC381BB
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Oct 2023 21:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOvG+kjG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B22C433C7;
	Mon, 16 Oct 2023 21:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697492926;
	bh=3sz20l4oWtKoPMMJ0PrXLs5CqFgiQDNQwbjobEewSLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XOvG+kjGdBnVQbs98gTyxsAy+Bc0uV9cUSZD4Pcf+Sx8CZ+be+RXpzI919htG8tJ/
	 gWDks4dEQkm1NMaqSwAEXkbUjfOAROGm7geT/BVNfU9zvll4naeGeDueOEvtGn7CcJ
	 RUyxBkAYQ0dPr5dFje2s6hd9S2Owo/5YYoQW3LWPVnao2odWupK4GUN6hH3RgMWc+k
	 B+U4sYfqGe79H3pM9oKqbZGx0E0YmNd8ixD3OrpjbXW0d9QrmqStLfJVr33JmDuj8Q
	 1VSpQu1O1vfDg4nuIF9RWgWOzGqC/2vTptxPcv4QkWLBXPJHyzbuGN2VM2OQyg+Jth
	 /1Yx/p4ix8mSQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id D546C40016; Mon, 16 Oct 2023 18:48:43 -0300 (-03)
Date: Mon, 16 Oct 2023 18:48:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Guilherme Amadio <amadio@gentoo.org>
Cc: linux-perf-users@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: NMI received for unknown reason when running perf with IBS on AMD
Message-ID: <ZS2vu8bSBS1/zseZ@kernel.org>
References: <ZS0l-k1MASK3547Q@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZS0l-k1MASK3547Q@gentoo.org>
X-Url: http://acmel.wordpress.com

pointers:

Ravi: the max_precise for core/ibs, can you please see if I got it
right?

Em Mon, Oct 16, 2023 at 02:00:58PM +0200, Guilherme Amadio escreveu:
> Hi Arnaldo,
> 
> I've been having a strange problem with perf when using IBS on an AMD
> 3950X processor. Whenever I use perf top or perf record with the default
> event, which corresponds to cycles:P, I get these messages in dmesg output:
> 
> [443324.266243] Uhhuh. NMI received for unknown reason 3c on CPU 1.
> [443324.266246] Dazed and confused, but trying to continue
> [443324.290039] Uhhuh. NMI received for unknown reason 2c on CPU 9.
> [443324.290042] Dazed and confused, but trying to continue
> [443324.307334] Uhhuh. NMI received for unknown reason 3c on CPU 9.
> [443324.307336] Dazed and confused, but trying to continue
> [443324.404938] Uhhuh. NMI received for unknown reason 2c on CPU 9.
> [443324.404940] Dazed and confused, but trying to continue
> 
> If I decrease the frequency I use for sampling, the messages also
> decrease in frequency, but even with a low sampling frequency,
> eventually they start to appear. Interestingly, if I use simply cycles
> as the event, the problem does not happen. However, if I use cycles:pp
> and a single CPU, it is less frequent, but does happen. Only CPUs used
> for measurement show up in the error messages as well (i.e. if I
> restrict to CPU 0, only CPU 0 shows in the messages above), and the more
> CPUs I use, the more frequent the messages.
> 
> Please let me know how I could help to debug this problem further. The
> output of perf record then perf report --header-only follows below,
> along with perf version --build-options.
> 
> Best regards,
> -Guilherme
> 
> $ perf report --header-only
> # ========
> # captured on    : Mon Oct 16 13:57:34 2023
> # header version : 1
> # data offset    : 664
> # data size      : 884904
> # feat offset    : 885568
> # hostname : gentoo.cern.ch
> # os release : 6.5.5-gentoo

> # perf version : 6.5
> # arch : x86_64
> # nrcpus online : 16
> # nrcpus avail : 16
> # cpudesc : AMD Ryzen 9 3950X 16-Core Processor
> # cpuid : AuthenticAMD,23,113,0

So, testing on a Ryzen 9 5950X:

[root@five ~]# uname -a
Linux five 6.5.5-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Sun Sep 24 15:52:44 UTC 2023 x86_64 GNU/Linux

[root@five ~]# dmesg | grep -i nmi
[    0.059840] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.592555] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[root@five ~]#

When I ran with "perf top -e cycles:P' I got:

[19184.078663] perf: interrupt took too long (2539 > 2500), lowering kernel.perf_event_max_sample_rate to 78000
[19198.077425] perf: interrupt took too long (3206 > 3173), lowering kernel.perf_event_max_sample_rate to 62000

[root@five ~]# pidof perf
57383
[root@five ~]# gdb -p 57383
GNU gdb (GDB) Fedora Linux 13.2-5.fc38
Attaching to process 57383
[New LWP 57384]
[New LWP 57417]
[New LWP 57418]

[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".
0x00007f7144d2734d in poll () from /lib64/libc.so.6
(gdb) bt
#0  0x00007f7144d2734d in poll () from /lib64/libc.so.6
#1  0x000000000069f174 in fdarray__poll (fda=0x19c0aa0, timeout=100) at fd/array.c:138
#2  0x00000000006a4d55 in perf_evlist__poll (evlist=0x19c0a60, timeout=100) at evlist.c:370
#3  0x0000000000523171 in evlist__poll (evlist=0x19c0a60, timeout=100) at util/evlist.c:636
#4  0x000000000043d6f4 in __cmd_top (top=0x7ffc83ef4070) at builtin-top.c:1353
#5  0x000000000043f348 in cmd_top (argc=0, argv=0x7ffc83ef82b0) at builtin-top.c:1835
#6  0x000000000050462e in run_builtin (p=0xdf0dc0 <commands+384>, argc=3, argv=0x7ffc83ef82b0) at perf.c:322
#7  0x000000000050489d in handle_internal_command (argc=3, argv=0x7ffc83ef82b0) at perf.c:375
#8  0x00000000005049ec in run_argv (argcp=0x7ffc83ef80cc, argv=0x7ffc83ef80c0) at perf.c:419
#9  0x0000000000504cd9 in main (argc=3, argv=0x7ffc83ef82b0) at perf.c:535
(gdb) fr 2
#2  0x00000000006a4d55 in perf_evlist__poll (evlist=0x19c0a60, timeout=100) at evlist.c:370
370		return fdarray__poll(&evlist->pollfd, timeout);
(gdb) print perf_evlist__first(evlist)
$1 = (struct perf_evsel *) 0x19e86b0
(gdb) print evsel__name(perf_evlist__first(evlist))
$2 = 0x19e2a40 "cycles:P"
(gdb) print perf_evlist__first(evlist)->attr
$3 = {type = 0, size = 136, config = 0, {sample_period = 4000, sample_freq = 4000}, sample_type = 391, read_format = 20, disabled = 1, inherit = 1, pinned = 0, exclusive = 0, exclude_user = 0,
  exclude_kernel = 0, exclude_hv = 0, exclude_idle = 0, mmap = 1, comm = 1, freq = 1, inherit_stat = 0, enable_on_exec = 0, task = 1, watermark = 0, precise_ip = 2, mmap_data = 0, sample_id_all = 1,
  exclude_host = 0, exclude_guest = 0, exclude_callchain_kernel = 0, exclude_callchain_user = 0, mmap2 = 1, comm_exec = 1, use_clockid = 0, context_switch = 0, write_backward = 0, namespaces = 0, ksymbol = 1,
  bpf_event = 1, aux_output = 0, cgroup = 0, text_poke = 0, build_id = 0, inherit_thread = 0, remove_on_exec = 0, sigtrap = 0, __reserved_1 = 0, {wakeup_events = 0, wakeup_watermark = 0}, bp_type = 0, {
    bp_addr = 0, kprobe_func = 0, uprobe_path = 0, config1 = 0}, {bp_len = 0, kprobe_addr = 0, probe_offset = 0, config2 = 0}, branch_sample_type = 0, sample_regs_user = 0, sample_stack_user = 0, clockid = 0,
  sample_regs_intr = 0, aux_watermark = 0, sample_max_stack = 0, __reserved_2 = 0, aux_sample_size = 0, __reserved_3 = 0, sig_data = 0, config3 = 0}
(gdb) print perf_evlist__first(evlist)->attr.precise_ip
$4 = 2
(gdb)

So it seems to be using IBS:

[root@five ~]# dmesg | grep -w perf
[    0.740947] perf: AMD IBS detected (0x000003ff)
[    0.741476] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
[19184.078663] perf: interrupt took too long (2539 > 2500), lowering kernel.perf_event_max_sample_rate to 78000
[19198.077425] perf: interrupt took too long (3206 > 3173), lowering kernel.perf_event_max_sample_rate to 62000
[root@five ~]#

[root@five ~]# for handle in 0 1 2 ; do dmidecode --handle $handle ; done
# dmidecode 3.4
Getting SMBIOS data from sysfs.
SMBIOS 3.3.0 present.
Table at 0x000E8D60.

Handle 0x0000, DMI type 0, 26 bytes
BIOS Information
	Vendor: American Megatrends International, LLC.
	Version: F35d
	Release Date: 10/13/2021
	Address: 0xF0000
	Runtime Size: 64 kB
	ROM Size: 16 MB
	Characteristics:
		PCI is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		BIOS ROM is socketed
		EDD is supported
		Japanese floppy for NEC 9800 1.2 MB is supported (int 13h)
		Japanese floppy for Toshiba 1.2 MB is supported (int 13h)
		5.25"/360 kB floppy services are supported (int 13h)
		5.25"/1.2 MB floppy services are supported (int 13h)
		3.5"/720 kB floppy services are supported (int 13h)
		3.5"/2.88 MB floppy services are supported (int 13h)
		Print screen service is supported (int 5h)
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		USB legacy is supported
		BIOS boot specification is supported
		Targeted content distribution is supported
		UEFI is supported
	BIOS Revision: 5.17

# dmidecode 3.4
Getting SMBIOS data from sysfs.
SMBIOS 3.3.0 present.
Table at 0x000E8D60.

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Gigabyte Technology Co., Ltd.
	Product Name: X570 AORUS PRO
	Version: -CF
	Serial Number: Default string
	UUID: 032e02b4-0499-05e3-6906-f30700080009
	Wake-up Type: PCI PME#
	SKU Number: Default string
	Family: X570 MB

# dmidecode 3.4
Getting SMBIOS data from sysfs.
SMBIOS 3.3.0 present.
Table at 0x000E8D60.

Handle 0x0002, DMI type 2, 15 bytes
Base Board Information
	Manufacturer: Gigabyte Technology Co., Ltd.
	Product Name: X570 AORUS PRO
	Version: Default string
	Serial Number: Default string
	Asset Tag: Default string
	Features:
		Board is a hosting board
		Board is replaceable
	Location In Chassis: Default string
	Chassis Handle: 0x0003
	Type: Motherboard
	Contained Object Handles: 0

[root@five ~]#

> # total memory : 32748648 kB
> # cmdline : /usr/bin/perf record -a -e cycles:pp -- sleep 1 
> # event : name = cycles:pp, , id = { 809, 810, 811, 812, 813, 814, 815, 816, 817, 818, 819, 820, 821, 822, 823, 824 }, type = 0 (PERF_TYPE_HARDWARE), size = 136, config = 0 (PERF_COUNT_HW_CPU_CYCLES), { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|ID|CPU|PERIOD, read_format = ID, disabled = 1, inherit = 1, freq = 1, precise_ip = 2, sample_id_all = 1
> # event : name = dummy:HG, , id = { 825, 826, 827, 828, 829, 830, 831, 832, 833, 834, 835, 836, 837, 838, 839, 840 }, type = 1 (PERF_TYPE_SOFTWARE), size = 136, config = 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|ID|CPU|PERIOD, read_format = ID, inherit = 1, mmap = 1, comm = 1, freq = 1, task = 1, sample_id_all = 1, mmap2 = 1, comm_exec = 1, ksymbol = 1, bpf_event = 1
> # CPU_TOPOLOGY info available, use -I to display
> # NUMA_TOPOLOGY info available, use -I to display
> # pmu mappings: cpu = 4, amd_df = 13, software = 1, ibs_op = 12, power = 10, ibs_fetch = 11, uprobe = 9, amd_iommu_0 = 15, breakpoint = 5, amd_l3 = 14, tracepoint = 2, kprobe = 8, msr = 16
> # CACHE info available, use -I to display
> # time of first sample : 444374.952454
> # time of last sample : 444375.960893
> # sample duration :   1008.439 ms

Humm:

> # cpu pmu capabilities: max_precise=0

For me:

[root@five ~]# perf report --header-only | grep "cpu pmu capabilities"
# cpu pmu capabilities: max_precise=0
[root@five ~]#

this is weird for both machines, as:

static ssize_t max_precise_show(struct device *cdev,
                                  struct device_attribute *attr,
                                  char *buf)
{
        return snprintf(buf, PAGE_SIZE, "%d\n", x86_pmu_max_precise());
}

static DEVICE_ATTR_RO(max_precise);

static struct attribute *x86_pmu_caps_attrs[] = {
        &dev_attr_max_precise.attr,
        NULL
};

int x86_pmu_hw_config(struct perf_event *event)
{
        if (event->attr.precise_ip) {
                int precise = x86_pmu_max_precise();

                if (event->attr.precise_ip > precise)
                        return -EOPNOTSUPP;

                /* There's no sense in having PEBS for non sampling events: */
                if (!is_sampling_event(event))
                        return -EINVAL;
        }


[root@five ~]# cat /sys/devices/cpu/caps/max_precise
0
[root@five ~]#

Ravi, this probably is the max_precise for the "core" PMU, but the "ibs"
one, that gets used when :pp and :p (but not :ppp) is used, i.e. that:

+++ b/arch/x86/events/amd/core.c
@@ -374,7 +374,7 @@ static int amd_pmu_hw_config(struct perf_event *event)

        /* pass precise event sampling to ibs: */
        if (event->attr.precise_ip && get_ibs_caps())
-               return -ENOENT;
+               return forward_event_to_ibs(event);

Thing..

Shouldn't we have some sort of max_precise cap for IBS so that we could
use it and not have this confusing "max_precise=0" for the core PMU but
accept attr.precise_ip = 1 and 2?

> # missing features: TRACING_DATA BRANCH_STACK GROUP_DESC AUXTRACE STAT MEM_TOPOLOGY CLOCKID DIR_FORMAT COMPRESSED CLOCK_DATA HYBRID_TOPOLOGY 
> # ========
> #
> 
> $ perf version --build-options
> perf version 6.5
>                  dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
>     dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
>          syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
>                 libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
>             debuginfod: [ OFF ]  # HAVE_DEBUGINFOD_SUPPORT
>                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
>                libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
>                libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
>              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
>               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
>              libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
>              libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
>     libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
>                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
>                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
>              get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
>                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
>                    aio: [ on  ]  # HAVE_AIO_SUPPORT
>                   zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
>                libpfm4: [ on  ]  # HAVE_LIBPFM
>          libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT

⬢[acme@toolbox perf-tools-next]$ perf -vv
perf version 6.6.rc1.gcdfd9c216f54
                 dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
    dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
         syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT
            debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
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
         bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
⬢[acme@toolbox perf-tools-next]$
