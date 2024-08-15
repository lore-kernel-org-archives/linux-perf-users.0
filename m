Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C10857CA7;
	Thu, 15 Aug 2024 23:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723765407; cv=none; b=EEet/g6IlgvwMnZR3xKXSIp04x+8Y3Rh2gLgSTEib8KmtdgIMwHCiZ4S0GpQ91QA51XEs0oVnnTlZecPdfnfsk4V4SbrExBfJKIh7FPbStbgo5jti62rTq5g0H3RIchjEDaiGmYRsflMZnl6zS9gdhDer317WxA/CJbYasQ5W5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723765407; c=relaxed/simple;
	bh=K+DgR8uw6O5PFI3wr1VI3pgqxp5LaYmdr4rVlO+twn8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UxwPI8IFb5BNDFNCl6foxeMQrs2uvS8+eHUDzJfl99DBjgzWDqNdUkQ2uxHk1dEbx/ryAQEwipfXVyg0HTbB8PJH+Uze4MgciwLriF5lBdbZ58nbczXUJ/6dfKD5/VUWf1wx9lelRT3Idt11hQKVPtGTgbfnIqK7DkffGkM94TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uHuKJBGm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oZXohWjR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uHuKJBGm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oZXohWjR"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723765401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2XRidH6KjhjXg8a6GEx4Lu5EO4pdvkhDlc0K73HvSQE=;
	b=uHuKJBGmoXryXSFUbrm1ydhs96IUQwYr5I80JKhSjtBbpvdNB/a0RyR/NYOXEl6BarQKEf
	GiVlLwHsatYv3U9t3e++z4Xn924Q00j38/clmSfLEbCjiGRv6slDJgTkiHTrLO/hGSvYLC
	6rMB9KqgYxytoVLdNzu2KXLn5CrSJ6VLBSgKHUs/a/U6q1Ic8FNwiCNKeWe2hbAw/bYJOF
	xDb+IweEG8kntI+LwgC8ccRbj4EA3tC2lXPpUaOfi4bHLV32Bx8R+WPwZdf5mrYpLRMXN2
	G+yN/VaPG1m3M4wdkkYtgCY0syzJMRarC9IPQ/VB2ZdoqgO8BfzXD4gzhL9zNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723765401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2XRidH6KjhjXg8a6GEx4Lu5EO4pdvkhDlc0K73HvSQE=;
	b=oZXohWjRkoDGTnkrsA6lSLzC2T1evvFF4+x0yEyCrUUNaHDWXaFHdBoCkQg3YqjF10Hy6/
	vwmmohkI5/xPcWCw==
To: "Liang, Kan" <kan.liang@linux.intel.com>, Li Huafei
 <lihuafei1@huawei.com>, peterz@infradead.org, mingo@redhat.com
Cc: acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Vince
 Weaver <vincent.weaver@maine.edu>
Subject: Re: [PATCH] perf/x86/intel: Restrict period on Haswell
In-Reply-To: <059d6217-10a5-4d2a-b639-90806c04a13b@linux.intel.com>
References: <87sev7nom4.ffs@tglx>
 <a42a3e35-2166-4539-930b-21ea0921e8d8@linux.intel.com>
 <87frr7nd28.ffs@tglx>
 <70657c5e-f771-456b-a5ac-3df590249288@linux.intel.com>
 <875xs2oh69.ffs@tglx>
 <166fdbdf-b24d-4267-b42d-f11348b87b1b@linux.intel.com>
 <87wmkhlk1l.ffs@tglx>
 <059d6217-10a5-4d2a-b639-90806c04a13b@linux.intel.com>
Date: Fri, 16 Aug 2024 01:43:21 +0200
Message-ID: <87plq9l5d2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 15 2024 at 16:15, Kan Liang wrote:
> On 2024-08-15 2:26 p.m., Thomas Gleixner wrote:
>>> Implication: When this erratum occurs, the fixed-function performance
>>> counter IA32_FIXED_CTR0 may over count by up to 32.
>> 
>> Sure. That's only explaining half of the problem.
>> 
>> As I demonstrated in the non-contended case even with a count of 2 (I
>> tried 1 too) the status bit is never set on the second check.
>> 
>
> Do you mean the below example? The status bit (32) of the fixed counter
> 0 is always set.

When HT is off or the threads are not running the handler concurrently
then there is zero looping. Once they start do fiddle concurrently the
looping starts and potentially never ends.

> 65.147782: x86_perf_event_set_period: idx:    32 period:         1 left:  2
> 65.147783: intel_pmu_handle_irq:      loops: 001 status: 100000000
>
> 65.147784: x86_perf_event_set_period: idx:    32 period:         1 left:  2
> 65.147784: intel_pmu_handle_irq:      loops: 002 status: 100000000

So in the non-concurrent (which includes !HT) case the status check
after handling the event is always 0. This never gets into a loop, not
even once.

>>> It should explains that the issue is gone with the magic number 32 or
>>> disabling the Hyper-Threading.
>> 
>> It explains only half of it. If you use 32, then the counter is set to
>> -32 so the overcount of 32 will still bring it to 0, which should set
>> the status bit, no?
>
> I think it's up to 32, not always 32.
> I don't have more details regarding the issue. The architect of HSW has
> left. I'm asking around internally to find the original bug report of
> the erratum. Hope there are more details in the report.

See below.

>>> I also found a related discussion about 9 years ago.
>>> https://lore.kernel.org/lkml/alpine.DEB.2.11.1505181343090.32481@vincent-weaver-1.umelst.maine.edu/
>>> Vince tried the workaround but it seems not work.
>> 
>> Let me play with that. :)
>
> Appreciate it.

I got it actually working. The inital sequence which "worked" is:

    1) Clear bit 32  in IA32_PERF_GLOBAL_CTRL
    2) Clear bit 0/1 in IA32_PERF_FIXED_CTR_CTRL
    3) Zero the IA32_FIXED_CTR0 MSR
    4) Set IA32_FIXED_CTR0 to (-left) & mask;
    5) Set bit 0/1 in IA32_PERF_FIXED_CTR_CTRL
    6) Set bit 32  in IA32_PERF_GLOBAL_CTRL

If I omit #3 it does not work. If I flip #5 and #6 it does not work.

So the initial "working" variant I had was hacking this sequence into
x86_perf_event_set_period() (omitting the fixed counter 0 conditionals
for readability):

	rdmsrl(MSR_CORE_PERF_GLOBAL_CTRL, cglbl);
	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, cglbl & ~(1ULL << 32));

	rdmsrl(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, cfixd);
	wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, cfixd & ~3ULL);

	wrmsrl(hwc->event_base, 0);
	wrmsrl(hwc->event_base, (u64)(-left) & x86_pmu.cntval_mask);

	wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, cfixd);
	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, cglbl);

Now I thought, that needs to be in intel/core.c and implemented a proper
quirk. And of course being smart I decided it's a brilliant idea to use
the cached values instead of the rdmsrl()s.

	cglbl = hybrid(cpuc->pmu, intel_ctrl) & ~cpuc->intel_ctrl_guest_mask;
	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, cglbl & ~(1ULL << 32));

        cfixd = cpuc->fixed_ctrl_val;
	wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, cfixd & ~3ULL);

	wrmsrl(hwc->event_base, 0);
	wrmsrl(hwc->event_base, (u64)(-left) & x86_pmu.cntval_mask);

	wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, cfixd);
	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, cglbl);

Surprise, surprise, that does not work. So I went back and wanted to
know which rdmslr() is curing it:

	rdmsrl(MSR_CORE_PERF_GLOBAL_CTRL, cglbl);
	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, cglbl & ~(1ULL << 32));

        cfixd = cpuc->fixed_ctrl_val;
	wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, cfixd & ~3ULL);

	wrmsrl(hwc->event_base, 0);
	wrmsrl(hwc->event_base, (u64)(-left) & x86_pmu.cntval_mask);

	wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, cfixd);
	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, cglbl);

This worked. Using the rdmsrl() only for MSR_ARCH_PERFMON_FIXED_CTR_CTRL
did not.

Now I got bold and boiled it down to:

	rdmsrl(MSR_CORE_PERF_GLOBAL_CTRL, cglbl);

	wrmsrl(hwc->event_base, 0);
	wrmsrl(hwc->event_base, (u64)(-left) & x86_pmu.cntval_mask);

and the whole thing still worked. *BLINK*

Exactly zero loop entries in the trace when running 100 instances of
that cve test case, which otherwise spams the trace with entries and
ends up in the loop > 100 path within a split second.

Removing the zeroing of the counter makes it come back, but reducing the
whole nonsense to:

	wrmsrl(hwc->event_base, 0);
	wrmsrl(hwc->event_base, (u64)(-left) & x86_pmu.cntval_mask);

makes the loop problem go away, but it "works" so well that the stupid
frequency adjustment algorithm keeps the left == 1, i.e count == 2 case
stay long enough around to trigger 'hung task messages' ....

Now I looked more at the dmesg output of all the experiments. In all
"working" cases except one running these 100 instances of cve... results
in a varying cascade of

   perf: interrupt took too long (2503 > 2500), lowering ...

messages.

The one case where this does not happen is when the limit is
unconditionally set to 32. But when I apply this limit only for the
fixed counter 0 it comes back. 

Now I looked at when these 'took too long' problems surface aside of the
obvious case of extensive looping. They are unrelated to the hyper
threading issue as I can reproduce with smt=off too.

They always happen when a counter was armed with a count < 32 and two
events expired in the same NMI. The test case uses fixed counter 0 and
general counter 0 for the other event.

So that erratum is a good hint, but that hardware does have more issues
than it tells.

So I think we should just apply that limit patch with a proper change
log and also make it:

hsw_limit(...)
{
	*left = max(*left, erratum_hsw11(event) ? 128 : 32;);
}

or such.

That limit won't cure the overcount issue from that HSM154 erratum, but
*SHRUG*.

Thanks,

        tglx
