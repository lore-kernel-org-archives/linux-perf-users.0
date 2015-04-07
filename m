From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Translation to File name in sys_enter_open
Date: Tue, 7 Apr 2015 09:21:38 -0300
Message-ID: <20150407122138.GF11983@kernel.org>
References: <CAGAANTWqLq4j-2rn=FPxOYw-dgG-2ed-JZfiQy76zB7WU4iA4Q@mail.gmail.com>
 <CAL2Y34Cb7YEkwJ24K9gCpN4cWDBxsrU=0HQOYXtEXihLUmdpsw@mail.gmail.com>
 <CAGAANTWMC=drNiWJ=6SG_p_EAqSytS0mA2JMsp042LA6oeW6HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56948 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751995AbbDGMVj (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 7 Apr 2015 08:21:39 -0400
Content-Disposition: inline
In-Reply-To: <CAGAANTWMC=drNiWJ=6SG_p_EAqSytS0mA2JMsp042LA6oeW6HQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: sahil aggarwal <sahil.agg15@gmail.com>
Cc: Elazar Leibovich <elazar.leibovich@ravellosystems.com>, linux-perf-users@vger.kernel.org

Em Tue, Apr 07, 2015 at 05:10:21PM +0530, sahil aggarwal escreveu:
> Thank you Elazar.
> BTW i found a way to achieve this other way. By enabling kprobe event
> on function 'getname' which returns file name, this function is called
> by do_sys_open, so i enabled sampling on sys_enter_open, getname,
> sys_exit_open therefore getname between them gives file name.

Yeah, albeit perf-trace still doesn't use it for open, but for other syscalls,
and it uses 'perf probe' to put the vfs_getname in place with a known parm
("pathname"), which needs to be done just once per system boot:

commit c522739d72a341a3e74a369ce6298b9412813d3f
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Fri Sep 27 18:06:19 2013 -0300

    perf trace: Use vfs_getname hook if available
    
    Initially it tries to find a probe:vfs_getname that should be setup
    with:
    
     perf probe 'vfs_getname=getname_flags:65 pathname=result->name:string'
    
    or with slight changes to cope with code flux in the getname_flags code.
    
    In the future, if a "vfs:getname" tracepoint becomes available, then it
    will be preferred.
    
    This is not strictly required and more expensive method of reading the
    /proc/pid/fd/ symlink will be used when the fd->path array entry is not
    populated by a previous vfs_getname + open syscall ret sequence.
    
    As with any other 'perf probe' probe the setup must be done just once
    and the probe will be left inactive, waiting for users, be it 'perf
    trace' of any other tool.
    
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: David Ahern <dsahern@gmail.com>
    Cc: Frederic Weisbecker <fweisbec@gmail.com>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
    Cc: Mike Galbraith <efault@gmx.de>
    Cc: Paul Mackerras <paulus@samba.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Stephane Eranian <eranian@google.com>
    Link: http://lkml.kernel.org/n/tip-ujg8se8glq5izmu8cdkq15po@git.kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Also, over time the place where this probe needs to be inserted has changed.

- Arnaldo
 
> On 6 April 2015 at 22:51, Elazar Leibovich
> <elazar.leibovich@ravellosystems.com> wrote:
> > I don't think you really can do that in the general case. I guess that
> > you can check the CWD of the running process, and calculate the
> > absolute path from it. Though, of course, you don't know the exact
> > state of the filesystem when the event occured.
> >
> > On Mon, Apr 6, 2015 at 1:08 PM, sahil aggarwal <sahil.agg15@gmail.com> wrote:
> >> Hi
> >>
> >> I enabled sampling on tracepoint sys_enter_open but filename field
> >> returned is address to filename as being passed to the system call,
> >> how i can translate this to actual file name while reading ring
> >> buffer.? How perf is doing it.?
> >>
> >> Thanks
> >> Regards
> >> Sahil
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
