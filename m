From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [BUGFIX PATCH] tracing/kprobes: Fix to check notrace function
 with correct range
Date: Tue, 21 Aug 2018 09:42:49 -0400
Message-ID: <20180821094249.3fea76bb@gandalf.local.home>
References: <20180821212448.d20ea26fa998b206adf4ece6@kernel.org>
        <153485669706.16611.17726752296213785504.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <153485669706.16611.17726752296213785504.stgit@devbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Francis Deslauriers <francis.deslauriers@efficios.com>, peterz@infradead.org, mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, Michael Rodin <michael@rodin.online>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Tue, 21 Aug 2018 22:04:57 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Fix within_notrace_func() to check notrace function correctly.
> 
> Since the ftrace_location_range(start, end) function checks
> the range inclusively (start <= ftrace-loc <= end), the end
> address must not include the entry address of next function.
> 
> However, within_notrace_func() uses kallsyms_lookup_size_offset()
> to get the function size and calculate the end address from
> adding the size to the entry address. This means the end address
> is the entry address of the next function.
> 
> In the result, within_notrace_func() fails to find notrace
> function if the next function of the target function is
> ftraced.
> 
> Let's subtract 1 from the end address so that ftrace_location_range()
> can check it correctly.
> 
> Fixes: commit 45408c4f9250 ("tracing: kprobes: Prohibit probing on notrace function")
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Reported-by: Michael Rodin <michael@rodin.online>
> ---
>

Applied. Thanks Masami! I'll start testing this and send it upstream
when it's finished.

-- Steve
