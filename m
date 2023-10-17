Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B219CA61
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Oct 2023 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+aByyw7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA58C433C7;
	Tue, 17 Oct 2023 18:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697567493;
	bh=I8nwPyTh3TvafnVbJJLXEU77LG2xbbve67ZL5kQU/H0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C+aByyw7gH3deKcZivY72gN8xOJa86XDoE11rQ34t96sTyhNqvl4iQB71G4VWqSjl
	 WBqDGeZwrytcjj1eghojUwiCDWIljMEv8gztIfEqCeVLQUJa9Hqg9gYYH39QLI3ydT
	 xotENTMSIQbH/1RC8aaxDgW4OG7+6tDSeqg00YXgnFUOQILB+qSSmkWQ5xblSbiOlU
	 Pwmifc3LizKzc+hz4ujAs7xQaCsf/skkgS0QuUqjCwpkeHvt0X/cJ27EKcCNKZRYne
	 Tqh13DfsdnDkqfjWPcJCahOUql4sCNxWp2FYxhH8M7VK3iSJoibDL+LAlG0DGwXl4f
	 K+ZWZqUnHCSsA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 9402F40016; Tue, 17 Oct 2023 15:31:30 -0300 (-03)
Date: Tue, 17 Oct 2023 15:31:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [perf stat] Extend --cpu to non-system-wide runs too? was Re:
 [PATCH v3] perf bench sched pipe: Add -G/--cgroups option
Message-ID: <ZS7TAr1bpOfkeNuv@kernel.org>
References: <20231016044225.1125674-1-namhyung@kernel.org>
 <ZS0D53ckVx356k4o@gmail.com>
 <ZS1Y5PhXhp384ynY@kernel.org>
 <ZS1ajf/9HmgUyyCl@kernel.org>
 <ZS1cGMgyEDJQbwq9@kernel.org>
 <ZS1c9RCh9MkzPbFG@kernel.org>
 <ZS2ecyCVpK8B2cQq@kernel.org>
 <ZS5yl3RzVGKBkCvY@gmail.com>
 <ZS592qxF3YxmCoG1@kernel.org>
 <ZS6BgfOUeWQnI1mS@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS6BgfOUeWQnI1mS@gmail.com>
X-Url: http://acmel.wordpress.com

Em Tue, Oct 17, 2023 at 02:43:45PM +0200, Ingo Molnar escreveu:
> * Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Em Tue, Oct 17, 2023 at 01:40:07PM +0200, Ingo Molnar escreveu:
> > > Side note: it might make sense to add a sane cpumask/affinity setting 
> > > option to perf stat itself:

> > >   perf stat --cpumask 

> > > ... or so?

> > > We do have -C:

> > >     -C, --cpu <cpu>       list of cpus to monitor in system-wide

> > > ... but that's limited to --all-cpus, right?

> > > Perhaps we could extend --cpu to non-system-wide runs too?

> > Maybe I misunderstood your question, but its a list of cpus to limit the
> > counting:
 
> Ok.
 
> So I thought that "--cpumask mask/list/etc" should simply do what 'taskset' 
> is doing: using the sched_setaffinity() syscall to make the current 
> workload and all its children.
 
> There's impact on perf stat itself: it could just call sched_setaffinity() 
> early on, and not bother about it?

> Having it built-in into perf would simply make it easier to not forget 
> running 'taskset'. :-)

Would that be the only advantage?

I think using taskset isn't that much of a burden and keeps with the
Unix tradition, no? :-\

See, using 'perf record -C', i.e. sampling, will use sched_setaffinity,
and in that case there is a clear advantage... wait, this train of
thought made me remember something, but its just about counter setup,
not about the workload:

[acme@five perf-tools-next]$ grep affinity__set tools/perf/*.c
tools/perf/builtin-stat.c:	else if (affinity__setup(&saved_affinity) < 0)
tools/perf/builtin-stat.c:		if (affinity__setup(&saved_affinity) < 0)
[acme@five perf-tools-next]$

/*
 * perf_event_open does an IPI internally to the target CPU.
 * It is more efficient to change perf's affinity to the target
 * CPU and then set up all events on that CPU, so we amortize
 * CPU communication.
 */
void affinity__set(struct affinity *a, int cpu)

[root@five ~]# perf trace --summary -e sched_setaffinity perf stat -e cycles -a sleep 1

 Performance counter stats for 'system wide':

     6,319,186,681      cycles

       1.002665795 seconds time elapsed


 Summary of events:

 perf (24307), 396 events, 87.4%

   syscall            calls  errors  total       min       avg       max       stddev
                                     (msec)    (msec)    (msec)    (msec)        (%)
   --------------- --------  ------ -------- --------- --------- ---------     ------
   sched_setaffinity      198      0     4.544     0.006     0.023     0.042      2.30%


[root@five ~]#

[root@five ~]# perf trace --summary -e sched_setaffinity perf stat -C 1 -e cycles -a sleep 1

 Performance counter stats for 'system wide':

       105,311,506      cycles

       1.001203282 seconds time elapsed


 Summary of events:

 perf (24633), 24 events, 29.6%

   syscall            calls  errors  total       min       avg       max       stddev
                                     (msec)    (msec)    (msec)    (msec)        (%)
   --------------- --------  ------ -------- --------- --------- ---------     ------
   sched_setaffinity       12      0     0.105     0.005     0.009     0.039     32.07%


[root@five ~]# perf trace --summary -e sched_setaffinity perf stat -C 1,2 -e cycles -a sleep 1

 Performance counter stats for 'system wide':

       131,474,375      cycles

       1.001324346 seconds time elapsed


 Summary of events:

 perf (24636), 36 events, 38.7%

   syscall            calls  errors  total       min       avg       max       stddev
                                     (msec)    (msec)    (msec)    (msec)        (%)
   --------------- --------  ------ -------- --------- --------- ---------     ------
   sched_setaffinity       18      0     0.442     0.000     0.025     0.093     24.75%


[root@five ~]# perf trace --summary -e sched_setaffinity perf stat -C 1,2,30 -e cycles -a sleep 1

 Performance counter stats for 'system wide':

       191,674,889      cycles

       1.001280015 seconds time elapsed


 Summary of events:

 perf (24639), 48 events, 45.7%

   syscall            calls  errors  total       min       avg       max       stddev
                                     (msec)    (msec)    (msec)    (msec)        (%)
   --------------- --------  ------ -------- --------- --------- ---------     ------
   sched_setaffinity       24      0     0.835     0.000     0.035     0.144     24.40%


[root@five ~]#

Too much affinity setting :-)


- Arnaldo
