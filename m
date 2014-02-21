From: Harald Servat <harald.servat@bsc.es>
Subject: Re: perf pebs sampling through stores + period is wrong?
Date: Fri, 21 Feb 2014 10:45:44 +0100
Message-ID: <53072048.5090405@bsc.es>
References: <5305E9AF.3050906@bsc.es> <87eh2xcw4h.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mao.bsc.es ([84.88.52.34]:35875 "EHLO opsmail01.bsc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754533AbaBUJpt (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 21 Feb 2014 04:45:49 -0500
In-Reply-To: <87eh2xcw4h.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

On 20/02/14 22:27, Andi Kleen wrote:
> Harald Servat <harald.servat@bsc.es> writes:
>>
>>    $ perf mem -t store record -c 10000 ./a.out
>>    ...
>>    [perf record: Woken up 4 times to write data]
>>    [perf record: Captured and wrote 0.921 MB perf.data (~40247 samples)]
>>
>>    Notice that the number of samples raised by 20x, which to me seems
>> very odd because the number of stores was half, so I expected 0.5x
>> here. Or am I supposing this the wrong way?
>
> Likely you're throttling. 10k is a far too low period for such
> measurements
>
> (The cpu can do multiple stores per cycle and it runs at multiple
> Ghz. Each PMI takes many thousands of cycles. You can do the math.)
>
> -Andi
>

Dear Andi,

   but then why the loads aren't throttling? There are far more loads in 
the app than stores (as seen in the perf stat results), but the loads do 
not throttle while store do? Of course, apps face different performance 
rate as apps run and there may be situations where the number of 
loads/second is either larger or smaller than stores/second, but still 
it is a bit confusing why so much difference between loads & stores. I 
would expect also the loads to throttle, then.

Regards.


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
