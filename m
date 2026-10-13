Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A55558203;
	Tue, 13 Oct 2026 20:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791925029; cv=none; b=CZQH49E8YPmw5QHqVtE4qMaWh7oVMoQ9vqH5H8nsAhicwEe7QF5o7vKD7fOSbL0Lny/CpQIY5iRjnVA2yivHhg6R5fPHwSNmUEyJj7ecI7wOae4Gxa+tYpl0sAZcTaSBiEtomveBUD3SmBO32CbaiC7Cfp1gtha04r0KRsUFLyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791925029; c=relaxed/simple;
	bh=94mZ+iZOEBz8sjUg1hFHkXla6LF8acESWz/g7ZYyYNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMm2SyV42mDdvaDp8Yr5tGBaK/sODwT23BWtxhPgJUGq3KWoFNS0SNRHCNEaWqxdcsTJXDTZHDSh8LkShsnq0Jw8OSsz22imD15osEbO/DspTDScWWtkOewjOy3+aWTszyRCnNmcYtTXevQvjjaOkDMARyDHsH++QB5gqleDp7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRCTT6/V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRCTT6/V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0D81F00893;
	Tue, 13 Oct 2026 20:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791925025;
	bh=VuMzsdrgrJyvSAviczO8JI01lqK2FIsGC0YJfBtGVuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GRCTT6/V881iBM1VUNoCX54Xa3TTV03zgfQWSgtRHqvqHEEx7yeyIdjNlLdUkKg+7
	 nkHpJfnwzdUZgcrimMeHDR+Jmg/i6Ku5cUz/AwIifFe3BuXmpjvNbbubeTqKT8TzIz
	 ikZ6y8XIjf4xbq2TcVG2wRKZhtyPRhPqYzS9FAHJtz+or8C2exmpaDGmVkapxT1w/W
	 3lviXS5VUAp51qlWzkyDC8xA6YWUsrSPDW/vNvMEJFfdCylYDpu0pnu87TNcml7BMS
	 uL1UL7zazjNuxlQDtkZ4WUMWdjhXIvOQ7hSA0BwTyXwDVMgJCmQuagaNUq+HF3ehnN
	 DhS5Sg8SCqsGg==
Date: Tue, 13 Oct 2026 13:57:04 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 06/11] perf symbol: Get rid of
 machine_or_dso_e_machine()
Message-ID: <as6bIHrio0WjQnOT@google.com>
References: <20261013172155.160869-1-namhyung@kernel.org>
 <20261013172155.160869-7-namhyung@kernel.org>
 <sashiko-outbox-170240@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-170240@kernel.org>

On Tue, Oct 13, 2026 at 05:37:49PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] perf symbol: NULL pointer dereference in dso__load() on error path
> --
> 
> commit a7899d8622f5885c1647a9ddbd7a9ae67999aeeb
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf symbol: Get rid of machine_or_dso_e_machine()
> 
> This commit removes the machine_or_dso_e_machine() fallback logic and relies
> directly on perf_env__e_machine() for kernel maps. It aims to prevent
> recursive locking issues and assumes kernel DSO architectures are correctly
> described by the machine environment.
> 
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index 56b8d75966133..a7afecb5816c2 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> [ ... ]
> > @@ -1855,7 +1838,7 @@ int dso__load(struct dso *dso, struct map *map)
> >  			ret = dso__load_guest_kernel_sym(dso, map);
> >  
> >  		machine = maps__machine(map__kmaps(map));
> > -		if (machine && machine_or_dso_e_machine(machine, dso) == EM_X86_64)
> > +		if (perf_env__e_machine(machine->env, /*e_flags=*/NULL) == EM_X86_64)
> 
> [Severity: Medium]
> Does this code cause a NULL pointer dereference if machine is NULL?
> 
> By removing the machine pointer guard, if map__kmaps() returns NULL (for
> example, if a kernel DSO is incorrectly associated with a non-kernel map from a
> malformed perf.data file), maps__machine() will also return NULL. Passing
> machine->env directly to perf_env__e_machine() in this state will then trigger
> a segfault.
> 
> Could the machine check be restored before attempting to read its environment?

I believe machine cannot be NULL when it's from a kmap.  In fact, I
think we'd better guarantee it's non-NULL for all cases.  IIUC only case
it can be NULL is a test case (and it's not a kmap).  I think it's better
to update the test not to pass NULL instead.

Thanks,
Namhyung

> 
> >  			machine__map_x86_64_entry_trampolines(machine, dso);
> >  		goto out;
> >  	}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261013172155.160869-1-namhyung@kernel.org?part=6
