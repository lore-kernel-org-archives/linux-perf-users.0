From: Harald Servat <harald.servat@bsc.es>
Subject: Re: unable to get load latency info
Date: Mon, 03 Mar 2014 08:50:22 +0100
Message-ID: <5314343E.803@bsc.es>
References: <1393568679.86476.YahooMailNeo@web125402.mail.ne1.yahoo.com> <87bnxrcq0y.fsf@tassilo.jf.intel.com> <531095B3.3070800@bsc.es> <20140228164510.GU22728@two.firstfloor.org> <1393823578.5408.YahooMailNeo@web125402.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mao.bsc.es ([84.88.52.34]:52572 "EHLO opsmail01.bsc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752263AbaCCHu2 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 3 Mar 2014 02:50:28 -0500
In-Reply-To: <1393823578.5408.YahooMailNeo@web125402.mail.ne1.yahoo.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Muthusamy <muthu9283@yahoo.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On 03/03/14 06:12, Muthusamy wrote:
>> On 28/02/14 14:42, Andi Kleen wrote:
>
>> I don't think r100b is a valid event on Westmere.
>
> Thanks for the replies.
> As Harald Servat and others pointed I am now trying "perf mem record"
>
> [root@rafa cms]# ./perf mem record /bin/ls
> invalid or unsupported event: 'cpu/mem-loads/pp'
>
> Is this a issue with the (old) kernel version I am on or the CPU version or both.
>
> Regards,
> Muthusamy C

   I'm using

   Linux laptop 3.11.0-12-generic #19-Ubuntu SMP Wed Oct 9 16:20:46 UTC 
2013 x86_64 x86_64 x86_64 GNU/Linux

   so I imagine that you're ok with respect to OS. Now I remember I had 
to install some microcode module for my OS, though [2]. WRT hardware, 
I'm running on top of a

vendor_id	: GenuineIntel
cpu family	: 6
model		: 42
model name	: Intel(R) Core(TM) i7-2760QM CPU @ 2.40GHz
stepping	: 7

    Besides of that, the Intel Manual [1] says in section 18.7.1.1 that 
Nehalem (and I'd would guess Westmere, as it is a Nehalem successor) 
supports PEBS, so it should work.

Best regards.

[1] 
http://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-software-developer-vol-3b-part-2-manual.pdf
[2] http://packages.ubuntu.com/lucid/intel-microcode

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
