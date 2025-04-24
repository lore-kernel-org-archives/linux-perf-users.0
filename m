Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA2C1FC0EA;
	Thu, 24 Apr 2025 18:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745519086; cv=none; b=pX83OVnhCgF7XDL+DYVtyvXfxt95kk8vhc/xbwA1cg26J76wR4MTDxgO5U8kGVsBl88qmJzqItjDM8BjYDtUrdmB2xcOiPUpe4SfHLf9aiSrFwm2zRkiSTtRZpl/giAuenw2E4L3cWMaetlArtwyOhsWRGxckp4X66Dchqge6SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745519086; c=relaxed/simple;
	bh=hyzkbqm4sOKiWO4qVvYP5wrpHM6flBsX96BDqcDu9ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rILKfQc8TeICpv7KW9ynVXVkCdmtXu+bz4v/KPoevdPX+T4QL540A4weAnVi7ZNkpupr5Y73CB9u2FKfgwvfYnJpUw00wv6Awc/vlFzhci2X4rvkyi4RA1Wz8X4HZL6T+UmixVgdc69fH95PN2foATGxe23xa6bkYEzNL23vKJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7+l4knV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7+l4knV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A468C4CEE4;
	Thu, 24 Apr 2025 18:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745519085;
	bh=hyzkbqm4sOKiWO4qVvYP5wrpHM6flBsX96BDqcDu9ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O7+l4knVZMuO5EKllmReVAf/jHDAe92qQlKUZj6hshrvM89nnakdcdprqxxxKoGhu
	 4nU7c46nLBxkPen96L6zsh0tYzm4EOc76pxDKZ6c62HbXzExa+Jauly2dn2hvjsvaq
	 Xt9vqqCR98yzX5qT5uyfOqIEs4DlDVHndlkHNoq6cUjUQkn8aIHbQ+4Uk6Bo7vfAe4
	 TP9DClPCOVthqnQq3wUnI/EIiyfgZbFqFqXQw8AzdtsNtRC4mZo6J/ZAi8syh4P1Ro
	 c60Vknckkyh7josYX/29ckOfvE/ClBtEGeMuMPpbskjsrnN+QVljsbDJtdFCs3NuDe
	 UBpTvfi0BDRsA==
Date: Thu, 24 Apr 2025 15:24:42 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>, jolsa@kernel.org,
	adrian.hunter@intel.com, irogers@google.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com, disgoel@linux.vnet.ibm.com,
	hbathini@linux.vnet.ibm.com, Aditya.Bodkhe1@ibm.com,
	jiang.peng9@zte.com.cn, Tejas.Manhas1@ibm.com,
	sshegde@linux.ibm.com, sfr@canb.auug.org.au,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	ravi.bangoria@amd.com, bp@alien8.de
Subject: Re: [PATCH] perf build: Add tools/arch/x86/include/asm/amd/ibs.h to
 sync the headers
Message-ID: <aAqB6kI5mDp4bxY9@x1>
References: <20250424163033.6601-1-atrajeev@linux.ibm.com>
 <16bee348-2b41-4337-85c8-8a6d2719e99b@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16bee348-2b41-4337-85c8-8a6d2719e99b@linux.ibm.com>

On Thu, Apr 24, 2025 at 10:39:56PM +0530, Venkat Rao Bagalkote wrote:
> On 24/04/25 10:00 pm, Athira Rajeev wrote:
> Tested this patch by applying on tip HEAD:
> 7ab869c799fc0fb22f9b4c2f36aaa603d9c7cc9d and it fixes the reported issue.

This is just a long list of characters, can you please next time provide
something like, humm, tip/head, not really:

⬢ [acme@toolbx perf-tools-next]$ git remote -v | grep tip
tip	https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git (fetch)
tip	https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git (push)
⬢ [acme@toolbx perf-tools-next]$ git remote update tip 
Fetching tip
⬢ [acme@toolbx perf-tools-next]$ git show 7ab869c799fc0fb22f9b4c2f36aaa603d9c7cc9d
fatal: bad object 7ab869c799fc0fb22f9b4c2f36aaa603d9c7cc9d
⬢ [acme@toolbx perf-tools-next]$

So please add the summary, that way we can try to figure out if this is
a rebase and they look for the description instead of this sha1 that I'm
not finding even after doing a 'git remore update tip'.
 
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Thanks,

- Arnaldo
