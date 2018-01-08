From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf ftrace: Fix the buffer size in __write_tracing_file
Date: Mon, 8 Jan 2018 15:34:57 +0100
Message-ID: <20180108143457.GA18380@krava>
References: <1514280416-29659-1-git-send-email-changbin.du@intel.com>
 <20180108030512.begv5uoo66kh5biu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932318AbeAHOe7 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Jan 2018 09:34:59 -0500
Content-Disposition: inline
In-Reply-To: <20180108030512.begv5uoo66kh5biu@intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Du, Changbin" <changbin.du@intel.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org

On Mon, Jan 08, 2018 at 11:05:12AM +0800, Du, Changbin wrote:
> Hi Olsa,
> What about this fix now? Thanks!
> 
> On Tue, Dec 26, 2017 at 05:26:56PM +0800, changbin.du@intel.com wrote:
> > From: Changbin Du <changbin.du@intel.com>
> > 
> > The terminal character '\0' should take into account as size of the string
> > buffer. Without this fix, the '--graph-funcs', '--nograph-funcs' and
> > '--trace-funcs' options didn't work as expected when the <func> doesn't
> > exist.
> > 
> > I didn't dive into kernel ftrace fops, but strace shows that if usersapce
> > writes a non-terminated string, the kernel side will return success but
> > no filter applied. After this fix in userspace, the kernel will return an
> > error.
> > 
> > $ sudo ./perf ftrace -a --graph-depth 1 --graph-funcs abcdefg
> >  0)   0.140 us    |  rcu_all_qs();
> >  3)   0.304 us    |  mutex_unlock();
> >  0)   0.153 us    |  find_vma();
> >  3)   0.088 us    |  __fsnotify_parent();
> >  0)   6.145 us    |  handle_mm_fault();
> >  3)   0.089 us    |  fsnotify();
> >  3)   0.161 us    |  __sb_end_write();
> >  3)   0.710 us    |  SyS_close();
> >  3)   7.848 us    |  exit_to_usermode_loop();
> > 
> > On above example, I specified function filter 'abcdefg' but all functions
> > are enabled.

hum, haven't checked, but looks like the filter is not working at all now:

[root@krava perf]# ./perf ftrace -vv -a --graph-depth 1 --graph-funcs proc_sys_read
write ' ' to tracing/set_ftrace_pid failed: Invalid argument
[root@krava perf]# ./perf ftrace -vv -a --graph-depth 1 --graph-funcs SyS_read
write ' ' to tracing/set_ftrace_pid failed: Invalid argument
[root@krava perf]# ./perf ftrace -vv -a --graph-depth 1 --graph-funcs fsnotify
write ' ' to tracing/set_ftrace_pid failed: Invalid argument

jirka

> > 
> > Signed-off-by: Changbin Du <changbin.du@intel.com>
> > ---
> >  tools/perf/builtin-ftrace.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index 25a42ac..2604a64 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -69,7 +69,7 @@ static int __write_tracing_file(const char *name, const char *val, bool append)
> >  {
> >  	char *file;
> >  	int fd, ret = -1;
> > -	ssize_t size = strlen(val);
> > +	ssize_t size = strlen(val) + 1;
> >  	int flags = O_WRONLY;
> >  	char errbuf[512];
> >  
> > -- 
> > 2.7.4
> > 
> 
> -- 
> Thanks,
> Changbin Du
