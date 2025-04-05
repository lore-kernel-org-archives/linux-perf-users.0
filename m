Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610431C861B
	for <linux-perf-users@vger.kernel.org>; Sat,  5 Apr 2025 09:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743844159; cv=none; b=mC/2WNSbikFN3aozNOw7x13bbGocWjoYOZC8vOv9lDw2kY53FjlAN+rEWTMJT3tkgDgZzR1hGTH35mvzDmdE821v8AIn1q5Ysl7YqmiLJh3I6CckNFmy8AHIt+dMKDt4ZtBaC9qZXKtj8c44Ug//mSDkSxaRXnbnL0QKKltkywc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743844159; c=relaxed/simple;
	bh=66wOPe74rz+L1Xo7Bafp7JOqwumWIDJZJson22EEZFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ek3MDKLQCgMcJiOEgML4NbqDBEMDuXitrpCd2A+hq9CZmJbmndS3/nsUZus8Ctppp4sHfkJnNYlw+22HVEHuY61LYL2roZqZQCLJbg4ufJ5TDsCUJ10Gf8Xi5J32utLffHzdcYDZR/FH0TaLt0Qnaeg2GPobvbUi7mvedeag/GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qoCN1tEZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qoCN1tEZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BCCFC4CEE4;
	Sat,  5 Apr 2025 09:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743844157;
	bh=66wOPe74rz+L1Xo7Bafp7JOqwumWIDJZJson22EEZFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qoCN1tEZq0hBkelaIXiwOOrkacEDNp/3q268HgCqcdmgEh8swdWwJd9hkXXhmNm40
	 4Vhv7RQcgtZ2LQzC7X3C56HFdr9cB1NUxOjjjjRoCmNJA0pKpRvIyWN9rzATopEgZu
	 JmPdhrzPJv5u+pv5ToF+TWbuBAxRE6IPU8PwUwB45jsN3kPLUsTYhYzuwQmDJvwz+u
	 DfyHAc+wLlEX/68rA+lJQNTIMPHP251y8YuPbbRrOQGjX1wqCKQwTW6jhGjQbi0d6z
	 VSZ8ahy/Q3RPWdhnFFoSAzN2Pr8tVAlwZNPEODd6rbNxFj98uKwlvjTPI5HsvTWrAy
	 LLJlmhwr2xjnQ==
Date: Sat, 5 Apr 2025 11:09:12 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [perf top] annotation doesn't work, libunwind doesn't seem to be
 working either
Message-ID: <Z_DzOPrOdRKn4o1i@gmail.com>
References: <20250307080829.354947-1-namhyung@kernel.org>
 <Z9tjKcKvjYgbR6hb@google.com>
 <Z9vgt1pjiNbDBDbM@gmail.com>
 <Z9w_aFlzOkoCTSqK@google.com>
 <Z-EJnye74la1triY@gmail.com>
 <Z--pWmTHGb62_83e@gmail.com>
 <Z_AWpgne5108xqlc@google.com>
 <Z_DyquBrleEGyiE3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_DyquBrleEGyiE3@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> > You need to pass LIBUNWIND=1 to build with it.
> 
> So, users (including me) have absolutely no idea which unwinding 
> library they want to build with: 99% of them would like to have a 
> clean, full-featured perf build with all libraries marked as '[ on ]' 
> in the build log. :-)

Correction: users would like to use the *best* unwinding library, and 
it would be great if the build process picked that for them, or at 
least warned them if that ideal state wasn't possible due to missing 
dependencies.

Thanks,

	Ingo
