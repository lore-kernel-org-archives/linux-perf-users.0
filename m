From: Harald Servat <harald.servat@bsc.es>
Subject: Information regarding the perf tool
Date: Tue, 22 Oct 2013 18:19:11 +0200
Message-ID: <5266A57F.2000201@bsc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mao.bsc.es ([84.88.52.34]:54588 "EHLO opsmail01.bsc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753454Ab3JVQ0n (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 22 Oct 2013 12:26:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by opsmail01.bsc.es (Postfix) with ESMTP id 7208EB1600
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2013 18:19:11 +0200 (CEST)
Received: from opsmail01.bsc.es ([127.0.0.1])
 by localhost (opswc01.bsc.es [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 17597-01 for <linux-perf-users@vger.kernel.org>;
 Tue, 22 Oct 2013 18:19:10 +0200 (CEST)
Received: from opswc01.bsc.es (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by opsmail01.bsc.es (Postfix) with ESMTPS id A9C21AE4BF
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2013 18:19:10 +0200 (CEST)
Received: (from filter@localhost)
	by opswc01.bsc.es (8.13.6/8.13.6/Submit) id r9MGJAX2018915
	for linux-perf-users@vger.kernel.org; Tue, 22 Oct 2013 18:19:10 +0200
Received: from [84.88.50.148] (unknown [84.88.50.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by opsmail01.bsc.es (Postfix) with ESMTPSA id 850CA9132C
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2013 18:19:10 +0200 (CEST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Dear list,

    I'm wondering whether it be possible to extend the "perf mem" (tool) 
to emit the TSC of the sampling event?

    I started looking at the code, and I'd like to understand how does 
the perf tool work to extend that tool providing such functionality. 
However, I'm clueless on how the perf tool works. I have a machine with 
kernel 3.11.0 and its source code and within the source code in 
tools/perf/builtin-mem.c I observe that the application is somehow 
executed through "cmd_record ()" but I don't see the implementation of 
cmd_record() around. Would anyone on the list giving me some hints on 
how this is done?

   Additionally, it seems that perf.data is a file that mostly contains 
perf_event that represent the data gathered. It seems to be defined in 
include/linux/perf_event.h, but it doesn't seem to me a simple container 
for performance data. Is that the struct I'm looking for?

Thank you very much.
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
