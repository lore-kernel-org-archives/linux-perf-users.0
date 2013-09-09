From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: perf cannot see call graph, visible in gdb
Date: Mon, 9 Sep 2013 16:35:37 +0200
Message-ID: <20130909143537.GA28036@krava.redhat.com>
References: <1309051629550.29229@wes.ijneb.com>
 <87ioydhgs1.fsf@tassilo.jf.intel.com>
 <1309091326270.22075@wes.ijneb.com>
 <522DD5A5.70500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:5879 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751506Ab3IIOgO (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 9 Sep 2013 10:36:14 -0400
Content-Disposition: inline
In-Reply-To: <522DD5A5.70500@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Mark Hills <mark@pogo.org.uk>, Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org

On Mon, Sep 09, 2013 at 07:05:25AM -0700, David Ahern wrote:
> Adding Jiri.
> 
> On 9/9/13 5:59 AM, Mark Hills wrote:
> >On Fri, 6 Sep 2013, Andi Kleen wrote:
> >
> >>Mark Hills <mark@pogo.org.uk> writes:
> >>
> >>>I have a pre-compiled .so library, which was given to me for profiling.
> >>>
> >>>gdb can see a complete call stack -- both the library and my own code,
> >>>as expected.
> >>>
> >>>But in perf the callgraph for the library is not present. I'm using
> >>>"perf record -g", and the callgraph for the other code is seen.
> >>>
> >>>In what cases could gdb see the stack, but perf cannot?
> >>
> >>No frame pointer.
> >>
> >>Recompile with -fno-omit-frame-pointer
> >>
> >>Or if you have a new enough perf, you can use -g dwarf to enable
> >>dwarf backtracing, but it's very slow and also doesn't handle all
> >>situations gdb handles.
> >
> >Thank you, much appreciated.
> >
> >A newer perf appears to need a newer kernel too, and it's not practical
> >for me to break away from the RedHat kernel at the moment (currently on
> >2.6.32-358.14.1.el6)
> 
> Any updates to RHEL6 for dwarf callchains?
> 

unfortunately no news in RHEL6 for this one

jirka
