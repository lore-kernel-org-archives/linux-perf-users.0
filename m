From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/3] tracing: don't set parser->cont if it has reached
 the end of input buffer
Date: Fri, 12 Jan 2018 10:31:08 -0500
Message-ID: <20180112103108.21a8fa22@gandalf.local.home>
References: <1515491748-25926-1-git-send-email-changbin.du@intel.com>
        <1515491748-25926-4-git-send-email-changbin.du@intel.com>
        <20180109181241.6b3f5ffb@vmware.local.home>
        <20180110031823.kewjaztlecxgrhad@intel.com>
        <20180109231936.17e91d51@vmware.local.home>
        <20180112040513.hozeldo7p7jwr455@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933926AbeALPbM (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 Jan 2018 10:31:12 -0500
In-Reply-To: <20180112040513.hozeldo7p7jwr455@intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Du, Changbin" <changbin.du@intel.com>
Cc: jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org

On Fri, 12 Jan 2018 12:05:13 +0800
"Du, Changbin" <changbin.du@intel.com> wrote:

> Hi Rostedt,
> On Tue, Jan 09, 2018 at 11:19:36PM -0500, Steven Rostedt wrote:
> > On Wed, 10 Jan 2018 11:18:23 +0800
> > "Du, Changbin" <changbin.du@intel.com> wrote:
> >   
> > > write(3, "abcdefg", 7)    
> > > > 
> > > > From my point of view, the above isn't done writing the function name
> > > > yet and we SHOULD continue waiting for more input.
> > > >     
> > > hmm, thanks for the background. Your above case is a postive use case. So by
> > > this design, instead of write(3, "abcdefg", 7), it should be
> > > write(3, "abcdefg\0", 8), right?  
> > 
> > BTW, gcc would translate the above string to 'abcdefg\0\0'. When
> > defining strings with "", gcc (and all C compilers) append a '\0' to
> > the end.
> >   
> I should clarify the expression here first. :) All the strings here is to express
> all the content of a string buffer, including the compiler appended '\0'. (Just like
> the output of 'strace').
> If this description is still not clear, please let me know!

I was just saying that:

	write(3, "abcdefg\0", 8);

is exactly the same as;

	write(3, "abcdefg", 8);

The '\0' is redundant, as the quoted string adds it. In other words

	sizeof("abcdefg") returns 8

> 
> > But I replied to the first patch, saying that allowing \0 as whitespace
> > may be OK, given the usecase I showed.
> >   
> > > 
> > > If true, it means kernel expect userspace write every string terminated with
> > > '\0'. So to fix this issue:
> > > open("/sys/kernel/debug/tracing//set_ftrace_pid", O_WRONLY|O_TRUNC) = 3
> > > write(3, " \0", 2)                      = -1 EINVAL (Invalid argument)
> > > 
> > > Fix would be:
> > > write(3, "\0", 1)?
> > > 
> > > So far, I am still confused. Some of the tracing debugfs entr0y accept '\0'
> > > while some not. AFIK, 'echo xxx > <path to tracing file>' always has a '\0'
> > > terminated.  
> > 
> > I don't believe that's true.
> > 
> >  $ echo -n abc > /tmp/abc
> >  $ wc /tmp/abc
> >  0 1 3 /tmp/abc
> > 
> > Echo writes only the characters you put on the line, nothing more.
> >   
> Sorry, I misundertood it. The extra character is '\n'.
>   $ echo abc > set_ftrace_filter
>     0.000 probe:ftrace_filter_write_line0:(ffffffffa7b8db80) ubuf=0xc77408 cnt=0x4)
>   $ echo -n abc > set_ftrace_filter
>     8889.832 probe:ftrace_filter_write_line0:(ffffffffa7b8db80) ubuf=0xc77408 cnt=0x3)
> 
> > Note, when the file descriptor is closed, the code also executes on
> > what was written but not terminated. That is:
> > 
> > 	write(fd, "abc", 3);
> > 	close(fd);
> > 
> > Will keep the "abc" in the continue buffer, but the closing of the file
> > descriptor will flush it, and execute it.
> >   
> Thanks, so now I unstand why below corner case. The userspace try to set the
> filter with a unrecognized symbole name (e.g "abcdefg").
> open("/sys/kernel/debug/tracing/set_ftrace_filter", O_WRONLY|O_TRUNC) = 3
> write(3, "abcdefg", 7)
> 
> Since "abcdefg" is not in the symbole list, so we would expect the write return
> -EINVAL, right? As below:
> # echo abcdefg > set_ftrace_filter
> bash: echo: write error: Invalid argument

The write itself doesn't finish the operation. There may be another
write. In other words:

	write(3, "do_", 3);
	write(3, "IRQ\n", 4);

Should both return success, even though it only enabled do_IRQ.

> 
> But the above mechanism hide the error. It return success actually no filter is
> apllied at all.
> # echo -n abcdefg > set_ftrace_filter
> 
> I think in this case kernel may request the userspace append a '\0' or space to the
> string buffer so everything can work.
> 
> Also there is another corner case. Below write dosn't work.
> open("/sys/kernel/debug/tracing//set_ftrace_pid", O_WRONLY|O_TRUNC) = 3
> write(3, " \0", 2)                      = -1 EINVAL (Invalid argument)
> 
> While these works:
> # echo "" > set_ftrace_pid
> # echo " " > set_ftrace_pid
> # echo -n " " > set_ftrace_pid
> 
> These is the reason why I think '\0' should be recognized by the parser.

Hmm, thinking about this more, I do partially agree with you. We should
accept '\0' but I disagree that it should be treated as a space. I
don't want hidden code.

It should be treated as a terminator. And carefully as well.

	write(3, "do_IRQ", 7);

Which will send to the kernel 'd' 'o' '_' 'I' 'R' 'Q' '\0' when the
kernel sees the '\0', and the write has not sent anything else, it
should go ahead and execute 'do_IRQ'

This will allow for this to work:

	char *funcs[] = { "do_IRQ", "schedule", NULL };

	for (i = 0; funcs[i]; i++) {
		ret = write(3, funcs[i], strlen(funcs[i]) + 1);
		if (ret < 0)
			exit(-1);
	}


Now if someone were to write:

	write(3, "do_IRQ\0schedule", 16);

That should return an error.

Why?

Because these are strings, and most tools treat '\0' as a nul
terminator to a string. If we allow for tools to send data after that
nul terminator, we are opening up a way for those interacting with
these tools to sneak in strings that are not visible.

Say we have some admin tools that is doing tracing, and takes input.
And all the input is logged. And say the tool does something like:


	r = read(0, buf, sizeof(buf));
	if (r < 0 || r > sizeof(buf) - 1)
		return -1;
	log("Adding to output %s\n", buf);
	write(3, buf, r);

The "Adding to output" would only show up to the '\0', but if we allow
that write to process after the '\0' then we just allowed the user to
circumvent the log.

-- Steve
