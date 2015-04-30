From: Patrick <plafratt@gmail.com>
Subject: Re: L1-dcache-stores twice as big as expected
Date: Thu, 30 Apr 2015 20:23:13 +0000 (UTC)
Message-ID: <loom.20150430T221024-824@post.gmane.org>
References: <loom.20150430T211657-416@post.gmane.org> <alpine.DEB.2.11.1504301613070.30426@vincent-weaver-1.umelst.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:39537 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752803AbbD3UXX (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 30 Apr 2015 16:23:23 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1YnuzQ-00009h-EC
	for linux-perf-users@vger.kernel.org; Thu, 30 Apr 2015 22:23:21 +0200
Received: from masquerade.micron.com ([137.201.242.130])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Apr 2015 22:23:20 +0200
Received: from plafratt by masquerade.micron.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Apr 2015 22:23:20 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Vince Weaver <vincent.weaver <at> maine.edu> writes:

> 
> On Thu, 30 Apr 2015, Patrick wrote:
> 
> > ->         2,207,859 L1-dcache-stores
> > ->       0.006255441 seconds time elapsed
> > 
> > I can't figure out why it is recording over 2 million stores to the L1 
> > data cache. I 
> > would expect it to be around 1 million. Has anyone seen this before?
> 
> also it looks like you're using C++.
> 
> Quite possibly the "new" initializer is setting each element in the array 
> to zero and then you later set each to one, so it wouldn't be surprising
> you'd get a result 2x as much as you'd expect.
> 
> Vince
> 

Vince,

Thanks for the response.

Processor: Core i7 940
Compiler: g++
Compiler options: compiled as "g++ copy.cpp -o copy"

I was a little surprised that the compiler didn't optimize it out, also. But
given that it didn't, I went ahead and used the code to start experimenting
with perf.

I think I may have figured out what is going on by looking at the assembly
(shown below). It looks like it is doing two stores per loop iteration - one to
set the array value and one to update the index into the array.

I am new to perf and seeing a lot of results from counters of which I'm not
sure how to make sense. So I'm still trying to get comfortable and make sure I
know what's going on. I have a follow-on question regarding possible ways to
count memory writes on a processor that's not a Xeon. I have some ideas on how
to do this, but I wanted to check to see if anyone on the list had any thoughts
on this. I'll post as a separate topic.

Thanks, Patrick

.L7:
    movl    -4(%rbp), %eax
    movslq  %eax, %rdx
    movq    -24(%rbp), %rax
    addq    %rdx, %rax
    movb    $1, (%rax)
    addl    $1, -4(%rbp)
.L6:
    movl    -4(%rbp), %eax
    cltq
    cmpq    -16(%rbp), %rax
    setb    %al
    testb   %al, %al
    jne .L7
