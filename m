From: Hank <hankendi@gmail.com>
Subject: using perf lock
Date: Wed, 23 May 2012 15:42:42 +0000 (UTC)
Message-ID: <loom.20120523T174059-193@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:49662 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757036Ab2EWPpN (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 23 May 2012 11:45:13 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1SXDkI-0003SN-62
	for linux-perf-users@vger.kernel.org; Wed, 23 May 2012 17:45:06 +0200
Received: from novalis.bu.edu ([128.197.176.26])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 23 May 2012 17:45:06 +0200
Received: from hankendi by novalis.bu.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 23 May 2012 17:45:06 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I've been trying to use perf lock command on my Ubuntu 12.04, but I'm getting
this error:

invalid or unsupported event: 'lock:lock_acquire'

What might be the problem? Should I get the kernel source code? 

Thanks,
