Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E771531A572;
	Tue, 23 Jun 2026 16:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782233439; cv=none; b=frwVBN70DIMQl8xMRoZWe1CkaEyZnEgEKBxuo3TRdHo4TdMknSTVovEpwfN18nQrKszeHfDFYZ0DcImn6SJBlij67JtrRP0LX4/Uk3EhbiuvXdspoR0jAhqUajsUcboOdK1JTHKpcqHKvEThw32Bp6Rl3WVNKZtpZONu7vxF5zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782233439; c=relaxed/simple;
	bh=iSPyoWrYb2LuFO1daSjKV4Q++qam+9le+dn+2rPNgYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWFA4iJfnawNWOVAyfFUr9jKAhwDATqKgB+DpYTCPoKg0Vuq7SkODKLlI20K1HreEiib219x/QE+mAmYkskLMwy4W2IgAnlhn+f8+WZlwZIDy43odkZiKLwuYp7LfGZ8djLYcwbrwbBPlF3BjR83pCQM2u+Mzb1eeEO/SokJetw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=An35byh6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="An35byh6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0FA1F000E9;
	Tue, 23 Jun 2026 16:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782233437;
	bh=OeRJ0tgCTUv568G8vi1FHh0MfeToMCU0SIxW5SVSQnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=An35byh6s/FKYEMweqFtnFd68VP/zUeZVx1fdJ93tcv/00LlzgWJJddsUSuZ8+FhX
	 aPWuS2RdWPq8foN3ZYpXHEjA6BT25dHfyeo5MyDkI/2KM+bEqvEHTmbT377LO+O7YJ
	 d5zz7EFfJzwq+8dTLLhbCpaMJh9njMuNp7xKaK254OfwNoclHlH8hDBFkoBYpmv9Da
	 UzOUjLp1Hbv00mb03wEVrwYyMHBAJTL8vIBw6E2jHZfcSlRdJ8eA8MvG3xXhvf3vOg
	 C7LoLjrAL2ydCBaY8ShMniVujnGWFZYgVnkBbVMhw+sozXfMr4XYQxb5fbm+nXUJz2
	 gqKsP0H1e8Z1Q==
Date: Tue, 23 Jun 2026 09:50:35 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/4] perf kvm: Kill STRDUP_FAIL_EXIT()
Message-ID: <ajq5WwN07wH35012@google.com>
References: <20260623070313.55225-1-namhyung@kernel.org>
 <20260623070313.55225-4-namhyung@kernel.org>
 <20260623071259.C36A01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260623071259.C36A01F000E9@smtp.kernel.org>

On Tue, Jun 23, 2026 at 07:12:59AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Medium] Memory leak of dynamically allocated strings in PowerPC default arch events due to removal of array cleanup loops.
> 
> Pre-existing issues:
> - [High] perf kvm record unconditionally crashes via BUG_ON() on non-Intel x86 hosts and architectures without default events.
> --
> 
> commit d3c8251de71559c69211fb2d23ba99dd14669107
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf kvm: Kill STRDUP_FAIL_EXIT()
> 
> This commit removes the STRDUP_FAIL_EXIT macro and replaces dynamically
> allocated copied strings with stack variables for passing command line
> options. It also removes the cleanup loops that freed these string
> copies, addressing a subtle double free issue.
> 
> > diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> > index acc6f2a706b35..477c28915c037 100644
> > --- a/tools/perf/builtin-kvm.c
> > +++ b/tools/perf/builtin-kvm.c
> [ ... ]
> > @@ -2008,9 +2004,9 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
> [ ... ]
> >  	for (j = 1; j < argc; j++, i++)
> > -		rec_argv[i] = STRDUP_FAIL_EXIT(argv[j]);
> > +		rec_argv[i] = argv[j];
> >  
> >  	BUG_ON(i != rec_argc);
> 
> [Severity: High]
> This is a pre-existing issue, but can this BUG_ON() crash the tool on
> non-Intel x86 hosts or architectures without default events?
> 
> If need_arch_event is true but the architecture hook returns early without
> adding events, rec_argc will be greater than the final value of i.
> 
> For example, in tools/perf/util/kvm-stat-arch/kvm-stat-x86.c:
> 
> __kvm_add_default_arch_event_x86() {
>         if (!x86__is_intel_cpu())
>                 return 0;
>         ...
> }
> 
> On AMD hosts, this returns 0 without incrementing the argument count, leaving
> i less than rec_argc and triggering the BUG_ON() assertion.
> 
> >  
> >  	ret = cmd_record(i, rec_argv);
> >  
> >  EXIT:
> > -	for (j = 0; j < i; j++)
> > -		free((void *)rec_argv[j]);
> 
> [Severity: Medium]
> Does removing this cleanup loop leak memory on PowerPC architectures?
> 
> While the central code now uses stack variables, the PowerPC architecture
> hook still dynamically allocates its default events. 
> 
> In tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c:
> 
> __kvm_add_default_arch_event_powerpc() {
>         ...
>         argv[j++] = strdup("-e");
>         argv[j++] = strdup("trace_imc/trace_cycles/");
>         ...
> }
> 
> Since these strings are allocated with strdup() and the free() loops in
> __cmd_record(), __cmd_top(), and kvm_events_record() have been removed,
> will these strings leak during command execution?

Right, will update powerpc.

Thanks,
Namhyung

> 
> >  	free(rec_argv);
> >  	return ret;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260623070313.55225-1-namhyung@kernel.org?part=3
