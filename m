From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] perf test: Test case 66 broken on s390 (lib/traceevent
 issue)
Date: Fri, 24 Jan 2020 11:36:10 -0500
Message-ID: <20200124113610.662f4afb@gandalf.local.home>
References: <20200124073941.39119-1-tmricht@linux.ibm.com>
        <20200124100742.4050c15e@gandalf.local.home>
        <20200125013153.46f05fc1f617fcd341e7060b@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200125013153.46f05fc1f617fcd341e7060b@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, borntraeger@de.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On Sat, 25 Jan 2020 01:31:53 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Steven and Thomas,
> 
> On Fri, 24 Jan 2020 10:07:42 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > This looks like a kernel bug, not a libtraceevent parsing bug.  
> 
> Totally agreed. It was my fault to update the print format.
> Even if still there is a problem on s390, this patch must be
> applied.

Thanks Masami for looking into it.

Thomas,

Please still test this patch. If it works, I'd like to add a
Reported-by and Tested-by tag from you.

-- Steve

> 
> Fixes: 88903c464321 ("tracing/probe: Add ustring type for user-space string")
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
