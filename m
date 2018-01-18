From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Question perf annotate: how to free allocated memory of
 arch->instructions
Date: Thu, 18 Jan 2018 13:23:04 -0300
Message-ID: <20180118162304.GF18383@kernel.org>
References: <aa217ab5-6920-cfa6-13e2-38feae4463b5@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933527AbeARQXH (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 Jan 2018 11:23:07 -0500
Content-Disposition: inline
In-Reply-To: <aa217ab5-6920-cfa6-13e2-38feae4463b5@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

Em Thu, Jan 18, 2018 at 03:56:00PM +0100, Thomas-Mich Richter escreveu:
> I have a question regarding the struct arch and its initialization/un_initialization.
> 
> Function symbol__disassemble() invokes arch->init() once it has identified the archticture
> its running on. 
> When I execute command ./perf annotate --stdio I discovered that functions
> arch__associate_ins_ops()
> --> arch__grow_instructions()
> 
> are called to create/enlarge the array of machine instructions which require special
> annotations like branches, jumps, etc to display arrows etc in the GUI. (At least on s390).
> 
> On ARM/ARM64 the arch->priv field also points to malloc'ed space needed for ARM specific
> processing.
> 
> However there is no uninit() like function to remove any allocated memory and to clean up
> before perf terminates.
> 
> Is this done on intention to rely on the exit of perf to release any allocated memory?

We can call symbol__disassemble() multiple times ina TUI session, but
then this is done only once, i.e. the second symbol__disassemble() will
find that already in place, etc.

So no leaks, when we exit, this is all cleaned up.

> Are there plans to change this, that is invent an uninit() like function for proper memory free?
> Where would be the best place to call this uninit() like function?

I think this may be useful, for completeness sake, and for using when
trying to find leaks, using something like valgrind, etc.

But do not use it at end when not debugging, as this will make the tool
exit time take longer for no gain.

For some long running app that does annotation for multiple
architectures, etc, theoretically one would want to tear down those
structures to save space, so having the ->exit() routine (we use that
name as the counterpart to ->init()) may come handy.

- Arnaldo
