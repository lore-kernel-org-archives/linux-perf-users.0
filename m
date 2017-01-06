From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: newbie question: tracing userspace call/return sequences
Date: Fri, 6 Jan 2017 16:23:12 -0300
Message-ID: <20170106192312.GQ27864@kernel.org>
References: <CAPfS4ZwrYePYFoNtf7GOvMpJKABY8ZdCf+MB+xc+Ksa7ubRATQ@mail.gmail.com>
 <87zij4nhvk.fsf@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937878AbdAFTXk (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Jan 2017 14:23:40 -0500
Content-Disposition: inline
In-Reply-To: <87zij4nhvk.fsf@firstfloor.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Christian Convey <christian.convey@gmail.com>, linux-perf-users@vger.kernel.org

Em Fri, Jan 06, 2017 at 10:49:35AM -0800, Andi Kleen escreveu:
> Christian Convey <christian.convey@gmail.com> writes:
> >
> > Any suggestions for a good/better way to pull this off?
> 
> Use the right tool for the job.
> 
> On Intel, use a Broadwell or Skylake or Goldmont and use processor trace.
> 
> perf record -e intel_pt//u foo
> perf script --itrace=cr

Does that already works while VT-x is in use?

[root@jouet ~]# grep "model name" /proc/cpuinfo 
model name	: Intel(R) Core(TM) i7-5600U CPU @ 2.60GHz
model name	: Intel(R) Core(TM) i7-5600U CPU @ 2.60GHz
model name	: Intel(R) Core(TM) i7-5600U CPU @ 2.60GHz
model name	: Intel(R) Core(TM) i7-5600U CPU @ 2.60GHz
[root@jouet ~]#

So Broadwell:

[root@jouet ~]# perf record -e intel_pt//u ls
Dockerfile  perf.data  perf.data.old
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.044 MB perf.data ]
[root@jouet ~]# perf script --itrace=cr
[root@jouet ~]# 

As soon as I stop a VM:

[root@jouet ~]# perf script --itrace=cr | wc -l
14644
[root@jouet ~]# perf script --itrace=cr | tail
  ls 6527 [3] 6255.381805: 1 branches:u: 7fd672d97ae0 __do_global_dtors_aux (/usr/lib64/libpthread-2.24.so) => 7fd673c2a18a _dl_fini (/usr/lib64/ld-2.24.so)
  ls 6527 [3] 6255.381805: 1 branches:u: 7fd673c2a1a6 _dl_fini (/usr/lib64/ld-2.24.so) => 7fd672da4da4 _fini (/usr/lib64/libpthread-2.24.so)
  ls 6527 [3] 6255.381805: 1 branches:u: 7fd672da4dac _fini (/usr/lib64/libpthread-2.24.so) => 7fd673c2a1a8 _dl_fini (/usr/lib64/ld-2.24.so)
  ls 6527 [3] 6255.381805: 1 branches:u: 7fd673c2a38e _dl_fini (/usr/lib64/ld-2.24.so) => 7fd673461410 __run_exit_handlers (/usr/lib64/libc-2.24.so)
  ls 6527 [3] 6255.381805: 1 branches:u: 7fd6734613b0 __run_exit_handlers (/usr/lib64/libc-2.24.so) => 7fd6734a5a30 _IO_cleanup (/usr/lib64/libc-2.24.so)
  ls 6527 [3] 6255.381805: 1 branches:u: 7fd6734a5a40 _IO_cleanup (/usr/lib64/libc-2.24.so) => 7fd6734a56e0 _IO_flush_all_lockp (/usr/lib64/libc-2.24.so)
  ls 6527 [3] 6255.381805: 1 branches:u: 7fd6734a594f _IO_flush_all_lockp (/usr/lib64/libc-2.24.so) => 7fd6734a5a45 _IO_cleanup (/usr/lib64/libc-2.24.so)
  ls 6527 [3] 6255.381805: 1 branches:u: 7fd6734a5b99 _IO_cleanup (/usr/lib64/libc-2.24.so) => 7fd6734613b3 __run_exit_handlers (/usr/lib64/libc-2.24.so)
  ls 6527 [3] 6255.381805: 1 branches:u: 7fd6734613be __run_exit_handlers (/usr/lib64/libc-2.24.so) => 7fd6734f3c30 _exit (/usr/lib64/libc-2.24.so)
  ls 6527 [3] 6255.381805: 1 branches:u: 7fd6734f3c66 _exit (/usr/lib64/libc-2.24.so) => 0 [unknown] ([unknown])
[root@jouet ~]# 

Using -F and callident it get even better :-)

[root@jouet ~]# perf script -F callindent,time,comm,pid,sym,ip,addr,flags,cpu --itrace=cr | head -40
  ls 6527 [3] 6255.380814: tr strt  _start                                0 [unknown] =>     7fd673c19cd0 _start
  ls 6527 [3] 6255.380814: tr end   _start                     7fd673c19cd0 _start =>                0 [unknown]
  ls 6527 [3] 6255.380817: tr strt  _start                                0 [unknown] =>     7fd673c19cd0 _start
  ls 6527 [3] 6255.380817: call         _dl_start              7fd673c19cd3 _start =>     7fd673c1dce0 _dl_start
  ls 6527 [3] 6255.380817: tr end       _dl_start              7fd673c1dcff _dl_start =>                0 [unknown]
  ls 6527 [3] 6255.380818: tr strt      _dl_start                         0 [unknown] =>     7fd673c1dcff _dl_start
  ls 6527 [3] 6255.380818: tr end       _dl_start              7fd673c1dd06 _dl_start =>                0 [unknown]
  ls 6527 [3] 6255.380822: tr strt      _dl_start                         0 [unknown] =>     7fd673c1dd06 _dl_start
  ls 6527 [3] 6255.380822: tr end       _dl_start              7fd673c1e0e0 _dl_start =>                0 [unknown]
  ls 6527 [3] 6255.380824: tr strt      _dl_start                         0 [unknown] =>     7fd673c1e0e0 _dl_start
  ls 6527 [3] 6255.380824: call             _dl_setup_hash     7fd673c1df03 _dl_start =>     7fd673c24c10 _dl_setup_hash
  ls 6527 [3] 6255.380824: return           _dl_setup_hash     7fd673c24c6d _dl_setup_hash =>     7fd673c1df08 _dl_start
  ls 6527 [3] 6255.380824: call             _dl_sysdep_start   7fd673c1df63 _dl_start =>     7fd673c32710 _dl_sysdep_start
  ls 6527 [3] 6255.380824: tr end           _dl_sysdep_start   7fd673c32743 _dl_sysdep_start =>                0 [unknown]
  ls 6527 [3] 6255.380827: tr strt          _dl_sysdep_start              0 [unknown] =>     7fd673c32743 _dl_sysdep_start
  ls 6527 [3] 6255.380827: call                 brk            7fd673c329d0 _dl_sysdep_start =>     7fd673c33890 brk
  ls 6527 [3] 6255.380827: syscall                             7fd673c33897 brk =>                0 [unknown]
  ls 6527 [3] 6255.380828: tr strt              brk                       0 [unknown] =>     7fd673c33899 brk
  ls 6527 [3] 6255.380828: return               brk            7fd673c338b2 brk =>     7fd673c329d5 _dl_sysdep_start
  ls 6527 [3] 6255.380828: call                 get_common_indeces.constprop.1            7fd673c32c2f _dl_sysdep_start =>     7fd673c325e0 get_common_indeces.constprop.1
  ls 6527 [3] 6255.380828: return               get_common_indeces.constprop.1            7fd673c326c3 get_common_indeces.constprop.1 =>     7fd673c32c34 _dl_sysdep_start
  ls 6527 [3] 6255.380828: call                 strlen                                    7fd673c32aed _dl_sysdep_start =>     7fd673c36400 strlen
  ls 6527 [3] 6255.380828: return               strlen                                    7fd673c36439 strlen =>     7fd673c32af2 _dl_sysdep_start
  ls 6527 [3] 6255.380828: call                 sbrk                                      7fd673c32afb _dl_sysdep_start =>     7fd673c338e0 sbrk
  ls 6527 [3] 6255.380828: return               sbrk                                      7fd673c3392e sbrk =>     7fd673c32b00 _dl_sysdep_start
  ls 6527 [3] 6255.380828: call                 dl_main                                   7fd673c32b2c _dl_sysdep_start =>     7fd673c1a9a0 dl_main
  ls 6527 [3] 6255.380828: call                     _dl_next_ld_env_entry                 7fd673c1aa6c dl_main =>     7fd673c33110 _dl_next_ld_env_entry
  ls 6527 [3] 6255.380828: return                   _dl_next_ld_env_entry                 7fd673c33150 _dl_next_ld_env_entry =>     7fd673c1aa71 dl_main
  ls 6527 [3] 6255.380828: call                     _dl_new_object                        7fd673c1ae4f dl_main =>     7fd673c24d50 _dl_new_object
  ls 6527 [3] 6255.380828: call                         strlen                            7fd673c24d77 _dl_new_object =>     7fd673c36400 strlen
  ls 6527 [3] 6255.380828: return                       strlen                            7fd673c36439 strlen =>     7fd673c24d7c _dl_new_object
  ls 6527 [3] 6255.380828: call                             7fd673c19ab0                  7fd673c24dd1 _dl_new_object =>     7fd673c19ab0 [unknown]
  ls 6527 [3] 6255.380828: return                       __libc_memalign                   7fd673c332a9 __libc_memalign =>     7fd673c24dd6 _dl_new_object
  ls 6527 [3] 6255.380828: call                         memmove                           7fd673c24e13 _dl_new_object =>     7fd673c36f20 memmove
  ls 6527 [3] 6255.380828: return                       memmove                           7fd673c36f56 memmove =>     7fd673c24e18 _dl_new_object
  ls 6527 [3] 6255.380828: return                   _dl_new_object                        7fd673c24fc8 _dl_new_object =>     7fd673c1ae54 dl_main
  ls 6527 [3] 6255.380828: call                     _dl_add_to_namespace_list             7fd673c1ae88 dl_main =>     7fd673c24cc0 _dl_add_to_namespace_list
  ls 6527 [3] 6255.380828: call                         rtld_lock_default_lock_recursive  7fd673c24cd1 _dl_add_to_namespace_list =>     7fd673c19d30 rtld_lock_default_lock_recursive
  ls 6527 [3] 6255.380828: return                       rtld_lock_default_lock_recursive  7fd673c19d34 rtld_lock_default_lock_recursive =>     7fd673c24cd7 _dl_add_to_namespace_list
  ls 6527 [3] 6255.380828: return                   rtld_lock_default_unlock_recursive    7fd673c19d44 rtld_lock_default_unlock_recursive =>     7fd673c1ae8d dl_main
[root@jouet ~]# 

- Arnaldo
