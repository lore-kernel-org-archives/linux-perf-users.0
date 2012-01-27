From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: perf: prctl(PR_TASK_PERF_EVENTS_DISABLE) has no effect
Date: Fri, 27 Jan 2012 18:12:43 +0100
Message-ID: <1327684363.2446.176.camel@twins>
References: <4F22D8D9.3010108@rgmadvisors.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:34932 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957Ab2A0RM5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 27 Jan 2012 12:12:57 -0500
In-Reply-To: <4F22D8D9.3010108@rgmadvisors.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andrew Steets <asteets@rgmadvisors.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>

On Fri, 2012-01-27 at 11:03 -0600, Andrew Steets wrote:
> Can anyone tell
> me if I'm using this wrong or if this is a bug? 

You're using it wrong, it will disable events you own (created) not
events that monitor you.
