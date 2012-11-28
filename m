From: Shahina Rabbani <shahinarabbani.shaik@gmail.com>
Subject: Queries on using PERF tool
Date: Wed, 28 Nov 2012 05:47:52 +0000 (UTC)
Message-ID: <loom.20121128T064019-497@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:54169 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751031Ab2K1Fyz (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 28 Nov 2012 00:54:55 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1Tdabw-0006xo-0h
	for linux-perf-users@vger.kernel.org; Wed, 28 Nov 2012 06:55:04 +0100
Received: from 125.21.230.68 ([125.21.230.68])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Nov 2012 06:55:04 +0100
Received: from shahinarabbani.shaik by 125.21.230.68 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Nov 2012 06:55:04 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,
 
I am a new user of PERF tool. I have few questions to ask about the PERF tool.
Please help me with the answers.

Q1. Is it possible to use PERF tool on a piece of code? Say i have a process P1 
and the process has several functions F1, F2, F3. Is it possible to perform 
profilng only on F1 Function ??

Q2. Say i am using the PERF tool to counts some events depending on the clock 
value. If i change the clock value in between, then PERF tool can be able to 
understand the situation and generate the event counts according to the old and 
new clock values??


Please Help.

Thanks,
Shahina Rabbani
