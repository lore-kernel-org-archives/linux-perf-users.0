From: Harald Servat <harald.servat@bsc.es>
Subject: Re: Sample LLC miss references?
Date: Thu, 08 Jan 2015 10:08:00 +0100
Message-ID: <54AE48F0.6070702@bsc.es>
References: <54A295A5.9030408@bsc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mao.bsc.es ([84.88.52.34]:37575 "EHLO opsmail01.bsc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753641AbbAHJIG (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 8 Jan 2015 04:08:06 -0500
Received: from localhost (localhost [127.0.0.1])
	by opsmail01.bsc.es (Postfix) with ESMTP id 7B4F5B5CC8
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2015 10:08:02 +0100 (CET)
Received: from opsmail01.bsc.es ([127.0.0.1])
 by localhost (opswc01.bsc.es [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 20640-07 for <linux-perf-users@vger.kernel.org>;
 Thu,  8 Jan 2015 10:08:01 +0100 (CET)
Received: from opswc01.bsc.es (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by opsmail01.bsc.es (Postfix) with ESMTPS id 3A553AEE62
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2015 10:08:01 +0100 (CET)
Received: (from filter@localhost)
	by opswc01.bsc.es (8.13.6/8.13.6/Submit) id t08981YD029271
	for linux-perf-users@vger.kernel.org; Thu, 8 Jan 2015 10:08:01 +0100
Received: from [84.88.50.148] (bsccs203.int.bsc.es [84.88.50.148])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by opsmail01.bsc.es (Postfix) with ESMTPSA id 1DBD4809A5
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2015 10:08:01 +0100 (CET)
In-Reply-To: <54A295A5.9030408@bsc.es>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>


On 30/12/14 13:08, Harald Servat wrote:
> Dear list,
>
>    I'd like to use PEBS to sample only misses at LLC on my Intel(R)
> Core(TM) i7-2760QM CPU.
>
>    I've been digging into section 18.4.4 of the Intel=AE 64 and IA-32
> Architectures Developer's Manual: Vol. 3B and I've found that
> MEM_LOAD_RETIRED does not include LLC_MISSES in that event. However, =
in
> Table 19-13 (Section 19.6) the LLC_MISSES can be reported by setting
> umask 0x10. Since I'm interested on this particular counter, I guess
> that I cannot use perf mem command and I've have to stick with perf, =
am
> I right?
>
>    In order to test this, I've modified the stream benchmark so that =
the
> accesses are random in each of the four kernels (copy, scale, add and
> triad) in order to reduce the spatial&temporal localities.
>
>    So if I run
>
>    # Capture MEM_LOAD_RETIRED.L2_HIT
>    perf record -c 1 -e r02cb ./stream.rand
>
>    The number of captured samples is about 2M.
>
>    However, if I run
>
>    # Capture MEM_LOAD_RETIRED.L3_MISS
>    perf record -c 1 -e r10cb ./stream.rand
>
>    then I get 0 samples. Is that a demonstration that it's impossible=
 to
> capture precise misses at L3? If so, is there any alternative to do
> that? Could I use the latency to bring the data from the memory
> hierarchy instead?
>
> Thank you very much, and happy new year!
>

   Any thoughts on this?

Thank you very much.



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
