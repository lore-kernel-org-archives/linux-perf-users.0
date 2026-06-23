Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A51E31AABF;
	Tue, 23 Jun 2026 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782233248; cv=none; b=IQOxC97yN+B9jgkYxiiU2fV4hOrv9+iZMISjTMaG4DpF0HZnXdLdLrngHstorze4nudaWKQfQuSDRwi1bklFf1LbHLXVVxpP/gZ7jFCwJPnDFBoC1BnfXMw7s1/3HIf8AykXiD+kPmvr3EPIfGt8F0XAcaFCRWVsrOOIc7bFzNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782233248; c=relaxed/simple;
	bh=6nTOByax4jB/RbktR9QxlM7A/wdSSh8pFF50KsAtWFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMGxF+SQJaR9jRiXgPnh4HvG6k3S1l+lAUMQDlAPv+YRMOkh7GXm9vM3U4PehJpAlLSjGWIkgGaf2CjPMcNkmqhJBtiz1NkkMOwW7EBJYNSiRy0rh2dwedKgDLJkQe+npPHgwynoQC1oLJNyGtazNr5RXi2Ow/7P0rgQ7vDHifM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOV1Ww5G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOV1Ww5G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0633D1F000E9;
	Tue, 23 Jun 2026 16:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782233247;
	bh=8UEvW52Ma638yZfU88bw/Kpb9Z6U8oLREn0H6+Xnczg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MOV1Ww5GcmC3fHCsiFuSzltDFE/U90KkxiqpWS0RN/oytkzoaLz2/xKtqja5/M4BC
	 Jzc/yr4EWqyNwDLy1LLzIGaw1HFNWuVfhHaYZ5nlO1cq8uGaU/EZF7ClwDSrpXaJsg
	 toTHBSbvX2WvKl83L/Y8/vl2GtbBUYsOdZDezo+Nq3Dtp3HZB3/EJWMTYA5wsfBmNf
	 q72NGalI5M1dvBRaI3QerCaqiwBhQLxJgbcTyf0sq/ene112qYy/Ogl2+jHzM51MvE
	 5r5u0HkiHepyjIwKl9X4AOSoE3SzRD1rO2SjVuWraUtoznvVGkBRut/LK/MsnF+DQd
	 Mcl5t+2mk0rDg==
Date: Tue, 23 Jun 2026 09:47:25 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/4] perf kvm: Factor out kvm_need_default_arch_event()
Message-ID: <ajq4nVwaCzIOcsY-@google.com>
References: <20260623070313.55225-1-namhyung@kernel.org>
 <20260623070313.55225-2-namhyung@kernel.org>
 <20260623071641.61C2F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260623071641.61C2F1F000E9@smtp.kernel.org>

On Tue, Jun 23, 2026 at 07:16:40AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] `__cmd_top()` unconditionally appends the default architecture event, breaking user-provided event overrides.
> - [Low] Missing explicit POSIX <stdlib.h> header inclusion in kvm-stat.c for calloc() and free().
> --
> 
> commit 3e2018b99366e21f6651143f8ed90e3f8257ec72
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf kvm: Factor out kvm_need_default_arch_event()
> 
> This commit factors out the logic for checking existing event command line
> options into a generic kvm_need_default_arch_event() function. It removes the
> duplicated option checking logic from architecture-specific implementations
> of kvm_add_default_arch_event() and updates __cmd_record() to use the new
> guard.
> 
> > diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> > index 0c5e6b3aac74d..c236093eac473 100644
> > --- a/tools/perf/builtin-kvm.c
> > +++ b/tools/perf/builtin-kvm.c
> > @@ -2015,9 +2015,11 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
> >  
> >  	BUG_ON(i + 2 != rec_argc);
> >  
> > -	ret = kvm_add_default_arch_event(EM_HOST, &i, rec_argv);
> > -	if (ret)
> > -		goto EXIT;
> > +	if (kvm_need_default_arch_event(argc, argv)) {
> > +		ret = kvm_add_default_arch_event(EM_HOST, &i, rec_argv);
> > +		if (ret)
> > +			goto EXIT;
> > +	}
> >  
> >  	ret = cmd_record(i, rec_argv);
> >  
> 
> [Severity: High]
> Is it possible that __cmd_top() is missing the kvm_need_default_arch_event()
> guard?
> 
> Since the option parsing logic was removed from kvm_add_default_arch_event(),
> it now unconditionally appends the default event.
> 
> __cmd_top() in tools/perf/builtin-kvm.c still calls it unconditionally:
> 
> __cmd_top()
>         ...
>         ret = kvm_add_default_arch_event(EM_HOST, &i, rec_argv);
>         if (ret)
>                 goto EXIT;
> 
> Will this cause perf kvm top to ignore user-provided event overrides
> (like -e some_event) and blindly append the default event?

Right, will fix in v2.

> 
> [ ... ]
> 
> > diff --git a/tools/perf/util/kvm-stat.c b/tools/perf/util/kvm-stat.c
> > index 27f16810498ca..dd599dd0e4322 100644
> > --- a/tools/perf/util/kvm-stat.c
> > +++ b/tools/perf/util/kvm-stat.c
> [ ... ]
> > @@ -271,3 +272,29 @@ int kvm_add_default_arch_event(uint16_t e_machine, int *argc, const char **argv)
> >  		return 0;
> >  	}
> >  }
> > +
> > +bool kvm_need_default_arch_event(int argc, const char **argv)
> > +{
> > +	const char **tmp_argv;
> > +	bool event = false;
> > +	int i;
> > +
> > +	const struct option event_options[] = {
> > +		OPT_BOOLEAN('e', "event", &event, NULL),
> > +		OPT_BOOLEAN(0, "pfm-events", &event, NULL),
> > +		OPT_END()
> > +	};
> > +
> > +	/* parse_options() may change the argv, let's make a copy */
> > +	tmp_argv = calloc(argc + 1, sizeof(char *));
> 
> [Severity: Low]
> Should we explicitly include <stdlib.h> in this file to support musl libc
> builds?
> 
> The new kvm_need_default_arch_event() function relies on calloc() and free(),
> but <stdlib.h> isn't explicitly included in tools/perf/util/kvm-stat.c.
> 
> Because musl libc enforces strict standard header separation, relying on
> implicit includes can cause the build to fail.

Good point, will add.

Thanks,
Namhyung

> 
> > +	if (!tmp_argv)
> > +		return false;
> > +
> > +	for (i = 0; i < argc; i++)
> > +		tmp_argv[i] = argv[i];
> > +
> > +	parse_options(argc, tmp_argv, event_options, NULL, PARSE_OPT_KEEP_UNKNOWN);
> > +	free(tmp_argv);
> > +
> > +	return !event;
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260623070313.55225-1-namhyung@kernel.org?part=1
