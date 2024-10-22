Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7850E126C05;
	Tue, 22 Oct 2024 23:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729641138; cv=none; b=aO/fL9UFAzhzuKiFaetTzC4l/e0HcFPf2Mokm/WXNVC2qO8txa85tlm0PsCUs/1HFDmONFlm1/Wb4dOGnjqtPUJgl6z0qs7c55bLH16P7K2a0Bzs/sgfoioC6uVQnlJ9V8UkIU19B7dQcwPYqSeSnpHafPgM6i/j/KkDgmDdPSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729641138; c=relaxed/simple;
	bh=rFVlsj1qHn0/duDf7jKx17I7NGXKofb8ULGbc4GE0XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUB8kE486n8rm99iCHU7kURlROR1e1uqm29dsuGFN/WHmLqpW6Vagk1vx9Uxzs43KS7GhKVnJXkU6jkg/JZLErb/MWz1qYSG0I8jF5b5Nko4PRcuWVMo890J6m05+bmFfdWFRn9c4P3qCpk/KkM9s84FDM4Q2RfEQeyCAlLrGRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sW8yb4Cg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sW8yb4Cg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBCCC4CEC3;
	Tue, 22 Oct 2024 23:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729641138;
	bh=rFVlsj1qHn0/duDf7jKx17I7NGXKofb8ULGbc4GE0XI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sW8yb4CgXjRyuzn3MRhtnszS8mdpFspNU2huCIPazc07bCEAKZORjJxPKbw17eAqF
	 7qFgowQUCXRLpTpqzKodv6Jp4U0vlnrKOtw9S+bjBPKzQbcP1kKGYjRGQ2/On7A7p8
	 4xHzZY21eBgWXyNZOdFIjX83AaMXJuL9E/AT53fGpcbqIRdx5rrNHP4Uxos1saHkd9
	 Z8vnbovbGHlfD2IsjTjLCYfUMJA6+eVg4LO9htSthcJAHW8WhGjNpJGkZuADn5yQ33
	 fxcP/oWVhxquaNa6g5z7Abcoq2S8QEciQGpoWgewfmKCWhCfZ7CKw0pdj3GADQcYCr
	 libLGrNRrEa7A==
Date: Tue, 22 Oct 2024 16:52:16 -0700
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
Message-ID: <Zxg6sCJAUDUsaVBM@google.com>
References: <20241011021403.4089793-1-howardchu95@gmail.com>
 <Zw61TUe1V97dKWer@google.com>
 <Zw7D9HXBanPLUO4G@x1>
 <Zw7JgJc0LOwSpuvx@x1>
 <Zw7SkmEaz730uVbL@x1>
 <Zw8fqyCZNqSABMkM@google.com>
 <Zw_MFwkejeWC2qbv@x1>
 <ZxfbNJ6nKXzoEYVn@google.com>
 <Zxfv3BupKqhi3zGV@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zxfv3BupKqhi3zGV@x1>

On Tue, Oct 22, 2024 at 03:33:00PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Oct 22, 2024 at 10:04:52AM -0700, Namhyung Kim wrote:
> > Hi Arnaldo,
> > 
> > On Wed, Oct 16, 2024 at 11:22:15AM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Tue, Oct 15, 2024 at 07:06:35PM -0700, Namhyung Kim wrote:
> > > > Hi Arnaldo,
> > > > 
> > > > On Tue, Oct 15, 2024 at 05:37:38PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > On Tue, Oct 15, 2024 at 04:58:56PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > > So I'm trying adding extra bounds checking, marking the index as
> > > > > > volatile, adding compiler barriers, etc, all the fun with the verifier,
> > > > > > but got distracted with other stuff, coming back to this now.
> > > > >  
> > > > > > Ok, the following seems to do the trick:
> > > > >  
> > > > > > [acme@dell-per740-01 perf-tools]$ git diff
> > > > > > diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > > > > > index 3b30aa74a3ae..ef87a04ff8d0 100644
> > > > > > --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > > > > > +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > > > > > @@ -486,6 +486,7 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
> > > > > >                                 augmented = true;
> > > > > >                 } else if (size < 0 && size >= -6) { /* buffer */
> > > > > >                         index = -(size + 1);
> > > > > > +                       index &= 7; // To satisfy the bounds checking with the verifier in some kernels
> > > > > >                         aug_size = args->args[index];
> > > > > >  
> > > > > >                         if (aug_size > TRACE_AUG_MAX_BUF)
> > > > > > 
> > > > > > I'll now test it without Howard's patch to see if it fixes the RHEL8 +
> > > > > > clang 17 case.
> > > > > 
> > > > > It works with this one-liner + the simplified patch from Howard and also
> > > > > on this other system (RHEL9), as well as with Fedora 40, it would be
> > > > > nice if someone could test with clang 16 and report back the version of
> > > > > the kernel tested as well as the distro name/release, that way I can try
> > > > > to get my hands on such as system and test there as well.
> > > > > 
> > > > > Its all at:
> > > > > 
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tmp.perf-tools
> > > > > 
> > > > > This is the current set of patches that when further tested will go to
> > > > > Linus for v6.12:
> > > > > 
> > > > > ⬢[acme@toolbox perf-tools]$ git log --oneline torvalds/master..
> > > > > ff14baa7a290bf42 (HEAD -> perf-tools, x1/perf-tools, perf-tools/tmp.perf-tools) perf trace augmented_raw_syscalls: Add more checks to pass the verifier
> > > > > 46180bec048aad85 perf trace augmented_raw_syscalls: Add extra array index bounds checking to satisfy some BPF verifiers
> > > > > 45d1aadac64869a2 perf build: Change the clang check back to 12.0.1
> > > > 
> > > > Wouldn't it be better to have this change after fixing the verifier
> > > > issues in the later commits?
> > > 
> > > I'm still testing it, this is a one-liner, so I think that the order in
> > > which the patches are applied isn't important. Also Howard's patch (the
> > > simplified one) doesn't clash with it.
> > 
> > I'm afraid if it'd break git bisect by allowing old clang versions
> > before the fix.
> 
> I can reorder the patches if you think it is interesting, but from the
> extended set of tests I'm performing on different kernel and clang
> version and in x86_64 and arm 64-bit, 32-bit and various distros, I'm
> not sure bisection is an option for BPF programs at this stage 8-)

Maybe.  But at least we can try our best. :)

> 
> There, did it now it looks like this:
> 
> ⬢ [acme@toolbox perf-tools]$ git log --oneline torvalds/master..
> 5d3a1b9ca3b1a059 (HEAD -> perf-tools) perf trace arm32: Fix iteration of syscall ids in syscalltbl->entries
> 34d2358a24fb5963 perf trace augmented_raw_syscalls: Add more checks to pass the verifier
> cdb84c31bd2813de perf trace augmented_raw_syscalls: Add extra array index bounds checking to satisfy some BPF verifiers
> e5c1811c590c4312 perf build: Change the clang check back to 12.0.1
> 39c6a356201ebbd7 perf trace: The return from 'write' isn't a pid
> ab8aaab874c4aa37 tools headers UAPI: Sync linux/const.h with the kernel headers
> ⬢ [acme@toolbox perf-tools]$
> 
> Is that what you meant?

Nope, I'd like to have e5c1811c590c4312 after the verifier fixes:

 34d2358a24fb5963 perf trace augmented_raw_syscalls: Add more checks to pass the verifier
 cdb84c31bd2813de perf trace augmented_raw_syscalls: Add extra array index bounds checking to satisfy some BPF verifiers

Thanks,
Namhyung

