Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B371E4AEF2;
	Wed, 31 Jul 2024 19:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722453652; cv=none; b=mW+k7lBothHAWPSLFeukNWHdY2NnjGWTV6qyDN+qTP72Loe6u76+Gyrp/EeubyCQf3TfDA2LbbM5bYHwDUYCouWoiPQaw+0vEYkl7uPzbB7mdi4TA92JwtcdgCh5yRxbGi64O0KL5SiHIVNB6/cX6Wm0Hg9SPiLOVe7RRgwl94k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722453652; c=relaxed/simple;
	bh=3vlZh7oIEQknitawqvcIdP4Ha/MTmQlIDb2iz8qWHAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r161cuwEplTmWtDsk+JRPi2yO4EgoBLflOQa5xrA0eu7/iRx+1kDj1uLw4WX5MjczSpDN6BZdjy3V1fgSscC7082+3eeFCWzj6zTxJaXeBzK+bK47gtuLE0MUfGEWqi4PnY+BPduz61UTNpBjZxvezliTX414YYFn4HGVv6DflE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OhtFmPsQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vFQWGtr3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OhtFmPsQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vFQWGtr3"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722453648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zBWp6z1FDSPauVV3TyzMDnpYP6fyDl5cR9HjFp5gCAs=;
	b=OhtFmPsQNktXTwVYmbBT9ux2YeS5nW2Tmi4JiRotAIRzkU/4KbTsEWfpCSCssXQxU6bQxE
	sgCbu3oz//LEOWUz+TZ99iWlfe5S6NIFEfvgaFpWGXXB7XFA6qjiiBz+a9x7rIfTdDXgc2
	YXWrwQ9WT5fatXqiS9wgzDitPToUilpDagWFV22zGcGzuCRkQndgf35zDnsdpSqteqRxl0
	jX3L+zNkKjqgT8bd6YqlQV/rH98Vnk646ucFuAoyKDbJ0MnGTFhwh06hClj5vJN0NVMjq7
	9RBrnM9rsVVaL8ecxH3c62EMcML/xqDYzQQ3r6STlqFklpiOBFOElYAVD923gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722453648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zBWp6z1FDSPauVV3TyzMDnpYP6fyDl5cR9HjFp5gCAs=;
	b=vFQWGtr3ZY7DGMXxdVvzdpi/awXKj4weTGpq61AzG4wvXVzFM1eYfuf64VLCUNSEanoAb6
	xnxacPjei41zP3Cw==
To: Li Huafei <lihuafei1@huawei.com>, peterz@infradead.org, mingo@redhat.com
Cc: acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 lihuafei1@huawei.com
Subject: Re: [PATCH] perf/x86/intel: Restrict period on Haswell
In-Reply-To: <20240729223328.327835-1-lihuafei1@huawei.com>
References: <20240729223328.327835-1-lihuafei1@huawei.com>
Date: Wed, 31 Jul 2024 21:20:48 +0200
Message-ID: <875xsl5pwv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 30 2024 at 06:33, Li Huafei wrote:
> On my Haswell machine, running the ltp test cve-2015-3290 concurrently
> reports the following warnings:
>
>   perfevents: irq loop stuck!
>   WARNING: CPU: 31 PID: 32438 at arch/x86/events/intel/core.c:3174 intel_pmu_handle_irq+0x285/0x370
>   CPU: 31 UID: 0 PID: 32438 Comm: cve-2015-3290 Kdump: loaded Tainted: G S      W          6.11.0-rc1+ #3
>   ...
>   Call Trace:
>    <NMI>
>    ? __warn+0xa4/0x220
>    ? intel_pmu_handle_irq+0x285/0x370
>    ? __report_bug+0x123/0x130
>    ? intel_pmu_handle_irq+0x285/0x370
>    ? __report_bug+0x123/0x130
>    ? intel_pmu_handle_irq+0x285/0x370
>    ? report_bug+0x3e/0xa0
>    ? handle_bug+0x3c/0x70
>    ? exc_invalid_op+0x18/0x50
>    ? asm_exc_invalid_op+0x1a/0x20
>    ? irq_work_claim+0x1e/0x40
>    ? intel_pmu_handle_irq+0x285/0x370
>    perf_event_nmi_handler+0x3d/0x60
>    nmi_handle+0x104/0x330
>    ? ___ratelimit+0xe4/0x1b0
>    default_do_nmi+0x40/0x100
>    exc_nmi+0x104/0x180
>    end_repeat_nmi+0xf/0x53
>    ...
>    ? intel_pmu_lbr_enable_all+0x2a/0x90
>    ? __intel_pmu_enable_all.constprop.0+0x16d/0x1b0
>    ? __intel_pmu_enable_all.constprop.0+0x16d/0x1b0
>    perf_ctx_enable+0x8e/0xc0
>    __perf_install_in_context+0x146/0x3e0
>    ? __pfx___perf_install_in_context+0x10/0x10
>    remote_function+0x7c/0xa0
>    ? __pfx_remote_function+0x10/0x10
>    generic_exec_single+0xf8/0x150
>    smp_call_function_single+0x1dc/0x230
>    ? __pfx_remote_function+0x10/0x10
>    ? __pfx_smp_call_function_single+0x10/0x10
>    ? __pfx_remote_function+0x10/0x10
>    ? lock_is_held_type+0x9e/0x120
>    ? exclusive_event_installable+0x4f/0x140
>    perf_install_in_context+0x197/0x330
>    ? __pfx_perf_install_in_context+0x10/0x10
>    ? __pfx___perf_install_in_context+0x10/0x10
>    __do_sys_perf_event_open+0xb80/0x1100
>    ? __pfx___do_sys_perf_event_open+0x10/0x10
>    ? __pfx___lock_release+0x10/0x10
>    ? lockdep_hardirqs_on_prepare+0x135/0x200
>    ? ktime_get_coarse_real_ts64+0xee/0x100
>    ? ktime_get_coarse_real_ts64+0x92/0x100
>    do_syscall_64+0x70/0x180
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>    ...

Please trim the backtrace to something useful:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces

> My machine has 32 physical cores, each with two logical cores. During
> testing, it executes the CVE-2015-3290 test case 100 times concurrently.
>
> This warning was already present in [1] and a patch was given there to
> limit period to 128 on Haswell, but that patch was not merged into the
> mainline.  In [2] the period on Nehalem was limited to 32. I tested 16
> and 32 period on my machine and found that the problem could be
> reproduced with a limit of 16, but the problem did not reproduce when
> set to 32. It looks like we can limit the cycles to 32 on Haswell as
> well.

It looks like? Either it works or not.

>  
> +static void hsw_limit_period(struct perf_event *event, s64 *left)
> +{
> +	*left = max(*left, 32LL);
> +}

And why do we need a copy of nhm_limit_period() ?

Thanks,

        tglx
