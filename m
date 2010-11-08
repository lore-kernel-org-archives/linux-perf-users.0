From: Reid Kleckner <reid.kleckner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: perf tools miscellaneous questions
Date: Mon, 8 Nov 2010 15:06:51 -0500
Message-ID: <AANLkTimyzO7_MzRs0tUaWFHWEN69MRhwQL=EPFiukXci@mail.gmail.com>
References: <fa.SSgtQesEhEQa5DUYUwBV3fWtoV4@ifi.uio.no> <fa.dD5ur5Phqa1TLmYBE2NVKCQMjTw@ifi.uio.no>
 <fa.Xj1lA7n6nIJYL40CeRDpQzSKlfc@ifi.uio.no> <fa.xcyA+VzIXesq6qsPU6ADM4xdCKY@ifi.uio.no>
 <fa.MOg61Pcfdp2SJnwM2GFdOxP+xt0@ifi.uio.no> <fa.4sHfhlc/fMhpYgKda4IfUHZ7jMY@ifi.uio.no>
 <m2wros3pzf.fsf@gmail.com> <alpine.DEB.2.00.1011051000310.26020@cl320.eecs.utk.edu>
 <m262wao6k7.fsf@gmail.com> <alpine.DEB.2.00.1011061642020.29635@cl320.eecs.utk.edu>
 <m24obr1tzf.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <m24obr1tzf.fsf-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-perf-users-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Francis Moreau <francis.moro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Vince Weaver <vweaver1-qKp7vQ+Mknf2fBVCVOL8/A@public.gmane.org>, Victor Jimenez <victor.javier-DuYNTNMygGQ@public.gmane.org>, Frederic Weisbecker <fweisbec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, Peter Zijlstra <a.p.zijlstra-/NLkJaSkS4VmR6Xm/wNWPw@public.gmane.org>, Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Stephane Eranian <eranian-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-perf-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

-lkml

On Mon, Nov 8, 2010 at 2:43 PM, Francis Moreau <francis.moro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>=
 wrote:
> Vince Weaver <vweaver1-qKp7vQ+Mknf2fBVCVOL8/A@public.gmane.org> writes:
>
>> This is rapidly getting of topic, especially for linux-kernel
>
> Don't think so but feel free to remove LKML from Cc.
>
> [...]
>
>> Most events are poorly documented, if at all. =C2=A0And the Linux ke=
rnel
>> predefined event list is loosely based upon the intel architectural
>> events, which not every processor has and I've heard from insiders s=
aying
>> that you should be very careful for the results from those events.
>
> I agree, that's why I try to clarify some events.
>
> Perf tools are cool stuffs, IMHO, but it's pretty hard for me to
> interpret results. I tried to compare some numbers in my previous pos=
ts
> but I got some 'random' figures for now.
>
> Another example is given below where I'm trying to bench a 2 function=
s
> which do the same thing but differently.
>
> =C2=A0 $ perf stat -e cache-misses:u,l1d-loads-misses:u,cycles:u -p $=
(pgrep test)
> =C2=A0 =C2=A0 C-c C-c
> =C2=A0 =C2=A0Performance counter stats for process id '30263':
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0406532 =C2=A0c=
ache-misses
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4986030 =C2=A0L1-dca=
che-load-misses
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 120247366 =C2=A0cycles
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2.482196928 =C2=A0seconds time ela=
psed
>
>
> =C2=A0 $ perf stat -e cache-misses:u,l1d-loads-misses:u,cycles:u -p $=
(pgrep test)
> =C2=A0 =C2=A0 C-c C-c
> =C2=A0 =C2=A0Performance counter stats for process id '30271':
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0459683 =C2=A0c=
ache-misses
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2513338 =C2=A0L1-dca=
che-load-misses
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 159968076 =C2=A0cycles
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2.129021265 =C2=A0seconds time ela=
psed
>
> Which numbers are important here ? cache-misses ? L1-dcache-load-miss=
es
> ?

Totally depends.  In this particular piece of code, you seem to have
improved your L1 hit rate, but you've hurt your hit rate somewhere
else, so the extra memory traffic has hurt you overall.  Also, it's
also helpful to look at the rate, and not just absolute numbers.  You
may be doing more L1 references in the second, so you just have more
memory traffic overall.

I don't know what level of cache the generic cache-misses and
-references refer to on your processor.  Unfortunately, you'd have to
go look up the source code and cross reference it with a manual to
know for 100%.  Having looked at the code, I can assert that it's an
event that has to do with the higher level caches, ie not L1, and
apparently it's not LLC on your machine.

Try comparing it to the numbers for L2-dcache-load-misses and
L2-dcache-store-misses.  IMO it's worth doing multiple runs to look at
*all* of the cache counters on a variety of workloads with known cache
behavior so you can get an understanding.

The reality is that these things aren't well documented either by the
manufacturer or the kernel developers, and the best way to understand
them right now is to run your own experiments.

Reid
