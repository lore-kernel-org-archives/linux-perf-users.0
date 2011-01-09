From: David Ahern <daahern@cisco.com>
Subject: Re: [PATCH] perf stat: fix scale option
Date: Sun, 09 Jan 2011 13:21:01 -0700
Message-ID: <4D2A18AD.6020406@cisco.com>
References: <1294595425-16791-1-git-send-email-daahern@cisco.com> <20110109194919.GC28554@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-2.cisco.com ([171.71.176.71]:47158 "EHLO
	sj-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122Ab1AIUVE (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 9 Jan 2011 15:21:04 -0500
In-Reply-To: <20110109194919.GC28554@elte.hu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: a.p.zijlstra@chello.nl, paulus@samba.org, acme@ghostprotocols.net, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org



On 01/09/11 12:49, Ingo Molnar wrote:
> 
> * David Ahern <daahern@cisco.com> wrote:
> 
>> The scale option defaults to true and the command line option only
>> allows it to be set to true. ie. the option is a no-op.
> 
> Hm, the option parser should already allow --no-scale. Does that not work for you?
> 
> Thanks,
> 
> 	Ingo

Indeed it does work; I was not aware of that option. What about the '-c'
option being a no-op?

David
