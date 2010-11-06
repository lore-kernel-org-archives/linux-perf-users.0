From: Vince Weaver <vweaver1-qKp7vQ+Mknf2fBVCVOL8/A@public.gmane.org>
Subject: Re: perf tools miscellaneous questions
Date: Sat, 6 Nov 2010 16:50:35 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1011061642020.29635@cl320.eecs.utk.edu>
References: <fa.SSgtQesEhEQa5DUYUwBV3fWtoV4@ifi.uio.no> <fa.dD5ur5Phqa1TLmYBE2NVKCQMjTw@ifi.uio.no> <fa.Xj1lA7n6nIJYL40CeRDpQzSKlfc@ifi.uio.no> <fa.xcyA+VzIXesq6qsPU6ADM4xdCKY@ifi.uio.no> <fa.MOg61Pcfdp2SJnwM2GFdOxP+xt0@ifi.uio.no> <fa.4sHfhlc/fMhpYgKda4IfUHZ7jMY@ifi.uio.no>
 <m2wros3pzf.fsf@gmail.com> <alpine.DEB.2.00.1011051000310.26020@cl320.eecs.utk.edu> <m262wao6k7.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <m262wao6k7.fsf-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-perf-users-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Francis Moreau <francis.moro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Victor Jimenez <victor.javier-DuYNTNMygGQ@public.gmane.org>, Reid Kleckner <reid.kleckner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Frederic Weisbecker <fweisbec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, Peter Zijlstra <a.p.zijlstra-/NLkJaSkS4VmR6Xm/wNWPw@public.gmane.org>, Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Stephane Eranian <eranian-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-perf-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


This is rapidly getting of topic, especially for linux-kernel

On Sat, 6 Nov 2010, Francis Moreau wrote:

> Specially since 'llc-loads-misses' is and should be self speaking.

Not necessarily.  Does "last level" mean the common L2 or the shared L3?
Do the misses count prefetch misses?  Do the misses count coherency
actions or else just "normal" cache accesses?  Does your processor count 
multiple loads from some single instructions [unfortunately, many do].

Most events are poorly documented, if at all.  And the Linux kernel 
predefined event list is loosely based upon the intel architectural
events, which not every processor has and I've heard from insiders saying 
that you should be very careful for the results from those events.  Also 
as far as I know there hasn't been much validation work on whether the 
events return useful values.  No chip company will guarantee the values 
returned by performance counters; they are more or less a bonus feature 
that works most of the time but you never really know the accuracy of what 
you are reading out of them.

> Could you point out the best architecture manual for it which describe
> the raw events ?

For your Core2 you want the Intel Software Developer's Manual, volume 2B.  
Google should find it.

> BTW, I'm wondering if event names are coherent across the different
> architectures supported by Linux.

Nope.  They aren't even consistent across the same chip company.  For 
example, Core2 and Nehalem have completely different event names, and even 
between Nehalem and Westmere there are incompatible changes.

Vince
--
To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
