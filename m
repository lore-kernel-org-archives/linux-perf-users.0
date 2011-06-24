From: David Ahern <dsahern@gmail.com>
Subject: Re: Using a new perf tool against an older kernel
Date: Thu, 23 Jun 2011 23:14:19 -0600
Message-ID: <4E041D2B.5020808@gmail.com>
References: <4E026123.4060208@fb.com> <4E034C2C.30509@gmail.com> <4E03968A.5010008@fb.com> <4E039BC7.4050802@gmail.com> <20110624001145.GE8058@somewhere.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:50845 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974Ab1FXFOW (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 24 Jun 2011 01:14:22 -0400
In-Reply-To: <20110624001145.GE8058@somewhere.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Arun Sharma <asharma@fb.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

On 06/23/2011 06:11 PM, Frederic Weisbecker wrote:
> On Thu, Jun 23, 2011 at 02:02:15PM -0600, David Ahern wrote:
>>
>>
>> On 06/23/2011 01:39 PM, Arun Sharma wrote:
>>> On 6/23/11 7:22 AM, David Ahern wrote:
>>>
>>>> I have not seen issues like this using newer perf userspace against
>>>> older kernels. For example, my laptop was running Fedora 14 (2.6.35) and
>>>> now Fedora 15 (2.6.38.8) and I typically use latest perf builds (e.g.,
>>>> testing patches).
>>>
>>> I narrowed it down to PERF_SAMPLE_RAW:
>>>
>>> perf record -ag -- sleep 1
>>>
>>> is fine, but:
>>>
>>> perf record -agR -- sleep 1
>>>
>>> fails for me most of the time. The reason I needed to use the -R in the
>>> first place is that "perf script" fails on older kernels with:
>>>
>>> Samples do not contain timestamps.
>>>
>>> With the newer perf, I don't get errors, but the timestamp field is
>>> invalid. So I need to use the -R flag to get valid timestamps +
>>> stacktraces out of "perf script".
>>
>> That should have been fixed.
>>
>> And -T on record gets the timestamps.
>>
>> David
> 
> Right, it would be nice to suggest that from perf script when timestamps
> are not recorded.

Timestamps are enabled by default, but that output option is removed if
the samples do not have timestamps. That message is generated if the
user requests timestamps (-f time) in the perf-script output and the
samples do not have timestamps, but Arun did not request that. Arun's
mileage with perf-3.0 definitely varies from what I've seen.

David
