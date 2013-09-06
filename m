From: Andi Kleen <andi@firstfloor.org>
Subject: Re: perf cannot see call graph, visible in gdb
Date: Fri, 06 Sep 2013 12:49:34 -0700
Message-ID: <87ioydhgs1.fsf@tassilo.jf.intel.com>
References: <1309051629550.29229@wes.ijneb.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60395 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830Ab3IFTte (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 6 Sep 2013 15:49:34 -0400
In-Reply-To: <1309051629550.29229@wes.ijneb.com> (Mark Hills's message of
	"Thu, 5 Sep 2013 17:48:07 +0100 (BST)")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Mark Hills <mark@pogo.org.uk>
Cc: linux-perf-users@vger.kernel.org

Mark Hills <mark@pogo.org.uk> writes:

> I have a pre-compiled .so library, which was given to me for profiling.
>
> gdb can see a complete call stack -- both the library and my own code, as 
> expected.
>
> But in perf the callgraph for the library is not present. I'm using "perf 
> record -g", and the callgraph for the other code is seen.
>  
> In what cases could gdb see the stack, but perf cannot?

No frame pointer. 

Recompile with -fno-omit-frame-pointer

Or if you have a new enough perf, you can use -g dwarf to enable 
dwarf backtracing, but it's very slow and also doesn't handle all 
situations gdb handles.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
