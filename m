From: Mauro Andreolini <mauro.andreolini@gmail.com>
Subject: Re: Two questions on perf dwarf callchains
Date: Wed, 29 Jan 2014 16:09:06 +0100
Message-ID: <1391008146.1316.8.camel@nb-andreolini.mat.unimo.it>
References: <1389954083.1125.23.camel@nb-andreolini.mat.unimo.it>
	 <20140129111844.GA1869@krava.brq.redhat.com>
Reply-To: mauro.andreolini@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:56765 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150AbaA2PJK (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 29 Jan 2014 10:09:10 -0500
Received: by mail-wg0-f48.google.com with SMTP id x13so3721004wgg.3
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jan 2014 07:09:09 -0800 (PST)
In-Reply-To: <20140129111844.GA1869@krava.brq.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-perf-users@vger.kernel.org

Il giorno mer, 29/01/2014 alle 12.18 +0100, Jiri Olsa ha scritto:
> this one could be caused by:
> http://marc.info/?l=linux-kernel&m=134934717011451&w=2
> I never managed to push this change through.. need to revisit it ;-)
> 
> if you want to try, I rebased the patch and put it in here:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   branch perf/rsp_fix1
> 
>   commit:
>   https://git.kernel.org/cgit/linux/kernel/git/jolsa/perf.git/commit/?h=perf/rsp_fix1&id=5eed39431f9b1e65e740a2e3e197c79f0a1bcf6b
> 
> it still fixies some of the backtraces for me
Hi, the patch improves things considerably. However, I still get several
"0x0" on top of the _start() function, e.g.:

    15.79%       ls  [kernel.kallsyms]  [k]
_raw_spin_unlock_irqrestore        
                 |
                 --- _raw_spin_unlock_irqrestore
                    |          
                    |--33.33%-- console_unlock
                    |          con_write
                    |          n_tty_write
                    |          tty_write
                    |          vfs_write
                    |          sys_write
                    |          system_call
                    |          __GI___libc_write
                    |          _IO_file_write@@GLIBC_2.2.5
                    |          new_do_write
                    |          _IO_do_write@@GLIBC_2.2.5
                    |          _IO_file_overflow@@GLIBC_2.2.5
                    |          print_many_per_line
                    |          print_current_files
                    |          print_dir
                    |          main
                    |          __libc_start_main
                    |          _start
                    |          0x0     <---- HERE

I also get an occasional screw in the dynamic linker code path:

     5.26%       ls  [kernel.kallsyms]  [k]
lock_release                       
                 |
                 --- lock_release
                     __mem_cgroup_try_charge
                     mem_cgroup_charge_common
                     mem_cgroup_newpage_charge
                     do_wp_page
                     handle_mm_fault
                     __do_page_fault
                     do_page_fault
                     do_async_page_fault
                     async_page_fault
                     __init_cpu_features
                     0x7fd2357470de   <---- HERE
                     _dl_relocate_object
                     dl_main
                     _dl_sysdep_start
                     _dl_start
                     _dl_start_user

and in the exit() path:

     5.26%       ls  [kernel.kallsyms]  [k]
do_raw_spin_trylock                
                 |
                 --- do_raw_spin_trylock
                     unmap_single_vma
                     unmap_vmas
                     exit_mmap
                     mmput
                     do_exit
                     do_group_exit
                     0xffffffff81068184
                     system_call

Other than that, it looks perfect. Thanks a lot!

Mauro
