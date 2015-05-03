From: Harald Servat <harald.servat@bsc.es>
Subject: About using PEBS from the user space
Date: Mon, 04 May 2015 00:05:04 +0200
Message-ID: <55469B90.1090903@bsc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mao.bsc.es ([84.88.52.34]:36346 "EHLO opsmail01.bsc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751458AbbECWFN (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 3 May 2015 18:05:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by opsmail01.bsc.es (Postfix) with ESMTP id 86BE1DF0DC
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2015 00:05:09 +0200 (CEST)
Received: from opsmail01.bsc.es ([127.0.0.1])
 by localhost (opswc01.bsc.es [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 25816-07 for <linux-perf-users@vger.kernel.org>;
 Mon,  4 May 2015 00:05:09 +0200 (CEST)
Received: from opswc01.bsc.es (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by opsmail01.bsc.es (Postfix) with ESMTPS id 0BA27DD133
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2015 00:05:09 +0200 (CEST)
Received: (from filter@localhost)
	by opswc01.bsc.es (8.13.6/8.13.6/Submit) id t43M58iu012520
	for linux-perf-users@vger.kernel.org; Mon, 4 May 2015 00:05:08 +0200
Received: from [192.168.1.36] (17.Red-79-150-113.dynamicIP.rima-tde.net [79.150.113.17])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by opsmail01.bsc.es (Postfix) with ESMTPSA id BD9CAE4BE2
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2015 00:05:08 +0200 (CEST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Dear list,

   I'd like to use the perf library to access PEBS so as to collect 
referenced memory addresses from the user space. I think I've 
successfully setup the perf structures (struct perf_event_attr) to 
configure the performance counters, but I don't see what should I do to 
access to the captured memory addresses. I've seen that within 
arch/x86/kernel/cpu/perf_event_intel_ds.c there are the routines 
alloc_pebs_buffer, alloc_ds_buffer which seems to allocate and setup the 
necessary buffers using kmalloc_node calls. Question is, how can 
replicate this from the user space? And how we should connect these 
buffers to the PEBS infrastructure using perf calls?

Thank you very much in advance.

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
