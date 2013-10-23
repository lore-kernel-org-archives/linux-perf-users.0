From: Harald Servat <harald.servat@bsc.es>
Subject: Changing frequency rate to perf mem
Date: Wed, 23 Oct 2013 17:43:10 +0200
Message-ID: <5267EE8E.3020306@bsc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mao.bsc.es ([84.88.52.34]:50734 "EHLO opsmail01.bsc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222Ab3JWPnM (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 23 Oct 2013 11:43:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by opsmail01.bsc.es (Postfix) with ESMTP id D3A28AC5A5
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Oct 2013 17:43:10 +0200 (CEST)
Received: from opsmail01.bsc.es ([127.0.0.1])
 by localhost (opswc01.bsc.es [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 22619-05 for <linux-perf-users@vger.kernel.org>;
 Wed, 23 Oct 2013 17:43:10 +0200 (CEST)
Received: from opswc01.bsc.es (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by opsmail01.bsc.es (Postfix) with ESMTPS id 370B8B1702
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Oct 2013 17:43:10 +0200 (CEST)
Received: (from filter@localhost)
	by opswc01.bsc.es (8.13.6/8.13.6/Submit) id r9NFhA3L032179
	for linux-perf-users@vger.kernel.org; Wed, 23 Oct 2013 17:43:10 +0200
Received: from [84.88.50.148] (unknown [84.88.50.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by opsmail01.bsc.es (Postfix) with ESMTPSA id 0C735BD8A1
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Oct 2013 17:43:10 +0200 (CEST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello list,

   I'm interested on changing the frequency rate to the perf mem tool. I 
understand that this tool captures the data every N loads or stores, 
however I don't see how to tune N.

   I've looked into builtin-record.c approx line 980 and I found that 
changing rec->opts.freq allows me capturing more or less data. 
Initially, its value is 4000 and generates 4.5Mbytes for an application. 
If I modify this value to 200, it generates 0.2Mbytes, therefore 
200/4000 is closely 0.2/4.5 which seems the value I want to tune.

   I'd like to know what is this rec->opts.freq with respect to perf 
mem. I expected to setup the number of loads, therefore the higher N the 
lesser number of samples generated, but it seems the other way around. 
Where I can get any hint on what does this mean.

   BTW, I tried to change this value by adding "-F" and "200" into the 
argv that is passed to cmd_report by adding

         rec_argv[i++] = strdup("-F");
         rec_argv[i++] = strdup("200");

   into line 42 of perf-mem.c - just after the strdup("record"). 
Unfortunately, this seems to break something and perf segfaults often. 
Which is the most appropriate way to tune the user frequency of perf mem?

Thank you very much in advance!

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
