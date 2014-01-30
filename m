From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: Two questions on perf dwarf callchains
Date: Thu, 30 Jan 2014 12:47:51 +0100
Message-ID: <20140130114751.GB1161@krava.brq.redhat.com>
References: <1389954083.1125.23.camel@nb-andreolini.mat.unimo.it>
 <20140129111844.GA1869@krava.brq.redhat.com>
 <1391008146.1316.8.camel@nb-andreolini.mat.unimo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:2838 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752646AbaA3Lr4 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 30 Jan 2014 06:47:56 -0500
Content-Disposition: inline
In-Reply-To: <1391008146.1316.8.camel@nb-andreolini.mat.unimo.it>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Mauro Andreolini <mauro.andreolini@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Wed, Jan 29, 2014 at 04:09:06PM +0100, Mauro Andreolini wrote:
> Il giorno mer, 29/01/2014 alle 12.18 +0100, Jiri Olsa ha scritto:

SNIP

>                     |          new_do_write
>                     |          _IO_do_write@@GLIBC_2.2.5
>                     |          _IO_file_overflow@@GLIBC_2.2.5
>                     |          print_many_per_line
>                     |          print_current_files
>                     |          print_dir
>                     |          main
>                     |          __libc_start_main
>                     |          _start
>                     |          0x0     <---- HERE

zero's are taken care by:
http://marc.info/?t=138909914500003&r=1&w=2
within following patchset:
http://marc.info/?l=linux-kernel&m=138909914404574&w=2

which implements libdw dwarf unwind.. you might
actualy want to try it, it seems to be little faster
than libunwind unwinder

> 
> I also get an occasional screw in the dynamic linker code path:
> 
>      5.26%       ls  [kernel.kallsyms]  [k]
> lock_release                       
>                  |
>                  --- lock_release
>                      __mem_cgroup_try_charge
>                      mem_cgroup_charge_common
>                      mem_cgroup_newpage_charge
>                      do_wp_page
>                      handle_mm_fault
>                      __do_page_fault
>                      do_page_fault
>                      do_async_page_fault
>                      async_page_fault
>                      __init_cpu_features
>                      0x7fd2357470de   <---- HERE

not sure if that's just untranslatable part (.plt .got?)
or an error.. need to be checked some day ;-)

jirka
