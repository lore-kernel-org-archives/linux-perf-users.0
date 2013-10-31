From: Harald Servat <harald.servat@bsc.es>
Subject: Re: Information regarding the perf tool
Date: Thu, 31 Oct 2013 18:23:58 +0100
Message-ID: <5272922E.20007@bsc.es>
References: <5266A57F.2000201@bsc.es> <87y55krw6f.fsf@tassilo.jf.intel.com> <52727B0C.5040402@bsc.es> <527287A7.3050908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mao.bsc.es ([84.88.52.34]:44502 "EHLO opsmail01.bsc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536Ab3JaRYA (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 31 Oct 2013 13:24:00 -0400
In-Reply-To: <527287A7.3050908@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>, Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

On 31/10/13 17:39, David Ahern wrote:
> On 10/31/13, 9:45 AM, Harald Servat wrote:
>> Can anyone point me where and how is the timestamp calculated for every
>> sample reported by perf?
>
>
> See perf_clock() in kernel/events/core.c
>
> David

Just another question.

Which is the relation between perf_clock() (or local_clock()) and 
clock_gettime (CLOCK_MONOTONIC, ). Are they the same? If not, is there a 
way to correlate them? Or alternatively, is it possible to call 
local_clock() from the userland?

Thank you in advance.

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
