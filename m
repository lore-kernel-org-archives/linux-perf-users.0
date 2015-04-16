From: Harald Servat <harald.servat@bsc.es>
Subject: perf message in dmesg
Date: Thu, 16 Apr 2015 10:02:08 +0200
Message-ID: <552F6C80.2000005@bsc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mao.bsc.es ([84.88.52.34]:45978 "EHLO opsmail01.bsc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757020AbbDPIMF (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 16 Apr 2015 04:12:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by opsmail01.bsc.es (Postfix) with ESMTP id EF347DE7C3
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2015 10:02:09 +0200 (CEST)
Received: from opsmail01.bsc.es ([127.0.0.1])
 by localhost (opswc01.bsc.es [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 03665-02 for <linux-perf-users@vger.kernel.org>;
 Thu, 16 Apr 2015 10:02:09 +0200 (CEST)
Received: from opswc01.bsc.es (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by opsmail01.bsc.es (Postfix) with ESMTPS id 94C31DED19
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2015 10:02:09 +0200 (CEST)
Received: (from filter@localhost)
	by opswc01.bsc.es (8.13.6/8.13.6/Submit) id t3G829Nr004677
	for linux-perf-users@vger.kernel.org; Thu, 16 Apr 2015 10:02:09 +0200
Received: from [84.88.51.110] (bsccs203.int.bsc.es [84.88.51.110])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by opsmail01.bsc.es (Postfix) with ESMTPSA id 6623FF93E8
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2015 10:02:09 +0200 (CEST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hello,

   I've been using the perf mem record command recently, and I've just 
noticed this message in the dmesg?

   What does it mean?

[  157.538495] perf samples too long (2504 > 2500), lowering
kernel.perf_event_max_sample_rate to 50000

Thank you very much in advance

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
