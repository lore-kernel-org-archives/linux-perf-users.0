From: Arun Sharma <asharma@fb.com>
Subject: Re: Profiling sleep times?
Date: Sat, 22 Oct 2011 17:27:52 -0700
Message-ID: <4EA35F88.9010803@fb.com>
References: <1317717291.25926.13.camel@twins> <4E8E2417.2000903@fb.com> <4E8FAB3A.2040801@gmail.com> <4E933E65.1090207@fb.com> <20111012074113.GK18618@elte.hu> <4E98A75E.3010000@fb.com> <20111015170044.GB29782@elte.hu> <1318706522.2664.8.camel@laptop> <1318706959.11898.1.camel@laptop> <4E9CD134.60106@fb.com> <20111022104947.GB2811@somewhere.feld.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43168 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751075Ab1JWA2O (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 22 Oct 2011 20:28:14 -0400
In-Reply-To: <20111022104947.GB2811@somewhere.feld.cvut.cz>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, avagin@gmail.com, linux-perf-users@vger.kernel.org, acme@ghostprotocols.net, Stephane Eranian <eranian@google.com>

On 10/22/11 3:49 AM, Frederic Weisbecker wrote:

> That's not only a problem of semantics although that alone is a problem,
> people will seldom read the documentation for corner cases, we should
> really stay consistant here: if remote callchains are really needed, we
> want a specific interface for that, not abusing the existing one that would
> only confuse people.

A separate interface sounds good.

>
> Now I still think doing remote callchains is asking for troubles: we need to
> ensure the target is really sleeping and is not going to be scheduled
> concurrently otherwise you might get weird or stale results. So the user needs
> to know which tracepoints are safe to perform this.

I expect this interface to be used in a small number of well known 
places in the kernel.

[...]

>
> I think we should use something like a perf report plugin: perhaps something
> that can create a virtual event on top of real ones: compute the sched:sched_switch
> events, find the time tasks are sleeping and create virtual sleep events on top
> of that with a period weighted with the sleep time.
> Just a thought.

Right - whether we're doing wall-clock profiling or sleep profiling, 
it'll involve looking at multiple real events.

I still see one problem with doing: perf record -ag -e <bunch of events> 
and trying to sort through what happened. Unprivileged users who don't 
have permissions to system wide profiling, but have privileges to 
profile their own processes get locked out of this feature.

  -Arun
