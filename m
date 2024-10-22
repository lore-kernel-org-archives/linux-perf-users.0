Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFEC256D;
	Tue, 22 Oct 2024 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729616695; cv=none; b=cS6RrJn1Um4MxnKoXAY7XehQtDKOPsHn5k0VnfyiRemi/mOsfiCzKdAp45ydQRGKoU9t1/x4jOWGG38Ubd/w7jdPB9TLhPfpp8ZEBLrs4E0Un+CspcBia0CUvprUXDhXuS6ygW3eL0vMV6leksdTgKZvbAIEbOe3FAfhcsCLhlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729616695; c=relaxed/simple;
	bh=dnzywOLb2D/osssfwAX6Xm+weLGD8+cwQbYfop+7Tc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBCASb93/thtld9/U6Ov5YHtjsrLEiLg5y7GOPsKSFHFtGwVw9fuODzdFWxosvDZVa13ZDiF6VcOlotRGX+C9AtYcLtgwW5C4yRht5Z92260BbGViDcoOB5VsOlqw0jiFOOAO9U9HT58BFnaQprzAJeomgGTMOzKSW6cqF2lLUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyS4WoSL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyS4WoSL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFC0C4CEC7;
	Tue, 22 Oct 2024 17:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729616694;
	bh=dnzywOLb2D/osssfwAX6Xm+weLGD8+cwQbYfop+7Tc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HyS4WoSLGRXfsWgv53aWFoSFVcEkEEFzsWeiWw9jSxxLoYzCzGDIQXtNxOlhdL3mt
	 rbq9pW5zHq7gaF353s2YeEC14WE0VIlGV/EW+n971qQ3RDVwTxx58iJMIcnhtQzoss
	 aEoEAA5W43IGNeLYcPI+vBCcAOhzCXQ3BVWx7dvxDFgPj7ouygSvr7dzcG3QK29nMN
	 /kB0owkzDz1kJMi+W53V2OQWEsUJBxfS4NS8XSYodskCnNMNgq1MHLk3nzjOvlnZ/K
	 Tokl9Lf+onURwDmL4zDCaTReOJYMruz3nk+znaUbv03rGlcsNXb8nmwWc4U6e1O9bd
	 zHF2v2rsdNX9g==
Date: Tue, 22 Oct 2024 10:04:52 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Song Liu <songliubraving@fb.com>, Howard Chu <howardchu95@gmail.com>,
	Andrea Righi <andrea.righi@linux.dev>, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, james.clark@linaro.org,
	alan.maguire@oracle.com
Subject: Re: [PATCH v2 0/2] perf trace: Fix support for the new BPF feature
 in clang 12
Message-ID: <ZxfbNJ6nKXzoEYVn@google.com>
References: <20241011021403.4089793-1-howardchu95@gmail.com>
 <Zw61TUe1V97dKWer@google.com>
 <Zw7D9HXBanPLUO4G@x1>
 <Zw7JgJc0LOwSpuvx@x1>
 <Zw7SkmEaz730uVbL@x1>
 <Zw8fqyCZNqSABMkM@google.com>
 <Zw_MFwkejeWC2qbv@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zw_MFwkejeWC2qbv@x1>

Hi Arnaldo,

On Wed, Oct 16, 2024 at 11:22:15AM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Oct 15, 2024 at 07:06:35PM -0700, Namhyung Kim wrote:
> > Hi Arnaldo,
> > 
> > On Tue, Oct 15, 2024 at 05:37:38PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Tue, Oct 15, 2024 at 04:58:56PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > So I'm trying adding extra bounds checking, marking the index as
> > > > volatile, adding compiler barriers, etc, all the fun with the verifier,
> > > > but got distracted with other stuff, coming back to this now.
> > >  
> > > > Ok, the following seems to do the trick:
> > >  
> > > > [acme@dell-per740-01 perf-tools]$ git diff
> > > > diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > > > index 3b30aa74a3ae..ef87a04ff8d0 100644
> > > > --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > > > +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > > > @@ -486,6 +486,7 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
> > > >                                 augmented = true;
> > > >                 } else if (size < 0 && size >= -6) { /* buffer */
> > > >                         index = -(size + 1);
> > > > +                       index &= 7; // To satisfy the bounds checking with the verifier in some kernels
> > > >                         aug_size = args->args[index];
> > > >  
> > > >                         if (aug_size > TRACE_AUG_MAX_BUF)
> > > > 
> > > > I'll now test it without Howard's patch to see if it fixes the RHEL8 +
> > > > clang 17 case.
> > > 
> > > It works with this one-liner + the simplified patch from Howard and also
> > > on this other system (RHEL9), as well as with Fedora 40, it would be
> > > nice if someone could test with clang 16 and report back the version of
> > > the kernel tested as well as the distro name/release, that way I can try
> > > to get my hands on such as system and test there as well.
> > > 
> > > Its all at:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tmp.perf-tools
> > > 
> > > This is the current set of patches that when further tested will go to
> > > Linus for v6.12:
> > > 
> > > ⬢[acme@toolbox perf-tools]$ git log --oneline torvalds/master..
> > > ff14baa7a290bf42 (HEAD -> perf-tools, x1/perf-tools, perf-tools/tmp.perf-tools) perf trace augmented_raw_syscalls: Add more checks to pass the verifier
> > > 46180bec048aad85 perf trace augmented_raw_syscalls: Add extra array index bounds checking to satisfy some BPF verifiers
> > > 45d1aadac64869a2 perf build: Change the clang check back to 12.0.1
> > 
> > Wouldn't it be better to have this change after fixing the verifier
> > issues in the later commits?
> 
> I'm still testing it, this is a one-liner, so I think that the order in
> which the patches are applied isn't important. Also Howard's patch (the
> simplified one) doesn't clash with it.

I'm afraid if it'd break git bisect by allowing old clang versions
before the fix.

Thanks,
Namhyung

>  
> > > 4e21679eb81b5f0d perf trace: The return from 'write' isn't a pid
> > > 2d2314d4b09b5ed9 tools headers UAPI: Sync linux/const.h with the kernel headers
> > > ⬢[acme@toolbox perf-tools]$
> > 
> > I guess you also need the syscalltbl fix from Jiri Slaby.
> > 
> > https://lore.kernel.org/linux-perf-users/3a592835-a14f-40be-8961-c0cee7720a94@kernel.org/
> 
> Right, he provided a report about the patch I sent solving the case, I
> have to check if he replied to my question about perf trace actually
> _working_ on a 32-bit arch system.
> 
> I also want to test it, I'm trying to get hold of such a system.
> 
> - Arnaldo
