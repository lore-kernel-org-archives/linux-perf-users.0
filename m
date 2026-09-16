Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7473793B0;
	Wed, 16 Sep 2026 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789571113; cv=none; b=u24LPnviynfgwEiFGwCdS1kT8dvEug0ey8d+253Pr/WvPbmAtKxn/x/2eYVaZVI9Zbcc+DatwERbiaIY3a4nviVHGd/GiBzibfoIL8S54g72shsCb4QQFY87U88hw1SpOpnrR4tUZdyH5d1R3dDU6iy691hZVmN0jTr2waTHMFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789571113; c=relaxed/simple;
	bh=lecKlwiZpOx67XjPELGhrtr2sWO32diwhhQ25lBYHPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyVO0zk5vAXNdp+qnNeTSual0ZRqWSHWlwHuDyp/kE/HEQVWk9HM7mPH2wps3UYqU7QAcXwxEL7sbJ1IkE3Gab3uo3xCSzZeimIYBSWz2P8diqwf/dZ5dl61LTZnePJhfUpYNAbAM+YP371JZ83Pp9LD5AndQm9p10r/SZCq1IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AVJxnD7c; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AVJxnD7c"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B14C540E01F9;
	Wed, 16 Sep 2026 15:05:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8aWCoS_NYVkT; Wed, 16 Sep 2026 15:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1789571096; bh=OavHCWMHrrNZGtQQFEfuOdSXz4SUqFw84RfIgt32BKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AVJxnD7chINUYXPPYH+EdWJImtVKM/uBwqDV3xpl5zS/oMqUAOxJyeY+CJxGH+k6w
	 OLbMjMvMvC6X7jNBelPQQbyxQp0RKdipnK3MwJNupxQCtVKVXnJlNVUrnXotiaMqb4
	 NkCtzIHawBNz3IYpMeGqk+ClEHzQ5GEPK5rmD5VewoxhI6EpLkcbZb7/5JwqiVpOcU
	 9ppRoKSnsrzXZWKkbZ/7I7iLB15FjyPord+7ZEL2k8cXnL7pK0mMBWE9kQ3Z+SaGR1
	 WCMUBZ6ri0Y9wgf2acLcNo8A61qdZ/yCdPvyOOYO4h0mDq5LwGJntzZ3xZUk/wKF1c
	 NE4Z/v3QqbaP6GSLQjcuq/rAi+WbO4oMSV5ggBnDDGu8UoJG5oRLA0iD6FwI7E27U5
	 0ZSLj5BcDOypfYw6z0+o/zFzyEB7mUlO4ts8KUHNVoQm8F1/hxYyJ5X6sWIZqRFylE
	 XMUzNqGE3gnijP995wLg1l//5+O0JK7ELFl01EBmA4P2NOxD7Yb39LLTugKoVgNoRE
	 l6wXziTY9mRN6nTp3VBRHhq2UP7c+ziRS1jvP8pDG2VjzgGGeno/yqu7/jb3wZKs3L
	 XDNkz5lFINBnUVfDHcvSIvrEoPdiAbrJnCdDEPx0HRUlZNuMgCSdMYollCjN0LU6ni
	 V0XxXhL4svuDld+AMHfZDjKs=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5B00240E00B9;
	Wed, 16 Sep 2026 15:04:40 +0000 (UTC)
Date: Wed, 16 Sep 2026 08:04:36 -0700
From: Borislav Petkov <bp@alien8.de>
To: Luka Absandze <absandze@amazon.de>, Sandipan Das <sandipan.das@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, tglx@kernel.org, dave.hansen@linux.intel.com,
	x86@kernel.org, yaoz@meta.com, dwmw2@infradead.org,
	kim.phillips@amd.com, kvm@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86/amd: Reject AMD Merge event as a countable event
Message-ID: <20260916150436.GAaqqwBD8KvgTVrmc3@fat_crate.local>
References: <20260916123315.89042-1-absandze@amazon.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916123315.89042-1-absandze@amazon.de>

+ Sandipan

On Wed, Sep 16, 2026 at 12:33:15PM +0000, Luka Absandze wrote:
> AMD event select 0xFFF (Merge) is the hardware control encoding used by
> Large Increment per Cycle (LIPC) pairs.  When written into an odd
> counter's PerfCtl it turns that counter into the upper 16 bits of a
> 64-bit merged accumulator; any subsequent arming write (-(2^47-1)) is
> silently truncated to its low 16 bits, while hwc->prev_count retains the
> full value.
> 
> This is particularly problematic with a KVM guest, which will program
> the Merge encoding into its own odd vPMC as a normal part of scheduling
> a LIPC event.  KVM intercepts that write and faithfully forwards it to
> the host as a raw event carrying the Merge encoding, where it is
> accepted as an ordinary countable event. Once a counter's PerfCtl holds
> the Merge encoding, every later user of that counter gets a first delta
> inflated by 2^47
> 
> Reject Merge (AMD_MERGE_EVENT) in amd_core_hw_config() so it cannot be
> submitted as a user-visible event.  The pair mechanism programs it
> itself via x86_pmu.perf_ctr_pair_en; nothing else should do so.
> 
> Fixes: 5738891229a2 ("perf/x86/amd: Add support for Large Increment per Cycle Events")
> Reported-by: Yao Zhou <yaoz@meta.com>
> Signed-off-by: Luka Absandze <absandze@amazon.de>
> ---
>  arch/x86/events/amd/core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 49b6b8fce566..cb655c751e5b 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -380,8 +380,12 @@ static int amd_core_hw_config(struct perf_event *event)
>  	else if (event->attr.exclude_guest)
>  		event->hw.config |= AMD64_EVENTSEL_HOSTONLY;
>  
> -	if ((x86_pmu.flags & PMU_FL_PAIR) && amd_is_pair_event_code(&event->hw))
> -		event->hw.flags |= PERF_X86_EVENT_PAIR;
> +	if (x86_pmu.flags & PMU_FL_PAIR) {
> +		if ((event->hw.config & AMD64_EVENTSEL_EVENT) == AMD_MERGE_EVENT)
> +			return -EINVAL;
> +		if (amd_is_pair_event_code(&event->hw))
> +			event->hw.flags |= PERF_X86_EVENT_PAIR;
> +	}
>  
>  	if (has_branch_stack(event))
>  		return static_call(amd_pmu_branch_hw_config)(event);
> -- 
> 2.47.3
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
