From: =?UTF-8?B?TWFydGluIExpxaFrYQ==?= <mliska@suse.cz>
Subject: Re: [RFC] Add --show-total-period for perf annotate
Date: Mon, 25 May 2015 09:46:07 +0200
Message-ID: <5562D33F.70706@suse.cz>
References: <555F3F8A.6000204@suse.cz> <87mw0wc4vt.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87mw0wc4vt.fsf@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On 05/23/2015 06:08 AM, Andi Kleen wrote:
> Martin Li=C5=A1ka <mliska@suse.cz> writes:
>
>> I've been working on a new feature for perf annotate, which should b=
e able to annotate
>> instructions with total spent time (compared to percentage usage).
>>
>> Let's consider following use-case. You want to compare two different=
 compilers
>> on the same code base and let's assume 90% of wall-time is spent in =
a single function.
>> Moreover, let's say that these compilers produce assembly of a total=
ly different size.
>>
>> In such case, it's very useful to get an approximation of spent time=
 on a bunch of instructions,
>> which can be compared among other compilers. Otherwise, one has to s=
omehow sum percentages and compare
>> it to size of a function.
>
> perf diff does not handle this? Especially with the differential
> profiling options it should.

It does not work if you, in my case, compare ICC and GCC, where ICC use=
s a different mangling
scheme for fortran modules. Moreover, situation can be more complicated=
 if a compiler performs
a bit different inlining decisions.

>
>>> @@ -623,6 +624,8 @@ static int __cmd_record(struct record *rec, int=
 argc, const char **argv)
>>   	if (!target__none(&opts->target) && !opts->initial_delay)
>>   		perf_evlist__enable(rec->evlist);
>>
>> +	t0 =3D rdclock();
>> +
>>   	/*
>>   	 * Let the child rip
>>   	 */
>> @@ -692,6 +695,9 @@ static int __cmd_record(struct record *rec, int =
argc, const char **argv)
>>   		goto out_child;
>>   	}
>>
>> +	t1 =3D rdclock();
>> +	walltime_nsecs =3D t1 - t0;
>
> The walltime can be later computed by the difference of the first and
> the last time stamp after sorting the events. So you don't need the n=
ew header.
>
> -Andi
>

Good point. Can you please help me how to compute a function percentage=
 usage in perf annotate ;) ?

Thanks,
Martin
