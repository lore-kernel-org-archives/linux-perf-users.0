From: Ryan Heniser <ryan.heniser@rsp.com.au>
Subject: My options when vendor refuses to supply debug symbols
Date: Thu, 5 Nov 2015 05:14:18 +0000 (UTC)
Message-ID: <loom.20151105T061223-246@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:40453 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894AbbKEFUF (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 5 Nov 2015 00:20:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1ZuCxv-0005iU-Ed
	for linux-perf-users@vger.kernel.org; Thu, 05 Nov 2015 06:20:03 +0100
Received: from 210.5.33.41 ([210.5.33.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2015 06:20:03 +0100
Received: from ryan.heniser by 210.5.33.41 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2015 06:20:03 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

What options do we have when a third party vendor refuses to provide debug 
symbols because they fear it might leak IP? There code is compiled into one 
dynamic shared object. Is there a way to perf record the memory addresses 
such that I could pass them on to the company for them to convert to function 
signatures?

Kind regards,
Ryan
