From: AKel <ankelly006@hotmail.com>
Subject: Using perf to generate a call stack from a kernel function to the user space caller
Date: Tue, 20 Jan 2015 17:08:10 +0000 (UTC)
Message-ID: <loom.20150120T180008-930@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:45996 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752595AbbATRPH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 20 Jan 2015 12:15:07 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1YDcOO-0007JX-Iy
	for linux-perf-users@vger.kernel.org; Tue, 20 Jan 2015 18:15:04 +0100
Received: from 12.175-14-84.ripe.coltfrance.com ([84.14.175.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2015 18:15:04 +0100
Received: from ankelly006 by 12.175-14-84.ripe.coltfrance.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2015 18:15:04 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I'm trying to profile an application which is spending quite a bit of time 
in the kernel (~40% in do_raw_spin_lock for example). To fully understand 
what is happening I would like to generate a call stack using perf (or 
otherwise) to see where the calls to this function are originating from. 
Is this possible? My hands are slightly tied in that I don't have sudo 
access to the system I'm working on, so a solution which accounts for this 
would be greatly appreciated. Even transferring files to/from the system 
is very difficult so I'm rather restricted in what i can do.

Thanks,
A
