From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] perf test: Test case 66 broken on s390 (lib/traceevent
 issue)
Date: Thu, 30 Jan 2020 07:54:27 -0500
Message-ID: <20200130075427.303478a0@gandalf.local.home>
References: <20200124073941.39119-1-tmricht@linux.ibm.com>
        <20200124100742.4050c15e@gandalf.local.home>
        <20200125013153.46f05fc1f617fcd341e7060b@kernel.org>
        <20200124113610.662f4afb@gandalf.local.home>
        <659928a1-95b3-ed0d-7988-745d92b495d6@linux.ibm.com>
        <20200127105553.3cd92ef8@gandalf.local.home>
        <20200130105804.GD3841@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200130105804.GD3841@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, borntraeger@de.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On Thu, 30 Jan 2020 11:58:04 +0100
Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:

> Em Mon, Jan 27, 2020 at 10:55:53AM -0500, Steven Rostedt escreveu:
> > On Mon, 27 Jan 2020 08:34:23 +0100
> > Thomas Richter <tmricht@linux.ibm.com> wrote:
> >   
> > > Steven and Masami,
> > > 
> > > thanks for the patch, it fixes this issue!  
> > 
> > Thanks for letting me know. I'll add a:
> > 
> >   Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> > 
> > to the commit.  
> 
> So you're taking it, right?

Yes (Linus already has it in his tree), because it was a kernel fix. The
tools lib traceevent does not need to be changed for this.

-- Steve
