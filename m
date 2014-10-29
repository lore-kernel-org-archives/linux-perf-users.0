From: Hemendra Rawat <hkr1990@vt.edu>
Subject: Collect Per thread event count using perf
Date: Wed, 29 Oct 2014 02:03:36 +0000 (UTC)
Message-ID: <loom.20141029T024721-194@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:39318 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751062AbaJ2CKG (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 28 Oct 2014 22:10:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1XjIi4-0008Gw-HR
	for linux-perf-users@vger.kernel.org; Wed, 29 Oct 2014 03:10:04 +0100
Received: from c-71-62-159-173.hsd1.va.comcast.net ([71.62.159.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2014 03:10:04 +0100
Received: from hkr1990 by c-71-62-159-173.hsd1.va.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2014 03:10:04 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I'm new to perf. I want to use perf to collect cpu-cycles spent in 
each function for a multi-threaded program (Nasa Parallel Bench
marks OpenMP version).  

I'm using following commands to record and analyze the data. 

            # perf record -s --call-graph=dwarf ./my-program 10
            # perf report -T --call-graph=graph     

But the TUI interface that opens up doesn't give information on a 
per thread basis. It's all aggregate event count for each function. 
I'm not sure whether i'm recording the data in the wrong way or 
I'm missing something in the interpretation of perf output.  Can 
someone help me with this ? Any help will be highly appreciated.

Thanks
Hemendra
   
