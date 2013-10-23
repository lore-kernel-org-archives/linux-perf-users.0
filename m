From: Harald Servat <harald.servat@bsc.es>
Subject: Re: Information regarding the perf tool
Date: Wed, 23 Oct 2013 15:51:32 +0200
Message-ID: <5267D464.5080801@bsc.es>
References: <5266A57F.2000201@bsc.es> <87y55krw6f.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mao.bsc.es ([84.88.52.34]:45665 "EHLO opsmail01.bsc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751855Ab3JWNve (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 23 Oct 2013 09:51:34 -0400
In-Reply-To: <87y55krw6f.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

On 23/10/13 14:47, Andi Kleen wrote:
> Harald Servat <harald.servat@bsc.es> writes:
>
>> Dear list,
>>
>>     I'm wondering whether it be possible to extend the "perf mem"
>> (tool) to emit the TSC of the sampling event?
>
> perf report -D reports everything, including time stamps.
>
> -Andi
>

Thank you very much for the pointer Andi. I see, the first data shown 
refers to the timestamp, but as returned by clock_gettime(). I was 
looking for the processor TSC, but I guess that this will work for now.

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
