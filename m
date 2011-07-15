From: David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH] perf tools: fix endian conversion reading event attr
 from header
Date: Fri, 15 Jul 2011 10:02:42 -0600
Message-ID: <4E2064A2.10807@gmail.com>
References: <1310483959-23621-1-git-send-email-dsahern@gmail.com> <20110715154711.GB6590@somewhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46650 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753018Ab1GOQCq (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 15 Jul 2011 12:02:46 -0400
In-Reply-To: <20110715154711.GB6590@somewhere>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, peterz@infradead.org, paulus@samba.org

On 07/15/2011 09:47 AM, Frederic Weisbecker wrote:
>> -		if (perf_header__getbuffer64(header, fd, &f_attr, sizeof(f_attr)))
>> +		if (readn(fd, &f_attr, sizeof(f_attr)) <= 0)
>>  			goto out_errno;
>>  
>> +		if (header->needs_swap) {
>> +			f_attr.attr.type = bswap_32(f_attr.attr.type);
>> +			f_attr.attr.size = bswap_32(f_attr.attr.size);
>> +			mem_bswap_64(&f_attr.attr.config,
>> +				     sizeof(struct perf_event_attr) - 8);
>> +		}
>> +
> 
> Good catch!

A long, painful discovery

> But would be nice to also handle the wakeup_events and bp_type fields.
> 

I did not think those values were used in userspace, so did not touch
them. But then your inquiry pushed me into cscope and I found the
perf_event__attr_swap() function. I'll redo the patch leveraging the
swapping done there.

David
