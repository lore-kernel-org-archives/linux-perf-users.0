From: David Ahern <daahern@cisco.com>
Subject: Re: [PATCH 1/3] perf events: fix WARN_ON_ONCE for 64-bit raw data,
 SW events
Date: Fri, 18 Feb 2011 07:33:28 -0700
Message-ID: <4D5E8338.8010602@cisco.com>
References: <1298008433-22911-1-git-send-email-daahern@cisco.com>	 <1298008433-22911-2-git-send-email-daahern@cisco.com> <1298026821.5226.642.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-3.cisco.com ([171.71.176.72]:33758 "EHLO
	sj-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042Ab1BROd2 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 18 Feb 2011 09:33:28 -0500
In-Reply-To: <1298026821.5226.642.camel@laptop>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, acme@ghostprotocols.net, paulus@samba.org



On 02/18/11 04:00, Peter Zijlstra wrote:
> On Thu, 2011-02-17 at 22:53 -0700, David Ahern wrote:
>> This check does not work out for 64-bit counter:
>>
>>     sizeof(u32) + sizeof(u64) = 4 + 8 = 12
>>
>> which does not pass the WARN_ON_ONCE test. I'm guessing (hoping
>> really) that the intent is that the size of the raw data is a
>> multiple of 4 bytes, not 8.
> 
> No the data must come in 8bytes strides.
> 

Then the sizeof the size field needs to be moved to u64; right now it is
u32:

struct perf_raw_record {
    u32             size;
    void                *data;
};

So size should be changed to u64 rather than modifying the WARN_ON_ONCE?


Another gotcha is in perf_output_sample there is:
            struct {
                u32 size;
                u32 data;
            } raw = {
                .size = sizeof(u32),
                .data = 0,
            };

While that meets the 8-byte stride I was concerned that changing the
size field to u64 breaks ABI.

David
