From: caobenzhi <caobenzhi0915@gmail.com>
Subject: how to see glibc symbol when using perf to profile programs
Date: Thu, 26 Sep 2013 01:26:39 +0000 (UTC)
Message-ID: <loom.20130926T032429-925@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:50751 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107Ab3IZBaG (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 25 Sep 2013 21:30:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1VP0P5-0007qs-NK
	for linux-perf-users@vger.kernel.org; Thu, 26 Sep 2013 03:30:03 +0200
Received: from 52.201.35.8.gae.googleusercontent.com ([8.35.201.52])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2013 03:30:03 +0200
Received: from caobenzhi0915 by 52.201.35.8.gae.googleusercontent.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2013 03:30:03 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi, everyone~ recently I use perf to see the bottleneck of my program. 
But I encounter a problem: I cann't use which function in glibc was called.
The command I use were like follows:
perf record -g ./wc ~/data/wc/10MB.txt -n 1
perf report -g
And the results I get were like follows:
48.13%  wc  libc-2.15.so                 [.] 0x000000000008c5a9
12.29%  wc  [kernel.kallsyms]         [k] clear_page_c
Also when I enter the libc-2.15.so, the results were as follows:
48.13%  wc  libc-2.15.so                 [.] 0x000000000008c5a9         
   + 0x7f5adf1a05bd                                                       
   + 0x7f5adf1a05a9                                                        
   + 0x7f5adf245e5e                                                        
     0x7f5adf26231e                                                        
     0x1                                                                   
     0x7f5adf2622e6                                                        
     0x1         
I cann't see which functions in glibc was called. 
Do anyone who know how to fix that problem?
Thanks a lot~
Emily
