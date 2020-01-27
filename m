From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] perf test: Test case 66 broken on s390 (lib/traceevent
 issue)
Date: Mon, 27 Jan 2020 10:55:53 -0500
Message-ID: <20200127105553.3cd92ef8@gandalf.local.home>
References: <20200124073941.39119-1-tmricht@linux.ibm.com>
        <20200124100742.4050c15e@gandalf.local.home>
        <20200125013153.46f05fc1f617fcd341e7060b@kernel.org>
        <20200124113610.662f4afb@gandalf.local.home>
        <659928a1-95b3-ed0d-7988-745d92b495d6@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <659928a1-95b3-ed0d-7988-745d92b495d6@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, borntraeger@de.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On Mon, 27 Jan 2020 08:34:23 +0100
Thomas Richter <tmricht@linux.ibm.com> wrote:

> Steven and Masami,
> 
> thanks for the patch, it fixes this issue!

Thanks for letting me know. I'll add a:

  Tested-by: Thomas Richter <tmricht@linux.ibm.com>

to the commit.

> 
> PS: I should have sent this description earlier, would have saved a week of debugging
> on my side....

Heh, I do things like this ofter after triggering bugs in others
code, and will spend a few days debugging it, then finding out that
there's already a fix to the bug I find (or presenting the problem
gives a proper fix). I just calk it up as a learning experience ;-)

-- Steve
