Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF43143736;
	Wed, 16 Oct 2024 02:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729044397; cv=none; b=eowrluVFu3JFQGlFoWLOactEg8AA55PjgIF9Ds7VJwPXaMem4nZ+59Qdqbch3sPSrp+Nov1cw/1a2Me8A7DT7I3H9/VcO1NquX0T0PFqhkxHhl1niR0XuMCB65TDAaCpekaIqBETUqY8hlGyzOa/eY+IKaVq2aGLrwK3JD2hQUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729044397; c=relaxed/simple;
	bh=aEa7/Y7h65bZMBSJIpYtv9760VAAbwP31QCb01yRdjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDTXAHZF7yEk1sLdmXL32KK1wzZMBIgLdECWirLWFO7tb2cqF4Cxe3Oaryew2EkVEnx2o0ugy449EHDHEXCtwUxD7osmyfHv2A1wJSK3VrBrAJ2ArYCaoj8xoHOpfXMQiPpH0EeAx7/XMeMYC/k0X7Ksqpws4ZRfOZcl3SoNZTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lu4jIqXj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lu4jIqXj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE6AC4CEC6;
	Wed, 16 Oct 2024 02:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729044397;
	bh=aEa7/Y7h65bZMBSJIpYtv9760VAAbwP31QCb01yRdjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lu4jIqXjVEcCPIl2hjDQQEc5SArSAbBioZHYouw2ydTQQ2+rSyBxG+gk9YvGr3aBx
	 1xCvbS4Nw8pUQpee+Kk//aYv1tPsY6hDCmthQS+B1b/l7ukbZDY7iqu9jjasFxhcfb
	 gmdEOnUm7IQUq714miBEC4JBIjOVKUZsFNlgWiSyjd4r1719q85xXcxV2Wy9mOagFb
	 4jn4x77/J8htcZHkz4AJxbzZgAQ8kFnfiIAjm17IR2DX6RN/FD5Bjzu/kgFfUJlW13
	 DWem1taJVt7iANN+7yEaUTD53n0sT6RNh+KT0yOPZDZjiXiH/zkyTuRxM59bwvFAFe
	 +CL8ZpCUda2aQ==
Date: Tue, 15 Oct 2024 19:06:35 -0700
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
Message-ID: <Zw8fqyCZNqSABMkM@google.com>
References: <20241011021403.4089793-1-howardchu95@gmail.com>
 <Zw61TUe1V97dKWer@google.com>
 <Zw7D9HXBanPLUO4G@x1>
 <Zw7JgJc0LOwSpuvx@x1>
 <Zw7SkmEaz730uVbL@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zw7SkmEaz730uVbL@x1>

Hi Arnaldo,

On Tue, Oct 15, 2024 at 05:37:38PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Oct 15, 2024 at 04:58:56PM -0300, Arnaldo Carvalho de Melo wrote:
> > So I'm trying adding extra bounds checking, marking the index as
> > volatile, adding compiler barriers, etc, all the fun with the verifier,
> > but got distracted with other stuff, coming back to this now.
>  
> > Ok, the following seems to do the trick:
>  
> > [acme@dell-per740-01 perf-tools]$ git diff
> > diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > index 3b30aa74a3ae..ef87a04ff8d0 100644
> > --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > @@ -486,6 +486,7 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
> >                                 augmented = true;
> >                 } else if (size < 0 && size >= -6) { /* buffer */
> >                         index = -(size + 1);
> > +                       index &= 7; // To satisfy the bounds checking with the verifier in some kernels
> >                         aug_size = args->args[index];
> >  
> >                         if (aug_size > TRACE_AUG_MAX_BUF)
> > 
> > I'll now test it without Howard's patch to see if it fixes the RHEL8 +
> > clang 17 case.
> 
> It works with this one-liner + the simplified patch from Howard and also
> on this other system (RHEL9), as well as with Fedora 40, it would be
> nice if someone could test with clang 16 and report back the version of
> the kernel tested as well as the distro name/release, that way I can try
> to get my hands on such as system and test there as well.
> 
> Its all at:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tmp.perf-tools
> 
> This is the current set of patches that when further tested will go to
> Linus for v6.12:
> 
> ⬢[acme@toolbox perf-tools]$ git log --oneline torvalds/master..
> ff14baa7a290bf42 (HEAD -> perf-tools, x1/perf-tools, perf-tools/tmp.perf-tools) perf trace augmented_raw_syscalls: Add more checks to pass the verifier
> 46180bec048aad85 perf trace augmented_raw_syscalls: Add extra array index bounds checking to satisfy some BPF verifiers
> 45d1aadac64869a2 perf build: Change the clang check back to 12.0.1

Wouldn't it be better to have this change after fixing the verifier
issues in the later commits?

> 4e21679eb81b5f0d perf trace: The return from 'write' isn't a pid
> 2d2314d4b09b5ed9 tools headers UAPI: Sync linux/const.h with the kernel headers
> ⬢[acme@toolbox perf-tools]$

I guess you also need the syscalltbl fix from Jiri Slaby.

https://lore.kernel.org/linux-perf-users/3a592835-a14f-40be-8961-c0cee7720a94@kernel.org/

Thanks,
Namhyung

> 
> [root@nine ~]# uname -a
> Linux nine 5.14.0-427.31.1.el9_4.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Aug 9 14:06:03 EDT 2024 x86_64 x86_64 x86_64 GNU/Linux
> [root@nine ~]# perf trace -e *sleep* sleep 1.234567890
>      0.000 (1234.742 ms): sleep/80014 clock_nanosleep(rqtp: 0x7ffc55b11240, rmtp: 0x7ffc55b11230)           = 0
> [root@nine ~]# clang --version
> clang version 17.0.6 (Red Hat, Inc. 17.0.6-5.el9)
> Target: x86_64-redhat-linux-gnu
> Thread model: posix
> InstalledDir: /usr/bin
> [root@nine ~]#
> 
> - Arnaldo
