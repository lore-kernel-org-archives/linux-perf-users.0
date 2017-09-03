From: Ralph =?utf-8?B?QsO2aG1l?= <slow@samba.org>
Subject: Callgraphs split at the kernel boundary
Date: Sun, 3 Sep 2017 11:49:13 +0200
Message-ID: <20170903094913.ddk52e4zd44zz3vn@kazak>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from hr2.samba.org ([144.76.82.148]:52800 "EHLO hr2.samba.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751461AbdICJtR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 3 Sep 2017 05:49:17 -0400
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1doRWl-0001T3-GS
        for linux-perf-users@vger.kernel.org; Sun, 03 Sep 2017 09:49:15 +0000
Content-Disposition: inline
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi!

I'm noticing split callgraphs at the kernel boundary when recording callgraphs
with perf record. This happens with both DWARF and FP, eg

perf record -g --call-graph fp -p 3293, or
perf record -g --call-graph dwarf -p 3293

Here are two examples, sys_fcntl in perf script output:

DWARF:

smbd  3293 48551.772583:     250000 cpu-clock: 
            7fff8183eb75 _cond_resched ([kernel.kallsyms])
            7fff81264bfb locks_alloc_lock ([kernel.kallsyms])
            7fff812680a6 fcntl_setlk ([kernel.kallsyms])
            7fff81224182 sys_fcntl ([kernel.kallsyms])
            7fff81842a72 entry_SYSCALL_64_fastpath ([kernel.kallsyms])
            7f9aca651687 __libc_fcntl (/lib/x86_64-linux-gnu/libpthread-2.23.so)
            7f9ac407d032 fcntl_lock (/home/slow/git/samba/scratch/bin/default/lib/tdb/libtdb.so)

FP:

smbd  3293 48969.378250:     250000 cpu-clock: 
            7fff810c5b00 __init_waitqueue_head ([kernel.kallsyms])
            7fff812680a6 fcntl_setlk ([kernel.kallsyms])
            7fff81224182 sys_fcntl ([kernel.kallsyms])
            7fff81842a72 entry_SYSCALL_64_fastpath ([kernel.kallsyms])
                   10687 __libc_fcntl (/lib/x86_64-linux-gnu/libpthread-2.23.so)
                       c [unknown] ([unknown])
            556e17ea6470 [unknown] ([unknown])

I'm seeing this on different kernels and perf versions:

# uname -a && perf -v
Linux kazak 4.12.8-300.fc26.x86_64 #1 SMP Thu Aug 17 15:30:20 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
perf version 4.12.8.300.fc26.x86_64.ga6ba

# uname -a && perf -v
Linux titan 4.4.0-79-generic #100-Ubuntu SMP Wed May 17 19:58:14 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
perf version 4.4.67

Occasionally callgraphs are not split, but this seems to be the exception:

smbd 18113 298919.831823:     250000 cpu-clock: 
                  46e9a9 path_get (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux)
                  4605d5 do_dentry_open (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux)
                  461bfe vfs_open (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux)
                  473caf path_openat (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux)
                  475e8b do_filp_open (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux)
                  4620ea do_sys_open (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux)
                  46219e sys_open (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux)
                  a77737 entry_SYSCALL_64 (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux)
                   1189d [unknown] (/usr/lib64/libpthread-2.25.so)
                  1c51c6 dos_mode_check_compressed (/home/slow/git/samba/scratch/bin/default/source3/libsmbd-base-samba4.so)
                  1c5435 dos_mode (/home/slow/git/samba/scratch/bin/default/source3/libsmbd-base-samba4.so)
                  22a89d smbd_smb2_create_send (/home/slow/git/samba/scratch/bin/default/source3/libsmbd-base-samba4.so)
                  2269c4 smbd_smb2_request_process_create (/home/slow/git/samba/scratch/bin/default/source3/libsmbd-base-samba4.so)
                  219833 smbd_smb2_request_dispatch (/home/slow/git/samba/scratch/bin/default/source3/libsmbd-base-samba4.so)
                  21e974 smbd_smb2_io_handler (/home/slow/git/samba/scratch/bin/default/source3/libsmbd-base-samba4.so)
                  21ea7a smbd_smb2_connection_handler (/home/slow/git/samba/scratch/bin/default/source3/libsmbd-base-samba4.so)
                    f106 epoll_event_loop (/home/slow/git/samba/scratch/bin/default/lib/tevent/libtevent.so)
                    f73e epoll_event_loop_once (/home/slow/git/samba/scratch/bin/default/lib/tevent/libtevent.so)
                    c431 std_event_loop_once (/home/slow/git/samba/scratch/bin/default/lib/tevent/libtevent.so)
                    51b9 _tevent_loop_once (/home/slow/git/samba/scratch/bin/default/lib/tevent/libtevent.so)
                    54d4 tevent_common_loop_wait (/home/slow/git/samba/scratch/bin/default/lib/tevent/libtevent.so)
                    c4d3 std_event_loop_wait (/home/slow/git/samba/scratch/bin/default/lib/tevent/libtevent.so)
                    5577 _tevent_loop_wait (/home/slow/git/samba/scratch/bin/default/lib/tevent/libtevent.so)
                  200da1 smbd_process (/home/slow/git/samba/scratch/bin/default/source3/libsmbd-base-samba4.so)
                    dd24 smbd_accept_connection (/home/slow/git/samba/scratch/bin/default/source3/smbd/smbd)
                    f106 epoll_event_loop (/home/slow/git/samba/scratch/bin/default/lib/tevent/libtevent.so)
                    f73e epoll_event_loop_once (/home/slow/git/samba/scratch/bin/default/lib/tevent/libtevent.so)
                    c431 std_event_loop_once (/home/slow/git/samba/scratch/bin/default/lib/tevent/libtevent.so)
                    51b9 _tevent_loop_once (/home/slow/git/samba/scratch/bin/default/lib/tevent/libtevent.so)
                    54d4 tevent_common_loop_wait (/home/slow/git/samba/scratch/bin/default/lib/tevent/libtevent.so)
                    c4d3 std_event_loop_wait (/home/slow/git/samba/scratch/bin/default/lib/tevent/libtevent.so)
                    5577 _tevent_loop_wait (/home/slow/git/samba/scratch/bin/default/lib/tevent/libtevent.so)
                    eb27 smbd_parent_loop (/home/slow/git/samba/scratch/bin/default/source3/smbd/smbd)
                   10ce5 main (/home/slow/git/samba/scratch/bin/default/source3/smbd/smbd)
                   2050a __libc_start_main (/usr/lib64/libc-2.25.so)
        6e3e258d4c544155 [unknown] ([unknown])

The majority of callgraphs for sys_open is split as well:

smbd 18113 298923.760035:     250000 cpu-clock: 
                  3d7de6 file_ra_state_init (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux)
                  461bfe vfs_open (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux)
                  473caf path_openat (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux)
                  475e8b do_filp_open (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux)
                  4620ea do_sys_open (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux)
                  46219e sys_open (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux)
                  a77737 entry_SYSCALL_64 (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux)
                   1189d [unknown] (/usr/lib64/libpthread-2.25.so)
                     c70 [unknown] ([unknown])
              ee0000000b [unknown] ([unknown])
                      41 [unknown] ([unknown])

As a result overhead calcuation is split between userspace and kernel:
# perf report --stdio -g none

# To display the perf.data header info, please use --header/--header-only options.
#
# Total Lost Samples: 0
#
# Samples: 11K of event 'cpu-clock'
# Event count (approx.): 2754000000
#
# Children      Self  Command  Shared Object                Symbol                                       
# ........  ........  .......  ...........................  .....................
#
    54.73%     0.60%  smbd     [kernel.vmlinux]             [k] entry_SYSCALL_64e
    44.62%     0.09%  smbd     libtevent.so                 [.] epoll_event_loop
    44.62%     0.05%  smbd     libtevent.so                 [.] _tevent_loop_once

The following flamegraph shows this as well:

<https://www.samba.org/~slow/flamegraph-25453.svg>

Am I missing something? This renders CPU profiling with perf pretty useless for
my usecase with lots of syscalls.

Thanks!
-slow
