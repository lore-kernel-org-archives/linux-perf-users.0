From: Francis Moreau <francis.moro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: perf tools miscellaneous questions
Date: Mon, 08 Nov 2010 20:43:48 +0100
Message-ID: <m24obr1tzf.fsf@gmail.com>
References: <fa.SSgtQesEhEQa5DUYUwBV3fWtoV4@ifi.uio.no>
	<fa.dD5ur5Phqa1TLmYBE2NVKCQMjTw@ifi.uio.no>
	<fa.Xj1lA7n6nIJYL40CeRDpQzSKlfc@ifi.uio.no>
	<fa.xcyA+VzIXesq6qsPU6ADM4xdCKY@ifi.uio.no>
	<fa.MOg61Pcfdp2SJnwM2GFdOxP+xt0@ifi.uio.no>
	<fa.4sHfhlc/fMhpYgKda4IfUHZ7jMY@ifi.uio.no> <m2wros3pzf.fsf@gmail.com>
	<alpine.DEB.2.00.1011051000310.26020@cl320.eecs.utk.edu>
	<m262wao6k7.fsf@gmail.com>
	<alpine.DEB.2.00.1011061642020.29635@cl320.eecs.utk.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1011061642020.29635-h+XK9Y6koVLPD5dMldXnqTe48wsgrGvP@public.gmane.org> (Vince
	Weaver's message of "Sat, 6 Nov 2010 16:50:35 -0400 (EDT)")
Sender: linux-perf-users-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vweaver1-qKp7vQ+Mknf2fBVCVOL8/A@public.gmane.org>
Cc: Victor Jimenez <victor.javier-DuYNTNMygGQ@public.gmane.org>, Reid Kleckner <reid.kleckner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Frederic Weisbecker <fweisbec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, Peter Zijlstra <a.p.zijlstra-/NLkJaSkS4VmR6Xm/wNWPw@public.gmane.org>, Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Stephane Eranian <eranian-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-perf-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Vince Weaver <vweaver1-qKp7vQ+Mknf2fBVCVOL8/A@public.gmane.org> writes:

> This is rapidly getting of topic, especially for linux-kernel

Don't think so but feel free to remove LKML from Cc.

[...]

> Most events are poorly documented, if at all.  And the Linux kernel 
> predefined event list is loosely based upon the intel architectural
> events, which not every processor has and I've heard from insiders saying 
> that you should be very careful for the results from those events.

I agree, that's why I try to clarify some events.

Perf tools are cool stuffs, IMHO, but it's pretty hard for me to
interpret results. I tried to compare some numbers in my previous posts
but I got some 'random' figures for now.

Another example is given below where I'm trying to bench a 2 functions
which do the same thing but differently.

   $ perf stat -e cache-misses:u,l1d-loads-misses:u,cycles:u -p $(pgrep test)
     C-c C-c
    Performance counter stats for process id '30263':
   
                406532  cache-misses            
               4986030  L1-dcache-load-misses   
             120247366  cycles                  
   
           2.482196928  seconds time elapsed
   
   
   $ perf stat -e cache-misses:u,l1d-loads-misses:u,cycles:u -p $(pgrep test)
     C-c C-c
    Performance counter stats for process id '30271':
   
                459683  cache-misses            
               2513338  L1-dcache-load-misses   
             159968076  cycles                  
   
           2.129021265  seconds time elapsed

Which numbers are important here ? cache-misses ? L1-dcache-load-misses
?

I just can say that the first run looks faster.

-- 
Francis
