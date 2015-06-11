From: Karthik M <byteblender@gmail.com>
Subject: perf report not showing symbols for .so built with -Ttext-segment linker option
Date: Thu, 11 Jun 2015 15:49:45 +0000 (UTC)
Message-ID: <loom.20150611T171926-311@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:55412 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198AbbFKQAI (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 11 Jun 2015 12:00:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1Z34tf-0008NO-DK
	for linux-perf-users@vger.kernel.org; Thu, 11 Jun 2015 18:00:03 +0200
Received: from c-50-184-253-21.hsd1.ca.comcast.net ([50.184.253.21])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2015 18:00:03 +0200
Received: from byteblender by c-50-184-253-21.hsd1.ca.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2015 18:00:03 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I have a program that dlopens() a libxx.so, jumps into it, and continues the
rest of the execution in it. libxx.so gets built with
-Ttext-segment,0x20400000. The problem I am facing is that perf report is
not showing the symbols in libxx.so. 

I added an empty infinite loop at the beginning, in the entry-point function
of libxx.so, so that all the cycles get spent in the entry-point function. 

When I use perf report to look the results of a perf record of the modified
entry-point, report  shows the correct offset of the infinite-loop jump
instruction, from the start of libxx.so, but it does not associate it with
the entry-point function name. I see that the entry-point function name is
available, when I look at it using the mapfile viewing option provided
inside perf report.

If I remove the "-Ttext-segment,0x20400000" option, then perf report shows
the entry-point function name correctly.

All this leads me to believe that perf record is correctly able to identify
the libxx.so .text start address, allowing it to report offsets correctly.
But perf report somehow is not able to figure out the .text start address of
libxx.so.

Is this correct ? If so, how do I get perf report to figure out the correct
start address for libxx.so ?

Thanks.

Karthik
