From: Binary Huang <huang.bindi@163.com>
Subject: Using perf in ubuntu with xen hypervisor
Date: Mon, 11 Nov 2013 06:20:21 +0000 (UTC)
Message-ID: <loom.20131111T071612-703@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:34518 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752558Ab3KKGZH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 11 Nov 2013 01:25:07 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1Vfkvo-0006a0-H6
	for linux-perf-users@vger.kernel.org; Mon, 11 Nov 2013 07:25:05 +0100
Received: from 202.120.38.22 ([202.120.38.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2013 07:25:04 +0100
Received: from huang.bindi by 202.120.38.22 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2013 07:25:04 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi All!
I install perf in ubuntu 12.10. And when using the orginal kernel(3.5.0-40), 
perf works well. But when using kernel with xen 4.3, there are some events 
not supported, such as cycles, branches, instructions etc..

Are there anyone use perf in xen ??
