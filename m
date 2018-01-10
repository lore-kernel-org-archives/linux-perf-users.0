From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/3] tracing: detect the string termination character
 when parsing user input string
Date: Tue, 9 Jan 2018 23:09:17 -0500
Message-ID: <20180109230917.19eaed97@vmware.local.home>
References: <1515491748-25926-1-git-send-email-changbin.du@intel.com>
        <1515491748-25926-2-git-send-email-changbin.du@intel.com>
        <20180109175434.77163e52@vmware.local.home>
        <20180110030119.sl6odftbzjdu3dop@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751991AbeAJEJW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Jan 2018 23:09:22 -0500
In-Reply-To: <20180110030119.sl6odftbzjdu3dop@intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Du, Changbin" <changbin.du@intel.com>
Cc: jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org

On Wed, 10 Jan 2018 11:01:20 +0800
"Du, Changbin" <changbin.du@intel.com> wrote:

> hi Rostedt,
> 
> On Tue, Jan 09, 2018 at 05:54:34PM -0500, Steven Rostedt wrote:
> > On Tue,  9 Jan 2018 17:55:46 +0800
> > changbin.du@intel.com wrote:
> >   
> > > From: Changbin Du <changbin.du@intel.com>
> > > 
> > > The usersapce can give a '\0' terminated C string or even has '\0' at the
> > > middle of input buffer. We need handle both these two cases correctly.  
> > 
> > What do you define as correctly. Because I'm not seeing it.
> >  
> Soory I don't fully understand your question. What I meant is want to get clear that
> how will tracing parser below strings.
>   "", "  ",  "\0", " \0 ", "aa\0bb"
> The parser may only recognize certain formats, but whatever the behaviour should
> be clear and coherent for all tracing interfaces.

We have a lack of communication here, because now I'm confused by what
exactly you are asking. ;-)

> 
> > > 
> > > Before this change, trace_get_user() will return a parsed string "\0" in
> > > below case. It is not expected (expects it skip all inputs) and cause the
> > > caller failed.
> > > 
> > > open("/sys/kernel/debug/tracing//set_ftrace_pid", O_WRONLY|O_TRUNC) = 3
> > > write(3, " \0", 2)                      = -1 EINVAL (Invalid argument)  
> > 
> > That looks more like a feature and not a bug.
> >   
> I point this out because I think the parser should take this as an emptry string
> per the comments of trace_get_user().
> /*
>  * trace_get_user - reads the user input string separated by  space
>  * (matched by isspace(ch))
>  *
>  * For each string found the 'struct trace_parser' is updated,
>  * and the function returns.
>  *
>  * Returns number of bytes read.
>  *
>  * See kernel/trace/trace.h for 'struct trace_parser' details.
>  */

I'm also confused about the inconsistency you see here.

> 
> > > 
> > > This patch try to make the parser '\0' aware to fix such issue.  
> > 
> > Why?
> >   
> 
> > > 
> > > Since the caller expects trace_get_user() to parse whole input buffer, so
> > > this patch treat '\0' as a separator as whitespace.  
> > 
> > It looks more like we are trying to fix a userspace bug via the kernel.
> >   
> 
> > I'm not liking this. So NACK.

Thinking about this more, I may not be so against it. I'm guessing you
want to do something like:

	write(fd, "func1", 6);
	write(fd, "func2", 6);

And have it add both func1 and func2, where the '\0' is the separator.

If so, I can see that as a legitimate use case.

-- Steve
