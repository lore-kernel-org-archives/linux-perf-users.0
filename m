From: Harald Servat <harald.servat@bsc.es>
Subject: Interference between perf record and PAPI in sampling mode
Date: Wed, 30 Oct 2013 11:43:47 +0100
Message-ID: <5270E2E3.2050201@bsc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mao.bsc.es ([84.88.52.34]:44882 "EHLO opsmail01.bsc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644Ab3J3Knw (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 30 Oct 2013 06:43:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by opsmail01.bsc.es (Postfix) with ESMTP id 3F294C02B1
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Oct 2013 11:43:49 +0100 (CET)
Received: from opsmail01.bsc.es ([127.0.0.1])
 by localhost (opswc01.bsc.es [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 27537-04-3 for <linux-perf-users@vger.kernel.org>;
 Wed, 30 Oct 2013 11:43:47 +0100 (CET)
Received: from opswc01.bsc.es (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by opsmail01.bsc.es (Postfix) with ESMTPS id AAA3D8306D
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Oct 2013 11:43:47 +0100 (CET)
Received: (from filter@localhost)
	by opswc01.bsc.es (8.13.6/8.13.6/Submit) id r9UAhlf9028248
	for linux-perf-users@vger.kernel.org; Wed, 30 Oct 2013 11:43:47 +0100
Received: from [84.88.50.148] (unknown [84.88.50.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by opsmail01.bsc.es (Postfix) with ESMTPSA id 842609C825
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Oct 2013 11:43:47 +0100 (CET)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Dear all,

   I'd like to run some experiments using perf record command while 
running some other experiments with PAPI library [1] in sampling mode. I 
found that in kernel 3.11.0, if I sample an application using 
PAPI_overflow on a hardware counter (PAPI_TOT_INS, for instance), then 
the following command I execute through perf mem record raises the 
following error.

Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument) 
for event (cpu/mem-loads/pp).
/bin/dmesg may provide additional information.
No CONFIG_PERF_EVENTS=y kernel support configured?

   It seems evident that there's an interference between the two. Can 
anyone enlighten me on how to debug this a bit just to hunt for this bug 
(if it's a bug, and not a feature)?

Thank you very much!

[1] http://icl.cs.utk.edu/papi/

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
