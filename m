Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108D358AD0;
	Fri, 13 Sep 2024 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726242699; cv=none; b=tTcH2xxaQwXUNi2MfBv+e1fE+KkCB0MzyETTuGK7sXo+L+zuZHB31FprNrV9US5r//Eo3yr3D3MEYZ1gTQ0QLujD4u/piaFjNOFdDn6/yzU7ac5L70uwX20cFYT+mG05Z6votWPDxD2Pqv2RtSO0tJKX5yWm1XkRWXetp+HHEpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726242699; c=relaxed/simple;
	bh=GAmUucMy9vuLeh91K6btHFOEbFl/PyM0yqJoMR0hgjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eiua4MOUcm0snDLnUlGZNUw/OWkVScsmjSV9xl2LW6hUpTIbiDg5LBVSXIBUVxplfHytv/29VCO/bIFxxPgqURoZd8ppKXM405W8HxTfoqYTaRZ822w9v4OD080MnFumqx1qKdhduZ841iVW1xt/1v9ixpfYpMVGh8lwcrJ3Fqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kf8x/i6s; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kf8x/i6s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726242698; x=1757778698;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GAmUucMy9vuLeh91K6btHFOEbFl/PyM0yqJoMR0hgjs=;
  b=kf8x/i6sm2AJNPH73Z2fyG7AVL/4O6zIF48jrTqm5ImKd5tXrgD6Val5
   5M83uoTf2cOtJfZy/BZr/UdtxlTupXGfhlhBySkuNcDpJZVVgnuhWuR83
   uO2pCguPsrBUBQozY1OTltz/tUM1IST9AzIjtzOal0VyuM8h6LAqLtvTY
   3BuibHhrCzcr9ECT2YPWT2TY6UXVj93PXGjlsXWuMAqIFtvrdv1YfnYci
   cdAVxkWVhZnxf81/t8liNcD+/qr9IyPb/0A2T//JhlipIHMtTAVWIOkib
   w3dmqfer5mYv3OdRxWpzQ0OZ0r1ThHuvpJQlu+hypshm+D4u5yvyn5jKn
   A==;
X-CSE-ConnectionGUID: th7AMbPZSm+aT+vJ82voqw==
X-CSE-MsgGUID: SbfXi+l3QJewaHx7zAxiEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="25347411"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="25347411"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 08:51:38 -0700
X-CSE-ConnectionGUID: 8BmZfTWZTNaiueaoRACoKA==
X-CSE-MsgGUID: sorbTAXYTgSt0vskP4Noig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="91360656"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 08:51:37 -0700
Received: from [10.212.21.130] (kliang2-mobl1.ccr.corp.intel.com [10.212.21.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 8955820CFED7;
	Fri, 13 Sep 2024 08:51:35 -0700 (PDT)
Message-ID: <8a9dabcd-023a-4e8f-8570-3c69a9cf0c0a@linux.intel.com>
Date: Fri, 13 Sep 2024 11:51:34 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG BISECTED] Missing RCU reader in perf_event_setup_cpumask()
To: Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com
References: <2b66dff8-b827-494b-b151-1ad8d56f13e6@paulmck-laptop>
 <20240913104752.GU4723@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240913104752.GU4723@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-09-13 6:47 a.m., Peter Zijlstra wrote:
> On Fri, Sep 13, 2024 at 01:00:44AM -0700, Paul E. McKenney wrote:
>> Hello!
>>
>> On next-20240912 running rcutorture scenario TREE05, I see this
>> deterministically:
>>
>> [   32.603233] =============================
>> [   32.604594] WARNING: suspicious RCU usage
>> [   32.605928] 6.11.0-rc5-00040-g4ba4f1afb6a9 #55238 Not tainted
>> [   32.607812] -----------------------------
>> [   32.609140] kernel/events/core.c:13946 RCU-list traversed in non-reader section!!
>> [   32.611595]
>> [   32.611595] other info that might help us debug this:
>> [   32.611595]
>> [   32.614247]
>> [   32.614247] rcu_scheduler_active = 2, debug_locks = 1
>> [   32.616392] 3 locks held by cpuhp/4/35:
>> [   32.617687]  #0: ffffffffb666a650 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun+0x4e/0x200
>> [   32.620563]  #1: ffffffffb666cd20 (cpuhp_state-down){+.+.}-{0:0}, at: cpuhp_thread_fun+0x4e/0x200
>> [   32.623412]  #2: ffffffffb677c288 (pmus_lock){+.+.}-{3:3}, at: perf_event_exit_cpu_context+0x32/0x2f0
>> [   32.626399]
>> [   32.626399] stack backtrace:
>> [   32.627848] CPU: 4 UID: 0 PID: 35 Comm: cpuhp/4 Not tainted 6.11.0-rc5-00040-g4ba4f1afb6a9 #55238
>> [   32.628832] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>> [   32.628832] Call Trace:
>> [   32.628832]  <TASK>
>> [   32.628832]  dump_stack_lvl+0x83/0xa0
>> [   32.628832]  lockdep_rcu_suspicious+0x143/0x1a0
>> [   32.628832]  perf_event_exit_cpu_context+0x2e5/0x2f0
>> [   32.628832]  ? __pfx_perf_event_exit_cpu+0x10/0x10
>> [   32.628832]  perf_event_exit_cpu+0x9/0x10
>> [   32.628832]  cpuhp_invoke_callback+0x130/0x2a0
>> [   32.628832]  ? lock_release+0xc7/0x290
>> [   32.628832]  ? cpuhp_thread_fun+0x4e/0x200
>> [   32.628832]  cpuhp_thread_fun+0x183/0x200
>> [   32.628832]  smpboot_thread_fn+0xd8/0x1d0
>> [   32.628832]  ? __pfx_smpboot_thread_fn+0x10/0x10
>> [   32.628832]  kthread+0xd4/0x100
>> [   32.628832]  ? __pfx_kthread+0x10/0x10
>> [   32.628832]  ret_from_fork+0x2f/0x50
>> [   32.628832]  ? __pfx_kthread+0x10/0x10
>> [   32.628832]  ret_from_fork_asm+0x1a/0x30
>> [   32.628832]  </TASK>
>>
>> I bisected this to:
>>
>> 4ba4f1afb6a9 ("perf: Generic hotplug support for a PMU with a scope")
>>
>> This adds a perf_event_setup_cpumask() function that uses
>> list_for_each_entry_rcu() without an obvious RCU read-side critical
>> section, so the fix might be as simple as adding rcu_read_lock() and
>> rcu_read_unlock().  In the proper places, of course.  ;-)
> 
> IIRC that condition should be:
> 
>   lockdep_is_held(&pmus_srcu) || lockdep_is_held(&pmus_lock)
> 
> And at this pooint we actually do hold pmus_lock.
> 
> But that all begs the question why we're using RCU iteration here to
> begin with, as this code seems to be only called from this context.

I think I just copied and paste the PMU iterate code here, and forget to
add the srcu_read_lock(). Sorry for it.

> 
> Kan, is the simple fix to do:
> 
> -	list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
> +	list_for_each_entry(pmu, &pmus, entry) {
> 
> ?
>   

Yes, the &pmus_lock protect is good enough. we don't need the rcu here.
I will post a patch with the suggested fix.

Thanks,
Kan

