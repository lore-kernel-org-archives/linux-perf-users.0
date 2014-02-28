From: Andi Kleen <andi@firstfloor.org>
Subject: Re: unable to get load latency info
Date: Fri, 28 Feb 2014 17:45:10 +0100
Message-ID: <20140228164510.GU22728@two.firstfloor.org>
References: <1393568679.86476.YahooMailNeo@web125402.mail.ne1.yahoo.com>
 <87bnxrcq0y.fsf@tassilo.jf.intel.com>
 <531095B3.3070800@bsc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:35643 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557AbaB1QpM (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 28 Feb 2014 11:45:12 -0500
Content-Disposition: inline
In-Reply-To: <531095B3.3070800@bsc.es>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Harald Servat <harald.servat@bsc.es>
Cc: Andi Kleen <andi@firstfloor.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

>   what do you mean by use-latency here? I understood that PEBS was
> able to report the number of core cycles that the load took to from
> some part of the memory hierarchy until it reached the CPU.

PEBS load/store latency reports the cycles from when the instruction
started issuing in the pipeline to the return of the value. That's not
quite the same, it can be much longer than the pure memory hierarchy
cost.

-Andi
