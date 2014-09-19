From: Milian Wolff <mail@milianw.de>
Subject: Re: Perf event for Wall-time based sampling?
Date: Fri, 19 Sep 2014 16:39:39 +0200
Message-ID: <1423473.AV2A0F0SQn@milian-kdab2>
References: <2221771.b2oSN5LR6X@milian-kdab2> <20140918203625.GM2770@kernel.org> <541C3B0B.3030706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:46355 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757190AbaISOjm (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 19 Sep 2014 10:39:42 -0400
In-Reply-To: <541C3B0B.3030706@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, linux-perf-users <linux-perf-users@vger.kernel.org>, Namhyung Kim <namhyung@gmail.com>, Ingo Molnar <mingo@kernel.org>, Joseph Schuchart <joseph.schuchart@tu-dresden.de>

On Friday 19 September 2014 08:17:47 David Ahern wrote:
> On 9/18/14, 2:36 PM, Arnaldo Carvalho de Melo wrote:
> > Ok, so you want to see what is the wait channel and unwind the stack
> > from there? Is that the case? I.e. again, a sysrq-t equivalent?
> > 
> >> Milian want is to grab samples every timer expiration even if process is
> >> not running.
> > 
> > What for? And by "grab samples" you want to know where it is waiting for
> > something, together with its callchain?
> > 
> >> Any limitations that would prevent doing this with a sw event? e.g, mimic
> >> task-clock just don't disable the timer when the task is scheduled out.
> > 
> > I'm just trying to figure out if what people want is a complete
> > backtrace of all threads in a process, no matter what they are doing, at
> > some given time, i.e. at "sysrq-t" time, is that the case?
> 
> This has been discussed before:
>     http://thread.gmane.org/gmane.linux.kernel/1307306
> 
> Example on the perf wiki:
>      https://perf.wiki.kernel.org/index.php/Tutorial#Profiling_sleep_times

Right, I also mentioned this in my initial email. This is _not_ what I want 
though :)

Bye
-- 
Milian Wolff
mail@milianw.de
http://milianw.de
