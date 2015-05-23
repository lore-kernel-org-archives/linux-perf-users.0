From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [RFC] Add --show-total-period for perf annotate
Date: Fri, 22 May 2015 21:08:38 -0700
Message-ID: <87mw0wc4vt.fsf@tassilo.jf.intel.com>
References: <555F3F8A.6000204@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <555F3F8A.6000204@suse.cz> ("Martin =?utf-8?Q?Li=C5=A1ka=22's?=
 message of "Fri, 22
	May 2015 16:39:06 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Martin =?utf-8?Q?Li=C5=A1ka?= <mliska@suse.cz>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Martin Li=C5=A1ka <mliska@suse.cz> writes:

> I've been working on a new feature for perf annotate, which should be=
 able to annotate
> instructions with total spent time (compared to percentage usage).
>
> Let's consider following use-case. You want to compare two different =
compilers
> on the same code base and let's assume 90% of wall-time is spent in a=
 single function.
> Moreover, let's say that these compilers produce assembly of a totall=
y different size.
>
> In such case, it's very useful to get an approximation of spent time =
on a bunch of instructions,
> which can be compared among other compilers. Otherwise, one has to so=
mehow sum percentages and compare
> it to size of a function.

perf diff does not handle this? Especially with the differential
profiling options it should.

>> @@ -623,6 +624,8 @@ static int __cmd_record(struct record *rec, int =
argc, const char **argv)
>  	if (!target__none(&opts->target) && !opts->initial_delay)
>  		perf_evlist__enable(rec->evlist);
> =20
> +	t0 =3D rdclock();
> +
>  	/*
>  	 * Let the child rip
>  	 */
> @@ -692,6 +695,9 @@ static int __cmd_record(struct record *rec, int a=
rgc, const char **argv)
>  		goto out_child;
>  	}
> =20
> +	t1 =3D rdclock();
> +	walltime_nsecs =3D t1 - t0;

The walltime can be later computed by the difference of the first and
the last time stamp after sorting the events. So you don't need the new=
 header.

-Andi

--=20
ak@linux.intel.com -- Speaking for myself only
