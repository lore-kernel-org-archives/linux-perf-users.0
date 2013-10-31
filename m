From: Harald Servat <harald.servat@bsc.es>
Subject: Re: Information regarding the perf tool
Date: Thu, 31 Oct 2013 17:57:35 +0100
Message-ID: <52728BFF.30100@bsc.es>
References: <5266A57F.2000201@bsc.es> <87y55krw6f.fsf@tassilo.jf.intel.com> <52727B0C.5040402@bsc.es> <20131031164801.GY29695@two.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mao.bsc.es ([84.88.52.34]:49809 "EHLO opsmail01.bsc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753825Ab3JaQ5j (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 31 Oct 2013 12:57:39 -0400
In-Reply-To: <20131031164801.GY29695@two.firstfloor.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

On 31/10/13 17:48, Andi Kleen wrote:
>>    In fact, I expected that for each entry into the PEBS a handler
>> would be executed, but Intel documentations points that to use PEBS
>> the tool (here perf) needs to allocate space for multiple PEBS
>> entries, so the when the handler is invoked there may be multiple
>> entries in the buffer, which makes things a little more obscure.
>
> perf always uses threshold 1 for the PEBS buffer.
>
> But yes there is some delay until the handler executes, and the
> time stamp is only computed in the handler.
>


David, Andi,

   thank you for your valuable comments, they're really helpful.

   David, wrt to the clock, which actually calls local_clock() I'm a bit 
worried about the comment in sched/clock.c

  * Similar to cpu_clock() for the current cpu. Time will only be observed
  * to be monotonic if care is taken to only compare timestampt taken on the
  * same CPU.

   I'll rerun my experiments making sure that I pin the processes to a 
single CPU.

Again, thank you!

-- 


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
