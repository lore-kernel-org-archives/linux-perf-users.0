From: "Du, Changbin" <changbin.du@intel.com>
Subject: Re: [PATCH 3/3] tracing: don't set parser->cont if it has reached
 the end of input buffer
Date: Wed, 10 Jan 2018 11:18:23 +0800
Message-ID: <20180110031823.kewjaztlecxgrhad@intel.com>
References: <1515491748-25926-1-git-send-email-changbin.du@intel.com>
 <1515491748-25926-4-git-send-email-changbin.du@intel.com>
 <20180109181241.6b3f5ffb@vmware.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:37385 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965043AbeAJD0j (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Jan 2018 22:26:39 -0500
Content-Disposition: inline
In-Reply-To: <20180109181241.6b3f5ffb@vmware.local.home>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: changbin.du@intel.com, jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org

On Tue, Jan 09, 2018 at 06:12:41PM -0500, Steven Rostedt wrote:
> On Tue,  9 Jan 2018 17:55:48 +0800
> changbin.du@intel.com wrote:
> 
> > From: Changbin Du <changbin.du@intel.com>
> > 
> > We should not set parser->cont if it has reached the end of input buffer.
> > And since some callers (like ftrace_graph_write()) treat it as an error
> > condition if trace_parser_cont() returns true.
> 
> This will break existing use cases. In fact you are removing the entire
> point of this code. It NEEDS to continue if it reached the end of the
> input buffer.
> 
> I do things like:
> 
>  # cat file > set_ftrace_filter
> 
> where the file has a list of function names. It writes in blocks, and
> it could very well have a function name split between two writes where
> the write is at the end of the buffer but not finished writing the
> function name.
>
> > 
> > For example, if userspace set 'set_ftrace_filter' by writing:
> > write(3, "abcdefg", 7)
> 
> From my point of view, the above isn't done writing the function name
> yet and we SHOULD continue waiting for more input.
> 
hmm, thanks for the background. Your above case is a postive use case. So by
this design, instead of write(3, "abcdefg", 7), it should be
write(3, "abcdefg\0", 8), right?

If true, it means kernel expect userspace write every string terminated with
'\0'. So to fix this issue:
open("/sys/kernel/debug/tracing//set_ftrace_pid", O_WRONLY|O_TRUNC) = 3
write(3, " \0", 2)                      = -1 EINVAL (Invalid argument)

Fix would be:
write(3, "\0", 1)?

So far, I am still confused. Some of the tracing debugfs entry accept '\0'
while some not. AFIK, 'echo xxx > <path to tracing file>' always has a '\0'
terminated.

> BIG NACK on this patch. Sorry.
> 
> I'm guessing you have some program that writes only the strlen() of
> these strings. That's wrong, you need to write "strlen()+1". Write some
> real white space between calls, it will work. Add a "write(fd, " ", 1)"
> between calls if you need to. Please don't change the kernel to fix
> some bad use case. Especially when your fix will break existing use
> cases.
> 
> -- Steve
> 
> > 
> > Then in the kernel function ftrace_regex_write(), ftrace_process_regex()
> > will not be executed. The result is that the given filter will not be
> > applied at all.
> > 
> > ftrace_regex_write() {
> > 	...
> > 	read = trace_get_user(parser, ubuf, cnt, ppos);
> > 	if (read >= 0 && trace_parser_loaded(parser) &&
> > 	    !trace_parser_cont(parser)) {
> > 		ret = ftrace_process_regex(iter, parser->buffer,
> > 					   parser->idx, enable);
> > 		...
> > 	}
> > 	...
> > }
> > 
> > Signed-off-by: Changbin Du <changbin.du@intel.com>

-- 
Thanks,
Changbin Du
