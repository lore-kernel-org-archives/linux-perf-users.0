From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 3/3] perf events: add timehist option to record and report
Date: Sat, 19 Feb 2011 10:32:16 +0100
Message-ID: <20110219093216.GA30331@elte.hu>
References: <1298008433-22911-1-git-send-email-daahern@cisco.com>
 <1298008433-22911-4-git-send-email-daahern@cisco.com>
 <20110218070657.GA11404@elte.hu>
 <4D5E8204.2090501@cisco.com>
 <20110218175926.GA3445@nowhere>
 <4D5EB564.6030504@cisco.com>
 <1298054399.5226.779.camel@laptop>
 <4D5EBE2C.7000701@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:40435 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752802Ab1BSJdN (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 19 Feb 2011 04:33:13 -0500
Content-Disposition: inline
In-Reply-To: <4D5EBE2C.7000701@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <daahern@cisco.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net, paulus@samba.org, Thomas Gleixner <tglx@linutronix.de>, Arnaldo Carvalho de Melo <acme@redhat.com>


* David Ahern <daahern@cisco.com> wrote:

> On 01/23/11 at 03:45:67 a syslog event noted an application restart.
> Checking the applications logs it went silent. Why? What does perf say?
> 
> Oh, 2 days have gone by before said event is reported to engineering,
> and the server was been rebooted to 'clear' the problem - hence
> resetting monotonic clock.

I think that's a valid usecase and the feature you are suggestion is very useful.

Why not extend the regular trace output to also (optionally) output GTOD timestamps?

Thanks,

	Ingo
