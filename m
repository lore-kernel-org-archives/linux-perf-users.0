Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861E2204F88;
	Tue,  4 Feb 2025 19:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698173; cv=none; b=QFDGIPPl49eOcB4Krdyx6d81JqxwoGbbGhe5KfD9d3RdvqXqiaU90ICSIIRPlJvCzcngAbgXXFmTcPf5pH25qxQaNFUaqnoShjNRshyhAWN0ZJ3x1lYKNJHkArTJeq0jHm+ilfMV97iUT+3OForKb3QGWItp6kWwSKirZQIGx/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698173; c=relaxed/simple;
	bh=A6jtiOeZFDOHNw4UoAyBrWoEdEYdp9RqNkRZDUrK2Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKwPEDcupjlgChHVrrsY6ouX44/A3iw5/sXsGbmRezk3+37xjMpkVwNmBjTxq24kH3e8VFWjFISqT2YsBlWGoevrbzJvCh1PnoHHXuFgihQSafxF2aHiMA1v6UQkzVxGf8H//7WnMHMn/7nrAhxMW1jREUAxbhftK5CYeY6CZAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9jHLNxb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9jHLNxb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9C4C4CEDF;
	Tue,  4 Feb 2025 19:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738698172;
	bh=A6jtiOeZFDOHNw4UoAyBrWoEdEYdp9RqNkRZDUrK2Ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F9jHLNxbjgGgn0a3+A7tpkwO4vpbqr1rT9ghKhx+ZjW0ra3r66AkfWkI/JK6PJ0jj
	 zrtxZ9S5ch8mtufxlMFvSYXtZ+aStoFcisXflAhFv/KEzm53Crb7mp3spbPMtaOePP
	 kefPIZGxfNMVml4k6mLmpjN3LHZNFd3gBsR3dslVYDZB5nbLZlxfvtsymCmIxwGn5T
	 LgMz+kHwTW20hH1SyfTi4HwyvowmpBRq1vP3EY15bah9NvQoozLVoVwS4FK1fkulgu
	 GctlDDCU6UsL/D7A74BoGmYMIdjxI2NMlKcnJJLKerD08KhI2gjz+zyf99OFRxTI+c
	 huJmmbL6h2wRA==
Date: Tue, 4 Feb 2025 11:42:50 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Weinan Liu <wnliu@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, andrii.nakryiko@gmail.com,
	broonie@kernel.org, fweimer@redhat.com, indu.bhagat@oracle.com,
	irogers@google.com, jolsa@kernel.org, jordalgo@meta.com,
	jremus@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-toolchains@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, luto@kernel.org,
	mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org, mingo@kernel.org, namhyung@kernel.org,
	peterz@infradead.org, rostedt@goodmis.org, sam@gentoo.org,
	x86@kernel.org
Subject: Re: [PATCH v4 19/39] unwind_user/sframe: Add support for reading
 .sframe contents
Message-ID: <20250204194250.ihfn2iynpwckzjnn@jpoimboe>
References: <20250124214107.ycccp4gapbdudzux@jpoimboe>
 <20250130195116.3930772-1-wnliu@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250130195116.3930772-1-wnliu@google.com>

On Thu, Jan 30, 2025 at 07:51:15PM +0000, Weinan Liu wrote:
> Nit: swap() might be a simplify way to alternate pointers between two
> fre_addr[] entries.
> 
> For example,
> 
> static __always_inline int __find_fre(struct sframe_section *sec,
> 				      struct sframe_fde *fde, unsigned long ip,
> 				      struct unwind_user_frame *frame)
> {
> 	/* intialize fres[] with invalid value */
> 	struct sframe_fre fres[2] = {0};
> 	struct sframe_fre *fre = &fres[1], *prev_fre = fres;
> 
> 	for (i = 0; i < fde->fres_num; i++) {
> 		swap(fre, next_fre);
> 		ret = __read_fre(sec, fde, fre_addr, fre);

Problem is, if it breaks out early here on the first iteration:

> 		if (fre->ip_off > ip_off)
> 			break;
> 	}
> 
> 	if (fre->size == 0)
> 		return -EINVAL;

Then fre isn't valid even though it has a nonzero size.

-- 
Josh
