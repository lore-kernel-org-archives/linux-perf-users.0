Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247CB17C98;
	Tue, 22 Oct 2024 18:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729621986; cv=none; b=rmAAHF73Wc8W0ECpgqjiCr1PHX4QqSpaQMo57JBm17rT9KX5NAV0TjMhieZlWSZjQFIvDCMPlpspm4m3M8f1+ePt3zbIwiqon++NNUQsLgOpXw+WQClKLcqueMz5DQlFrt6HG0w7CHM78ET1sN7sI4ZbcgNqDfyGzRKXbehmaOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729621986; c=relaxed/simple;
	bh=24yn3OFS2AZsp+QNzelAVzSZ8vU4Vf1mostOE7lH+eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+ZiOd8o5yibG95f/k8W6PgREDKj+xtQupVuRuN7AUR6c0xyiCE0jJvsRngMnDRkBANYRGJRhADwqAJu1fcbV0cVhAVF4cNQIyeAtYIPmIqPoy1VnqIrVMU1QVPKoL7UTWohK98VwqvmvDY7rIZ4q+KUi+g3BYcJ1YFtKVg6dnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uIY8ekuB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uIY8ekuB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3E0C4CEC3;
	Tue, 22 Oct 2024 18:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729621986;
	bh=24yn3OFS2AZsp+QNzelAVzSZ8vU4Vf1mostOE7lH+eM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uIY8ekuBu6EGpDByeacwBvKaIs+/IfvWXCPWtLCmSX+6np6LqmsOvkjL23NcPFnOz
	 NB6btTGM0gJI9D5w84sqroMhRqrAqo4jIrqzkddhQuTzTL5gHhHhzqKMlVND+GFxKc
	 pCOA2dnIWNULlciSdDahpz7nU9cdwsPDs5cKdfekiQ8QxfqQBWpsgBjplbk58Cfp+L
	 yup+QcY4G3Wq7BgLg0wJbARfw4QJCbiKc7eIVX0794Ro7zoNsZDhV+vjmN0A7pWqt+
	 xxWDVzAngod994Gh0F3vzExRT+m5F5Qh+oJ66PQmLhcqH22w7JrQZPMyw1sHiDO4ht
	 YlCR/jazJceEw==
Date: Tue, 22 Oct 2024 15:33:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
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
Message-ID: <Zxfv3BupKqhi3zGV@x1>
References: <20241011021403.4089793-1-howardchu95@gmail.com>
 <Zw61TUe1V97dKWer@google.com>
 <Zw7D9HXBanPLUO4G@x1>
 <Zw7JgJc0LOwSpuvx@x1>
 <Zw7SkmEaz730uVbL@x1>
 <Zw8fqyCZNqSABMkM@google.com>
 <Zw_MFwkejeWC2qbv@x1>
 <ZxfbNJ6nKXzoEYVn@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxfbNJ6nKXzoEYVn@google.com>

On Tue, Oct 22, 2024 at 10:04:52AM -0700, Namhyung Kim wrote:
> Hi Arnaldo,
> 
> On Wed, Oct 16, 2024 at 11:22:15AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Oct 15, 2024 at 07:06:35PM -0700, Namhyung Kim wrote:
> > > Hi Arnaldo,
> > > 
> > > On Tue, Oct 15, 2024 at 05:37:38PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > On Tue, Oct 15, 2024 at 04:58:56PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > So I'm trying adding extra bounds checking, marking the index as
> > > > > volatile, adding compiler barriers, etc, all the fun with the verifier,
> > > > > but got distracted with other stuff, coming back to this now.
> > > >  
> > > > > Ok, the following seems to do the trick:
> > > >  
> > > > > [acme@dell-per740-01 perf-tools]$ git diff
> > > > > diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > > > > index 3b30aa74a3ae..ef87a04ff8d0 100644
> > > > > --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > > > > +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > > > > @@ -486,6 +486,7 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
> > > > >                                 augmented = true;
> > > > >                 } else if (size < 0 && size >= -6) { /* buffer */
> > > > >                         index = -(size + 1);
> > > > > +                       index &= 7; // To satisfy the bounds checking with the verifier in some kernels
> > > > >                         aug_size = args->args[index];
> > > > >  
> > > > >                         if (aug_size > TRACE_AUG_MAX_BUF)
> > > > > 
> > > > > I'll now test it without Howard's patch to see if it fixes the RHEL8 +
> > > > > clang 17 case.
> > > > 
> > > > It works with this one-liner + the simplified patch from Howard and also
> > > > on this other system (RHEL9), as well as with Fedora 40, it would be
> > > > nice if someone could test with clang 16 and report back the version of
> > > > the kernel tested as well as the distro name/release, that way I can try
> > > > to get my hands on such as system and test there as well.
> > > > 
> > > > Its all at:
> > > > 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tmp.perf-tools
> > > > 
> > > > This is the current set of patches that when further tested will go to
> > > > Linus for v6.12:
> > > > 
> > > > ⬢[acme@toolbox perf-tools]$ git log --oneline torvalds/master..
> > > > ff14baa7a290bf42 (HEAD -> perf-tools, x1/perf-tools, perf-tools/tmp.perf-tools) perf trace augmented_raw_syscalls: Add more checks to pass the verifier
> > > > 46180bec048aad85 perf trace augmented_raw_syscalls: Add extra array index bounds checking to satisfy some BPF verifiers
> > > > 45d1aadac64869a2 perf build: Change the clang check back to 12.0.1
> > > 
> > > Wouldn't it be better to have this change after fixing the verifier
> > > issues in the later commits?
> > 
> > I'm still testing it, this is a one-liner, so I think that the order in
> > which the patches are applied isn't important. Also Howard's patch (the
> > simplified one) doesn't clash with it.
> 
> I'm afraid if it'd break git bisect by allowing old clang versions
> before the fix.

I can reorder the patches if you think it is interesting, but from the
extended set of tests I'm performing on different kernel and clang
version and in x86_64 and arm 64-bit, 32-bit and various distros, I'm
not sure bisection is an option for BPF programs at this stage 8-)

There, did it now it looks like this:

⬢ [acme@toolbox perf-tools]$ git log --oneline torvalds/master..
5d3a1b9ca3b1a059 (HEAD -> perf-tools) perf trace arm32: Fix iteration of syscall ids in syscalltbl->entries
34d2358a24fb5963 perf trace augmented_raw_syscalls: Add more checks to pass the verifier
cdb84c31bd2813de perf trace augmented_raw_syscalls: Add extra array index bounds checking to satisfy some BPF verifiers
e5c1811c590c4312 perf build: Change the clang check back to 12.0.1
39c6a356201ebbd7 perf trace: The return from 'write' isn't a pid
ab8aaab874c4aa37 tools headers UAPI: Sync linux/const.h with the kernel headers
⬢ [acme@toolbox perf-tools]$

Is that what you meant?

Thanks,

- Arnaldo
