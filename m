From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/3] perf events: fix WARN_ON_ONCE for 64-bit raw data,
 SW events
Date: Fri, 18 Feb 2011 12:00:21 +0100
Message-ID: <1298026821.5226.642.camel@laptop>
References: <1298008433-22911-1-git-send-email-daahern@cisco.com>
	 <1298008433-22911-2-git-send-email-daahern@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:52140 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550Ab1BRK7H (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 18 Feb 2011 05:59:07 -0500
Received: from j77219.upc-j.chello.nl ([24.132.77.219] helo=dyad.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.72 #1 (Red Hat Linux))
	id 1PqO3F-0000kc-IV
	for linux-perf-users@vger.kernel.org; Fri, 18 Feb 2011 10:59:05 +0000
In-Reply-To: <1298008433-22911-2-git-send-email-daahern@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <daahern@cisco.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, acme@ghostprotocols.net, paulus@samba.org

On Thu, 2011-02-17 at 22:53 -0700, David Ahern wrote:
> This check does not work out for 64-bit counter:
> 
>     sizeof(u32) + sizeof(u64) = 4 + 8 = 12
> 
> which does not pass the WARN_ON_ONCE test. I'm guessing (hoping
> really) that the intent is that the size of the raw data is a
> multiple of 4 bytes, not 8.

No the data must come in 8bytes strides.
