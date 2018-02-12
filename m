From: "Du, Changbin" <changbin.du@intel.com>
Subject: Re: [PATCH v2] perf ftrace: Fix the buffer size in
 __write_tracing_file
Date: Mon, 12 Feb 2018 12:48:15 +0800
Message-ID: <20180212044815.luulsdte6co5uku4@intel.com>
References: <1518077600-19615-1-git-send-email-changbin.du@intel.com>
 <20180212015527.GE31513@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21055 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932433AbeBLE45 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 11 Feb 2018 23:56:57 -0500
Content-Disposition: inline
In-Reply-To: <20180212015527.GE31513@sejong>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: changbin.du@intel.com, jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, kernel-team@lge.com

Hi,

On Mon, Feb 12, 2018 at 10:55:27AM +0900, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Feb 08, 2018 at 04:13:20PM +0800, changbin.du@intel.com wrote:
> > From: Changbin Du <changbin.du@intel.com>
> > 
> > The terminal character '\0' should take into account into size of the
> > string buffer. Without this fix, the '--graph-funcs', '--nograph-funcs'
> > and '--trace-funcs' options didn't work as expected when the <func>
> > doesn't exist. If usersapce writes a non-terminated string, the kernel
> > side will always return success but actually no filter applied.
> > 
> > As discussed before, the kernel now support '\0' to mark the end of string:
> > https://lkml.org/lkml/2018/1/16/116
> > 
> > After this fix in userspace, the perf will report correct error state. Also
> > let it print an error if reset_tracing_files() fails.
> 
> But what about old kernels?  IIRC there was an error with this change.
>
Yes, you're right. I can't find a good compitable change. So what is the compatibilty policy for perf?
If it must work with recent kernel, I think the only idea is leave as it was.
 
> Thanks,
> Namhyung
> 
> 
> > 
> > The problem:
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
> > are enabled. The expected error is hidden.
> > 
> > Signed-off-by: Changbin Du <changbin.du@intel.com>
> > ---
> >  tools/perf/builtin-ftrace.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index 25a42ac..a87e9b3 100644
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
> > @@ -280,8 +280,10 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> >  	signal(SIGCHLD, sig_handler);
> >  	signal(SIGPIPE, sig_handler);
> >  
> > -	if (reset_tracing_files(ftrace) < 0)
> > +	if (reset_tracing_files(ftrace) < 0) {
> > +		pr_err("failed to reset ftrace\n");
> >  		goto out;
> > +	}
> >  
> >  	/* reset ftrace buffer */
> >  	if (write_tracing_file("trace", "0") < 0)
> > -- 
> > 2.7.4
> > 

-- 
Thanks,
Changbin Du
