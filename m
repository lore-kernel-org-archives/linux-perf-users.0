From: "Du, Changbin" <changbin.du@intel.com>
Subject: Re: [PATCH 3/3] tracing: don't set parser->cont if it has reached
 the end of input buffer
Date: Sun, 14 Jan 2018 13:43:48 +0800
Message-ID: <20180114054348.3gddmmzlcxn3kkqs@intel.com>
References: <1515491748-25926-1-git-send-email-changbin.du@intel.com>
 <1515491748-25926-4-git-send-email-changbin.du@intel.com>
 <20180109181241.6b3f5ffb@vmware.local.home>
 <20180110031823.kewjaztlecxgrhad@intel.com>
 <20180109231936.17e91d51@vmware.local.home>
 <20180112040513.hozeldo7p7jwr455@intel.com>
 <20180112103108.21a8fa22@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:18056 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750999AbeANFwG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 14 Jan 2018 00:52:06 -0500
Content-Disposition: inline
In-Reply-To: <20180112103108.21a8fa22@gandalf.local.home>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Du, Changbin" <changbin.du@intel.com>, jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org

On Fri, Jan 12, 2018 at 10:31:08AM -0500, Steven Rostedt wrote:
[...]
> > Thanks, so now I unstand why below corner case. The userspace try to set the
> > filter with a unrecognized symbole name (e.g "abcdefg").
> > open("/sys/kernel/debug/tracing/set_ftrace_filter", O_WRONLY|O_TRUNC) = 3
> > write(3, "abcdefg", 7)
> > 
> > Since "abcdefg" is not in the symbole list, so we would expect the write return
> > -EINVAL, right? As below:
> > # echo abcdefg > set_ftrace_filter
> > bash: echo: write error: Invalid argument
> 
> The write itself doesn't finish the operation. There may be another
> write. In other words:
> 
> 	write(3, "do_", 3);
> 	write(3, "IRQ\n", 4);
> 
> Should both return success, even though it only enabled do_IRQ.
> 
> > 
> > But the above mechanism hide the error. It return success actually no filter is
> > apllied at all.
> > # echo -n abcdefg > set_ftrace_filter
> > 
> > I think in this case kernel may request the userspace append a '\0' or space to the
> > string buffer so everything can work.
> > 
> > Also there is another corner case. Below write dosn't work.
> > open("/sys/kernel/debug/tracing//set_ftrace_pid", O_WRONLY|O_TRUNC) = 3
> > write(3, " \0", 2)                      = -1 EINVAL (Invalid argument)
> > 
> > While these works:
> > # echo "" > set_ftrace_pid
> > # echo " " > set_ftrace_pid
> > # echo -n " " > set_ftrace_pid
> > 
> > These is the reason why I think '\0' should be recognized by the parser.
> 
> Hmm, thinking about this more, I do partially agree with you. We should
> accept '\0' but I disagree that it should be treated as a space. I
> don't want hidden code.
> 
> It should be treated as a terminator. And carefully as well.
> 
> 	write(3, "do_IRQ", 7);
> 
> Which will send to the kernel 'd' 'o' '_' 'I' 'R' 'Q' '\0' when the
> kernel sees the '\0', and the write has not sent anything else, it
> should go ahead and execute 'do_IRQ'
> 
> This will allow for this to work:
> 
> 	char *funcs[] = { "do_IRQ", "schedule", NULL };
> 
> 	for (i = 0; funcs[i]; i++) {
> 		ret = write(3, funcs[i], strlen(funcs[i]) + 1);
> 		if (ret < 0)
> 			exit(-1);
> 	}
> 
> 
> Now if someone were to write:
> 
> 	write(3, "do_IRQ\0schedule", 16);
> 
> That should return an error.
> 
> Why?
> 
> Because these are strings, and most tools treat '\0' as a nul
> terminator to a string. If we allow for tools to send data after that
> nul terminator, we are opening up a way for those interacting with
> these tools to sneak in strings that are not visible.
> 
> Say we have some admin tools that is doing tracing, and takes input.
> And all the input is logged. And say the tool does something like:
> 
> 
> 	r = read(0, buf, sizeof(buf));
> 	if (r < 0 || r > sizeof(buf) - 1)
> 		return -1;
> 	log("Adding to output %s\n", buf);
> 	write(3, buf, r);
> 
> The "Adding to output" would only show up to the '\0', but if we allow
> that write to process after the '\0' then we just allowed the user to
> circumvent the log.
> 
> -- Steve
I agree on your concern. So I will revise this serias and drop the last patch.

-- 
Thanks,
Changbin Du
