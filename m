From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: L1-dcache-stores twice as big as expected
Date: Thu, 30 Apr 2015 16:53:32 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1504301648300.30450@vincent-weaver-1.umelst.maine.edu>
References: <loom.20150430T211657-416@post.gmane.org> <alpine.DEB.2.11.1504301613070.30426@vincent-weaver-1.umelst.maine.edu> <loom.20150430T221024-824@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:35713 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbbD3Usa (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 30 Apr 2015 16:48:30 -0400
Received: by qcbii10 with SMTP id ii10so35482462qcb.2
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Apr 2015 13:48:30 -0700 (PDT)
In-Reply-To: <loom.20150430T221024-824@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Patrick <plafratt@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Thu, 30 Apr 2015, Patrick wrote:

> I think I may have figured out what is going on by looking at the assembly
> (shown below). It looks like it is doing two stores per loop iteration - one to
> set the array value and one to update the index into the array.

Yes, that's because you are compiling without optimization.

> I am new to perf and seeing a lot of results from counters of which I'm not
> sure how to make sense. So I'm still trying to get comfortable and make sure I
> know what's going on. I have a follow-on question regarding possible ways to
> count memory writes on a processor that's not a Xeon. 

good luck sorting things out, perf counter results have many issues that 
make them hard to interpret, especially with advanced processors and 
especially if cache is involved.

Just be glad you aren't running your test on an AMD model 14h machine as 
seen below.

perf stat -e L1-dcache-stores:u ./copy 1048576

 Performance counter stats for './copy_test 1048576':

                35      L1-dcache-stores                                            

       0.014573254 seconds time elapsed


Vince
