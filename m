From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/3] perf events: fix WARN_ON_ONCE for 64-bit raw data,
 SW events
Date: Fri, 18 Feb 2011 16:01:31 +0100
Message-ID: <1298041291.5226.776.camel@laptop>
References: <1298008433-22911-1-git-send-email-daahern@cisco.com>
	 <1298008433-22911-2-git-send-email-daahern@cisco.com>
	 <1298026821.5226.642.camel@laptop> <4D5E8338.8010602@cisco.com>
	 <20110218145348.GA302@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:56137 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754341Ab1BRPAP (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 18 Feb 2011 10:00:15 -0500
Received: from j77219.upc-j.chello.nl ([24.132.77.219] helo=dyad.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.72 #1 (Red Hat Linux))
	id 1PqRoc-0006m0-HB
	for linux-perf-users@vger.kernel.org; Fri, 18 Feb 2011 15:00:14 +0000
In-Reply-To: <20110218145348.GA302@ghostprotocols.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: David Ahern <daahern@cisco.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, paulus@samba.org

On Fri, 2011-02-18 at 12:53 -0200, Arnaldo Carvalho de Melo wrote:
> 
> > So size should be changed to u64 rather than modifying the
> WARN_ON_ONCE?
> 
> Yeah, I guess so, 32-bit has to die it seems, gets in the way of
> testing
> :-) 

No!

1) don't use RAW unless you have to
2) you don't have to, goto 1
3) if you do anyway, ensure its properly padded
