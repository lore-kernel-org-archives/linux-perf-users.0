From: Harald Servat <harald.servat@bsc.es>
Subject: Sample memory references with at least a given latency?
Date: Wed, 04 Feb 2015 13:48:36 +0100
Message-ID: <54D21524.8010305@bsc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mao.bsc.es ([84.88.52.34]:44166 "EHLO opsmail01.bsc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752527AbbBDMsl (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 4 Feb 2015 07:48:41 -0500
Received: from localhost (localhost [127.0.0.1])
	by opsmail01.bsc.es (Postfix) with ESMTP id 4AF6380C55
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Feb 2015 13:48:38 +0100 (CET)
Received: from opsmail01.bsc.es ([127.0.0.1])
 by localhost (opswc01.bsc.es [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 22261-08 for <linux-perf-users@vger.kernel.org>;
 Wed,  4 Feb 2015 13:48:37 +0100 (CET)
Received: from opswc01.bsc.es (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by opsmail01.bsc.es (Postfix) with ESMTPS id AE628D0075
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Feb 2015 13:48:37 +0100 (CET)
Received: (from filter@localhost)
	by opswc01.bsc.es (8.13.6/8.13.6/Submit) id t14Cmbhk025768
	for linux-perf-users@vger.kernel.org; Wed, 4 Feb 2015 13:48:37 +0100
Received: from [10.111.69.211] (unknown [161.116.111.69])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by opsmail01.bsc.es (Postfix) with ESMTPSA id 2B387B85B2
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Feb 2015 13:48:37 +0100 (CET)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello list,

   is there any way to configure perf to sample memory references 
through PEBS and enable the Load Latency Performance Monitoring Facility 
(section 18.7.1.2 from the Intel 64 and IA-32 Architectures Software 
Developer's Manual).

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
