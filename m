Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575EB2853FD;
	Tue, 23 Jun 2026 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782233354; cv=none; b=i3UKSfTMHNv7dp04DNvBTluQ9XqaornSaEv0Q5SOtK1qBxkV7XhRaRWqGj1R9k6EYZpBKmN39O8LzaS6hZzR4yykVFa55tzG2OvEWqMtV5xYuYec7DFXer84q8m4NMopRa/nC5506+zSX4f5ejKPD0JkMILvJPTnMmaFDGH6AyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782233354; c=relaxed/simple;
	bh=uJESZwzQetj7bsP1Y5YB4Rky1pTFuKDm1eTLjrcKgD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxSegIDaKpNCwkgiqgBtXsJS8kbmKmfORRz5wd++cfjIO2daZTKPGHXAhE+p/OJUqyosOrFAALHPwksMp9cjPTWrEqb1MaLe1En6yAOzC+vdHwPZG23Qnxanvba6gYTZltU59kr2+f3AQfdGBwj7hMXv3+NiYt8y53SCid7T4Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPIsYuJZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPIsYuJZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BF51F000E9;
	Tue, 23 Jun 2026 16:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782233353;
	bh=UAIuZzJVuMknDux/bEzPsZD71ovTlDxXumqdgDrt0ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FPIsYuJZMGuNFb42/8CgB2rsdvqjeyPAE9jDG55eYI6/yUBXW4b0e4N7MBjr6GcoT
	 LDTTDrmyYI3+Y3RMAGlHFVYanMN3h6m3fjvpKFTSY5Lj06rTBPDEj0DcGs9VcgWC4t
	 S3Yg5EZf0r1xnd+3opAAidwlQij8Z34ESDxD5CiiB6VHl0tOdWPE4mDnh8yz7fBN9H
	 GSOTcvSLyhkaUPwbfhgbXB4bcXzrL4RMmwQch9oEPG6P9DGRbtGHUj+EXSq/6/V4im
	 0jiaVUeLYYEmSUIzVfp8idRaLjGKrSm8N0tKIBQ3KUFq24bJgVdohJaH1RRco2UoLz
	 zJH1PsSUg7Mzg==
Date: Tue, 23 Jun 2026 09:49:10 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/4] perf kvm: Check kvm_need_default_arch_event() early
Message-ID: <ajq5BhgBMjWpAc2S@google.com>
References: <20260623070313.55225-1-namhyung@kernel.org>
 <20260623070313.55225-3-namhyung@kernel.org>
 <20260623071657.7D2E61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260623071657.7D2E61F00A3A@smtp.kernel.org>

On Tue, Jun 23, 2026 at 07:16:57AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] BUG_ON() unconditionally triggers and crashes `perf kvm record` on architectures where default arch events are not added (e.g., ARM64, RISC-V, s390).
> --
> 
> commit e180ad0afcd0778bb15a60785a0b08bfd2f76a50
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf kvm: Check kvm_need_default_arch_event() early
> 
> This commit modifies perf kvm record to check if default options are needed
> before allocating arguments and passing the extra command line, preventing
> the default event from being incorrectly passed to the external command.
> 
> > diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> > index c236093eac473..acc6f2a706b35 100644
> > --- a/tools/perf/builtin-kvm.c
> > +++ b/tools/perf/builtin-kvm.c
> > @@ -1996,13 +1996,14 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
> >  {
> >  	int rec_argc, i = 0, j, ret;
> >  	const char **rec_argv;
> > +	int need_arch_event = !!kvm_need_default_arch_event(argc, argv);
> >  
> >  	/*
> >  	 * Besides the 2 more options "-o" and "filename",
> >  	 * kvm_add_default_arch_event() may add 2 extra options,
> > -	 * so allocate 4 more items.
> > +	 * so allocate more items conditionally.
> >  	 */
> > -	rec_argc = argc + 2 + 2;
> > +	rec_argc = argc + 2 + (2 * need_arch_event);
> 
> [ ... ]
> 
> > -	if (kvm_need_default_arch_event(argc, argv)) {
> > +	if (need_arch_event) {
> >  		ret = kvm_add_default_arch_event(EM_HOST, &i, rec_argv);
> >  		if (ret)
> >  			goto EXIT;
> >  	}
> >  
> > +	for (j = 1; j < argc; j++, i++)
> > +		rec_argv[i] = STRDUP_FAIL_EXIT(argv[j]);
> > +
> > -	BUG_ON(i + 2 != rec_argc);
> > +	BUG_ON(i != rec_argc);
> 
> [Severity: High]
> Could this BUG_ON() cause a regression for perf kvm record on architectures
> that do not add default events?
> 
> If kvm_need_default_arch_event() returns true, rec_argc is set to argc + 4.
> 
> However, on architectures like ARM64, RISC-V, or s390, it appears
> kvm_add_default_arch_event() can return 0 without actually appending any
> events or incrementing i.
> 
> If that happens, i will only equal argc + 2 after the loop, causing this
> assertion to unconditionally fail and abort the process.

I'll check those arch and make sure they return 0 in
kvm_need_default_arch_event().

Thanks,
Namhyung

