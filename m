From: Francis Moreau <francis.moro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: perf tools miscellaneous questions
Date: Tue, 09 Nov 2010 16:22:31 +0100
Message-ID: <m239rav7wo.fsf@gmail.com>
References: <fa.SSgtQesEhEQa5DUYUwBV3fWtoV4@ifi.uio.no>
	<fa.dD5ur5Phqa1TLmYBE2NVKCQMjTw@ifi.uio.no>
	<fa.Xj1lA7n6nIJYL40CeRDpQzSKlfc@ifi.uio.no>
	<fa.xcyA+VzIXesq6qsPU6ADM4xdCKY@ifi.uio.no>
	<fa.MOg61Pcfdp2SJnwM2GFdOxP+xt0@ifi.uio.no>
	<fa.4sHfhlc/fMhpYgKda4IfUHZ7jMY@ifi.uio.no> <m2wros3pzf.fsf@gmail.com>
	<alpine.DEB.2.00.1011051000310.26020@cl320.eecs.utk.edu>
	<m262wao6k7.fsf@gmail.com>
	<alpine.DEB.2.00.1011061642020.29635@cl320.eecs.utk.edu>
	<m24obr1tzf.fsf@gmail.com>
	<AANLkTimyzO7_MzRs0tUaWFHWEN69MRhwQL=EPFiukXci@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTimyzO7_MzRs0tUaWFHWEN69MRhwQL=EPFiukXci-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
	(Reid Kleckner's message of "Mon, 8 Nov 2010 15:06:51 -0500")
Sender: linux-perf-users-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Reid Kleckner <reid.kleckner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Vince Weaver <vweaver1-qKp7vQ+Mknf2fBVCVOL8/A@public.gmane.org>, Victor Jimenez <victor.javier-DuYNTNMygGQ@public.gmane.org>, Frederic Weisbecker <fweisbec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, Peter Zijlstra <a.p.zijlstra-/NLkJaSkS4VmR6Xm/wNWPw@public.gmane.org>, Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Stephane Eranian <eranian-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-perf-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Reid Kleckner <reid.kleckner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

[...]

> I don't know what level of cache the generic cache-misses and
> -references refer to on your processor.  Unfortunately, you'd have to
> go look up the source code and cross reference it with a manual to
> know for 100%.

Looking at the source and intel processor manual, 'cache-misses' event
is a "Pre-defined Architectural Performance Events" with:

   - UMASK =3D 0x41
   - Event select =3D 0x2e

Here's the complete definition of 'cache-misses':

   Last Level Cache Misses =E2=80=94 Event select 2EH, Umask 41H

   This event counts each cache miss condition for references to the
   last level cache.  The event count may include speculation, but
   excludes cache line fills due to hardware-prefetch.

   Because cache hierarchy, cache sizes and other
   implementation-specific characteristics; value comparison to estimat=
e
   performance differences is not recommended.


Also "Pre-defined Architectural Performance Events" means, that's
the definition is common across all Intel CPUs, IIUC.

> Having looked at the code, I can assert that it's an event that has t=
o
> do with the higher level caches, ie not L1, and apparently it's not
> LLC on your machine.

Unfortunately 'cache-misses' _is_ LLC on this machine hence my
confusion with my previous examples using true(1), and gzip(1).

But to add more confusion please see the numbers below...

> IMO it's worth doing multiple runs to look at *all* of the cache
> counters on a variety of workloads with known cache behavior so you
> can get an understanding.

Here's a more complete run.

method 1:
             408502  cache-misses
            3040439  cache-references
           38489028  L1-dcache-loads
            6616736  L1-dcache-stores
            4948739  L1-dcache-load-misses
                241  L1-dcache-store-misses
            2998011  LLC-loads
             406115  LLC-load-misses
                171  LLC-stores
                 41  LLC-store-misses
          120654728  cycles
           82578853  instructions             #      0.684 IPC
                  0  minor-faults
                  0  major-faults
                  0  alignment-faults

method 2:
             460273  cache-misses
            1891362  cache-references
           28549238  L1-dcache-loads
            6596346  L1-dcache-stores
            3699561  L1-dcache-load-misses
                608  L1-dcache-store-misses
            1884987  LLC-loads
             459826  LLC-load-misses
                 63  LLC-stores
                 38  LLC-store-misses
          160426298  cycles
           87272047  instructions             #      0.544 IPC =20
                  0  minor-faults
                  0  major-faults
                  0  alignment-faults

Now 'cache-misses' and 'LLC-{load,store}-misses' are quite similar,
sigh...

So the first method since more efficient because it seems to execute
less instructions and have less LLC misses even if its L1-dcache misses
is lower.

Thanks
--=20
=46rancis
