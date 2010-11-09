From: Francis Moreau <francis.moro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: perf tools miscellaneous questions
Date: Tue, 09 Nov 2010 12:07:12 +0100
Message-ID: <m2y692vjq7.fsf@gmail.com>
References: <fa.yHA7Aw03llqLWxPVYRnHvK5/dT8@ifi.uio.no>
	<fa.13KEqWk+Dk+jLLdFlAoZtQ2Vjuw@ifi.uio.no> <m2lj59sc7a.fsf@gmail.com>
	<20101107214025.GD11134@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101107214025.GD11134@nowhere> (Frederic Weisbecker's message
	of "Sun, 7 Nov 2010 22:40:27 +0100")
Sender: linux-perf-users-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Frederic Weisbecker <fweisbec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, Peter Zijlstra <a.p.zijlstra-/NLkJaSkS4VmR6Xm/wNWPw@public.gmane.org>, Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Stephane Eranian <eranian-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-perf-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Frederic Weisbecker <fweisbec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

> On Thu, Nov 04, 2010 at 09:52:09AM +0100, Francis Moreau wrote:

[...]

>> 
>> No problem, but yes this part should be documented somewhere. And I
>> think the syntax of event too, specially the modifier like 'u' or 'p'.
>
> Ah that is documented in "man perf-list".

Ok, after updating my 3 weeks old kernel, modifiers are now documented.

But I failed to generate it:

    XMLTO perf-record.1
xmlto: /home/fmoreau/linux-2.6/tools/perf/Documentation/perf-record.xml does not validate (status 3)

BTW, what does 'skid' mean ? s(?) k(?) instruction delay ?

[...]

> I have the same problem. But running perf record with this :p works
> for me. Which is what we want: pebs is useful for sampling, not
> counting-only.

That makes sense but I still have a problem:

   $ perf record -e cache-misses:p -p $(pgrep test)

  Error: perfcounter syscall returned with -1 (No space left on device)

  Fatal: No CONFIG_PERF_EVENTS=y kernel support configured?


> Ah and that won't work if you don't run some intel CPU I think.  Check
> you have PEBS support in /proc/cpuinfo

It seems so:

   $ grep -qi pebs /proc/cpuinfo && echo pebs
   pebs

Thanks
-- 
Francis
