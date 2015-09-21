From: Harris <mhmughees@gmail.com>
Subject: Perf Hardware Counters Android
Date: Mon, 21 Sep 2015 07:54:49 +0000 (UTC)
Message-ID: <loom.20150921T094733-948@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:38024 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756191AbbIUIuJ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 21 Sep 2015 04:50:09 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1ZdwnV-0004Us-6r
	for linux-perf-users@vger.kernel.org; Mon, 21 Sep 2015 10:50:07 +0200
Received: from wf099-128.ust.hk ([175.159.99.128])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2015 10:50:05 +0200
Received: from mhmughees by wf099-128.ust.hk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2015 10:50:05 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I have compiled AOSP which includes perf tool. 
Later I pushed this compiled perf module into 
production build on my MotoG device. 
Now I am able to run perf command however perf top 
command only shows empty layout of table with no entry. 
Similarly I found I can to record and 
stat for software events only. 
While hardware events like "cycles" are not recorded. 

I wonder if it is not possible to use perf with production
built android or do I need to configure something.
Please help me out.
