From: Chris Freehill <cfreehill@gmail.com>
Subject: Re: perf stat -e cycles -p <pid> sleep 10
Date: Tue, 27 Nov 2012 12:25:41 +0000 (UTC)
Message-ID: <loom.20121127T131426-104@post.gmane.org>
References: <loom.20121126T234917-97@post.gmane.org> <50B461F4.10003@core.kaist.ac.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:57631 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822Ab2K0M0I (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 27 Nov 2012 07:26:08 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1TdKEs-0001jJ-Fr
	for linux-perf-users@vger.kernel.org; Tue, 27 Nov 2012 13:26:10 +0100
Received: from gate-tx3.freescale.com ([192.88.168.1])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Nov 2012 13:26:10 +0100
Received: from cfreehill by gate-tx3.freescale.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Nov 2012 13:26:10 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org


Chulmin Kim <cmkim <at> core.kaist.ac.kr> writes:
> What kind of distributions you've tested?
> 
> In my case(ubuntu 11.04), it works correctly.
> 
> I suspect your machine's PMU status, wrong installation, or missing perf 
> kernel module.

Thank you for the reply.

I had tested on Ubuntu 12.04 and the Freescale Linux version (power arch--
P5020). Upon your response, I retested, and you are correct. It does work as 
expected on Ubuntu, so there must be an issue on the other version only. 

I will investigate some of the leads you suggested. I am a newbie with perf 
and perf development, so the suggestions help.

Thanks again.
