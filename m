From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v3 0/3] tracing: Fix the parser when processing strings
 w/ or w/o terminated '\0'
Date: Wed, 17 Jan 2018 11:35:41 +0900
Message-ID: <20180117023541.GA6698@danjae.aot.lge.com>
References: <1516093350-12045-1-git-send-email-changbin.du@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34155 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751930AbeAQCin (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 16 Jan 2018 21:38:43 -0500
Content-Disposition: inline
In-Reply-To: <1516093350-12045-1-git-send-email-changbin.du@intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: changbin.du@intel.com
Cc: rostedt@goodmis.org, jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, kernel-team@lge.com

On Tue, Jan 16, 2018 at 05:02:27PM +0800, changbin.du@intel.com wrote:
> From: Changbin Du <changbin.du@intel.com>
> 
> I found there are some problems in the tracing parser when I investiage the root
> cause of issues mentioned in below patch.
> https://patchwork.kernel.org/patch/10132953/
> 
> This serials can fix them.
> 
> v3: Polish commit msg from Steven Rostedt.
> v2:
>   - Drop 1 old patch and add a new one.
>   - Stop parsing when '\0' found.
> 
> Changbin Du (3):
>   tracing: detect the string termination character when parsing user
>     input string
>   tracing: clear parser->idx if parser gets nothing
>   tracing: make sure the parsed string always terminates with '\0'

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> 
>  kernel/trace/ftrace.c       |  2 --
>  kernel/trace/trace.c        | 14 +++++++-------
>  kernel/trace/trace_events.c |  2 --
>  3 files changed, 7 insertions(+), 11 deletions(-)
> 
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
