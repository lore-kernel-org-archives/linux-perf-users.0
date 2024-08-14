Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3337346D;
	Wed, 14 Aug 2024 22:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723675668; cv=none; b=BtdT8P607BEkza1SBZReOhf3dNZP5yODfHD3941x0G5LVsdON2X0GCrfGI35BEqC5EpMK6JdxcMcvyz9VYB1cW9BQ8sOywxQL/at5eRe5+A5V8J0z3dnUaDfhcocUcY0dA0nCTgbPxyZ2V1jVPca6hYiDi+DOYhKa5XsomozaCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723675668; c=relaxed/simple;
	bh=oAsW3ALRb2L/L1VSxlS3PeVwvzoUTOy9LVHYau2FFUI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y9Vo9IJudulmQYqi+MOVCY7jK7NwpOegS7Oh7hAbvPJhVmkk2EM8l7v1pmG2Su7xCHV+LX7jHJ+t3KCdrA+DdmuTN/FSZlgPN6Ksgoc9HLHK1h96GQLwuRccO+qn4vOOJyictTjDGNg7boQD4HoVTJ8MSq3wycjG1ZJsBw+UbbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qoZWWgRc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UQcyJcQo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qoZWWgRc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UQcyJcQo"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723675663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TEBkZJEgq/1j0sqdK8RDzUheGmdmMnYbuKi5UkgQAbo=;
	b=qoZWWgRcsuDkXjOpRyz7WFFEnpHWWB3SvJMReyx1SmPyIc62yxiYlV5h2Qp2Vwgg4+ww8m
	PMiW17eoxpaU6LtwUtP3O/mJ6HmgXlBdWIj1baJxRyl4P4oUI2/bWaiMeT3eHb2I8X70s8
	M1bdc9YdLYAuZvjCiyJk4OJTKz/x7EE87X5iSpsay/WcGXnKLaN7zeuGPi9WTpiZ6v33BX
	wycj4/rkWzEwfwMqCjd1FVaqMuD+5h1Q9bq9W6nrWzUqUZ4ddsJxUc4FVXc/5xwsRj46Nd
	fzYCSp4AMQWlUJAQncn2QIL9wsm9J8tavICpDAQVcs5yUD1DOun8O/1sLFxa1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723675663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TEBkZJEgq/1j0sqdK8RDzUheGmdmMnYbuKi5UkgQAbo=;
	b=UQcyJcQoOxSPnW6A7lzK5oG/VKeoWNfJ1Cr3UtaJPD2oPV0h+hM8grogjvXH0v/5UoVc9z
	0BebqUH3HOgf4AAw==
To: "Liang, Kan" <kan.liang@linux.intel.com>, Li Huafei
 <lihuafei1@huawei.com>, peterz@infradead.org, mingo@redhat.com
Cc: acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel: Restrict period on Haswell
In-Reply-To: <70657c5e-f771-456b-a5ac-3df590249288@linux.intel.com>
References: <87sev7nom4.ffs@tglx>
 <a42a3e35-2166-4539-930b-21ea0921e8d8@linux.intel.com>
 <87frr7nd28.ffs@tglx>
 <70657c5e-f771-456b-a5ac-3df590249288@linux.intel.com>
Date: Thu, 15 Aug 2024 00:47:42 +0200
Message-ID: <875xs2oh69.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 14 2024 at 15:37, Kan Liang wrote:
> On 2024-08-14 3:01 p.m., Thomas Gleixner wrote:
>> This happens at the very same time and CPU#88 is the HT sibling of
>> CPU#16
>
> The fixed counter 0 is used which doesn't match of what the HSW11
> describes. I will check if the HSW11 missed the case, or if there is
> another issue.

This looks like a plain stupid software issue at the first glance. The
hack I use to look at that is at the end of the mail. Most of the output
here is heavily trimmed for readability:

65.147782: x86_perf_event_set_period: idx:    32 period:         1 left:  2
65.147783: intel_pmu_handle_irq:      loops: 001 status: 100000000

65.147784: x86_perf_event_set_period: idx:    32 period:         1 left:  2
65.147784: intel_pmu_handle_irq:      loops: 002 status: 100000000         

and this continues up to 100 times.

If I'm not missing something then a period of 1 or even 2 is way too
small for fixed counter 0 which is rearmed in the NMI and counts user
_and_ kernel.

But what's weird is that earlier in the trace I can see in the context
of a different task the following w/o looping in the handler:

65.084029: x86_perf_event_set_period: idx: 32 period:          1 left:          2
65.084033: x86_perf_event_set_period: idx: 32 period:          1 left:          2
65.085654: x86_perf_event_set_period: idx: 32 period:          1 left:          2
65.085660: x86_perf_event_set_period: idx: 32 period:          1 left:          2
65.085667: x86_perf_event_set_period: idx: 32 period:          1 left:          2
65.085673: x86_perf_event_set_period: idx: 32 period:          2 left:          2
65.085681: x86_perf_event_set_period: idx: 32 period:          4 left:          4
65.085687: x86_perf_event_set_period: idx: 32 period:          7 left:          7
65.085693: x86_perf_event_set_period: idx: 32 period:         14 left:         14
65.085699: x86_perf_event_set_period: idx: 32 period:         26 left:         26
65.085705: x86_perf_event_set_period: idx: 32 period:         49 left:         49
65.085708: x86_perf_event_set_period: idx: 32 period:         95 left:         95
65.085711: x86_perf_event_set_period: idx: 32 period:        303 left:        303
65.085713: x86_perf_event_set_period: idx: 32 period:        967 left:        550
65.085716: x86_perf_event_set_period: idx: 32 period:       3118 left:       2799
65.085722: x86_perf_event_set_period: idx: 32 period:       9723 left:       9411

This goes on to almost 100k period and then goes back down to 50k.

The test case sets it up with

    attr::freq        = 1
    attr::sample_freq = max_sample_rate / 5

max_sample_rate is read from /proc/sys/kernel/perf_event_max_sample_rate,
which contains 100000 after boot, so the requested value is 20000.

So in the good case the period = 1 manages to not have the status bit
set at, after handling.

The bad case stays there forever. Of course setting a limit makes this
magically go away, but honestly this is not a solution.

Another one magically cures itself:

65.131743: x86_perf_event_set_period: idx:    32 period:         1 left:          2
65.131745: x86_perf_event_set_period: idx:    32 period:         1 left:          2
65.131745: intel_pmu_handle_irq:      loops: 001 status: 100000000
65.131746: x86_perf_event_set_period: idx:    32 period:         1 left:          2
65.131746: intel_pmu_handle_irq:      loops: 002 status: 100000000
65.131747: x86_perf_event_set_period: idx:    32 period:         1 left:          2
65.131944: x86_perf_event_set_period: idx:    32 period:         1 left:          2
65.131950: x86_perf_event_set_period: idx:    32 period:         1 left:          2
65.131955: x86_perf_event_set_period: idx:    32 period:         1 left:          2
65.131961: x86_perf_event_set_period: idx:    32 period:         2 left:          2
65.131965: x86_perf_event_set_period: idx:    32 period:         5 left:          5
....
65.132331: x86_perf_event_set_period: idx:    32 period:     83183 left:      82871

I just wanted to look at something else and started a single instance of
the cve test right after booting and that ran into the same problem.

Full trace at: https://tglx.de/~tglx/t.txt

I think I see a pattern with that now. In all cases I saw so far the
problem happens when two HT siblings get the PMI at the very same time.

# grep handle t.txt

shows you the cases where it goes into the loop. I checked all the
previous traces and the pattern is always identical.

That aside. What really puzzles me is this period adjustment
algorithm.

# grep 'cve-2015-3290-2715.*idx: 32' t.txt

316.966607: x86_perf_event_set_period: idx: 32 period:          1 left:          2
316.966621: x86_perf_event_set_period: idx: 32 period:          1 left:          2
316.966977: x86_perf_event_set_period: idx: 32 period:          1 left:          2
316.966985: x86_perf_event_set_period: idx: 32 period:          1 left:          2
316.970507: x86_perf_event_set_period: idx: 32 period:       9980 left:       9980
316.970516: x86_perf_event_set_period: idx: 32 period:       9980 left:       9616
316.970562: x86_perf_event_set_period: idx: 32 period:       9980 left:       9674
316.970580: x86_perf_event_set_period: idx: 32 period:       8751 left:       8446
316.970596: x86_perf_event_set_period: idx: 32 period:      10733 left:      10428

This looks more than broken .... Seriously. 

    attr::freq        = 1
    attr::sample_freq = 20000

means 20000 samples per second, i.e. one sample every 50 microseconds,
unless this uses some magic new fangled math.

That CPU runs with 3.3GHz. Let's assume 1.0 IPC for simplicity. That
means in 50us it executes 16500 instructions, right?

So why on earth start with 1 as the estimate for the frequency
especially for this particular event which is guaranteed to fire
immediately? That makes no sense at all.

But even when you start with 1, then latest at the third event in the
loop or the third event within a couple of microseconds the frequency
estimate algorithm should notice that a period of 1 is bonkers.


But ranting^Wreasoning about all of this made me understand what goes
actually wrong.

Look at the "good" case:

316.966607: x86_perf_event_set_period: idx: 32 period:          1 left:          2
316.966621: x86_perf_event_set_period: idx: 32 period:          1 left:          2

Now the bad case:

# grep -E '\[063|135\]' t.txt

   cve-2015-3290-2725    [063] d..3.   316.967339: x86_perf_event_set_period: idx: 32 period:          1 left:          2
   cve-2015-3290-2725    [063] d.Z3.   316.967343: x86_perf_event_set_period: idx: 32 period:          1 left:          2
           <...>-2743    [135] d..3.   316.968473: x86_perf_event_set_period: idx: 32 period:          1 left:          2
           <...>-2743    [135] d.Z3.   316.968478: x86_perf_event_set_period: idx: 32 period:          1 left:          2
           <...>-2743    [135] d.h2.   316.970502: x86_perf_event_set_period: idx: 32 period:       5596 left:       5596
   cve-2015-3290-2725    [063] d.h2.   316.970503: x86_perf_event_set_period: idx: 32 period:       9385 left:       9385

Here the two hyperthread NMIs are interleaved by a few microseconds,
which is still good by some definition of good, but later it goes south:

   cve-2015-3290-2808    [063] d.Z3.   316.970712: x86_perf_event_set_period: idx: 32 period:          1 left:          2
   cve-2015-3290-2806    [135] d.Z3.   316.970712: x86_perf_event_set_period: idx: 32 period:          1 left:          2

Starting here they are not longer interleaved. They happen simultanously.

   cve-2015-3290-2806    [135] d.Z3.   316.970713: intel_pmu_handle_irq: 001        100000000
   cve-2015-3290-2808    [063] d.Z3.   316.970713: intel_pmu_handle_irq: 001        100000000
   cve-2015-3290-2808    [063] d.Z3.   316.970713: x86_perf_event_set_period: idx: 32 period:          1 left:          2
   cve-2015-3290-2806    [135] d.Z3.   316.970713: x86_perf_event_set_period: idx: 32 period:          1 left:          2

...
   cve-2015-3290-2808    [063] d.Z3.   316.970819: intel_pmu_handle_irq: 099        100000000
   cve-2015-3290-2806    [135] d.Z3.   316.970819: x86_perf_event_set_period: idx: 32 period:          1 left:          2
   cve-2015-3290-2808    [063] d.Z3.   316.970819: x86_perf_event_set_period: idx: 32 period:          1 left:          2
   cve-2015-3290-2806    [135] d.Z3.   316.970819: intel_pmu_handle_irq: 099        100000000
   cve-2015-3290-2808    [063] d.Z3.   316.970820: intel_pmu_handle_irq: 100        100000000
   cve-2015-3290-2806    [135] d.Z3.   316.970820: x86_perf_event_set_period: idx: 32 period:          1 left:          2
   cve-2015-3290-2806    [135] d.Z3.   316.970820: intel_pmu_handle_irq: 100        100000000

Which means they are almost in lockstep. TBH, I could not be bothered to
repeat the experiment and turn on nanoseconds resolution for the trace
because it's too obvious what's going on.

In the single threaded case period == 1 (left == 2) does not matter
because the status register stays zero after handling the event and is
only updated after the NMI returns which makes the NMI come back
immediately, but that does not cause a loop.

But in the HT sibling concurrent case the hardware behaves differently
and the status register is updated for whatever reason before returning
from the NMI, which causes the endless loop because both hyper threads
get that treatment.

To prove my point I disabled hyperthreading via /sys/.../cpu/smt/control
and as expected the test case can't trigger the problem anymore.
Grepping for the loop trace_printk() comes back empty. I disabled the
other one to reduce the noise over several runs, which keeps the trace
completely empty.

Reverse engineering hardware is fun, isn't it?

It's not hard either because every reproducible problem has a pattern.
You just have to look for it.

Now the conclusion of this fun exercise is:

    1) The hardware behaves differently when the perf event happens
       concurrently on HT siblings

    2) The frequency estimation algorithm is broken

    3) Using a 'limit' guestimate is just papering over the underlying
       problems

Thanks,

        tglx
---
 arch/x86/events/core.c       |    1 +
 arch/x86/events/intel/core.c |    5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1400,6 +1400,7 @@ int x86_perf_event_set_period(struct per
 
 	static_call_cond(x86_pmu_limit_period)(event, &left);
 
+	trace_printk("idx: %2d period: %10lld left: %10lld\n", idx, period, left);
 	this_cpu_write(pmc_prev_left[idx], left);
 
 	/*
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3164,13 +3164,16 @@ static int intel_pmu_handle_irq(struct p
 
 	loops = 0;
 again:
+	if (loops)
+		trace_printk("%03d %16llx\n,", loops, status);
 	intel_pmu_lbr_read();
 	intel_pmu_ack_status(status);
 	if (++loops > 100) {
 		static bool warned;
 
 		if (!warned) {
-			WARN(1, "perfevents: irq loop stuck!\n");
+			tracing_off();
+			//WARN(1, "perfevents: irq loop stuck!\n");
 			perf_event_print_debug();
 			warned = true;
 		}


