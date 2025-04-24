Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EC31F583A;
	Thu, 24 Apr 2025 20:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745528087; cv=none; b=R/C2J9/tgxM9ny2yBKPqwfRbsm5/hCmV09XsZEIrQ9NNyGLi7dlbvjLbTrVyyCq4uvef5cXVZHkwyHNoUmelvkMzWtZoGdzfmZ4v1u5Yi1xa6oiX340ZZYWklT54tjVj/JcjjXJRICQNkwnTOi8N8EXP9nTtlI68mvghH+QEXSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745528087; c=relaxed/simple;
	bh=mVOfzXORKBDjoat8v4wa6t+Bp56lm/uF2PtECtlz2aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhDivQYA8O9DWQkQD09tkQi73UDXkS4LUNXIACZr6vSG8aATmZcGpBSAEnaqaR/gC5/oAunlB5F+eq8yoECBBRJw5JFO2cQFlzUhcYOwKOpZX7nDhkNkCj9App9ikK9Rnf8ILZdd0XFuxlZQS1OGBSSwwhZyQJSYWyKTHxjWM1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAXBLzck; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAXBLzck"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8422C4CEE3;
	Thu, 24 Apr 2025 20:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745528086;
	bh=mVOfzXORKBDjoat8v4wa6t+Bp56lm/uF2PtECtlz2aI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KAXBLzck3/aY5i5WpDgpNe0S9MVRUvjwzdE5yg8eNsLLNEK9tVLDif8ovhlckrhRu
	 I6hmjTI983hXSAjzp56+fJPfV7sKApqcjVianVGbQflRikuhyPzh6hfEGQUQ/QL1/m
	 1jqNgRIlqnE25Vz4LRIyLPw6K7W2vjuRrKhJ6hYdOsVGf2i4rc89kCxSW4vXndPHcI
	 CEy8vJG1mq2aqaww20AkWpaUBG7LKORGO03u5i4atVHr5DqEydxxT7iFF2/BGOHnCg
	 E4NuOs0FXHsZS68l+Mmp2qEt2iejnyPVg+tXiFhLkXiTrggF9G4lZaLgV7C6GN7fdA
	 xc9E8UJP1Op7A==
Date: Thu, 24 Apr 2025 13:54:44 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
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
Message-ID: <aAqlFA4qIVh9SQke@google.com>
References: <20250424163033.6601-1-atrajeev@linux.ibm.com>
 <16bee348-2b41-4337-85c8-8a6d2719e99b@linux.ibm.com>
 <aAqB6kI5mDp4bxY9@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aAqB6kI5mDp4bxY9@x1>

Hello,

On Thu, Apr 24, 2025 at 03:24:42PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Apr 24, 2025 at 10:39:56PM +0530, Venkat Rao Bagalkote wrote:
> > On 24/04/25 10:00 pm, Athira Rajeev wrote:
> > Tested this patch by applying on tip HEAD:
> > 7ab869c799fc0fb22f9b4c2f36aaa603d9c7cc9d and it fixes the reported issue.
> 
> This is just a long list of characters, can you please next time provide
> something like, humm, tip/head, not really:
> 
> ⬢ [acme@toolbx perf-tools-next]$ git remote -v | grep tip
> tip	https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git (fetch)
> tip	https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git (push)
> ⬢ [acme@toolbx perf-tools-next]$ git remote update tip 
> Fetching tip
> ⬢ [acme@toolbx perf-tools-next]$ git show 7ab869c799fc0fb22f9b4c2f36aaa603d9c7cc9d
> fatal: bad object 7ab869c799fc0fb22f9b4c2f36aaa603d9c7cc9d
> ⬢ [acme@toolbx perf-tools-next]$
> 
> So please add the summary, that way we can try to figure out if this is
> a rebase and they look for the description instead of this sha1 that I'm
> not finding even after doing a 'git remore update tip'.

Does this mean the kernel change broke the tool build but we don't have
it in the perf-tools-next yet?  Then probably we need to wait for the
next merge window to fix it in the tool side, no?

Thanks,
Namhyung

