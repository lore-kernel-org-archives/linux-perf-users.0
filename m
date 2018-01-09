From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/3] tracing: don't set parser->cont if it has reached
 the end of input buffer
Date: Tue, 9 Jan 2018 18:12:41 -0500
Message-ID: <20180109181241.6b3f5ffb@vmware.local.home>
References: <1515491748-25926-1-git-send-email-changbin.du@intel.com>
        <1515491748-25926-4-git-send-email-changbin.du@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932091AbeAIXMn (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Jan 2018 18:12:43 -0500
In-Reply-To: <1515491748-25926-4-git-send-email-changbin.du@intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: changbin.du@intel.com
Cc: jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org

On Tue,  9 Jan 2018 17:55:48 +0800
changbin.du@intel.com wrote:

> From: Changbin Du <changbin.du@intel.com>
> 
> We should not set parser->cont if it has reached the end of input buffer.
> And since some callers (like ftrace_graph_write()) treat it as an error
> condition if trace_parser_cont() returns true.

This will break existing use cases. In fact you are removing the entire
point of this code. It NEEDS to continue if it reached the end of the
input buffer.

I do things like:

 # cat file > set_ftrace_filter

where the file has a list of function names. It writes in blocks, and
it could very well have a function name split between two writes where
the write is at the end of the buffer but not finished writing the
function name.

> 
> For example, if userspace set 'set_ftrace_filter' by writing:
> write(3, "abcdefg", 7)

From my point of view, the above isn't done writing the function name
yet and we SHOULD continue waiting for more input.

BIG NACK on this patch. Sorry.

I'm guessing you have some program that writes only the strlen() of
these strings. That's wrong, you need to write "strlen()+1". Write some
real white space between calls, it will work. Add a "write(fd, " ", 1)"
between calls if you need to. Please don't change the kernel to fix
some bad use case. Especially when your fix will break existing use
cases.

-- Steve

> 
> Then in the kernel function ftrace_regex_write(), ftrace_process_regex()
> will not be executed. The result is that the given filter will not be
> applied at all.
> 
> ftrace_regex_write() {
> 	...
> 	read = trace_get_user(parser, ubuf, cnt, ppos);
> 	if (read >= 0 && trace_parser_loaded(parser) &&
> 	    !trace_parser_cont(parser)) {
> 		ret = ftrace_process_regex(iter, parser->buffer,
> 					   parser->idx, enable);
> 		...
> 	}
> 	...
> }
> 
> Signed-off-by: Changbin Du <changbin.du@intel.com>
