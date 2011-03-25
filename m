From: David Ahern <daahern@cisco.com>
Subject: Re: [PATCH] perf tools: Emit clearer message for sys_perf_event_open
 ENOENT return
Date: Fri, 25 Mar 2011 12:26:41 -0600
Message-ID: <4D8CDE61.6050400@cisco.com>
References: <1301076350-19593-1-git-send-email-daahern@cisco.com> <20110325180840.GE13180@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-3.cisco.com ([171.71.176.72]:46036 "EHLO
	sj-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754525Ab1CYS0q (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 25 Mar 2011 14:26:46 -0400
In-Reply-To: <20110325180840.GE13180@ghostprotocols.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, peterz@infradead.org, fweisbec@gmail.com, paulus@samba.org, tglx@linutronix.de



On 03/25/11 12:08, Arnaldo Carvalho de Melo wrote:
> Em Fri, Mar 25, 2011 at 12:05:50PM -0600, David Ahern escreveu:
>> Resend of patch sent back in January 2011 in light of recent confusion around
>> unsupported events for a given platform.
>>
>> Improve sys_perf_event_open ENOENT return handling in top and record, just
>> like 5a3446b does for stat.
>>
>> Retry of Arnaldo's patch using error instead of die which allows the fallback
>> from hardware cycles to software clock.
> 
> Please use ui__warning(""...) as it will work in the TUI too.

error() is consistent with current pattern. Is ui__warning the
preference for new messages? Is that for perf-top only?
