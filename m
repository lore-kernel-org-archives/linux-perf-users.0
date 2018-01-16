From: "Du, Changbin" <changbin.du@intel.com>
Subject: Re: [PATCH v2 1/3] tracing: detect the string termination character
 when parsing user input string
Date: Tue, 16 Jan 2018 10:41:31 +0800
Message-ID: <20180116024130.775vna6sm432xvp2@intel.com>
References: <1516016474-5581-1-git-send-email-changbin.du@intel.com>
 <1516016474-5581-2-git-send-email-changbin.du@intel.com>
 <20180115182000.531487c2@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:31917 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750903AbeAPCty (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 Jan 2018 21:49:54 -0500
Content-Disposition: inline
In-Reply-To: <20180115182000.531487c2@gandalf.local.home>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: changbin.du@intel.com, jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org

Hi Rostedt,
Thanks for your polish, let me update commit msg with your words.

On Mon, Jan 15, 2018 at 06:20:00PM -0500, Steven Rostedt wrote:
> On Mon, 15 Jan 2018 19:41:12 +0800
> changbin.du@intel.com wrote:
> 
> > From: Changbin Du <changbin.du@intel.com>
> > 
> > The usersapce can give a '\0' terminated C string in the input buffer.
> > Before this change, trace_get_user() will return a parsed string "\0" in
> > below case which is not expected (expects it skip all inputs) and cause the
> > caller failed.
> 
> The above totally does not parse (no pun intended).
> 
> Are you trying to say:
> 
> "User space can pass in a C nul character '\0' along with its input.
> The function trace_get_user() will try to process it as a normal
> character, and that will fail to parse.
> 
> > 
> > open("/sys/kernel/debug/tracing//set_ftrace_pid", O_WRONLY|O_TRUNC) = 3
> > write(3, " \0", 2)                      = -1 EINVAL (Invalid argument)
> > 
> > while parse can handle spaces, so below works.
> > 
> > $ echo "" > set_ftrace_pid
> > $ echo " " > set_ftrace_pid
> > $ echo -n " " > set_ftrace_pid
> > 
> > This patch try to make the parser '\0' aware to fix such issue. When parser
> > sees a '\0' it stops further parsing. With this change, write(3, " \0", 2)
> > will work.
> 
> The above should be something like:
> 
> "Have the parser stop on '\0' and cease any further parsing. Only
> process the characters up to the nul '\0' character and do not process
> it."
> 
> -- Steve
> 
> 
> > 
> > Signed-off-by: Changbin Du <changbin.du@intel.com>
> > 
> > ---
> >   v2: Stop parsing when '\0' found.
> > ---
> >  kernel/trace/trace.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 2a8d8a2..144d08e 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -1237,7 +1237,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
> >  		}
> >  
> >  		/* only spaces were written */
> > -		if (isspace(ch)) {
> > +		if (isspace(ch) || !ch) {
> >  			*ppos += read;
> >  			ret = read;
> >  			goto out;
> > @@ -1247,7 +1247,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
> >  	}
> >  
> >  	/* read the non-space input */
> > -	while (cnt && !isspace(ch)) {
> > +	while (cnt && !isspace(ch) && ch) {
> >  		if (parser->idx < parser->size - 1)
> >  			parser->buffer[parser->idx++] = ch;
> >  		else {
> > @@ -1262,7 +1262,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
> >  	}
> >  
> >  	/* We either got finished input or we have to wait for another call. */
> > -	if (isspace(ch)) {
> > +	if (isspace(ch) || !ch) {
> >  		parser->buffer[parser->idx] = 0;
> >  		parser->cont = false;
> >  	} else if (parser->idx < parser->size - 1) {
> 

-- 
Thanks,
Changbin Du
