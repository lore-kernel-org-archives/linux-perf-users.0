Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0F71B373B;
	Wed, 14 Aug 2024 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723646587; cv=none; b=MsqilVnyOlGS7pxHVqEb09Vn2S/5tRXDnzykYL/xuqN/XXyM8ySbnOMuTlfw2Yf3Xp+KJ6PJc95BbSxYAXdZkBAXKXpaBrUX3eFUPzvfnoCTR5zbHWJ1aVMaqre4ZJa3kf+NOMbCU798oWDXBManv1eLs9Zzujwb5GhmT0AInLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723646587; c=relaxed/simple;
	bh=9xtS5oXDruHKmH17qtvD0oi54++fWO816Kyvd6zH9XQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=EVB1roPB2GgR5mZNfHhmSth9sKD9PI9r5vlisbr2sGdfNtYXIBbyoKAXn150ZJ4y7iEJdoUUo328FoU0TDXGc2FW+pNEWIKH00zbCZSD2M1+yGM1Z6zl/k7hrQXEfp9ls6i8gYkgyVb+tG2J2E8+7JRJ6MhPKHDRpyEPJhy65HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WO+cjit1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lnyiN52O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WO+cjit1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lnyiN52O"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723646583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=Lcrk78kvLD57a6HRaT+x89f6hNY7nMNBaXWKad4tGQk=;
	b=WO+cjit1yxdN2ENumLFlf+zFyiMX8QxmE8+rmSWwqHSy73vw0hO4t1xNak4/0/S5jA3bp7
	FDKLx45uGpJ98AaIBjsOT/Z4TZRU79Zc20P3dDpcnMvgbP92ck0d+gnsc/nteKVt8KW6hW
	b7qcUgWPoGNKU6bvaHhKqFPWck776zxNxAZjr1k51I/OKQT+3GM8IL291dgsl5v9pZGRIt
	WpJD0f3bBHGWoNU5HRU63J9iwnnjki2Te+MtvtWx+Djf0WzCvf2RteMiRDzsHSFBaN4vWj
	dK+s1SDq/5phjs+ObdiELDJfl6qhD6yBuUr0lie//vpSOG70o6kVyXUUzv6PBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723646583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=Lcrk78kvLD57a6HRaT+x89f6hNY7nMNBaXWKad4tGQk=;
	b=lnyiN52OR9QBONN9sQB46j5NRyoTYp5K0VDTj00SUkm0V+6wpg+bm9OBBsVCTGUEe+dCKR
	Pq5dfe18nyMMLAAQ==
To: Li Huafei <lihuafei1@huawei.com>, peterz@infradead.org, mingo@redhat.com
Cc: acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel: Restrict period on Haswell
In-Reply-To: <fb87cc82-94b7-31aa-0374-a1d7fa49470e@huawei.com>
Date: Wed, 14 Aug 2024 16:43:03 +0200
Message-ID: <87ttfnnp1k.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Li!

On Tue, Aug 13 2024 at 21:13, Li Huafei wrote:
> On 2024/8/1 3:20, Thomas Gleixner wrote:
>>> My machine has 32 physical cores, each with two logical cores. During
>>> testing, it executes the CVE-2015-3290 test case 100 times concurrently.
>>>
>>> This warning was already present in [1] and a patch was given there to
>>> limit period to 128 on Haswell, but that patch was not merged into the
>>> mainline.  In [2] the period on Nehalem was limited to 32. I tested 16
>>> and 32 period on my machine and found that the problem could be
>>> reproduced with a limit of 16, but the problem did not reproduce when
>>> set to 32. It looks like we can limit the cycles to 32 on Haswell as
>>> well.
>> 
>> It looks like? Either it works or not.
>
> It worked for my test scenario. I say "looks like" because I'm not sure
> how it circumvents the problem, and if the limit of 32 no longer works
> if I increase the number of test cases executed in parallel. Any
> suggestions?

If you read back through the email history of these limits, then you can
see that too short periods cause that problem on Broadwell due to a
erratum, which is explained on top of the BDW limit.

Now looking at the HSW specification update specifically erratum HSW11:

  Performance Monitor Precise Instruction Retired Event May Present
  Wrong Indications

  Problem:
         When the Precise Distribution for Instructions Retired (PDIR)
         mechanism is activated (INST_RETIRED.ALL (event C0H, umask
         value 00H) on Counter 1 programmed in PEBS mode), the processor
         may return wrong PEBS or Performance Monitoring Interrupt (PMI)
         interrupts and/or incorrect counter values if the counter is
         reset with a Sample- After-Value (SAV) below 100 (the SAV is
         the counter reset value software programs in the MSR
         IA32_PMC1[47:0] in order to control interrupt frequency).

  Implication:
         Due to this erratum, when using low SAV values, the program may
         get incorrect PEBS or PMI interrupts and/or an invalid counter
         state.

  Workaround:
         The sampling driver should avoid using SAV<100.

IOW, that's exactly the same issue as the BDM11 erratum.

Kan: Can you please go through the various specification updates and
identify which generations are affected by this and fix it once and
forever in a sane way instead of relying on 'tried until it works by
some definition of works' hacks. These errata are there for a reason.

But that does not explain the fallout with that cve test because that
does not use PEBS AFAICT. It's using fixed counter 0.

Li, you added that huge useless backtrace to your changelog, but omitted
the output of perf_event_print_debug() after that. It should tell us
about which counter is causing that.

>>> +static void hsw_limit_period(struct perf_event *event, s64 *left)
>>> +{
>>> +	*left = max(*left, 32LL);
>>> +}
>> 
>> And why do we need a copy of nhm_limit_period() ?
>> 
>
> Do you mean why the period is limited to 32 like nhm_limit_period()?

No. If 32 is the correct limit, then we don't need another function
which does exactly the same. So you can assign exactly that function for
HSW, no?

Thanks,

        tglx
