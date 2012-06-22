From: David Ahern <dsahern@gmail.com>
Subject: Re: --mmap-pages option seemingly has no effect to help with LOST
 samples
Date: Fri, 22 Jun 2012 13:44:33 -0600
Message-ID: <4FE4CB21.90005@gmail.com>
References: <4FD7ACB9.70205@us.ibm.com> <4FD7AF0C.1030300@gmail.com> <4FD8B32C.60608@us.ibm.com> <4FD8B641.9040907@gmail.com> <4FE49663.7000908@us.ibm.com> <4FE49A6F.7020503@gmail.com> <4FE4C589.5080802@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43201 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756384Ab2FVTog (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 22 Jun 2012 15:44:36 -0400
Received: by dady13 with SMTP id y13so2739640dad.19
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Jun 2012 12:44:36 -0700 (PDT)
In-Reply-To: <4FE4C589.5080802@us.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Maynard Johnson <maynardj@us.ibm.com>
Cc: linux-perf-users@vger.kernel.org, suka@us.ibm.com

On 6/22/12 1:20 PM, Maynard Johnson wrote:
> I was seeing this on both my Intel Core 2 Duo and an IBM POWER7 server, both running RHEL 6.2.  Also tried on another POWER7 running RHEL 6.3 beta, and got the same results.  I found another POWER server that had RHEL 6.2 but was temporarily booted on a 3.5 kernel and ran the test there -- the counts were good there. :-)  Just to be sure, I rebooted that system to the stock RHEL 6.2 kernel and reproduced the problem.  So it seems there's an upstream fix for this.  Can someone help me find the commit?

emails crossing in the ether.

2.6.32 is real early in the perf history. I flipped a system to the 
Fedora 14 2.6.35.14 kernel -- and it does not handle multiple events 
either. With Arnaldo's last updates I did notice something curious about 
the events:

Aggregated stats:
            TOTAL events:      13165
             MMAP events:         63
             COMM events:          2
           SAMPLE events:      13100
cycles:HG stats:
            TOTAL events:       5769
             MMAP events:         63
             COMM events:          2
           SAMPLE events:       5704
instructions:HG stats:
            TOTAL events:       7396
           SAMPLE events:       7396

The HG is wrong -- I did not put attributes on the event. So, re-running 
with uk:

$ perf record -fo /tmp/perf.data -e cycles:uk -e instructions:uk -c 
100000 /tmp/loop_1b_instructions

And life turned out right:
Aggregated stats:
            TOTAL events:      17967
             MMAP events:         63
             COMM events:          2
             EXIT events:          1
           SAMPLE events:      17901
cycles:ku stats:
            TOTAL events:       7862
             MMAP events:         63
             COMM events:          2
             EXIT events:          1
           SAMPLE events:       7796
instructions:ku stats:
            TOTAL events:      10105
           SAMPLE events:      10105

So, try adding :uk to your events.

David
