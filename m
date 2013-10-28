From: Harald Servat <harald.servat@bsc.es>
Subject: Re: Changing frequency rate to perf mem
Date: Mon, 28 Oct 2013 09:15:35 +0100
Message-ID: <526E1D27.5070302@bsc.es>
References: <5267EE8E.3020306@bsc.es> <87ppqvs15r.fsf@tassilo.jf.intel.com>	<5268D0B9.50704@bsc.es> <87sivl99do.fsf@sejong.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mao.bsc.es ([84.88.52.34]:49419 "EHLO opsmail01.bsc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045Ab3J1IPm (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 28 Oct 2013 04:15:42 -0400
In-Reply-To: <87sivl99do.fsf@sejong.aot.lge.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org


>> I think that this could be implemented extending the mem_options[] in
>> file builtin-mem.c lines 205-221.
>
> Or else, use 'perf record' directly as Andi suggested.
>
>>
>>> Alternatively you can just specify the command line perf mem record
>>> would specify directly to perf record, plus -c/-F
>
>    $ perf record -Wd -e cpu/mem-loads/pp -F 200 -- ls
>
>    $ perf mem report
>

Wow, thank you for such details! I'll take a look at this!

Best regards.


> Thanks,
> Namhyung
>


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
