From: David Ahern <daahern@cisco.com>
Subject: Re: [PATCH 1/3] perf events: fix WARN_ON_ONCE for 64-bit raw data,
 SW events
Date: Fri, 18 Feb 2011 08:28:22 -0700
Message-ID: <4D5E9016.4070808@cisco.com>
References: <1298008433-22911-1-git-send-email-daahern@cisco.com>	 <1298008433-22911-2-git-send-email-daahern@cisco.com>	 <1298026821.5226.642.camel@laptop>  <4D5E8338.8010602@cisco.com> <1298040938.5226.771.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-6.cisco.com ([171.71.176.117]:27445 "EHLO
	sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389Ab1BRP2Y (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 18 Feb 2011 10:28:24 -0500
In-Reply-To: <1298040938.5226.771.camel@laptop>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, acme@ghostprotocols.net, paulus@samba.org



On 02/18/11 07:55, Peter Zijlstra wrote:
>> Another gotcha is in perf_output_sample there is:
>>             struct {
>>                 u32 size;
>>                 u32 data;
>>             } raw = {
>>                 .size = sizeof(u32),
>>                 .data = 0,
>>             };
>>
>> While that meets the 8-byte stride I was concerned that changing the
>> size field to u64 breaks ABI.
> 
> It would.
> 
> No, what you need to do is provide data that is sized such that it
> matches the 8b stride adding padding where needed.

I want to push a 64-bit counter to userspace. By definition it meets the
8-byte stride. Now how do I get sizeof(size field) + sizeof(data) to
meet an 8-byte stride? I can't when sizeof(size field) = 4. Ok, I can
pad the data with 4 bytes, but then I an api to tell the user to strip
the 4-byte pad. Seems like an odd way to go.

Why is an 8-byte stride preferred over a 4-bytes?

David

> 
> Anyway, I don't think you need RAW at all.
> 
