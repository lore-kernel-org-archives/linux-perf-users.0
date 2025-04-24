Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DBB13213E;
	Thu, 24 Apr 2025 21:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745531261; cv=none; b=lrZB3PhVzVQCBWaUTxFAOV/V/5nhBnbPFME5DXidjCd4e791nVyFY6mFl5rUFjm7Jxr7Nk6LJ1AAEhUyOTKUDBrqfcy5ioRG0ERE7Fiju53pC7FbZTIV0ocbBatA+qUTv9gSFPDleQDfWuKgEJXqhTtZVc8XfjbNIL4VHcbGjIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745531261; c=relaxed/simple;
	bh=/OtnegXrAUInM02RmbInPRK5cQX2lIlEaqMGbFsc8QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKufhDUCTI7cSscXIyq2w1wtYNyF0d3557hmSpNRfTW8FRqB6+Zjsws2D6oDhDLN/8xrk/fPLsH+iqOcTBAklT4/NuXNZps23RN3w2duoGgqcexO4eVPXaTq/QfIdNjH46lONjAxnWfKH11sxwE5exL40kvVChUw8SShwiJfTd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPjpiAWL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPjpiAWL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3F3C4CEE3;
	Thu, 24 Apr 2025 21:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745531261;
	bh=/OtnegXrAUInM02RmbInPRK5cQX2lIlEaqMGbFsc8QM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fPjpiAWLJmklUim0524Dr+JbFiUZKVwGNoM5kezTioyx52Vghb/vbv+KGIHIPzEkG
	 u/it2sj5HQROCzqtKddufFAgZSvSFG9wSZsduDTUZ4flK/bU0a7St+TqmkUcie+hha
	 a6lgHMMewgovod6o1l4SJlzPJBZ26MIkug21EtvrO0v9r4tW88HRD0VfsYIREPppsd
	 WwYReglf3megpF/2IH7eSGSE0jFDUdL8yQxNgZWHuakH53/dMcYMo9hTXH2q5i6PGm
	 sZy5DTDGYDwJMh4+jAv67EV5uaQ53eC28p2DyfXyrPsdGxpaki7xAhnddctiPzN+wJ
	 LxjujzSFVvjew==
Date: Thu, 24 Apr 2025 18:47:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>, jolsa@kernel.org,
	adrian.hunter@intel.com, irogers@google.com,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com, disgoel@linux.vnet.ibm.com,
	hbathini@linux.vnet.ibm.com, Aditya.Bodkhe1@ibm.com,
	jiang.peng9@zte.com.cn, Tejas.Manhas1@ibm.com,
	sshegde@linux.ibm.com, sfr@canb.auug.org.au,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	ravi.bangoria@amd.com, bp@alien8.de
Subject: Re: [PATCH] perf build: Add tools/arch/x86/include/asm/amd/ibs.h to
 sync the headers
Message-ID: <aAqxei2pAfDbmiTy@x1>
References: <20250424163033.6601-1-atrajeev@linux.ibm.com>
 <16bee348-2b41-4337-85c8-8a6d2719e99b@linux.ibm.com>
 <aAqB6kI5mDp4bxY9@x1>
 <aAqlFA4qIVh9SQke@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aAqlFA4qIVh9SQke@google.com>

On Thu, Apr 24, 2025 at 01:54:44PM -0700, Namhyung Kim wrote:
> > On Thu, Apr 24, 2025 at 10:39:56PM +0530, Venkat Rao Bagalkote wrote:
> > > On 24/04/25 10:00 pm, Athira Rajeev wrote:
> > > Tested this patch by applying on tip HEAD:
> > > 7ab869c799fc0fb22f9b4c2f36aaa603d9c7cc9d and it fixes the reported issue.

> > This is just a long list of characters, can you please next time provide
> > something like, humm, tip/head, not really:
> 
> > ⬢ [acme@toolbx perf-tools-next]$ git remote -v | grep tip
> > tip	https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git (fetch)
> > tip	https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git (push)
> > ⬢ [acme@toolbx perf-tools-next]$ git remote update tip 
> > Fetching tip
> > ⬢ [acme@toolbx perf-tools-next]$ git show 7ab869c799fc0fb22f9b4c2f36aaa603d9c7cc9d
> > fatal: bad object 7ab869c799fc0fb22f9b4c2f36aaa603d9c7cc9d
> > ⬢ [acme@toolbx perf-tools-next]$

> > So please add the summary, that way we can try to figure out if this is
> > a rebase and they look for the description instead of this sha1 that I'm
> > not finding even after doing a 'git remore update tip'.

> Does this mean the kernel change broke the tool build but we don't have
> it in the perf-tools-next yet?  Then probably we need to wait for the
> next merge window to fix it in the tool side, no?

I'm not noticing this with perf-tools-next on a 9950x3d fedora:42 and
the referenced commit is not present in it nor in upstream nor in tip
master, so I need the reporter to check his environment and report back.

- Arnaldo
