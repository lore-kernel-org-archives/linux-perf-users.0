From: Yuanfang Chen <tabloid.adroit@gmail.com>
Subject: measuring offcore events on snb
Date: Sat, 15 Sep 2012 17:50:23 +0000 (UTC)
Message-ID: <loom.20120915T194641-95@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:52222 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752471Ab2IORzE (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 15 Sep 2012 13:55:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1TCwa8-0001G6-5y
	for linux-perf-users@vger.kernel.org; Sat, 15 Sep 2012 19:55:04 +0200
Received: from c-68-82-250-225.hsd1.de.comcast.net ([68.82.250.225])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Sat, 15 Sep 2012 19:55:04 +0200
Received: from tabloid.adroit by c-68-82-250-225.hsd1.de.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Sat, 15 Sep 2012 19:55:04 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I'm trying to measure offcore events on snb. (kernel 3.6.0-rc3).  For example 
OFFCORE_RESPONSE.ALL_CODE_RD.LLC_HIT_N   is  0x10003C0244  according to 
intel manual. so I tried

perf stat -e r1b710003C0244 -- sleep 10
perf stat -e r10003C02441b7 -- sleep 10

both gives me 0, I did something wrong?

thank you so much,
yuanfang
