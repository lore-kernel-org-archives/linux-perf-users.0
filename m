From: David Ahern <dsahern@gmail.com>
Subject: Re: Using a new perf tool against an older kernel
Date: Thu, 23 Jun 2011 14:02:15 -0600
Message-ID: <4E039BC7.4050802@gmail.com>
References: <4E026123.4060208@fb.com> <4E034C2C.30509@gmail.com> <4E03968A.5010008@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:56272 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932670Ab1FWUCT (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 23 Jun 2011 16:02:19 -0400
In-Reply-To: <4E03968A.5010008@fb.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <asharma@fb.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org



On 06/23/2011 01:39 PM, Arun Sharma wrote:
> On 6/23/11 7:22 AM, David Ahern wrote:
> 
>> I have not seen issues like this using newer perf userspace against
>> older kernels. For example, my laptop was running Fedora 14 (2.6.35) and
>> now Fedora 15 (2.6.38.8) and I typically use latest perf builds (e.g.,
>> testing patches).
> 
> I narrowed it down to PERF_SAMPLE_RAW:
> 
> perf record -ag -- sleep 1
> 
> is fine, but:
> 
> perf record -agR -- sleep 1
> 
> fails for me most of the time. The reason I needed to use the -R in the
> first place is that "perf script" fails on older kernels with:
> 
> Samples do not contain timestamps.
> 
> With the newer perf, I don't get errors, but the timestamp field is
> invalid. So I need to use the -R flag to get valid timestamps +
> stacktraces out of "perf script".

That should have been fixed.

And -T on record gets the timestamps.

David

> 
>  -Arun
