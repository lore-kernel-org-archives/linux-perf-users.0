From: David Ahern <daahern@cisco.com>
Subject: Re: [PATCH 1/5] perf events: add support for realtime clock attribute
Date: Sun, 20 Mar 2011 13:49:18 -0600
Message-ID: <4D865A3E.9040605@cisco.com>
References: <1300647277-8431-1-git-send-email-daahern@cisco.com> <1300647277-8431-2-git-send-email-daahern@cisco.com> <alpine.LFD.2.00.1103202000500.2787@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-5.cisco.com ([171.68.10.87]:39869 "EHLO
	sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240Ab1CTTtV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 20 Mar 2011 15:49:21 -0400
In-Reply-To: <alpine.LFD.2.00.1103202000500.2787@localhost6.localdomain6>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, peterz@infradead.org, fweisbec@gmail.com, paulus@samba.org



On 03/20/11 13:08, Thomas Gleixner wrote:
> On Sun, 20 Mar 2011, David Ahern wrote:
>> +
>> +	if (sample_type & PERF_SAMPLE_REALTIME)
>> +		data->realtime = ktime_to_ns(ktime_get_real());
> 
> That's going to live lock on any sample which happens to hit in a
> xtime_lock write locked section. I knew why I suggested adding
> tracepoints to the timekeeping code :)

Hmmm.... Can you give an example of when perf samples could be generated
with xtime write locked? What are the rules for when ktime_get_real can
be invoked?

David

> 
> Thanks,
> 
> 	tglx
