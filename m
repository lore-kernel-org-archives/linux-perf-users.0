From: Chris Freehill <cfreehill@gmail.com>
Subject: perf stat -e cycles -p <pid> sleep 10
Date: Mon, 26 Nov 2012 22:50:13 +0000 (UTC)
Message-ID: <loom.20121126T234917-97@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:56972 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757346Ab2KZWyy (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 26 Nov 2012 17:54:54 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1Td7Zv-0008Dk-CJ
	for linux-perf-users@vger.kernel.org; Mon, 26 Nov 2012 23:55:03 +0100
Received: from gate-tx3.freescale.com ([192.88.168.1])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Nov 2012 23:55:03 +0100
Received: from cfreehill by gate-tx3.freescale.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Nov 2012 23:55:03 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

Apologies if the answer to this is someplace I have not looked. I've searched 
this list and other sites/FAQ's. 

I've noticed that command listed in the subject line always yields

<not counted> cycles

unless the target process is suspended. I have noticed this with a few different
distributions. Is the fact that the target process has to be suspended at least
once a known design limitation or would it be considered a bug?

Thank you for your help.

Chris
