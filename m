From: walimis <walimisdev@gmail.com>
Subject: how to get event sample data on vdso section?
Date: Fri, 14 Oct 2011 11:26:29 +0800
Message-ID: <20111014032629.GA12896@walimis-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:34166 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756003Ab1JNDpN (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 13 Oct 2011 23:45:13 -0400
Received: by wwn22 with SMTP id 22so203273wwn.1
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Oct 2011 20:45:12 -0700 (PDT)
Content-Disposition: inline
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: acme@ghostprotocols.net, mingo@elte.hu

hi,

I want to use perf to profile how many events are emitted on vdso section?
I followed the document Documentation/trace/tracepoint-analysis.txt to do that:

  $ perf record  -e cycles  -f ./hackbench 10 
  $ perf report

But I can't see any events emitted on vdso section. I used 2.6.34 
kernel and x86_32 host.

What's wrong with that? Could anyone give me some clues how to get 
events data on vdso section? 

Thanks a lot!
walimis
    
