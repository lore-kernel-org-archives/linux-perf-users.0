From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [BUGFIX PATCH] tracing/kprobes: Fix to check notrace function
 with correct range
Date: Wed, 22 Aug 2018 21:39:33 -0400
Message-ID: <20180822213933.7da87c5c@vmware.local.home>
References: <20180821212448.d20ea26fa998b206adf4ece6@kernel.org>
        <153485669706.16611.17726752296213785504.stgit@devbox>
        <20180821094249.3fea76bb@gandalf.local.home>
        <20180822085809.01da04b0@gandalf.local.home>
        <20180823101831.6997f36954257d79d3a15d51@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180823101831.6997f36954257d79d3a15d51@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Francis Deslauriers <francis.deslauriers@efficios.com>, peterz@infradead.org, mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, Michael Rodin <michael@rodin.online>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Thu, 23 Aug 2018 10:18:31 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Wed, 22 Aug 2018 08:58:09 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Tue, 21 Aug 2018 09:42:49 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >   
> > > On Tue, 21 Aug 2018 22:04:57 +0900
> > > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >   
> > > > Fix within_notrace_func() to check notrace function correctly.
> > > > 
> > > > Since the ftrace_location_range(start, end) function checks
> > > > the range inclusively (start <= ftrace-loc <= end), the end
> > > > address must not include the entry address of next function.
> > > > 
> > > > However, within_notrace_func() uses kallsyms_lookup_size_offset()
> > > > to get the function size and calculate the end address from
> > > > adding the size to the entry address. This means the end address
> > > > is the entry address of the next function.
> > > > 
> > > > In the result, within_notrace_func() fails to find notrace
> > > > function if the next function of the target function is
> > > > ftraced.
> > > > 
> > > > Let's subtract 1 from the end address so that ftrace_location_range()
> > > > can check it correctly.
> > > > 
> > > > Fixes: commit 45408c4f9250 ("tracing: kprobes: Prohibit probing on notrace function")
> > > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > > Reported-by: Michael Rodin <michael@rodin.online>
> > > > ---
> > > >    
> > > 
> > > Applied. Thanks Masami! I'll start testing this and send it upstream
> > > when it's finished.
> > >   
> > 
> > Hmm, this fix shows the extent of not tracing functions with notrace
> > attched much deeper. For one thing, we can't hook kprobes to the
> > __schedule() function (which is now what all the main schedule
> > functions call). One of my tests used this function to test kprobes and
> > it failed.
> > 
> > I'll push this to Linus, but I'm wondering if we want to perhaps add a
> > white list of functions marked "notrace" but still kprobes can trace?  
> 
> Yes, that is what I'm thinking about. Maybe most of notrace function is
> safe for kprobes (like __schedule()). And if it is really critical, those
> functions must be marked by NOKPROBE_SYMBOL().
> 

Correct. This notrace was added because we want to not trace any
function call between preempt_schedule() and where NEED_RESCHED is
cleared. Because the function tracer does a preempt_enable_notrace()
which triggers the preempt_schedule() call again, and we can end up in
a recursive loop. But that is fixed, but by tracing __schedule() we do
a song and dance of calling preempt_schedule_notrace and makes the
trace output weird.

See commit 499d79559ffe4.

-- Steve
