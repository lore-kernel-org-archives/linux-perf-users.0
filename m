From: David Ahern <daahern@cisco.com>
Subject: Re: [PATCH 2/3] perf events: Introduce realtime clock event
Date: Fri, 18 Feb 2011 08:35:43 -0700
Message-ID: <4D5E91CF.60509@cisco.com>
References: <1298008433-22911-1-git-send-email-daahern@cisco.com>	 <1298008433-22911-3-git-send-email-daahern@cisco.com>	 <1298027641.5226.666.camel@laptop>  <4D5E84AC.4040104@cisco.com> <1298041106.5226.775.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-4.cisco.com ([171.68.10.86]:59939 "EHLO
	sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209Ab1BRPft (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 18 Feb 2011 10:35:49 -0500
In-Reply-To: <1298041106.5226.775.camel@laptop>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, acme@ghostprotocols.net, paulus@samba.org



On 02/18/11 07:58, Peter Zijlstra wrote:
> Well, but you can fix that, simply add PERF_SAMPLE_READ, no need to
> abuse the raw crap.
> 

Ok I see how this option works kernel side. It's not plumbed userspace side:
	if (type & PERF_SAMPLE_READ) {
		fprintf(stderr, "PERF_SAMPLE_READ is unsuported for now\n");
		return -1;
	}

I'll take a look at that.

David

> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
