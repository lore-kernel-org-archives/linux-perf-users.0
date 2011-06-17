From: David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH 3/6] perf: add reference time event
Date: Fri, 17 Jun 2011 08:28:44 -0600
Message-ID: <4DFB649C.8030303@gmail.com>
References: <1307490806-24548-1-git-send-email-dsahern@gmail.com> <1307490946-24673-1-git-send-email-dsahern@gmail.com> <20110617133230.GC25197@somewhere.redhat.com> <4DFB5F0B.4020903@gmail.com> <20110617141707.GE25197@somewhere.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59744 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758350Ab1FQO2s (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 17 Jun 2011 10:28:48 -0400
In-Reply-To: <20110617141707.GE25197@somewhere.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, peterz@infradead.org, paulus@samba.org, tglx@linutronix.de

On 06/17/2011 08:17 AM, Frederic Weisbecker wrote:
>>> We would like to avoid adding more custom events like these. They were very convenient
>>> but they steal the kernel event type space. They are deemed for removal in the long term.
>>>
>>> Another idea to achieve what you want would be to create a new perf event header feature,
>>> like HEADER_TRACE_INFO or HEADER_BUILD_ID are. Then use that to create a space in the perf
>>> file to save that couple of clocks initial values.
>>
>> you mean like this:
>> https://lkml.org/lkml/2010/12/7/813
>>
>> David
> 
> Exactly, why did you change?

As I recall suggestions on adding new clock events and using those for
periodic samples. Once we have the initial correlation (the point of
this patch) and updates to xtime (the new tracepoints) periodic events
should not be needed.

I'll go back to this option -- and address comments from that round as well.

David
