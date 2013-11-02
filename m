From: caobenzhi <caobenzhi0915@gmail.com>
Subject: memory read/write access counts event in perf
Date: Sat, 2 Nov 2013 09:25:25 +0000 (UTC)
Message-ID: <loom.20131102T102049-521@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:33015 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751596Ab3KBJZs (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 2 Nov 2013 05:25:48 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1VcXSk-0005aD-Cf
	for linux-perf-users@vger.kernel.org; Sat, 02 Nov 2013 10:25:47 +0100
Received: from 222.195.92.204 ([222.195.92.204])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Sat, 02 Nov 2013 10:25:46 +0100
Received: from caobenzhi0915 by 222.195.92.204 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Sat, 02 Nov 2013 10:25:46 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,everyone~ 
Recently I want to use perf to count the memory read/write access times, but 
when I use perf list|help, I can't find corresponding events? Does perf 
cannot be used to count memory access times? Any help will be appreciated, 
thanks a lot~
Best
