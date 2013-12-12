From: David Ahern <dsahern@gmail.com>
Subject: Re: Information regarding the perf tool
Date: Wed, 11 Dec 2013 17:56:40 -0700
Message-ID: <52A909C8.4060801@gmail.com>
References: <5266A57F.2000201@bsc.es> <87y55krw6f.fsf@tassilo.jf.intel.com> <52727B0C.5040402@bsc.es> <527287A7.3050908@gmail.com> <5272922E.20007@bsc.es> <52729FE5.3090109@gmail.com> <5277D8E1.9000009@bsc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:62309 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000Ab3LLA4n (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 11 Dec 2013 19:56:43 -0500
Received: by mail-pd0-f180.google.com with SMTP id q10so10543265pdj.39
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Dec 2013 16:56:42 -0800 (PST)
In-Reply-To: <5277D8E1.9000009@bsc.es>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Harald Servat <harald.servat@bsc.es>
Cc: linux-perf-users@vger.kernel.org

On 11/4/13, 10:26 AM, Harald Servat wrote:
> On 31/10/13 19:22, David Ahern wrote:
>> On 10/31/13, 11:23 AM, Harald Servat wrote:
>>> Which is the relation between perf_clock() (or local_clock()) and
>>> clock_gettime (CLOCK_MONOTONIC, ). Are they the same? If not, is there a
>>> way to correlate them? Or alternatively, is it possible to call
>>> local_clock() from the userland?
>>
>> We still do not have a means of correlating perf_clock to time-of-day,
>> monotonic or any other clock source. Still trying.
>>
>> Pawell Moll has a couple of patches posted -- one uses an ioctl to get
>> perf_clock timestamps the other makes perf_clock accessible through
>> clock_gettime. See attached.
>>

Coming back to this....

Here is a module version of the posix clock approach:
  https://github.com/dsahern/linux/blob/perf-full-monty/README.ahern

As far as I can tell it works for 2.6.38 and forward and there should 
not be a conflict with the CLOCK_PERF id of 12. No need to patch and 
build your kernel, just build the module, load and go.

That branch also has time-of-day hooks for record, report, script and sched.

David
