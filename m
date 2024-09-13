Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10432C80;
	Fri, 13 Sep 2024 10:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726224491; cv=none; b=RXYW5Xvdm2pRP3B/7DKr42UijAMvq9u3W6L9cdPp5B3bJ5Ns9semmHkEnS1zm3ins6/waGz324FYeG/gSMDRbfjOl2bxrYAVt8VbKQD3MSuTd15FhCdtxfmaDp04ukcpjI+mtgPwsydN9DkgiCLFw4uOC7p4EUSTLZPwMd5Sd7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726224491; c=relaxed/simple;
	bh=uyXk2wl0oIMrGI35p0JiaNvUYXkyuKxh0QgHHyUWTBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6hcRClC5umgFD4SM9EcWR5HO0gUvEVaxIam1y0bMMszlxAWlyYHJrWsXSc9I6Gt8c7mvtLtpM93VdH8TwT8Omt0pDVzZzmPa8VY10FfggcewzAcoCqlDhivJug5MNdDZO2TKRFGtaZfQv/buZr73Az+uV6YbB1rUQiHk0OoZzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IBfUeyqm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IBfUeyqm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qExJ1eSAIG6uS9RKXYfNI+ldhnokTO3+3L9xVG0mHwI=; b=IBfUeyqmy7otonnkWjM0yC42zG
	O+d/EyOr/n9+iQrz1ApQcHk7rYpMhuVQVMAuP172YBQeLRGanJ57RVd1YVrvw6eZI+nh5cwGwtgA9
	IZXPwdan9yA3FAIWIE+jr/2Ewq+G0qElVnx2PPQFEtybcwEPpELj+i3p8SvR0VQeYgg0jtHfA2JbK
	R2KEB+aJlxtm7HQ2d1mz7EXkGtfNpb4Ikbt4rbFqW0ZGKsWpH4X9UUnvmA432pohKS3u6+LeDAb4a
	V1jffnxaeYHS4ERxXMDPJxQQvvxchUAtF5C/fsuQ8wdtRWbEOjCB53IVKkZsmjFGxFaRP3tWLYgxn
	XRfVhttw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sp3qD-0000000GT5k-11dF;
	Fri, 13 Sep 2024 10:47:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 310163003E1; Fri, 13 Sep 2024 12:47:52 +0200 (CEST)
Date: Fri, 13 Sep 2024 12:47:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	kan.liang@linux.intel.com, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com
Subject: Re: [BUG BISECTED] Missing RCU reader in perf_event_setup_cpumask()
Message-ID: <20240913104752.GU4723@noisy.programming.kicks-ass.net>
References: <2b66dff8-b827-494b-b151-1ad8d56f13e6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b66dff8-b827-494b-b151-1ad8d56f13e6@paulmck-laptop>

On Fri, Sep 13, 2024 at 01:00:44AM -0700, Paul E. McKenney wrote:
> Hello!
> 
> On next-20240912 running rcutorture scenario TREE05, I see this
> deterministically:
> 
> [   32.603233] =============================
> [   32.604594] WARNING: suspicious RCU usage
> [   32.605928] 6.11.0-rc5-00040-g4ba4f1afb6a9 #55238 Not tainted
> [   32.607812] -----------------------------
> [   32.609140] kernel/events/core.c:13946 RCU-list traversed in non-reader section!!
> [   32.611595]
> [   32.611595] other info that might help us debug this:
> [   32.611595]
> [   32.614247]
> [   32.614247] rcu_scheduler_active = 2, debug_locks = 1
> [   32.616392] 3 locks held by cpuhp/4/35:
> [   32.617687]  #0: ffffffffb666a650 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun+0x4e/0x200
> [   32.620563]  #1: ffffffffb666cd20 (cpuhp_state-down){+.+.}-{0:0}, at: cpuhp_thread_fun+0x4e/0x200
> [   32.623412]  #2: ffffffffb677c288 (pmus_lock){+.+.}-{3:3}, at: perf_event_exit_cpu_context+0x32/0x2f0
> [   32.626399]
> [   32.626399] stack backtrace:
> [   32.627848] CPU: 4 UID: 0 PID: 35 Comm: cpuhp/4 Not tainted 6.11.0-rc5-00040-g4ba4f1afb6a9 #55238
> [   32.628832] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [   32.628832] Call Trace:
> [   32.628832]  <TASK>
> [   32.628832]  dump_stack_lvl+0x83/0xa0
> [   32.628832]  lockdep_rcu_suspicious+0x143/0x1a0
> [   32.628832]  perf_event_exit_cpu_context+0x2e5/0x2f0
> [   32.628832]  ? __pfx_perf_event_exit_cpu+0x10/0x10
> [   32.628832]  perf_event_exit_cpu+0x9/0x10
> [   32.628832]  cpuhp_invoke_callback+0x130/0x2a0
> [   32.628832]  ? lock_release+0xc7/0x290
> [   32.628832]  ? cpuhp_thread_fun+0x4e/0x200
> [   32.628832]  cpuhp_thread_fun+0x183/0x200
> [   32.628832]  smpboot_thread_fn+0xd8/0x1d0
> [   32.628832]  ? __pfx_smpboot_thread_fn+0x10/0x10
> [   32.628832]  kthread+0xd4/0x100
> [   32.628832]  ? __pfx_kthread+0x10/0x10
> [   32.628832]  ret_from_fork+0x2f/0x50
> [   32.628832]  ? __pfx_kthread+0x10/0x10
> [   32.628832]  ret_from_fork_asm+0x1a/0x30
> [   32.628832]  </TASK>
> 
> I bisected this to:
> 
> 4ba4f1afb6a9 ("perf: Generic hotplug support for a PMU with a scope")
> 
> This adds a perf_event_setup_cpumask() function that uses
> list_for_each_entry_rcu() without an obvious RCU read-side critical
> section, so the fix might be as simple as adding rcu_read_lock() and
> rcu_read_unlock().  In the proper places, of course.  ;-)

IIRC that condition should be:

  lockdep_is_held(&pmus_srcu) || lockdep_is_held(&pmus_lock)

And at this pooint we actually do hold pmus_lock.

But that all begs the question why we're using RCU iteration here to
begin with, as this code seems to be only called from this context.

Kan, is the simple fix to do:

-	list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
+	list_for_each_entry(pmu, &pmus, entry) {

?
  
