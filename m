From: Harald Servat <harald.servat@bsc.es>
Subject: Re: Information regarding the perf tool
Date: Thu, 12 Dec 2013 09:47:32 +0100
Message-ID: <52A97824.1050203@bsc.es>
References: <5266A57F.2000201@bsc.es> <87y55krw6f.fsf@tassilo.jf.intel.com> <52727B0C.5040402@bsc.es> <527287A7.3050908@gmail.com> <5272922E.20007@bsc.es> <52729FE5.3090109@gmail.com> <5277D8E1.9000009@bsc.es> <52A909C8.4060801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mao.bsc.es ([84.88.52.34]:48999 "EHLO opsmail01.bsc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064Ab3LLI4x (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 12 Dec 2013 03:56:53 -0500
In-Reply-To: <52A909C8.4060801@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On 12/12/13 01:56, David Ahern wrote:
> On 11/4/13, 10:26 AM, Harald Servat wrote:
>> On 31/10/13 19:22, David Ahern wrote:
>>> On 10/31/13, 11:23 AM, Harald Servat wrote:
>>>> Which is the relation between perf_clock() (or local_clock()) and
>>>> clock_gettime (CLOCK_MONOTONIC, ). Are they the same? If not, is
>>>> there a
>>>> way to correlate them? Or alternatively, is it possible to call
>>>> local_clock() from the userland?
>>>
>>> We still do not have a means of correlating perf_clock to time-of-day,
>>> monotonic or any other clock source. Still trying.
>>>
>>> Pawell Moll has a couple of patches posted -- one uses an ioctl to get
>>> perf_clock timestamps the other makes perf_clock accessible through
>>> clock_gettime. See attached.
>>>
>
> Coming back to this....
>
> Here is a module version of the posix clock approach:
>   https://github.com/dsahern/linux/blob/perf-full-monty/README.ahern
>
> As far as I can tell it works for 2.6.38 and forward and there should
> not be a conflict with the CLOCK_PERF id of 12. No need to patch and
> build your kernel, just build the module, load and go.
>
> That branch also has time-of-day hooks for record, report, script and
> sched.
>

Thank you very much David. Using a module instead of recompiling would 
be a very nice alternative. I'll give it a try.

WARNING / LEGAL TEXT: This message is intended only for the use of the
individual or entity to which it is addressed and may contain
information which is privileged, confidential, proprietary, or exempt
from disclosure under applicable law. If you are not the intended
recipient or the person responsible for delivering the message to the
intended recipient, you are strictly prohibited from disclosing,
distributing, copying, or in any way using this message. If you have
received this communication in error, please notify the sender and
destroy and delete any copies you may have received.

http://www.bsc.es/disclaimer
