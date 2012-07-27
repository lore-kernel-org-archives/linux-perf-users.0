From: Iegorov Oleg <oleg_iegorov@mentor.com>
Subject: Re: perf: prctl(PR_TASK_PERF_EVENTS_DISABLE) has no effect
Date: Fri, 27 Jul 2012 13:40:05 +0200
Message-ID: <50127E15.4020102@mentor.com>
References: <501121D3.3060700@mentor.com> <20120727072647.GA3965@gmail.com>	 <1343376002.32120.22.camel@twins> <20120727081830.GA4258@gmail.com> <1343377764.32120.29.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:36807 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006Ab2G0LkN (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 27 Jul 2012 07:40:13 -0400
In-Reply-To: <1343377764.32120.29.camel@twins>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org, mingo@elte.hu, acme@ghostprotocols.net, =?ISO-8859-1?Q?Fr=E9d=E9ric_We?= =?ISO-8859-1?Q?isbecker?= <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@infradead.org>, Thomas Gleixner <tglx@linutronix.de>

Le 2012-07-27 10:29, Peter Zijlstra a =E9crit :
> On Fri, 2012-07-27 at 10:18 +0200, Ingo Molnar wrote:
>> * Peter Zijlstra<a.p.zijlstra@chello.nl>  wrote:
>>
>>> On Fri, 2012-07-27 at 09:26 +0200, Ingo Molnar wrote:
>>>> Maybe someone on Cc: would be interested in implementing this
>>>> new perf events feature?
>>> Why would we go build new kernel interfaces because userspace
>>> is silly?
>> Because it's (much) easier to use the existing perf tools almost
>> as-is instead of librarizing your own.
>>
>> It would also allow other usecases, like self-profiling a
>> library and then profiling it within the context of a larger app
>> that you don't want to rebuild and which dynamically links this
>> library.
> Uhm.. why not? For the first use proper self profiling, for the secon=
d
> do a regular 3rd party profile.
>
>> It also allows system-wide profiling after you've modified a
>> library to self-profile, while your suggestion does not allow
>> that.
> But its no long self-profiling when some other process is involved. A=
nd
> system wide is definitely not self.
>
>>> It really isn't that hard to make userspace do what is needed,
>>> it just takes a bit of work.
>> Even if your suggested solution was available (it isn't), my
>> suggested approach is easier to use and covers more usecases.
>>
>> User-space expecting the kernel to provide usable and minimal
>> interfaces is not 'being silly'. It's the fundamental task of a
>> kernel to provide them.
> Bloating the interface for something that is already well possible is=
=2E
>
> I really don't see the problem, other than that people simply don't w=
ant
> to do work.
I totally agree with Ingo. The key words here are "much easier to use".

Moreover, in my use case, it would add a lot of complexity to rebuild=20
the application each time a new performance event is added/removed from=
=20
the event set (if I understood correctly Peter's approach).

Regards,
Oleg
