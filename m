From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] perf test: Test case 66 broken on s390 (lib/traceevent
 issue)
Date: Sat, 25 Jan 2020 01:31:53 +0900
Message-ID: <20200125013153.46f05fc1f617fcd341e7060b@kernel.org>
References: <20200124073941.39119-1-tmricht@linux.ibm.com>
        <20200124100742.4050c15e@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200124100742.4050c15e@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, mhiramat@kernel.org, borntraeger@de.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Hi Steven and Thomas,

On Fri, 24 Jan 2020 10:07:42 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> This looks like a kernel bug, not a libtraceevent parsing bug.

Totally agreed. It was my fault to update the print format.
Even if still there is a problem on s390, this patch must be
applied.

Fixes: 88903c464321 ("tracing/probe: Add ustring type for user-space string")
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

> 
> > +		}
> >  		str = malloc(len + 1);
> >  		if (!str) {
> >  			do_warning_event(event, "%s: not enough memory!",
> 
> Does this patch fix it for you?
> 
> -- Steve
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 905b10af5d5c..d3309fceb480 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -876,7 +876,8 @@ static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
>  	for (i = 0; i < tp->nr_args; i++) {
>  		parg = tp->args + i;
>  		if (parg->count) {
> -			if (strcmp(parg->type->name, "string") == 0)
> +			if ((strcmp(parg->type->name, "string") == 0) ||
> +			    (strcmp(parg->type->name, "ustring") == 0))
>  				fmt = ", __get_str(%s[%d])";
>  			else
>  				fmt = ", REC->%s[%d]";
> @@ -884,7 +885,8 @@ static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
>  				pos += snprintf(buf + pos, LEN_OR_ZERO,
>  						fmt, parg->name, j);
>  		} else {
> -			if (strcmp(parg->type->name, "string") == 0)
> +			if ((strcmp(parg->type->name, "string") == 0) ||
> +			    (strcmp(parg->type->name, "ustring") == 0))
>  				fmt = ", __get_str(%s)";
>  			else
>  				fmt = ", REC->%s";


Thank you!

-- 
Masami Hiramatsu <mhiramat@kernel.org>
