From: Harald Servat <harald.servat@bsc.es>
Subject: Sample LLC miss references?
Date: Tue, 30 Dec 2014 13:08:05 +0100
Message-ID: <54A295A5.9030408@bsc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mao.bsc.es ([84.88.52.34]:58395 "EHLO opsmail01.bsc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977AbaL3MQ2 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 30 Dec 2014 07:16:28 -0500
Received: from localhost (localhost [127.0.0.1])
	by opsmail01.bsc.es (Postfix) with ESMTP id C17F8885A4
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Dec 2014 13:08:36 +0100 (CET)
Received: from opsmail01.bsc.es ([127.0.0.1])
 by localhost (opswc01.bsc.es [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 23681-10 for <linux-perf-users@vger.kernel.org>;
 Tue, 30 Dec 2014 13:08:09 +0100 (CET)
Received: from opswc01.bsc.es (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by opsmail01.bsc.es (Postfix) with ESMTPS id 258F6B5A7C
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Dec 2014 13:08:09 +0100 (CET)
Received: (from filter@localhost)
	by opswc01.bsc.es (8.13.6/8.13.6/Submit) id sBUC89VS012934
	for linux-perf-users@vger.kernel.org; Tue, 30 Dec 2014 13:08:09 +0100
Received: from [192.168.1.35] (105.Red-83-53-16.dynamicIP.rima-tde.net [83.53.16.105])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by opsmail01.bsc.es (Postfix) with ESMTPSA id DD9FCED085
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Dec 2014 13:08:08 +0100 (CET)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Dear list,

   I'd like to use PEBS to sample only misses at LLC on my Intel(R)=20
Core(TM) i7-2760QM CPU.

   I've been digging into section 18.4.4 of the Intel=AE 64 and IA-32=20
Architectures Developer's Manual: Vol. 3B and I've found that=20
MEM_LOAD_RETIRED does not include LLC_MISSES in that event. However, in=
=20
Table 19-13 (Section 19.6) the LLC_MISSES can be reported by setting=20
umask 0x10. Since I'm interested on this particular counter, I guess=20
that I cannot use perf mem command and I've have to stick with perf, am=
=20
I right?

   In order to test this, I've modified the stream benchmark so that th=
e=20
accesses are random in each of the four kernels (copy, scale, add and=20
triad) in order to reduce the spatial&temporal localities.

   So if I run

   # Capture MEM_LOAD_RETIRED.L2_HIT
   perf record -c 1 -e r02cb ./stream.rand

   The number of captured samples is about 2M.

   However, if I run

   # Capture MEM_LOAD_RETIRED.L3_MISS
   perf record -c 1 -e r10cb ./stream.rand

   then I get 0 samples. Is that a demonstration that it's impossible t=
o=20
capture precise misses at L3? If so, is there any alternative to do=20
that? Could I use the latency to bring the data from the memory=20
hierarchy instead?

Thank you very much, and happy new year!

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
