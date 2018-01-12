From: "Du, Changbin" <changbin.du@intel.com>
Subject: Re: [PATCH 3/3] tracing: don't set parser->cont if it has reached
 the end of input buffer
Date: Fri, 12 Jan 2018 12:05:13 +0800
Message-ID: <20180112040513.hozeldo7p7jwr455@intel.com>
References: <1515491748-25926-1-git-send-email-changbin.du@intel.com>
 <1515491748-25926-4-git-send-email-changbin.du@intel.com>
 <20180109181241.6b3f5ffb@vmware.local.home>
 <20180110031823.kewjaztlecxgrhad@intel.com>
 <20180109231936.17e91d51@vmware.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24700 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932860AbeALENa (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Jan 2018 23:13:30 -0500
Content-Disposition: inline
In-Reply-To: <20180109231936.17e91d51@vmware.local.home>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Du, Changbin" <changbin.du@intel.com>, jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org


Hi Rostedt,
On Tue, Jan 09, 2018 at 11:19:36PM -0500, Steven Rostedt wrote:
> On Wed, 10 Jan 2018 11:18:23 +0800
> "Du, Changbin" <changbin.du@intel.com> wrote:
> 
> > write(3, "abcdefg", 7)  
> > > 
> > > From my point of view, the above isn't done writing the function name
> > > yet and we SHOULD continue waiting for more input.
> > >   
> > hmm, thanks for the background. Your above case is a postive use case. So by
> > this design, instead of write(3, "abcdefg", 7), it should be
> > write(3, "abcdefg\0", 8), right?
> 
> BTW, gcc would translate the above string to 'abcdefg\0\0'. When
> defining strings with "", gcc (and all C compilers) append a '\0' to
> the end.
> 
I should clarify the expression here first. :) All the strings here is to express
all the content of a string buffer, including the compiler appended '\0'. (Just like
the output of 'strace').
If this description is still not clear, please let me know!

> But I replied to the first patch, saying that allowing \0 as whitespace
> may be OK, given the usecase I showed.
> 
> > 
> > If true, it means kernel expect userspace write every string terminated with
> > '\0'. So to fix this issue:
> > open("/sys/kernel/debug/tracing//set_ftrace_pid", O_WRONLY|O_TRUNC) = 3
> > write(3, " \0", 2)                      = -1 EINVAL (Invalid argument)
> > 
> > Fix would be:
> > write(3, "\0", 1)?
> > 
> > So far, I am still confused. Some of the tracing debugfs entry accept '\0'
> > while some not. AFIK, 'echo xxx > <path to tracing file>' always has a '\0'
> > terminated.
> 
> I don't believe that's true.
> 
>  $ echo -n abc > /tmp/abc
>  $ wc /tmp/abc
>  0 1 3 /tmp/abc
> 
> Echo writes only the characters you put on the line, nothing more.
> 
Sorry, I misundertood it. The extra character is '\n'.
  $ echo abc > set_ftrace_filter
    0.000 probe:ftrace_filter_write_line0:(ffffffffa7b8db80) ubuf=0xc77408 cnt=0x4)
  $ echo -n abc > set_ftrace_filter
    8889.832 probe:ftrace_filter_write_line0:(ffffffffa7b8db80) ubuf=0xc77408 cnt=0x3)

> Note, when the file descriptor is closed, the code also executes on
> what was written but not terminated. That is:
> 
> 	write(fd, "abc", 3);
> 	close(fd);
> 
> Will keep the "abc" in the continue buffer, but the closing of the file
> descriptor will flush it, and execute it.
> 
Thanks, so now I unstand why below corner case. The userspace try to set the
filter with a unrecognized symbole name (e.g "abcdefg").
open("/sys/kernel/debug/tracing/set_ftrace_filter", O_WRONLY|O_TRUNC) = 3
write(3, "abcdefg", 7)

Since "abcdefg" is not in the symbole list, so we would expect the write return
-EINVAL, right? As below:
# echo abcdefg > set_ftrace_filter
bash: echo: write error: Invalid argument

But the above mechanism hide the error. It return success actually no filter is
apllied at all.
# echo -n abcdefg > set_ftrace_filter

I think in this case kernel may request the userspace append a '\0' or space to the
string buffer so everything can work.

Also there is another corner case. Below write dosn't work.
open("/sys/kernel/debug/tracing//set_ftrace_pid", O_WRONLY|O_TRUNC) = 3
write(3, " \0", 2)                      = -1 EINVAL (Invalid argument)

While these works:
# echo "" > set_ftrace_pid
# echo " " > set_ftrace_pid
# echo -n " " > set_ftrace_pid

These is the reason why I think '\0' should be recognized by the parser.

> -- Steve

-- 
Thanks,
Changbin Du
