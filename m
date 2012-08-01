From: Yipeng Huang <yipeng@gmail.com>
Subject: Using Perf Stat with --field-separator flag
Date: Wed, 1 Aug 2012 04:14:22 +0000 (UTC)
Message-ID: <loom.20120801T060325-224@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:49531 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814Ab2HAEOf (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 1 Aug 2012 00:14:35 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1SwQKP-0001kh-Ja
	for linux-perf-users@vger.kernel.org; Wed, 01 Aug 2012 06:14:34 +0200
Received: from cm244.omega17.maxonline.com.sg ([218.186.17.244])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Aug 2012 06:14:33 +0200
Received: from yipeng by cm244.omega17.maxonline.com.sg with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Aug 2012 06:14:33 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I would like to use the separator flag for easy exporting but face two issues. 

1) The standard perf stat output has elapsed time but the SEP output doesn't. 
How can I capture elapsed time AND use --field-separator at the same time? 

2) I also need to record CPU utilization. How do I derive this from the task-
clock field? 

Thanks, 

Yipeng 
