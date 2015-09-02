From: David Ahern <dsahern@gmail.com>
Subject: Re: Understanding timestamps in perf.data
Date: Wed, 2 Sep 2015 13:25:51 -0600
Message-ID: <55E74D3F.4040705@gmail.com>
References: <55E6C120.3030504@kit.edu> <55E6FCF9.60403@gmail.com>
 <55E71351.8010507@kit.edu> <55E72762.6030209@gmail.com>
 <87oahk4ock.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36913 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755206AbbIBTZx (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 2 Sep 2015 15:25:53 -0400
Received: by igbni9 with SMTP id ni9so22328825igb.0
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Sep 2015 12:25:52 -0700 (PDT)
In-Reply-To: <87oahk4ock.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Dennis Gnad <dennis.gnad@kit.edu>, linux-perf-users@vger.kernel.org

On 9/2/15 1:23 PM, Andi Kleen wrote:
> David Ahern <dsahern@gmail.com> writes:
>>
>> The counter values are not relevant for profiling. They are programmed
>> to rollover and generate an NMI which causes the sample to be taken.
>
> Actually it's relevent if you use adaptive frequency mode
> (-F or default, not using -c) because it varies then.

In all cases the counters are set to rollover for profiling mode.
