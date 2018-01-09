From: "Du, Changbin" <changbin.du@intel.com>
Subject: Re: [PATCH] perf ftrace: Fix the buffer size in __write_tracing_file
Date: Tue, 9 Jan 2018 14:10:33 +0800
Message-ID: <20180109061033.hxlwz2j2xfzwiknn@intel.com>
References: <1514280416-29659-1-git-send-email-changbin.du@intel.com>
 <20180108030512.begv5uoo66kh5biu@intel.com>
 <20180108143457.GA18380@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180108143457.GA18380@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: "Du, Changbin" <changbin.du@intel.com>, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

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
>
Thanks for your test. I forgot to test normal case and thought the err is expected...

This time I dived into kernel side, and found 3 issues (if I am all right) at the
kernel function trace_get_user(). This function has problems to process both complete
C string or not.

I will send the kernel patches and Cc you guys. And I still think it is better
let perf write a complete C string.

Thanks!
Changbin Du

> jirka
>
[...] 
