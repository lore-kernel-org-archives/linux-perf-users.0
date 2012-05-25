From: Hank <hankendi@bu.edu>
Subject: perf event "instructions"
Date: Fri, 25 May 2012 02:46:15 +0000 (UTC)
Message-ID: <loom.20120525T044121-415@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46921 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754889Ab2EYCuI (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 24 May 2012 22:50:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1SXkbN-0005qB-Jx
	for linux-perf-users@vger.kernel.org; Fri, 25 May 2012 04:50:05 +0200
Received: from c-24-128-76-83.hsd1.ma.comcast.net ([24.128.76.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Fri, 25 May 2012 04:50:05 +0200
Received: from hankendi by c-24-128-76-83.hsd1.ma.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Fri, 25 May 2012 04:50:05 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I've collected number of instructions using predefined event named
"instructions" and also collected using the raw event (register and unit mask)
for instructions retired. Although they are similar, outputs are not the exactly
the same. 

Can anyone explain me what is the built-in event "instructions" measuring? If it
is the number of retired instructions, then what might be the reason for getting
different output when I use the raw event number?

Thanks a lot,
