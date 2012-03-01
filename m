From: Victor Jimenez <victor.javier@bsc.es>
Subject: Sampling instruction pointer on PPC
Date: Thu, 01 Mar 2012 18:08:10 +0100
Message-ID: <4F4FACFA.6080209@bsc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mao.bsc.es ([84.88.52.34]:40997 "EHLO opsmail01.bsc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757211Ab2CARIO (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 1 Mar 2012 12:08:14 -0500
Received: from localhost (localhost [127.0.0.1])
	by opsmail01.bsc.es (Postfix) with ESMTP id 04B17517BB
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Mar 2012 18:08:12 +0100 (CET)
Received: from opsmail01.bsc.es ([127.0.0.1])
 by localhost (opswc01.bsc.es [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 16030-10 for <linux-perf-users@vger.kernel.org>;
 Thu,  1 Mar 2012 18:08:11 +0100 (CET)
Received: from opswc01.bsc.es (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by opsmail01.bsc.es (Postfix) with ESMTPS id 3CE286FAB8
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Mar 2012 18:08:11 +0100 (CET)
Received: (from filter@localhost)
	by opswc01.bsc.es (8.13.6/8.13.6/Submit) id q21H8BT8018463
	for linux-perf-users@vger.kernel.org; Thu, 1 Mar 2012 18:08:11 +0100
Received: from [84.88.50.218] (unknown [84.88.50.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by opsmail01.bsc.es (Postfix) with ESMTPSA id 083BB517D8
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Mar 2012 18:08:11 +0100 (CET)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I am trying to sample instruction pointer along time on a Power7 system. 
I know that there are accurate mechanisms to do so in Intel processors 
(e.g., PEBS and Branch Trace Store).

Is it possible to do something similar in Power7? Will the samples be 
accurate? I am worried that significant delays (skids) may appear.

Thank you,
Victor

WARNING / LEGAL TEXT: This message is intended only for the use of the
individual or entity to which it is addressed and may contain
information which is privileged, confidential, proprietary, or exempt
from disclosure under applicable law. If you are not the intended
recipient or the person responsible for delivering the message to the
intended recipient, you are strictly prohibited from disclosing,
distributing, copying, or in any way using this message. If you have
received this communication in error, please notify the sender and
destroy and delete any copies you may have received.

http://www.bsc.es/disclaimer.htm
