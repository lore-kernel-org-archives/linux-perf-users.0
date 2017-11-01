From: Bram Stolk <b.stolk@gmail.com>
Subject: Re: Adding a recording delay interferes with symbols/call-stack
Date: Tue, 31 Oct 2017 21:36:20 -0700
Message-ID: <CABYXEktgnCoc7tTzeOaT-e=ggYPAVHRk=R2tc64NgCtphL1-aw@mail.gmail.com>
References: <CABYXEksdehm6S9-WGO6MV1wQaWHCsk-Ofp-sDaxY+qwQSNPp8Q@mail.gmail.com>
 <20171031142537.GT7045@kernel.org> <CABYXEktUSaLrT4Ajp17D4i93o1Sia+Jd5vpSAydEPNOw6nTFiA@mail.gmail.com>
 <20171031191411.GB3531@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:43581 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751185AbdKAEgW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Nov 2017 00:36:22 -0400
Received: by mail-vk0-f45.google.com with SMTP id t203so715537vke.0
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Oct 2017 21:36:21 -0700 (PDT)
In-Reply-To: <20171031191411.GB3531@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Thanks again, Arnaldo!


So, ugh, there is something wrong with either my system or my binary,
because the newly built perf has the exact same problem.

bram@ubuntu64:~/apps/BloxTrace$ perf -v
perf version 4.14.rc6.gadb243

bram@ubuntu64:~/apps/BloxTrace$ perf record --delay=3D1000 --freq 2000
--call-graph lbr ./bench
...
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.015 MB perf.data (37 samples) ]

bram@ubuntu64:~/apps/BloxTrace$ perf script
perf 20537 185854.082586:          1 cycles:uppp:
        ffffffff81844357 native_irq_return_iret ([kernel.kallsyms])

perf 20537 185854.082591:          1 cycles:uppp:
          78400200000009 [unknown] ([unknown])

perf 20537 185854.082593:         12 cycles:uppp:
        ffffffff81844357 native_irq_return_iret ([kernel.kallsyms])

perf 20537 185854.082595:        343 cycles:uppp:
        ffffffff81844357 native_irq_return_iret ([kernel.kallsyms])

perf 20537 185854.082597:      10499 cycles:uppp:
                  412280 [unknown] ([unknown])

perf 20537 185854.082603:     326186 cycles:uppp:
                  412110 [unknown] ([unknown])
                  40ada3 [unknown] ([unknown])

perf 20537 185854.082708:    3664038 cycles:uppp:
                  411ba0 [unknown] ([unknown])
                  412634 [unknown] ([unknown])
                  40ada3 [unknown] ([unknown])

perf 20537 185854.083857:    5403078 cycles:uppp:
                  412110 [unknown] ([unknown])
                  40ada3 [unknown] ([unknown])

perf 20537 185854.085554: 17592235560281 cycles:uppp:
                  412110 [unknown] ([unknown])
                  40ada3 [unknown] ([unknown])

perf 20537 185854.525567:    9346320 cycles:uppp:
                  412110 [unknown] ([unknown])
                  40ada3 [unknown] ([unknown])
                  40b303 [unknown] ([unknown])
                  401917 [unknown] ([unknown])
...


On Tue, Oct 31, 2017 at 12:14 PM, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
> Em Tue, Oct 31, 2017 at 10:10:28AM -0700, Bram Stolk escreveu:
>> Thanks for trying to reproduce, Arnaldo.
>>
>> But for me, it's not the kernel symbols that are missing: they are all
>> there, syscalls and stuff.
>> Just the app's symbols itself are missing.
>>
>> What happens if you try it on a binary you built locally, that spends
>> cycles in userspace?
>
> So, trying with 'perf trace' to do a system wide strace like session for =
the
> 'open' syscall, that will use DWARF callchains and go from userspace all =
the
> way to raw_syscalls:sys_enter/sys_exit, to check various setups to try to
> narrow down what may be broken:
>
> [root@jouet ~]# perf trace --max-stack 32 -e open
>    518.496 ( 0.049 ms): libvirtd/1171 open(filename: /proc/cpuinfo, mode:=
 IRUGO|IWUGO                       ) =3D 23
>                                        __open_nocancel (inlined)
>                                        __GI__IO_file_open (inlined)
>                                        __GI__IO_file_fopen (inlined)
>                                        __fopen_internal (/usr/lib64/libc-=
2.25.so)
>                                        virHostCPUGetInfo (/usr/lib64/libv=
irt.so.0.3002.1)
>                                        virCapabilitiesGetNodeInfo (/usr/l=
ib64/libvirt.so.0.3002.1)
>                                        virNodeGetInfo (/usr/lib64/libvirt=
.so.0.3002.1)
>                                        _init (/usr/sbin/libvirtd)
>                                        virNetServerProgramDispatch (/usr/=
lib64/libvirt.so.0.3002.1)
>                                        [0xffffaa7a2a4a8737] (/usr/sbin/li=
bvirtd)
>                                        [0xffff80b476e99f30] (/usr/lib64/l=
ibvirt.so.0.3002.1)
>                                        [0xffff80b476e992a7] (/usr/lib64/l=
ibvirt.so.0.3002.1)
>                                        start_thread (/usr/lib64/libpthrea=
d-2.25.so)
>                                        __GI___clone (inlined)
>    518.817 ( 0.022 ms): libvirtd/1171 open(filename: /sys/devices/system/=
cpu/present, mode: IFSOCK|ISGID|IXUSR|IRGRP|0x720b0000) =3D 24
>                                        [0xffff80b47aad198d] (/usr/lib64/l=
ibpthread-2.25.so)
>                                        virFileReadAll (/usr/lib64/libvirt=
.so.0.3002.1)
>                                        virFileReadValueBitmap (/usr/lib64=
/libvirt.so.0.3002.1)
>                                        virSysfsGetValueBitmap (/usr/lib64=
/libvirt.so.0.3002.1)
>                                        virHostCPUGetPresentBitmap (/usr/l=
ib64/libvirt.so.0.3002.1)
>                                        virHostCPUGetInfoPopulateLinux (/u=
sr/lib64/libvirt.so.0.3002.1)
>                                        virHostCPUGetInfo (/usr/lib64/libv=
irt.so.0.3002.1)
>                                        virCapabilitiesGetNodeInfo (/usr/l=
ib64/libvirt.so.0.3002.1)
>                                        virNodeGetInfo (/usr/lib64/libvirt=
.so.0.3002.1)
>                                        _init (/usr/sbin/libvirtd)
>                                        virNetServerProgramDispatch (/usr/=
lib64/libvirt.so.0.3002.1)
>                                        [0xffffaa7a2a4a8737] (/usr/sbin/li=
bvirtd)
>                                        [0xffff80b476e99f30] (/usr/lib64/l=
ibvirt.so.0.3002.1)
>                                        [0xffff80b476e992a7] (/usr/lib64/l=
ibvirt.so.0.3002.1)
>                                        start_thread (/usr/lib64/libpthrea=
d-2.25.so)
>                                        __GI___clone (inlined)
>
> --------------------------
>
> Seems to work, now using a CPU hog and sampling the most precise CPU "cyc=
les" hardware counter:
>
> # time perf record --call-graph=3Ddwarf stress --cpu 1 --timeout 10
> stress: info: [4690] dispatching hogs: 1 cpu, 0 io, 0 vm, 0 hdd
> stress: info: [4690] successful run completed in 10s
> [ perf record: Woken up 1288 times to write data ]
> [ perf record: Captured and wrote 321.915 MB perf.data (40001 samples) ]
>
> real    0m10.174s
> user    0m10.065s
> sys     0m0.244s
> #
> # perf evlist -v
> cycles:ppp: size: 112, { sample_period, sample_freq }: 4000, sample_type:=
 IP|TID|TIME|ADDR|CALLCHAIN|PERIOD|REGS_USER|STACK_USER|DATA_SRC, disabled:=
 1, inherit: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, prec=
ise_ip: 3, mmap_data: 1, sample_id_all: 1, exclude_guest: 1, exclude_callch=
ain_user: 1, mmap2: 1, comm_exec: 1, sample_regs_user: 0xff0fff, sample_sta=
ck_user: 8192
> #
>
> # perf report --stdio --dsos stress
>
> # To display the perf.data header info, please use --header/--header-only=
 options.
> #
> # dso: stress
> #
> # Total Lost Samples: 0
> #
> # Samples: 40K of event 'cycles:ppp'
> # Event count (approx.): 31368767617
> #
> # Children      Self  Command  Symbol
> # ........  ........  .......  ......................
> #
>     88.38%    14.59%  stress   [.] hogcpu
>             |
>             |--73.78%--hogcpu
>             |          |
>             |           --73.73%--rand
>             |                     |
>             |                      --73.71%--__random
>             |                                |
>             |                                 --40.58%--__random_r
>             |
>             |--13.00%--_start
>             |          __libc_start_main
>             |          main
>             |          hogcpu
>             |
>              --1.59%--0xbb7
>                        hogcpu
>
>     86.78%     0.00%  stress   [.] _start
>             |
>             ---_start
>                __libc_start_main
>                main
>                hogcpu
>                |
>                 --73.73%--rand
>                           |
>                            --73.71%--__random
>                                      |
>                                       --40.58%--__random_r
>
>     86.78%     0.00%  stress   [.] __libc_start_main
>             |
>             ---__libc_start_main
>                main
>                hogcpu
>                |
>                 --73.73%--rand
>                           |
>                            --73.71%--__random
>                                      |
>                                       --40.58%--__random_r
>
>     86.78%     0.00%  stress   [.] main
>             |
>             ---main
>                hogcpu
>                |
>                 --73.73%--rand
>                           |
>                            --73.71%--__random
>                                      |
>                                       --40.58%--__random_r
>
>      0.01%     0.01%  stress   [k] 0x000055ae24920bc9
>      0.00%     0.00%  stress   [k] 0x00007fba0ad15790
>      0.00%     0.00%  stress   [k] 0x00007fba0ad157e6
>      0.00%     0.00%  stress   [k] 0x00007fba0ad15770
>      0.00%     0.00%  stress   [k] 0x000055ae24920bcd
>      0.00%     0.00%  stress   [k] 0x00007fba0ad157a5
>      0.00%     0.00%  stress   [k] 0x00007fba0ad15c7d
>      0.00%     0.00%  stress   [k] 0x00007fba0ad15808
>
>
> #
> # (Tip: System-wide collection from all CPUs: perf record -a)
> #
>
> Also with 'perf script':
>
> <SNIP>
> stress  4691  1422.153895:     576462 cycles:ppp:
>                    3b946 __random_r (/usr/lib64/libc-2.25.so)
>                    3b7d1 __random (/usr/lib64/libc-2.25.so)
>                    3bc78 rand (/usr/lib64/libc-2.25.so)
>                     2bbc hogcpu (/usr/bin/stress)
>                     160c main (/usr/bin/stress)
>                    20509 __libc_start_main (/usr/lib64/libc-2.25.so)
>                     2ac9 _start (/usr/bin/stress)
>
> stress  4691  1422.154121:     582967 cycles:ppp:
>                    3b946 __random_r (/usr/lib64/libc-2.25.so)
>                    3b7d1 __random (/usr/lib64/libc-2.25.so)
>                    3bc78 rand (/usr/lib64/libc-2.25.so)
>                     2bbc hogcpu (/usr/bin/stress)
>                     160c main (/usr/bin/stress)
>                    20509 __libc_start_main (/usr/lib64/libc-2.25.so)
>                     2ac9 _start (/usr/bin/stress)
>
> stress  4691  1422.154349:     590924 cycles:ppp:
>                    3b93c __random_r (/usr/lib64/libc-2.25.so)
>                    3b7d1 __random (/usr/lib64/libc-2.25.so)
>                    3bc78 rand (/usr/lib64/libc-2.25.so)
>                     2bbc hogcpu (/usr/bin/stress)
>                     160c main (/usr/bin/stress)
>                    20509 __libc_start_main (/usr/lib64/libc-2.25.so)
>                     2ac9 _start (/usr/bin/stress)
> <SNIP>
>
>> Here is my output on my clang-built binary:
>
> I'll try as well with a clang built binary:
>
> [acme@jouet linux]$ make CC=3Dclang O=3D/tmp/build/perf -C tools/perf ins=
tall-bin
>
> I.e. will profile a perf binary built with clang:
>
> $ readelf -wi ~/bin/perf | grep DW_AT_producer | head -1
>     <c>   DW_AT_producer    : (indirect string, offset: 0x0): clang versi=
on 4.0.0 (http://llvm.org/git/clang.git f5be8ba13adc4ba1011a7ccd60c844bd604=
27c1c) (http://llvm.org/git/llvm.git efca1a37676f4cd276d947658cf90b0fb625ab=
fd)
> $
>
> # perf record -F 2000 --call-graph=3Ddwarf perf top
> [ perf record: Woken up 20 times to write data ]
> [ perf record: Captured and wrote 5.771 MB perf.data (694 samples) ]
> # perf report --dsos=3Dperf --no-children --stdio
> # To display the perf.data header info, please use --header/--header-only=
 options.
> #
> # dso: perf
> #
> # Total Lost Samples: 0
> #
> # Samples: 694  of event 'cycles:ppp'
> # Event count (approx.): 889028447
> #
> # Overhead  Command  Symbol
> # ........  .......  ......................................
> #
>      4.77%  perf     [.] rb_next
>             |
>             ---rb_next
>                |
>                |--3.15%--map_groups__fixup_overlappings
>                |          thread__insert_map
>                |          machine__process_mmap2_event
>                |          machine__process_event
>                |          perf_event__process
>                |          perf_event__synthesize_mmap_events
>                |          0xffffffffffffffff
>                |
>                 --1.12%--map__next
>                           map_groups__find_by_name
>                           map_groups__set_modules_path_dir
>                           map_groups__set_modules_path_dir
>                           0xffffffffffffffff
>
>      2.69%  perf     [.] map_groups__fixup_overlappings
>             |
>             ---map_groups__fixup_overlappings
>                thread__insert_map
>                machine__process_mmap2_event
>                machine__process_event
>                perf_event__process
>                perf_event__synthesize_mmap_events
>                0xffffffffffffffff
>
>      1.36%  perf     [.] rb_erase
>             |
>             ---rb_erase
>                symbols__delete
>                dso__delete
>                dso__put
>                |
>                 --1.18%--map__put
>                           __map__zput (inlined)
>                           hist_entry__delete
>                           hists_evsel__exit
>                           perf_evsel__exit
>                           perf_evsel__delete
>                           perf_evlist__purge (inlined)
>                           perf_evlist__delete
>                           cmd_top
>                           0xffffffffffffffff
>
> Also seems to work.
>
> Can you try building the latest codebase, that I'm putting at:
>
> [acme@jouet linux]$ rm -f perf-4.14.0-rc6.tar.xz
> [acme@jouet linux]$ make help | grep perf
>   perf-tar-src-pkg    - Build perf-4.14.0-rc6.tar source tarball
>   perf-targz-src-pkg  - Build perf-4.14.0-rc6.tar.gz source tarball
>   perf-tarbz2-src-pkg - Build perf-4.14.0-rc6.tar.bz2 source tarball
>   perf-tarxz-src-pkg  - Build perf-4.14.0-rc6.tar.xz source tarball
> [acme@jouet linux]$ make perf-tarxz-src-pkg
>   TAR
>   PERF_VERSION =3D 4.14.rc6.gadb243
> [acme@jouet linux]$ ls -lart perf-4*
> -rw-rw-r--. 1 acme acme 1252444 Oct 31 16:06 perf-4.14.0-rc6.tar.xz
> [acme@jouet linux]$
>
> http://vger.kernel.org/~acme/perf/perf-4.14.0-rc6.tar.xz
>
> Download it and try building it:
>
> $ mkdir /tmp/perf
> $ cd /tmp/perf
> $ wget http://vger.kernel.org/~acme/perf/perf-4.14.0-rc6.tar.xz
> $ tar xf perf-4.14.0-rc6.tar.xz
> $ cd perf-4.14.0-rc6
> $ make -C tools/perf install-bin
>
> Then make sure your ~/bin/ directory is in the path and try your workload=
s to
> see if there was some fix that addresses the problems you're experiencing=
.
>
> - Arnaldo



--=20
Owner/Director of Game Studio Abraham Stolk Inc.
Vancouver BC, Canada
b.stolk@gmail.com
