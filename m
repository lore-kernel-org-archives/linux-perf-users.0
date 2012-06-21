From: Hank <hankendi@gmail.com>
Subject: measuring L3cache misses
Date: Thu, 21 Jun 2012 07:36:59 +0000 (UTC)
Message-ID: <loom.20120621T093151-851@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:36290 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755033Ab2FUHhO (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 21 Jun 2012 03:37:14 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1Shbwz-0006FZ-5N
	for linux-perf-users@vger.kernel.org; Thu, 21 Jun 2012 09:37:09 +0200
Received: from wireless1x-168-122-5-26.bu.edu ([168.122.5.26])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Thu, 21 Jun 2012 09:37:09 +0200
Received: from hankendi by wireless1x-168-122-5-26.bu.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Thu, 21 Jun 2012 09:37:09 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,
I'm measuring L1-L2-L3 cache misses on AMD Magnycours server. 
I'm getting very high numbers for L3-miss numbers in comparison to L2-misses. 
In some cases L3misses are 30times higher than L2misses. 
Theoretically L1miss>L2miss>L3miss. 
Anyone have any idea what might be the reason for this? 

thanks
