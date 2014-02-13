From: Harald Servat <harald.servat@bsc.es>
Subject: Latency = weigth in perf mem record/report?
Date: Thu, 13 Feb 2014 18:08:43 +0100
Message-ID: <52FCFC1B.1000703@bsc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mao.bsc.es ([84.88.52.34]:42070 "EHLO opsmail01.bsc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751968AbaBMRIr (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 13 Feb 2014 12:08:47 -0500
Received: from localhost (localhost [127.0.0.1])
	by opsmail01.bsc.es (Postfix) with ESMTP id 88957C328E
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2014 18:08:44 +0100 (CET)
Received: from opsmail01.bsc.es ([127.0.0.1])
 by localhost (opswc01.bsc.es [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 15871-10 for <linux-perf-users@vger.kernel.org>;
 Thu, 13 Feb 2014 18:08:43 +0100 (CET)
Received: from opswc01.bsc.es (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by opsmail01.bsc.es (Postfix) with ESMTPS id E24FDC0B36
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2014 18:08:43 +0100 (CET)
Received: (from filter@localhost)
	by opswc01.bsc.es (8.13.6/8.13.6/Submit) id s1DH8hYB026143
	for linux-perf-users@vger.kernel.org; Thu, 13 Feb 2014 18:08:43 +0100
Received: from [84.88.50.148] (bsccs203.int.bsc.es [84.88.50.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by opsmail01.bsc.es (Postfix) with ESMTPSA id C1487D5210
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2014 18:08:43 +0100 (CET)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Dear list,

   table 18-18 from the Vol 3b part 2 of the Intel=AE 64 and IA-32=20
Architectures  Software Developer=92s Manual (labeled as Table 18-18. P=
EBS=20
Record Format for Intel Core i7 Processor Family ) [1] indicates that=20
the PEBS samples report the latency value (in core cycles) for that=20
particular load/store that emitted the sample at the address 0xa8 from=20
the begin of the PEBS sample address.

   I've seen that there is a weight field in the output of the perf=20
report -D associated to the PERF_RECORD_SAMPLE. Looking at the kernel=20
code I found in file arch/x86/kernel/cpu/perf_event_intel_ds.c the=20
following code which seems to be storing the info I want

  819         /*
  820          * Use latency for weight (only avail with PEBS-LL)
  821          */
  822         if (fll && (sample_type & PERF_SAMPLE_WEIGHT))
  823             data.weight =3D pebs->lat;

   and then in tools/perf/builtin-mem.c the routine dump_raw_samples=20
seems to dump this info. Am I right? Can anyone kindly confirm this?

Thank you very much.

[1]=20
http://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-=
ia-32-architectures-software-developer-vol-3b-part-2-manual.pdf

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
