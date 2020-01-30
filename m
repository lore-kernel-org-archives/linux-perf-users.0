From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] perf test: Test case 66 broken on s390 (lib/traceevent
 issue)
Date: Thu, 30 Jan 2020 11:58:04 +0100
Message-ID: <20200130105804.GD3841@kernel.org>
References: <20200124073941.39119-1-tmricht@linux.ibm.com>
 <20200124100742.4050c15e@gandalf.local.home>
 <20200125013153.46f05fc1f617fcd341e7060b@kernel.org>
 <20200124113610.662f4afb@gandalf.local.home>
 <659928a1-95b3-ed0d-7988-745d92b495d6@linux.ibm.com>
 <20200127105553.3cd92ef8@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200127105553.3cd92ef8@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, borntraeger@de.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Jan 27, 2020 at 10:55:53AM -0500, Steven Rostedt escreveu:
> On Mon, 27 Jan 2020 08:34:23 +0100
> Thomas Richter <tmricht@linux.ibm.com> wrote:
> 
> > Steven and Masami,
> > 
> > thanks for the patch, it fixes this issue!
> 
> Thanks for letting me know. I'll add a:
> 
>   Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> 
> to the commit.

So you're taking it, right?

- Arnaldo
 
> > 
> > PS: I should have sent this description earlier, would have saved a week of debugging
> > on my side....
> 
> Heh, I do things like this ofter after triggering bugs in others
> code, and will spend a few days debugging it, then finding out that
> there's already a fix to the bug I find (or presenting the problem
> gives a proper fix). I just calk it up as a learning experience ;-)
> 
> -- Steve

-- 

- Arnaldo
