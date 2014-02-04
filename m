From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: Two questions on perf dwarf callchains
Date: Tue, 4 Feb 2014 16:35:26 +0100
Message-ID: <20140204153526.GE1117@krava.brq.redhat.com>
References: <1389954083.1125.23.camel@nb-andreolini.mat.unimo.it>
 <20140129111844.GA1869@krava.brq.redhat.com>
 <1391008146.1316.8.camel@nb-andreolini.mat.unimo.it>
 <20140130114751.GB1161@krava.brq.redhat.com>
 <1391092999.1111.3.camel@nb-andreolini.mat.unimo.it>
 <20140130154047.GB1827@krava.brq.redhat.com>
 <1391437856.1135.8.camel@nb-andreolini.mat.unimo.it>
 <1391527739.1174.16.camel@nb-andreolini.mat.unimo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53341 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751177AbaBDPfg (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 4 Feb 2014 10:35:36 -0500
Content-Disposition: inline
In-Reply-To: <1391527739.1174.16.camel@nb-andreolini.mat.unimo.it>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Mauro Andreolini <mauro.andreolini@unimore.it>
Cc: linux-perf-users@vger.kernel.org, Jean Pihet <jean.pihet@linaro.org>

On Tue, Feb 04, 2014 at 04:28:59PM +0100, Mauro Andreolini wrote:
> > /usr/lib/perl5/core_perl/CORE/hv_func.h:398:5: error: switch missing
> > default case [-Werror=switch-default]
> >      switch(bytes_in_carry) { /* how many bytes in carry */
> >      ^
> > cc1: all warnings being treated as errors
> > make: *** [util/scripting-engines/trace-event-perl.o] Errore 1
> I solved this one by applying this:
> https://lkml.org/lkml/2013/7/23/60
> 
> Wow! Unwinding is noticeably faster than libunwind! The trace is almost
> perfect. I think I found only one unresolved symbol (it's always the
> same one, maybe I screwed up the compilation):
> 
>      0.01%       ls  [kernel.kallsyms]  [k] do_raw_read_unlock
>                  |
>                  --- do_raw_read_unlock
>                      _raw_read_unlock
>                      0xffffffffa0154479 <--- HERE

hum, is there any symbol around that address?
you can check /proc/kallsyms or vmlinux file from debug package


>                      jbd2__journal_start
>                      __ext4_journal_start_sb
>                      ext4_dirty_inode
>                      __mark_inode_dirty
>                      update_time
>                      touch_atime
>                      sys_readlinkat
>                      sys_readlink
>                      system_call
>                      __GI___readlink
>                      get_link_name
>                      gobble_file
>                      print_dir
>                      main
>                      __libc_start_main
>                      _start
> 
> Is this going into mainline soon?

hopefully ;-) it's on review now..

thanks a lot for testing! please let us know any issues you spot

jirka
