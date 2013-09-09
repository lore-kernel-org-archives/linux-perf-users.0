From: Mark Hills <mark@pogo.org.uk>
Subject: Re: perf cannot see call graph, visible in gdb
Date: Mon, 9 Sep 2013 13:59:07 +0100 (BST)
Message-ID: <1309091326270.22075@wes.ijneb.com>
References: <1309051629550.29229@wes.ijneb.com> <87ioydhgs1.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx.ij.cx ([212.13.201.15]:58997 "EHLO wes.ijneb.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751969Ab3IIM7K (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 9 Sep 2013 08:59:10 -0400
In-Reply-To: <87ioydhgs1.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

On Fri, 6 Sep 2013, Andi Kleen wrote:

> Mark Hills <mark@pogo.org.uk> writes:
> 
> > I have a pre-compiled .so library, which was given to me for profiling.
> >
> > gdb can see a complete call stack -- both the library and my own code, 
> > as expected.
> >
> > But in perf the callgraph for the library is not present. I'm using 
> > "perf record -g", and the callgraph for the other code is seen.
> >  
> > In what cases could gdb see the stack, but perf cannot?
> 
> No frame pointer. 
> 
> Recompile with -fno-omit-frame-pointer
>
> Or if you have a new enough perf, you can use -g dwarf to enable 
> dwarf backtracing, but it's very slow and also doesn't handle all 
> situations gdb handles.

Thank you, much appreciated.

A newer perf appears to need a newer kernel too, and it's not practical 
for me to break away from the RedHat kernel at the moment (currently on 
2.6.32-358.14.1.el6)

Also I looked to cherry-pick the relevant patches, but it seems this is 
non-trivial.

I'll speak to the author of the library in question but may have to 
re-visit the dwarf behaviour; omit-frame-pointer may have been used with 
performance in mind.

Thanks

-- 
Mark
