From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/3] tracing: don't set parser->cont if it has reached
 the end of input buffer
Date: Tue, 9 Jan 2018 23:19:36 -0500
Message-ID: <20180109231936.17e91d51@vmware.local.home>
References: <1515491748-25926-1-git-send-email-changbin.du@intel.com>
        <1515491748-25926-4-git-send-email-changbin.du@intel.com>
        <20180109181241.6b3f5ffb@vmware.local.home>
        <20180110031823.kewjaztlecxgrhad@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965354AbeAJETj (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Jan 2018 23:19:39 -0500
In-Reply-To: <20180110031823.kewjaztlecxgrhad@intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Du, Changbin" <changbin.du@intel.com>
Cc: jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org

On Wed, 10 Jan 2018 11:18:23 +0800
"Du, Changbin" <changbin.du@intel.com> wrote:

> write(3, "abcdefg", 7)  
> > 
> > From my point of view, the above isn't done writing the function name
> > yet and we SHOULD continue waiting for more input.
> >   
> hmm, thanks for the background. Your above case is a postive use case. So by
> this design, instead of write(3, "abcdefg", 7), it should be
> write(3, "abcdefg\0", 8), right?

BTW, gcc would translate the above string to 'abcdefg\0\0'. When
defining strings with "", gcc (and all C compilers) append a '\0' to
the end.

But I replied to the first patch, saying that allowing \0 as whitespace
may be OK, given the usecase I showed.

> 
> If true, it means kernel expect userspace write every string terminated with
> '\0'. So to fix this issue:
> open("/sys/kernel/debug/tracing//set_ftrace_pid", O_WRONLY|O_TRUNC) = 3
> write(3, " \0", 2)                      = -1 EINVAL (Invalid argument)
> 
> Fix would be:
> write(3, "\0", 1)?
> 
> So far, I am still confused. Some of the tracing debugfs entry accept '\0'
> while some not. AFIK, 'echo xxx > <path to tracing file>' always has a '\0'
> terminated.

I don't believe that's true.

 $ echo -n abc > /tmp/abc
 $ wc /tmp/abc
 0 1 3 /tmp/abc

Echo writes only the characters you put on the line, nothing more.

Note, when the file descriptor is closed, the code also executes on
what was written but not terminated. That is:

	write(fd, "abc", 3);
	close(fd);

Will keep the "abc" in the continue buffer, but the closing of the file
descriptor will flush it, and execute it.

-- Steve
