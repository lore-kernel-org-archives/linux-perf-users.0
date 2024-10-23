Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C6F17DE16;
	Wed, 23 Oct 2024 21:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729720641; cv=none; b=JyBz0srcGt4LyUDrh7pRZmsQLIb4mLKoE1czhG8Ey6M0M09kF2X54IGCdE6D1PUp2PJubs+iS+i05Ij0r9u26o0PvTa2c5rhqZGsa/5IfHXAD1q8rB6HCWWFNsQ37knxQeiGO5pv52DDgx+IP4fzVzwqmwYko1YobmjQMImGBXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729720641; c=relaxed/simple;
	bh=RG0bGMbyOGkTEX0rTcKK//agJ+NrEKekSWU6CWmm7JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hf0Q4A81WyN8n1bYlv+cbCpadyEV4+62VoPkizn5SK2UUA8dM4GcM3UFPqr5qpyCpeSl/pJ9Z32MgN1F/y+eu+kYGId9TDIXYkZsNJ0QUxlmKrQX/5XwggiJOZEZ0hfAZAhIsNeN6vRlMsQH5pZp6F4gn/RJIvSyBOkjG+1+5J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFZWZRb4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFZWZRb4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D522DC4CEE6;
	Wed, 23 Oct 2024 21:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729720641;
	bh=RG0bGMbyOGkTEX0rTcKK//agJ+NrEKekSWU6CWmm7JQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HFZWZRb4SbgQaPf1epDqKrwSww9SGMxssOghFj5Wv8eaH9ZgudCbcH3xjm4qpGObX
	 hbEkmWbwWB9ftmRzj6/14jVB/XxpTmy3fs+b1/nDT0Mia05f+HXm0bFojXAJiymFFn
	 ZDMxoV3TAIc4q6Y52M+COeyNY7/y7vFHZ4/Jkwqs+xf+fXL2X11alxKgcxP7i5+Axv
	 bCydBfU1BT9qgWadhWxtU3DRVrBNgDSIeqtSGKwK9lDregaYo9DnrtrWofbW0+TmiG
	 E15RTb6ikqH+3HWvTCbmubxcMT5p0/99yALKvyBKz7r4TQOg3ljhBeUbyhM1rAtaKC
	 90B5t5geKqCCQ==
Date: Wed, 23 Oct 2024 14:57:19 -0700
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
Message-ID: <ZxlxP2otBeW3OYrc@google.com>
References: <Zw61TUe1V97dKWer@google.com>
 <Zw7D9HXBanPLUO4G@x1>
 <Zw7JgJc0LOwSpuvx@x1>
 <Zw7SkmEaz730uVbL@x1>
 <Zw8fqyCZNqSABMkM@google.com>
 <Zw_MFwkejeWC2qbv@x1>
 <ZxfbNJ6nKXzoEYVn@google.com>
 <Zxfv3BupKqhi3zGV@x1>
 <Zxg6sCJAUDUsaVBM@google.com>
 <ZxkKnIaz6QaIC4VN@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxkKnIaz6QaIC4VN@x1>

On Wed, Oct 23, 2024 at 11:39:24AM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Oct 22, 2024 at 04:52:16PM -0700, Namhyung Kim wrote:
> > On Tue, Oct 22, 2024 at 03:33:00PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Tue, Oct 22, 2024 at 10:04:52AM -0700, Namhyung Kim wrote:
> > > > On Wed, Oct 16, 2024 at 11:22:15AM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > On Tue, Oct 15, 2024 at 07:06:35PM -0700, Namhyung Kim wrote:
> > > > > > On Tue, Oct 15, 2024 at 05:37:38PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > > > On Tue, Oct 15, 2024 at 04:58:56PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > > > Its all at:
> 
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tmp.perf-tools
> 
> > > > > > > This is the current set of patches that when further tested will go to
> > > > > > > Linus for v6.12:
> 
> > > > > > > ⬢[acme@toolbox perf-tools]$ git log --oneline torvalds/master..
> > > > > > > ff14baa7a290bf42 (HEAD -> perf-tools, x1/perf-tools, perf-tools/tmp.perf-tools) perf trace augmented_raw_syscalls: Add more checks to pass the verifier
> > > > > > > 46180bec048aad85 perf trace augmented_raw_syscalls: Add extra array index bounds checking to satisfy some BPF verifiers
> > > > > > > 45d1aadac64869a2 perf build: Change the clang check back to 12.0.1
> 
> > > > > > Wouldn't it be better to have this change after fixing the verifier
> > > > > > issues in the later commits?
> 
> > > > > I'm still testing it, this is a one-liner, so I think that the order in
> > > > > which the patches are applied isn't important. Also Howard's patch (the
> > > > > simplified one) doesn't clash with it.
> 
> > > > I'm afraid if it'd break git bisect by allowing old clang versions
> > > > before the fix.
> 
> > > I can reorder the patches if you think it is interesting, but from the
> > > extended set of tests I'm performing on different kernel and clang
> > > version and in x86_64 and arm 64-bit, 32-bit and various distros, I'm
> > > not sure bisection is an option for BPF programs at this stage 8-)
> 
> > Maybe.  But at least we can try our best. :)
> 
> That rhel8 verifier case was with clang 17 even, but whatever, see below
> :-)
> 
> > > There, did it now it looks like this:
> > > 
> > > ⬢ [acme@toolbox perf-tools]$ git log --oneline torvalds/master..
> > > 5d3a1b9ca3b1a059 (HEAD -> perf-tools) perf trace arm32: Fix iteration of syscall ids in syscalltbl->entries
> > > 34d2358a24fb5963 perf trace augmented_raw_syscalls: Add more checks to pass the verifier
> > > cdb84c31bd2813de perf trace augmented_raw_syscalls: Add extra array index bounds checking to satisfy some BPF verifiers
> > > e5c1811c590c4312 perf build: Change the clang check back to 12.0.1
> > > 39c6a356201ebbd7 perf trace: The return from 'write' isn't a pid
> > > ab8aaab874c4aa37 tools headers UAPI: Sync linux/const.h with the kernel headers
> > > ⬢ [acme@toolbox perf-tools]$
> 
> > > Is that what you meant?
>  
> > Nope, I'd like to have e5c1811c590c4312 after the verifier fixes:
>  
> >  34d2358a24fb5963 perf trace augmented_raw_syscalls: Add more checks to pass the verifier
> >  cdb84c31bd2813de perf trace augmented_raw_syscalls: Add extra array index bounds checking to satisfy some BPF verifiers
> 
> Done:
> 
> ⬢ [acme@toolbox perf-tools]$ git log --oneline torvalds/master..
> d822ca29a4fc5278 (HEAD -> perf-tools) tools headers UAPI: Sync kvm headers with the kernel sources
> 5d35634ecc2d2c39 perf trace: Fix non-listed archs in the syscalltbl routines
> 7fbff3c0e085745b perf build: Change the clang check back to 12.0.1
> 395d38419f1853de perf trace augmented_raw_syscalls: Add more checks to pass the verifier
> ecabac70ff919580 perf trace augmented_raw_syscalls: Add extra array index bounds checking to satisfy some BPF verifiers
> 39c6a356201ebbd7 perf trace: The return from 'write' isn't a pid
> ab8aaab874c4aa37 tools headers UAPI: Sync linux/const.h with the kernel headers
> ⬢ [acme@toolbox perf-tools]$

Thanks!
Namhyung

