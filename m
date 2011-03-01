From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/6] perf record: add time-of-day option
Date: Tue, 01 Mar 2011 17:00:50 +0100
Message-ID: <1298995250.5226.882.camel@laptop>
References: <1298865151-23656-1-git-send-email-daahern@cisco.com>
	 <1298865151-23656-4-git-send-email-daahern@cisco.com>
	 <1298989751.5226.863.camel@laptop>  <4D6D0438.2090901@cisco.com>
	 <1298993714.5226.871.camel@laptop>  <4D6D13C6.5020807@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:53917 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753070Ab1CAP7U (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 1 Mar 2011 10:59:20 -0500
Received: from j77219.upc-j.chello.nl ([24.132.77.219] helo=dyad.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.72 #1 (Red Hat Linux))
	id 1PuRyp-0004za-Qu
	for linux-perf-users@vger.kernel.org; Tue, 01 Mar 2011 15:59:19 +0000
In-Reply-To: <4D6D13C6.5020807@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <daahern@cisco.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, fweisbec@gmail.com, paulus@samba.org, tglx@linutronix.de

On Tue, 2011-03-01 at 08:41 -0700, David Ahern wrote:

> realtime-clock counter is created with a period N. How do you correlate
> perf_clock to time-of-day until now + N? 

You scan fwd? Since its at most N time ahead you're scanning fwd its
still constant time.

Thing is, I'm really not convinced this is a very useful ioctl() in
generic, and ioctl()s really need a good justification to add.
