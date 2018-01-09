From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf ftrace: Fix the buffer size in __write_tracing_file
Date: Tue, 9 Jan 2018 15:35:33 +0900
Message-ID: <20180109063533.GB7138@sejong>
References: <1514280416-29659-1-git-send-email-changbin.du@intel.com>
 <20180108030512.begv5uoo66kh5biu@intel.com>
 <20180108143457.GA18380@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:37476 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754165AbeAIGff (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Jan 2018 01:35:35 -0500
Content-Disposition: inline
In-Reply-To: <20180108143457.GA18380@krava>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: "Du, Changbin" <changbin.du@intel.com>, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, kernel-team@lge.com

Hi,

On Mon, Jan 08, 2018 at 03:34:57PM +0100, Jiri Olsa wrote:
> On Mon, Jan 08, 2018 at 11:05:12AM +0800, Du, Changbin wrote:
> > Hi Olsa,
> > What about this fix now? Thanks!
> > 
> > On Tue, Dec 26, 2017 at 05:26:56PM +0800, changbin.du@intel.com wrote:
> > > From: Changbin Du <changbin.du@intel.com>
> > > 
> > > The terminal character '\0' should take into account as size of the string
> > > buffer. Without this fix, the '--graph-funcs', '--nograph-funcs' and
> > > '--trace-funcs' options didn't work as expected when the <func> doesn't
> > > exist.
> > > 
> > > I didn't dive into kernel ftrace fops, but strace shows that if usersapce
> > > writes a non-terminated string, the kernel side will return success but
> > > no filter applied. After this fix in userspace, the kernel will return an
> > > error.
> > > 
> > > $ sudo ./perf ftrace -a --graph-depth 1 --graph-funcs abcdefg
> > >  0)   0.140 us    |  rcu_all_qs();
> > >  3)   0.304 us    |  mutex_unlock();
> > >  0)   0.153 us    |  find_vma();
> > >  3)   0.088 us    |  __fsnotify_parent();
> > >  0)   6.145 us    |  handle_mm_fault();
> > >  3)   0.089 us    |  fsnotify();
> > >  3)   0.161 us    |  __sb_end_write();
> > >  3)   0.710 us    |  SyS_close();
> > >  3)   7.848 us    |  exit_to_usermode_loop();
> > > 
> > > On above example, I specified function filter 'abcdefg' but all functions
> > > are enabled.
> 
> hum, haven't checked, but looks like the filter is not working at all now:
> 
> [root@krava perf]# ./perf ftrace -vv -a --graph-depth 1 --graph-funcs proc_sys_read
> write ' ' to tracing/set_ftrace_pid failed: Invalid argument
> [root@krava perf]# ./perf ftrace -vv -a --graph-depth 1 --graph-funcs SyS_read
> write ' ' to tracing/set_ftrace_pid failed: Invalid argument
> [root@krava perf]# ./perf ftrace -vv -a --graph-depth 1 --graph-funcs fsnotify
> write ' ' to tracing/set_ftrace_pid failed: Invalid argument

Hmm.. it seems writing a whitespace alone caused the failure.

The filter files are handled little bit different in that they process
the given string when it find a whitespace or at the close() if not.
But the thing is that it's gonna lose the return value if handled at
close().

Anyway adding a NUL character at the end won't make different IMHO
since it's not a whitespace.  And I think it needs a separate function
to set filters with a whitespace.  But this will change the program
behavior on invalid filter inputs.

Thanks,
Namhyung
